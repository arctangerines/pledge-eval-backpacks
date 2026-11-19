#!/bin/bash
set -e 
set -o pipefail

makeflow --jx ./star_gatk.jx -T vine --project-name "${VINE_MANAGER_NAME}"
