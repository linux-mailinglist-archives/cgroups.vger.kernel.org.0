Return-Path: <cgroups+bounces-9418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D57B35EF6
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A767AFD19
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CB2BE7D9;
	Tue, 26 Aug 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Md35W654"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA82798ED
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210585; cv=none; b=hAUuHSZC2GV6KXar9tOgwrklJ7zOnDFCHcuixoUXdjmiWZ5oj1b8Q9SjAQFAynPEOlmgSH1pQ7vFoa2e8M9brbyA5sPj9DaZ7dqA1RHQWzAzMuWyXtXdmQ0psol4HR83Z6RUZ8tBGPjy87cd4l+Luh5aMjQHWX6zwVKmq3aOvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210585; c=relaxed/simple;
	bh=6sp2IYjNFNV3pCRsYAjobJB86c8nMP6fWtHOvCmy+ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMovCPXUqQozpchEdRmF4lceIyhmrSoL7M/g4GVKzvi4a0cxoCSprU+y0KRDWjs7kr9AIq68/73Hz4wTFunmOM9glavESGh9z6zaNkByxafBON0r7+icAp9UzH7Al9BGDFXMgM1ovwso7hMdYvOcixYnJEvKc1gaLw+DaT66woE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Md35W654; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-246fc803b90so14850975ad.3
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756210582; x=1756815382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gI8Rkz2xs2TNrO5rkZwGpMdZoPF3RS/IxewK8Qap8Ak=;
        b=Md35W654bRTOyzAVGh3KDBHVSp2y2s2CU9TMMVfXnGge/AK6D6MpY6kqqdBDxAa8aK
         smHJLUe12TO+Eo6k8sNKr/WTyzujUBJWiSW7w05OV1b0F82/yXve0ARzuYPFqVLfTvcr
         bn2Jdu+/LP+puaPpoNQUxYTJXVlFrEHtm5TbNMATT8LDg2s0FMqYJdxMYP0n0UfUG9Ro
         3tRtm/ZtpGyUCSyTvJVY5XL50Z90dVPhvRyXGNYdVlK9ZP/CbbVB4MCYGfW4F94jQkKn
         3d0iCbMXgfOcgHJTPUDZ++OLA+8CN/0pmTeC3NKM10a35HPK57o6knO7qc/TL2AMEuTg
         MOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210582; x=1756815382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gI8Rkz2xs2TNrO5rkZwGpMdZoPF3RS/IxewK8Qap8Ak=;
        b=EF9uoAz2pOB8NeBTUbMnLsI+L2b3DwfUreVTb4X+fozO3yycFXjBViYNltCHmW5bRK
         mH80aQwiRqt6dEYXwk6pwP4NM7OObchHyq2nn57rC0KBdkRbPJ+RqF6UC/JD+jEzdH2n
         ZqKT3aFaGplVrtD5Us+uh8R3LpdF2iD2hpovwoy9FAUJ+ArCNj9faR+FC1cjKXg/fw8L
         0RGM/AYg3sPggrCpCg8ZM2zGjfSA3A3Uk0+VHhuc6dRSkYIMLOabBBAgljCoJ/MSb7QE
         KoPFPvbkVeffNb4uD+UVf3RYPQsXuCQCkxR3sD+JJ3uqMSCTc/rKzv+Dj8v8HU6+R83Q
         Nlkg==
X-Gm-Message-State: AOJu0YwlQFad0FX47mufONCGZpYOEzDyorY/8skBvL1ELsuxk9/KWTEo
	8DCsitWvInlbnJfl/oSPF3Ga5Xgh5RYA+wwRQsqIUaW+zYUXMVAss9OHWYFHNLpBIkRfwCKQ7kT
	YuwkcVZxJYA==
X-Gm-Gg: ASbGncsHZApwU3V3dT8aT0tWE6OguR7cSN+LfcirPqPznEsH9oQh6St5ogc8m6++NF3
	L+YyUg4hpScRRV1cSXF4lNDy2uO/I99Nz5K+s/fyplGcXLGb6JtmLpwPiKQdQafWP+YkXl/1ZNk
	acBWi7j/ySYl/nQL1Ex0R+OfEYcJXV0QbUg3zBEKT8usk+rQlY+feMjHsGQ8HkksGKExHldMFTh
	nbUwiHoFjlbOVHjZw2FrXm+ewZjCSWt+7ctu1T3LDmwCzZsoeDNUFaHFt9zLKLsa/lgBF5x6QuL
	mZegtB2l2ghe8Yaro7ib2a61y9DZ5rOlUdczdS7oWJ6/9V99DZu/QkZc3TGdGopbuBIlVFDcw1q
	KqzyAQ2fu+7ACkwCcD26UI/+6kNCBiA==
X-Google-Smtp-Source: AGHT+IFqn3VtdQOuMTY/ZFF0B1ec+ONaoq3koATTk6iUYsrDd3VlLlXjAabCYWVUIup+ISfCqmsHZg==
X-Received: by 2002:a17:903:2f08:b0:246:3583:394d with SMTP id d9443c01a7336-2463583555emr192356195ad.29.1756210581656;
        Tue, 26 Aug 2025 05:16:21 -0700 (PDT)
