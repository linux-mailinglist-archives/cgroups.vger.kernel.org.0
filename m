Return-Path: <cgroups+bounces-2488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE638A5A61
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC87D1F229DB
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594415575F;
	Mon, 15 Apr 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clNy4uP6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133A219EA;
	Mon, 15 Apr 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208132; cv=none; b=I6ktDB3aGdJbKXgkzZMj3XxiPl3BL0yS8Yvm2uBJug+k7/48wkYj7cDzTcBBxCQCc205GT00lASz8bBW60xwoLWO61hcn/0pdA5Qd5Uqamj/txCWifSCKFdcNXZLWC931+6s4+2puA4G0sBHiYFhoJGA6TTbWPDnwKKTxinXlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208132; c=relaxed/simple;
	bh=ABqLMLq2kctB2hBc+3xjhqB9Efz0wVvl07SZus701xw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MQU+9cBEN3RAWi4GC47txOV/6fzKZvkn50sp2rjUyh32mRhJxJs6xN2n0NZ58Mmpy87bnq0+OvL3RwCFPA1pG+QW/DQLivM+yX1cvLL/kOzVDfLb0JgzCYTsrhWPSShhCMyF9NKxFmHPMBEoQJd+HSj8oqecHYk8myzuaPlLyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clNy4uP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3F2C113CC;
	Mon, 15 Apr 2024 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713208131;
	bh=ABqLMLq2kctB2hBc+3xjhqB9Efz0wVvl07SZus701xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clNy4uP6Mv3aZ+DuVCF1x0c9dU50HXjt4y3qQL21vgP5xGpvPBNnUmY47KkD1DYAZ
	 46r9hXdKurPwrNNsk4meIfso//rrKEaz9xB83U59ExEB3HHybkf2cIc5w068CjCR6n
	 Ca6jhx1VpPz6YhFmzx7Z2fUNeQEBCbupFqBJXi019I1PPnlAgArdk22ZhshLIDqC/n
	 PrKbZAcVOpjd/taNhOUD0/ek1J7Exz9TOQxuO9vU4CDhS8xftlqBiWfJC/Q30Uj3JN
	 eAWr7vJIm4/kIralPaGOwtF76fIYH5QrVk+dxzqKgDTr+bNtulFSLTxFfEKrlSD4bR
	 wZ9zEWg1BAEqA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:08:44 +0300
