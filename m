Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3C39A3C9
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFCO7e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhFCO7e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 10:59:34 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E84C06174A;
        Thu,  3 Jun 2021 07:57:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g17so4532695qtk.9;
        Thu, 03 Jun 2021 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VS+AJIREtfm1DlPcOn40z4ON87bSHZWbgG5Synn7ZO8=;
        b=iqVXOUWgNzwFwPHNnw49sUum1PihyLT+VlXKBaoLQVjZNTXlL77kj1c5hbxB2Ufp/N
         GVmpehFau9dW4saGmdfHwOc/FGW5w3MSGilMwRfcbBzrB16nJZpr31NieB8BUlm2Qc9m
         +7kyP0wQtsnHb03EH94bmx/SFEb8TJaPSJDKw2SSKBAgaNdtHvd3LMFnOFZzdP48cAiH
         JWcqN8MYDf1CjzNJZ5q0q3b8P4C2egE3Yy3n0N9wZqizYpUyqy4DuZlNyeprOeKRrwFs
         ZxtKeWlqXeKIWrBQ+rjB0CmEVPtdpGpql25Ur5NBNUVQTV8KBBmSkMTDWLxXXRDMAy+0
         O1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VS+AJIREtfm1DlPcOn40z4ON87bSHZWbgG5Synn7ZO8=;
        b=YzfECg8TGLKGYgJMM85Ly+9NbvOb8YNjseZ4OEoC2DBAwSbbipeQ2IEtAaMqvR2EMo
         ojSEx0M2J8b+hdOnaDR23BjERiVvPJ+nKMqm8EyCMsqeeMe/AYgu2xzq52CzBN9P2AIG
         2CsqN54+8Djwjr3/VFl+45srOHXeLatY0GU2i8uOhwiFQtiLTxZRY8gmql8LUAZ8ih24
         TTd/RjngeiDo/+rvXsQ6b2OBbjmwQC0czejdeMJSyviNiZ0NNtMAXGmnQ2zZFz/kEOWk
         it2rp4FXsMx5x3pgFPPr25xJlH6RXbWteCGqSjwpDo+dyRV/eMQNXy/dSz+kBbgIdBZM
         aJoQ==
X-Gm-Message-State: AOAM532ZNT4TefHFvmY2magvKW2QqAUnY0+5UQEORE2J7G/kxHX5kca1
        MBwz5fmYlmokzLcI/0Zi9+9f8uBvUeVVGg==
X-Google-Smtp-Source: ABdhPJwyDhFJ1ML31Q77HmPbsCFBze3Wz4jAme3SKplFkaqQaGf05FO+JDf3Vg0NJJx0oyEsVAboRg==
X-Received: by 2002:ac8:594a:: with SMTP id 10mr255630qtz.293.1622732254896;
        Thu, 03 Jun 2021 07:57:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8008])
        by smtp.gmail.com with ESMTPSA id t19sm1581541qkp.2.2021.06.03.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:57:34 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH 2/3] mm: Charge active memcg when no mm is set
Date:   Thu,  3 Jun 2021 07:57:06 -0700
Message-Id: <20210603145707.4031641-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603145707.4031641-1-schatzberg.dan@gmail.com>
References: <20210603145707.4031641-1-schatzberg.dan@gmail.com>
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
 mm/memcontrol.c | 48 +++++++++++++++++++++++++++++++-----------------
 mm/shmem.c      |  4 ++--
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..ac82a93d4f38 100644
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
index 64ada9e650a5..26dc2dc0056a 100644
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
@@ -6541,7 +6554,8 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
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
index 5d46611cba8d..2e7af1725ff6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1695,7 +1695,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct page *page;
 	swp_entry_t swap;
 	int error;
@@ -1816,7 +1816,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : current->mm;
+	charge_mm = vma ? vma->vm_mm : NULL;
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
-- 
2.30.2

