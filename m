Return-Path: <cgroups+bounces-2214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130488F3A1
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279AA2A55BF
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B23C08E;
	Thu, 28 Mar 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQnS5ETy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC63838F;
	Thu, 28 Mar 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585376; cv=none; b=OgjomblbGc5JTrZdpdIDIS7PCDpLCi3VO9wlC50Hw+2+PggfdXai2mOupT5Ba5ikrhD88DqT2L4wt6kILmAbzMYURiyYOMqG3I/Mnel8AbFKAIH8K7QbUEX76py55oW0Pwo9mK8Oe9u8o0ivG4iZPxDavF+z6OB4bLYBiX/7NmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585376; c=relaxed/simple;
	bh=yOWHglLZ1B+fQRkP+rpuHciUQYdwgtTPy4iyogRW/R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P308dnJZKbTrjRtnBc6qgqoBLwmD1x4nKn2TBGG6NBMBXIolz5tjRKzYRZsBsoKW+y2oGDk1TViNSie02yIeorDY/60K1YnMJTkxqEvWGY84641lsl4sOSchX0oJn2Lix9LQvt89wtozy0wj0hJV1Mv5QYOYZZrciNg8G9mxf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQnS5ETy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711585374; x=1743121374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOWHglLZ1B+fQRkP+rpuHciUQYdwgtTPy4iyogRW/R4=;
  b=dQnS5ETypc65i76+CKzwBoiJIpRjw4OeSZoY1HJ9Imjdw3NqYJJtYBpv
   XGyVyI5I6T0hIWUUkXvRvWbLu0Xhl2HcpL2AKWLFe4a37xKB8w83ZOktW
   C843qi9oQUpnBfvQnml2Pz/uJ1fHtOmlWfa2zh1as9oEQAlMANm84xaxi
   o7Y6KHMJ+zb5Dgv8MguzFRiwuXdVFqm7plg3wN4nbT4cUgR47h4YOqtNa
   QSJ3eWmUPVmmaGfzwAswEc1We4WZjG3kSYFXAdvk/iGNH5FvcvG+BsPwX
   fClN6roGWhjYtQ6B8j4wVdLKZJFMhKtFztqNB4sF0H+NWTAhzEzAPUS3x
   w==;
X-CSE-ConnectionGUID: vDEPaaYsSBeZyK+8+EPtKw==
X-CSE-MsgGUID: H+1kHmzySbOK3iAB4XAwRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6580758"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6580758"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16411824"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2024 17:22:32 -0700
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
Subject: [PATCH v10 14/14] selftests/sgx: Add scripts for EPC cgroup testing
Date: Wed, 27 Mar 2024 17:22:29 -0700
Message-Id: <20240328002229.30264-15-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328002229.30264-1-haitao.huang@linux.intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
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


