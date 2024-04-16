Return-Path: <cgroups+bounces-2508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214998A619F
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD92628528A
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603B13A87E;
	Tue, 16 Apr 2024 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9Kcb363"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16951804A;
	Tue, 16 Apr 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237625; cv=none; b=t0fP4k024ZlT2v955OnxSMMJ8YPiU4pQofeP0dQR9SCFh2DVqWAzAKrlqjyhxcHTWtxpibRHSjpgh4xoy5aOaNOA5Pn0K0xGzM7qJjgs/XQF5Q47A/xSakKCNY09qcpoaP0IKfibTPBfjtB5xtTutvhKbWAV/FRqj735exiCFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237625; c=relaxed/simple;
	bh=THbPGe15T0OMednZ5XsV7dKHfBATK+o43QwLQbXYXuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHGX6ZDjYG5VDEvdTpfyMOscaE18IA+a+VN01eu2Rxuhg6LEmmL2jx8TM6cnxUCTXdkliSkcI+hKI+v/nlQuMOY75J7Q1fBwj6v4UA0kqyuj0S+jnMYeUFkHYJY9KuyYBOCodWKrmLQFbZ1KuWC+8rn64tCVTYkH/bz52c3T+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9Kcb363; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237623; x=1744773623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THbPGe15T0OMednZ5XsV7dKHfBATK+o43QwLQbXYXuo=;
  b=e9Kcb363JWh6aDst1Oi3HkZFab7hBd1dT/ZTELEXbQ1e7Z16hOyAzZ+D
   nve4IaIpx86ewAsGdFjSAm7XdsTF0TqzhQ932428HDg65+Z16xcOi0twU
   rz122HYXLBp9wGfN3cFsULJxrCDDcvoQr546yj8B7PplSxClScfJRedhE
   6XqTeRwPdbstxfmVwBR47Hog80OOPCn/nvzc/uXJ4x+5inAVBTSSgI3mR
   xMnOCH92rb5ipoosQhhgKVT3nB81nNo/mre3YzRo49eYoj3ArKHJlmzbz
   HNmqbJ01Q2WdM97W3gO6FmlzMMi160mH7h0Yf4Rw5h4qrTjSR8uEaTFDN
   Q==;
X-CSE-ConnectionGUID: hB/LUEGnScKdUUFC6+sLyw==
X-CSE-MsgGUID: 2rWZBa8mQz++27sZrwsRVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34043448"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="34043448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:20:21 -0700
X-CSE-ConnectionGUID: C9mWQyt7S8ytXAZSmJKdXg==
X-CSE-MsgGUID: rdTadTX2RHuOJ6KxTkWXcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22193674"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 20:20:20 -0700
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
Subject: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup testing
Date: Mon, 15 Apr 2024 20:20:11 -0700
Message-Id: <20240416032011.58578-15-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416032011.58578-1-haitao.huang@linux.intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Add README to document how to run the tests.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V12:
- Integrate the scripts to the "run_tests" target. (Jarkko)

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
 tools/testing/selftests/sgx/Makefile          |   3 +-
 tools/testing/selftests/sgx/README            | 116 +++++++
 tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
 .../selftests/sgx/run_epc_cg_selftests.sh     | 283 ++++++++++++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
 5 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sgx/README
 create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..739376af9e33 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -20,7 +20,8 @@ ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 
 ifeq ($(CAN_BUILD_X86_64), 1)
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
-TEST_FILES := $(OUTPUT)/test_encl.elf
+TEST_FILES := $(OUTPUT)/test_encl.elf ash_cgexec.sh
+TEST_PROGS := run_epc_cg_selftests.sh
 
 all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
 endif
