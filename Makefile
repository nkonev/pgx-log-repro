TEST_TIMEOUT := 360s

.PHONY: test-verbose
test-verbose:
	# here is timeout for all the tests
	go test ./... -count=1 -test.v -test.timeout=$(TEST_TIMEOUT) -p 1

.PHONY: infra
infra: infra_up

.PHONY: infra_up
infra_up:
	docker compose up -d
	./scripts/wait-for-it.sh -t 30 127.0.0.1:35444 -- echo 'postgresql is up'
	./scripts/wait-for-it.sh -t 30 127.0.0.1:46686 -- echo 'jaeger web ui is up'

.PHONY: infra_down
infra_down:
	docker compose down -v

run: infra package-go
	./$(EXECUTABLE) serve --cqrs.testhelpermethods=true

.PHONY: test
test:
	# here is timeout for all the tests
	go test ./... -count=1 -test.v -test.timeout=$(TEST_TIMEOUT) -p 1
