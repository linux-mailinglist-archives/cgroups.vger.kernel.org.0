Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163655327D7
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiEXKgu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 06:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiEXKgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 06:36:49 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727EFD16
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 03:36:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v15so1799364pgk.11
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mv0h03Fi/OtxPp/Z+fPoItRmuRgY3cwaQPU9funRX9c=;
        b=XSkF/bmPvGekW75aBNlxtn4mVjVNuZkS8BypyCMs1G5idGF4Ty3XbFkec8vlHBZMaj
         zZwD2LVcBdYOOHEDFY9XAoWlv78XpR6SeHp/n21hGalRs7qtlO8pDMhAQzN6/Sm7kUfI
         aiBO9h/VWkiDCNG8a5iZDWtmuNe/raMvjMRrCW9B4u8ZWES3W7Fdd2QnMvwP02HDxhRl
         yR+gXercw+VgwdzFpA171XoYDBJ4URP3bB0ZcxwNifVs6zwanO703O+XCetzwpoBPHl5
         1sxVk7U579O7sNBv8XzyWH3IHvyjibFJeXc8o4euBduT94QIJ6oZN+m0+ssKCU/X9GmZ
         j1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mv0h03Fi/OtxPp/Z+fPoItRmuRgY3cwaQPU9funRX9c=;
        b=EfSYrsaZqp4dBwXgmwSL/9zpcReKGxrxBkfIHrNYORyWigEE+rOP/AR6xAUg7XqfxT
         1X02nvwhl6JLuU7VAOwhm3vecEaPIDpwMkFt8qFh5mJ6Oe1UgdiBZoLnfht/wzGSARfP
         AY6CSmmC4bktGIGZ3O1nbsHcWLLRWQ7+DeNOsvwiZaXNy4dsxzFjB9H0I8XmZkcibcNW
         zHIsY2eMMSSnN8gGHiwdXyBaOPO6ZqYeqCYeTrz/IJSGCIP+UYwidC4LMd10y3QQXP7V
         oXCvpmA6tTj6jeO4VEfrcOIZQNFzqFWuW9c+aCflGIScxMcbQiqgwnzeeYz1tD4jpAFN
         DdiA==
X-Gm-Message-State: AOAM530gu6oGh4rdwwNV2WlRP2CgalBJXqAHyS22I6M/urBVwypfQ1DD
        NPco07SW8F8fajjTKzD72o62qQ==
X-Google-Smtp-Source: ABdhPJzU0XpiMdHt9AZg3iIPm1ofoXx4H5Mz44HKUELtKJUbPAnWeRAYPyeFGF6qI+8tBZMmdL6dOA==
X-Received: by 2002:a63:fc08:0:b0:3f9:e159:b114 with SMTP id j8-20020a63fc08000000b003f9e159b114mr14550018pgi.526.1653388607832;
        Tue, 24 May 2022 03:36:47 -0700 (PDT)
Received: from R911R1VA-1UT.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b00161823de53csm6913010plh.282.2022.05.24.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 03:36:47 -0700 (PDT)
From:   hezhongkun <hezhongkun.hzk@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        Hezhongkun <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm: memcontrol: add the mempolicy interface for cgroup v2.
Date:   Tue, 24 May 2022 18:36:38 +0800
Message-Id: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hezhongkun <hezhongkun.hzk@bytedance.com>

Mempolicy is difficult to use because it is set in-process
via a system call. We want to make it easier to use mempolicy
in cgroups, so that we can control low-priority cgroups to
allocate memory in specified nodes. So this patch want to
adds the mempolicy interface.

the mempolicy priority of memcgroup is higher than the priority
of task. The order of getting the policy is,
memcgroup->policy,task->policy or vma policy, default policy.
memcgroup's policy is owned by itself, so descendants will
not inherit it.

