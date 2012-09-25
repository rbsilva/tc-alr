#!/bin/sh
# to schedule with cron
rails runner RawFileTransformer.transform
