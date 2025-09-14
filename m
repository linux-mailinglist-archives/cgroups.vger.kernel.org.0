Return-Path: <cgroups+bounces-10058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9DB56781
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3733516E761
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00E23A99F;
	Sun, 14 Sep 2025 10:07:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29E7262E;
	Sun, 14 Sep 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844424; cv=none; b=JRWEkdMUXcduS+G2UpCH/uMIf06rRGG5nRX7OZVgKjDLLy+aVhleT8hA26Rw8f2+eJFsp2K/MYVM73jdj3+unxBedQSzUS5CC5Kkmopi7+O1bKW1SdzLqTchKINyKlFKpzLkyXLjcDKAw6lWnvRsxP1c2lJEr0hFOhwg3dACiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844424; c=relaxed/simple;
	bh=ll/2ZGKGDGKEzRTjNb8ucJW92bdg7yoIzU8YwGYTj5I=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=pP64xtq1MROqGoNwlno7V0Xm9JbgCHcJJFrHjdUh1J3FziAP37mmEQbVlqnx+LwRMVGOl0K4JLu3aGsG573lZHIfhi6kc5+NQjkVZGriXwnAGwhsaLkVHbLvdQfVS/LZisNelsW5M8XwW1tAYXy+xb4N33xy8f7NYDkQSM91BGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cPkNN28VMz8Xs71;
	Sun, 14 Sep 2025 18:07:00 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 58EA6nPp099586;
	Sun, 14 Sep 2025 18:06:49 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 14 Sep 2025 18:06:51 +0800 (CST)
Date: Sun, 14 Sep 2025 18:06:51 +0800 (CST)
X-Zmail-TransId: 2af968c693bb4ca-669d7
X-Mailer: Zmail v1.0
Message-ID: <20250914180651981vC9sC806WA8UGn7FNbL7N@zte.com.cn>
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
Cc: <akpm@linux-foundation.org>, <shakeel.butt@linux.dev>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <david@redhat.com>, <chengming.zhou@linux.dev>,
        <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNV0gbWVtY2c6IHNob3cga3NtX21lcmdpbmdfcGFnZXMgaW4gbWVtb3J5LnN0YXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58EA6nPp099586
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 14 Sep 2025 18:07:00 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68C693C4.000/4cPkNN28VMz8Xs71

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_merging_pages of a cgroup just by:

    'cat /sys/fs/cgroup/memory.stat | grep ksm_merging_pages

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 5832159214f8..4cc47ad1e887 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3312,6 +3312,7 @@ long ksm_process_profit(struct mm_struct *mm)
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
+	unsigned long ksm_merging_pages;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -3323,6 +3324,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
+		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
 		mmput(mm);
 	}

@@ -3338,16 +3340,20 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
 		/* Just use the global counters when root memcg */
 		ksm_stat.ksm_rmap_items = ksm_rmap_items;
 		ksm_stat.ksm_zero_pages = atomic_long_read(&ksm_zero_pages);
+		ksm_stat.ksm_merging_pages = ksm_pages_shared +
+					     ksm_pages_sharing;
 	} else {
 		/* Initialization */
 		ksm_stat.ksm_rmap_items = 0;
 		ksm_stat.ksm_zero_pages = 0;
+		ksm_stat.ksm_merging_pages = 0;
 		/* Summing all processes'ksm statistic items */
 		mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
 	}
 	/* Print memcg ksm statistic items */
 	seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_buf_printf(s, "ksm_zero_pages %lu\n", ksm_stat.ksm_zero_pages);
+	seq_buf_printf(s, "ksm_merging_pages %lu\n", ksm_stat.ksm_merging_pages);
 }
 #endif

-- 
2.25.1