Message-Id: <D0KXLFE83H9V.3GNOZNN4II125@kernel.org>
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
Subject: Re: [PATCH v11 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
X-Mailer: aerc 0.17.0
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
 <20240410182558.41467-15-haitao.huang@linux.intel.com>
 <D0JXP8HZLEQZ.3PHVXZI140VIH@kernel.org>
 <op.2l81wdjdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2l81wdjdwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Mon Apr 15, 2024 at 6:13 AM EEST, Haitao Huang wrote:
> On Sun, 14 Apr 2024 10:01:03 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Wed Apr 10, 2024 at 9:25 PM EEST, Haitao Huang wrote:
> >> To run selftests for EPC cgroup:
> >>
> >> sudo ./run_epc_cg_selftests.sh
> >>
> >> To watch misc cgroup 'current' changes during testing, run this in a
> >> separate terminal:
> >>
> >> ./watch_misc_for_tests.sh current
> >>
> >> With different cgroups, the script starts one or multiple concurrent S=
GX
> >> selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
> >> test case, which loads an enclave of EPC size equal to the EPC capacit=
y
> >> available on the platform. The script checks results against the
> >> expectation set for each cgroup and reports success or failure.
> >>
> >> The script creates 3 different cgroups at the beginning with following
> >> expectations:
> >>
> >> 1) SMALL - intentionally small enough to fail the test loading an
> >> enclave of size equal to the capacity.
> >> 2) LARGE - large enough to run up to 4 concurrent tests but fail some =
if
> >> more than 4 concurrent tests are run. The script starts 4 expecting at
> >> least one test to pass, and then starts 5 expecting at least one test
> >> to fail.
> >> 3) LARGER - limit is the same as the capacity, large enough to run lot=
s =20
> >> of
> >> concurrent tests. The script starts 8 of them and expects all pass.
> >> Then it reruns the same test with one process randomly killed and
> >> usage checked to be zero after all processes exit.
> >>
> >> The script also includes a test with low mem_cg limit and LARGE sgx_ep=
c
> >> limit to verify that the RAM used for per-cgroup reclamation is charge=
d
> >> to a proper mem_cg. For this test, it turns off swapping before start,
> >> and turns swapping back on afterwards.
> >>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> ---
> >> V11:
> >> - Remove cgroups-tools dependency and make scripts ash compatible. =20
> >> (Jarkko)
> >> - Drop support for cgroup v1 and simplify. (Michal, Jarkko)
> >> - Add documentation for functions. (Jarkko)
> >> - Turn off swapping before memcontrol tests and back on after
> >> - Format and style fixes, name for hard coded values
> >>
> >> V7:
> >> - Added memcontrol test.
> >>
> >> V5:
> >> - Added script with automatic results checking, remove the interactive
> >> script.
> >> - The script can run independent from the series below.
> >> ---
> >>  tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
> >>  .../selftests/sgx/run_epc_cg_selftests.sh     | 275 +++++++++++++++++=
+
> >>  .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
> >>  3 files changed, 302 insertions(+)
> >>  create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
> >>  create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.s=
h
> >>  create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.s=
h
> >>
> >> diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh =20
> >> b/tools/testing/selftests/sgx/ash_cgexec.sh
> >> new file mode 100755
> >> index 000000000000..cfa5d2b0e795
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/sgx/ash_cgexec.sh
> >> @@ -0,0 +1,16 @@
> >> +#!/usr/bin/env sh
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright(c) 2024 Intel Corporation.
> >> +
> >> +# Start a program in a given cgroup.
> >> +# Supports V2 cgroup paths, relative to /sys/fs/cgroup
> >> +if [ "$#" -lt 2 ]; then
> >> +    echo "Usage: $0 <v2 cgroup path> <command> [args...]"
> >> +    exit 1
> >> +fi
> >> +# Move this shell to the cgroup.
> >> +echo 0 >/sys/fs/cgroup/$1/cgroup.procs
> >> +shift
> >> +# Execute the command within the cgroup
> >> +exec "$@"
> >> +
> >> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh =20
> >> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> new file mode 100755
> >> index 000000000000..dd56273056fc
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> @@ -0,0 +1,275 @@
> >> +#!/usr/bin/env sh
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright(c) 2023, 2024 Intel Corporation.
> >> +
> >> +TEST_ROOT_CG=3Dselftest
> >> +TEST_CG_SUB1=3D$TEST_ROOT_CG/test1
> >> +TEST_CG_SUB2=3D$TEST_ROOT_CG/test2
> >> +# We will only set limit in test1 and run tests in test3
> >> +TEST_CG_SUB3=3D$TEST_ROOT_CG/test1/test3
> >> +TEST_CG_SUB4=3D$TEST_ROOT_CG/test4
> >> +
> >> +# Cgroup v2 only
> >> +CG_ROOT=3D/sys/fs/cgroup
> >> +mkdir -p $CG_ROOT/$TEST_CG_SUB1
> >> +mkdir -p $CG_ROOT/$TEST_CG_SUB2
> >> +mkdir -p $CG_ROOT/$TEST_CG_SUB3
> >> +mkdir -p $CG_ROOT/$TEST_CG_SUB4
> >> +
> >> +# Turn on misc and memory controller in non-leaf nodes
> >> +echo "+misc" >  $CG_ROOT/cgroup.subtree_control && \
> >> +echo "+memory" > $CG_ROOT/cgroup.subtree_control && \
> >> +echo "+misc" >  $CG_ROOT/$TEST_ROOT_CG/cgroup.subtree_control && \
> >> +echo "+memory" > $CG_ROOT/$TEST_ROOT_CG/cgroup.subtree_control && \
> >> +echo "+misc" >  $CG_ROOT/$TEST_CG_SUB1/cgroup.subtree_control
> >> +if [ $? -ne 0 ]; then
> >> +    echo "# Failed setting up cgroups, make sure misc and memory =20
> >> cgroups are enabled."
> >> +    exit 1
> >> +fi
> >> +
> >> +CAPACITY=3D$(grep "sgx_epc" "$CG_ROOT/misc.capacity" | awk '{print $2=
}')
> >> +# This is below number of VA pages needed for enclave of capacity =20
> >> size. So
> >> +# should fail oversubscribed cases
> >> +SMALL=3D$(( CAPACITY / 512 ))
> >> +
> >> +# At least load one enclave of capacity size successfully, maybe up t=
o =20
> >> 4.
> >> +# But some may fail if we run more than 4 concurrent enclaves of =20
> >> capacity size.
> >> +LARGE=3D$(( SMALL * 4 ))
> >> +
> >> +# Load lots of enclaves
> >> +LARGER=3D$CAPACITY
> >> +echo "# Setting up limits."
> >> +echo "sgx_epc $SMALL" > $CG_ROOT/$TEST_CG_SUB1/misc.max && \
> >> +echo "sgx_epc $LARGE" >  $CG_ROOT/$TEST_CG_SUB2/misc.max && \
> >> +echo "sgx_epc $LARGER" > $CG_ROOT/$TEST_CG_SUB4/misc.max
> >> +if [ $? -ne 0 ]; then
> >> +    echo "# Failed setting up misc limits."
> >> +    exit 1
> >> +fi
> >> +
> >> +clean_up()
> >> +{
> >> +    sleep 2
> >> +    rmdir $CG_ROOT/$TEST_CG_SUB2
> >> +    rmdir $CG_ROOT/$TEST_CG_SUB3
> >> +    rmdir $CG_ROOT/$TEST_CG_SUB4
> >> +    rmdir $CG_ROOT/$TEST_CG_SUB1
> >> +    rmdir $CG_ROOT/$TEST_ROOT_CG
> >> +}
> >> +
> >> +timestamp=3D$(date +%Y%m%d_%H%M%S)
> >> +
> >> +test_cmd=3D"./test_sgx -t unclobbered_vdso_oversubscribed"
> >> +
> >> +PROCESS_SUCCESS=3D1
> >> +PROCESS_FAILURE=3D0
> >> +
> >> +# Wait for a process and check for expected exit status.
> >> +#
> >> +# Arguments:
> >> +#	$1 - the pid of the process to wait and check.
> >> +#	$2 - 1 if expecting success, 0 for failure.
> >> +#
> >> +# Return:
> >> +#	0 if the exit status of the process matches the expectation.
> >> +#	1 otherwise.
> >> +wait_check_process_status() {
> >> +    pid=3D$1
> >> +    check_for_success=3D$2
> >> +
> >> +    wait "$pid"
> >> +    status=3D$?
> >> +
> >> +    if [ $check_for_success -eq $PROCESS_SUCCESS ] && [ $status -eq 0=
 =20
> >> ]; then
> >> +        echo "# Process $pid succeeded."
> >> +        return 0
> >> +    elif [ $check_for_success -eq $PROCESS_FAILURE ] && [ $status -ne=
 =20
> >> 0 ]; then
> >> +        echo "# Process $pid returned failure."
> >> +        return 0
> >> +    fi
> >> +    return 1
> >> +}
> >> +
> >> +# Wait for a set of processes and check for expected exit status
> >> +#
> >> +# Arguments:
> >> +#	$1 - 1 if expecting success, 0 for failure.
> >> +#	remaining args - The pids of the processes
> >> +#
> >> +# Return:
> >> +#	0 if exit status of any process matches the expectation.
> >> +#	1 otherwise.
> >> +wait_and_detect_for_any() {
> >> +    check_for_success=3D$1
> >> +
> >> +    shift
> >> +    detected=3D1 # 0 for success detection
> >> +
> >> +    for pid in $@; do
> >> +        if wait_check_process_status "$pid" "$check_for_success"; the=
n
> >> +            detected=3D0
> >> +            # Wait for other processes to exit
> >> +        fi
> >> +    done
> >> +
> >> +    return $detected
> >> +}
> >> +
> >> +echo "# Start unclobbered_vdso_oversubscribed with SMALL limit, =20
> >> expecting failure..."
> >> +# Always use leaf node of misc cgroups
> >> +# these may fail on OOM
> >> +./ash_cgexec.sh $TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log =
=20
> >> 2>&1
> >> +if [ $? -eq 0 ]; then
> >> +    echo "# Fail on SMALL limit, not expecting any test passes."
> >> +    clean_up
> >> +    exit 1
> >> +else
> >> +    echo "# Test failed as expected."
> >> +fi
> >> +
> >> +echo "# PASSED SMALL limit."
> >> +
> >> +echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with=
 =20
