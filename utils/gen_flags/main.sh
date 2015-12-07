#! /bin/bash

source ./.config

source utils/gen_flags/common.sh

source utils/gen_flags/gen_arch.sh

source utils/gen_flags/$AOSC_EC_ARCH.sh

source utils/gen_flags/output.sh
