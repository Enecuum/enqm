#!/usr/bin/env enqin

ls -la
bla bla

enqin --close-comment -x

ls -la
bla bla bla

enqin --close-comment -x

echo yes1

enqin --lazy-input

echo yes2

echo now error must happen

enqin --close-comment -x

echo message after error


