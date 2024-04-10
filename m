Return-Path: <cgroups+bounces-2430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638F89FFC9
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FD6B29FE4
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199A18410B;
	Wed, 10 Apr 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMtSmFEW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04680181CFE;
	Wed, 10 Apr 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773570; cv=none; b=u2DDtngOpohfcItyAd9ch9NQZL0X60Kejbrrt0D6OevDjlD5N+p3O6lua6zp7w88U/xR/PdKYURTmxxl+36HGt3KE47J5irVDEOuFtIsXkdAqzsCExhVxgriVrZ3+i+dL97NXX2XHSBrtiiWK5KfzaI4Aip1zzLUf1obCu7dRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773570; c=relaxed/simple;
	bh=tcQaHd7p+lQvAxec5L8/nLphd4OBjFrDcxkNFSyGAqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtM9mEwQZqjztGd6MDWdOv3HQL32BkuZ9QjnI58HBvwE1t/1ZGlmF8BCFcjDBJaPjVFAqV2jAOWssMAu4nHWhZax9bNaEWBQrkQG5tw1Gxrxd62heEmaROo3t4wTqY8CtT/7EYJc4IMWf+Jjg2IpyxNuYDSv7CRVzJQNRVYfUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMtSmFEW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712773568; x=1744309568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tcQaHd7p+lQvAxec5L8/nLphd4OBjFrDcxkNFSyGAqc=;
  b=HMtSmFEWL/vQKGk9WWPPLPyXpKzKpaOZ0UVTesHJXafdtg+JuT0ChvDF
   EHPYQtujpUVQ0VzDQyoE7H3W94bt+oLmRFnu2Fgb+IaaDv1eWCWEj8nWC
   +h3BmpVN5F85B25ps9KDg5JKNJKqdfZcbcgRe5oG5B4aDHxWom/4aPUbA
   fpzdRZWL5VZsyAonrHzwK1wr+l5qyVB9W9MkgFDpaGtaXRS9DsOfsZO96
   T6cg1kVx6ndoVhb7BQhBocdW618gFiM6EtHoAGUKuVoF2dqHadzj+JWku
   iara/4gbJ2NWSY8J/pJ5Mxqykt9ZXPkB/372RFBPfq2dAjA9vccPB5NuA
   w==;
X-CSE-ConnectionGUID: w86HCyFnS7egCGhKBHgPvQ==
X-CSE-MsgGUID: pW9s/Nv/Sr6lly5rvZEU7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19583769"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19583769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:26:02 -0700
X-CSE-ConnectionGUID: xy9MzLrBSqKWsqQ1KtRhQg==
X-CSE-MsgGUID: mS4+ZIPDS2W9+eI8dXm7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21232459"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 11:26:01 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v11 14/14] selftests/sgx: Add scripts for EPC cgroup testing
Date: Wed, 10 Apr 2024 11:25:58 -0700
Message-Id: <20240410182558.41467-15-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410182558.41467-1-haitao.huang@linux.intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To run selftests for EPC cgroup:

sudo ./run_epc_cg_selftests.sh

To watch misc cgroup 'current' changes during testing, run this in a
separate terminal:

./watch_misc_for_tests.sh current

With different cgroups, the script starts one or multiple concurrent SGX
selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
test case, which loads an enclave of EPC size equal to the EPC capacity
available on the platform. The script checks results against the
expectation set for each cgroup and reports success or failure.

The script creates 3 different cgroups at the beginning with following
expectations:

1) SMALL - intentionally small enough to fail the test loading an
enclave of size equal to the capacity.
2) LARGE - large enough to run up to 4 concurrent tests but fail some if
more than 4 concurrent tests are run. The script starts 4 expecting at
least one test to pass, and then starts 5 expecting at least one test
to fail.
3) LARGER - limit is the same as the capacity, large enough to run lots of
concurrent tests. The script starts 8 of them and expects all pass.
Then it reruns the same test with one process randomly killed and
usage checked to be zero after all processes exit.

The script also includes a test with low mem_cg limit and LARGE sgx_epc
limit to verify that the RAM used for per-cgroup reclamation is charged
to a proper mem_cg. For this test, it turns off swapping before start,
and turns swapping back on afterwards.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V11:
- Remove cgroups-tools dependency and make scripts ash compatible. (Jarkko)
- Drop support for cgroup v1 and simplify. (Michal, Jarkko)
- Add documentation for functions. (Jarkko)
- Turn off swapping before memcontrol tests and back on after
- Format and style fixes, name for hard coded values

V7:
- Added memcontrol test.

V5:
- Added script with automatic results checking, remove the interactive
script.
- The script can run independent from the series below.
---
 tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
 .../selftests/sgx/run_epc_cg_selftests.sh     | 275 ++++++++++++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
 3 files changed, 302 insertions(+)
 create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh b/tools/testing/selftests/sgx/ash_cgexec.sh
