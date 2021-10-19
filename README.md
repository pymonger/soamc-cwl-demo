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
   INFO [job stage-in.cwl] /private/tmp/docker_tmp6vqhma46$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp6vqhma46,target=/aaIZcM \
       --mount=type=bind,source=/private/tmp/docker_tmpz0ckamgd,target=/tmp \
       --workdir=/aaIZcM \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmp23oc8v9t/20211013131310-442260.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/aaIZcM \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmp6vqhma46/stdout_stage-in.txt 2> /private/tmp/docker_tmp6vqhma46/stderr_stage-in.txt
   INFO [job stage-in.cwl] Max memory used: 0MiB
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
           "checksum": "sha1$8607e4962ff795210c5c552cb74c188d9c882d8c",
           "size": 396,
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
   INFO [job run-pge.cwl] /private/tmp/docker_tmpcajcsy0q$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpcajcsy0q,target=/rITdEy \
       --mount=type=bind,source=/private/tmp/docker_tmpetg5af6x,target=/tmp \
       --mount=type=bind,source=/private/tmp/soamc-cwl-demo/baseline-pge/LC80101172015002LGN00_BQA.TIF,target=/rITdEy/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/rITdEy \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpc2z1d4cc/20211013131400-518090.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/rITdEy \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /rITdEy/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpcajcsy0q/stdout_run-pge.txt 2> /private/tmp/docker_tmpcajcsy0q/stderr_run-pge.txt
   INFO [job run-pge.cwl] Max memory used: 12494MiB
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
                   "checksum": "sha1$6cf89f4419ed1738957cf0a2b1205c966bb765e0",
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
                   "checksum": "sha1$f303e9851d474eb79d51d83a4d68d891456dd147",
                   "size": 2477207,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$554c92f17f3a07f4c3205b7ab4f70cad96bc6a39",
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
           "checksum": "sha1$03de58551b0a4b70f78e8b4cf06e338a4802fa86",
           "size": 58329458,
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
   -rw-r--r--  1 gmanipon  wheel  2861879 Oct 13 13:14 LC80101172015002LGN00_BQA.TIF
   -rw-r--r--  1 gmanipon  wheel        2 Oct 13 13:14 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  wheel      186 Oct 13 13:14 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  wheel  2477207 Oct 13 13:14 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  wheel    80019 Oct 13 13:14 dumby-product-20210622191038567000.browse_small.png
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
   INFO [job stage-out.cwl] /private/tmp/docker_tmpeyl3v48v$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpeyl3v48v,target=/AfeosC \
       --mount=type=bind,source=/private/tmp/docker_tmpfth4_rjr,target=/tmp \
       --mount=type=bind,source=/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000,target=/var/lib/cwl/stg3de9dfb8-71ea-4f80-ba8b-afd10683c161/dumby-product-20210622191038567000,readonly \
       --workdir=/AfeosC \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpomtabmhh/20211013131731-527292.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/AfeosC \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg3de9dfb8-71ea-4f80-ba8b-afd10683c161/dumby-product-20210622191038567000 s3://hysds-dataset-bucket-gman-test/test/dumby-product-20210622191038567000' > /private/tmp/docker_tmpeyl3v48v/stdout_stage-out.txt 2> /private/tmp/docker_tmpeyl3v48v/stderr_stage-out.txt
   INFO [job stage-out.cwl] Max memory used: 878MiB
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
           "checksum": "sha1$c4f81f39c21e885345f32c33fcc974f43d2dc80d",
           "size": 3052,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stdout_stage-out.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the`dumby-product-20210622191038567000` dataset directory was staged to the 
   S3 bucket location.
   ```
   aws s3 ls $(grep base_dataset_url stage-out-job.yml | awk '{print $2}')/$(grep path stage-out-job.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2021-10-13 13:17:35    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 13:17:35    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 13:17:35      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 13:17:35          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 13:17:35        186 dumby-product-20210622191038567000.met.json
   ```

