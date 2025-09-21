Return-Path: <cgroups+bounces-10320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC653B8DD37
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF31189CFC9
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96A1DF725;
	Sun, 21 Sep 2025 15:14:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C3282E1;
	Sun, 21 Sep 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467673; cv=none; b=c4GjT4yq7BVDBBhZsw8DQgN5/m3bt+NY4SMNcNfpJYFlhJ0NR+Fw3f3fUmdIunGTP2iUdg7Qi9yTARoz19ZpNuW8HX4+iP7SGy6NJN7ARVObQu6hF3gcTtKhmqCmsb4IJbHBk4daUybaba2sNLl7bniRpVExY/hhhYijmUiNKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467673; c=relaxed/simple;
	bh=Hh9jyzgQeiIkRT2nDYmtBJoh5930RBsuhwLrqFEMp04=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Yo67hR3bugHZ5DpW9DxBOilQAhdIKl9uBMJ/tPByvxIJzbWwv94wZQYapSZpNGYVaZHXrprpWkrhL3KE1m4Wy62TsjGJNLPLnM7UIpI1PvzMIjLwnLTE70rsys1/RMz11u3vYAD5xLQVOy3zsik7SNsUusO5ED9ZZhJ7MD/TDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cV8sq4ggvz4xPS7;
	Sun, 21 Sep 2025 23:14:23 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 58LFEKLb056996;
	Sun, 21 Sep 2025 23:14:20 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:14:23 +0800 (CST)
Date: Sun, 21 Sep 2025 23:14:23 +0800 (CST)
X-Zmail-TransId: 2afc68d0164f141-02cd9
X-Mailer: Zmail v1.0
Message-ID: <202509212314234220Nz2yHDfXTgwoTRJwuZTs@zte.com.cn>
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
References: 20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xu.xin16@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <shakeel.butt@linux.dev>, <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <david@redhat.com>,
        <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgNS82XSBtZW1jZzogYWRkIHBlci1tZW1jZyBrc21fcHJvZml0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58LFEKLb056996
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 21 Sep 2025 23:14:23 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D0164F.000/4cV8sq4ggvz4xPS7

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_profit of a cgroup just by:

    'cat /sys/fs/cgroup/memory.stat | grep ksm_profit

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a68d4b37b503..55329398797f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3307,11 +3307,18 @@ long ksm_process_profit(struct mm_struct *mm)
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }

+static inline long ksm_general_profit(void)
+{
+	return (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
+		ksm_rmap_items * sizeof(struct ksm_rmap_item);
+}
+
 #ifdef CONFIG_MEMCG
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
 	unsigned long ksm_merging_pages;
+	long ksm_profit;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -3324,6 +3331,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
+		ksm_stat->ksm_profit += ksm_process_profit(mm);
 		mmput(mm);
 	}

@@ -3341,11 +3349,13 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
 		ksm_stat.ksm_zero_pages = atomic_long_read(&ksm_zero_pages);
 		ksm_stat.ksm_merging_pages = ksm_pages_shared +
 					     ksm_pages_sharing;
+		ksm_stat.ksm_profit = ksm_general_profit();
 	} else {
 		/* Initialization */
 		ksm_stat.ksm_rmap_items = 0;
 		ksm_stat.ksm_zero_pages = 0;
 		ksm_stat.ksm_merging_pages = 0;
+		ksm_stat.ksm_profit = 0;
 		/* Summing all processes'ksm statistic items */
 		mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
 	}
@@ -3353,6 +3363,7 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
 	seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_buf_printf(s, "ksm_zero_pages %lu\n", ksm_stat.ksm_zero_pages);
 	seq_buf_printf(s, "ksm_merging_pages %lu\n", ksm_stat.ksm_merging_pages);
+	seq_buf_printf(s, "ksm_profit %lu\n", ksm_stat.ksm_profit);
 }
 #endif

@@ -3647,12 +3658,7 @@ KSM_ATTR_RO(ksm_zero_pages);
 static ssize_t general_profit_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	long general_profit;
-
-	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
-				ksm_rmap_items * sizeof(struct ksm_rmap_item);
-
-	return sysfs_emit(buf, "%ld\n", general_profit);
+	return sysfs_emit(buf, "%ld\n", ksm_general_profit());
 }
 KSM_ATTR_RO(general_profit);

-- 
2.25.1

