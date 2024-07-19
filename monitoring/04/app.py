import sentry_sdk

sentry_sdk.init(
    dsn="http://af5dc74ce140c516824aef933649f5c3@192.168.56.11:9000/2",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    traces_sample_rate=1.0,
)