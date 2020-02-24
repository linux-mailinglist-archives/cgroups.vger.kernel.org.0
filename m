Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31A16B3B5
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2020 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgBXWSM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Feb 2020 17:18:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36088 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgBXWSM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Feb 2020 17:18:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id f3so7244250qkh.3;
        Mon, 24 Feb 2020 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCkGRqTJz70QV81Hpnays5VS0skwnz1lHvPTyvLahTQ=;
        b=LPtAbAQL+o6zGkxQYVl6oUm314BGitf+8dwHRfBTwvX2vCIWMWsdxtAx6cO5EURiDw
         hT86AELE/sWFsqn9UE2P89uSDbn1Pcd+L92hHaxnAInur0nmUwg1wBcQ495+4XM5EjC1
         tO9EoQDeJhaVKrF0wydjSdqi6PRYB+QUTgmBr899l6OOHs9b1EiWl6VS8He+h2WW/9G7
         tWhj3S5Fw0ZbWtgq6sa+QVDF1vnINI+i2RL1yrpk2XdzXISlUSDia42BCLI6PAhbCocY
         5S9Qq1UTq0TgT5HKK7tcjG32nutDmkHKGgw24VRqDVYre0dFT/dxZMP95KgmYJQxLARY
         5CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCkGRqTJz70QV81Hpnays5VS0skwnz1lHvPTyvLahTQ=;
        b=RfvgqaFvtaXsK80Z+Om2oUpYC6NwNY3dFPge0YEkTW8TaQ+t2530jtpHzyLetjHvPB
         2+IsNtW+6Ybc5c2Fnn4FMybqUsp12lD8bmSg07RGwGX8AC4XbWYF9Rs4RGTh4m/acuYm
         Jk6hwxcsYzKzZJZtBe9LLRJwMPc388rjpv7kKZkHzcGzno97rSGzp48HWyVPVL524M+G
         xzXyj+vdMNx7vap4MtMz/6rOszPqB6z5KWg8KwlMn9xnmJ6PhoVjFfNEVQIJY2JQ1ROK
         p7LXgxIoXZAHeMBStxQwzL5P5ifDgnUKxgxqp11esZISGrXOGAOxrFEw4wpwwk09PzVk
         /50w==
X-Gm-Message-State: APjAAAVqL8bALWaNpmeqKLcWetTsM6BhAkeVKXKk3tMzIbw7enGB6MRA
        GxB+VtdJn3hej5KJZetSGd0=
X-Google-Smtp-Source: APXvYqxWDwQIhlfPU7vYI8DHfzyLzFKyJd3oBZ1Xvj/9j0Xcen+L3F9yigwUtJlebcEkS8YmknFljQ==
X-Received: by 2002:a37:e0d:: with SMTP id 13mr36331326qko.145.1582582691321;
        Mon, 24 Feb 2020 14:18:11 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:500::2:b19b])
        by smtp.gmail.com with ESMTPSA id o17sm6648870qtj.80.2020.02.24.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:18:10 -0800 (PST)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
Date:   Mon, 24 Feb 2020 17:17:46 -0500
Message-Id: <4456276af198412b2d41cd09d246cd20e0c6d22a.1582581887.git.schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1582581887.git.schatzberg.dan@gmail.com>
References: <cover.1582581887.git.schatzberg.dan@gmail.com>
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
Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 mm/memcontrol.c | 11 ++++++++---
 mm/shmem.c      |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d09776cd6e10..222e4aac0c85 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6319,7 +6319,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
  * @compound: charge the page as compound or small page
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * pages according to @gfp_mask if necessary. If @mm is NULL, try to
+ * charge to the active memcg.
  *
  * Returns 0 on success, with *@memcgp pointing to the charged memcg.
  * Otherwise, an error code is returned.
@@ -6363,8 +6364,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		}
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
 
diff --git a/mm/shmem.c b/mm/shmem.c
index c8f7540ef048..8664c97851f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1631,7 +1631,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct mem_cgroup *memcg;
 	struct page *page;
 	swp_entry_t swap;
@@ -1766,7 +1766,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : current->mm;
+	charge_mm = vma ? vma->vm_mm : NULL;
 
 	page = find_lock_entry(mapping, index);
 	if (xa_is_value(page)) {
-- 
2.17.1

