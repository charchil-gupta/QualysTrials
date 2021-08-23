# Qualys IaC GitHub Action 

# Usage
    name: Qualys IAC Scan 
    on:
      push:
         branches:
       - main
    pull_request:
         branches: [ main ] 
     schedule:
      - cron:  '*/5 * * * *'
    
    
    jobs:
        iac_scan:
            runs-on: ubuntu-latest
            name: IaC Scan Connector
            steps:
              - name: Checkout
                uses: actions/checkout@v2 
                with:
                    fetch-depth: 0
        
              - name: IAC scan action step
                uses: Qualys/QualysTrials@main
                id: iac
                env:
                    URL: ${{ secrets.URL }}
                    UNAME: ${{ secrets.USERNAME }}
                    PASS: ${{ secrets.PASSWORD }}
                with:
                  directory: 'input'