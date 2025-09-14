Return-Path: <cgroups+bounces-10061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E354BB5679B
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 12:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F56420831
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97523A9B3;
	Sun, 14 Sep 2025 10:09:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC53223DDA;
	Sun, 14 Sep 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844592; cv=none; b=YzCJkHcM4KDPJEUN99X3gdFwG8dAyxQ1Rzj/WrgMtBiJ2SrL2dOjiY1CuyB0OtDtbil6bnekRAqDYiSZgVDcq7rvRp9hHaXj0aZan5RiCNZKc4w7Qjbcx9VK9K8bL6VzCjNPW0b1wzgOe77wMc2yeinWEOmYQX+T457uIqnb4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844592; c=relaxed/simple;
	bh=xZxsr5cwG6lEoaCjEFS9C2L4teN6L7b0Nz0PG3F/Lfk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=AYHNOe+dIggQBsQwPeyWCukplJe3iTxfSx8xTfXlBpx20wrT14e4z1cqv7iEaN2zChNXltj0O3lMSaJKrNpG+MnYfuwwumfMu8tzNDRtWvWeqxkNJYs6IdWK4OTdJbvUSTkF/EPIb3ytPRc794jJTIqkTVijUy4qyHgydFg7o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cPkK81Zy7z1FhC;
	Sun, 14 Sep 2025 18:04:12 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4cPkK22jGqzBQkJn;
	Sun, 14 Sep 2025 18:04:06 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cPkJr6x1Bz5PM38;
	Sun, 14 Sep 2025 18:03:56 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 58EA3mCY092681;
	Sun, 14 Sep 2025 18:03:49 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 14 Sep 2025 18:03:51 +0800 (CST)
Date: Sun, 14 Sep 2025 18:03:51 +0800 (CST)
X-Zmail-TransId: 2afa68c69307545-58a60
X-Mailer: Zmail v1.0
Message-ID: <20250914180351288rcLuZnPAMUej48nuTc7KV@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvNV0gbWVtY2c6IGFkZCBwZXItbWVtY2cga3NtX3JtYXBfaXRlbXMgc3RhdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58EA3mCY092681
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.121 unknown Sun, 14 Sep 2025 18:04:12 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68C6931A.001/4cPkK81Zy7z1FhC

From: xu xin <xu.xin16@zte.com.cn>

With the enablement of container-level KSM (e.g., via prctl), there is
a growing demand for container-level observability of KSM behavior.

The value of "ksm_rmap_items" indicates the total allocated ksm
rmap_items of this memcg, which could be used to determine how
unbeneficial the ksm-policy (like madvise), they are using brings,
since the bigger the ratio of ksm_rmap_items over ksm_merging_pages,
the more unbeneficial the ksm bring.

Add the counter in the existing memory.stat without adding a new interface.
We traverse all processes of a memcg and summing the processes'
ksm_rmap_items counters instead of adding enum item in memcg_stat_item
or node_stat_item and updating the corresponding enum counter when
ksmd manipulate pages.

Finally, we can look up ksm_rmap_items of per-memcg simply by:

    cat /sys/fs/cgroup/memory.stat | grep ksm_rmap_items

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/ksm.h |  1 +
 mm/ksm.c            | 38 ++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c     |  5 +++++
 3 files changed, 44 insertions(+)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 22e67ca7cba3..a41ed503f152 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -94,6 +94,7 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 		struct list_head *to_kill, int force_early);
 long ksm_process_profit(struct mm_struct *);
 bool ksm_process_mergeable(struct mm_struct *mm);
+void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s);

 #else  /* !CONFIG_KSM */

diff --git a/mm/ksm.c b/mm/ksm.c
index 2ef29802a49b..b533f0edaf96 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3308,6 +3308,44 @@ long ksm_process_profit(struct mm_struct *mm)
 }
 #endif /* CONFIG_PROC_FS */

+#ifdef CONFIG_MEMCG
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
+/* Show the ksm statistic count at memory.stat under cgroup mountpoint */
+void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s)
+{
+	struct memcg_ksm_stat ksm_stat;
+
+	if (mem_cgroup_is_root(memcg)) {
+		/* Just use the global counters when root memcg */
+		ksm_stat.ksm_rmap_items = ksm_rmap_items;
+	} else {
+		/* Initialization */
+		ksm_stat.ksm_rmap_items = 0;
+		/* Summing all processes'ksm statistic items */
+		mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
+	}
+	/* Print memcg ksm statistic items */
+	seq_buf_printf(s, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+}
+#endif
+
 #ifdef CONFIG_SYSFS
 /*
  * This all compiles without CONFIG_SYSFS, but is a waste of space.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 257d2c76b730..9595b132c6c3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/ksm.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -1492,6 +1493,10 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		}
 	}

+#ifdef CONFIG_KSM
+	memcg_stat_ksm_show(memcg, s);
+#endif
+
 	/* Accumulated memory events */
 	seq_buf_printf(s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
-- 
2.25.1

