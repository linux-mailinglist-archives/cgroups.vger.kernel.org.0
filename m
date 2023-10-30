Return-Path: <cgroups+bounces-130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F77DBFB8
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EE41C20B5C
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E519BCC;
	Mon, 30 Oct 2023 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIPxdGh2"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C019BB1
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D59E1;
	Mon, 30 Oct 2023 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690038; x=1730226038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vwoNizkiHcFYzYVMWoNqF3D7lmeva/dKQ41pgY/Z5Eo=;
  b=oIPxdGh2L7axnKHvFARPmeUYlAfGCBBp76ONANHG6iod16Vgykf5YmdT
   jRhPPmhS3obzO+FKJ6NQ0jeV+IMAMe0jLVizCoY+wddaS+FbedQS6opF5
   xFHkAmSkZ96bBNFSWZXVgqzu5frODhmv1oj0PmIxfUT1pmxQIx07fYD5r
   ySHpVDLB2CcIA1WU+dwBhtab+P2QgBOKIZrHfSVM06i8jpgYnlUPiiZ/z
   KqEHTIGv6m6i4R2e5+Yj20yiPQPkZr6j6a3o+e/M9KAYszAVH4JRbAVS7
   gfsox4wImxFise3DadxLaDmE/jdoQ+c3IlAIQzvYaxPN/UbPHpnHnQVGF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479647"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479647"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529539"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529539"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:30 -0700
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
	yangjie@microsoft.com,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 12/12] selftests/sgx: Add scripts for EPC cgroup testing
Date: Mon, 30 Oct 2023 11:20:13 -0700
Message-Id: <20231030182013.40086-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
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
concurrent tests. The script starts 10 of them and expects all pass.
Then it reruns the same test with one process randomly killed and
usage checked to be zero after all process exit.

To watch misc cgroup 'current' changes during testing, run this in a
separate terminal:

./watch_misc_for_tests.sh current

[1] https://github.com/libcgroup/libcgroup/blob/main/README

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V5:

- Added script with automatic results checking, remove the interactive
script.
- The script can run independent from the series below.
---
 .../selftests/sgx/run_epc_cg_selftests.sh     | 196 ++++++++++++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     |  13 ++
 2 files changed, 209 insertions(+)
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
new file mode 100755
index 000000000000..72b93f694753
--- /dev/null
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -0,0 +1,196 @@
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
+TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
+TEST_CG_SUB4=$TEST_ROOT_CG/test4
+
+cgcreate -g misc:$TEST_CG_SUB1
+cgcreate -g misc:$TEST_CG_SUB2
+cgcreate -g misc:$TEST_CG_SUB3
+cgcreate -g misc:$TEST_CG_SUB4
+
+# Default to V2
+CG_ROOT=/sys/fs/cgroup
+if [ ! -d "/sys/fs/cgroup/misc" ]; then
+    echo "# cgroup V2 is in use."
+else
+    echo "# cgroup V1 is in use."
+    CG_ROOT=/sys/fs/cgroup/misc
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
+echo "sgx_epc $SMALL" | tee $CG_ROOT/$TEST_CG_SUB1/misc.max
+echo "sgx_epc $LARGE" | tee $CG_ROOT/$TEST_CG_SUB2/misc.max
+echo "sgx_epc $LARGER" | tee $CG_ROOT/$TEST_CG_SUB4/misc.max
+
+timestamp=$(date +%Y%m%d_%H%M%S)
+
+test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
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
+pids=()
+for i in {1..4}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+any_success=0
+for pid in "${pids[@]}"; do
+    wait "$pid"
+    status=$?
+    if [[ $status -eq 0 ]]; then
+        any_success=1
+	echo "# Process $pid returned successfully."
+    fi
+done
+
+if [[ $any_success -eq 0 ]]; then
+    echo "# Failed on LARGE limit positive testing, no test passes."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+
+echo "# PASSED LARGE limit positive testing."
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
+any_failure=0
+for pid in "${pids[@]}"; do
+    wait "$pid"
+    status=$?
+    if [[ $status -ne 0 ]]; then
+	echo "# Process $pid returned failure."
+        any_failure=1
+    fi
+done
+
+if [[ $any_failure -eq 0 ]]; then
+    echo "# Failed on LARGE limit negative testing, no test fails."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+
+echo "# PASSED LARGE limit negative testing."
+
+echo "# Start 10 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
+        expecting no failure...."
+pids=()
+for i in {1..10}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+any_failure=0
+for pid in "${pids[@]}"; do
+    wait "$pid"
+    status=$?
+    if [[ $status -ne 0 ]]; then
+	echo "# Process $pid returned failure."
+        any_failure=1
+    fi
+done
+
+if [[ $any_failure -ne 0 ]]; then
+    echo "# Failed on LARGER limit, at least one test fails."
+    cgdelete -r -g misc:$TEST_ROOT_CG
+    exit 1
+fi
+
+echo "# PASSED LARGER limit tests."
+
+
+echo "# Start 10 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
+      randomly kill one, expecting no failure...."
+pids=()
+for i in {1..10}; do
+    (
+        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
+    ) &
+    pids+=($!)
+done
+
+sleep $((RANDOM % 10 + 5))
+
+# Randomly select a PID to kill
+RANDOM_INDEX=$((RANDOM % 10))
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
+
+sleep 1
+
+USAGE=$(grep '^sgx_epc' "$CG_ROOT/$TEST_ROOT_CG/misc.current" | awk '{print $2}')
+if [ "$USAGE" -ne 0 ]; then
+    echo "# Failed: Final usage is $USAGE, not 0."
+else
+    echo "# PASSED leakage check."
+    echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
+fi
+cgdelete -r -g misc:$TEST_ROOT_CG
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


