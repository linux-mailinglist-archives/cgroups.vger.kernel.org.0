Return-Path: <cgroups+bounces-2472-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B48A3EC2
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 23:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A39281E1C
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AD5644B;
	Sat, 13 Apr 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ8lmKQO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC3537F6;
	Sat, 13 Apr 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044064; cv=none; b=SZIxWTc0cVGvmCe4GRy7Y8zNHG6ClMLsXVj8ohapTZuGA21vp60oPXqGYsC0CiqBsDGva42Mrg8MXvpd0RuxJx7Wx0peX1nCZ1bImG4c6ZceuRXTpgyO71q7/kMixx8cbohDHnX838rru8IGLcGULj3urYoOo9nHC2TaX5RWzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044064; c=relaxed/simple;
	bh=gHEXvCSnZpnw6hTckg2tGstdsatBgKWirSYGD99cXY4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=asNHhK+54YUW3Gz8+YY2MoGvxB3Uf2PfTVrrgjOhofQU56qLpZ9q9EMSsNRSYd1zXR38A+Yr9JgYOTyJCxe7OB3LCMg80BsexiRUkziwhA/xoHpdFJQkZQqdHLaQduSf02wVXOOxKmFiIf8MD9HVx+MxDJMG8+v3BLxDtVhCIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ8lmKQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB099C113CD;
	Sat, 13 Apr 2024 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044063;
	bh=gHEXvCSnZpnw6hTckg2tGstdsatBgKWirSYGD99cXY4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hJ8lmKQOlDpjdp+cmrA9NDRwEBLVmjJ6jDHcYxzK7ougM6cXDrU1Ho/VOQNliQqcb
	 kQf+9inJIL1oJPQDIiDcKWR32VDwnnqlqLEiDIanEaWgjsyuFK/2ZhooKcLgemIcLQ
	 eCo52rE1NyJNDsBsN/ymVMfVGMFzPT+PVTu/bzUoVZ8gj5rOl54TXtY17bCXD1PIui
	 mBSrFJHJf6URZByXJooxa4iNAIPW36mt5BNIWQ221FJMw+xSH9//8Qu9UMAascNzke
	 7LhAgCWIiLn1eisHNssjJOoODOrXBISYpZ+2UToggdNnyR1hpmYnzGzMAJSD7TnKJL
	 tXH+QgJVEsN1Q==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:34:17 +0300
