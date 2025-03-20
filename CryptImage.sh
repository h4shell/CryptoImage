#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Nessun parametro specificato."
  echo "inserire il segreto: "
  read secret
  echo "inserire la password: "
  read pwd
  echo "inserisci il file di immagine: "
  read imgfile
  enc=$(echo $secret | gpg --symmetric --cipher-algo AES256 --batch --passphrase $pwd --armor | base64 -w 0)
  if [ -z $imgfile ]; then
    echo $enc
  else
    exiftool -Title=$enc $imgfile
  fi

else
  echo $1 | base64 -d > /tmp/s.gpg && gpg --decrypt /tmp/s.gpg && rm /tmp/s.gpg
fi