> >> LARGE limit,
> >> +        expecting at least one success...."
> >> +
> >> +pids=3D""
> >> +for i in 1 2 3 4; do
> >> +    (
> >> +        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd =20
> >> >cgtest_large_positive_$timestamp.$i.log 2>&1
> >> +    ) &
> >> +    pids=3D"$pids $!"
> >> +done
> >> +
> >> +
> >> +if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
> >> +    echo "# PASSED LARGE limit positive testing."
> >> +else
> >> +    echo "# Failed on LARGE limit positive testing, no test passes."
> >> +    clean_up
> >> +    exit 1
> >> +fi
> >> +
> >> +echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with=
 =20
> >> LARGE limit,
> >> +        expecting at least one failure...."
> >> +pids=3D""
> >> +for i in 1 2 3 4 5; do
> >> +    (
> >> +        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd =20
> >> >cgtest_large_negative_$timestamp.$i.log 2>&1
> >> +    ) &
> >> +    pids=3D"$pids $!"
> >> +done
> >> +
> >> +if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
> >> +    echo "# PASSED LARGE limit negative testing."
> >> +else
> >> +    echo "# Failed on LARGE limit negative testing, no test fails."
> >> +    clean_up
> >> +    exit 1
> >> +fi
> >> +
> >> +echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with=
 =20
