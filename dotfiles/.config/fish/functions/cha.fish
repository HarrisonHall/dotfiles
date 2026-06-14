function cha --wraps=cha --description 'Wrapped cha'
    set real_cha (which cha)
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt $real_cha $argv

end
