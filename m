Return-Path: <cgroups+bounces-7319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD3A79B6B
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F5F3B6000
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DE19E7F8;
	Thu,  3 Apr 2025 05:40:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5614199EB0;
	Thu,  3 Apr 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658820; cv=none; b=Ao08miL5iTfimqm8BglCFmx+yxknCXNZE7t1BAQ4nIQPHHcyAKLfkkOMH5dGxk0SX1q/qsY5tegHFxqOUs8LA80Bx5dQtCKBpp9Ji/3MlrRui/7f1PVTeI8W13yfGxQ04pLY+042/kg82X8upOICqeycq4ahUULJnUHuREUzJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658820; c=relaxed/simple;
	bh=/tTUnVNOyLZuLB9VxUf703I3JwCpIFx3QDmRbmt33Lw=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=eH+MwMkwm2qvH28+TM/eTO/P69yjrXK76pxMnY5QDKZhlteAnfJMe2q480IyCbniba/jzqljAvWKA+uWDYZZF3aMSSRvqJV+t5K41/NXWwB+pt0NidjYL4WKXtD5hgEWvK4xG6kbRhphnm8tf2TxpDKSFQBGEaXJI1bZhYWCSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZSrDD759fz4x6DN;
	Thu,  3 Apr 2025 13:40:12 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 5335eBrW047456;
	Thu, 3 Apr 2025 13:40:11 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:40:13 +0800 (CST)
Date: Thu, 3 Apr 2025 13:40:13 +0800 (CST)
X-Zmail-TransId: 2afc67ee1f3dffffffffce3-75188
X-Mailer: Zmail v1.0
Message-ID: <20250403134013749X6VVdhQope3TRpBQF_qia@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgNi82XSBtZW1jb250cm9sLXYxOiBhZGQga3NtX3Byb2ZpdCBpbiBjZ3JvdXAvbWVtb3J5LmtzbV9zdGF0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5335eBrW047456
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1F3C.00C/4ZSrDD759fz4x6DN

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_profit of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 76800
ksm_profit 309657600

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b52f728af963..3e7a653e3df1 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1827,6 +1827,7 @@ struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
 	unsigned long ksm_merging_pages;
+	long ksm_profit;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -1839,6 +1840,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
+		ksm_stat->ksm_profit += ksm_process_profit(mm);
 		mmput(mm);
 	}

@@ -1854,6 +1856,7 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	ksm_stat.ksm_rmap_items = 0;
 	ksm_stat.ksm_zero_pages = 0;
 	ksm_stat.ksm_merging_pages = 0;
+	ksm_stat.ksm_profit = 0;

 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
@@ -1861,6 +1864,7 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
 	seq_printf(m, "ksm_merging_pages %ld\n", ksm_stat.ksm_merging_pages);
+	seq_printf(m, "ksm_profit %ld\n", ksm_stat.ksm_profit);

 	return 0;
 }
-- 
2.15.2

