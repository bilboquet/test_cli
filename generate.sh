pushd .
cd ../massa-sc-toolkit/packages/massa-proto-cli/ && npm run build
popd
npx massa-proto --addr=AS1q88jh5NRbgsof8Ln2oBeU2oQ2wEirqSiCvkkZjJP4PejNZXtn --gen=sc