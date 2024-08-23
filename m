Return-Path: <cgroups+bounces-4423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3195CA14
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94471F23B24
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00E4189525;
	Fri, 23 Aug 2024 10:09:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E218732D;
	Fri, 23 Aug 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407743; cv=none; b=Qd0TIJWEud0TrSUPzbqSk/p/O+xfLNbOx1N2KwIOuVaRZxR9iJq2QQgSduY8eZJaX/2VUUd80DNLVoLFhCBB8w+SBXVZyTZ8VvpGG7wbBdwqlB+qW2IAXX6katBcEj6A+9TVqpwlaL/cYDcSMabe7HxlY3LnLowjRIRLO/xduxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407743; c=relaxed/simple;
	bh=b+Dxf9DeqLb3tJ4l70KeYnWi9XsnEKwYUfFeY1RV+GA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7FunagccP6nk58bLYTwUKsxTHe46N1ZAmQW3OXiNWPB7O81NvNuxDKAtEzHwZD0dme6jY2qzjK119zEqhJdiiNn6187Pz2cdRRs0fQOz5zejSnefxC8RrbvdWefWDB7pQsTPTSr9SHW0Jfk8Xed+RKC5SY6LtchXY7hixF9dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqwlB1xGRz1j6p4;
	Fri, 23 Aug 2024 18:08:54 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id E4B041A016C;
	Fri, 23 Aug 2024 18:08:58 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:58 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 11/11] cgroup/cpuset: add sefltest for cpuset v1
Date: Fri, 23 Aug 2024 10:01:10 +0000
Message-ID: <20240823100110.472120-12-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823100110.472120-1-chenridong@huawei.com>
References: <20240823100110.472120-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
index 7668f8577bc1..0af35d39a123 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5772,6 +5772,7 @@ F:	kernel/cgroup/cpuset-v1.c
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


