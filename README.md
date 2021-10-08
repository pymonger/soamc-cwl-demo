# SOAMC CWL demo

## Prerequisites

1. Clone repo:
   ```
   git clone https://github.com/pymonger/soamc-cwl-demo.git
   cd soamc-cwl-demo
   ```
1. Create virtualenv:
   ```
   virtualenv env
   source env/bin/activate
   ```
1. Install `cwl-runner` and `cwltool`:
   ```
   pip install cwltool cwl-runner
   ```

## Run stage-in example

1. Change to `baseline-pge` directory:
   ```
   cd baseline-pge
   ```
1. Run cwl-runner:
   ```
   cwl-runner stage-in.cwl stage-in-job.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/gmanipon/dev/azure/cwl_tutorial/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'stage-in.cwl' to 'file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stage-in.cwl'
   INFO [job stage-in.cwl] /private/tmp/docker_tmpag6dga47$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpag6dga47,target=/OQWxDM \
       --mount=type=bind,source=/private/tmp/docker_tmpbb54xxdi,target=/tmp \
       --workdir=/OQWxDM \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpfbfjgz7_/20211007172154-707101.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/OQWxDM \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpag6dga47/stdout_stage-in.txt 2> /private/tmp/docker_tmpag6dga47/stderr_stage-in.txt
   INFO [job stage-in.cwl] Max memory used: 45MiB
   INFO [job stage-in.cwl] completed success
   {   
       "localized_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF",
           "basename": "LC80101172015002LGN00_BQA.TIF",
           "class": "File",
           "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
           "size": 2861879,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF"
       },
       "stderr_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$0223f85f3418bf15db0d4b1d059322b0a5826068",
           "size": 554,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt"
       },
       "stdout_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt",
           "basename": "stdout_stage-in.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt"
       }
   }
   INFO Final process status is success
   ```

## Run PGE example

1. Change to `baseline-pge` directory:
   ```
   cd baseline-pge
   ```
1. Ensure that the `LC80101172015002LGN00_BQA.TIF` file exists there. If not, run the `stage-in` example above.
1. Run cwl-runner:
   ```
   cwl-runner --no-match-user --no-read-only run-pge.cwl run-pge-job.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/gmanipon/dev/azure/cwl_tutorial/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'run-pge.cwl' to 'file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/run-pge.cwl'
   INFO [job run-pge.cwl] /private/tmp/docker_tmp6sqzkomy$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp6sqzkomy,target=/gZSlkl \
       --mount=type=bind,source=/private/tmp/docker_tmpik3exlhk,target=/tmp \
       --mount=type=bind,source=/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF,target=/gZSlkl/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/gZSlkl \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpa09ln010/20211007172717-055820.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/gZSlkl \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /gZSlkl/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmp6sqzkomy/stdout_run-pge.txt 2> /private/tmp/docker_tmp6sqzkomy/stderr_run-pge.txt
   INFO [job run-pge.cwl] Max memory used: 9951MiB
   INFO [job run-pge.cwl] completed success
   {
       "dataset_dir": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000",
           "basename": "dumby-product-20210622191038567000",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json",
                   "basename": "dumby-product-20210622191038567000.met.json",
                   "checksum": "sha1$01f65847089e5cfdab463ebe5b196d4bf33d701b",
                   "size": 186,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF",
                   "basename": "LC80101172015002LGN00_BQA.TIF",
                   "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
                   "size": 2861879,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json",
                   "basename": "dumby-product-20210622191038567000.dataset.json",
                   "checksum": "sha1$bf21a9e8fbc5a3846fb05b4fa0859e0917b2202f",
                   "size": 2,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png",
                   "basename": "dumby-product-20210622191038567000.browse.png",
                   "checksum": "sha1$33a7daa110dd3cf9b330d1556b20592b59bb57f7",
                   "size": 2477207,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$65a7b27d4cb0bbda25e1a947a900d274e57b1cd9",
                   "size": 80019,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png"
               }
           ],
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000"
       },
       "stderr_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt",
           "basename": "stderr_run-pge.txt",
           "class": "File",
           "checksum": "sha1$f7f8c8c185ce9b18d9cbeeb1a00b9f9717614e7a",
           "size": 85279170,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt"
       },
       "stdout_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt",
           "basename": "stdout_run-pge.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt"
       }
   }
   INFO Final process status is success
   ```