## Run 3-step workflow (stage-in, run-pge & stage-out) example
Now that we've seen the individual steps at work, we can proceed with running them in 
a CWL workflow. The following image depicts the graph visualiation (dot) of the 
DAG workflow.

![baseline-pge-workflow](images/baseline-pge-workflow.png?raw=true "baseline-pge-workflow")

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
   INFO [job stage-in] /private/tmp/docker_tmpjry4wess$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpjry4wess,target=/wvFbBT \
       --mount=type=bind,source=/private/tmp/docker_tmp6v8oxmbb,target=/tmp \
       --workdir=/wvFbBT \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpvcjlysne/20211013132131-719009.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/wvFbBT \
       curlimages/curl \
       curl \
       -O \
       https://s3-us-west-2.amazonaws.com/landsat-pds/L8/010/117/LC80101172015002LGN00/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmpjry4wess/stdout_stage-in.txt 2> /private/tmp/docker_tmpjry4wess/stderr_stage-in.txt
   INFO [job stage-in] Max memory used: 32MiB
   INFO [job stage-in] completed success
   INFO [step stage-in] completed success
   INFO [workflow ] starting step run-pge
   INFO [step run-pge] start
   INFO [job run-pge] /private/tmp/docker_tmp20nra5u4$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp20nra5u4,target=/wvFbBT \
       --mount=type=bind,source=/private/tmp/docker_tmpzf0opqrw,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpjry4wess/LC80101172015002LGN00_BQA.TIF,target=/wvFbBT/LC80101172015002LGN00_BQA.TIF,readonly \
       --workdir=/wvFbBT \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmp3q30affl/20211013132133-609403.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/wvFbBT \
       pymonger/baseline-pge:develop \
       /home/ops/verdi/ops/baseline_pge/dumby_landsat_cwl.sh \
       dumby-product-20210622191038567000 \
       30 \
       60 \
       /wvFbBT/LC80101172015002LGN00_BQA.TIF > /private/tmp/docker_tmp20nra5u4/stdout_run-pge.txt 2> /private/tmp/docker_tmp20nra5u4/stderr_run-pge.txt
   INFO [job run-pge] Max memory used: 8185MiB
   INFO [job run-pge] completed success
   INFO [step run-pge] completed success
   INFO [workflow ] starting step stage-out
   INFO [step stage-out] start
   INFO [job stage-out] /private/tmp/docker_tmp30pvnjef$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp30pvnjef,target=/wvFbBT \
       --mount=type=bind,source=/private/tmp/docker_tmpb4_mfuqy,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmp20nra5u4/dumby-product-20210622191038567000,target=/var/lib/cwl/stg0598cbb5-325d-4124-905b-776b4736aafe/dumby-product-20210622191038567000,readonly \
       --workdir=/wvFbBT \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmp_clz9oee/20211013132241-600003.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/wvFbBT \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg0598cbb5-325d-4124-905b-776b4736aafe/dumby-product-20210622191038567000 s3://hysds-dataset-bucket-gman-test/test/dumby-product-20210622191038567000' > /private/tmp/docker_tmp30pvnjef/stdout_stage-out.txt 2> /private/tmp/docker_tmp30pvnjef/stderr_stage-out.txt
   INFO [job stage-out] Max memory used: 881MiB
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
                   "checksum": "sha1$147cb77d6c7eed3031aa6bee2eb1eda9816268c3",
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
                   "checksum": "sha1$ef61dc5bf87c7edf708870389731b2ca7b8c3c9f",
                   "size": 2477207,
                   "path": "/private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$59f812466537bb932a07e8f536cc987bcdbbbe2a",
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
           "checksum": "sha1$91d037de84f8936a5a5ddad9c6f06b751850616d",
           "size": 85051633,
           "path": "/private/tmp/soamc-cwl-demo/baseline-pge/stderr_run-pge.txt"
       },
       "stderr_stage-in": {
           "location": "file:///private/tmp/soamc-cwl-demo/baseline-pge/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$8eb960185b334b9a2fdad356b1f248938037805c",
           "size": 317,
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
           "checksum": "sha1$ed4b0b31b6bde76d86667c0a738def576c49d217",
           "size": 3058,
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
   -rw-r--r--  1 gmanipon  wheel  2861879 Oct 13 13:22 LC80101172015002LGN00_BQA.TIF
   -rw-r--r--  1 gmanipon  wheel        2 Oct 13 13:22 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  wheel      186 Oct 13 13:22 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  wheel  2477207 Oct 13 13:22 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  wheel    80019 Oct 13 13:22 dumby-product-20210622191038567000.browse_small.png
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep workflow_base_dataset_url baseline-pge-workflow-job.yml | awk '{print $2}')/$(grep workflow_product_id baseline-pge-workflow-job.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2021-10-13 13:22:45    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 13:22:45    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 13:22:45      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 13:22:45          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 13:22:45        186 dumby-product-20210622191038567000.met.json
   ```

## Run 3-step workflow (stage-in, run-pge & stage-out) example on K8s (Kubernetes) via Calrissian
Now that we've seen the execution of the workflow on a local machine, it's time to execute the
workflow on a K8s cluster. Once again the following image depicts the graph visualiation (dot) 
of the DAG workflow.

![baseline-pge-workflow](images/baseline-pge-workflow.png?raw=true "baseline-pge-workflow")

In the previous section, we used `cwl-runner` to execute the CWL workflow which proceeded to
spawn 3 containers corresponding to the 3 steps in the workflow. In this example, we submit
a K8s job to run Calrissian, a CWL-compliant implementation that supports execution of
workflows and their composite steps as K8s jobs.

1. Change to `baseline-pge` directory:
   ```
   cd baseline-pge
   ```
1. Clean out any artifacts that were left as a result of running the previous examples:
   ```
   rm -rf LC80101172015002LGN00_BQA.TIF dumby-product-20210622191038567000 *.txt
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
1. Create secret containing AWS creds. Set the following env variables manually:
   ```
   export aws_access_key_id="<your AWS access key ID>"
   export aws_secret_access_key="<your AWS secret access key>"
   ```

   Then write them to a K8s secret: 
   ```
   kubectl --namespace="$NAMESPACE_NAME" create secret generic aws-creds \
     --from-literal=aws_access_key_id="$aws_access_key_id" \
     --from-literal=aws_secret_access_key="$aws_secret_access_key"
   ```
1. Create volumes (this is the equivalent to creating a unique work directory for the workflow execution job):
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f VolumeClaims.yaml
   ```

   If on GKE (Google Kubernetes Engine), see the GKE caveat below to create an
   NFS server to support `ReadWriteMany` and run this afterwards:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f GKE/VolumeClaims.yaml
   ```
1. Run the workflow:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f CalrissianJob.yaml
   ```

   Monitor execution with:
   ```
   while true; do kubectl --namespace="$NAMESPACE_NAME" logs -f job/calrissian-job && break; sleep 2; done
   ```

   Output should be similar to this:
   ```
   INFO calrissian 0.10.0 (cwltool 3.1.20211004060744)                                                               INFO https://raw.githubusercontent.com/pymonger/soamc-cwl-demo/develop/baseline-pge/baseline-pge-workflow.cwl:1:1: Unknown hint
                                                                                                                 http://commonwl.org/cwltool#Secrets
   INFO https://raw.githubusercontent.com/pymonger/soamc-cwl-demo/develop/baseline-pge/stage-out.cwl:1:1: Unknown hint
                                                                                                     http://commonwl.org/cwltool#Secrets
   INFO [workflow ] starting step stage-in
   INFO [step stage-in] start
   INFO [workflow ] start
   INFO [step stage-in] completed success
   INFO [workflow ] starting step run-pge
   INFO [step run-pge] start
   INFO [step run-pge] completed success
   INFO [workflow ] starting step stage-out
   INFO [step stage-out] start
   INFO [step stage-out] completed success
   INFO [workflow ] completed success
   {
       "final_dataset_dir": {
           "location": "file:///calrissian/output-data/dumby-product-20210622191038567000",
           "basename": "dumby-product-20210622191038567000",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///calrissian/output-data/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png",
                   "basename": "dumby-product-20210622191038567000.browse.png",
                   "checksum": "sha1$5cd47ad8f2cd2f7f4d8bc8df02dfb06a57b74914",
                   "size": 2477207,
                   "path": "/calrissian/output-data/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///calrissian/output-data/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png",
                   "basename": "dumby-product-20210622191038567000.browse_small.png",
                   "checksum": "sha1$8230dd45fdeb8a376840c9edd9b064e8625090fc",
                   "size": 80019,
                   "path": "/calrissian/output-data/dumby-product-20210622191038567000/dumby-product-20210622191038567000.browse_small.png"
               },
               {
                   "class": "File",
                   "location": "file:///calrissian/output-data/dumby-product-20210622191038567000/dumby-product-20210622191038567000.dataset.json",
                   "basename": "dumby-product-20210622191038567000.dataset.json",
   622191038567000.met.json",
                   "basename": "dumby-product-20210622191038567000.met.json",
                   "checksum": "sha1$620d60e084154f2ee5dd460a4b8133e794ea758e",
                   "size": 189,
                   "path": "/calrissian/output-data/dumby-product-20210622191038567000/dumby-product-20210622191038567000.met.json"
               },
               {   
                   "class": "File",
                   "location": "file:///calrissian/output-data/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF",
                   "basename": "LC80101172015002LGN00_BQA.TIF",
                   "checksum": "sha1$e85ca3c7a92887593c1caa434bbc17893650baf4",
                   "size": 2861879,
                   "path": "/calrissian/output-data/dumby-product-20210622191038567000/LC80101172015002LGN00_BQA.TIF"
               }
           ],
           "path": "/calrissian/output-data/dumby-product-20210622191038567000"
       },
       "stderr_run-pge": {
           "location": "file:///calrissian/output-data/stderr_run-pge.txt",
           "basename": "stderr_run-pge.txt",
           "class": "File",
           "checksum": "sha1$9340a52d43d53f44fe5847f37f102d2609978c50",
           "size": 93300733,
           "path": "/calrissian/output-data/stderr_run-pge.txt"
       },
       "stderr_stage-in": {
           "location": "file:///calrissian/output-data/stderr_stage-in.txt",
           "basename": "stderr_stage-in.txt",
           "class": "File",
           "checksum": "sha1$007c5b2d361259523791355e59d4f250bac6ad80",
           "size": 475,
           "path": "/calrissian/output-data/stderr_stage-in.txt"
       },
       "stderr_stage-out": {
           "location": "file:///calrissian/output-data/stderr_stage-out.txt",
           "basename": "stderr_stage-out.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/calrissian/output-data/stderr_stage-out.txt"
       },
       "stdout_run-pge": {
           "location": "file:///calrissian/output-data/stdout_run-pge.txt",
           "basename": "stdout_run-pge.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/calrissian/output-data/stdout_run-pge.txt"
       },
       "stdout_stage-in": {
   INFO Final process status is success
           "location": "file:///calrissian/output-data/stdout_stage-in.txt",
           "basename": "stdout_stage-in.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/calrissian/output-data/stdout_stage-in.txt"
       },
       "stdout_stage-out": {
           "location": "file:///calrissian/output-data/stdout_stage-out.txt",
           "basename": "stdout_stage-out.txt",
           "class": "File",
           "checksum": "sha1$3d21e822ba163b0b862416dba7b285819330b2f5",
           "size": 3058,
           "path": "/calrissian/output-data/stdout_stage-out.txt"
       }
   }
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

   Then copy out the output-data directory through this pod:
   ```
   NAMESPACE_NAME=soamc-cwl-demo
   kubectl --namespace="$NAMESPACE_NAME" cp access-pv:/calrissian/output-data output-data
   ```
