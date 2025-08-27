Return-Path: <cgroups+bounces-9446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4DEB38953
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB06A1B21E18
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F12D0612;
	Wed, 27 Aug 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lzsZBOCZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85954C98
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318444; cv=none; b=ubMzT5d59BxpENV307/aY92DkAuxgkfiXZAUJMaKC0TVUfaMRrZRQwU5tdHJ+AM5XnuH/LW4OUvj0IrpTodu9UWbOTkiCSwGzajPyEmfpzjSAUhvvkv60ZXzJU5hGiBZTMYaQcylEU20igmcawiuwSCQgAul7iVAbFDQLan10TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318444; c=relaxed/simple;
	bh=5EdRezsWV8Xiy7ZM267xr0dLeC7tZZV8/YqKxe52D0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8UXRTZE2aJ7Ksp+Hmtc4lZtaeDDEW+TDFZsSzi6G8zPtHspnogeUXyWiF8d4X7omyIplrSLAFe/+4TVoClXuAP2K2mB8trxoBfbs/e5VlmHDtq5Tx9cfFqxmDPPOuTNtL5DHyGHWjLbaVwO/gH4/Ui3PyXEG0tXnM8gfrtsq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lzsZBOCZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7704799d798so136391b3a.3
        for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756318441; x=1756923241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdUaVv5/q92fEJn4ngmJCNwvS1NxjHxx36mqmnqPgHE=;
        b=lzsZBOCZRyrZr524WTgAV4xgSrNnj8A6arr//Ji+/+87EM0TCUER/lEuWX6wyyLaAh
         2hgyOromgCNcm1XOyifyZtDwLRjItbNiGzg84A1RAA0QrMjt5I0V/eFwRj3tqnHPpiBt
         tcMdcrv2y8rD9iJwerqXrR0nSVgHf8Ytv/RUKNAA+CaOjMtK/K1EL/ymRv366G74q1Ax
         OmIRPkSdlV1gqGTZsicKRAoOWkm4aCDjAaJq7dnQaJO6D0UWAKB7jAzQ9w6AgmaHYGiV
         dsAK1NuZsWyLXuLrZhxK2RW50eFIDLiYux/qiZv4tsC+tdN6jTg4vq7EIdikdvur8LEv
         /meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756318441; x=1756923241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdUaVv5/q92fEJn4ngmJCNwvS1NxjHxx36mqmnqPgHE=;
        b=Y6YfCqBG1kQWUHkJglyyMoB1ZEtc4ZzXigh5OKgneraIJDB0Nbkf5+cSB4l24Ij29l
         hYeNBPoWmdAB6XaYVJ7RckF+rvzIGHwpFNab784XsgsAuUf3nt5akCpXwEikRGE2PHaP
         A2s4A6x2J7lPkzaLNSxiYlgMuVVaI3SaalzKhwH8yd+eD7nIsYats41qMQUO1PQPsjgl
         yScfoTVfH3u+qM3T0qKNt3uPNcaSuVIaFBfM7fzNs+L20qlWWsfLSsDXGzD94SLkca8w
         v5Hq6FoUdrTZc/a2tkqINTZuDPGWdj+Z4umwuDRKbJHngdqfdlgwLrK3mdRtSjL7s32H
         zeOw==
X-Gm-Message-State: AOJu0YwyN7kkR6Oq2QwWWl4nVMC3mCW5khoy+2DO/yVGeh5TWJruOQld
	DmwKJs7JIk9srBrlWw02n8LqX7Wxvi1MfvooysnFZPp5JQme7muyCrQg+dfhwVV+ZwhXsLLtRHL
	Q3curJFnqZaTx
X-Gm-Gg: ASbGncsQbdz1yLRdzRSZhK/7ZwpQh2bfc2CQRWCSWJP3SXpggnY+e96Wr3Fr9K5S/oB
	Bu5/5hY8tMMBuxlTxus2Vpwg8vkFehlwZToEqOfLAoiRQ5k4pEGkGvRTzSmjoNufCjwpV7w78AD
	QQST1sy8MfcyWTp5zc9EDiTJkaLct8YiGYVqb0hOXuCyHKlwRRFYVij0t/kceel/9gyB+Kr/LyG
	hnpAFCPmhEbeTBOUpZQM0lph0KmHR1rXcPSjyvOhCc1IPo83i4V6SRba8T9Y9H3h7nOAB1dpB8f
	5KYztdrFTgBf+zHvnYmhzQYRCeX49w0QZAkgoXHRDvu/IgGu3y87hckmpVJQ3lU1GvAg1+WhVn+
	4yyId