> >> LARGER limit,
> >> +        expecting no failure...."
> >> +pids=3D""
> >> +for i in 1 2 3 4 5 6 7 8; do
> >> +    (
> >> +        ./ash_cgexec.sh $TEST_CG_SUB4 $test_cmd =20
> >> >cgtest_larger_$timestamp.$i.log 2>&1
> >> +    ) &
> >> +    pids=3D"$pids $!"
> >> +done
> >> +
> >> +if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
> >> +    echo "# Failed on LARGER limit, at least one test fails."
> >> +    clean_up
> >> +    exit 1
> >> +else
> >> +    echo "# PASSED LARGER limit tests."
> >> +fi
> >> +
> >> +echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with=
 =20
> >> LARGER limit,
> >> +      randomly kill one, expecting no failure...."
> >> +pids=3D""
> >> +for i in 1 2 3 4 5 6 7 8; do
> >> +    (
> >> +        ./ash_cgexec.sh $TEST_CG_SUB4 $test_cmd =20
> >> >cgtest_larger_kill_$timestamp.$i.log 2>&1
> >> +    ) &
> >> +    pids=3D"$pids $!"
> >> +done
> >> +random_number=3D$(awk 'BEGIN{srand();print int(rand()*5)}')
> >> +sleep $((random_number + 1))
> >> +
> >> +# Randomly select a process to kill
> >> +# Make sure usage counter not leaked at the end.
> >> +RANDOM_INDEX=3D$(awk 'BEGIN{srand();print int(rand()*8)}')
> >> +counter=3D0
> >> +for pid in $pids; do
> >> +    if [ "$counter" -eq "$RANDOM_INDEX" ]; then
> >> +        PID_TO_KILL=3D$pid
> >> +        break
> >> +    fi
> >> +    counter=3D$((counter + 1))
> >> +done
> >> +
> >> +kill $PID_TO_KILL
> >> +echo "# Killed process with PID: $PID_TO_KILL"
> >> +
> >> +any_failure=3D0
> >> +for pid in $pids; do
> >> +    wait "$pid"
> >> +    status=3D$?
> >> +    if [ "$pid" !=3D "$PID_TO_KILL" ]; then
> >> +        if [ $status -ne 0 ]; then
> >> +	    echo "# Process $pid returned failure."
> >> +            any_failure=3D1
> >> +        fi
> >> +    fi
> >> +done
> >> +
> >> +if [ $any_failure -ne 0 ]; then
> >> +    echo "# Failed on random killing, at least one test fails."
> >> +    clean_up
> >> +    exit 1
> >> +fi
> >> +echo "# PASSED LARGER limit test with a process randomly killed."
> >> +
> >> +MEM_LIMIT_TOO_SMALL=3D$((CAPACITY - 2 * LARGE))
> >> +
> >> +echo "$MEM_LIMIT_TOO_SMALL" > $CG_ROOT/$TEST_CG_SUB2/memory.max
> >> +if [ $? -ne 0 ]; then
> >> +    echo "# Failed creating memory controller."
> >> +    clean_up
> >> +    exit 1
> >> +fi
> >> +
> >> +echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with=
 =20
