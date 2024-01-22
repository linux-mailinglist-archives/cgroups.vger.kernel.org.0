Return-Path: <cgroups+bounces-1199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236D836F29
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 19:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E721AB314D2
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28319604A9;
	Mon, 22 Jan 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO0XHnvU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074D5FEF7;
	Mon, 22 Jan 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944060; cv=none; b=rH8aJp4lXfa48PVAPQVMtkiznr8vns/6gBa1811eHhBfmdHAFZqENlg43nDK1g9tibkSqNIM2B8yjtXtsGtC4mPnzr6pbJFp/PizwWsBqcpB2MWLGODVCF6UQA87BQXWYk3Eq+ob8e19gAQv8402EA05OPUxJA3NkIU5SBAz0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944060; c=relaxed/simple;
	bh=yOWHglLZ1B+fQRkP+rpuHciUQYdwgtTPy4iyogRW/R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKfIMdpTjF/BtTcT2Vcf5wGFxntJ5lIp9ytENg4mv013UiTTg0fmhH7/0hL9AbV2ePaU8r3rqJrRLfCrdqoBZx/l1z18yQS7ogvkqGj/bwwF/OPQJcM0MVqSZrpdfBnCnAU49c7sX8mnGYpGFut3inekLvjRHrjBFCjoHCecASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO0XHnvU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944059; x=1737480059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOWHglLZ1B+fQRkP+rpuHciUQYdwgtTPy4iyogRW/R4=;
  b=gO0XHnvUmDrF+cHTHwXxiujteatXSFtsyrjHYM8eVeawXLSrRGbtYX0G
   2I6f9btVJJ66n2PSX5Csgzclj5sCCOcpiuLCM9aA4j/ttNRU7mWtsPkl6
   GXK/VOdUmMAcE3aPTQ+ANPn/hWG2W2w2hKCnaPDxsro8zQxa4IAjjbYJY
   z1ZY0S4IZOjDKHz623Tch1FUtQIx06pKa2WtI35KvxEz6c5EjddAkHIht
   mUIS2FiRmjS2Ez9WoBoNpN4ETBnaEFNmh3uGG8dM6mACUEkPHm1cGYD5a
   MhLenebe+hzH62NKQ6D+e6U82kT+NNTRS19ODvOt7AD36Hy7OO87hF0VP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150239"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150239"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1262900"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa005.jf.intel.com with ESMTP; 22 Jan 2024 09:20:50 -0800
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
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
	sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com
Subject: [PATCH v7 15/15] selftests/sgx: Add scripts for EPC cgroup testing
Date: Mon, 22 Jan 2024 09:20:48 -0800
Message-Id: <20240122172048.11953-16-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122172048.11953-1-haitao.huang@linux.intel.com>
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scripts rely on cgroup-tools package from libcgroup [1].

To run selftests for epc cgroup:

sudo ./run_epc_cg_selftests.sh

To watch misc cgroup 'current' changes during testing, run this in a
separate terminal:

./watch_misc_for_tests.sh current

With different cgroups, the script starts one or multiple concurrent SGX
selftests, each to run one unclobbered_vdso_oversubscribed test.  Each
of such test tries to load an enclave of EPC size equal to the EPC
capacity available on the platform. The script checks results against
the expectation set for each cgroup and reports success or failure.

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
usage checked to be zero after all process exit.

The script also includes a test with low mem_cg limit and LARGE sgx_epc
limit to verify that the RAM used for per-cgroup reclamation is charged
to a proper mem_cg.

[1] https://github.com/libcgroup/libcgroup/blob/main/README

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V7:
- Added memcontrol test.

