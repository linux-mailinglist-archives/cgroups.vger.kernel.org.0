Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC33CB8C0
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2019 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJDK6N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Oct 2019 06:58:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:55186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfJDK6H (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9295AD78;
        Fri,  4 Oct 2019 10:58:05 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 5/5] selftests: cgroup: Run test_core under interfering stress
Date:   Fri,  4 Oct 2019 12:57:43 +0200
Message-Id: <20191004105743.363-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004105743.363-1-mkoutny@suse.com>
References: <20191004105743.363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test_core tests various cgroup creation/removal and task migration
paths. Run the tests repeatedly with interfering noise (for lockdep
checks). Currently, forking noise and subsystem enabled/disabled
switching are the implemented noises.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/test_stress.sh |   4 +
 tools/testing/selftests/cgroup/with_stress.sh | 101 ++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100755 tools/testing/selftests/cgroup/test_stress.sh
 create mode 100755 tools/testing/selftests/cgroup/with_stress.sh

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 1c9179400be0..66aafe1f5746 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -3,6 +3,8 @@ CFLAGS += -Wall -pthread
 
 all:
 
+TEST_FILES     := with_stress.sh
+TEST_PROGS     := test_stress.sh
 TEST_GEN_PROGS = test_memcontrol
 TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
new file mode 100755
index 000000000000..15d9d5896394
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_stress.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+./with_stress.sh -s subsys -s fork ./test_core
diff --git a/tools/testing/selftests/cgroup/with_stress.sh b/tools/testing/selftests/cgroup/with_stress.sh
new file mode 100755
index 000000000000..e28c35008f5b
--- /dev/null
+++ b/tools/testing/selftests/cgroup/with_stress.sh
@@ -0,0 +1,101 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+stress_fork()
+{
+	while true ; do
+		/usr/bin/true
+		sleep 0.01
+	done
+}
+
+stress_subsys()
+{
+	local verb=+
+	while true ; do
+		echo $verb$subsys_ctrl >$sysfs/cgroup.subtree_control
+		[ $verb = "+" ] && verb=- || verb=+
+		# incommensurable period with other stresses
+		sleep 0.011
+	done
+}
+
+init_and_check()
+{
+	sysfs=`mount -t cgroup2 | head -1 | awk '{ print $3 }'`
+	if [ ! -d "$sysfs" ]; then
+		echo "Skipping: cgroup2 is not mounted" >&2
+		exit $ksft_skip
+	fi
+
+	if ! echo +$subsys_ctrl >$sysfs/cgroup.subtree_control ; then
+		echo "Skipping: cannot enable $subsys_ctrl in $sysfs" >&2
+		exit $ksft_skip
+	fi
+
+	if ! echo -$subsys_ctrl >$sysfs/cgroup.subtree_control ; then
+		echo "Skipping: cannot disable $subsys_ctrl in $sysfs" >&2
+		exit $ksft_skip
+	fi
+}
+
+declare -a stresses
+declare -a stress_pids
+duration=5
+rc=0
+subsys_ctrl=cpuset
+sysfs=
+
+while getopts c:d:hs: opt; do
+	case $opt in
+	c)
+		subsys_ctrl=$OPTARG
+		;;
+	d)
+		duration=$OPTARG
+		;;
+	h)
+		echo "Usage $0 [ -s stress ] ... [ -d duration ] [-c controller] cmd args .."
+		echo -e "\t default duration $duration seconds"
+		echo -e "\t default controller $subsys_ctrl"
+		exit
+		;;
+	s)
+		func=stress_$OPTARG
+		if [ "x$(type -t $func)" != "xfunction" ] ; then
+			echo "Unknown stress $OPTARG"
+			exit 1
+		fi
+		stresses+=($func)
+		;;
+	esac
+done
+shift $((OPTIND - 1))
+
+init_and_check
+
+for s in ${stresses[*]} ; do
+	$s &
+	stress_pids+=($!)
+done
+
+
+time=0
+start=$(date +%s)
+
+while [ $time -lt $duration ] ; do
+	$*
+	rc=$?
+	[ $rc -eq 0 ] || break
+	time=$(($(date +%s) - $start))
+done
+
+for pid in ${stress_pids[*]} ; do
+	kill -SIGTERM $pid
+	wait $pid
+done
+
+exit $rc
-- 
2.21.0

