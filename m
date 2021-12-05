Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4603B468CD1
	for <lists+cgroups@lfdr.de>; Sun,  5 Dec 2021 19:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhLESgw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Dec 2021 13:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237506AbhLESgs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Dec 2021 13:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638729200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srW5FvViVNlgVQPZi0XRS0cVWIEUmnmolBehdDs0pR8=;
        b=C2/LhR0IpaGYj9q7mQ15XAccqJAk2ebeM9KjFBqVjtdwDKqzdClx2jswjWmLa+lwoRU7w3
        A7YAuPPYexYoyTWT269V8H7BHcDSMhQg1k/4zIRSdUaDrfvp6WdDIzWjYBtu95ZRcaUhoT
        lQD7r6rfCO2Jo0Pqsa7oF6laR00r6d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-VvFj3pxvPwSdcHcCpqrG0w-1; Sun, 05 Dec 2021 13:33:17 -0500
X-MC-Unique: VvFj3pxvPwSdcHcCpqrG0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2123C18A0F1B;
        Sun,  5 Dec 2021 18:33:15 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBD3694C0;
        Sun,  5 Dec 2021 18:33:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 7/7] kselftest/cgroup: Add cpuset v2 partition root state test
Date:   Sun,  5 Dec 2021 13:32:20 -0500
Message-Id: <20211205183220.818872-8-longman@redhat.com>
In-Reply-To: <20211205183220.818872-1-longman@redhat.com>
References: <20211205183220.818872-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a test script test_cpuset_prs.sh with a helper program wait_inotify
for exercising the cpuset v2 partition root state code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 667 ++++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  87 +++
 3 files changed, 757 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 59e222460581..3f1fd3f93f41 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wall -pthread
 
-all:
+all: ${HELPER_PROGS}
 
 TEST_FILES     := with_stress.sh
