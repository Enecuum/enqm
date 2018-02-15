
```

enqin pingPeer 127.0.0.1
enqin -c "startMining | enqout"
enqin -c "startMining | enqout | enqound --after 20min"
enqin -c "getTorPublicControl | startMining | enqtat --dayly --to-email travelbook12345@mymail.com --subject mining | enqout | enqarchive --after 1enq | enqilize --to-email caffe1212@othermail.com"
enqin pvcnHashLoop < /bin/bzip2 | head -n 200

#!/usr/bin/env enqin
for i in 1 2 3 4
do
  miner=myMiner$i
  enqenete $miner --snapshot | enqake --use-running-state
  isPowMining && getConnectedPeers | head -n 2 | pingPeers --limit 10 --max-time 30sec && echo "GoodPing: $miner"
  stat=`enqtat --base64`
  enqout --all
  enqin -c "jsonRpcPipe" <<EOF
    { "method": "pvcnHashLoop", "data", "$stat" }
  EOF
done
exit


#!/usr/bin/env enqin
enqout --id 1 --save-publickeys-to ~/public.txt --save-keypairs-to-folder /mnt/security-disk/private-keys/
flashkey=`createKeyPair | enqout --public-key`
for i in `seq 1 100`
do
  walletkey=`createKeyPair | enqout --keep-in-stack --public-key`
  for j in `seq 1 100`
  do
    createKeyPair --encrypt-everyting-with $flashkey
  done
  enqout --all-pending-public-keys | createWallet --encrypt-everyting-with $walletkey
done
enqout --id 1 --clear
exit


```

