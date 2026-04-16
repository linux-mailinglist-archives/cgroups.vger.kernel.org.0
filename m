Return-Path: <cgroups+bounces-15330-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCnyEUAs4WmQqAAAu9opvQ
	(envelope-from <cgroups+bounces-15330-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC766413C95
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6216530AE619
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDF33D6F8;
	Thu, 16 Apr 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3LbEPlp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F4339844;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364483; cv=none; b=uF5uBZIk6pnMAX6S0Rq/4k+B56Q/8ABJBvv1MHSwYZcbY/KKGAvlkbYC3ODKU5iOFZwbjuKbhHTUVeuI/qNpJEGR9MJ9BhTw6NDiDa3+DEjMgmjPVNJNSZr3/rUbEB5siwOF9FlS1pp2bhXGVdJpoHtdUoSKihKbiWDd3r+tLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364483; c=relaxed/simple;
	bh=UyUy5sknSy4UlieqVWanxeAKCUYZOMCiIgW+BtPl9xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5ae4zS6UonXGF+HUkMMEaKUn8BmKruop9Z/SDnUw/VX2QKC3xQ0kDRkr7R/Znt8j14KfDT81GN0govgBipiTRDyU6ps0/q2HCQuAKmzR0GSaKaDOgDSDpPfDK5SQrBBMyTpfHu4/+dBqRJ3r7aZNPHIZokWdO4X/HMOWlVJjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3LbEPlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BD0BC2BCB0;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364483;
	bh=UyUy5sknSy4UlieqVWanxeAKCUYZOMCiIgW+BtPl9xE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b3LbEPlpD4i28rVmdrH+AIqsvTs9DORoJTSnHjHC9NlilR1ovNsC4eMCUXrBc/uAQ
	 0yGdRw5IyHJMk9fhOy5gModnmn4lni7+70Or3hNdfLCzEo1aZ1ExjwMmnJWDEfztJb
	 /TjfxDNW/AlD+R6DXKHRRx3DA7WHi9FkwL1YEXMTH0qGu4C5nErC+GVRDhmclzYq68
	 jNSFFnMnxybOELO3MzgHqdHlfuHUoroIgH3+IHNoXRbSi+861Y3QjRHJLIfQQLMNpC
	 /GTs2sJmLg+kvNw+VUNzrfubvfx0mvjq0dALdZv1nkRPPN3eQ/+zd0pu+s19ZYDn5c
	 5wQiHFmm76LWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA0F8D755;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 17 Apr 2026 02:34:38 +0800
Subject: [PATCH v2 08/11] mm/swap: delay and unify memcg lookup and
 charging for swapin
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-swap-table-p4-v2-8-17f5d1015428@tencent.com>
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
In-Reply-To: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776364480; l=7647;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=MaPZt4DakdEFcAuU7VMbnT8dk7oBx3itn1gaO3e2CGw=;
 b=bhDnUB5C89/wmrDy04bf6K7rURpehnUIZLRzfTCPaUkBQIn08ezpUPelyzuE/ynTJRE+6VGOB
 ma1S0NAIT9CA3vRQN2vO+02EdMCcpMkmbTRhK5RDgo82mxzJHJebs6x
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15330-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,tencent.com,arm.com,suse.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:replyto,tencent.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC766413C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

Instead of checking the cgroup private ID during page table walk in
swap_pte_batch(), move the memcg lookup into __swap_cache_add_check()
under the cluster lock.

The first speculative check skips the memcg check since the post alloc
stable check ensures all folios are in the same memcg. The chance that
all contiguous entries got installed to a contiguous range of page
table or shmem mapping, while belonging to different memcg seems a very
rare thing.

This also prepares for recording the memcg info in the cluster's
table. Also make the order check and fallback more compact.

There should be no user observable behavior change.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h |  6 +++---
 mm/internal.h              |  4 ----
 mm/memcontrol.c            | 10 ++++------
 mm/swap_state.c            | 28 +++++++++++++++++++---------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7d08128de1fd..a013f37f24aa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -646,8 +646,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 
 int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 
-int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
-				  gfp_t gfp, swp_entry_t entry);
+int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned short id,
+				   struct mm_struct *mm, gfp_t gfp);
 
 void __mem_cgroup_uncharge(struct folio *folio);
 
@@ -1137,7 +1137,7 @@ static inline int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp)
 }
 
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
-			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
+		 unsigned short id, struct mm_struct *mm, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/mm/internal.h b/mm/internal.h
index d009d51e522b..32de9f3a9fa0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -453,12 +453,10 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 	const pte_t *end_ptep = start_ptep + max_nr;
 	const softleaf_t entry = softleaf_from_pte(pte);
 	pte_t *ptep = start_ptep + 1;
-	unsigned short cgroup_id;
 
 	VM_WARN_ON(max_nr < 1);
 	VM_WARN_ON(!softleaf_is_swap(entry));
 
-	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
 		softleaf_t entry;
 
@@ -467,8 +465,6 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 		if (!pte_same(pte, expected_pte))
 			break;
 		entry = softleaf_from_pte(pte);
