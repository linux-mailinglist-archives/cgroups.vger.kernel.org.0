Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAC6785FC
	for <lists+cgroups@lfdr.de>; Mon, 23 Jan 2023 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjAWTSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 14:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjAWTR7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 14:17:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655A3AA7
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 11:17:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso14236877ybe.21
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29eNHuXkN4Biw7YjDro7DKxD9MLgh2JPpCUKKyMlqpA=;
        b=Subdt7mbpSJ3q++6bJrXZjJZZw2B5aXVhcYIOjpWp1e7w65W6r5oAUZpnmuhuuxtGC
         m6yHwVIfAM74kNHnxjivy2kMGAg6vCfv+3hhWBYw2BJN0Dja1Y7NQKOgWr6COa+8oUkk
         rUnUidJgv1sRL2Bt6YdHCPqVzpfizdrAy9YnM1stYfRMcfzP4DXyiUe0ObHRm1rO0ZdX
         Z1ZA/fI74arWwHwvDOYrrcmDZGCsMH3Nq+OQolvzt4CNc9tJFsaB0vn3Yw+H2aqetp8n
         bmppFH7vBRP4aW++HEHSq4uD8ir3GpzrY/G/loULfk/4Fe0e7jWIDY4IGgw0L9zKW6Fz
         9YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29eNHuXkN4Biw7YjDro7DKxD9MLgh2JPpCUKKyMlqpA=;
        b=4Rq6uDIaZB/pu3Dmo7+1gBhyD+ZgHtgnuvk/wm9aVmzKYrUsYCSpJo7kDDc+n0xKx/
         kUtkKQOnyF0iFh/xgyhp0ZW++AEftk5T8D8zOKoGg5uPgrtQxFLkxNg3y7OrKuGIQbRH
         G4SPMYocyHCDOijrh9Q0xugEJmqwVKHsJHaYhy0a//pAZuvFHWEDpvbEkbc6kMcikqXE
         f+6wLfDmrY3A/RW3VhCfKQaIDPjPTmp9gqg/vND2FfKs/kTHhf+sup7E7iwX4D/0YNlg
         O9tELRkl23RWbAW6oomnqXIbfETnqIrbRd1zCOMgPfGJAf56fAi4192D/qzPA/2rXmqd
         DHLg==
X-Gm-Message-State: AFqh2koO3l3ZAiQjrx2p9x6eZJIkurf2yMHiW8qmDAhaJtibT27+G9m0
        jYdbIhaIJsHq3KzqJ9oObmtrN6jcvux4FMg=
X-Google-Smtp-Source: AMrXdXuIEmBCRRQ29mCX2Lz8F60RAV61DpR49m4PqdkPLl3Fou0sh8htd5KZF+eNK2HXmLDFr4FD/qKGK/2gVtE=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a81:5553:0:b0:4d1:959d:fa49 with SMTP id
 j80-20020a815553000000b004d1959dfa49mr3602848ywb.33.1674501476646; Mon, 23
 Jan 2023 11:17:56 -0800 (PST)
Date:   Mon, 23 Jan 2023 19:17:23 +0000
In-Reply-To: <20230123191728.2928839-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230123191728.2928839-2-tjmercier@google.com>
Subject: [PATCH v2 1/4] memcg: Track exported dma-buffers
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, cmllamas@google.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a buffer is exported to userspace, use memcg to attribute the
buffer to the allocating cgroup until all buffer references are
released.

Unlike the dmabuf sysfs stats implementation, this memcg accounting
avoids contention over the kernfs_rwsem incurred when creating or
removing nodes.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 +++
 drivers/dma-buf/dma-buf.c               | 13 +++++++++
 include/linux/dma-buf.h                 |  3 ++
 include/linux/memcontrol.h              | 38 +++++++++++++++++++++++++
 mm/memcontrol.c                         | 19 +++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c8ae7c897f14..538ae22bc514 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1455,6 +1455,10 @@ PAGE_SIZE multiple when read back.
 		Amount of memory used for storing in-kernel data
 		structures.
 
+	  dmabuf (npn)
+		Amount of memory used for exported DMA buffers allocated by the cgroup.
+		Stays with the allocating cgroup regardless of how the buffer is shared.
+
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
 
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index e6528767efc7..a6a8cb5cb32d 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -75,6 +75,9 @@ static void dma_buf_release(struct dentry *dentry)
 	 */
 	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
 
