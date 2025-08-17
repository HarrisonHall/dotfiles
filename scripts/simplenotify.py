#!/usr/bin/env -S uv run --script
# /// script
# dependencies = [
#   "desktop-notifier>=6.1",
#   "pydantic>=2.11",
#   "pyzmq>=27.0",
# ]
# ///
"""
simplenotify.py
===============
Reference notifications by custom id for scripting.

Details:
The program works by binding to a port and receiving all future information by
socketio. If the port is not bound, the instance becomes the server and will run
until there are no more notifications. The script will exit immediately either way
in order to preserve scripting.

Note:
    Action and category are not supported because dunst, the notification daemon I use, doesn't support
    them in this form and I didn't want to test them.
    If the port happens to be used by another project, change it.
"""

import argparse
import asyncio
import enum
import json
import os
import sys
from typing import Dict, Optional

import desktop_notifier
import pydantic
import zmq
import zmq.asyncio

APP_NAME = "SimpleNotify"
SOCKET = "ipc:///tmp/simplenotify"
POLL_TIME = 0.2 * 1000


class Urgency(enum.Enum):
    low = "low"
    normal = "normal"
    critical = "critical"


class Notification(pydantic.BaseModel):
    """Notification wrapper."""

    title: Optional[str] = None
    message: str
    icon: str
    timeout: int = 10
    urgency: Urgency = Urgency.normal
    id: Optional[str] = None

    has_been_shown: bool = False

    def to_notification(self) -> desktop_notifier.common.Notification:
        return desktop_notifier.common.Notification(
            title=self.title,
            message=self.message,
            # icon=self.icon,
            urgency=self.urgency,
            timeout=self.timeout,
            identifier=self.id,
        )

    def parse_info(self, info):
        (
            self.summary,
            self.message,
            self.icon,
            self.timeout,
            self.reset,
            self.action,
            self.urgency,
            self.category,
            self.debug,
            self.id,
        ) = info
        self.timeout = int(self.timeout)
        if "true" in self.reset.lower():
            self.reset = True
        else:
            self.reset = False
        if self.debug:
            print(str(self))

    def empty(self) -> bool:
        return self.summary == "" and self.message == "" and self.icon == ""


class Server:
    """Server/client comms for simplenotify."""

    def __init__(self):
        self.context = zmq.asyncio.Context()
        self.local: bool
        self.socket = self.context.socket(zmq.REQ)
        try:
            self.socket.bind(SOCKET)
            self.local = True
        except Exception as e:
            print(e)
            self.socket.connect(SOCKET)
            self.local = False

    async def receive_notification(self) -> Optional[Notification]:
        if await self.socket.poll(timeout=POLL_TIME) == 0:
            return None
        info: str = await self.socket.recv().decode()
        try:
            notification = Notification(**json.loads(info))
            return notification
        except Exception as e:
            print(e)
            return None

    async def send_notification(self, notification: Notification) -> bool:
        try:
            await self.socket.send(str(notification).encode())
            return True
        except Exception as e:
            print(e)
            return False

    async def loop(self, n: Notification):
        notifier = desktop_notifier.main.DesktopNotifier(app_name=APP_NAME)
        notifications: Dict[str, Notification] = {}
        notifications[n.id] = n
        print("Sending")
        id: str = await notifier.send_notification(n.to_notification())
        print("Sent")
        # while len(notifications) > 0:
        #     context = zmq.Context()
        #     socket = context.socket(zmq.REP)
        #     socket.bind(SOCKET)
        #     to_pop = []
        #     for nid in notifications.keys():
        #         if (
        #             time.time() - notifications[nid]["notification"].start_time
        #             > notifications[nid]["notification"].timeout
        #         ):
        #             to_pop.append(nid)
        #     for p in to_pop:
        #         notifications.pop(p)
        #     notifications = self.receive_data(socket, notifications)
        #     del socket
        #     del context


def parse_args() -> dict:
    parser = argparse.ArgumentParser(description="A simple notification system.")
    parser.add_argument("message", action="store", default="", help="Notification contents.")
    parser.add_argument("-t", "--title", action="store", default="", help="Notification title.")
    parser.add_argument("-i", "--icon", action="store", default="", help="Notification icon.")
    parser.add_argument(
        "--timeout", action="store", default=10, type=int, help="Notification timeout."
    )
    parser.add_argument("-r", "--reset", action="store_true", default=False, help="Reset timeout.")
    parser.add_argument(
        "-u",
        "--urgency",
        action="store",
        default="normal",
        help="Notification urgency (low, normal, critical).",
    )
    parser.add_argument("--id", action="store", default="", help="Scripting id.")

    parser.add_argument(
        "-D",
        "-d",
        "--debug",
        "-V",
        "-v",
        "--verbose",
        action="store_true",
        default=False,
        help="Debug/Verbose printing",
    )
    args = parser.parse_args()
    return vars(args)


if __name__ == "__main__":
    notification = Notification(**parse_args())
    server = Server()
    if server.local:
        # pid = os.fork()
        pid = 1
        if pid != 0:
            print("hellow")
            sys.exit(asyncio.run(server.loop(notification)))
    else:
        sys.exit(asyncio.run(server.send_notification(notification)))