-TEST_PROGS     := test_stress.sh
+TEST_PROGS     := test_stress.sh test_cpuset_prs.sh
+TEST_GEN_FILES := wait_inotify
 TEST_GEN_PROGS = test_memcontrol
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_core
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
new file mode 100755
index 000000000000..cf8d20e3c544
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -0,0 +1,667 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test for cpuset v2 partition root state (PRS)
+#
+# The sched verbose flag is set, if available, so that the console log
+# can be examined for the correct setting of scheduling domain.
+#
+
+skip_test() {
+	echo "$1"
+	echo "Test SKIPPED"
+	exit 0
+}
+
+[[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
+
+# Set sched verbose flag, if available
+[[ -d /sys/kernel/debug/sched ]] && echo Y > /sys/kernel/debug/sched/verbose
+
+# Get wait_inotify location
+WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
+
+# Find cgroup v2 mount point
+CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+[[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
+
+CPUS=$(lscpu | grep "^CPU(s)" | sed -e "s/.*:[[:space:]]*//")
+[[ $CPUS -lt 8 ]] && skip_test "Test needs at least 8 cpus available!"
+
+# Set verbose flag and delay factor
+PROG=$1
+VERBOSE=
+DELAY_FACTOR=1
+while [[ "$1" = -* ]]
+do
+	case "$1" in
+		-v) VERBOSE=1
+		    break
+		    ;;
+		-d) DELAY_FACTOR=$2
+		    shift
+		    break
+		    ;;
+		*)  echo "Usage: $PROG [-v] [-d <delay-factor>"
+		    exit
+		    ;;
+	esac
+	shift
+done
+
+cd $CGROUP2
+echo +cpuset > cgroup.subtree_control
+[[ -d test ]] || mkdir test
+cd test
+
+# Pause in ms
+pause()
+{
+	DELAY=$1
+	LOOP=0
+	while [[ $LOOP -lt $DELAY_FACTOR ]]
+	do
+		sleep $DELAY
+		((LOOP++))
+	done
+	return 0
+}
+
+console_msg()
+{
+	MSG=$1
+	echo "$MSG"
+	echo "" > /dev/console
+	echo "$MSG" > /dev/console
+	pause 0.01
+}
+
+test_partition()
+{
+	EXPECTED_VAL=$1
+	echo $EXPECTED_VAL > cpuset.cpus.partition
+	[[ $? -eq 0 ]] || exit 1
+	ACTUAL_VAL=$(cat cpuset.cpus.partition)
+	[[ $ACTUAL_VAL != $EXPECTED_VAL ]] && {
+		echo "cpuset.cpus.partition: expect $EXPECTED_VAL, found $EXPECTED_VAL"
+		echo "Test FAILED"
+		exit 1
+	}
+}
+
+test_effective_cpus()
+{
+	EXPECTED_VAL=$1
+	ACTUAL_VAL=$(cat cpuset.cpus.effective)
+	[[ "$ACTUAL_VAL" != "$EXPECTED_VAL" ]] && {
+		echo "cpuset.cpus.effective: expect '$EXPECTED_VAL', found '$EXPECTED_VAL'"
+		echo "Test FAILED"
+		exit 1
+	}
+}
+
+# Adding current process to cgroup.procs as a test
+test_add_proc()
+{
+	OUTSTR="$1"
+	ERRMSG=$((echo $$ > cgroup.procs) |& cat)
+	echo $ERRMSG | grep -q "$OUTSTR"
+	[[ $? -ne 0 ]] && {
+		echo "cgroup.procs: expect '$OUTSTR', got '$ERRMSG'"
+		echo "Test FAILED"
+		exit 1
+	}
+	echo $$ > $CGROUP2/cgroup.procs	# Move out the task
+}
+
+#
+# Testing the new "isolated" partition root type
+#
+test_isolated()
+{
+	echo 2-3 > cpuset.cpus
+	TYPE=$(cat cpuset.cpus.partition)
+	[[ $TYPE = member ]] || echo member > cpuset.cpus.partition
+
+	console_msg "Change from member to root"
+	test_partition root
+
+	console_msg "Change from root to isolated"
+	test_partition isolated
+
+	console_msg "Change from isolated to member"
+	test_partition member
+
+	console_msg "Change from member to isolated"
+	test_partition isolated
+
+	console_msg "Change from isolated to root"
+	test_partition root
+
+	console_msg "Change from root to member"
+	test_partition member
+
+	#
+	# Testing partition root with no cpu
+	#
+	console_msg "Distribute all cpus to child partition"
+	echo +cpuset > cgroup.subtree_control
+	test_partition root
+
+	mkdir A1
+	cd A1
+	echo 2-3 > cpuset.cpus
+	test_partition root
+	test_effective_cpus 2-3
+	cd ..
+	test_effective_cpus ""
+
+	console_msg "Moving task to partition test"
+	test_add_proc "No space left"
+	cd A1
+	test_add_proc ""
+	cd ..
+
+	console_msg "Shrink and expand child partition"
+	cd A1
+	echo 2 > cpuset.cpus
+	cd ..
+	test_effective_cpus 3
+	cd A1
+	echo 2-3 > cpuset.cpus
+	cd ..
+	test_effective_cpus ""
+
+	# Cleaning up
+	console_msg "Cleaning up"
+	echo $$ > $CGROUP2/cgroup.procs
+	[[ -d A1 ]] && rmdir A1
+}
+
+#
+# Cpuset controller state transition test matrix.
+#
+# Cgroup test hierarchy
+#
+# test -- A1 -- A2 -- A3
+#      \- B1
+#
+#  P<v> = set cpus.partition (0:member, 1:root, 2:isolated, -1:root invalid)
+#  C<l> = add cpu-list
+#  S<p> = use prefix in subtree_control
+#  T    = put a task into cgroup
+#  O<c>-<v> = Write <v> to CPU online file of <c>
+#
+SETUP_A123_PARTITIONS="C1-3:P1:S+ C2-3:P1:S+ C3:P1"
+TEST_MATRIX=(
+	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
+	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
+	"  S+    C0-1     .      .    C2-3    S+    C4-5     .      .     0 A2:0-1"
+	"  S+    C0-1     .      .    C2-3    P1      .      .      .     0 "
+	"  S+    C0-1     .      .    C2-3   P1:S+ C0-1:P1   .      .     0 "
+	"  S+    C0-1     .      .    C2-3   P1:S+  C1:P1    .      .     0 "
+	"  S+   C0-1:S+   .      .    C2-3     .      .      .     P1     0 "
+	"  S+   C0-1:P1   .      .    C2-3    S+     C1      .      .     0 "
+	"  S+   C0-1:P1   .      .    C2-3    S+    C1:P1    .      .     0 "
+	"  S+   C0-1:P1   .      .    C2-3    S+    C1:P1    .     P1     0 "
+	"  S+   C0-1:P1   .      .    C2-3   C4-5     .      .      .     0 A1:4-5"
+	"  S+   C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     0 A1:4-5"
+	"  S+    C0-1     .      .   C2-3:P1   .      .      .     C2     0 "
+	"  S+    C0-1     .      .   C2-3:P1   .      .      .    C4-5    0 B1:4-5"
+	"  S+ C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1,A2:2-3"
+	"  S+ C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1,A2:2-3"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3,A2:3 A1:P1,A2:P0"
+	"  S+ C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4,A2:2"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:,B1:0-2 A1:P1,A2:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+
+	# CPU offlining cases:
+	"  S+    C0-1     .      .    C2-3    S+    C4-5     .     O2-0   0 A1:0-1,B1:3"
+	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O2-0    .      .      .     0 A1:0-1,A2:3"
+	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O2-0   O2-1    .      .     0 A1:0-1,A2:2-3"
+	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O1-0    .      .      .     0 A1:0,A2:2-3"
+	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O1-0   O1-1    .      .     0 A1:0-1,A2:2-3"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     O3-0   O3-1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"  S+ C2-3:P1:S+  C3:P2  .      .     O3-0   O3-1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     O2-0   O2-1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"  S+ C2-3:P1:S+  C3:P2  .      .     O2-0   O2-1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     O2-0    .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
+	"  S+ C2-3:P1:S+  C3:P1  .      .     O3-0    .      .      .     0 A1:2,A2: A1:P1,A2:P1"
+	"  S+ C2-3:P1:S+  C3:P1  .      .    T:O2-0   .      .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
+	"  S+ C2-3:P1:S+  C3:P1  .      .      .    T:O3-0   .      .     0 A1:2,A2:2 A1:P1,A2:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    .     O1-0    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .     O2-0    .      .      .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .     O3-0    .      .      .     0 A1:1,A2:2,A3: A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    .      .    T:O2-0   .      .     0 A1:1,A2:3,A3:3 A1:P1,A2:P1,A3:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    .      .      .    T:O3-0   .     0 A1:1,A2:2,A3:2 A1:P1,A2:P1,A3:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0  O1-1    .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .      .    T:O2-0  O2-1    .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .      .      .    T:O3-0  O3-1   0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0  O2-0   O1-1    .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
+	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0  O2-0   O2-1    .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+
+	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
+	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
+	#
+	# Incorrect change to cpuset.cpus invalidates partition root
+	#
+	# Adding CPUs to partition root that are not in parent's
+	# cpuset.cpus is allowed, but those extra CPUs are ignored.
+	"  S+ C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:,A2:2-3 A1:P1,A2:P1"
+
+	# Taking away all CPUs from parent or itself if there are tasks
+	# will make the partition invalid.
+	"  S+ C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+
+	# Changing a partition root to member makes child partitions invalid
+	"  S+ C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3,A2:3 A1:P0,A2:P-1"
+	"  S+ $SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P0,A3:P-1"
+
+	# cpuset.cpus can contains cpus not in parent's cpuset.cpus as long
+	# as they overlap.
+	"  S+ C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+
+	# Deletion of CPUs distributed to child cgroup is allowed.
+	"  S+ C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5,A2:4-5"
+
+	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
+	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
+	# Failure cases:
+
+	# To become a partition root, cpuset.cpus must overlap parent's
+	# cpuset.cpus.
+	"  S+    C0-1     .      .    C2-3    S+   C4-5:P1   .      .     1 "
+
+	# A cpuset cannot become a partition root if it has child cpusets
+	# with non-empty cpuset.cpus.
+	"  S+   C0-1:S+   C1     .    C2-3    P1      .      .      .     1 "
+
+	# Any change to cpuset.cpus of a partition root must be exclusive.
+	"  S+   C0-1:P1   .      .    C2-3   C0-2     .      .      .     1 "
+	"  S+    C0-1     .      .   C2-3:P1   .      .      .     C1     1 "
+	"  S+ C2-3:P1:S+  C2:P1  .     C1    C1-3     .      .      .     1 "
+
+	# A task cannot be added to a partition with no cpu
+	"  S+ C2-3:P1:S+  C3:P1  .      .    O2-0:T   .      .      .     1 A1:,A2:3 A1:P1,A2:P1"
+)
+
+#
+# Write to the cpu online file
+#  $1 - <c>-<v> where <c> = cpu number, <v> value to be written
+#
+write_cpu_online()
+{
+	CPU=${1%-*}
+	VAL=${1#*-}
+	CPUFILE=//sys/devices/system/cpu/cpu${CPU}/online
+	if [[ $VAL -eq 0 ]]
+	then
+		OFFLINE_CPUS="$OFFLINE_CPUS $CPU"
+	else
+		[[ -n "$OFFLINE_CPUS" ]] && {
+			OFFLINE_CPUS=$(echo $CPU $CPU $OFFLINE_CPUS | fmt -1 |\
+					sort | uniq -u)
+		}
+	fi
+	echo $VAL > $CPUFILE
+	pause 0.01
+}
+
+#
+# Set controller state
+#  $1 - cgroup directory
+#  $2 - state
+#  $3 - showerr
+#
+# The presence of ":" in state means transition from one to the next.
+#
+set_ctrl_state()
+{
+	TMPMSG=/tmp/.msg_$$
+	CGRP=$1
+	STATE=$2
+	SHOWERR=${3}${VERBOSE}
+	CTRL=${CTRL:=$CONTROLLER}
+	HASERR=0
+	REDIRECT="2> $TMPMSG"
+	[[ -z "$STATE" || "$STATE" = '.' ]] && return 0
+
+	rm -f $TMPMSG
+	for CMD in $(echo $STATE | sed -e "s/:/ /g")
+	do
+		TFILE=$CGRP/cgroup.procs
+		SFILE=$CGRP/cgroup.subtree_control
+		PFILE=$CGRP/cpuset.cpus.partition
+		CFILE=$CGRP/cpuset.cpus
+		S=$(expr substr $CMD 1 1)
+		if [[ $S = S ]]
+		then
+			PREFIX=${CMD#?}
+			COMM="echo ${PREFIX}${CTRL} > $SFILE"
+			eval $COMM $REDIRECT
+		elif [[ $S = C ]]
+		then
+			CPUS=${CMD#?}
+			COMM="echo $CPUS > $CFILE"
+			eval $COMM $REDIRECT
+		elif [[ $S = P ]]
+		then
+			VAL=${CMD#?}
+			case $VAL in
+			0)  VAL=member
+			    ;;
+			1)  VAL=root
+			    ;;
+			2)  VAL=isolated
+			    ;;
+			*)
+			    echo "Invalid partition state - $VAL"
+			    exit 1
+			    ;;
+			esac
+			COMM="echo $VAL > $PFILE"
+			eval $COMM $REDIRECT
+		elif [[ $S = O ]]
+		then
+			VAL=${CMD#?}
+			write_cpu_online $VAL
+		elif [[ $S = T ]]
+		then
+			COMM="echo 0 > $TFILE"
+			eval $COMM $REDIRECT
+		fi
+		RET=$?
+		[[ $RET -ne 0 ]] && {
+			[[ -n "$SHOWERR" ]] && {
+				echo "$COMM"
+				cat $TMPMSG
+			}
+			HASERR=1
+		}
+		pause 0.01
+		rm -f $TMPMSG
+	done
+	return $HASERR
+}
+
+set_ctrl_state_noerr()
+{
+	CGRP=$1
+	STATE=$2
+	[[ -d $CGRP ]] || mkdir $CGRP
+	set_ctrl_state $CGRP $STATE 1
+	[[ $? -ne 0 ]] && {
+		echo "ERROR: Failed to set $2 to cgroup $1!"
+		exit 1
+	}
+}
+
+online_cpus()
+{
+	[[ -n "OFFLINE_CPUS" ]] && {
+		for C in $OFFLINE_CPUS
+		do
+			write_cpu_online ${C}-1
+		done
+	}
+}
+
+#
+# Return 1 if the list of effective cpus isn't the same as the initial list.
+#
+reset_cgroup_states()
+{
+	echo 0 > $CGROUP2/cgroup.procs
+	online_cpus
+	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
+	set_ctrl_state . S-
+	pause 0.01
+}
+
+dump_states()
+{
+	for DIR in A1 A1/A2 A1/A2/A3 B1
+	do
+		ECPUS=$DIR/cpuset.cpus.effective
+		PRS=$DIR/cpuset.cpus.partition
+		[[ -e $ECPUS ]] && echo "$ECPUS: $(cat $ECPUS)"
+		[[ -e $PRS   ]] && echo "$PRS: $(cat $PRS)"
+	done
+}
+
+#
+# Check effective cpus
+# $1 - check string, format: <cgroup>:<cpu-list>[,<cgroup>:<cpu-list>]*
+#
+check_effective_cpus()
+{
+	CHK_STR=$1
+	for CHK in $(echo $CHK_STR | sed -e "s/,/ /g")
+	do
+		set -- $(echo $CHK | sed -e "s/:/ /g")
+		CGRP=$1
+		CPUS=$2
+		[[ $CGRP = A2 ]] && CGRP=A1/A2
+		[[ $CGRP = A3 ]] && CGRP=A1/A2/A3
+		FILE=$CGRP/cpuset.cpus.effective
+		[[ -e $FILE ]] || return 1
+		[[ $CPUS = $(cat $FILE) ]] || return 1
+	done
+}
+
+#
+# Check cgroup states
+#  $1 - check string, format: <cgroup>:<state>[,<cgroup>:<state>]*
+#
+check_cgroup_states()
+{
+	CHK_STR=$1
+	for CHK in $(echo $CHK_STR | sed -e "s/,/ /g")
+	do
+		set -- $(echo $CHK | sed -e "s/:/ /g")
+		CGRP=$1
+		STATE=$2
+		FILE=
+		EVAL=$(expr substr $STATE 2 2)
+		[[ $CGRP = A2 ]] && CGRP=A1/A2
+		[[ $CGRP = A3 ]] && CGRP=A1/A2/A3
+
+		case $STATE in
+			P*) FILE=$CGRP/cpuset.cpus.partition
+			    ;;
+			*)  echo "Unknown state: $STATE!"
+			    exit 1
+			    ;;
+		esac
+		VAL=$(cat $FILE)
+
+		case "$VAL" in
+			member) VAL=0
+				;;
+			root)	VAL=1
+				;;
+			isolated)
+				VAL=2
+				;;
+			"root invalid"*)
+				VAL=-1
+				;;
+		esac
+		[[ $EVAL != $VAL ]] && return 1
+	done
+	return 0
+}
+
+#
+# Run cpuset state transition test
+#  $1 - test matrix name
+#
+# This test is somewhat fragile as delays (sleep x) are added in various
+# places to make sure state changes are fully propagated before the next
+# action. These delays may need to be adjusted if running in a slower machine.
+#
+run_state_test()
+{
+	TEST=$1
+	CONTROLLER=cpuset
+	CPULIST=0-6
+	I=0
+	eval CNT="\${#$TEST[@]}"
+
+	reset_cgroup_states
+	echo $CPULIST > cpuset.cpus
+	echo root > cpuset.cpus.partition
+	console_msg "Running state transition test ..."
+
+	while [[ $I -lt $CNT ]]
+	do
+		echo "Running test $I ..." > /dev/console
+		eval set -- "\${$TEST[$I]}"
+		ROOT=$1
+		OLD_A1=$2
+		OLD_A2=$3
+		OLD_A3=$4
+		OLD_B1=$5
+		NEW_A1=$6
+		NEW_A2=$7
+		NEW_A3=$8
+		NEW_B1=$9
+		RESULT=${10}
+		ECPUS=${11}
+		STATES=${12}
+
+		set_ctrl_state_noerr .        $ROOT
+		set_ctrl_state_noerr A1       $OLD_A1
+		set_ctrl_state_noerr A1/A2    $OLD_A2
+		set_ctrl_state_noerr A1/A2/A3 $OLD_A3
+		set_ctrl_state_noerr B1       $OLD_B1
+		RETVAL=0
+		set_ctrl_state A1       $NEW_A1; ((RETVAL += $?))
+		set_ctrl_state A1/A2    $NEW_A2; ((RETVAL += $?))
+		set_ctrl_state A1/A2/A3 $NEW_A3; ((RETVAL += $?))
+		set_ctrl_state B1       $NEW_B1; ((RETVAL += $?))
+
+		[[ $RETVAL -ne $RESULT ]] && {
+			echo "Test $TEST[$I] failed result check!"
+			eval echo \"\${$TEST[$I]}\"
+			dump_states
+			online_cpus
+			exit 1
+		}
+
+		[[ -n "$ECPUS" && "$ECPUS" != . ]] && {
+			check_effective_cpus $ECPUS
+			[[ $? -ne 0 ]] && {
+				echo "Test $TEST[$I] failed effective CPU check!"
+				eval echo \"\${$TEST[$I]}\"
+				echo
+				dump_states
+				online_cpus
+				exit 1
+			}
+		}
+
+		[[ -n "$STATES" ]] && {
+			check_cgroup_states $STATES
+			[[ $? -ne 0 ]] && {
+				echo "FAILED: Test $TEST[$I] failed states check!"
+				eval echo \"\${$TEST[$I]}\"
+				echo
+				dump_states
+				online_cpus
+				exit 1
+			}
+		}
+
+		reset_cgroup_states
+		#
+		# Check to see if effective cpu list changes
+		#
+		pause 0.05
+		NEWLIST=$(cat cpuset.cpus.effective)
+		[[ $NEWLIST != $CPULIST ]] && {
+			echo "Effective cpus changed to $NEWLIST after test $I!"
+			exit 1
+		}
+		[[ -n "$VERBOSE" ]] && echo "Test $I done."
+		((I++))
+	done
+	echo "All $I tests of $TEST PASSED."
+
+	echo member > cpuset.cpus.partition
+}
+
+#
+# Wait for inotify event for the given file and read it
+# $1: cgroup file to wait for
+# $2: file to store the read result
+#
+wait_inotify()
+{
+	CGROUP_FILE=$1
+	OUTPUT_FILE=$2
+
+	$WAIT_INOTIFY $CGROUP_FILE
+	cat $CGROUP_FILE > $OUTPUT_FILE
+}
+
+#
+# Test if inotify events are properly generated when going into and out of
+# invalid partition state.
+#
+test_inotify()
+{
+	ERR=0
+	PRS=/tmp/.prs_$$
+	[[ -f $WAIT_INOTIFY ]] || {
+		echo "wait_inotify not found, inotify test SKIPPED."
+		return
+	}
+
+	pause 0.01
+	echo 1 > cpuset.cpus
+	echo 0 > cgroup.procs
+	echo root > cpuset.cpus.partition
+	pause 0.01
+	rm -f $PRS
+	wait_inotify $PWD/cpuset.cpus.partition $PRS &
+	pause 0.01
+	set_ctrl_state . "O1-0"
+	pause 0.01
+	check_cgroup_states ".:P-1"
+	if [[ $? -ne 0 ]]
+	then
+		echo "FAILED: Inotify test - partition not invalid"
+		ERR=1
+	elif [[ ! -f $PRS ]]
+	then
+		echo "FAILED: Inotify test - event not generated"
+		ERR=1
+		kill %1
+	elif [[ $(cat $PRS) != "root invalid"* ]]
+	then
+		echo "FAILED: Inotify test - incorrect state"
+		cat $PRS
+		ERR=1
+	fi
+	online_cpus
+	echo member > cpuset.cpus.partition
+	echo 0 > ../cgroup.procs
+	if [[ $ERR -ne 0 ]]
+	then
+		exit 1
+	else
+		echo "Inotify test PASSED"
+	fi
+}
+
+run_state_test TEST_MATRIX
+test_isolated
+test_inotify
+echo "All tests PASSED."
+cd ..
+rmdir test
diff --git a/tools/testing/selftests/cgroup/wait_inotify.c b/tools/testing/selftests/cgroup/wait_inotify.c
new file mode 100644
index 000000000000..e11b431e1b62
--- /dev/null
+++ b/tools/testing/selftests/cgroup/wait_inotify.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wait until an inotify event on the given cgroup file.
+ */
+#include <linux/limits.h>
+#include <sys/inotify.h>
+#include <sys/mman.h>
+#include <sys/ptrace.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static const char usage[] = "Usage: %s [-v] <cgroup_file>\n";
+static char *file;
+static int verbose;
+
+static inline void fail_message(char *msg)
+{
+	fprintf(stderr, msg, file);
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	char *cmd = argv[0];
+	int c, fd;
+	struct pollfd fds = { .events = POLLIN, };
+
+	while ((c = getopt(argc, argv, "v")) != -1) {
+		switch (c) {
+		case 'v':
+			verbose++;
+			break;
+		}
+		argv++, argc--;
+	}
+
+	if (argc != 2) {
+		fprintf(stderr, usage, cmd);
+		return -1;
+	}
+	file = argv[1];
+	fd = open(file, O_RDONLY);
+	if (fd < 0)
+		fail_message("Cgroup file %s not found!\n");
+	close(fd);
+
+	fd = inotify_init();
+	if (fd < 0)
+		fail_message("inotify_init() fails on %s!\n");
+	if (inotify_add_watch(fd, file, IN_MODIFY) < 0)
+		fail_message("inotify_add_watch() fails on %s!\n");
+	fds.fd = fd;
+
+	/*
+	 * poll waiting loop
+	 */
+	for (;;) {
+		int ret = poll(&fds, 1, 10000);
+
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			perror("poll");
+			exit(1);
+		}
+		if ((ret > 0) && (fds.revents & POLLIN))
+			break;
+	}
+	if (verbose) {
+		struct inotify_event events[10];
+		long len;
+
+		usleep(1000);
+		len = read(fd, events, sizeof(events));
+		printf("Number of events read = %ld\n",
+			len/sizeof(struct inotify_event));
+	}
+	close(fd);
+	return 0;
+}
-- 
2.27.0