+	mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
+	mem_cgroup_put(dmabuf->memcg);
+
 	dma_buf_stats_teardown(dmabuf);
 	dmabuf->ops->release(dmabuf);
 
@@ -673,6 +676,13 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	if (ret)
 		goto err_dmabuf;
 
+	dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
+	if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
+				      GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_memcg;
+	}
+
 	file->private_data = dmabuf;
 	file->f_path.dentry->d_fsdata = dmabuf;
 	dmabuf->file = file;
@@ -683,6 +693,9 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	return dmabuf;
 
+err_memcg:
+	mem_cgroup_put(dmabuf->memcg);
+	dma_buf_stats_teardown(dmabuf);
 err_dmabuf:
 	if (!resv)
 		dma_resv_fini(dmabuf->resv);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 6fa8d4e29719..1f0ffb8e4bf5 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
+#include <linux/memcontrol.h>
 
 struct device;
 struct dma_buf;
@@ -446,6 +447,8 @@ struct dma_buf {
 		struct dma_buf *dmabuf;
 	} *sysfs_entry;
 #endif
+	/* The cgroup to which this buffer is currently attributed */
+	struct mem_cgroup *memcg;
 };
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d3c8203cab6c..c10b8565fdbf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -37,6 +37,7 @@ enum memcg_stat_item {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+	MEMCG_DMABUF,
 	MEMCG_NR_STAT,
 };
 
@@ -673,6 +674,25 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
+
+/**
+ * mem_cgroup_charge_dmabuf - Charge dma-buf memory to a cgroup and update stat counter
+ * @memcg: memcg to charge
+ * @nr_pages: number of pages to charge
+ * @gfp_mask: reclaim mode
+ *
+ * Charges @nr_pages to @memcg. Returns %true if the charge fit within
+ * @memcg's configured limit, %false if it doesn't.
+ */
+bool __mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages, gfp_t gfp_mask);
+static inline bool mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages,
+					    gfp_t gfp_mask)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+	return __mem_cgroup_charge_dmabuf(memcg, nr_pages, gfp_mask);
+}
+
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 
 void __mem_cgroup_uncharge(struct folio *folio);
@@ -690,6 +710,14 @@ static inline void mem_cgroup_uncharge(struct folio *folio)
 	__mem_cgroup_uncharge(folio);
 }
 
+void __mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_dmabuf(memcg, nr_pages);
+}
+
 void __mem_cgroup_uncharge_list(struct list_head *page_list);
 static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
@@ -1242,6 +1270,12 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
+static inline bool mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages,
+					    gfp_t gfp_mask)
+{
+	return true;
+}
+
 static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 {
 }
@@ -1250,6 +1284,10 @@ static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
 
+static inline void mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+}
+
 static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab..375d18370f4b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1502,6 +1502,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "unevictable",		NR_UNEVICTABLE			},
 	{ "slab_reclaimable",		NR_SLAB_RECLAIMABLE_B		},
 	{ "slab_unreclaimable",		NR_SLAB_UNRECLAIMABLE_B		},
+	{ "dmabuf",			MEMCG_DMABUF			},
 
 	/* The memory events */
 	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
@@ -4042,6 +4043,7 @@ static const unsigned int memcg1_stats[] = {
 	WORKINGSET_REFAULT_ANON,
 	WORKINGSET_REFAULT_FILE,
 	MEMCG_SWAP,
+	MEMCG_DMABUF,
 };
 
 static const char *const memcg1_stat_names[] = {
@@ -4057,6 +4059,7 @@ static const char *const memcg1_stat_names[] = {
 	"workingset_refault_anon",
 	"workingset_refault_file",
 	"swap",
+	"dmabuf",
 };
 
 /* Universal VM events cgroup1 shows, original sort order */
@@ -7299,6 +7302,22 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 	refill_stock(memcg, nr_pages);
 }
 
+bool __mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages, gfp_t gfp_mask)
+{
+	if (try_charge(memcg, gfp_mask, nr_pages) == 0) {
+		mod_memcg_state(memcg, MEMCG_DMABUF, nr_pages);
+		return true;
+	}
+
+	return false;
+}
+
+void __mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
+	refill_stock(memcg, nr_pages);
+}
+
 static int __init cgroup_memory(char *s)
 {
 	char *token;
-- 
2.39.0.246.g2a6d74b583-goog

