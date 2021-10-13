# SOAMC CWL demo

## Prerequisites

1. Clone repo:
   ```
   cd /tmp
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
   INFO /private/tmp/soamc-cwl-demo/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'stage-in.cwl' to 'file:///private/tmp/soamc-cwl-demo/baseline-pge/stage-in.cwl'
   INFO [job stage-in.cwl] /private/tmp/docker_tmpw24o8sn7$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpw24o8sn7,target=/CdvYQv \
       --mount=type=bind,source=/private/tmp/docker_tmp3br6aq3q,target=/tmp \
       --workdir=/CdvYQv \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpm7s6fyel/20211013112035-882333.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CdvYQv \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpw24o8sn7/stdout_stage-in.txt 2> /private/tmp/docker_tmpw24o8sn7/stderr_stage-in.txt
   INFO [job stage-in.cwl] Max memory used: 29MiB
   INFO [job stage-in.cwl] completed success
   {
       "localized_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF",
           "basename": "LC80101172015002LGN00_BQA.TIF",
           "class": "File",
           "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
           "size": 2861879,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF"
       },
       "stderr_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$4bafbbce27f4008c294125b0bb85088a9db071ea",
           "size": 475,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt"
       },
       "stdout_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt",
           "basename": "stdout_stage-in.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt"
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
   INFO /private/tmp/soamc-cwl-demo/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'run-pge.cwl' to 'file:///private/tmp/soamc-cwl-demo/baseline-pge/run-pge.cwl'
   INFO [job run-pge.cwl] /private/tmp/docker_tmpm980jn4y$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpm980jn4y,target=/HqZEZA \
       --mount=type=bind,source=/private/tmp/docker_tmpnxx13llx,target=/tmp \
       --mount=type=bind,source=/private/tmp/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF,target=/HqZEZA/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/HqZEZA \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpr2b724l7/20211013112151-243100.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/HqZEZA \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /HqZEZA/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpm980jn4y/stdout_run-pge.txt 2> /private/tmp/docker_tmpm980jn4y/stderr_run-pge.txt
   INFO [job run-pge.cwl] Max memory used: 10836MiB
   INFO [job run-pge.cwl] completed success
   {
       "dataset_dir": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000",
           "basename": "dumby-product-20210622191038567000",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json",
                   "basename": "dumby-product-20210622191038567000.met.json",
                   "checksum": "sha1$246d5220f788052517503f449c36327a2af84599",
                   "size": 186,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF",
                   "basename": "LC80101172015002LGN00_BQA.TIF",
                   "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
                   "size": 2861879,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json",
                   "basename": "dumby-product-20210622191038567000.dataset.json",
                   "checksum": "sha1$bf21a9e8fbc5a3846fb05b4fa0859e0917b2202f",
                   "size": 2,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png",
                   "basename": "dumby-product-20210622191038567000.browse.png",
                   "checksum": "sha1$e1cc7b0015673131c184b39773b6fa2f217d3297",
                   "size": 2477207,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$c6123694cd279598b606600137fee3f236578a1f",
                   "size": 80019,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png"
               }
           ],
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000"
       },
       "stderr_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt",
           "basename": "stderr_run-pge.txt",
           "class": "File",
           "checksum": "sha1$1558d086b1c405f3d9d823748f084f2ea603acea",
           "size": 49989988,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt"
       },
       "stdout_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt",
           "basename": "stdout_run-pge.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `dumby-product-20210622191038567000` dataset directory was created:
   ```
   ls -ltr dumby-product-20210622191038567000/
   ```

   Output should look similar to this:
   ``` 
   total 12040
   -rw-r--r--  1 gmanipon  wheel  2861879 Oct 13 11:22 LC80101172015002LGN00_BQA.TIF
   -rw-r--r--  1 gmanipon  wheel        2 Oct 13 11:22 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  wheel      186 Oct 13 11:22 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  wheel  2477207 Oct 13 11:22 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  wheel    80019 Oct 13 11:22 dumby-product-20210622191038567000.browse_small.png
   ```

## Run stage-out example

Building off of the previous run-pge example:
1. Change to `baseline-pge` directory if not already in there:
   ```
   cd baseline-pge
   ```
1. Ensure that the `dumby-product-20210622191038567000` dataset directory exists there. 
   If not, run the `run-pge` example above.
1. Copy the `stage-out-job.yml.tmpl` file to `stage-out-job.yml`:
   ```
   cp stage-out-job.yml.tmpl stage-out-job.yml
   ```

   then edit `stage-out-job.yml`:
   ```
   vi stage-out-job.yml
   ```

   and insert the values for:
   - `aws_access_key_id`
   - `aws_secret_access_key`
   - `aws_session_token`

   These values can be copied from your valid `$HOME/.aws/credentials` file.
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
   ```
   cwl-runner stage-out.cwl stage-out-job.yml 
   ```

   Output should look similar to this:

   ```
   INFO /private/tmp/soamc-cwl-demo/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'stage-out.cwl' to 'file:///private/tmp/soamc-cwl-demo/baseline-pge/stage-out.cwl'
   INFO stage-out.cwl:1:1: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO [job stage-out.cwl] /private/tmp/docker_tmpcdvi5w2n$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpcdvi5w2n,target=/VAEwUP \
       --mount=type=bind,source=/private/tmp/docker_tmpn5lxawn3,target=/tmp \
       --mount=type=bind,source=/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000,target=/var/lib/cwl/stg314eda98-c5a9-4f9b-8250-0d9353df7f4f/dumby-product-20210622191038567000,readonly \
       --workdir=/VAEwUP \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpyswmeaq8/20211013113022-379989.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/VAEwUP \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg314eda98-c5a9-4f9b-8250-0d9353df7f4f/dumby-product-20210622191038567000 s3://nisar-dev/test' > /private/tmp/docker_tmpcdvi5w2n/stdout_stage-out.txt 2> /private/tmp/docker_tmpcdvi5w2n/stderr_stage-out.txt
   INFO [job stage-out.cwl] Max memory used: 897MiB
   INFO [job stage-out.cwl] completed success
   {
       "stderr_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt",
           "basename": "stderr_stage-out.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt"
       },
       "stdout_file": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt",
           "basename": "stdout_stage-out.txt",
           "class": "File",
           "checksum": "sha1$238138c2124c8ff1573f2cd63539b6dc1c5f43d5",
           "size": 2883,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt"
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
   2021-10-13 11:30:25    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 11:30:25    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 11:30:25      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 11:30:25          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 11:30:25        186 dumby-product-20210622191038567000.met.json
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
1. Copy the `baseline-pge-workflow-job.yml.tmpl` file to `baseline-pge-workflow-job.yml`:
   ```
   cp baseline-pge-workflow-job.yml.tmpl baseline-pge-workflow-job.yml
   ```

   then edit `baseline-pge-workflow-job.yml`:
   ```
   vi baseline-pge-workflow-job.yml
   ```

   and insert the values for:
   1. `workflow_aws_access_key_id`
   1. `workflow_aws_secret_access_key`
   1. `workflow_aws_session_token`

   These values can be copied from your valid `$HOME/.aws/credentials` file.
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
   ```
   cwl-runner --no-match-user --no-read-only baseline-pge-workflow.cwl baseline-pge-workflow-job.yml
   ```

   Output should look similar to this:

   ```
   INFO /private/tmp/soamc-cwl-demo/env/bin/cwl-runner 3.1.20211004060744
   INFO Resolved 'baseline-pge-workflow.cwl' to 'file:///private/tmp/soamc-cwl-demo/baseline-pge/baseline-pge-workflow.cwl'
   INFO baseline-pge-workflow.cwl:1:1: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO stage-out.cwl:1:1: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO [workflow ] start
   INFO [workflow ] starting step stage-in
   INFO [step stage-in] start
   INFO [job stage-in] /private/tmp/docker_tmpaiu05iwc$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpaiu05iwc,target=/CfDTKw \
       --mount=type=bind,source=/private/tmp/docker_tmpl83otpw1,target=/tmp \
       --workdir=/CfDTKw \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpr2bzm68c/20211013113438-398777.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CfDTKw \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpaiu05iwc/stdout_stage-in.txt 2> /private/tmp/docker_tmpaiu05iwc/stderr_stage-in.txt
   INFO [job stage-in] Max memory used: 36MiB
   INFO [job stage-in] completed success
   INFO [step stage-in] completed success
   INFO [workflow ] starting step run-pge
   INFO [step run-pge] start
   INFO [job run-pge] /private/tmp/docker_tmp8w9zo_4d$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp8w9zo_4d,target=/CfDTKw \
       --mount=type=bind,source=/private/tmp/docker_tmp5hofw8pm,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpaiu05iwc/LC80101172015002LGN00_BQA.TIF,target=/CfDTKw/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/CfDTKw \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmp4pgjke0z/20211013113440-733485.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CfDTKw \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /CfDTKw/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmp8w9zo_4d/stdout_run-pge.txt 2> /private/tmp/docker_tmp8w9zo_4d/stderr_run-pge.txt
   INFO [job run-pge] Max memory used: 8241MiB
   INFO [job run-pge] completed success
   INFO [step run-pge] completed success
   INFO [workflow ] starting step stage-out
   INFO [step stage-out] start
   INFO [job stage-out] /private/tmp/docker_tmp72_qv_03$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp72_qv_03,target=/CfDTKw \
       --mount=type=bind,source=/private/tmp/docker_tmpk7c4t_ee,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmp8w9zo_4d/dumby-product-20210622191038567000,target=/var/lib/cwl/stg270668ef-14e0-4060-a461-d3885d4e0e13/dumby-product-20210622191038567000,readonly \
       --workdir=/CfDTKw \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpqidfjgvb/20211013113529-414539.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CfDTKw \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg270668ef-14e0-4060-a461-d3885d4e0e13/dumby-product-20210622191038567000 s3://nisar-dev/test' > /private/tmp/docker_tmp72_qv_03/stdout_stage-out.txt 2> /private/tmp/docker_tmp72_qv_03/stderr_stage-out.txt
   INFO [job stage-out] Max memory used: 812MiB
   INFO [job stage-out] completed success
   INFO [step stage-out] completed success
   INFO [workflow ] completed success
   {
       "final_dataset_dir": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000",
           "basename": "dumby-product-20210622191038567000",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json",
                   "basename": "dumby-product-20210622191038567000.met.json",
                   "checksum": "sha1$b149505ff1e02781d1e4d6500587156f52620b29",
                   "size": 186,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF",
                   "basename": "LC80101172015002LGN00_BQA.TIF",
                   "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
                   "size": 2861879,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json",
                   "basename": "dumby-product-20210622191038567000.dataset.json",
                   "checksum": "sha1$bf21a9e8fbc5a3846fb05b4fa0859e0917b2202f",
                   "size": 2,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png",
                   "basename": "dumby-product-20210622191038567000.browse.png",
                   "checksum": "sha1$0dbe1bb1278f0e04293684ef2fa75819d9569fed",
                   "size": 2477207,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$cabcd91334b9995f5b880899e5e723a3d7b300dd",
                   "size": 80019,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png"
               }
           ],
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000"
       },
       "stderr_run-pge": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt",
           "basename": "stderr_run-pge.txt",
           "class": "File",
           "checksum": "sha1$c28c577bfdcc5618500a03e937c97a1fffd59a89",
           "size": 57332924,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt"
       },
       "stderr_stage-in": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$436757093c81e6a128ebcbb440b085d62cb8b390",
           "size": 396,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt"
       },
       "stderr_stage-out": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt",
           "basename": "stderr_stage-out.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-out.txt"
       },
       "stdout_run-pge": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt",
           "basename": "stdout_run-pge.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_run-pge.txt"
       },
       "stdout_stage-in": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt",
           "basename": "stdout_stage-in.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-in.txt"
       },
       "stdout_stage-out": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt",
           "basename": "stdout_stage-out.txt",
           "class": "File",
           "checksum": "sha1$07a7e4495c5a4ff244648bce275ad00f3d54dec0",
           "size": 2885,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the`dumby-product-20210622191038567000` dataset directory exists locally:
   ```
   ls -ltr dumby-product-20210622191038567000/
   ```

   Output should look similar to this:
   ```
   total 12040
   -rw-r--r--  1 gmanipon  wheel  2861879 Oct 13 11:35 LC80101172015002LGN00_BQA.TIF
   -rw-r--r--  1 gmanipon  wheel        2 Oct 13 11:35 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  wheel      186 Oct 13 11:35 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  wheel  2477207 Oct 13 11:35 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  wheel    80019 Oct 13 11:35 dumby-product-20210622191038567000.browse_small.png
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep base_dataset_url stage-out-job.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2021-10-13 11:35:32    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 11:35:32    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 11:35:32      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 11:35:32          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 11:35:32        186 dumby-product-20210622191038567000.met.json
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
