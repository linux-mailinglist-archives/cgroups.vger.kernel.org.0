Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBBC352F92
	for <lists+cgroups@lfdr.de>; Fri,  2 Apr 2021 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhDBTRJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Apr 2021 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhDBTRH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Apr 2021 15:17:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16015C0613E6;
        Fri,  2 Apr 2021 12:17:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g20so6118505qkk.1;
        Fri, 02 Apr 2021 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KHwE2AhOFIJnmIDNMc1DwLLUBXXvq8Ulhj1XiQvB5I=;
        b=BXaI/FORtIxMvTFmIa9kbNY62q1FS0JEgTex/Q4f5VKgABUmi+/JkKYUVd2RTFv6yX
         wQpyGa4OYO9YjtvIpxculFHDo4m2gm+Vzqr9RaiE6KrDSi3PpyuOE2z2Sfel7jL4nlaM
         +1dumXxo87f3ZSVnSwmw9/erMj2QJhMqIEUASqej03TSvjMnU7qVQwGjzBTO1eqV1vk5
         MTR88N6jcgDZgG3+Rnjn8dwnyoMspRBjvQnLmA5lMFwM5MuNFuuNnBmBR2Ii0hX38FLR
         sJtWQgorXlOFKPbMtdD2T/qcx/NYMCe9Q/onzQFSiHEjwFtt1YIbwb050CgTp4hyJMT7
         FXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KHwE2AhOFIJnmIDNMc1DwLLUBXXvq8Ulhj1XiQvB5I=;
        b=kdVxHi8VWc9QVW1db+sDJo/RJ7Xj4ar1aVoQEmE3bjVLqADBYpPdFM6iEAsbIzAo81
         XnusAesJLWXCwFC1cKL7bwEFFk0Na+6gEzuUqYNxPGWBk+sfn81uMFM6uUnb5mIxAUm/
         d2JRMh0FRvxh7TPnCgeHZnbpG90w+UVJq6WGpGYtglKOh0OmYS0O4c8ANkN/OT/cWTr+
         27KASAJzYtIRy5PGgKnxLA8Can8IrWJzsyENCGLEaNvXTjAOss9BJVwhaQsrV7tDW7xj
         0SS5gUb+zYMBnGEVZiiS4wghMaAs3S40f45QBWbWUmq6yK4Ll35KV1Qpq1yLr8a5DGF+
         1ehw==
X-Gm-Message-State: AOAM531dbMQomeXwObhhvmzjFjUvmE/48aNMgC2B2pKsLizqe/dquOVO
        /C6YKmK2ywMO2n6871e0ARg=
X-Google-Smtp-Source: ABdhPJxMGcXT3JcQRvQnajZ/JKy0cNPymTLKlftpElVkfeeC60c7QmwgaMW2l1kPWw/4acp3YR2Kbw==
X-Received: by 2002:a05:620a:209d:: with SMTP id e29mr14597432qka.316.1617391024335;
        Fri, 02 Apr 2021 12:17:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:ae82])
        by smtp.gmail.com with ESMTPSA id 8sm8083426qkc.32.2021.04.02.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:17:03 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        Chris Down <chris@chrisdown.name>
Subject: [PATCH 2/3] mm: Charge active memcg when no mm is set
Date:   Fri,  2 Apr 2021 12:16:33 -0700
Message-Id: <20210402191638.3249835-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

set_active_memcg() worked for kernel allocations but was silently
ignored for user pages.

This patch establishes a precedence order for who gets charged:

1. If there is a memcg associated with the page already, that memcg is
   charged. This happens during swapin.

2. If an explicit mm is passed, mm->memcg is charged. This happens
   during page faults, which can be triggered in remote VMs (eg gup).

3. Otherwise consult the current process context. If there is an
   active_memcg, use that. Otherwise, current->mm->memcg.

Previously, if a NULL mm was passed to mem_cgroup_charge (case 3) it
would always charge the root cgroup. Now it looks up the active_memcg
first (falling back to charging the root cgroup if not set).

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/filemap.c    |  2 +-
 mm/memcontrol.c | 48 +++++++++++++++++++++++++++++++-----------------
 mm/shmem.c      |  4 ++--
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c03463cb72d6..38648f7d2106 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -872,7 +872,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	page->index = offset;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page, current->mm, gfp);
+		error = mem_cgroup_charge(page, NULL, gfp);
 		if (error)
 			goto error;
 		charged = true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c0b83a396299..d2939d6602b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -886,13 +886,24 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 }
 EXPORT_SYMBOL(mem_cgroup_from_task);
 
+static __always_inline struct mem_cgroup *active_memcg(void)
+{
+	if (in_interrupt())
+		return this_cpu_read(int_active_memcg);
+	else
+		return current->active_memcg;
+}
+
 /**
  * get_mem_cgroup_from_mm: Obtain a reference on given mm_struct's memcg.
  * @mm: mm from which memcg should be extracted. It can be NULL.
  *
- * Obtain a reference on mm->memcg and returns it if successful. Otherwise
- * root_mem_cgroup is returned. However if mem_cgroup is disabled, NULL is
- * returned.
+ * Obtain a reference on mm->memcg and returns it if successful. If mm
+ * is NULL, then the memcg is chosen as follows:
+ * 1) The active memcg, if set.
+ * 2) current->mm->memcg, if available
+ * 3) root memcg
+ * If mem_cgroup is disabled, NULL is returned.
  */
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
@@ -901,13 +912,23 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	/*
+	 * Page cache insertions can happen without an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
+	 */
+	if (unlikely(!mm)) {
+		memcg = active_memcg();
+		if (unlikely(memcg)) {
+			/* remote memcg must hold a ref */
+			css_get(&memcg->css);
+			return memcg;
+		}
+		mm = current->mm;
+	}
+
 	rcu_read_lock();
 	do {
-		/*
-		 * Page cache insertions can happen without an
-		 * actual mm context, e.g. during disk probing
-		 * on boot, loopback IO, acct() writes etc.
-		 */
 		if (unlikely(!mm))
 			memcg = root_mem_cgroup;
 		else {
@@ -921,14 +942,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
-static __always_inline struct mem_cgroup *active_memcg(void)
-{
-	if (in_interrupt())
-		return this_cpu_read(int_active_memcg);
-	else
-		return current->active_memcg;
-}
-
 static __always_inline bool memcg_kmem_bypass(void)
 {
 	/* Allow remote memcg charging from any context. */
@@ -6537,7 +6550,8 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
  * @gfp_mask: reclaim mode
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * charge to the active memcg.
  *
  * Do not use this for pages allocated for swapin.
  *
diff --git a/mm/shmem.c b/mm/shmem.c
index 5cfd2fb6e52b..524fa5aa0459 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1694,7 +1694,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct page *page;
 	swp_entry_t swap;
 	int error;
@@ -1815,7 +1815,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : current->mm;
+	charge_mm = vma ? vma->vm_mm : NULL;
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
-- 
2.30.2