Message-Id: <D0JBFRTGWZV9.3TRHOTV0SCGV@kernel.org>
Subject: Re: [PATCH v11 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
X-Mailer: aerc 0.17.0
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
 <20240410182558.41467-15-haitao.huang@linux.intel.com>
In-Reply-To: <20240410182558.41467-15-haitao.huang@linux.intel.com>

On Wed Apr 10, 2024 at 9:25 PM EEST, Haitao Huang wrote:
> To run selftests for EPC cgroup:
>
> sudo ./run_epc_cg_selftests.sh
>
> To watch misc cgroup 'current' changes during testing, run this in a
> separate terminal:
>
> ./watch_misc_for_tests.sh current
>
> With different cgroups, the script starts one or multiple concurrent SGX
> selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
> test case, which loads an enclave of EPC size equal to the EPC capacity
> available on the platform. The script checks results against the
> expectation set for each cgroup and reports success or failure.
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
> concurrent tests. The script starts 8 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all processes exit.
>
> The script also includes a test with low mem_cg limit and LARGE sgx_epc
> limit to verify that the RAM used for per-cgroup reclamation is charged
> to a proper mem_cg. For this test, it turns off swapping before start,
> and turns swapping back on afterwards.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V11:
> - Remove cgroups-tools dependency and make scripts ash compatible. (Jarkk=
o)
> - Drop support for cgroup v1 and simplify. (Michal, Jarkko)
> - Add documentation for functions. (Jarkko)
> - Turn off swapping before memcontrol tests and back on after
> - Format and style fixes, name for hard coded values
>
> V7:
> - Added memcontrol test.
>
> V5:
> - Added script with automatic results checking, remove the interactive
> script.
> - The script can run independent from the series below.
> ---
>  tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
>  .../selftests/sgx/run_epc_cg_selftests.sh     | 275 ++++++++++++++++++
>  .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
>  3 files changed, 302 insertions(+)
>  create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
>  create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>  create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh
>
> diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh b/tools/testing/se=
lftests/sgx/ash_cgexec.sh
> new file mode 100755
> index 000000000000..cfa5d2b0e795
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/ash_cgexec.sh
> @@ -0,0 +1,16 @@
> +#!/usr/bin/env sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2024 Intel Corporation.
> +
> +# Start a program in a given cgroup.
> +# Supports V2 cgroup paths, relative to /sys/fs/cgroup
> +if [ "$#" -lt 2 ]; then
> +    echo "Usage: $0 <v2 cgroup path> <command> [args...]"
> +    exit 1
> +fi
> +# Move this shell to the cgroup.
> +echo 0 >/sys/fs/cgroup/$1/cgroup.procs
> +shift
> +# Execute the command within the cgroup
> +exec "$@"
> +
> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/=
testing/selftests/sgx/run_epc_cg_selftests.sh
> new file mode 100755
> index 000000000000..dd56273056fc
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> @@ -0,0 +1,275 @@
> +#!/usr/bin/env sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2023, 2024 Intel Corporation.
> +
> +TEST_ROOT_CG=3Dselftest
> +TEST_CG_SUB1=3D$TEST_ROOT_CG/test1
> +TEST_CG_SUB2=3D$TEST_ROOT_CG/test2
> +# We will only set limit in test1 and run tests in test3
> +TEST_CG_SUB3=3D$TEST_ROOT_CG/test1/test3
> +TEST_CG_SUB4=3D$TEST_ROOT_CG/test4
> +
> +# Cgroup v2 only
> +CG_ROOT=3D/sys/fs/cgroup
> +mkdir -p $CG_ROOT/$TEST_CG_SUB1
> +mkdir -p $CG_ROOT/$TEST_CG_SUB2
> +mkdir -p $CG_ROOT/$TEST_CG_SUB3
> +mkdir -p $CG_ROOT/$TEST_CG_SUB4
> +
> +# Turn on misc and memory controller in non-leaf nodes
> +echo "+misc" >  $CG_ROOT/cgroup.subtree_control && \
> +echo "+memory" > $CG_ROOT/cgroup.subtree_control && \
> +echo "+misc" >  $CG_ROOT/$TEST_ROOT_CG/cgroup.subtree_control && \
> +echo "+memory" > $CG_ROOT/$TEST_ROOT_CG/cgroup.subtree_control && \
> +echo "+misc" >  $CG_ROOT/$TEST_CG_SUB1/cgroup.subtree_control
> +if [ $? -ne 0 ]; then
> +    echo "# Failed setting up cgroups, make sure misc and memory cgroups=
 are enabled."
> +    exit 1
> +fi
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
> +echo "sgx_epc $SMALL" > $CG_ROOT/$TEST_CG_SUB1/misc.max && \
> +echo "sgx_epc $LARGE" >  $CG_ROOT/$TEST_CG_SUB2/misc.max && \
> +echo "sgx_epc $LARGER" > $CG_ROOT/$TEST_CG_SUB4/misc.max
> +if [ $? -ne 0 ]; then
> +    echo "# Failed setting up misc limits."
> +    exit 1
> +fi
> +
> +clean_up()
> +{
> +    sleep 2
> +    rmdir $CG_ROOT/$TEST_CG_SUB2
> +    rmdir $CG_ROOT/$TEST_CG_SUB3
> +    rmdir $CG_ROOT/$TEST_CG_SUB4
> +    rmdir $CG_ROOT/$TEST_CG_SUB1
> +    rmdir $CG_ROOT/$TEST_ROOT_CG
> +}
> +
> +timestamp=3D$(date +%Y%m%d_%H%M%S)
> +
> +test_cmd=3D"./test_sgx -t unclobbered_vdso_oversubscribed"
> +
> +PROCESS_SUCCESS=3D1
> +PROCESS_FAILURE=3D0
> +
> +# Wait for a process and check for expected exit status.
> +#
> +# Arguments:
> +#	$1 - the pid of the process to wait and check.
> +#	$2 - 1 if expecting success, 0 for failure.
> +#
> +# Return:
> +#	0 if the exit status of the process matches the expectation.
> +#	1 otherwise.
> +wait_check_process_status() {
> +    pid=3D$1
> +    check_for_success=3D$2
> +
> +    wait "$pid"
> +    status=3D$?
> +
> +    if [ $check_for_success -eq $PROCESS_SUCCESS ] && [ $status -eq 0 ];=
 then
> +        echo "# Process $pid succeeded."
> +        return 0
> +    elif [ $check_for_success -eq $PROCESS_FAILURE ] && [ $status -ne 0 =
]; then
> +        echo "# Process $pid returned failure."
> +        return 0
> +    fi
> +    return 1
> +}
> +
> +# Wait for a set of processes and check for expected exit status
> +#
> +# Arguments:
> +#	$1 - 1 if expecting success, 0 for failure.
> +#	remaining args - The pids of the processes
> +#
> +# Return:
> +#	0 if exit status of any process matches the expectation.
> +#	1 otherwise.
> +wait_and_detect_for_any() {
> +    check_for_success=3D$1
> +
> +    shift
> +    detected=3D1 # 0 for success detection
> +
> +    for pid in $@; do
> +        if wait_check_process_status "$pid" "$check_for_success"; then
> +            detected=3D0
> +            # Wait for other processes to exit
> +        fi
> +    done
> +
> +    return $detected
> +}
> +
> +echo "# Start unclobbered_vdso_oversubscribed with SMALL limit, expectin=
g failure..."
> +# Always use leaf node of misc cgroups
> +# these may fail on OOM
> +./ash_cgexec.sh $TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&=
1
> +if [ $? -eq 0 ]; then
> +    echo "# Fail on SMALL limit, not expecting any test passes."
> +    clean_up
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
> +
> +pids=3D""
> +for i in 1 2 3 4; do
> +    (
> +        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$=
timestamp.$i.log 2>&1
> +    ) &
> +    pids=3D"$pids $!"
> +done
> +
> +
> +if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
> +    echo "# PASSED LARGE limit positive testing."
> +else
> +    echo "# Failed on LARGE limit positive testing, no test passes."
> +    clean_up
> +    exit 1
> +fi
> +
> +echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with LA=
RGE limit,
> +        expecting at least one failure...."
> +pids=3D""
> +for i in 1 2 3 4 5; do
> +    (
> +        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$=
timestamp.$i.log 2>&1
> +    ) &
> +    pids=3D"$pids $!"
> +done
> +
> +if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
> +    echo "# PASSED LARGE limit negative testing."
> +else
> +    echo "# Failed on LARGE limit negative testing, no test fails."
> +    clean_up
> +    exit 1
> +fi
> +
> +echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LA=
RGER limit,
> +        expecting no failure...."
> +pids=3D""
> +for i in 1 2 3 4 5 6 7 8; do
> +    (
> +        ./ash_cgexec.sh $TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestam=
p.$i.log 2>&1
> +    ) &
> +    pids=3D"$pids $!"
> +done
> +
> +if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
> +    echo "# Failed on LARGER limit, at least one test fails."
> +    clean_up
> +    exit 1
> +else
> +    echo "# PASSED LARGER limit tests."
> +fi
> +
> +echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LA=
RGER limit,
> +      randomly kill one, expecting no failure...."
> +pids=3D""
> +for i in 1 2 3 4 5 6 7 8; do
> +    (
> +        ./ash_cgexec.sh $TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$tim=
estamp.$i.log 2>&1
> +    ) &
> +    pids=3D"$pids $!"
> +done
> +random_number=3D$(awk 'BEGIN{srand();print int(rand()*5)}')
> +sleep $((random_number + 1))
> +
> +# Randomly select a process to kill
> +# Make sure usage counter not leaked at the end.
> +RANDOM_INDEX=3D$(awk 'BEGIN{srand();print int(rand()*8)}')
> +counter=3D0
> +for pid in $pids; do
> +    if [ "$counter" -eq "$RANDOM_INDEX" ]; then
> +        PID_TO_KILL=3D$pid
> +        break
> +    fi
> +    counter=3D$((counter + 1))
> +done
> +
> +kill $PID_TO_KILL
> +echo "# Killed process with PID: $PID_TO_KILL"
> +
> +any_failure=3D0
> +for pid in $pids; do
> +    wait "$pid"
> +    status=3D$?
> +    if [ "$pid" !=3D "$PID_TO_KILL" ]; then
> +        if [ $status -ne 0 ]; then
> +	    echo "# Process $pid returned failure."
> +            any_failure=3D1
> +        fi
> +    fi
> +done
> +
> +if [ $any_failure -ne 0 ]; then
> +    echo "# Failed on random killing, at least one test fails."
> +    clean_up
> +    exit 1
> +fi
> +echo "# PASSED LARGER limit test with a process randomly killed."
> +
> +MEM_LIMIT_TOO_SMALL=3D$((CAPACITY - 2 * LARGE))
> +
> +echo "$MEM_LIMIT_TOO_SMALL" > $CG_ROOT/$TEST_CG_SUB2/memory.max
> +if [ $? -ne 0 ]; then
> +    echo "# Failed creating memory controller."
> +    clean_up
> +    exit 1
> +fi
> +
> +echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LA=
RGE EPC limit,
> +        and too small RAM limit, expecting all failures...."
> +# Ensure swapping off so the OOM killer is activated when mem_cgroup lim=
it is hit.
> +swapoff -a
> +pids=3D""
> +for i in 1 2 3 4; do
> +    (
> +        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd >cgtest_large_oom_$times=
tamp.$i.log 2>&1
> +    ) &
> +    pids=3D"$pids $!"
> +done
> +
> +if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
> +    echo "# Failed on tests with memcontrol, some tests did not fail."
> +    clean_up
> +    swapon -a
> +    exit 1
> +else
> +    swapon -a
> +    echo "# PASSED LARGE limit tests with memcontrol."
> +fi
> +
> +sleep 2
> +
> +USAGE=3D$(grep '^sgx_epc' "$CG_ROOT/$TEST_ROOT_CG/misc.current" | awk '{=
print $2}')
> +if [ "$USAGE" -ne 0 ]; then
> +    echo "# Failed: Final usage is $USAGE, not 0."
> +else
> +    echo "# PASSED leakage check."
> +    echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
> +fi
> +clean_up
> +echo "# done."
> diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/=
testing/selftests/sgx/watch_misc_for_tests.sh
> new file mode 100755
> index 000000000000..1c9985726ace
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
> @@ -0,0 +1,11 @@
> +#!/usr/bin/env sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2023, 2024 Intel Corporation.
> +
> +if [ -z "$1" ]; then
> +    echo "No argument supplied, please provide 'max', 'current', or 'eve=
nts'"
> +    exit 1
> +fi
> +
> +watch -n 1 'find /sys/fs/cgroup -wholename "*/test*/misc.'$1'" -exec \
> +    sh -c '\''echo "$1:"; cat "$1"'\'' _ {} \;'

I'll compile the kernel with this and see what happens!

Have you tried to run the test suite from top-level? This is just a
sanity check. I've few times forgot to do this so thus asking :-)

BR, Jarkko