Signed-off-by: Hezhongkun <hezhongkun.hzk@bytedance.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 42 ++++++++++++++++++++++++++++++++++++++
 mm/mempolicy.c             | 30 ++++++++++++++++++++++-----
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..2261eeb6100c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -343,6 +343,7 @@ struct mem_cgroup {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct deferred_split deferred_split_queue;
 #endif
+	struct mempolicy *mempolicy;
 
 	struct mem_cgroup_per_node *nodeinfo[];
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 598fece89e2b..38108fd4df64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6332,6 +6332,42 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+
+static int memory_policy_show(struct seq_file *m, void *v)
+{
+	char buffer[64];
+	struct mempolicy *mpol = mem_cgroup_from_seq(m)->mempolicy;
+
+	memset(buffer, 0, sizeof(buffer));
+
+	if (!mpol || mpol->mode == MPOL_DEFAULT)
+		return 0;
+
+	mpol_to_str(buffer, sizeof(buffer), mpol);
+	seq_printf(m, buffer);
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static ssize_t memory_policy_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	int err = 1;
+	struct mempolicy *mpol, *old;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	old = memcg->mempolicy;
+	buf = strstrip(buf);
+	err = mpol_parse_str(buf, &mpol);
+
+	if (err)
+		goto out;
+	mpol_put(old);
+	memcg->mempolicy = mpol;
+out:
+	return nbytes;
+}
+
 #endif
 
 static int memory_oom_group_show(struct seq_file *m, void *v)
@@ -6416,6 +6452,12 @@ static struct cftype memory_files[] = {
 		.name = "numa_stat",
 		.seq_show = memory_numa_stat_show,
 	},
+	{
+		.name = "policy",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_policy_show,
+		.write = memory_policy_write,
+	},
 #endif
 	{
 		.name = "oom.group",
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8c74107a2b15..5153b046f8c3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -176,6 +176,16 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 	return &default_policy;
 }
 
+struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
+{
+	struct mempolicy *pol;
+	struct mem_cgroup *memcg = mem_cgroup_from_task(p);
+
+	pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
+	return pol;
+}
+
+
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
 	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -1782,6 +1792,16 @@ static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	return pol;
 }
 
+static struct mempolicy *get_cgrp_or_vma_policy(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	struct mempolicy *pol;
+	struct mem_cgroup *memcg = mem_cgroup_from_task(current);
+
+	pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_vma_policy(vma, addr);
+	return pol;
+}
+
 bool vma_policy_mof(struct vm_area_struct *vma)
 {
 	struct mempolicy *pol;
@@ -1896,7 +1916,7 @@ unsigned int mempolicy_slab_node(void)
 	if (!in_task())
 		return node;
 
-	policy = current->mempolicy;
+	policy = get_cgrp_or_task_policy(current);
 	if (!policy)
 		return node;
 
@@ -2005,7 +2025,7 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 	int nid;
 	int mode;
 
-	*mpol = get_vma_policy(vma, addr);
+	*mpol = get_cgrp_or_vma_policy(vma, addr);
 	*nodemask = NULL;
 	mode = (*mpol)->mode;
 
@@ -2158,7 +2178,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	int preferred_nid;
 	nodemask_t *nmask;
 
-	pol = get_vma_policy(vma, addr);
+	pol = get_cgrp_or_vma_policy(vma, addr);
 
 	if (pol->mode == MPOL_INTERLEAVE) {
 		unsigned nid;
@@ -2257,7 +2277,7 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	struct page *page;
 
 	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
-		pol = get_task_policy(current);
+		pol = get_cgrp_or_task_policy(current);
 
 	/*
 	 * No reference counting needed for current->mempolicy
@@ -2562,7 +2582,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	int polnid = NUMA_NO_NODE;
 	int ret = NUMA_NO_NODE;
 
-	pol = get_vma_policy(vma, addr);
+	pol = get_cgrp_or_vma_policy(vma, addr);
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;
 
-- 
2.17.1

