Return-Path: <cgroups+bounces-10316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F869B8DD13
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F1189CA09
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F33B1C861A;
	Sun, 21 Sep 2025 15:09:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403E146588;
	Sun, 21 Sep 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467345; cv=none; b=F1qENbJ3+kfwRyh1XLqv5qUqjGlw0ozmbjECqiGS9u7Uww9xSkTUurh4IsIzlHFNqMTTQ4Eb5QqOwcrTDePO831+IwaZlh+DaEkw8ysq7hwUlF5xLTPyn886qcidLo6Nhl6qRzrgbmMQbzQazgLWBGi+vwWjgNayDuIi4eFGJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467345; c=relaxed/simple;
	bh=KZd/ED+7o7EkoeJyVZYwZmfLg42CgrN/IDRXqp6qUlk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=HRhGoWF7GVr2V1XG3diUbQjdMqEnLmN5ocEODg9ioWoqS+jem9OkKf1yrS7nh83wtmBVWEXj2KaznB5blaL827DGWCgJXxSKT893vMGhtZUlKlHAiijaMzmELm17Kzi2sZoZOX+FLzpGKWSqwwy2a7zu6S08NvzEk7zaTatropA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cV8lc0d6Wz8Xs70;
	Sun, 21 Sep 2025 23:09:00 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 58LF8pmu055494;
	Sun, 21 Sep 2025 23:08:51 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:08:54 +0800 (CST)
Date: Sun, 21 Sep 2025 23:08:54 +0800 (CST)
X-Zmail-TransId: 2afa68d0150669b-1c21a
X-Mailer: Zmail v1.0
Message-ID: <20250921230854496C6rkj7YZAYi39dNV3t6Fp@zte.com.cn>
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
Cc: <akpm@linux-foundation.org>, <shakeel.butt@linux.dev>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <david@redhat.com>, <chengming.zhou@linux.dev>,
        <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMS82XSBtZW1jZzogYWRkIHBlci1tZW1jZyBrc21fcm1hcF9pdGVtcyBzdGF0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58LF8pmu055494
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 21 Sep 2025 23:09:00 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D0150C.000/4cV8lc0d6Wz8Xs70

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
 mm/ksm.c            | 39 +++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c     |  5 +++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 067538fc4d58..ce2a32b73f95 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -100,6 +100,7 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 		struct list_head *to_kill, int force_early);
 long ksm_process_profit(struct mm_struct *);
 bool ksm_process_mergeable(struct mm_struct *mm);
+void memcg_stat_ksm_show(struct mem_cgroup *memcg, struct seq_buf *s);

 #else  /* !CONFIG_KSM */

diff --git a/mm/ksm.c b/mm/ksm.c
index 2ef29802a49b..be0efa0f8f2b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -40,6 +40,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/pagewalk.h>
+#include <linux/seq_buf.h>

 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -3308,6 +3309,44 @@ long ksm_process_profit(struct mm_struct *mm)
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
index e090f29eb03b..705717f73b89 100644
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
@@ -1493,6 +1494,10 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
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