new file mode 100755
index 000000000000..cfa5d2b0e795
--- /dev/null
+++ b/tools/testing/selftests/sgx/ash_cgexec.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2024 Intel Corporation.
+
+# Start a program in a given cgroup.
+# Supports V2 cgroup paths, relative to /sys/fs/cgroup
+if [ "$#" -lt 2 ]; then
+    echo "Usage: $0 <v2 cgroup path> <command> [args...]"
+    exit 1
+fi
+# Move this shell to the cgroup.
+echo 0 >/sys/fs/cgroup/$1/cgroup.procs
+shift
+# Execute the command within the cgroup
+exec "$@"
+
diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
new file mode 100755
index 000000000000..dd56273056fc
--- /dev/null
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -0,0 +1,275 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023, 2024 Intel Corporation.
+
+TEST_ROOT_CG=selftest
+TEST_CG_SUB1=$TEST_ROOT_CG/test1
+TEST_CG_SUB2=$TEST_ROOT_CG/test2
+# We will only set limit in test1 and run tests in test3
+TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
+TEST_CG_SUB4=$TEST_ROOT_CG/test4
+
+# Cgroup v2 only
+CG_ROOT=/sys/fs/cgroup
+mkdir -p $CG_ROOT/$TEST_CG_SUB1
+mkdir -p $CG_ROOT/$TEST_CG_SUB2
+mkdir -p $CG_ROOT/$TEST_CG_SUB3
+mkdir -p $CG_ROOT/$TEST_CG_SUB4
+
+# Turn on misc and memory controller in non-leaf nodes
+echo "+misc" >  $CG_ROOT/cgroup.subtree_control && \
+echo "+memory" > $CG_ROOT/cgroup.subtree_control && \
+echo "+misc" >  $CG_ROOT/$TEST_ROOT_CG/cgroup.subtree_control && \
+echo "+memory" > $CG_ROOT/$TEST_ROOT_CG/cgroup.subtree_control && \
+echo "+misc" >  $CG_ROOT/$TEST_CG_SUB1/cgroup.subtree_control
+if [ $? -ne 0 ]; then
+    echo "# Failed setting up cgroups, make sure misc and memory cgroups are enabled."
+    exit 1
+fi
+
+CAPACITY=$(grep "sgx_epc" "$CG_ROOT/misc.capacity" | awk '{print $2}')
+# This is below number of VA pages needed for enclave of capacity size. So
+# should fail oversubscribed cases
+SMALL=$(( CAPACITY / 512 ))
+
+# At least load one enclave of capacity size successfully, maybe up to 4.
+# But some may fail if we run more than 4 concurrent enclaves of capacity size.
+LARGE=$(( SMALL * 4 ))
+
+# Load lots of enclaves
+LARGER=$CAPACITY
+echo "# Setting up limits."
+echo "sgx_epc $SMALL" > $CG_ROOT/$TEST_CG_SUB1/misc.max && \
+echo "sgx_epc $LARGE" >  $CG_ROOT/$TEST_CG_SUB2/misc.max && \
+echo "sgx_epc $LARGER" > $CG_ROOT/$TEST_CG_SUB4/misc.max
+if [ $? -ne 0 ]; then
+    echo "# Failed setting up misc limits."
+    exit 1
+fi
+
+clean_up()
+{
+    sleep 2
+    rmdir $CG_ROOT/$TEST_CG_SUB2
+    rmdir $CG_ROOT/$TEST_CG_SUB3
+    rmdir $CG_ROOT/$TEST_CG_SUB4
+    rmdir $CG_ROOT/$TEST_CG_SUB1
+    rmdir $CG_ROOT/$TEST_ROOT_CG
+}
+
+timestamp=$(date +%Y%m%d_%H%M%S)
+
+test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
+
+PROCESS_SUCCESS=1
+PROCESS_FAILURE=0
+
+# Wait for a process and check for expected exit status.
+#
+# Arguments:
+#	$1 - the pid of the process to wait and check.
+#	$2 - 1 if expecting success, 0 for failure.
+#
+# Return:
+#	0 if the exit status of the process matches the expectation.
+#	1 otherwise.
+wait_check_process_status() {
+    pid=$1
+    check_for_success=$2
+
+    wait "$pid"
+    status=$?
+
+    if [ $check_for_success -eq $PROCESS_SUCCESS ] && [ $status -eq 0 ]; then
+        echo "# Process $pid succeeded."
+        return 0
+    elif [ $check_for_success -eq $PROCESS_FAILURE ] && [ $status -ne 0 ]; then
+        echo "# Process $pid returned failure."
+        return 0
+    fi
+    return 1
+}
+
+# Wait for a set of processes and check for expected exit status
+#
+# Arguments:
+#	$1 - 1 if expecting success, 0 for failure.
+#	remaining args - The pids of the processes
+#
+# Return:
+#	0 if exit status of any process matches the expectation.
+#	1 otherwise.
+wait_and_detect_for_any() {
+    check_for_success=$1
+
+    shift
+    detected=1 # 0 for success detection
+
+    for pid in $@; do
+        if wait_check_process_status "$pid" "$check_for_success"; then
+            detected=0
+            # Wait for other processes to exit
+        fi
+    done
+
+    return $detected
+}
+
+echo "# Start unclobbered_vdso_oversubscribed with SMALL limit, expecting failure..."
+# Always use leaf node of misc cgroups
+# these may fail on OOM
+./ash_cgexec.sh $TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
+if [ $? -eq 0 ]; then
+    echo "# Fail on SMALL limit, not expecting any test passes."
+    clean_up
+    exit 1
+else
+    echo "# Test failed as expected."
+fi
+
+echo "# PASSED SMALL limit."
+
+echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
+        expecting at least one success...."
+
+pids=""
+for i in 1 2 3 4; do
+    (
+        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+
+if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
+    echo "# PASSED LARGE limit positive testing."
+else
+    echo "# Failed on LARGE limit positive testing, no test passes."
+    clean_up
+    exit 1
+fi
+
+echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
+        expecting at least one failure...."
+pids=""
+for i in 1 2 3 4 5; do
+    (
+        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$timestamp.$i.log 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
+    echo "# PASSED LARGE limit negative testing."
+else
+    echo "# Failed on LARGE limit negative testing, no test fails."
+    clean_up
+    exit 1
+fi
+
+echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
+        expecting no failure...."
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
+    (
+        ./ash_cgexec.sh $TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
+    echo "# Failed on LARGER limit, at least one test fails."
+    clean_up
+    exit 1
+else
+    echo "# PASSED LARGER limit tests."
+fi
+
+echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
+      randomly kill one, expecting no failure...."
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
+    (
+        ./ash_cgexec.sh $TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$timestamp.$i.log 2>&1
+    ) &
+    pids="$pids $!"
+done
+random_number=$(awk 'BEGIN{srand();print int(rand()*5)}')
+sleep $((random_number + 1))
+
+# Randomly select a process to kill
+# Make sure usage counter not leaked at the end.
+RANDOM_INDEX=$(awk 'BEGIN{srand();print int(rand()*8)}')
+counter=0
+for pid in $pids; do
+    if [ "$counter" -eq "$RANDOM_INDEX" ]; then
+        PID_TO_KILL=$pid
+        break
+    fi
+    counter=$((counter + 1))
+done
+
+kill $PID_TO_KILL
+echo "# Killed process with PID: $PID_TO_KILL"
+
+any_failure=0
+for pid in $pids; do
+    wait "$pid"
+    status=$?
+    if [ "$pid" != "$PID_TO_KILL" ]; then
+        if [ $status -ne 0 ]; then
+	    echo "# Process $pid returned failure."
+            any_failure=1
+        fi
+    fi
+done
+
+if [ $any_failure -ne 0 ]; then
+    echo "# Failed on random killing, at least one test fails."
+    clean_up
+    exit 1
+fi
+echo "# PASSED LARGER limit test with a process randomly killed."
+
+MEM_LIMIT_TOO_SMALL=$((CAPACITY - 2 * LARGE))
+
+echo "$MEM_LIMIT_TOO_SMALL" > $CG_ROOT/$TEST_CG_SUB2/memory.max
+if [ $? -ne 0 ]; then
+    echo "# Failed creating memory controller."
+    clean_up
+    exit 1
+fi
+
+echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE EPC limit,
+        and too small RAM limit, expecting all failures...."
+# Ensure swapping off so the OOM killer is activated when mem_cgroup limit is hit.
+swapoff -a
+pids=""
+for i in 1 2 3 4; do
+    (
+        ./ash_cgexec.sh $TEST_CG_SUB2 $test_cmd >cgtest_large_oom_$timestamp.$i.log 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
+    echo "# Failed on tests with memcontrol, some tests did not fail."
+    clean_up
+    swapon -a
+    exit 1
+else
+    swapon -a
+    echo "# PASSED LARGE limit tests with memcontrol."
+fi
+
+sleep 2
+
+USAGE=$(grep '^sgx_epc' "$CG_ROOT/$TEST_ROOT_CG/misc.current" | awk '{print $2}')
+if [ "$USAGE" -ne 0 ]; then
+    echo "# Failed: Final usage is $USAGE, not 0."
+else
+    echo "# PASSED leakage check."
+    echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
+fi
+clean_up
+echo "# done."
diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
new file mode 100755
index 000000000000..1c9985726ace
--- /dev/null
+++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
@@ -0,0 +1,11 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023, 2024 Intel Corporation.
+
+if [ -z "$1" ]; then
+    echo "No argument supplied, please provide 'max', 'current', or 'events'"
+    exit 1
+fi
+
+watch -n 1 'find /sys/fs/cgroup -wholename "*/test*/misc.'$1'" -exec \
+    sh -c '\''echo "$1:"; cat "$1"'\'' _ {} \;'
-- 
2.25.1


