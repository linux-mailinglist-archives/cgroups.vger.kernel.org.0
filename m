Return-Path: <cgroups+bounces-4615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE06965E10
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A50288019
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC618E35D;
	Fri, 30 Aug 2024 10:10:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866D184543;
	Fri, 30 Aug 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012628; cv=none; b=dYi+9XOBju+3my8FoWt9xuDLZ09shXODTmn0s2XvXYfrZOEynlACrXvpXHuTwsn4Lfqg3+YYR7D/rGAisECHdN6qiiLQ8uCxUSZ+47ctyLnfgv7zyVxerewqQGS/kOyVGVBOdNspfuThAuhBXV/DPve5fTtQuC+s6KDx8lnAJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012628; c=relaxed/simple;
	bh=OtL1qNuIN4q0YMRrYxmaw+dGUho+R7FjVT43ek4uBCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tl7oUTrBv/Yf+DNmWVlaDzFjBGhZJPbN9UCO3DDsNE+r3TxEN+XsvuDQYZ5y2iuUZZ/4ZCTeNdZ0HjvXRCUnS7u+268OCXIzUZtC4tm534ZMyScjL4hn/qNM6ZS3+a8MPDD5GCqj7vtHtzV5ZBj5LXKihvEXv3uvGWAJeZJQsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwDPg3x6CzpV5n;
	Fri, 30 Aug 2024 18:08:39 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 89DC8180105;
	Fri, 30 Aug 2024 18:10:24 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 18:10:23 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v4 -next 12/12] cgroup/cpuset: add sefltest for cpuset v1
Date: Fri, 30 Aug 2024 10:02:29 +0000
Message-ID: <20240830100229.953012-13-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
References: <20240830100229.953012-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

There is only hotplug test for cpuset v1, just add base read/write test
for cpuset v1.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 MAINTAINERS                                   |  1 +
 .../selftests/cgroup/test_cpuset_v1_base.sh   | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b5ec1cafd95..b59f54e1e30d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5703,6 +5703,7 @@ F:	kernel/cgroup/cpuset-v1.c
 F:	kernel/cgroup/cpuset.c
 F:	tools/testing/selftests/cgroup/test_cpuset.c
 F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
+F:	tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
 
 CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_base.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
new file mode 100755
index 000000000000..42a6628fb8bc
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Basc test for cpuset v1 interfaces write/read
+#
+
+skip_test() {
+	echo "$1"
+	echo "Test SKIPPED"
+	exit 4 # ksft_skip
+}
+
+write_test() {
+	dir=$1
+	interface=$2
+	value=$3
+	original=$(cat $dir/$interface)
+	echo "testing $interface $value"
+	echo $value > $dir/$interface
+	new=$(cat $dir/$interface)
+	[[ $value -ne $(cat $dir/$interface) ]] && {
+		echo "$interface write $value failed: new:$new"
+		exit 1
+	}
+}
+
+[[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
+
+# Find cpuset v1 mount point
+CPUSET=$(mount -t cgroup | grep cpuset | head -1 | awk '{print $3}')
+[[ -n "$CPUSET" ]] || skip_test "cpuset v1 mount point not found!"
+
+#
+# Create a test cpuset, read write test
+#
+TDIR=test$$
+[[ -d $CPUSET/$TDIR ]] || mkdir $CPUSET/$TDIR
+
+ITF_MATRIX=(
+	#interface			value		expect 	root_only
+	'cpuset.cpus			0-1		0-1	0'
+	'cpuset.mem_exclusive		1		1	0'
+	'cpuset.mem_exclusive		0		0	0'
+	'cpuset.mem_hardwall		1		1	0'
+	'cpuset.mem_hardwall		0		0	0'
+	'cpuset.memory_migrate		1		1	0'
+	'cpuset.memory_migrate		0		0	0'
+	'cpuset.memory_spread_page	1		1	0'
+	'cpuset.memory_spread_page	0		0	0'
+	'cpuset.memory_spread_slab	1		1	0'
+	'cpuset.memory_spread_slab	0		0	0'
+	'cpuset.mems			0		0	0'
+	'cpuset.sched_load_balance	1		1	0'
+	'cpuset.sched_load_balance	0		0	0'
+	'cpuset.sched_relax_domain_level	2	2	0'
+	'cpuset.memory_pressure_enabled	1		1	1'
+	'cpuset.memory_pressure_enabled	0		0	1'
+)
+
+run_test()
+{
+	cnt="${ITF_MATRIX[@]}"
+	for i in "${ITF_MATRIX[@]}" ; do
+		args=($i)
+		root_only=${args[3]}
+		[[ $root_only -eq 1 ]] && {
+			write_test "$CPUSET" "${args[0]}" "${args[1]}" "${args[2]}"
+			continue
+		}
+		write_test "$CPUSET/$TDIR" "${args[0]}" "${args[1]}" "${args[2]}"
+	done
+}
+
+run_test
+rmdir $CPUSET/$TDIR
+echo "Test PASSED"
+exit 0
-- 
2.34.1


