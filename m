Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A33A3250
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJRl5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJRl4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 13:41:56 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FACFC061760;
        Thu, 10 Jun 2021 10:40:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i67so28172184qkc.4;
        Thu, 10 Jun 2021 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCRNE9exhy9WFifL3FriooCp94kazhT9QF+anNMPc+4=;
        b=dI1xhGmDysXuwpJBMly8vuj6ZM3geTPTQNJnlNbuNn1TvzYLVZIAlunDY8WjPNCQD0
         SHoNxvOLSL7p9GkdGgqn37dwEZ+LUV7qQUuI/uCl1LPgyZrPo//RN3ZqAwVDTugPnW7r
         CDx3JGc6pq8zDTyCYP76qQYlKn5lodwZUqJNFtsiyTTvQBYVU143jfaaf1/bV/jkpzsk
         AIO+v3rZMLkvxDe/ucUme7O1n5RT9S/eyFr1wILK09Hv+lwqlU2ztuUg/1BA05eJdkBP
         G3RHRZUrS73Ssw5Z+S9VQ8T7vYtRpxi0d7thnsFRl+4zJ6aSoo1RtUMsmr19OIpatJX2
         hdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCRNE9exhy9WFifL3FriooCp94kazhT9QF+anNMPc+4=;
        b=YTsKJ7C+z4OwPWxzRA7WttK2FJnMuxAeumRdAg0bupropCMmJ9MgxOJAVGdfapHmII
         4OhiNqRJmRpPawsUFYnIotZ8+wg9n0vTd0hHSBNAlhf+N/hVS/fnoDr7szQ+iPdh/4TZ
         9SJVUvBp3PuoJIZz1/yvrL+Wl0diNCJUsxrTmhzixzedObn0lbjeRHJaOu4rdaTjqIff
         mGdt0UqEiDl0HjfK8nZQoe8/hQymjGoskrZTgM4+qMIii/etm7fZ7vLD/f6a/lDvbTrV
         AmHdrCs/0Y1zSWuTHPk0eg5qmHacN7RRaGX0jI3SH3r/OuqInNWm7YbbYTI39zNLanfd
         7xoQ==
X-Gm-Message-State: AOAM5309WYCQ7W2yJdrTYtQSzpk7/jxsDbD5q3sSOup0ceAdipFWxUVY
        DqQv5x865SkxYAwULF2yYxr5YPchpnJOtQ==
X-Google-Smtp-Source: ABdhPJzFS+uzwQQDi9zLu+5+kiu1XvD6gyrC+7sETMR5NPRMnlEXNi5JljAeEI6pFSx88iJ07lbaCw==
X-Received: by 2002:a37:9a91:: with SMTP id c139mr657570qke.50.1623346799488;
        Thu, 10 Jun 2021 10:39:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be7a])
        by smtp.gmail.com with ESMTPSA id t8sm2542697qtp.7.2021.06.10.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:39:59 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Jens Axboe <axboe@kernel.dk>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH 2/3] mm: Charge active memcg when no mm is set
Date:   Thu, 10 Jun 2021 10:39:43 -0700
Message-Id: <20210610173944.1203706-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/filemap.c    |  2 +-
 mm/memcontrol.c | 41 +++++++++++++++++++++++++++--------------
 mm/shmem.c      |  4 ++--
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ba1068a1837f..bde9c167c056 100644
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
index 4e6c6658ca0d..919736ee656b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -902,13 +902,24 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
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
@@ -926,8 +937,17 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	 * counting is disabled on the root level in the
 	 * cgroup core. See CSS_NO_REF.
 	 */
-	if (unlikely(!mm))
-		return root_mem_cgroup;
+	if (unlikely(!mm)) {
+		memcg = active_memcg();
+		if (unlikely(memcg)) {
+			/* remote memcg must hold a ref */
+			css_get(&memcg->css);
+			return memcg;
+		}
+		mm = current->mm;
+		if (unlikely(!mm))
+			return root_mem_cgroup;
+	}
 
 	rcu_read_lock();
 	do {
@@ -940,14 +960,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
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
@@ -6716,7 +6728,8 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
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
index 34d84465ce3e..9af4b2173fe9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1695,7 +1695,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct swap_info_struct *si;
 	struct page *page = NULL;
 	swp_entry_t swap;
@@ -1828,7 +1828,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : current->mm;
+	charge_mm = vma ? vma->vm_mm : NULL;
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
-- 
2.30.2

