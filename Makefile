CONFIG=./config/live_gdax.cfg

runconfig:  ## clean and make target, run target
	python3 -m algocoin --config=$(CONFIG)

run:  ## clean and make target, run target
	python3 -m algocoin --live --verbose=$(VERBOSE) --exchange=$(EXCHANGE)

sandbox:  ## clean and make target, run target
	python3 -m algocoin --sandbox --verbose=$(VERBOSE) -exchange=$(EXCHANGE)

fetch_data: ## fetch data
	. scripts/fetchdata.sh --exchange=$(EXCHANGE) --currency=$(CURRENCY)

backtest: ## clean and make target, run backtest
	python3 -m algocoin --backtest --verbose=$(VERBOSE) --exchange=$(EXCHANGE)

backtest_inline:  ## clean and make target, run backtest, plot in terminal
	bash -c "export MPLBACKEND=\"module://itermplot\";	export ITERMPLOT=\"rv\"; python3 -m algocoin backtest $(VERBOSE) $(EXCHANGE)"

tests: ## Clean and Make unit tests
	python3 -m nose -v algocoin/tests --with-coverage --cover-erase --cover-package=`find algocoin -name "*.py" | sed "s=\./==g" | sed "s=/=.=g" | sed "s/.py//g" | tr '\n' ',' | rev | cut -c2- | rev`

test: ## run the tests for travis CI
	@ python3 -m nose -v algocoin/tests --with-coverage --cover-erase --cover-package=`find algocoin -name "*.py" | sed "s=\./==g" | sed "s=/=.=g" | sed "s/.py//g" | tr '\n' ',' | rev | cut -c2- | rev`
 
test_verbose: ## run the tests with full output
	python3 -m nose -vv -s algocoin/tests --with-coverage --cover-erase --cover-package=`find algocoin -name "*.py" | sed "s=\./==g" | sed "s=/=.=g" | sed "s/.py//g" | tr '\n' ',' | rev | cut -c2- | rev`

annotate: ## MyPy type annotation check
	mypy -s algocoin 

annotate_l: ## MyPy type annotation check - count only
	mypy -s algocoin | wc -l 

clean: ## clean the repository
	find -name "*.pyc" -exec rm -rf {} \;
	find -name "__pycache__" -exec rm -rf {} \;
	rm -rf .coverage cover htmlcov logs

# Thanks to Francoise at marmelab.com for this
.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

print-%:
	@echo '$*=$($*)'

.PHONY: clean run sandbox backtest test tests test_verbose help
