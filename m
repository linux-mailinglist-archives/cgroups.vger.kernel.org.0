Return-Path: <cgroups+bounces-436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE407ED523
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DE7B20A7F
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A722FE25;
	Wed, 15 Nov 2023 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB6xGR0P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8543ACA
	for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 21:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC84C433C8;
	Wed, 15 Nov 2023 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700082057;
	bh=EZnoGrDSgDtvXarpirnsnzrk/w/EI7vAyv4wQcSOROw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CB6xGR0PFo8Mk3ffEgE4ISOT1UN8sekKav5RvhN59W20uRZxIvYCQq7cSD9Mcjtpz
	 kZbQtzPqBvPznI2b9lNbfsCw6I5quEsb5GLq3h/qweYzLgdJ5b/2bTQEvCEMthoXvB
	 tGkSydk4YxnXruEkglm5AIOTkuw5LXIa1unykHL9+XQCBWWr7L7kXZ5BdQ3nD4rMWd
	 9DgDY90fHpRYKOHO7yDKlf0zI0xD1SwqgTVcr4NStTF5ReJ9xF2p+J4a7duv210Eo8
	 axykr2YlppsrK1T+/GWbQw+nhVGqJW8MdrQSDVmJF0hiflot+3JYxABmhP52In1/uf
	 Ppko673qBYyTw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 23:00:51 +0200
Message-Id: <CWZOSGQ2RYRX.2T0TCXOL4991P@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v6 12/12] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-13-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-13-haitao.huang@linux.intel.com>

On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> The scripts rely on cgroup-tools package from libcgroup [1].
>
> To run selftests for epc cgroup:
>
> sudo ./run_epc_cg_selftests.sh
>
> With different cgroups, the script starts one or multiple concurrent SGX
> selftests, each to run one unclobbered_vdso_oversubscribed test.  Each
> of such test tries to load an enclave of EPC size equal to the EPC
> capacity available on the platform. The script checks results against
> the expectation set for each cgroup and reports success or failure.
>
> The script creates 3 different cgroups at the beginning with following
> expectations:
>
> 1) SMALL - intentionally small enough to fail the test loading an
> enclave of size equal to the capacity.
> 2) LARGE - large enough to run up to 4 concurrent tests but fail some if
> more than 4 concurrent tests are run. The script starts 4 expecting at
> least one test to pass, and then starts 5 expecting at least one test
> to fail.
> 3) LARGER - limit is the same as the capacity, large enough to run lots o=
f
> concurrent tests. The script starts 10 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all process exit.
>
> To watch misc cgroup 'current' changes during testing, run this in a
> separate terminal:
>
> ./watch_misc_for_tests.sh current
>
> [1] https://github.com/libcgroup/libcgroup/blob/main/README
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V5:
>
> - Added script with automatic results checking, remove the interactive
> script.
> - The script can run independent from the series below.
> ---
>  .../selftests/sgx/run_epc_cg_selftests.sh     | 196 ++++++++++++++++++
>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 ++
>  2 files changed, 209 insertions(+)
>  create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>  create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh
>
> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/=
testing/selftests/sgx/run_epc_cg_selftests.sh
> new file mode 100755
> index 000000000000..72b93f694753
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> @@ -0,0 +1,196 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2023 Intel Corporation.
> +
> +TEST_ROOT_CG=3Dselftest
> +cgcreate -g misc:$TEST_ROOT_CG
> +if [ $? -ne 0 ]; then
> +    echo "# Please make sure cgroup-tools is installed, and misc cgroup =
is mounted."
> +    exit 1
> +fi
> +TEST_CG_SUB1=3D$TEST_ROOT_CG/test1
> +TEST_CG_SUB2=3D$TEST_ROOT_CG/test2
> +TEST_CG_SUB3=3D$TEST_ROOT_CG/test1/test3
> +TEST_CG_SUB4=3D$TEST_ROOT_CG/test4
> +
> +cgcreate -g misc:$TEST_CG_SUB1
> +cgcreate -g misc:$TEST_CG_SUB2
> +cgcreate -g misc:$TEST_CG_SUB3
> +cgcreate -g misc:$TEST_CG_SUB4
> +
> +# Default to V2
> +CG_ROOT=3D/sys/fs/cgroup
> +if [ ! -d "/sys/fs/cgroup/misc" ]; then
> +    echo "# cgroup V2 is in use."
> +else
> +    echo "# cgroup V1 is in use."
> +    CG_ROOT=3D/sys/fs/cgroup/misc
> +fi

Does the test need to support v1 cgroups?

