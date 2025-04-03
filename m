Return-Path: <cgroups+bounces-7318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25EDA79B69
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C73B5F10
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CF919E7ED;
	Thu,  3 Apr 2025 05:38:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3748199EB0;
	Thu,  3 Apr 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658722; cv=none; b=FzvQ0RXHs/VJOGA/XNv4z9xL9l0axMipf0KCT6VwFzGbdA3ZEcU5J9jXSVO8EcyaT3qguRxmWp3wHMGE2q1XaerWrOqOnv1rZMD1TIQIY2FbRB79ALzZtikmTBAYzBf0z9xCSQiq+v6liG10JtkcdYDXerNA6ExZ+mZ1KhYdCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658722; c=relaxed/simple;
	bh=zi8NXk3p42tO/Q7Q7pLyw/dDYNobmqL2jNxPxFyODRc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=aSokeQImeezXwczY8jkCxU5jEGC4w12FwswsseVtxl/0/iKnFQd/AR6cJqpRewxJ90pVHDcsnV9qVkzgYoytYhce29tuMdO3dAydrZ4yRwh9BVPLAoOH4d1YtXFW1TEDsriTiIIIq4j5jGH9tv83roThA9FC1IoUuQgC4R5f8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZSrBN0RWlz51SY9;
	Thu,  3 Apr 2025 13:38:36 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5335cWOB017140;
	Thu, 3 Apr 2025 13:38:32 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:38:34 +0800 (CST)
Date: Thu, 3 Apr 2025 13:38:34 +0800 (CST)
X-Zmail-TransId: 2afb67ee1eda53d-6e9e8
X-Mailer: Zmail v1.0
Message-ID: <20250403133834135T-0RJg5_VxJfmzN3dG3bE@zte.com.cn>
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
        <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgNS82XSBtZW1jb250cm9sLXYxOiBhZGQga3NtX21lcmdpbmdfcGFnZXMgaW4gY2dyb3VwL21lbW9yeS5rc21fc3RhdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5335cWOB017140
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1EDC.000/4ZSrBN0RWlz51SY9

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_merging_pages of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 1092

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index a6eea1deebff..b52f728af963 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1826,6 +1826,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
+	unsigned long ksm_merging_pages;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -1837,6 +1838,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
+		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
 		mmput(mm);
 	}

@@ -1851,12 +1853,14 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	/* Initialization */
 	ksm_stat.ksm_rmap_items = 0;
 	ksm_stat.ksm_zero_pages = 0;
+	ksm_stat.ksm_merging_pages = 0;

 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);

 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
+	seq_printf(m, "ksm_merging_pages %ld\n", ksm_stat.ksm_merging_pages);

 	return 0;
 }
-- 
2.15.2