> >> LARGE EPC limit,
> >> +        and too small RAM limit, expecting all failures...."
> >> +# Ensure swapping off so the OOM killer is activated when mem_cgroup =
=20
> >> limit is hit.
> >> +swapoff -a
> >> +pids=3D""
> >> +for i in 1 2 3 4; do
> >> +    (
> >> +        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd =20
> >> >cgtest_large_oom_$timestamp.$i.log 2>&1
> >> +    ) &
> >> +    pids=3D"$pids $!"
> >> +done
> >> +
> >> +if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
> >> +    echo "# Failed on tests with memcontrol, some tests did not fail.=
"
> >> +    clean_up
> >> +    swapon -a
> >> +    exit 1
> >> +else
> >> +    swapon -a
> >> +    echo "# PASSED LARGE limit tests with memcontrol."
> >> +fi
> >> +
> >> +sleep 2
> >> +
> >> +USAGE=3D$(grep '^sgx_epc' "$CG_ROOT/$TEST_ROOT_CG/misc.current" | awk=
 =20
> >> '{print $2}')
> >> +if [ "$USAGE" -ne 0 ]; then
> >> +    echo "# Failed: Final usage is $USAGE, not 0."
> >> +else
> >> +    echo "# PASSED leakage check."
> >> +    echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
> >> +fi
> >> +clean_up
> >> +echo "# done."
> >> diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh =20
> >> b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >> new file mode 100755
> >> index 000000000000..1c9985726ace
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >> @@ -0,0 +1,11 @@
> >> +#!/usr/bin/env sh
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright(c) 2023, 2024 Intel Corporation.
> >> +
> >> +if [ -z "$1" ]; then
> >> +    echo "No argument supplied, please provide 'max', 'current', or =
=20
> >> 'events'"
> >> +    exit 1
> >> +fi
> >> +
> >> +watch -n 1 'find /sys/fs/cgroup -wholename "*/test*/misc.'$1'" -exec =
\
> >> +    sh -c '\''echo "$1:"; cat "$1"'\'' _ {} \;'
> >
> > So this is what happens now:
> >
> > jarkko@mustatorvisieni:~/linux-tpmdd> make -C =20
> > tools/testing/selftests/sgx run_tests
> > make: Entering directory =20
> > '/home/jarkko/linux-tpmdd/tools/testing/selftests/sgx'
> > TAP version 13
> > 1..1
> > # timeout set to 45
> > # selftests: sgx: test_sgx
> > # TAP version 13
> > # 1..16
> > # # Starting 16 tests from 1 test cases.
> > # #  RUN           enclave.unclobbered_vdso ...
> > # #            OK  enclave.unclobbered_vdso
> > # ok 1 enclave.unclobbered_vdso
> > # #  RUN           enclave.unclobbered_vdso_oversubscribed ...
> > # #            OK  enclave.unclobbered_vdso_oversubscribed
> > # ok 2 enclave.unclobbered_vdso_oversubscribed
> > # #  RUN           enclave.unclobbered_vdso_oversubscribed_remove ...
> > # # main.c:402:unclobbered_vdso_oversubscribed_remove:Creating an =20
> > enclave with 98566144 bytes heap may take a while ...
> > # # main.c:457:unclobbered_vdso_oversubscribed_remove:Changing type of =
=20
> > 98566144 bytes to trimmed may take a while ...
> > # # main.c:473:unclobbered_vdso_oversubscribed_remove:Entering enclave =
=20
> > to run EACCEPT for each page of 98566144 bytes may take a while ...
> > # # main.c:494:unclobbered_vdso_oversubscribed_remove:Removing 98566144=
 =20
