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
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
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
1. Verify that the `LC80101172015002LGN00_BQA.TIF` was staged in the directory:
   ```
   ls -l LC80101172015002LGN00_BQA.TIF
   ```

## Run PGE example

Building off of the previous stage-in example:
1. Change to `baseline-pge` directory if not already in there:
   ```
   cd baseline-pge
   ```
1. Ensure that the `LC80101172015002LGN00_BQA.TIF` file exists there. If not, run the `stage-in` example above.
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
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
1. Verify that the `dumby-product-20210622191038567000` dataset directory was created:
   ```
   ls -ltr dumby-product-20210622191038567000/
   total 12040
   -rw-r--r--  1 gmanipon  wheel  2861879 Oct  7 17:38 LC80101172015002LGN00_BQA.TIF
   -rw-r--r--  1 gmanipon  wheel        2 Oct  7 17:38 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  wheel      186 Oct  7 17:38 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  wheel  2477207 Oct  7 17:38 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  wheel    80019 Oct  7 17:38 dumby-product-20210622191038567000.browse_small.png
   ```

## Run stage-out example

Building off of the previous run-pge example:
1. Change to `baseline-pge` directory if not already in there:
   ```
   cd baseline-pge
   ```
1. Ensure that the `dumby-product-20210622191038567000` dataset directory exists there. 
   If not, run the `run-pge` example above.