diff --git a/tools/testing/selftests/sgx/README b/tools/testing/selftests/sgx/README
new file mode 100644
index 000000000000..dfc0c74ce99d
--- /dev/null
+++ b/tools/testing/selftests/sgx/README
@@ -0,0 +1,116 @@
+SGX selftests
+
+The SGX selftests includes a c program (test_sgx) that covers basic user space
+facing APIs and a shell scripts (run_sgx_cg_selftests.sh) testing SGX misc
+cgroup. The SGX cgroup test script requires root privileges and runs a
+specific test case of  the test_sgx in different cgroups configured by the
+script. More details about the cgroup test can be found below.
+
+All SGX selftests can run with or without kselftest framework.
+
+WITH KSELFTEST FRAMEWORK
+=======================
+
+BUILD
+-----
+
+Build executable file "test_sgx" from top level directory of the kernel source:
+ $ make -C tools/testing/selftests TARGETS=sgx
+
+RUN
+---
+
+Run all sgx tests as sudo or root since the cgroup tests need to configure cgroup
+limits in files under /sys/fs/cgroup.
+
+ $ sudo make -C tools/testing/selftests/sgx run_tests
+
+Without sudo, SGX cgroup tests will be skipped.
+
+On platforms with large Enclave Page Cache (EPC) and/or less cpu cores, the
+tests may need run longer than default timeout of 45 seconds. To avoid
+timeouts, set a value for kselftest_override_timeout for the make command:
+
+ $ sudo kselftest_override_timeout=165 make -C tools/testing/selftests/sgx run_tests
+
+Or use --override-timeout option if running the installed kselftests from the
+installation root directory:
+
+  $sudo ./run_kselftest.sh --override-timeout 165 -c sgx
+
+More details about kselftest framework can be found in
+Documentation/dev-tools/kselftest.rst.
+
+WITHOUT KSELFTEST FRAMEWORK
+===========================
+
+BUILD
+-----
+
+Build executable file "test_sgx" from this
+directory(tools/testing/selftests/sgx/):
+
+  $ make
+
+RUN
+---
+
+Run all non-cgroup tests:
+
+ $ ./test_sgx
+
+To test SGX cgroup:
+
+ $ sudo ./run_sgx_cg_selftests.sh
+
+THE SGX CGROUP TEST SCRIPTS
+===========================
+
+Overview of the main cgroup test script
+---------------------------------------
+
+With different cgroups, the script (run_sgx_cg_selftests.sh)  starts one or
+multiple concurrent SGX selftests (test_sgx), each to run the
+unclobbered_vdso_oversubscribed test case, which loads an enclave of EPC size
+equal to the EPC capacity available on the platform. The script checks results
+against the expectation set for each cgroup and reports success or failure.
+
+The script creates 3 different cgroups at the beginning with following
+expectations:
+
+  1) SMALL - intentionally small enough to fail the test loading an enclave of
+             size equal to the capacity.
+
+  2) LARGE - large enough to run up to 4 concurrent tests but fail some if more
+	     than 4 concurrent tests are run. The script starts 4 expecting at
+	     least one test to pass, and then starts 5 expecting at least one
+             test to fail.
+
+  3) LARGER - limit is the same as the capacity, large enough to run lots of
+	      concurrent tests. The script starts 8 of them and expects all
+	      pass.  Then it reruns the same test with one process randomly
+	      killed and usage checked to be zero after all processes exit.
+
+The script also includes a test with low mem_cg limit (memory.max) and LARGE
+sgx_epc limit to verify that the RAM used for per-cgroup reclamation is charged
+to a proper mem_cg. To validate mem_cg OOM-kills processes when its memory.max
+limit is reached due to SGX EPC reclamation, the script turns off swapping
+before start, and turns swapping back on afterwards for this particular test.
+
+The helper scripts for monitoring and trouble-shooting
+------------------------------------------------------
+
+For developer/tester to monitor the SGX cgroup settings and behavior or
+trouble-shoot any issues encountered during testing, a helper script,
+watch_misc_for_tests.sh, is provided, which can watch relevant entries in
+cgroupfs files. For example, to watch the SGX cgroup 'current' counter changes
+during testing, run this in a separate terminal from this directory:
+
+  $ ./watch_misc_for_tests.sh current
+
+For more details about SGX cgroups, see "Cgroup Support" in
+Documentation/arch/x86/sgx.rst.
+
+The scripts require cgroup v2 support. More details about cgroup v2 can be found
+in Documentation/admin-guide/cgroup-v2.rst.
+
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
index 000000000000..cd2911e865f0
--- /dev/null
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -0,0 +1,283 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023, 2024 Intel Corporation.
+
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+if [ "$(id -u)" -ne 0 ]; then
+    echo "SKIP: SGX Cgroup tests need root privileges."
+    exit $ksft_skip
+fi
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