## Run 2-step workflow (stage-in & run-pge) example

1. Change to `baseline-pge` directory:
   ```
   cd baseline-pge
   ```
1. Run cwl-runner:
   ```
   cwl-runner --no-match-user --no-read-only baseline-pge-workflow.cwl baseline-pge-workflow-job.yml
   ```

   Output should look similar to this:

   ```
   INFO /Users/gmanipon/dev/azure/cwl_tutorial/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'baseline-pge-workflow.cwl' to 'file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/baseline-pge-workflow.cwl'
   INFO [workflow ] start
   INFO [workflow ] starting step stage-in
   INFO [step stage-in] start
   INFO [job stage-in] /private/tmp/docker_tmpxpt9pqw6$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpxpt9pqw6,target=/UcVukO \
       --mount=type=bind,source=/private/tmp/docker_tmp2fxx2izp,target=/tmp \
       --workdir=/UcVukO \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpy1dvannp/20211007173714-289629.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/UcVukO \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpxpt9pqw6/stdout_stage-in.txt 2> /private/tmp/docker_tmpxpt9pqw6/stderr_stage-in.txt
   INFO [job stage-in] Max memory used: 45MiB
   INFO [job stage-in] completed success
   INFO [step stage-in] completed success
   INFO [workflow ] starting step run-pge
   INFO [step run-pge] start
   INFO [job run-pge] /private/tmp/docker_tmp1y86xkoq$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp1y86xkoq,target=/UcVukO \
       --mount=type=bind,source=/private/tmp/docker_tmpprjveadm,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpxpt9pqw6/LC80101172015002LGN00_BQA.TIF,target=/UcVukO/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/UcVukO \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpiahcua1f/20211007173718-894041.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/UcVukO \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /UcVukO/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmp1y86xkoq/stdout_run-pge.txt 2> /private/tmp/docker_tmp1y86xkoq/stderr_run-pge.txt
   INFO [job run-pge] Max memory used: 9800MiB
   INFO [job run-pge] completed success
   INFO [step run-pge] completed success
   INFO [workflow ] completed success
   {
       "final_dataset_dir": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000",
           "basename": "dumby-product-20210622191038567000",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json",
                   "basename": "dumby-product-20210622191038567000.met.json",
                   "checksum": "sha1$7148463a6e598efab4ffd75337686527c3a50d1a",
                   "size": 186,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF",
                   "basename": "LC80101172015002LGN00_BQA.TIF",
                   "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
                   "size": 2861879,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json",
                   "basename": "dumby-product-20210622191038567000.dataset.json",
                   "checksum": "sha1$bf21a9e8fbc5a3846fb05b4fa0859e0917b2202f",
                   "size": 2,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png",
                   "basename": "dumby-product-20210622191038567000.browse.png",
                   "checksum": "sha1$50d824825da84c0dc23e14fd6060c68929d580e5",
                   "size": 2477207,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$620f6b4d80c6915939a2e26124ef9de78cd3e1c1",
                   "size": 80019,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png"
               }
           ],
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000"
       },
       "stderr_run-pge": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt",
           "basename": "stderr_run-pge.txt",
           "class": "File",
           "checksum": "sha1$1d91e26eb6d2e71635a08c962d53e52a292c0041",
           "size": 91466132,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt"
       },
       "stderr_stage-in": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$ef9b76e2897e0388b11059f1b3496b4290fb5a5b",
           "size": 633,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt"
       },
       "stdout_run-pge": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt",
           "basename": "stdout_run-pge.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt"
       },
       "stdout_stage-in": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt",
           "basename": "stdout_stage-in.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt"
       }
   }
   INFO Final process status is success
   ```
