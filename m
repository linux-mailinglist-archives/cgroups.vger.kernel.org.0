Return-Path: <cgroups+bounces-10318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA7B8DD2B
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC9317C1DD
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073F1DF25C;
	Sun, 21 Sep 2025 15:12:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593191DE3B5;
	Sun, 21 Sep 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467556; cv=none; b=i+OiMEvMn6RQuWMKgTxHKkUSKaMtXlDl275xO/P9ioPw9w2sXunSUEADAts4C3GcPn1XV6lHev/TX+cOcOH0CTHuuT7ayrWtJZolrEO2TrGDz0h8efnoSVmu33rbguPq+3OeUQrha2aA6W3erd/bmE/LuNhODgVWsB/xfG/2ma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467556; c=relaxed/simple;
	bh=MVRf6CXjpE+tHya5kNSEjiGyLT6nEq1sf/hPnUwbMJ4=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=sl1GQP+cVrXclm0g7qYk4A4qas0L1w9bm/xkKPDF03zZ7tydDnvek5QI1J+Za9t9mv0B5vweSrRS8sfeuXqMcSx9tUfzQCyeTzoPg1Ws27In/TVw/4Mc42HUbrmLrKo1U08/FwtIeMdAjfMbbwBob9uuq+snUAT79joqiGK9hnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cV8qZ0F03z5BNRd;
	Sun, 21 Sep 2025 23:12:26 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 58LFCIUF056594;
	Sun, 21 Sep 2025 23:12:18 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:12:21 +0800 (CST)
Date: Sun, 21 Sep 2025 23:12:21 +0800 (CST)
X-Zmail-TransId: 2afb68d015d563a-061cf
X-Mailer: Zmail v1.0
Message-ID: <20250921231221760ia5tTTBoELVcZzeH5Pl2Z@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMy82XSBtZW1jZzogc2hvdyBrc21fbWVyZ2luZ19wYWdlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58LFCIUF056594
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 21 Sep 2025 23:12:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D015DA.000/4cV8qZ0F03z5BNRd

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_merging_pages of a cgroup just by:

    'cat /sys/fs/cgroup/memory.stat | grep ksm_merging_pages

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2fb4198458a4..e49f4b86ffb0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3313,6 +3313,7 @@ long ksm_process_profit(struct mm_struct *mm)
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
+	unsigned long ksm_merging_pages;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -3324,6 +3325,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
+		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
 		mmput(mm);
 	}

@@ -3339,16 +3341,20 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
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

