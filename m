Return-Path: <cgroups+bounces-10317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E569EB8DD25
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D7189CFBA
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE751DE4CD;
	Sun, 21 Sep 2025 15:11:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05881C700C;
	Sun, 21 Sep 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467490; cv=none; b=GUThefzS9LCD0WuHT5AvNkC68sesz93FHhsYGG0Ztv5yZFUycoeWmVgPdD2LVKBmNq/HmHe4ITHv1tpGT8yb5UydoZrBWCVheg+JrEBsDXxKjbKmfWy2GsGWLN/ECJXg/tmkqgjszGArnMLt5mTmvc0CDlFRDmsW9KbG/oUMxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467490; c=relaxed/simple;
	bh=/PgtUKZo/tTmM/IyFTv///c9ThkDROBOTiHmSM89okM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=hZy+wDc2gycVxASms7+jWbpb0wiAcu/4rKC8jiHvOLzHCrm0+QUvNLMne8zOmeSQDdgTfu38MHsSDt0LzWB8/7NHyPossp9wkTZHCMOcVmqwpITT0W5R1hdFkBoJsLM/G7Gj02Z9hvp6xpMG/KNHEDRLM+FnG0hSyaEyGDrpF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cV8pP6LXGz8Xs6w;
	Sun, 21 Sep 2025 23:11:25 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 58LFBFuk071467;
	Sun, 21 Sep 2025 23:11:15 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:11:18 +0800 (CST)
Date: Sun, 21 Sep 2025 23:11:18 +0800 (CST)
X-Zmail-TransId: 2afb68d01596a55-055eb
X-Mailer: Zmail v1.0
Message-ID: <20250921231118775bX0EITd4B9qu_9qEeGPkr@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMi82XSBtZW1jZzogc2hvdyBrc21femVyb19wYWdlcyBjb3VudCBpbiBtZW1vcnkuc3RhdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58LFBFuk071467
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 21 Sep 2025 23:11:25 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D0159D.001/4cV8pP6LXGz8Xs6w

From: xu xin <xu.xin16@zte.com.cn>

Users can obtain ksm_zero_pages of a cgroup just by:

    'cat /sys/fs/cgroup/memory.stat | grep ksm_zero_pages

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index be0efa0f8f2b..2fb4198458a4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3312,6 +3312,7 @@ long ksm_process_profit(struct mm_struct *mm)
 #ifdef CONFIG_MEMCG
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
+	long ksm_zero_pages;
 };

 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -3322,6 +3323,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	mm = get_task_mm(task);
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		mmput(mm);
 	}

@@ -3336,14 +3338,17 @@ void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
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

