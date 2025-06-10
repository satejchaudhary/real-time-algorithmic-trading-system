from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict

# when running this file, ensure that it is run from the root of the project
# Else the env_file part will not work correctly and it will fail to load the settings


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file="services/trades/settings.env", env_file_encoding="utf-8"
    )

    product_ids: list[str] = [
        "ETH/EUR",
        "BTC/USD",
        "BTC/EUR",
        "ETH/USD",
        "SOL/USD",
        "SOL/EUR",
        "XRP/USD",
        "XRP/EUR",
    ]
    kafka_broker_address: str
    kafka_topic_name: str
    live_or_historical: Literal["live", "historical"] = "live"
    last_n_days: int = 30


config = Settings()

# To debug this file, simply run from the root of the project:
# $uv run services/trades/src/trades/config.py

print(config.model_dump())  # This will print the settings loaded from the env file
