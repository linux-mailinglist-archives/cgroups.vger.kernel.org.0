Return-Path: <cgroups+bounces-4638-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E767A96672F
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2B12836EC
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B91BDABC;
	Fri, 30 Aug 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7pEPqEZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF81BD004;
	Fri, 30 Aug 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036102; cv=none; b=TDQnSMjvIeca3rZh5AOLKQXWhwrNkAELzQj9I1tmRngW7xVDlBkzxdmqNr0UBxy4+eDyhD09yANmkeoWA2c+eubBFXETPvvNXLCOGNOXvYa0NabESPRI89knZv3yJ3kcNwfNWRE0ArFcQTch/krjEDpRiMchPkBwIuQ/ooTbV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036102; c=relaxed/simple;
	bh=RmM+XSvPBk5DaUpLqbo3+g0JbIk2NZO23NlBJalmJ2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJtXUegSWVZdMK9CauoKtq4OppZqeF7x2brb63yjlRirpqeq9ORrGDZvFKtIK+SHFEI5ri9i9U6Rv5I8xi0EMu5unugWT0cg15fBdsJVkSB10jM/waQIJBRKPL8w8HeWPHd3Pq6uv+7WDK4aWTZ5G0SJaTXd1J7akN4cuwGMpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7pEPqEZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036100; x=1756572100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RmM+XSvPBk5DaUpLqbo3+g0JbIk2NZO23NlBJalmJ2Y=;
  b=e7pEPqEZdNWQnPqO5Ql1knCXz+aoDMzMwVS/HlHgnPXZkZHSqZWCF4q5
   AwptO8t5r7a6K2Je6LJkhHo7KxcGRAtiTTLa082MFbZQs0SUcghz2o59v
   iJp0hnrWZov8TSwawFpz28NH8nt+SJhO+MIc6JcHnMcJW4Wjl2JnicvUY
   DnPXy7847Fm3sS8uEVr2bvg1S3CLw4KpxgvVxjgfMCJ88Vn14lW6t1YKJ
   Er0lKPFsHMhLGqwEdlp7MXXVCl14NFv90okk+rRwz2HSbUX8xDJuydoy3
   lGnKoSscwZVkedWuzql1KYqCZejr0d7z3s0VRSE8xAB29kywPoXEqMclh
   g==;
X-CSE-ConnectionGUID: zJ8Ah4A6R2GB0U3FTOtXtg==
X-CSE-MsgGUID: rbrX1TkJRKWdxW9w3wBs9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300051"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300051"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:53 -0700
X-CSE-ConnectionGUID: JBxFfYYYSOCfPigogfhCJA==
X-CSE-MsgGUID: Phdp5+M4QQOXFjzCq4uSqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440500"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:53 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
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
Subject: [PATCH v17 16/16] selftests/sgx: Add scripts for EPC cgroup testing
Date: Fri, 30 Aug 2024 09:40:37 -0700
Message-ID: <20240830164038.39343-17-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830164038.39343-1-haitao.huang@linux.intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
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

1) small - intentionally small enough to fail the test loading an
enclave of size equal to the capacity.
2) large - large enough to run up to 4 concurrent tests but fail some if
more than 4 concurrent tests are run. The script starts 4 expecting at
least one test to pass, and then starts 5 expecting at least one test
to fail.
3) larger - limit is the same as the capacity, large enough to run lots of
concurrent tests. The script starts 8 of them and expects all pass.
Then it reruns the same test with one process randomly killed and
usage checked to be zero after all processes exit.

The script also includes a test with low mem_cg limit and large sgx_epc
limit to verify that the RAM used for per-cgroup reclamation is charged
to a proper mem_cg. For this test, it turns off swapping before start,
and turns swapping back on afterwards.