Received: from localhost ([106.38.226.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm95376665ad.42.2025.08.26.05.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:16:21 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	jack@suse.cz
Subject: [PATCH v2] memcg: Don't wait writeback completion when release memcg.
Date: Tue, 26 Aug 2025 20:16:18 +0800
Message-Id: <20250826121618.3594169-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, we encountered the following hung task:

INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
[Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
[Wed Jul 30 17:47:45 2025] Call Trace:
[Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
[Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
[Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
[Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
[Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
[Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
[Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
[Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
[Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
[Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
[Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
[Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
[Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
[Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30

The direct cause is that memcg spends a long time waiting for dirty page
writeback of foreign memcgs during release.

The root causes are:
    a. The wb may have multiple writeback tasks, containing millions
       of dirty pages, as shown below:

>>> for work in list_for_each_entry("struct wb_writeback_work", \
				    wb.work_list.address_of_(), "list"):
...     print(work.nr_pages, work.reason, hex(work))
...
900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00

    b. The writeback might severely throttled by wbt, with a speed
       possibly less than 100kb/s, leading to a very long writeback time.

>>> wb.write_bandwidth
(unsigned long)24
>>> wb.write_bandwidth
(unsigned long)13

The wb_wait_for_completion() here is probably only used to prevent
use-after-free. Therefore, we manage 'done' separately and automatically
free it.

This allows us to remove wb_wait_for_completion() while preventing
the use-after-free issue.

Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---

 Changes in v2:
  * Use custom waitq function to free resources.

 include/linux/backing-dev-defs.h |  7 ++++
 include/linux/memcontrol.h       |  8 ++++-
 mm/memcontrol.c                  | 62 +++++++++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..6c1ed286da6a 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -65,6 +65,13 @@ struct wb_completion {
 	wait_queue_head_t	*waitq;
 };
 
+static inline void wb_completion_init(struct wb_completion *done,
+									  struct wait_queue_head *waitq)
+{
+	atomic_set(&done->cnt, 1);
+	done->waitq = waitq;
+}
+
 #define __WB_COMPLETION_INIT(_waitq)	\
 	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..f6dd771df369 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -157,11 +157,17 @@ struct mem_cgroup_thresholds {
  */
 #define MEMCG_CGWB_FRN_CNT	4
 
+struct cgwb_frn_wq_entry {
+	struct wb_completion *done;
+	struct wait_queue_entry wq_entry;
+};
+
 struct memcg_cgwb_frn {
 	u64 bdi_id;			/* bdi->id of the foreign inode */
 	int memcg_id;			/* memcg->css.id of foreign inode */
 	u64 at;				/* jiffies_64 at the time of dirtying */
-	struct wb_completion done;	/* tracks in-flight foreign writebacks */
+	struct wb_completion *done;	/* tracks in-flight foreign writebacks */
+	struct cgwb_frn_wq_entry *frn_wq; /* used to free resources when release memcg */
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..b47f3972c1ed 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3459,7 +3459,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 		    frn->memcg_id == wb->memcg_css->id)
 			break;
 		if (time_before64(frn->at, oldest_at) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->done->cnt) == 1) {
 			oldest = i;
 			oldest_at = frn->at;
 		}
@@ -3506,12 +3506,12 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		 * already one in flight.
 		 */
 		if (time_after64(frn->at, now - intv) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->done->cnt) == 1) {
 			frn->at = 0;
 			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
-					       &frn->done);
+					       frn->done);
 		}
 	}
 }
@@ -3702,13 +3702,26 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 	__mem_cgroup_free(memcg);
 }
 
+static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_entry, unsigned int mode,
+					int flags, void *key)
+{
+	struct cgwb_frn_wq_entry *frn_wq_entry = container_of(wq_entry,
+							struct cgwb_frn_wq_entry, wq_entry);
+
+	list_del_init_careful(&wq_entry->entry);
+	kfree(frn_wq_entry->done);
+	kfree(frn_wq_entry);
+
+	return 0;
+}
+
 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
 	struct memcg_vmstats_percpu *statc;
 	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
-	int __maybe_unused i;
+	int __maybe_unused i = 0;
 	long error;
 
 	memcg = kmem_cache_zalloc(memcg_cachep, GFP_KERNEL);
@@ -3763,9 +3776,23 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		memcg->cgwb_frn[i].done =
-			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		frn->done = kmalloc(sizeof(struct wb_completion), GFP_KERNEL);
+		if (!frn->done)
+			goto fail;
+
+		frn->frn_wq = kmalloc(sizeof(struct cgwb_frn_wq_entry), GFP_KERNEL);
+		if (!frn->frn_wq) {
+			kfree(frn->done);
+			goto fail;
+		}
+
+		wb_completion_init(frn->done, &memcg_cgwb_frn_waitq);
+		init_wait_func(&frn->frn_wq->wq_entry, memcg_cgwb_waitq_callback_fn);
+		frn->frn_wq->done = frn->done;
+	}
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
@@ -3775,6 +3802,12 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
+#ifdef CONFIG_CGROUP_WRITEBACK
+	while (i--) {
+		kfree(memcg->cgwb_frn[i].done);
+		kfree(memcg->cgwb_frn[i].frn_wq);
+	}
+#endif
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return ERR_PTR(error);
@@ -3912,8 +3945,19 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		if (atomic_dec_and_test(&frn->done->cnt)) {
+			kfree(frn->done);
+			kfree(frn->frn_wq);
+		} else
+			/*
+			 * Not necessary to wait for wb completion which might cause task hung,
+			 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
+			 */
+			__add_wait_queue_entry_tail(frn->done->waitq, &frn->frn_wq->wq_entry);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.20.1