> > bytes from enclave may take a while ...
> > # #            OK  enclave.unclobbered_vdso_oversubscribed_remove
> > # ok 3 enclave.unclobbered_vdso_oversubscribed_remove
> > # #  RUN           enclave.clobbered_vdso ...
> > # #            OK  enclave.clobbered_vdso
> > # ok 4 enclave.clobbered_vdso
> > # #  RUN           enclave.clobbered_vdso_and_user_function ...
> > # #            OK  enclave.clobbered_vdso_and_user_function
> > # ok 5 enclave.clobbered_vdso_and_user_function
> > # #  RUN           enclave.tcs_entry ...
> > # #            OK  enclave.tcs_entry
> > # ok 6 enclave.tcs_entry
> > # #  RUN           enclave.pte_permissions ...
> > # #            OK  enclave.pte_permissions
> > # ok 7 enclave.pte_permissions
> > # #  RUN           enclave.tcs_permissions ...
> > # #            OK  enclave.tcs_permissions
> > # ok 8 enclave.tcs_permissions
> > # #  RUN           enclave.epcm_permissions ...
> > # #            OK  enclave.epcm_permissions
> > # ok 9 enclave.epcm_permissions
> > # #  RUN           enclave.augment ...
> > # #            OK  enclave.augment
> > # ok 10 enclave.augment
> > # #  RUN           enclave.augment_via_eaccept ...
> > # #            OK  enclave.augment_via_eaccept
> > # ok 11 enclave.augment_via_eaccept
> > # #  RUN           enclave.tcs_create ...
> > # #            OK  enclave.tcs_create
> > # ok 12 enclave.tcs_create
> > # #  RUN           enclave.remove_added_page_no_eaccept ...
> > # #            OK  enclave.remove_added_page_no_eaccept
> > # ok 13 enclave.remove_added_page_no_eaccept
> > # #  RUN           enclave.remove_added_page_invalid_access ...
> > # #            OK  enclave.remove_added_page_invalid_access
> > # ok 14 enclave.remove_added_page_invalid_access
> > # #  RUN           =20
> > enclave.remove_added_page_invalid_access_after_eaccept ...
> > # #            OK  enclave.remove_added_page_invalid_access_after_eacce=
pt
> > # ok 15 enclave.remove_added_page_invalid_access_after_eaccept
> > # #  RUN           enclave.remove_untouched_page ...
> > # #            OK  enclave.remove_untouched_page
> > # ok 16 enclave.remove_untouched_page
> > # # PASSED: 16 / 16 tests passed.
> > # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:0 error:0
> > ok 1 selftests: sgx: test_sgx
> >
> > Also cgroups tests are expected to run when invoking "run_tests".
> >
> I can add the SGX cgroup tests to the "run_tests" target. But it will nee=
d =20
> more than the 45secs given by the default timeout especially on platforms=
 =20
> with larger EPC. You will need run with --override-timeout
> (current SGX selftests also timeout for default 45 sec on a server with 4=
G =20
> EPC).
>
>
> > I also wonder do we really want this:
> >
> > diff --git a/config/x86_64/default b/config/x86_64/default
> > index 246b1f3df46..6c3d20af7b4 100644
> > --- a/config/x86_64/default
> > +++ b/config/x86_64/default
> > @@ -502,6 +502,7 @@ CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
> >  # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> >  # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> >  CONFIG_X86_SGX=3Dy
> > +CONFIG_CGROUP_SGX_EPC=3Dy
> >  # CONFIG_X86_USER_SHADOW_STACK is not set
> >  CONFIG_EFI=3Dy
> >  CONFIG_EFI_STUB=3Dy
> >
> > It is a small change but affects all of downstream, not just OpenSUSE.
> >
> > I hard time projecting a situation where you wanted SGX but without
> > cgroups support so perhaps it would be a better idea to enable cgroups
> > unconditionally when SGX and cgroups are part of the kernel config?
> >
> > Then downstream can just pick the patches and call it a day...
> >
> > BR, Jarkko
> >
>
> I don't have issue to remove this config and conditionally compile in SGX=
 =20
> cgroup implementation when MISC is configured.

I did run the basic test by manually creating the cgroup so you could
add tested-by from my side to the other kernel patches expect this one
:-)

I've reviewed it enough rounds and given various code suggestions etc.
For me it is "good enough" or has been for a while. I just want this
test to work so that people doing kernel QA will automatically get it
to their testing cycle. That is why proper integration to kselftest
framework is a must.

BR, Jarkko