1. Edit the `stage-out-job.yml` and replace the value of
   1. `path` under `aws_creds` from `/Users/gmanipon/.aws` to the path of your AWS 
      credentials located in your environment. Don't use environment variables 
      (e.g. `$HOME/.aws`) but actual absolute paths.
   1. `base_dataset_url` from `s3://nisar-dev/test` to the path of some S3 bucket
      under your AWS account.
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
   ```
   cwl-runner stage-out.cwl stage-out-job.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/gmanipon/dev/soamc-cwl-demo/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'stage-out.cwl' to 'file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stage-out.cwl'
   INFO [job stage-out.cwl] /private/tmp/docker_tmpp7q_a2yz$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpp7q_a2yz,target=/EkRGFX \
       --mount=type=bind,source=/private/tmp/docker_tmp0sdfjri4,target=/tmp \
       --mount=type=bind,source=/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000,target=/var/lib/cwl/stg2acb15a4-511f-4d1d-bc4c-73e89f736555/dumby-product-20210622191038567000,readonly \
       --mount=type=bind,source=/Users/gmanipon/.aws,target=/EkRGFX/.aws,readonly \
       --workdir=/EkRGFX \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpz6ss2lta/20211013085624-979712.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/EkRGFX \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg2acb15a4-511f-4d1d-bc4c-73e89f736555/dumby-product-20210622191038567000 s3://nisar-dev/test' > /private/tmp/docker_tmpp7q_a2yz/stdout_stage-out.txt 2> /private/tmp/docker_tmpp7q_a2yz/stderr_stage-out.txt
   INFO [job stage-out.cwl] Max memory used: 717MiB
   INFO [job stage-out.cwl] completed success
   {
       "stderr_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt",
           "basename": "stderr_stage-out.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt"
       },
       "stdout_file": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt",
           "basename": "stdout_stage-out.txt",
           "class": "File",
           "checksum": "sha1$856a74a159927176f146576a2a95d9a74e777e1d",
           "size": 2873,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the`dumby-product-20210622191038567000` dataset directory was staged to the 
   S3 bucket location.
   ```
   aws s3 ls $(grep base_dataset_url stage-out-job.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2021-10-13 08:56:27    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 08:56:27    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 08:56:27      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 08:56:27          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 08:56:27        186 dumby-product-20210622191038567000.met.json
   ```

## Run 3-step workflow (stage-in, run-pge & stage-out) example

1. Change to `baseline-pge` directory:
   ```
   cd baseline-pge
   ```
1. Clean out any artifacts that were left as a result of running the previous examples:
   ```
   rm -rf LC80101172015002LGN00_BQA.TIF dumby-product-20210622191038567000 *.txt
   ```
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
   ```
   cwl-runner --no-match-user --no-read-only baseline-pge-workflow.cwl baseline-pge-workflow-job.yml
   ```

   Output should look similar to this:

   ```
   INFO /Users/gmanipon/dev/soamc-cwl-demo/env/bin/cwltool 3.1.20211004060744
   INFO Resolved 'baseline-pge-workflow.cwl' to 'file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/baseline-pge-workflow.cwl'
   INFO [workflow ] start
   INFO [workflow ] starting step stage-in
   INFO [step stage-in] start
   INFO [job stage-in] /private/tmp/docker_tmpwuf9teik$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpwuf9teik,target=/YxCGZT \
       --mount=type=bind,source=/private/tmp/docker_tmpyioyegp7,target=/tmp \
       --workdir=/YxCGZT \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmplia39pvh/20211013090620-804504.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/YxCGZT \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpwuf9teik/stdout_stage-in.txt 2> /private/tmp/docker_tmpwuf9teik/stderr_stage-in.txt
   INFO [job stage-in] Max memory used: 0MiB
   INFO [job stage-in] completed success
   INFO [step stage-in] completed success
   INFO [workflow ] starting step run-pge
   INFO [step run-pge] start
   INFO [job run-pge] /private/tmp/docker_tmp2ugbe61w$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp2ugbe61w,target=/YxCGZT \
       --mount=type=bind,source=/private/tmp/docker_tmpqtldf81x,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpwuf9teik/LC80101172015002LGN00_BQA.TIF,target=/YxCGZT/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/YxCGZT \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpidkk8fr6/20211013090622-861094.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/YxCGZT \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /YxCGZT/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmp2ugbe61w/stdout_run-pge.txt 2> /private/tmp/docker_tmp2ugbe61w/stderr_run-pge.txt
   INFO [job run-pge] Max memory used: 8277MiB
   INFO [job run-pge] completed success
   INFO [step run-pge] completed success
   INFO [workflow ] starting step stage-out
   INFO [step stage-out] start
   INFO [job stage-out] /private/tmp/docker_tmpxqw3h2lp$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpxqw3h2lp,target=/YxCGZT \
       --mount=type=bind,source=/private/tmp/docker_tmp6xdsxk_n,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmp2ugbe61w/dumby-product-20210622191038567000,target=/var/lib/cwl/stg3da502a4-ee74-444b-aa91-ce83e4ba88f7/dumby-product-20210622191038567000,readonly \
       --mount=type=bind,source=/Users/gmanipon/.aws,target=/YxCGZT/.aws,readonly \
       --workdir=/YxCGZT \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpiz6x44r2/20211013090718-090763.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/YxCGZT \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg3da502a4-ee74-444b-aa91-ce83e4ba88f7/dumby-product-20210622191038567000 s3://nisar-dev/test' > /private/tmp/docker_tmpxqw3h2lp/stdout_stage-out.txt 2> /private/tmp/docker_tmpxqw3h2lp/stderr_stage-out.txt
   INFO [job stage-out] Max memory used: 792MiB
   INFO [job stage-out] completed success
   INFO [step stage-out] completed success
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
                   "checksum": "sha1$26672db1b9cf92a7f1160ccf14152bfea9e4af95",
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
                   "checksum": "sha1$dd17d0e203208221843fa870e4fc87b6abe7c68f",
                   "size": 2477207,
                   "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$70f5516aeb017d6f47a98f4e6e44c648ac947c43",
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
           "checksum": "sha1$66d68ff2147b7470ad813379385100cd26ef450c",
           "size": 70248488,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt"
       },
       "stderr_stage-in": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$c8c3558ded10587359c3769da95a7d05f8fbec68",
           "size": 396,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt"
       },
       "stderr_stage-out": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt",
           "basename": "stderr_stage-out.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt"
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
       },
       "stdout_stage-out": {
           "location": "file:///Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt",
           "basename": "stdout_stage-out.txt",
           "class": "File",
           "checksum": "sha1$19f8a27892fe995e6129dee6854dabc77ba14996",
           "size": 2883,
           "path": "/Users/gmanipon/dev/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the`dumby-product-20210622191038567000` dataset directory exists locally and was staged to the
   S3 bucket location.

   Output should look similar to this:
   ```
   ls -ltr dumby-product-20210622191038567000/
   total 12040
   -rw-r--r--  1 gmanipon  wheel  2861879 Oct 13 09:07 LC80101172015002LGN00_BQA.TIF
   -rw-r--r--  1 gmanipon  wheel        2 Oct 13 09:07 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  wheel      186 Oct 13 09:07 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  wheel  2477207 Oct 13 09:07 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  wheel    80019 Oct 13 09:07 dumby-product-20210622191038567000.browse_small.png
   
   aws s3 ls $(grep base_dataset_url stage-out-job.yml | awk '{print $2}')/
   2021-10-13 09:07:21    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 09:07:21    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 09:07:21      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 09:07:21          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 09:07:21        186 dumby-product-20210622191038567000.met.json
   ```

## Run 3-step workflow (stage-in, run-pge & stage-out) example on K8s (Kubernetes) via Calrissian

1. Change to `baseline-pge` directory:
   ```
   cd baseline-pge
   ```
1. Create namespace and roles:
   ```
   NAMESPACE_NAME=soamc-cwl-demo
   kubectl create namespace "$NAMESPACE_NAME"
   kubectl --namespace="$NAMESPACE_NAME" create role pod-manager-role \
     --verb=create,patch,delete,list,watch --resource=pods
   kubectl --namespace="$NAMESPACE_NAME" create role log-reader-role \
     --verb=get,list --resource=pods/log
   kubectl --namespace="$NAMESPACE_NAME" create rolebinding pod-manager-default-binding \
     --role=pod-manager-role --serviceaccount=${NAMESPACE_NAME}:default
   kubectl --namespace="$NAMESPACE_NAME" create rolebinding log-reader-default-binding \
     --role=log-reader-role --serviceaccount=${NAMESPACE_NAME}:default
   ```
1. Create secret containing AWS creds:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create secret generic aws-creds --from-file=$HOME/.aws/credentials
   ```
1. Create volumes (this is the equivalent to creating a unique work directory for the workflow execution job):
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f VolumeClaims.yaml
   ```
1. Stage CWL workflow and job parameters YAML to volume:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f StageWorkflowAndJobParams.yaml
   ```
   Monitor execution with:
   ```
   watch kubectl --namespace="$NAMESPACE_NAME" logs -f job/stage-workflow-and-params
   ```
1. Run the workflow:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f CalrissianJob.yaml
   ```
   Monitor execution with:
   ```
   watch kubectl --namespace="$NAMESPACE_NAME" logs -f job/calrissian-job
   ```
   Additionally, note the jobs and pods that were created by Calrissian as a result
   of the workflow submission:
   ```
   watch kubectl --namespace="$NAMESPACE_NAME" get jobs
   watch kubectl --namespace="$NAMESPACE_NAME" get pods
   ```
1. Once the workflow execution is done, you can copy over the STDOUT/STDERR logs and
   output files. In one terminal window run:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f AccessVolumes.yaml
   ```
   In another terminal window:
   ```
   NAMESPACE_NAME=soamc-cwl-demo
   kubectl --namespace="$NAMESPACE_NAME" cp access-pv:/calrissian/output-data output-data
   ```
