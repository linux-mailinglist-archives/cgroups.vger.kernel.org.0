Return-Path: <cgroups+bounces-2266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396E8948DB
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 03:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FEE1F22EE5
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7506C2FD;
	Tue,  2 Apr 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc8ZPdHZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C068F7D;
	Tue,  2 Apr 2024 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022179; cv=none; b=GR3l4pcJJ5YhsiuiINKZ4wOezMiD9TzAdYFVF5iEOkUXG7uFXIHADO3XvxE85PaZqEI9/NpgxNzn5kX7R/8vZ/l3Hh7UCKtFvdRUf4h380l12lWLdGRQ3k9i0y3CxgB0p/Ha2i1/djC1HFf41ZakoEFwMeKmmigIfw5ehw4OIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022179; c=relaxed/simple;
	bh=YL07RNzQ+IrLuaGQ98bNmMijBJ6zdWlZOd+8C9CH0sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1RE4cmmdoF873VexXUQqTQjtQjyJbD5U7iIR7thBiyBIpnXicVwkipZHLOmiFp9Z+lgMzM/lPf0Y2W95wVQRB8Sre9AibuvXFkQP2DgSyQKAk9XCU9ozhLRR7UVY8ErBm1UwiseCoDigXJ1UDJRFRT7MttLhY+OaBMhnIUNFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc8ZPdHZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712022177; x=1743558177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YL07RNzQ+IrLuaGQ98bNmMijBJ6zdWlZOd+8C9CH0sU=;
  b=Sc8ZPdHZ8HcdBYDBt/M19VFzqTgqnNN4r/BFHOsUrnz1+rs2+zrXPMOk
   cjMAiVXNAKU5K5tL8V3VcIPBeAYCaxB1o2CLaxb0PnHQQX9T/qNp0fAlg
   Uab2oJ6OLxzvMu53IzYmRz3n13dqkf+Tk5brihF2OniBgQZvZb/uC36aQ
   PGBON5rWQRyKKxsLIQJlnv/LJdH21KV6PHdXsh3E7HrwMNkGeZ0yRADx8
   ePd0soi6+57HLyln+yniXGhfHuxYeDsrFjg46OIo7iUyjHEhuWUGPpY5P
   X6OMmcdqnkk7nbDL7OwQWRagtR4rv1608TFyRYtxVr3IUV1MTJwjUTTAB
   Q==;
X-CSE-ConnectionGUID: TRppVAFhSoGTdQRGvd66Fw==
X-CSE-MsgGUID: c703YzF3T8GXq0uMZ3+2Dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7295957"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7295957"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 18:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="49110607"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa001.fm.intel.com with ESMTP; 01 Apr 2024 18:42:54 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org
Cc: anakrish@microsoft.com,
	bp@alien8.de,
	cgroups@vger.kernel.org,
	chrisyan@microsoft.com,
	dave.hansen@linux.intel.com,
	haitao.huang@linux.intel.com,
	hpa@zytor.com,
	kai.huang@intel.com,
	kristen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	mikko.ylinen@linux.intel.com,
	mingo@redhat.com,
	mkoutny@suse.com,
	seanjc@google.com,
	sohil.mehta@intel.com,
	tglx@linutronix.de,
	tim.c.chen@linux.intel.com,
	tj@kernel.org,
	x86@kernel.org,
	yangjie@microsoft.com,
	zhanb@microsoft.com,
	zhiquan1.li@intel.com
Subject: [PATCH v2] selftests/sgx: Improve cgroup test scripts
Date: Mon,  1 Apr 2024 18:42:54 -0700
Message-Id: <20240402014254.27717-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
References: <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make cgroup test scripts ash compatible.
Remove cg-tools dependency.
Add documentation for functions.

Tested with busybox on Ubuntu.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
v2:
- Fixes for v2 cgroup
- Turn off swapping before memcontrol tests and back on after
- Add comments and reformat
---
 tools/testing/selftests/sgx/ash_cgexec.sh     |  57 ++++++
 .../selftests/sgx/run_epc_cg_selftests.sh     | 187 +++++++++++-------
 .../selftests/sgx/watch_misc_for_tests.sh     |  13 +-
 3 files changed, 179 insertions(+), 78 deletions(-)
 create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh

diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh b/tools/testing/selftests/sgx/ash_cgexec.sh
new file mode 100755
index 000000000000..9607784378df
--- /dev/null
+++ b/tools/testing/selftests/sgx/ash_cgexec.sh
@@ -0,0 +1,57 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2024 Intel Corporation.
+
+# Move the current shell process to the specified cgroup
+# Arguments:
+# 	$1 - The cgroup controller name, e.g., misc, memory.
+#	$2 - The path of the cgroup,
+#		relative to /sys/fs/cgroup for cgroup v2,
+#		relative to /sys/fs/cgroup/$1 for v1.
+move_to_cgroup() {
+    controllers="$1"
+    path="$2"
+
+    # Check if cgroup v2 is in use
+    if [ ! -d "/sys/fs/cgroup/misc" ]; then
+        # Cgroup v2 logic
+        cgroup_full_path="/sys/fs/cgroup/${path}"
+        echo $$ > "${cgroup_full_path}/cgroup.procs"
+    else
+        # Cgroup v1 logic
+        OLD_IFS="$IFS"
+        IFS=','
+        for controller in $controllers; do
+            cgroup_full_path="/sys/fs/cgroup/${controller}/${path}"
+            echo $$ > "${cgroup_full_path}/tasks"
+        done
+        IFS="$OLD_IFS"
+    fi
+}
+
+if [ "$#" -lt 3 ] || [ "$1" != "-g" ]; then
+    echo "Usage: $0 -g <controller1,controller2:path> [-g <controller3:path> ...] <command> [args...]"
+    exit 1
+fi
+
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+        -g)
+            # Ensure that a controller:path pair is provided after -g
+            if [ -z "$2" ]; then
+                echo "Error: Missing controller:path argument after -g"
+                exit 1
+            fi
+            IFS=':' read CONTROLLERS CGROUP_PATH <<EOF
+$2
+EOF
+            move_to_cgroup "$CONTROLLERS" "$CGROUP_PATH"
+            shift 2
+            ;;
+        *)
+            # Execute the command within the cgroup
+            exec "$@"
+            ;;
+    esac
+done
+
diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
index e027bf39f005..be4172f84580 100755
--- a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -1,24 +1,14 @@
-#!/bin/bash
+#!/usr/bin/env sh
 # SPDX-License-Identifier: GPL-2.0
-# Copyright(c) 2023 Intel Corporation.
+# Copyright(c) 2023, 2024 Intel Corporation.
 
 TEST_ROOT_CG=selftest
-cgcreate -g misc:$TEST_ROOT_CG
-if [ $? -ne 0 ]; then
-    echo "# Please make sure cgroup-tools is installed, and misc cgroup is mounted."
-    exit 1
-fi
 TEST_CG_SUB1=$TEST_ROOT_CG/test1
 TEST_CG_SUB2=$TEST_ROOT_CG/test2
 # We will only set limit in test1 and run tests in test3
 TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
 TEST_CG_SUB4=$TEST_ROOT_CG/test4
 
-cgcreate -g misc:$TEST_CG_SUB1
-cgcreate -g misc:$TEST_CG_SUB2
-cgcreate -g misc:$TEST_CG_SUB3
-cgcreate -g misc:$TEST_CG_SUB4
-
 # Default to V2
 CG_MISC_ROOT=/sys/fs/cgroup
 CG_MEM_ROOT=/sys/fs/cgroup
@@ -31,6 +21,19 @@ else
     CG_MEM_ROOT=/sys/fs/cgroup/memory
     CG_V1=1
 fi
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB1
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB2
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB3
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB4
+
+# Turn on misc and memory controller in non-leaf nodes for V2
+if [ $CG_V1 -eq 0 ]; then
+    echo "+misc" >  $CG_MISC_ROOT/cgroup.subtree_control
+    echo "+memory" > $CG_MEM_ROOT/cgroup.subtree_control
+    echo "+misc" >  $CG_MISC_ROOT/$TEST_ROOT_CG/cgroup.subtree_control
+    echo "+memory" > $CG_MEM_ROOT/$TEST_ROOT_CG/cgroup.subtree_control
+    echo "+misc" >  $CG_MISC_ROOT/$TEST_CG_SUB1/cgroup.subtree_control
+fi
 
 CAPACITY=$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk '{print $2}')
 # This is below number of VA pages needed for enclave of capacity size. So
@@ -48,34 +51,67 @@ echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
 echo "sgx_epc $LARGE" >  $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
 echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
 