1. Verify that the`dumby-product-20210622191038567000` dataset directory exists in the output-data directory:
   ```
   ls -ltr output-data/dumby-product-20210622191038567000/
   ```

   Output should look similar to this:
   ```
   total 10608
   -rw-r--r--  1 gmanipon  staff  2477207 Oct 13 13:33 dumby-product-20210622191038567000.browse.png
   -rw-r--r--  1 gmanipon  staff    80019 Oct 13 13:33 dumby-product-20210622191038567000.browse_small.png
   -rw-r--r--  1 gmanipon  staff        2 Oct 13 13:33 dumby-product-20210622191038567000.dataset.json
   -rw-r--r--  1 gmanipon  staff      189 Oct 13 13:33 dumby-product-20210622191038567000.met.json
   -rw-r--r--  1 gmanipon  staff  2861879 Oct 13 13:33 LC80101172015002LGN00_BQA.TIF
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep workflow_base_dataset_url baseline-pge-workflow-job.yml | awk '{print $2}')/$(grep workflow_product_id baseline-pge-workflow-job.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2021-10-13 13:32:49    2861879 LC80101172015002LGN00_BQA.TIF
   2021-10-13 13:32:49    2477207 dumby-product-20210622191038567000.browse.png
   2021-10-13 13:32:49      80019 dumby-product-20210622191038567000.browse_small.png
   2021-10-13 13:32:49          2 dumby-product-20210622191038567000.dataset.json
   2021-10-13 13:32:49        189 dumby-product-20210622191038567000.met.json
   ```

