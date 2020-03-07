Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5817CCBE
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2020 09:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgCGIAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Mar 2020 03:00:13 -0500
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:39228 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgCGIAN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Mar 2020 03:00:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AB493182CED34;
        Sat,  7 Mar 2020 08:00:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4117:4321:4605:5007:6117:9025:9036:9592:10004:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12679:12760:12986:13439:13845:14096:14097:14394:14659:14877:21080:21433:21451:21627:21811:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thing31_16ce6d4a5145
X-Filterd-Recvd-Size: 6434
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Mar 2020 08:00:09 +0000 (UTC)
Message-ID: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
Subject: [PATCH] mm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Date:   Fri, 06 Mar 2020 23:58:33 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert the various /* fallthrough */ comments to the
pseudo-keyword fallthrough;

Done via script:
https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

Signed-off-by: Joe Perches <joe@perches.com>
---

Might as well start with fallthrough conversions somewhere...

 mm/gup.c            | 2 +-
 mm/hugetlb_cgroup.c | 6 +++---
 mm/ksm.c            | 3 +--
 mm/list_lru.c       | 2 +-
 mm/memcontrol.c     | 2 +-
 mm/mempolicy.c      | 3 ---
 mm/mmap.c           | 5 ++---
 mm/shmem.c          | 2 +-
 mm/zsmalloc.c       | 2 +-
 9 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f58929..4bfd753 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1072,7 +1072,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 				goto retry;
 			case -EBUSY:
 				ret = 0;
-				/* FALLTHRU */
+				fallthrough;
 			case -EFAULT:
 			case -ENOMEM:
 			case -EHWPOISON:
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 790f63..7994eb8 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -468,14 +468,14 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_RSVD_USAGE:
 		counter = &h_cg->rsvd_hugepage[idx];
-		/* Fall through. */
+		fallthrough;
 	case RES_USAGE:
 		val = (u64)page_counter_read(counter);
 		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
 	case RES_RSVD_LIMIT:
 		counter = &h_cg->rsvd_hugepage[idx];
-		/* Fall through. */
+		fallthrough;
 	case RES_LIMIT:
 		val = (u64)counter->max;
 		if (val == limit)
@@ -515,7 +515,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_RSVD_LIMIT:
 		rsvd = true;
-		/* Fall through. */
+		fallthrough;
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
 		ret = page_counter_set_max(
diff --git a/mm/ksm.c b/mm/ksm.c
index 363ec8..a558da9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2813,8 +2813,7 @@ static int ksm_memory_callback(struct notifier_block *self,
 		 */
 		ksm_check_stable_tree(mn->start_pfn,
 				      mn->start_pfn + mn->nr_pages);
-		/* fallthrough */
-
+		fallthrough;
 	case MEM_CANCEL_OFFLINE:
 		mutex_lock(&ksm_thread_mutex);
 		ksm_run &= ~KSM_RUN_OFFLINE;
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 9e4a28..87b540f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -223,7 +223,7 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
 		switch (ret) {
 		case LRU_REMOVED_RETRY:
 			assert_spin_locked(&nlru->lock);
-			/* fall through */
+			fallthrough;
 		case LRU_REMOVED:
 			isolated++;
 			nlru->nr_items--;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1e1260..dfe191 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5756,7 +5756,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		switch (get_mctgt_type(vma, addr, ptent, &target)) {
 		case MC_TARGET_DEVICE:
 			device = true;
-			/* fall through */
+			fallthrough;
 		case MC_TARGET_PAGE:
 			page = target.page;
 			/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6d30379..45eb0a5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -907,7 +907,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 
 	switch (p->mode) {
 	case MPOL_BIND:
-		/* Fall through */
 	case MPOL_INTERLEAVE:
 		*nodes = p->v.nodes;
 		break;
@@ -2092,7 +2091,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 		break;
 
 	case MPOL_BIND:
-		/* Fall through */
 	case MPOL_INTERLEAVE:
 		*mask =  mempolicy->v.nodes;
 		break;
@@ -2359,7 +2357,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 
 	switch (a->mode) {
 	case MPOL_BIND:
-		/* Fall through */
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
diff --git a/mm/mmap.c b/mm/mmap.c
index f8ea04..60dc38 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1457,7 +1457,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			 * with MAP_SHARED to preserve backward compatibility.
 			 */
 			flags &= LEGACY_MAP_MASK;
-			/* fall through */
+			fallthrough;
 		case MAP_SHARED_VALIDATE:
 			if (flags & ~flags_mask)
 				return -EOPNOTSUPP;
@@ -1480,8 +1480,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
-
-			/* fall through */
+			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
 				return -EACCES;
diff --git a/mm/shmem.c b/mm/shmem.c
index d01d5b..1e9b377 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3992,7 +3992,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 			if (i_size >= HPAGE_PMD_SIZE &&
 					i_size >> PAGE_SHIFT >= off)
 				return true;
-			/* fall through */
+			fallthrough;
 		case SHMEM_HUGE_ADVISE:
 			/* TODO: implement fadvise() hints */
 			return (vma->vm_flags & VM_HUGEPAGE);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2aa2d5..2f836a2b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -424,7 +424,7 @@ static void *zs_zpool_map(void *pool, unsigned long handle,
 	case ZPOOL_MM_WO:
 		zs_mm = ZS_MM_WO;
 		break;
-	case ZPOOL_MM_RW: /* fall through */
+	case ZPOOL_MM_RW:
 	default:
 		zs_mm = ZS_MM_RW;
 		break;