+if [ $? -ne 0 ]; then
+    echo "# Failed setting up misc limits, make sure misc cgroup is mounted."
+    exit 1
+fi
+
+clean_up_misc()
+{
+    sleep 2
+    rmdir $CG_MISC_ROOT/$TEST_CG_SUB2
+    rmdir $CG_MISC_ROOT/$TEST_CG_SUB3
+    rmdir $CG_MISC_ROOT/$TEST_CG_SUB4
+    rmdir $CG_MISC_ROOT/$TEST_CG_SUB1
+    rmdir $CG_MISC_ROOT/$TEST_ROOT_CG
+}
+
 timestamp=$(date +%Y%m%d_%H%M%S)
 
 test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
 
+# Wait for a process and check for expected exit status.
+#
+# Arguments:
+#	$1 - the pid of the process to wait and check.
+#	$2 - 1 if expecting success, 0 for failure.
+#
+# Return:
+#	0 if the exit status of the process matches the expectation.
+#	1 otherwise.
 wait_check_process_status() {
-    local pid=$1
-    local check_for_success=$2  # If 1, check for success;
-                                # If 0, check for failure
+    pid=$1
+    check_for_success=$2  # If 1, check for success;
+                          # If 0, check for failure
     wait "$pid"
-    local status=$?
+    status=$?
 
-    if [[ $check_for_success -eq 1 && $status -eq 0 ]]; then
+    if [ $check_for_success -eq 1 ] && [ $status -eq 0 ]; then
         echo "# Process $pid succeeded."
         return 0
-    elif [[ $check_for_success -eq 0 && $status -ne 0 ]]; then
+    elif [ $check_for_success -eq 0 ] && [ $status -ne 0 ]; then
         echo "# Process $pid returned failure."
         return 0
     fi
     return 1
 }
 
