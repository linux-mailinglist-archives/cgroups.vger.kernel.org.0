Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0708257D88
	for <lists+cgroups@lfdr.de>; Mon, 31 Aug 2020 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgHaPhh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Aug 2020 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgHaPhb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Aug 2020 11:37:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1573C061573;
        Mon, 31 Aug 2020 08:37:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b13so2696945qvl.2;
        Mon, 31 Aug 2020 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFNO1srh3AW4C+hy+7CfuD56Hs7de0B4v+mt5P6Q+8c=;
        b=SjePWpDm/dcOfaWyG090sIQ82qRogNC8U9o/SXOsilJibfKn37U7NrP6cYs9z13ajn
         3ahnbXMI1dfgdzV1jsX4P8YPuyM1wY2QGXQiesxpHGGEg3Z23HYwzkk62guOns9HMJyO
         mv5bVZQTbHPtdEJ+eNlOenVGaVNmy48r50T0qx1KJrkByftLK+OzvzENGehdjQZ0EdVJ
         SbKPXAl9lN5Bz1sTMxYIYgFWi6dPAG2dwLhw1nXA9usckN3AXJXudsT9uUJdRuIs/Ntq
         5nv1yGY0UIXNQDK7x6fl3OY/BjqkvDLJzoM8kbzBSnvSW8Q8tEl7Yp4cPcUq9xxnCReP
         1UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFNO1srh3AW4C+hy+7CfuD56Hs7de0B4v+mt5P6Q+8c=;
        b=lci5gG1UJ8ZSjJmCZcWM7oDaTTsxTfycHF6vfNutBUvyVNaW0eoMO6EdQQfGBk/6RQ
         twPIBCxfswZIIfqE97nftkvudGeWcLD+0Uz11M8zx/0An+2QOY4MeOiMwqlDA5kSNWX7
         Hgm8Hp4ISgdrHdcLhZANIouiXjEA4o22NOo/dCnJ/6u4hR3qJtkAYmQg0fAQB/lY6Knr
         2DoNUXCrDEAX2Do0Kd7GmpfCR5QTeGbqt2Ar6tQ+iisJCgI8q8piJAXu4ng6FOEEkMHO
         lQpbudNpY1BPbe9bp7DPOi0INxUb9hJ5tpjFfycSO2zPWJmTYXG/snqXtk1ObJzKrheD
         4dqQ==
X-Gm-Message-State: AOAM532zn0KPP4GQKNxH4qwz9bhJPgvQyJkTRUhth/cjdZnrVyZyNXup
        MAltodrlT5ORrw17BTMW0qo=
X-Google-Smtp-Source: ABdhPJxZrAVMLKA6PaN3RQHI9DyNFWZHOVofg01sLYGajv8EisNnh3wB37+tmq28zRDNQhabk9LCkg==
X-Received: by 2002:ad4:430d:: with SMTP id c13mr1642259qvs.49.1598888249829;
        Mon, 31 Aug 2020 08:37:29 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:2edc])
        by smtp.gmail.com with ESMTPSA id s5sm9908872qke.120.2020.08.31.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 08:37:29 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Shakeel Butt <shakeelb@google.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 2/3] mm: Charge active memcg when no mm is set
Date:   Mon, 31 Aug 2020 11:36:59 -0400
Message-Id: <20200831153704.16848-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200831153704.16848-1-schatzberg.dan@gmail.com>
References: <20200831153704.16848-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

memalloc_use_memcg() worked for kernel allocations but was silently
ignored for user pages.

This patch establishes a precedence order for who gets charged:

1. If there is a memcg associated with the page already, that memcg is
   charged. This happens during swapin.

2. If an explicit mm is passed, mm->memcg is charged. This happens
   during page faults, which can be triggered in remote VMs (eg gup).

3. Otherwise consult the current process context. If it has configured
   a current->active_memcg, use that. Otherwise, current->mm->memcg.

Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
would always charge the root cgroup. Now it looks up the current
active_memcg first (falling back to charging the root cgroup if not
set).

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 11 ++++++++---
 mm/shmem.c      |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e27ac6d79a32..877778b792da 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6676,7 +6676,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
  * @gfp_mask: reclaim mode
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * charge to the active memcg.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
@@ -6712,8 +6713,12 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 		rcu_read_unlock();
 	}
 
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(mm);
+	if (!memcg) {
+		if (!mm)
+			memcg = get_mem_cgroup_from_current();
+		else
+			memcg = get_mem_cgroup_from_mm(mm);
+	}
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
 	if (ret)
diff --git a/mm/shmem.c b/mm/shmem.c
index 271548ca20f3..1139f52ac4ee 100644
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
@@ -1809,7 +1809,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : current->mm;
+	charge_mm = vma ? vma->vm_mm : NULL;
 
 	page = find_lock_entry(mapping, index);
 	if (xa_is_value(page)) {
-- 
2.24.1