X-Google-Smtp-Source: AGHT+IGCmZr0Zre+3COOBtEP5LaYvPBToTS9DePQeYSQkW3zFjmEengazb3hEGUo7UDhLeBVUJPbug==
X-Received: by 2002:a05:6a20:7f96:b0:220:10e5:825d with SMTP id adf61e73a8af0-24340ad0a52mr27608359637.8.1756318440578;
        Wed, 27 Aug 2025 11:14:00 -0700 (PDT)
Received: from localhost ([101.82.184.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm2593013a91.26.2025.08.27.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:14:00 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: jack@suse.cz,
	tj@kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v3] memcg: Don't wait writeback completion when release memcg.
Date: Thu, 28 Aug 2025 02:13:56 +0800
Message-Id: <20250827181356.40971-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
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
  Changes in v3:
    * Rename cgwb_frn_wq_entry to cgwb_frn_wait.
    * Define memcg_cgwb_waitq_callback_fn() only when 
      CONFIG_CGROUP_WRITEBACK is defined.
    * Embed wb_completion into struct cgwb_frn_wait.

  Change in v2:
    * Use custom waitq function to free resources

 include/linux/backing-dev-defs.h |  7 +++++
 include/linux/memcontrol.h       |  8 ++++-
 mm/memcontrol.c                  | 54 ++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 10 deletions(-)

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
index 785173aa0739..24e881ce4909 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -157,11 +157,17 @@ struct mem_cgroup_thresholds {
  */
 #define MEMCG_CGWB_FRN_CNT	4
 
+struct cgwb_frn_wait {
+	struct wb_completion done;
+	struct wait_queue_entry wq_entry;
+};
+
 struct memcg_cgwb_frn {
 	u64 bdi_id;			/* bdi->id of the foreign inode */
 	int memcg_id;			/* memcg->css.id of foreign inode */
 	u64 at;				/* jiffies_64 at the time of dirtying */
-	struct wb_completion done;	/* tracks in-flight foreign writebacks */
+	struct wb_completion *done;	/* tracks in-flight foreign writebacks */
+	struct cgwb_frn_wait *wait;	/* used to free resources when release memcg */
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..d9d8b3cc82d5 100644
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
@@ -3702,13 +3702,27 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 	__mem_cgroup_free(memcg);
 }
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_entry, unsigned int mode,
+					int flags, void *key)
+{
+	struct cgwb_frn_wait *frn_wait = container_of(wq_entry,
+						      struct cgwb_frn_wait, wq_entry);
+
+	list_del(&wq_entry->entry);
+	kfree(frn_wait);
+
+	return 0;
+}
+#endif
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
@@ -3763,9 +3777,17 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		memcg->cgwb_frn[i].done =
-			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		frn->wait = kmalloc(sizeof(struct cgwb_frn_wait), GFP_KERNEL);
+		if (!frn->wait)
+			goto fail;
+
+		wb_completion_init(&frn->wait->done, &memcg_cgwb_frn_waitq);
+		init_wait_func(&frn->wait->wq_entry, memcg_cgwb_waitq_callback_fn);
+		frn->done = &frn->wait->done;
+	}
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
@@ -3775,6 +3797,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
+#ifdef CONFIG_CGROUP_WRITEBACK
+	while (i--)
+		kfree(memcg->cgwb_frn[i].wait);
+#endif
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return ERR_PTR(error);
@@ -3912,8 +3938,18 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		if (atomic_dec_and_test(&frn->done->cnt))
+			kfree(frn->wait);
+		else
+			/*
+			 * Not necessary to wait for wb completion which might cause task hung,
+			 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
+			 */
+			__add_wait_queue_entry_tail(frn->done->waitq, &frn->wait->wq_entry);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