Add README to document how to run the tests.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
---
V13:
- More improvement on handling error cases and style fixes.
- Add settings file for custom timeout

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
 tools/testing/selftests/sgx/README            | 109 +++++++
 tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
 tools/testing/selftests/sgx/config            |   4 +
 .../selftests/sgx/run_epc_cg_selftests.sh     | 294 ++++++++++++++++++
 tools/testing/selftests/sgx/settings          |   2 +
 .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
 7 files changed, 438 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sgx/README
 create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
 create mode 100644 tools/testing/selftests/sgx/config
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100644 tools/testing/selftests/sgx/settings
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 03b5e13b872b..3e673b8ace3f 100644
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
index 000000000000..f84406bf29a4
--- /dev/null
+++ b/tools/testing/selftests/sgx/README
@@ -0,0 +1,109 @@
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
+On platforms with large Enclave Page Cache (EPC) and/or less cpu cores, you may
+need adjust the timeout in 'settings' to avoid timeouts.
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
+With different cgroups, the script (run_sgx_cg_selftests.sh) starts one or
+multiple concurrent SGX selftests (test_sgx), each to run the
+unclobbered_vdso_oversubscribed test case, which loads an enclave of EPC size
+equal to the EPC capacity available on the platform. The script checks results
+against the expectation set for each cgroup and reports success or failure.
+
+The script creates 3 different cgroups at the beginning with following
+expectations:
+
+  1) small - intentionally small enough to fail the test loading an enclave of
+             size equal to the capacity.
+
+  2) large - large enough to run up to 4 concurrent tests but fail some if more
+	     than 4 concurrent tests are run. The script starts 4 expecting at
+	     least one test to pass, and then starts 5 expecting at least one
+             test to fail.
+
+  3) larger - limit is the same as the capacity, large enough to run lots of
+	      concurrent tests. The script starts 8 of them and expects all
+	      pass.  Then it reruns the same test with one process randomly
+	      killed and usage checked to be zero after all processes exit.
+
+The script also includes a test with low mem_cg limit (memory.max) and the
+'large' sgx_epc limit to verify that the RAM used for per-cgroup reclamation is
+charged to a proper mem_cg. To validate mem_cg OOM-kills processes when its
+memory.max limit is reached due to SGX EPC reclamation, the script turns off
+swapping before start, and turns swapping back on afterwards for this particular
+test.
+
+The helper script
+------------------------------------------------------
+
+To monitor the SGX cgroup settings and behaviors or trouble-shoot during
+testing, the helper script, watch_misc_for_tests.sh, can be used to watch
+relevant entries in cgroupfs files. For example, to watch the SGX cgroup
+'current' counter changes during testing, run this in a separate terminal from
+this directory:
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
diff --git a/tools/testing/selftests/sgx/config b/tools/testing/selftests/sgx/config
new file mode 100644
index 000000000000..e7f1db1d3eff
--- /dev/null
+++ b/tools/testing/selftests/sgx/config
@@ -0,0 +1,4 @@
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_MISC=y
+CONFIG_MEMCG=y
+CONFIG_X86_SGX=y
diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
new file mode 100755
index 000000000000..dab648e0bb53
--- /dev/null
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -0,0 +1,294 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023, 2024 Intel Corporation.
+
+PROCESS_SUCCESS=1
+PROCESS_FAILURE=0
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
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+if [ "$(id -u)" -ne 0 ]; then
+    echo "SKIP: SGX cgroup tests need root privileges."
+    exit $ksft_skip
+fi
+
+cg_root=/sys/fs/cgroup
+if [ ! -d "$cg_root/$test_root_cg" ]; then
+    echo "SKIP: SGX cgroup tests require v2 cgroups."
+    exit $ksft_skip
+fi
+test_root_cg=sgx_kselftest
+#make sure we start clean
+if [ -d "$cg_root/$test_root_cg" ]; then
+    echo "SKIP: Please clean up $cg_root/$test_root_cg."
+    exit $ksft_skip
+fi
+
+test_cg_small_parent=$test_root_cg/sgx_test_small_parent
+test_cg_large=$test_root_cg/sgx_test_large
+test_cg_small=$test_cg_small_parent/sgx_test_small
+test_cg_larger=$test_root_cg/sgx_test_larger
+
+clean_up()
+{
+    # Wait a little for cgroups to reset counters for dead processes.
+    sleep 2
+    rmdir $cg_root/$test_cg_large
+    rmdir $cg_root/$test_cg_small
+    rmdir $cg_root/$test_cg_larger
+    rmdir $cg_root/$test_cg_small_parent
+    rmdir $cg_root/$test_root_cg
+}
+
+mkdir $cg_root/$test_root_cg && \
+mkdir $cg_root/$test_cg_small_parent && \
+mkdir $cg_root/$test_cg_large && \
+mkdir $cg_root/$test_cg_small && \
+mkdir $cg_root/$test_cg_larger
+if [ $? -ne 0 ]; then
+    echo "FAIL: Failed creating cgroups."
+    exit 1
+fi
+
+# Turn on misc and memory controller in non-leaf nodes
+echo "+misc" >  $cg_root/cgroup.subtree_control && \
+echo "+memory" > $cg_root/cgroup.subtree_control && \
+echo "+misc" >  $cg_root/$test_root_cg/cgroup.subtree_control && \
+echo "+memory" > $cg_root/$test_root_cg/cgroup.subtree_control && \
+echo "+misc" >  $cg_root/$test_cg_small_parent/cgroup.subtree_control
+if [ $? -ne 0 ]; then
+    echo "FAIL: can't set up cgroups, make sure misc and memory cgroups are enabled."
+    clean_up
+    exit 1
+fi
+
+epc_capacity=$(grep "sgx_epc" "$cg_root/misc.capacity" | awk '{print $2}')
+
+# This is below number of VA pages needed for enclave of capacity size. So
+# should fail oversubscribed cases
+epc_small_limit=$(( epc_capacity / 512 ))
+
+# At least load one enclave of capacity size successfully, maybe up to 4.
+# But some may fail if we run more than 4 concurrent enclaves of capacity size.
+epc_large_limit=$(( epc_small_limit * 4 ))
+
+# Load lots of enclaves
+epc_larger_limit=$epc_capacity
+echo "# Setting up SGX cgroup limits."
+echo "sgx_epc $epc_small_limit" > $cg_root/$test_cg_small_parent/misc.max && \
+echo "sgx_epc $epc_large_limit" >  $cg_root/$test_cg_large/misc.max && \
+echo "sgx_epc $epc_larger_limit" > $cg_root/$test_cg_larger/misc.max
+if [ $? -ne 0 ]; then
+    echo "# Failed setting up misc limits for sgx_epc."
+    echo "SKIP: Kernel does not support SGX cgroup."
+    clean_up
+    exit $ksft_skip
+fi
+
+test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
+
+echo "# Start unclobbered_vdso_oversubscribed with small EPC limit, expecting failure..."
+./ash_cgexec.sh $test_cg_small $test_cmd >/dev/null 2>&1
+if [ $? -eq 0 ]; then
+    echo "FAIL: Fail on small EPC limit, not expecting any test passes."
+    clean_up
+    exit 1
+else
+    echo "# Test failed as expected."
+fi
+
+echo "PASS: small EPC limit test."
+
+echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with large EPC limit, \
+expecting at least one success...."
+
+pids=""
+for i in 1 2 3 4; do
+    (
+        ./ash_cgexec.sh $test_cg_large $test_cmd >/dev/null 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
+    echo "PASS: large EPC limit positive testing."
+else
+    echo "FAIL: Failed on large EPC limit positive testing, no test passes."
+    clean_up
+    exit 1
+fi
+
+echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with large EPC limit, \
+expecting at least one failure...."
+pids=""
+for i in 1 2 3 4 5; do
+    (
+        ./ash_cgexec.sh $test_cg_large $test_cmd >/dev/null 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
+    echo "PASS: large EPC limit negative testing."
+else
+    echo "FAIL: Failed on large EPC limit negative testing, no test fails."
+    clean_up
+    exit 1
+fi
+
+echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with larger EPC limit, \
+expecting no failure...."
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
+    (
+        ./ash_cgexec.sh $test_cg_larger $test_cmd >/dev/null 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_FAILURE "$pids"; then
+    echo "FAIL: Failed on larger EPC limit, at least one test fails."
+    clean_up
+    exit 1
+else
+    echo "PASS: larger EPC limit tests."
+fi
+
+echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with larger EPC limit,\
+ randomly kill one, expecting no failure...."
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
+    (
+        ./ash_cgexec.sh $test_cg_larger $test_cmd >/dev/null 2>&1
+    ) &
+    pids="$pids $!"
+done
+random_number=$(awk 'BEGIN{srand();print int(rand()*5)}')
+sleep $((random_number + 1))
+
+# Randomly select a process to kill
+# Make sure usage counter not leaked at the end.
+random_index=$(awk 'BEGIN{srand();print int(rand()*8)}')
+counter=0
+for pid in $pids; do
+    if [ "$counter" -eq "$random_index" ]; then
+        pid_to_kill=$pid
+        break
+    fi
+    counter=$((counter + 1))
+done
+
+kill $pid_to_kill
+echo "# Killed process with PID: $pid_to_kill"
+
+any_failure=0
+for pid in $pids; do
+    wait "$pid"
+    status=$?
+    if [ "$pid" != "$pid_to_kill" ]; then
+        if [ $status -ne 0 ]; then
+	    echo "# Process $pid returned failure."
+            any_failure=1
+        fi
+    fi
+done
+
+if [ $any_failure -ne 0 ]; then
+    echo "FAIL: Failed on random killing, at least one test fails."
+    clean_up
+    exit 1
+fi
+echo "PASS: larger EPC limit test with a process randomly killed."
+
+mem_limit_too_small=$((epc_capacity - 2 * epc_large_limit))
+
+echo "$mem_limit_too_small" > $cg_root/$test_cg_large/memory.max
+if [ $? -ne 0 ]; then
+    echo "FAIL: Failed setting up memory controller."
+    clean_up
+    exit 1
+fi
+
+echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with large EPC limit, \
+and too small RAM limit, expecting all failures...."
+# Ensure swapping off so the OOM killer is activated when mem_cgroup limit is hit.
+swapoff -a
+pids=""
+for i in 1 2 3 4; do
+    (
+        ./ash_cgexec.sh $test_cg_large $test_cmd >/dev/null 2>&1
+    ) &
+    pids="$pids $!"
+done
+
+if wait_and_detect_for_any $PROCESS_SUCCESS "$pids"; then
+    echo "FAIL: Failed on tests with memcontrol, some tests did not fail."
+    clean_up
+    swapon -a
+    exit 1
+else
+    swapon -a
+    echo "PASS: large EPC limit tests with memcontrol."
+fi
+
+sleep 2
+
+epc_usage=$(grep '^sgx_epc' "$cg_root/$test_root_cg/misc.current" | awk '{print $2}')
+if [ "$epc_usage" -ne 0 ]; then
+    echo "FAIL: Final usage is $epc_usage, not 0."
+else
+    echo "PASS: leakage check."
+    echo "PASS: ALL cgroup limit tests, cleanup cgroups..."
+fi
+clean_up
+echo "# Done SGX cgroup tests."
diff --git a/tools/testing/selftests/sgx/settings b/tools/testing/selftests/sgx/settings
new file mode 100644
index 000000000000..4bf7dcbf9fa8
--- /dev/null
+++ b/tools/testing/selftests/sgx/settings
@@ -0,0 +1,2 @@
+# This timeout may need be increased for platforms with EPC larger than 4G
+timeout=140
diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
new file mode 100755
index 000000000000..9280a5e0962b
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
+watch -n 1 'find /sys/fs/cgroup -wholename "*/sgx_test*/misc.'$1'" -exec \
+    sh -c '\''echo "$1:"; cat "$1"'\'' _ {} \;'
-- 
2.43.0


