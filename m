Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36233D7BF
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhCPPhg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCPPh0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 11:37:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140CC06174A;
        Tue, 16 Mar 2021 08:37:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n79so35644124qke.3;
        Tue, 16 Mar 2021 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Io4/SuSrOnO2lgbZBjKm6Sy30ngmcZaMUy5F+H9fpyg=;
        b=litRM2T0M677dAg8+HS9+0ucinGZ/dprpSboNx4ygkFJPc0HA7LeXLHFrv7Q9m7k79
         aUxF39PH+bvWZtQ0icKUCN/4ShHLXO2+bh72cKKbvhbVjEJDHIL0WCz61My8fhcto88B
         QvLWU0tlpdH7qaNFpUHjdjkJ7Asl4Hi0b3cRIqZ93FsHXczVR7keUqqqpiMBaIlsoJ5m
         HokRsWiOoqXWTO98zQWkfe4xQC3jTTfs0+bMx0aKRlA47CnKyFscvmsBxs3Z7jKLx+jd
         1HGoBPab+GGGBMBfNjofRaLQVJrgvBq2KfmpJBH1thj4ZTg7KHcg32MgwI4IJ2rSfJh/
         2noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io4/SuSrOnO2lgbZBjKm6Sy30ngmcZaMUy5F+H9fpyg=;
        b=UGpG9V4OnQC+ojYGwVpuuE57tDN/CJKaCIyFF9O5E6jFskJE8KnHz1twipyETK08A0
         VZiIg7amJv6ritRSKUSsDFts/HLgifNK44sfP/vNMY0kONsyPIfX7IAL2iReHum5fGrI
         nNmVYRzE5Kw6V9RZTAJBOxFKYcrCvuj3OBnzrBu+PpBbXhEbNfLHUM+AFLaVgtiOcfnG
         Ycft2T7EuoP738a7+2Hjoe58Yv7ble8tF9wUAbVoMYGzbN68dyJeqDuv5Kta3FekUJxE
         0qPNLqsOMjcLleF1x4Nm0882MdOdT2IWC4IXIRtUlxkXLNdQs8KThnwqqeOH2gBIKjCw
         T/sg==
X-Gm-Message-State: AOAM531iz5DI4/pTA5rmh9Epbu+vzvtLqtzXqZnirlKUMlq5C5GbcmL5
        yd7b7mb+i4SRx3E9/pnBMII=
X-Google-Smtp-Source: ABdhPJzLhmIigbpwLFc93Ups8jNMalmervLIp/mKz6S4aNI/h1o+8g1FB8LgzYpx7UXu9v1tS7X0QA==
X-Received: by 2002:a37:6ca:: with SMTP id 193mr125522qkg.405.1615909045580;
        Tue, 16 Mar 2021 08:37:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1ee])
        by smtp.gmail.com with ESMTPSA id k24sm13719703qtu.35.2021.03.16.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:37:25 -0700 (PDT)
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
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH 2/3] mm: Charge active memcg when no mm is set
Date:   Tue, 16 Mar 2021 08:36:51 -0700
Message-Id: <20210316153655.500806-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316153655.500806-1-schatzberg.dan@gmail.com>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
 mm/filemap.c    |  2 +-
 mm/memcontrol.c | 14 +++++++++++---
 mm/shmem.c      |  4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 43700480d897..5135f330f05c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -843,7 +843,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	page->index = offset;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page, current->mm, gfp);
+		error = mem_cgroup_charge(page, NULL, gfp);
 		if (error)
 			goto error;
 		charged = true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d850a..9a1b23ed3412 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6690,7 +6690,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
  * @gfp_mask: reclaim mode
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * charge to the active memcg.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
@@ -6726,8 +6727,15 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 		rcu_read_unlock();
 	}
 
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(mm);
+	if (!memcg) {
+		if (!mm) {
+			memcg = get_mem_cgroup_from_current();
+			if (!memcg)
+				memcg = get_mem_cgroup_from_mm(current->mm);
+		} else {
+			memcg = get_mem_cgroup_from_mm(mm);
+		}
+	}
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
 	if (ret)
diff --git a/mm/shmem.c b/mm/shmem.c
index b2db4ed0fbc7..353b362c370e 100644
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