V5:
- Added script with automatic results checking, remove the interactive
script.
- The script can run independent from the series below.
---
 .../selftests/sgx/run_epc_cg_selftests.sh     | 246 ++++++++++++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
 2 files changed, 259 insertions(+)
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
new file mode 100755
index 000000000000..e027bf39f005
--- /dev/null
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -0,0 +1,246 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023 Intel Corporation.
+
+TEST_ROOT_CG=selftest
+cgcreate -g misc:$TEST_ROOT_CG
+if [ $? -ne 0 ]; then
+    echo "# Please make sure cgroup-tools is installed, and misc cgroup is mounted."
+    exit 1
+fi
+TEST_CG_SUB1=$TEST_ROOT_CG/test1
+TEST_CG_SUB2=$TEST_ROOT_CG/test2
+# We will only set limit in test1 and run tests in test3
+TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
+TEST_CG_SUB4=$TEST_ROOT_CG/test4
+
+cgcreate -g misc:$TEST_CG_SUB1
+cgcreate -g misc:$TEST_CG_SUB2
+cgcreate -g misc:$TEST_CG_SUB3
+cgcreate -g misc:$TEST_CG_SUB4
+
+# Default to V2
+CG_MISC_ROOT=/sys/fs/cgroup
+CG_MEM_ROOT=/sys/fs/cgroup
+CG_V1=0
+if [ ! -d "/sys/fs/cgroup/misc" ]; then
+    echo "# cgroup V2 is in use."
+else
+    echo "# cgroup V1 is in use."
+    CG_MISC_ROOT=/sys/fs/cgroup/misc
+    CG_MEM_ROOT=/sys/fs/cgroup/memory
+    CG_V1=1
+fi
+
+CAPACITY=$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk '{print $2}')
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
+echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
+echo "sgx_epc $LARGE" >  $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
+echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
+
+timestamp=$(date +%Y%m%d_%H%M%S)
+
+test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
+
+wait_check_process_status() {
+    local pid=$1
+    local check_for_success=$2  # If 1, check for success;
+                                # If 0, check for failure
+    wait "$pid"
+    local status=$?
+
+    if [[ $check_for_success -eq 1 && $status -eq 0 ]]; then
+        echo "# Process $pid succeeded."
+        return 0
+    elif [[ $check_for_success -eq 0 && $status -ne 0 ]]; then
+        echo "# Process $pid returned failure."
+        return 0
+    fi
+    return 1
+}
+
+wait_and_detect_for_any() {
+    local pids=("$@")
+    local check_for_success=$1  # If 1, check for success;
+                                # If 0, check for failure
+    local detected=1 # 0 for success detection
+
+    for pid in "${pids[@]:1}"; do
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
+# Always use leaf node of misc cgroups so it works for both v1 and v2
+# these may fail on OOM
+cgexec -g misc:$TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
+if [[ $? -eq 0 ]]; then
+    echo "# Fail on SMALL limit, not expecting any test passes."
+    cgdelete -r -g misc:$TEST_ROOT_CG
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
+pids=()
+for i in {1..4}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+
+if wait_and_detect_for_any 1 "${pids[@]}"; then
+    echo "# PASSED LARGE limit positive testing."
+else
+    echo "# Failed on LARGE limit positive testing, no test passes."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+
+echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
+        expecting at least one failure...."
+pids=()
+for i in {1..5}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+if wait_and_detect_for_any 0 "${pids[@]}"; then
+    echo "# PASSED LARGE limit negative testing."
+else
+    echo "# Failed on LARGE limit negative testing, no test fails."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+
+echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
+        expecting no failure...."
+pids=()
+for i in {1..8}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+if wait_and_detect_for_any 0 "${pids[@]}"; then
+    echo "# Failed on LARGER limit, at least one test fails."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+else
+    echo "# PASSED LARGER limit tests."
+fi
+
+echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
+      randomly kill one, expecting no failure...."
+pids=()
+for i in {1..8}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+sleep $((RANDOM % 10 + 5))
+
+# Randomly select a PID to kill
+RANDOM_INDEX=$((RANDOM % 8))
+PID_TO_KILL=${pids[RANDOM_INDEX]}
+
+kill $PID_TO_KILL
+echo "# Killed process with PID: $PID_TO_KILL"
+
+any_failure=0
+for pid in "${pids[@]}"; do
+    wait "$pid"
+    status=$?
+    if [ "$pid" != "$PID_TO_KILL" ]; then
+        if [[ $status -ne 0 ]]; then
+	    echo "# Process $pid returned failure."
+            any_failure=1
+        fi
+    fi
+done
+
+if [[ $any_failure -ne 0 ]]; then
+    echo "# Failed on random killing, at least one test fails."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+echo "# PASSED LARGER limit test with a process randomly killed."
+
+cgcreate -g memory:$TEST_CG_SUB2
+if [ $? -ne 0 ]; then
+    echo "# Failed creating memory controller."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+MEM_LIMIT_TOO_SMALL=$((CAPACITY - 2 * LARGE))
+
+if [[ $CG_V1 -eq 0 ]]; then
+    echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.max
+else
+    echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.limit_in_bytes
+    echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.memsw.limit_in_bytes
+fi
+
+echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE EPC limit,
+        and too small RAM limit, expecting all failures...."
+pids=()
+for i in {1..4}; do
+    (
+        cgexec -g memory:$TEST_CG_SUB2 -g misc:$TEST_CG_SUB2 $test_cmd \
+               >cgtest_large_oom_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+if wait_and_detect_for_any 1 "${pids[@]}"; then
+    echo "# Failed on tests with memcontrol, some tests did not fail."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    if [[ $CG_V1 -ne 0 ]]; then
+        cgdelete -r -g memory:$TEST_ROOT_CG
+    fi
+    exit 1
+else
+    echo "# PASSED LARGE limit tests with memcontrol."
+fi
+
+sleep 2
+
+USAGE=$(grep '^sgx_epc' "$CG_MISC_ROOT/$TEST_ROOT_CG/misc.current" | awk '{print $2}')
+if [ "$USAGE" -ne 0 ]; then
+    echo "# Failed: Final usage is $USAGE, not 0."
+else
+    echo "# PASSED leakage check."
+    echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
+fi
+cgdelete -r -g misc:$TEST_ROOT_CG
+if [[ $CG_V1 -ne 0 ]]; then
+     cgdelete -r -g memory:$TEST_ROOT_CG
+fi
+echo "# done."
diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
new file mode 100755
index 000000000000..dbd38f346e7b
--- /dev/null
+++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023 Intel Corporation.
+
+if [ -z "$1" ]
+  then
+    echo "No argument supplied, please provide 'max', 'current' or 'events'"
+    exit 1
+fi
+
+watch -n 1 "find /sys/fs/cgroup -wholename */test*/misc.$1 -exec sh -c \
+    'echo \"\$1:\"; cat \"\$1\"' _ {} \;"
+
-- 
2.25.1


