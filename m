Return-Path: <cgroups+bounces-7317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49FA79B67
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4793171719
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0DE19DFAB;
	Thu,  3 Apr 2025 05:37:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888E199EB0;
	Thu,  3 Apr 2025 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658631; cv=none; b=ZGHpQhhbchigf9UGr9qZed+Fy3O1W8Bd2wxb7WvY03cuIrgBPhB9T/P0hdoeWIhqh5UUkNiP6uJFchciGcHnoFxcrMC6nDyUFLOPQjSeANIOwv0OHc14oggUKZf/P/HU1U5LuzWENxiy6lYZgMrMT+C0a86ENDipP3ZBlNeXtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658631; c=relaxed/simple;
	bh=DkPMlsDZjv5DSrQnUXpSBl1a/+EgHtPiqSIFYHVCbtE=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=aBGCZvLE2n06/upiPdjDG+jM0YwYg+gNGIPNQ52bPrOIaIL2t9bVh2v6Ib5JZVPGDHuZMOhCO+EabRvBDAInWu65p9MGBHxaa+sWOztuA8Xwvy+3fH9kYu38MbbOesuvpjpYuD619eyP7HILQkDhBB9XQOmRkOCDktRroW7O0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZSr8c1tDPz51SY9;
	Thu,  3 Apr 2025 13:37:04 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5335ax06016459;
	Thu, 3 Apr 2025 13:36:59 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:37:00 +0800 (CST)
Date: Thu, 3 Apr 2025 13:37:00 +0800 (CST)
X-Zmail-TransId: 2af967ee1e7cffffffffe9c-7733f
X-Mailer: Zmail v1.0
Message-ID: <20250403133700772Rm5te7Iuqsi7ZGMGpFlok@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgNC82XSBtZW1jb250cm9sLXYxOiBhZGQga3NtX3plcm9fcGFnZXMgaW4KCiBjZ3JvdXAvbWVtb3J5LmtzbV9zdGF0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5335ax06016459
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1E80.002/4ZSr8c1tDPz51SY9

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_zero_pages of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 95da877d5516..a6eea1deebff 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -11,6 +11,7 @@
 #include <linux/sort.h>
 #include <linux/file.h>
 #include <linux/seq_buf.h>
+#include <linux/ksm.h>

 #include "internal.h"
 #include "swap.h"
@@ -1824,6 +1825,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_KSM
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
+	long ksm_zero_pages;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -1834,6 +1836,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	mm = get_task_mm(task);
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		mmput(mm);
 	}

@@ -1847,9 +1850,13 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)

 	/* Initialization */
 	ksm_stat.ksm_rmap_items = 0;
+	ksm_stat.ksm_zero_pages = 0;
+
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
+
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);

 	return 0;
 }
-- 
2.15.2