> +
> +CAPACITY=3D$(grep "sgx_epc" "$CG_ROOT/misc.capacity" | awk '{print $2}')
> +# This is below number of VA pages needed for enclave of capacity size. =
So
> +# should fail oversubscribed cases
> +SMALL=3D$(( CAPACITY / 512 ))
> +
> +# At least load one enclave of capacity size successfully, maybe up to 4=
.
> +# But some may fail if we run more than 4 concurrent enclaves of capacit=
y size.
> +LARGE=3D$(( SMALL * 4 ))
> +
> +# Load lots of enclaves
> +LARGER=3D$CAPACITY
> +echo "# Setting up limits."
> +echo "sgx_epc $SMALL" | tee $CG_ROOT/$TEST_CG_SUB1/misc.max
> +echo "sgx_epc $LARGE" | tee $CG_ROOT/$TEST_CG_SUB2/misc.max
> +echo "sgx_epc $LARGER" | tee $CG_ROOT/$TEST_CG_SUB4/misc.max
> +
> +timestamp=3D$(date +%Y%m%d_%H%M%S)
> +
> +test_cmd=3D"./test_sgx -t unclobbered_vdso_oversubscribed"
> +
> +echo "# Start unclobbered_vdso_oversubscribed with SMALL limit, expectin=
g failure..."
> +# Always use leaf node of misc cgroups so it works for both v1 and v2
> +# these may fail on OOM
> +cgexec -g misc:$TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
> +if [[ $? -eq 0 ]]; then
> +    echo "# Fail on SMALL limit, not expecting any test passes."
> +    cgdelete -r -g misc:$TEST_ROOT_CG
> +    exit 1
> +else
> +    echo "# Test failed as expected."
> +fi
> +
> +echo "# PASSED SMALL limit."
> +
> +echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LA=
RGE limit,
> +        expecting at least one success...."
> +pids=3D()
> +for i in {1..4}; do
> +    (
> +        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$t=
imestamp.$i.log 2>&1
> +    ) &
> +    pids+=3D($!)
> +done
> +
> +any_success=3D0
> +for pid in "${pids[@]}"; do
> +    wait "$pid"
> +    status=3D$?
> +    if [[ $status -eq 0 ]]; then
> +        any_success=3D1
> +	echo "# Process $pid returned successfully."
> +    fi
> +done
> +
> +if [[ $any_success -eq 0 ]]; then
> +    echo "# Failed on LARGE limit positive testing, no test passes."
> +    cgdelete -r -g misc:$TEST_ROOT_CG
> +    exit 1
> +fi
> +
> +echo "# PASSED LARGE limit positive testing."
> +
> +echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with LA=
RGE limit,
> +        expecting at least one failure...."
> +pids=3D()
> +for i in {1..5}; do
> +    (
> +        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$t=
imestamp.$i.log 2>&1
> +    ) &
> +    pids+=3D($!)
> +done
> +
> +any_failure=3D0
> +for pid in "${pids[@]}"; do
> +    wait "$pid"
> +    status=3D$?
> +    if [[ $status -ne 0 ]]; then
> +	echo "# Process $pid returned failure."
> +        any_failure=3D1
> +    fi
> +done
> +
> +if [[ $any_failure -eq 0 ]]; then
> +    echo "# Failed on LARGE limit negative testing, no test fails."
> +    cgdelete -r -g misc:$TEST_ROOT_CG
> +    exit 1
> +fi
> +
> +echo "# PASSED LARGE limit negative testing."
> +
> +echo "# Start 10 concurrent unclobbered_vdso_oversubscribed tests with L=
ARGER limit,
> +        expecting no failure...."
> +pids=3D()
> +for i in {1..10}; do
> +    (
> +        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp=
.$i.log 2>&1
> +    ) &
> +    pids+=3D($!)
> +done
> +
> +any_failure=3D0
> +for pid in "${pids[@]}"; do
> +    wait "$pid"
> +    status=3D$?
> +    if [[ $status -ne 0 ]]; then
> +	echo "# Process $pid returned failure."
> +        any_failure=3D1
> +    fi
> +done
> +
> +if [[ $any_failure -ne 0 ]]; then
> +    echo "# Failed on LARGER limit, at least one test fails."
> +    cgdelete -r -g misc:$TEST_ROOT_CG
> +    exit 1
> +fi
> +
> +echo "# PASSED LARGER limit tests."
> +
> +
> +echo "# Start 10 concurrent unclobbered_vdso_oversubscribed tests with L=
ARGER limit,
> +      randomly kill one, expecting no failure...."
> +pids=3D()
> +for i in {1..10}; do
> +    (
> +        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp=
.$i.log 2>&1
> +    ) &
> +    pids+=3D($!)
> +done
> +
> +sleep $((RANDOM % 10 + 5))
> +
> +# Randomly select a PID to kill
> +RANDOM_INDEX=3D$((RANDOM % 10))
> +PID_TO_KILL=3D${pids[RANDOM_INDEX]}
> +
> +kill $PID_TO_KILL
> +echo "# Killed process with PID: $PID_TO_KILL"
> +
> +any_failure=3D0
> +for pid in "${pids[@]}"; do
> +    wait "$pid"
> +    status=3D$?
> +    if [ "$pid" !=3D "$PID_TO_KILL" ]; then
> +        if [[ $status -ne 0 ]]; then
> +	    echo "# Process $pid returned failure."
> +            any_failure=3D1
> +        fi
> +    fi
> +done
> +
> +if [[ $any_failure -ne 0 ]]; then
> +    echo "# Failed on random killing, at least one test fails."
> +    cgdelete -r -g misc:$TEST_ROOT_CG
> +    exit 1
> +fi
> +
> +sleep 1
> +
> +USAGE=3D$(grep '^sgx_epc' "$CG_ROOT/$TEST_ROOT_CG/misc.current" | awk '{=
print $2}')
> +if [ "$USAGE" -ne 0 ]; then
> +    echo "# Failed: Final usage is $USAGE, not 0."
> +else
> +    echo "# PASSED leakage check."
> +    echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
> +fi
> +cgdelete -r -g misc:$TEST_ROOT_CG
> +echo "# done."
> diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/=
testing/selftests/sgx/watch_misc_for_tests.sh
> new file mode 100755
> index 000000000000..dbd38f346e7b
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
> @@ -0,0 +1,13 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2023 Intel Corporation.
> +
> +if [ -z "$1" ]
> +  then
> +    echo "No argument supplied, please provide 'max', 'current' or 'even=
ts'"
> +    exit 1
> +fi
> +
> +watch -n 1 "find /sys/fs/cgroup -wholename */test*/misc.$1 -exec sh -c \
> +    'echo \"\$1:\"; cat \"\$1\"' _ {} \;"
> +

BR, Jarkko