## K8s Caveats

### Azure Kubernetes Service

The default storage class utilizes azure disk which doesn't support `ReadWriteMany` which is required by
Calrissian. To change the default storage class to azure-file (which supports `ReadWriteMany`):

```
$ kubectl get storageclass
NAME                PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile           kubernetes.io/azure-file   Delete          Immediate              true                   106d
azurefile-premium   kubernetes.io/azure-file   Delete          Immediate              true                   106d
default (default)   kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
managed-premium     kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d

$ kubectl patch storageclass default -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
storageclass.storage.k8s.io/default patched

$ kubectl get storageclass
NAME                PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile           kubernetes.io/azure-file   Delete          Immediate              true                   106d
azurefile-premium   kubernetes.io/azure-file   Delete          Immediate              true                   106d
default             kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
managed-premium     kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d

$ kubectl patch storageclass azurefile -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
storageclass.storage.k8s.io/azurefile patched

$ kubectl get storageclass
NAME                  PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile (default)   kubernetes.io/azure-file   Delete          Immediate              true                   106d
azurefile-premium     kubernetes.io/azure-file   Delete          Immediate              true                   106d
default               kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
managed-premium       kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
```

### Google Kubernetes Engine

The default storage class utilizes Google persistent disk which doesn't support `ReadWriteMany` 
which is required by Calrissian. Google Cloud Filestore resolves this issue but it is a costly
solution. The alternative is to run NFS in the GKE cluster as described here:
https://medium.com/@Sushil_Kumar/readwritemany-persistent-volumes-in-google-kubernetes-engine-a0b93e203180

Run the following to proceed with setting up an NFS server on your GKE cluster:
```
# provision a GCP persistent disk
gcloud compute disks create --size=10GB --zone=us-west2-a nfs-disk

# provision NFS deployment
kubectl create -f GKE/nfs-server-deployment.yaml

# make NFS server accessible at a fixed IP/DNS
kubectl create -f GKE/nfs-clusterip-service.yaml
```
After this, continue with step 5 above but instead use the `GKE/VolumeClaims.yaml` instead:
```
kubectl --namespace="$NAMESPACE_NAME" create -f GKE/VolumeClaims.yaml
```
