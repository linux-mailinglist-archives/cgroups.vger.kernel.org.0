Return-Path: <cgroups+bounces-10497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15331BAC5DB
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C976D3215BC
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D12F7ACE;
	Tue, 30 Sep 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z6m78rVT"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FC2F6164;
	Tue, 30 Sep 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225913; cv=none; b=VlA+fQ3ckDUYnf/WAH8JP9+kDDwfIR7WCMawBqT4+ZWcLUJvZTogMM4WXN1uipVqfNENFcAmOdDkMHA7LfLUX7Gwi5LTgTRfqy/l42UKHo6BXOqWTXyYyRM6la/JDv0o65/Cpn8e9KrmJG9EK4KK9XVDWt8kZHbQFIlqanJ528k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225913; c=relaxed/simple;
	bh=7ZLaEJ0ebPuWyyKFGFYC43JjOCxEZxcSF09jQrdtGIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNBLwP28Al5Hj/nAzmhO4E1s7hlhTo4ViMczFCz4zotiRCluVJEtdCoKSZRw70eT6dmTwiml9zoQ3a5Al+wCcBYNuh+a46bld/oG6f13lblvEIa+bEwmb0P2Xunygk5sux4+WHkxmLvP6P5y01gePyOTwSCJFisy4FvKfpwcvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z6m78rVT; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nADysAodi9/Cp0iwK3kIOTrsOn+wVW7FsZKmEos2uoM=;
	b=Z6m78rVTntq34mnVpYg0Z2ehH44nYuHrL81WqnQUmHlvp9AwsSkzpfKVO5ULkVxJdSnS/Dpt/
	Mnzp8t4jtbktrIH96TlsF8kGK/BbiU21E/yf1WgpGbcs9HD+SGJekofLAg2b1DYPMQRfSTfO4CG
	PENyVHTzmBOBoczI+Y2RtCA=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cbYGt48lczpStY;
	Tue, 30 Sep 2025 17:51:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 79BEA180464;
	Tue, 30 Sep 2025 17:51:47 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:51:47 +0800
Received: from hulk-cxc.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:51:46 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <llong@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>, <caixinchen1@huawei.com>
Subject: [PATCH -next RFC 2/2] cpuset: Add spread_page interface to cpuset v2
Date: Tue, 30 Sep 2025 09:35:52 +0000
Message-ID: <20250930093552.2842885-3-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930093552.2842885-1-caixinchen1@huawei.com>
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200017.china.huawei.com (7.202.195.228)

I encountered a scenario where a machine with 1.5TB of memory,
while testing the Spark TPCDS 3TB dataset, experienced a significant
concentration of page cache usage on one of the NUMA nodes.
I discovered that the DataNode process had requested a large amount
of page cache. most of the page cache was concentrated in one NUMA node,
ultimately leading to the exhaustion of memory in that NUMA node.
At this point, all other processes in that NUMA node have to alloc
memory across NUMA nodes, or even across sockets. This eventually
caused a degradation in the end-to-end performance of the Spark test.

I do not want to restart the Spark DataNode service during business
operations. This issue can be resolved by migrating the DataNode into
a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
allow it to evenly request memory. The core business threads could still
allocate local numa memory. After using cpuset.memory_spread_page, the
performance in the tpcds-99 test is improved by 2%.

The key point is that the even distribution of page cache within the
DataNode process (rather than the current NUMA distribution) does not
significantly affect end-to-end performance. However, the allocation
of core business processes, such as Executors, to the same NUMA node
does have a noticeable impact on end-to-end performance.

However, I found that cgroup v2 does not provide this interface. I
believe this interface still holds value in addressing issues caused
by uneven distribution of page cache allocation among process groups.

Thus I add cpuset.mems.spread_page to cpuset v2 interface.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 kernel/cgroup/cpuset.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3a0d443180c6..04a24642f490 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3461,6 +3461,32 @@ void cpuset_update_task_spread_flags(struct cpuset *cs,
 		task_clear_spread_page(tsk);
 }
 
+static int cpuset_update_spread_page(struct cgroup_subsys_state *css, struct cftype *cft,
+			    u64 val)
+{
+	struct cpuset *cs = css_cs(css);
+	int retval = 0;
+
+	cpuset_full_lock();
+	if (!is_cpuset_online(cs)) {
+		retval = -ENODEV;
+		goto out_unlock;
+	}
+
+	retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
+
+out_unlock:
+	cpuset_full_unlock();
+	return retval;
+}
+
+static u64 cpuset_read_spread_page(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct cpuset *cs = css_cs(css);
+
+	return is_spread_page(cs);
+}
+
 /*
  * This is currently a minimal set for the default hierarchy. It can be
  * expanded later on by migrating more features and control files from v1.
@@ -3535,6 +3561,13 @@ static struct cftype dfl_files[] = {
 		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
 
+	{
+		.name = "mems.spread_page",
+		.read_u64 = cpuset_read_spread_page,
+		.write_u64 = cpuset_update_spread_page,
+		.private = FILE_SPREAD_PAGE,
+	},
+
 	{ }	/* terminate */
 };
 
-- 
2.34.1


