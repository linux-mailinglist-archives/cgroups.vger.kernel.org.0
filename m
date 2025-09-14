Return-Path: <cgroups+bounces-10057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA457B5676B
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141F47A958A
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3012367CE;
	Sun, 14 Sep 2025 10:06:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF4211C;
	Sun, 14 Sep 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844374; cv=none; b=ZFOkZl+rXfkesY1Ka5mwRPs3fcU+tNk1e5OKjG3WLo8Z7w4buxy6MCBIVIPB4uIHYEOZU0aqZqQefC/fB+sBnTdLNUddAPa+wDbn94N5ia2Ibw5s2YlmalS45+ipN6g2c0HMOs73+LcYw1Of9vk16T8UFFMULTMOekw9Pw61+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844374; c=relaxed/simple;
	bh=Jr66LOVLZi8h7k4UjScGJXJYeufb9/vM5YInM7zGC4w=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=MAHMm57siDNPGbWPYp8x5bSjN588j3VJdShlUnIUPNTJeIBLo1PST+OVr7QTk3Zwcp4B8tenggzQHmDdIGEriT+2nxTTRQEqQKVp3wXjbC4e6NMv9YtVuY+uODehJP4n69V08NJTORDxN6XFaQWbeLZmCB2yH8cC3vJdklmY8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cPkMM1W5Fz8Xs6w;
	Sun, 14 Sep 2025 18:06:07 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cPkM325p2z4xPT5;
	Sun, 14 Sep 2025 18:05:51 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 58EA5e4P099229;
	Sun, 14 Sep 2025 18:05:40 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 14 Sep 2025 18:05:43 +0800 (CST)
Date: Sun, 14 Sep 2025 18:05:43 +0800 (CST)
X-Zmail-TransId: 2af968c693778a4-65db2
X-Mailer: Zmail v1.0
Message-ID: <20250914180543238RmGhd2wFVDA1pXX_I9Rrb@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvNV0gbWVtY2c6IHNob3cga3NtX3plcm9fcGFnZXMgY291bnQgaW4gbWVtb3J5LnN0YXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58EA5e4P099229
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Sun, 14 Sep 2025 18:06:07 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68C6938F.000/4cPkMM1W5Fz8Xs6w

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_zero_pages of a cgroup just by:

    'cat /sys/fs/cgroup/memory.stat | grep ksm_zero_pages

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index b533f0edaf96..5832159214f8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3311,6 +3311,7 @@ long ksm_process_profit(struct mm_struct *mm)
 #ifdef CONFIG_MEMCG
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
+	long ksm_zero_pages;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -3321,6 +3322,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	mm = get_task_mm(task);
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		mmput(mm);
 	}

@@ -3335,14 +3337,17 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
 	if (mem_cgroup_is_root(memcg)) {
 		/* Just use the global counters when root memcg */
 		ksm_stat.ksm_rmap_items = ksm_rmap_items;
+		ksm_stat.ksm_zero_pages = atomic_long_read(&ksm_zero_pages);
 	} else {
 		/* Initialization */
 		ksm_stat.ksm_rmap_items = 0;
+		ksm_stat.ksm_zero_pages = 0;
 		/* Summing all processes'ksm statistic items */
 		mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
 	}
 	/* Print memcg ksm statistic items */
 	seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+	seq_buf_printf(s, "ksm_zero_pages %lu\n", ksm_stat.ksm_zero_pages);
 }
 #endif

-- 
2.25.1