+# Wait for a set of processes and check for expected exit status
+#
+# Arguments:
+#	$1 - 1 if expecting success, 0 for failure.
+#	remaining args - The pids of the processes
+#
+# Return:
+#	0 if exit status of any process matches the expectation.
+#	1 otherwise.
 wait_and_detect_for_any() {
-    local pids=("$@")
-    local check_for_success=$1  # If 1, check for success;
-                                # If 0, check for failure
-    local detected=1 # 0 for success detection
+    check_for_success=$1  # If 1, check for success;
+                          # If 0, check for failure
+    shift
+    detected=1 # 0 for success detection
 
-    for pid in "${pids[@]:1}"; do
+    for pid in $@; do
         if wait_check_process_status "$pid" "$check_for_success"; then
             detected=0
             # Wait for other processes to exit
@@ -88,10 +124,10 @@ wait_and_detect_for_any() {
 echo "# Start unclobbered_vdso_oversubscribed with SMALL limit, expecting failure..."
 # Always use leaf node of misc cgroups so it works for both v1 and v2
 # these may fail on OOM
-cgexec -g misc:$TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
-if [[ $? -eq 0 ]]; then
+./ash_cgexec.sh -g misc:$TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
+if [ $? -eq 0 ]; then
     echo "# Fail on SMALL limit, not expecting any test passes."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 else
     echo "# Test failed as expected."
@@ -102,54 +138,54 @@ echo "# PASSED SMALL limit."
 echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
         expecting at least one success...."
 
-pids=()
-for i in {1..4}; do
+pids=""
+for i in 1 2 3 4; do
     (
-        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
 
-if wait_and_detect_for_any 1 "${pids[@]}"; then
+if wait_and_detect_for_any 1 "$pids"; then
     echo "# PASSED LARGE limit positive testing."
 else
     echo "# Failed on LARGE limit positive testing, no test passes."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 
 echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
         expecting at least one failure...."
-pids=()
-for i in {1..5}; do
+pids=""
+for i in 1 2 3 4 5; do
     (
-        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
-if wait_and_detect_for_any 0 "${pids[@]}"; then
+if wait_and_detect_for_any 0 "$pids"; then
     echo "# PASSED LARGE limit negative testing."
 else
     echo "# Failed on LARGE limit negative testing, no test fails."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 
 echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
         expecting no failure...."
-pids=()
-for i in {1..8}; do
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
     (
-        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
-if wait_and_detect_for_any 0 "${pids[@]}"; then
+if wait_and_detect_for_any 0 "$pids"; then
     echo "# Failed on LARGER limit, at least one test fails."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 else
     echo "# PASSED LARGER limit tests."
@@ -157,51 +193,58 @@ fi
 
 echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
       randomly kill one, expecting no failure...."
-pids=()
-for i in {1..8}; do
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
     (
-        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
-
-sleep $((RANDOM % 10 + 5))
+random_number=$(awk 'BEGIN{srand();print int(rand()*10)}')
+sleep $((random_number + 5))
 
 # Randomly select a PID to kill
-RANDOM_INDEX=$((RANDOM % 8))
-PID_TO_KILL=${pids[RANDOM_INDEX]}
+RANDOM_INDEX=$(awk 'BEGIN{srand();print int(rand()*8)}')
+counter=0
+for pid in $pids; do
+    if [ "$counter" -eq "$RANDOM_INDEX" ]; then
+        PID_TO_KILL=$pid
+        break
+    fi
+    counter=$((counter + 1))
+done
 
 kill $PID_TO_KILL
 echo "# Killed process with PID: $PID_TO_KILL"
 
 any_failure=0
-for pid in "${pids[@]}"; do
+for pid in $pids; do
     wait "$pid"
     status=$?
     if [ "$pid" != "$PID_TO_KILL" ]; then
-        if [[ $status -ne 0 ]]; then
+        if [ $status -ne 0 ]; then
 	    echo "# Process $pid returned failure."
             any_failure=1
         fi
     fi
 done
 
-if [[ $any_failure -ne 0 ]]; then
+if [ $any_failure -ne 0 ]; then
     echo "# Failed on random killing, at least one test fails."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 echo "# PASSED LARGER limit test with a process randomly killed."
 
-cgcreate -g memory:$TEST_CG_SUB2
+mkdir -p $CG_MEM_ROOT/$TEST_CG_SUB2
 if [ $? -ne 0 ]; then
     echo "# Failed creating memory controller."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 MEM_LIMIT_TOO_SMALL=$((CAPACITY - 2 * LARGE))
 
-if [[ $CG_V1 -eq 0 ]]; then
+if [ $CG_V1 -eq 0 ]; then
     echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.max
 else
     echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.limit_in_bytes
@@ -210,23 +253,27 @@ fi
 
 echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE EPC limit,
         and too small RAM limit, expecting all failures...."
-pids=()
-for i in {1..4}; do
+# Ensure swapping off
+swapoff -a
+pids=""
+for i in 1 2 3 4; do
     (
-        cgexec -g memory:$TEST_CG_SUB2 -g misc:$TEST_CG_SUB2 $test_cmd \
+        ./ash_cgexec.sh -g memory:$TEST_CG_SUB2 -g misc:$TEST_CG_SUB2 $test_cmd \
                >cgtest_large_oom_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
-if wait_and_detect_for_any 1 "${pids[@]}"; then
+if wait_and_detect_for_any 1 "$pids"; then
     echo "# Failed on tests with memcontrol, some tests did not fail."
-    cgdelete -r -g misc:$TEST_ROOT_CG
-    if [[ $CG_V1 -ne 0 ]]; then
-        cgdelete -r -g memory:$TEST_ROOT_CG
+    clean_up_misc
+    if [ $CG_V1 -ne 0 ]; then
+        rmdir $CG_MEM_ROOT/$TEST_CG_SUB2
     fi
+    swapon -a
     exit 1
 else
+    swapon -a
     echo "# PASSED LARGE limit tests with memcontrol."
 fi
 
@@ -239,8 +286,8 @@ else
     echo "# PASSED leakage check."
     echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
 fi
-cgdelete -r -g misc:$TEST_ROOT_CG
-if [[ $CG_V1 -ne 0 ]]; then
-     cgdelete -r -g memory:$TEST_ROOT_CG
+clean_up_misc
+if [ $CG_V1 -ne 0 ]; then
+     rmdir $CG_MEM_ROOT/$TEST_CG_SUB2
 fi
 echo "# done."
diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
index dbd38f346e7b..3b05475938d0 100755
--- a/tools/testing/selftests/sgx/watch_misc_for_tests.sh
+++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
@@ -1,13 +1,10 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+##!/usr/bin/env sh
+#!/bin/sh
 # Copyright(c) 2023 Intel Corporation.
 
-if [ -z "$1" ]
-  then
-    echo "No argument supplied, please provide 'max', 'current' or 'events'"
+if [ -z "$1" ]; then
+    echo "No argument supplied, please provide 'max', 'current', or 'events'"
     exit 1
 fi
 
-watch -n 1 "find /sys/fs/cgroup -wholename */test*/misc.$1 -exec sh -c \
-    'echo \"\$1:\"; cat \"\$1\"' _ {} \;"
-
+watch -n 1 'find /sys/fs/cgroup -wholename "*/test*/misc.'$1'" -exec sh -c '\''echo "$1:"; cat "$1"'\'' _ {} \;'
-- 
2.25.1


