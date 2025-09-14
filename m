Return-Path: <cgroups+bounces-10059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5367B56783
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 12:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A03C189F2F6
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8222376E0;
	Sun, 14 Sep 2025 10:08:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D538FA3;
	Sun, 14 Sep 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844481; cv=none; b=RIW3x0ksB17RNK/H3ajasr8i/PBWUHKCqlnWL/KrwXuQfRMWGLKEhvh+K1NSac5ZejiNYeskX2lXYg27blyxmGUKVg3sX/oI2zi+yRItiutQIE3tOmQdgJfBVuXtsnj8dpc7dtGuB3BlnwhT0Jmq3AV+b9a9WNt55TyWlBKjCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844481; c=relaxed/simple;
	bh=ln4AeIiIDMFIQtWmbwMxbhwxK9WZeSnTTugMyTw0B40=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=N8nVJ0iajpz2r87gUhA36NYpfMxMGCmVgX3XCva9OlKuZokwfEwB/6cR6AHvYhA4dW25Ev2g/1dfflG0bQAcsFT/A8AV52wzP5lwpd0cocmCDngIcqjSCvWQEqBubLiGf+mqJixlp64WSoTH3PTNRK45R0dZRDrnWz+TrkzGzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cPkPT2RjZz8Xs6w;
	Sun, 14 Sep 2025 18:07:57 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 58EA7nNc099870;
	Sun, 14 Sep 2025 18:07:49 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 14 Sep 2025 18:07:50 +0800 (CST)
Date: Sun, 14 Sep 2025 18:07:50 +0800 (CST)
X-Zmail-TransId: 2af968c693f6eb9-673c6
X-Mailer: Zmail v1.0
Message-ID: <20250914180750448qMRz3iTon78DoExPyZusD@zte.com.cn>
In-Reply-To: <20250914180031197jk6ngo5pQjpXkNtNsjzSo@zte.com.cn>
References: 20250914180031197jk6ngo5pQjpXkNtNsjzSo@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <shakeel.butt@linux.dev>, <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <david@redhat.com>,
        <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDQvNV0gbWVtY2c6IGFkZCBwZXItbWVtY2cga3NtX3Byb2ZpdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58EA7nNc099870
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 14 Sep 2025 18:07:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68C693FD.000/4cPkPT2RjZz8Xs6w

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_profit of a cgroup just by:

    'cat /sys/fs/cgroup/memory.stat | grep ksm_profit

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4cc47ad1e887..c01567a3d5ca 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3308,11 +3308,18 @@ long ksm_process_profit(struct mm_struct *mm)
 }
 #endif /* CONFIG_PROC_FS */

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
@@ -3325,6 +3332,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
+		ksm_stat->ksm_profit += ksm_process_profit(mm);
 		mmput(mm);
 	}

@@ -3342,11 +3350,13 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
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
@@ -3354,6 +3364,7 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
 	seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_buf_printf(s, "ksm_zero_pages %lu\n", ksm_stat.ksm_zero_pages);
 	seq_buf_printf(s, "ksm_merging_pages %lu\n", ksm_stat.ksm_merging_pages);
+	seq_buf_printf(s, "ksm_profit %lu\n", ksm_stat.ksm_profit);
 }
 #endif

@@ -3648,12 +3659,7 @@ KSM_ATTR_RO(ksm_zero_pages);
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