-		if (lookup_swap_cgroup_id(entry) != cgroup_id)
-			break;
 		expected_pte = pte_next_swp_offset(expected_pte);
 		ptep++;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c7df30ca5aa7..641706fa47bf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5062,27 +5062,25 @@ int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
 
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
- * @folio: folio to charge.
+ * @folio: the folio to charge
+ * @id: memory cgroup id
  * @mm: mm context of the victim
  * @gfp: reclaim mode
- * @entry: swap entry for which the folio is allocated
  *
  * This function charges a folio allocated for swapin. Please call this before
  * adding the folio to the swapcache.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
-				  gfp_t gfp, swp_entry_t entry)
+int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned short id,
+				   struct mm_struct *mm, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
-	unsigned short id;
 	int ret;
 
 	if (mem_cgroup_disabled())
 		return 0;
 
-	id = lookup_swap_cgroup_id(entry);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_private_id(id);
 	if (!memcg || !css_tryget_online(&memcg->css))
diff --git a/mm/swap_state.c b/mm/swap_state.c
index af50e6a21850..4c1cb0b1c0c5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -142,16 +142,20 @@ void *swap_cache_get_shadow(swp_entry_t entry)
  * @ci: The locked swap cluster
  * @targ_entry: The target swap entry to check, will be rounded down by @nr
  * @nr: Number of slots to check, must be a power of 2
- * @shadowp: Returns the shadow value if one exists in the range.
+ * @shadowp: Returns the shadow value if one exists in the range
+ * @memcg_id: Returns the memory cgroup id, NULL to ignore cgroup check
  *
  * Check if all slots covered by given range have a swap count >= 1.
- * Retrieves the shadow if there is one.
+ * Retrieves the shadow if there is one. If @memcg_id is not NULL, also
+ * checks if all slots belong to the same cgroup and return the cgroup
+ * private id.
  *
  * Context: Caller must lock the cluster.
  */
 static int __swap_cache_add_check(struct swap_cluster_info *ci,
 				  swp_entry_t targ_entry,
-				  unsigned long nr, void **shadowp)
+				  unsigned long nr, void **shadowp,
+				  unsigned short *memcg_id)
 {
 	unsigned int ci_off, ci_end;
 	unsigned long old_tb;
@@ -169,19 +173,24 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 		return -EEXIST;
 	if (!__swp_tb_get_count(old_tb))
 		return -ENOENT;
-	if (swp_tb_is_shadow(old_tb) && shadowp)
+	if (shadowp && swp_tb_is_shadow(old_tb))
 		*shadowp = swp_tb_to_shadow(old_tb);
+	if (memcg_id)
+		*memcg_id = lookup_swap_cgroup_id(targ_entry);
 
 	if (nr == 1)
 		return 0;
 
+	targ_entry.val = round_down(targ_entry.val, nr);
 	ci_off = round_down(ci_off, nr);
 	ci_end = ci_off + nr;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		if (unlikely(swp_tb_is_folio(old_tb) ||
-			     !__swp_tb_get_count(old_tb)))
+			     !__swp_tb_get_count(old_tb) ||
+			     (memcg_id && *memcg_id != lookup_swap_cgroup_id(targ_entry))))
 			return -EBUSY;
+		targ_entry.val++;
 	} while (++ci_off < ci_end);
 
 	return 0;
@@ -397,6 +406,7 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	swp_entry_t entry;
 	struct folio *folio;
 	void *shadow = NULL;
+	unsigned short memcg_id;
 	unsigned long address, nr_pages = 1 << order;
 	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 
@@ -404,7 +414,7 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 
 	/* Check if the slot and range are available, skip allocation if not */
 	spin_lock(&ci->lock);
-	err = __swap_cache_add_check(ci, targ_entry, nr_pages, NULL);
+	err = __swap_cache_add_check(ci, targ_entry, nr_pages, NULL, NULL);
 	spin_unlock(&ci->lock);
 	if (unlikely(err))
 		return ERR_PTR(err);
@@ -430,7 +440,7 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 
 	/* Double check the range is still not in conflict */
 	spin_lock(&ci->lock);
-	err = __swap_cache_add_check(ci, targ_entry, nr_pages, &shadow);
+	err = __swap_cache_add_check(ci, targ_entry, nr_pages, &shadow, &memcg_id);
 	if (unlikely(err)) {
 		spin_unlock(&ci->lock);
 		folio_put(folio);
@@ -442,8 +452,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	__swap_cache_do_add_folio(ci, folio, entry);
 	spin_unlock(&ci->lock);
 
-	if (mem_cgroup_swapin_charge_folio(folio, vmf ? vmf->vma->vm_mm : NULL,
-					   gfp, entry)) {
+	if (mem_cgroup_swapin_charge_folio(folio, memcg_id,
+					   vmf ? vmf->vma->vm_mm : NULL, gfp)) {
 		spin_lock(&ci->lock);
 		__swap_cache_do_del_folio(ci, folio, entry, NULL);
 		spin_unlock(&ci->lock);

-- 
2.53.0



