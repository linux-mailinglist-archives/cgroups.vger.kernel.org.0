Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC234D2C5
	for <lists+cgroups@lfdr.de>; Mon, 29 Mar 2021 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhC2Otw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhC2OtO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Mar 2021 10:49:14 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544AC061574;
        Mon, 29 Mar 2021 07:49:12 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 30so6539265qva.9;
        Mon, 29 Mar 2021 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rthy9P0Uh0koEJAABJmO03Eire712vne5xpQyDeAJI4=;
        b=XZIDOotpCQUmqCUTzgdbM8HJwIVy95s2B1jNzXPmJ4vLobO925VPGi5h2cxuRcOr6m
         P0Gn0hmTY+Djt+3Br3i5bCY7ohQ0YBNJ+0neLiCdBePj6yBCOQKOPVBI0mpDh/Ylu7HA
         tTS8doZTk1LNXCgmrl5aJtIkOoLN2CZMqqjTlG7p5PXZ1/3ww3JGfDauAwyMJ4/hcEoz
         lfw+rrWA2eJ3fp65V/B0T7HVjflxGy0y1HBEStGDoaKwE4Q5xA0TXGVe5gh5Z5blKadd
         8UaXcRFJVASTjFWpG8SevupS9sLNcFSZlAPrCsiMYIVA8JA0DDpV1hsNdCy7COqs0MsP
         yMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rthy9P0Uh0koEJAABJmO03Eire712vne5xpQyDeAJI4=;
        b=GdEKyXFjEAMIJrcZ/eyYgDY6if87hYX8U91XAb9GrneJzPSSCu/I7/9LXIkS2IM0P3
         cJd7I+aSTOmQ9CPcItyphqGl4YLIA2lN9ODDfSeZXE47XPYiyqFwqa3n13Sh5OvdMy5N
         a3DDu7rIGyu69YxFivVqJVBwjTFhgBAZsQcAKxC80nIHdr2fjPVuFaIfAIacj/SUQjVX
         zWjwtg2xTTYxVd3iiUFJd2f8Bkik/tWmRRHfJYkjvnj3mBMxkgcB+4khmO10dtSQry8B
         dDDEn5f8WOU3e9A963WVmsAq/jpWGvaIiMhbQW5DjMG7BAufa3CqlwoS6qVy6LqgqOs6
         T/6w==
X-Gm-Message-State: AOAM531gsA7VRLkPIBnNMH9D7eWGfcoygURMts/JHn/SD/eeMgvYQ43T
        LdKF5iOVyTHeMlx0Epy2oa4=
X-Google-Smtp-Source: ABdhPJyrPwiFHe9h8ZF/GhbLu+UwDgiEfytWhwG8ZmTnL/HS3e9ZG9nz3oT6qCsy2JGljwvTpeBPmw==
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr25705154qvb.12.1617029351737;
        Mon, 29 Mar 2021 07:49:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6ffc])
        by smtp.gmail.com with ESMTPSA id d14sm14255708qkg.33.2021.03.29.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:49:11 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        Chris Down <chris@chrisdown.name>
Subject: [PATCH 2/3] mm: Charge active memcg when no mm is set
Date:   Mon, 29 Mar 2021 07:48:24 -0700
Message-Id: <20210329144829.1834347-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329144829.1834347-1-schatzberg.dan@gmail.com>
References: <20210329144829.1834347-1-schatzberg.dan@gmail.com>
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
 mm/memcontrol.c | 72 ++++++++++++++++++++++++++++---------------------
 mm/shmem.c      |  4 +--
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index eeeb8e2cc36a..63fd980e863a 100644
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
index 668d1d7c2645..adc618814fd2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -884,13 +884,38 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
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
+static __always_inline struct mem_cgroup *get_active_memcg(void)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = active_memcg();
+	/* remote memcg must hold a ref. */
+	if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
+		memcg = root_mem_cgroup;
+	rcu_read_unlock();
+
+	return memcg;
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
@@ -899,13 +924,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	/*
+	 * Page cache insertions can happen without an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
+	 */
+	if (unlikely(!mm)) {
+		if (unlikely(active_memcg()))
+			return get_active_memcg();
+		mm = current->mm;
+	}
+
 	rcu_read_lock();
 	do {
-		/*
-		 * Page cache insertions can happen withou an
-		 * actual mm context, e.g. during disk probing
-		 * on boot, loopback IO, acct() writes etc.
-		 */
 		if (unlikely(!mm))
 			memcg = root_mem_cgroup;
 		else {
@@ -919,28 +950,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
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
-static __always_inline struct mem_cgroup *get_active_memcg(void)
-{
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
-	memcg = active_memcg();
-	/* remote memcg must hold a ref. */
-	if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
-	rcu_read_unlock();
-
-	return memcg;
-}
-
 static __always_inline bool memcg_kmem_bypass(void)
 {
 	/* Allow remote memcg charging from any context. */
@@ -6549,7 +6558,8 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
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
index 78ab81a62b29..7c09276125d5 100644
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

