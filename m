Return-Path: <cgroups+bounces-14034-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFX4ISWgl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14034-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 269021639E9
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C7B3061E0F
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B289331209;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdqwLoRA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715932D7FF;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544528; cv=none; b=M/yq4GcI5KL/jlwQyrdDgEshusvaVE1CcChsHEQ6AWVLrXO4nx1hNAwM9Vj1c5rWsZzmQb2gwsWatOJ39NN6VsN61+dmPC34bR3/4B8MIUoDXtUr0ctdTRhK/Oq5/1pWlYaORSOOsU4poQVRFKzhY5WQBlYcLSWGMN1svGjRSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544528; c=relaxed/simple;
	bh=XphCFHReTLerRTmQ62E7k3tj+ws8vNIKhOrrRBsM1to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fp7V+KPb03M3dO6DJ/NhbMz4EU8gKddmkrojwZJiYGtoqTK3F7vV8c9Ffe78qw4UTouig7oWoI0SaNS4zIwxFtX0PuD24aGoW0tN0eys5zRGO4cR7DWjv0FD4SgUcMr1DGlPw3Lntn13M4lZr3Yp2WhAU+drvDTvksYEQCsUXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdqwLoRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE002C2BCAF;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544528;
	bh=XphCFHReTLerRTmQ62E7k3tj+ws8vNIKhOrrRBsM1to=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mdqwLoRAkSEFaKH5nJYW4cVLC+sLaPjgd7tmmPIXVPooYnwsbygV1gv6tomQodj9N
	 jO714FjHDyMkiCkBQZLpEz0D809nXyLNDbtNZUhd99XA587oEMu1OIZ7IWBztDpWjg
	 7l/OUQxVr2UVAbaoj7nEvQawvxGJwkt/M6Y6LYN/g1Kn0FIAeGlToAdnsjp6f/q7L+
	 Ug+CD9rx2u9idWo3v3o4hSIvx+3K4cYtqKbTkXdc7c4h5USVZI77vlNDo/v5kKlAX6
	 utsmjLEUdr9zGPsEx7K/dj+dbgOBaY5lsR31hO2mcoJqN4vhs48c+BkHmHsgiZqRzu
	 yqm7kL5/WB+ig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568BC531EB;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:11 +0800
Subject: [PATCH RFC 10/15] mm, swap: always retrieve memcg id from swap
 table
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-10-104795d19815@tencent.com>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
In-Reply-To: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=4319;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=WsZXml04ASUgTsoFPs4VOCkE3+G9dotFosGt0KDSdnI=;
 b=8PUGQy+iLDj47T0eAJnEPkBbFEpbjpdotOGd9HFhFodXjiH7rSlOJhvBygk9dElK56junzS5k
 sewBlHU75avAo5d1frQoohXdWvj9c85coOf+rZoeyzNWabyjMYaOOeT
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14034-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com]
X-Rspamd-Queue-Id: 269021639E9
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Transition mem_cgroup_swapin_charge_folio() to receive the memcg id
from the caller via the swap table shadow entry, demoting the old
swap cgroup array lookup to a sanity check. Also removes the per-PTE
cgroup id batching break from swap_pte_batch() since now swap is able to
free slots across mem cgroups.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h | 6 ++++--
 mm/internal.h              | 4 ----
 mm/memcontrol.c            | 9 ++++++---
 mm/swap_state.c            | 5 ++++-
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0b37d4faf785..8fc794baf736 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -667,7 +667,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
-				  gfp_t gfp, swp_entry_t entry);
+				   gfp_t gfp, swp_entry_t entry,
+				   unsigned short id);
 
 void __mem_cgroup_uncharge(struct folio *folio);
 
@@ -1145,7 +1146,8 @@ static inline int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp)
 }
 
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
-			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
+			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry,
+			unsigned short id)
 {
 	return 0;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 5bbe081c9048..416d3401aa17 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -452,12 +452,10 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 	const pte_t *end_ptep = start_ptep + max_nr;
 	const softleaf_t entry = softleaf_from_pte(pte);
 	pte_t *ptep = start_ptep + 1;
-	unsigned short cgroup_id;
 
 	VM_WARN_ON(max_nr < 1);
 	VM_WARN_ON(!softleaf_is_swap(entry));
 
-	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
 		softleaf_t entry;
 
@@ -466,8 +464,6 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 		if (!pte_same(pte, expected_pte))
 			break;
 		entry = softleaf_from_pte(pte);
-		if (lookup_swap_cgroup_id(entry) != cgroup_id)
-			break;
 		expected_pte = pte_next_swp_offset(expected_pte);
 		ptep++;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d9ff44b77409..d0f50019d733 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4794,6 +4794,7 @@ int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
  * @mm: mm context of the victim
  * @gfp: reclaim mode
  * @entry: swap entry for which the folio is allocated
+ * @id: the mem cgroup id
  *
  * This function charges a folio allocated for swapin. Please call this before
  * adding the folio to the swapcache.
@@ -4801,19 +4802,21 @@ int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
  * Returns 0 on success. Otherwise, an error code is returned.
  */
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
-				  gfp_t gfp, swp_entry_t entry)
+				   gfp_t gfp, swp_entry_t entry, unsigned short id)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
+	unsigned short memcg_id;
 	unsigned int nr_pages;
-	unsigned short id;
 	int ret;
 
 	if (mem_cgroup_disabled())
 		return 0;
 
-	id = lookup_swap_cgroup_id(entry);
+	memcg_id = lookup_swap_cgroup_id(entry);
 	nr_pages = folio_nr_pages(folio);
 
+	WARN_ON_ONCE(id != memcg_id);
+
 	rcu_read_lock();
 	swap_memcg = mem_cgroup_from_private_id(id);
 	if (!swap_memcg) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cc4bf40320ef..5ab3a41fe42c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -251,8 +251,11 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	__swap_cache_add_folio(ci, folio, entry);
 	spin_unlock(&ci->lock);
 
+	/* With swap table, we must have a shadow, for memcg tracking */
+	WARN_ON(!shadow);
+
 	if (mem_cgroup_swapin_charge_folio(folio, vmf ? vmf->vma->vm_mm : NULL,
-					   gfp, entry)) {
+					   gfp, entry, shadow_to_memcgid(shadow))) {
 		spin_lock(&ci->lock);
 		__swap_cache_del_folio(ci, folio, shadow, false, false);
 		spin_unlock(&ci->lock);

-- 
2.53.0



