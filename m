Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC8179DF09
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbjIMEJv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjIMEJN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:09:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3419B4;
        Tue, 12 Sep 2023 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578141; x=1726114141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deuShLNhhDjtFREz/27mivDy0NewVu2ghIGkXQ/WYEo=;
  b=BGRpBZfbppv+HPdcdDiUGm5ZsH97PhSvaBsw8VcWZcpsB4SUH9rRPcfV
   Nmp8pezs6suwzQuuJhnFzIiQR5lmRF3hvk1kfKY8CkeyVSHrBbTZqsuMZ
   2x6RlryAKoFTAPLCaGU9UbSl+GlI7uEdqeQUT6C4+OvKnUXR9BS6dT+kn
   H1ckmoL9mD9l+iIfzuFZl7sS4xcUbXYJKUqbjgYEFjXUquytISxIpW3VZ
   2MddTacl+TuHDhHCz4cCxamn5mK+KueABxA3ldQ2LkslKwcjw2G6rxdyB
   aM0U4WOXSEJEWReESUcw2Gfs32O8BYGQg4gegAA2IREGS7uVIUXNuTI36
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990526"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990526"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747156021"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747156021"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:56 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 18/18] selftests/sgx: Add scripts for epc cgroup testing
Date:   Tue, 12 Sep 2023 21:06:35 -0700
Message-Id: <20230913040635.28815-19-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Scripts rely on cgroup-tools package from libcgroup [1].

To test:
1) sudo ./setup_epc_cg.sh (optional one time setup)
2) sudo ./run_tests_in_misc_cg.sh

To watch misc group current:
./watch_misc_for_tests.sh current

[1] https://github.com/libcgroup/libcgroup/blob/main/README

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V4:

Note: Need to apply on top of this series previously reviewed:
https://lore.kernel.org/linux-sgx/20220905020411.17290-1-jarkko@kernel.org/
---
 .../selftests/sgx/run_tests_in_misc_cg.sh     | 68 +++++++++++++++++++
 tools/testing/selftests/sgx/setup_epc_cg.sh   | 29 ++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     | 13 ++++
 3 files changed, 110 insertions(+)
 create mode 100755 tools/testing/selftests/sgx/run_tests_in_misc_cg.sh
 create mode 100755 tools/testing/selftests/sgx/setup_epc_cg.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

diff --git a/tools/testing/selftests/sgx/run_tests_in_misc_cg.sh b/tools/testing/selftests/sgx/run_tests_in_misc_cg.sh
new file mode 100755
index 000000000000..63da7b23b74e
--- /dev/null
+++ b/tools/testing/selftests/sgx/run_tests_in_misc_cg.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023 Intel Corporation.
+
+if ! lscgroup | grep -q "test/test1/test3$"; then
+  echo "setting up cgroups for testing..."
+  ./setup_epc_cg.sh
+fi
+
+cmd='./test_sgx'
+default_test="augment_via_eaccept_long"
+
+# We use 'tail' to skip header lines and 'sed' to remove 'enclave' from the first non-header line.
+list=$($cmd -l 2>&1 | tail -n +4 | sed '0,/^enclave/ s/^enclave//' | sed 's/^ *//')
+
+IFS=$'\n' read -d '' -r -a lines <<< "$list"
+lines=("all" "${lines[@]}")
+
+echo "Available tests:"
+for i in "${!lines[@]}"; do
+  # Check if the current line is the default test
+  if [[ ${lines[$i]} == *"$default_test"* ]]; then
+    echo "$((i)). ${lines[$i]} (default)"
+  else
+    echo "$((i)). ${lines[$i]}"
+  fi
+done
+
+echo "Please enter the number of the test you want to run (or press enter for the default test):"
+read choice
+
+if [ -z "$choice" ]; then
+  testname="$default_test"
+else
+  testname="${lines[$choice]}"
+fi
+
+if [ "$testname" == "all" ]; then
+  test_cmd="$cmd"
+else
+  test_cmd="$cmd -t $testname"
+fi
+
+timestamp=$(date +%Y%m%d_%H%M%S)
+
+# Always use leaf node of misc cgroups so it works for both v1 and v2
+# these may fail on OOM
+nohup bash -c "cgexec -g misc:test/test1/test3 $test_cmd" >test1_1_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test1/test3 $test_cmd" >test1_2_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test1/test3 $test_cmd" >test1_3_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test1/test3 $test_cmd" >test1_4_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test1/test3 $test_cmd" >test1_5_$timestamp.log 2>&1 &
+
+# These tests may timeout on oversubscribed tests on 4G EPC
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_1_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_2_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_3_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_4_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_5_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_6_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_7_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test/test2 $test_cmd" >test2_8_$timestamp.log 2>&1 &
+
+# this should work on 4G EPC
+nohup bash -c "cgexec -g misc:test4 $test_cmd" >test4_1_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test4 $test_cmd" >test4_2_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test4 $test_cmd" >test4_3_$timestamp.log 2>&1 &
+nohup bash -c "cgexec -g misc:test4 $test_cmd" >test4_4_$timestamp.log 2>&1 &
diff --git a/tools/testing/selftests/sgx/setup_epc_cg.sh b/tools/testing/selftests/sgx/setup_epc_cg.sh
new file mode 100755
index 000000000000..5fd137a66436
--- /dev/null
+++ b/tools/testing/selftests/sgx/setup_epc_cg.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023 Intel Corporation.
+
+cgcreate -g misc:test
+if [ $? -ne 0 ]; then
+    echo "Please make sure cgroup-tools is installed, and misc cgroup is mounted."
+    exit 1
+fi
+cgcreate -g misc:test/test1
+cgcreate -g misc:test/test1/test3
+cgcreate -g misc:test/test2
+cgcreate -g misc:test4
+
+# Setup for a platform with 4G EPC
+LARGER=4096000000
+LARGE=409600000
+SMALL=4096000
+if [ ! -d "/sys/fs/cgroup/misc" ]; then
+    echo "cgroups v2 is in use. Only leaf nodes can run a process"
+    echo "sgx_epc $SMALL" | tee /sys/fs/cgroup/test/test1/misc.max
+    echo "sgx_epc $LARGE" | tee /sys/fs/cgroup/test/test2/misc.max
+    echo "sgx_epc $LARGER" | tee /sys/fs/cgroup/test4/misc.max
+else
+    echo "cgroups v1 is in use."
+    echo "sgx_epc $SMALL" | tee /sys/fs/cgroup/misc/test/test1/misc.max
+    echo "sgx_epc $LARGE" | tee /sys/fs/cgroup/misc/test/test2/misc.max
+    echo "sgx_epc $LARGER" | tee /sys/fs/cgroup/misc/test4/misc.max
+fi
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

