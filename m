Return-Path: <cgroups+bounces-7315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A7A79B49
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CD1174809
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B4194094;
	Thu,  3 Apr 2025 05:32:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B23D26D;
	Thu,  3 Apr 2025 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658323; cv=none; b=K8iz9Z/ogd+xuF1bZt64FhWw/wclGiGArVhPDSL/jhyEIHRSAAaUia3pcH0x0VyMfbMbNehzPoU0TUd80JGi8AaQNe7cxzvWBUYEbyvB3Xstl0ikMEv0HdxFGcJ9QdGT9iB3ds/aPYgV0dNtQ7R/kJIwp9MWYSQDaKvhJKyZFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658323; c=relaxed/simple;
	bh=unUSdxUnKG+T7L+6CvqNgY2lpiikyaDL8t2v61GBeLI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=mvkIzgbiqVlJrnsg/az2RMXW+qEo8FvHjYut3KKk8fo2Upq4UwECeapI4jjziAyt98CIF7KdbnFGOExAZv7QfJqJeQC4UDhGHR5cX8o4OTH5CaS4Lmrh9WCuHbtoKbU95sZHpfRyQaVDwIXh80a8ahnMnl2FgCQ0k4Z/p+dMx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSr2j21sXz8R042;
	Thu,  3 Apr 2025 13:31:57 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 5335Vu70043767;
	Thu, 3 Apr 2025 13:31:56 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:31:58 +0800 (CST)
Date: Thu, 3 Apr 2025 13:31:58 +0800 (CST)
X-Zmail-TransId: 2afa67ee1d4effffffff9e4-6de90
X-Mailer: Zmail v1.0
Message-ID: <20250403133158436XF_dvGEyg6j0sZsH6VH9U@zte.com.cn>
In-Reply-To: <20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn>
References: 20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <mhocko@kernel.org>
Cc: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
        <shakeel.butt@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMy82XSBtZW1jb250cm9sLXYxOiBpbnRyb2R1Y2Uga3NtX3N0YXQgYXQgY2dyb3VwCgogbGV2ZWw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5335Vu70043767
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1D4D.000/4ZSr2j21sXz8R042

From: xu xin <xu.xin16@zte.com.cn>

With the enablement of container-level KSM (e.g., via prctl), there is a
growing demand for container-level observability of KSM behavior. However,
current cgroup implementations lack support for exposing KSM-related
metrics.

This patch introduces a new interface named ksm_stat
at the cgroup hierarchy level, enabling users to monitor KSM merging
statistics specifically for containers where this feature has been
activated, eliminating the need to manually inspect KSM information for
each individual process within the cgroup.

Users can obtain the KSM information of a cgroup just by:

        `cat /sys/fs/cgroup/memory.ksm_stat`

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Co-developed-by: Haonan Chen <chen.haonan2@zte.com.cn>
Signed-off-by: Haonan Chen <chen.haonan2@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 8660908850dc..95da877d5516 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1821,6 +1821,40 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_NUMA */

+#ifdef CONFIG_KSM
+struct memcg_ksm_stat {
+	unsigned long ksm_rmap_items;
+};
+
+static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
+{
+	struct mm_struct *mm;
+	struct memcg_ksm_stat *ksm_stat = arg;
+
+	mm = get_task_mm(task);
+	if (mm) {
+		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		mmput(mm);
+	}
+
+	return 0;
+}
+
+static int memcg_ksm_stat_show(struct seq_file *m, void *v)
+{
+	struct memcg_ksm_stat ksm_stat;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	/* Initialization */
+	ksm_stat.ksm_rmap_items = 0;
+	/* summing all processes'ksm statistic items of this cgroup hierarchy */
+	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
+	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+
+	return 0;
+}
+#endif
+
 static const unsigned int memcg1_stats[] = {
 	NR_FILE_PAGES,
 	NR_ANON_MAPPED,
@@ -2079,6 +2113,12 @@ struct cftype mem_cgroup_legacy_files[] = {
 		.name = "numa_stat",
 		.seq_show = memcg_numa_stat_show,
 	},
+#endif
+#ifdef CONFIG_KSM
+	{
+		.name = "ksm_stat",
+		.seq_show = memcg_ksm_stat_show,
+	},
 #endif
 	{
 		.name = "kmem.limit_in_bytes",
-- 
2.15.2

