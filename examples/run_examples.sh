#!/usr/bin/env bash
set -eu

cd $(dirname "$0")

julia pizza.jl
