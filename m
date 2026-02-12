Return-Path: <cgroups+bounces-13874-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFQ6AQAhjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13874-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:38:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBAB128AF7
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88BB930413C5
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9D221DB9;
	Thu, 12 Feb 2026 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5t2Oeb0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2D21B9C9
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856659; cv=none; b=M8Dc1A3NU1BzROrVtFf5QQBhkXWOiMOCnNF2dDU85DR15AGXnvlT2NteKIYDw2njkTiKoHfGaYaG7jGA8i0sCtzZDabPDYT+RZYL5vXe7XljZEh1hXoSd/nxJW/2dehhXHkGcCP78gngM03XgQ0faBxOg9d3S9b3tcb9+rwoySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856659; c=relaxed/simple;
	bh=EwNfUsWZF1vGarE+OLV6nbe8sQt1PL8TvcUOE7m4PpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9lDB2jgqNmmj3Ahaup1wUOoBnaiUGBkFYgHwaob750FToTGBgb6jV+ArkRx6pRs5hsQ89jAqvqX3MxS6Ksi81kF/WrV22Y/WYkBfkUSPCLSZi0nJU0viDvq4hr0J5g/ZRj77cJd0OIizsmkp/rsBHEpm2iDJpJDnNUEclSkMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5t2Oeb0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7d7b87977so29974275ad.0
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856657; x=1771461457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mW1n+uSYA6jLOEsvKLlQWfWVUyuDqSU/loYnlj1zbjs=;
        b=k5t2Oeb0fweDj+TO75fIWcU2fwhjgzi5B2WSRoMz0yE2aAHR+zg5O6gVjU4SnJRFVA
         qn5PxHwyGKbSUpDvLrOFwFPzciUvG/EpIXNdrlsc41gF0As2E3lSL3/kM0NgTreHPIZX
         a200gntpy5yqIQIu4B+fHJI7jL8VAzphOGG3v92usfuzDjgkZ4tZDPfNH8b0UDJ4EOnC
         BGxSz/CDlNjfsmg4gzfx71ZZBx88NhZFPXRLLfDtvwBvv+hgyE6+uBqbYGO28iRtFt1Y
         CtWbpGLZckdJwplkgxurro6XQawart2jR3V4HMvZGdbCJFdOVCQW5U/pfxI96r5+ZTK6
         Y0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856657; x=1771461457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW1n+uSYA6jLOEsvKLlQWfWVUyuDqSU/loYnlj1zbjs=;
        b=twiJ58/oySMmKvQ8OdvAiS1Wu95kwwGuOoDY+EEVkzEmUpH32+6xk7UDh1xL5GakFt
         AnGKoCeogGtgjQDnCkQiyYCleAgUFqmjfhc1VPO3tulrQvKwz6Srgw9CvVorKuOcpSJ4
         MJE93yx0rf7Gkzw7XrwjXjTPVCBX8Oskj2MdQMXibI8CzOBUYehMGvZ2VheH8XrvboHf
         aYlm7fviq2gS5X41D49C3qKy0K/sTvtHLxoFzmny1qZQqdyQx5duzl5oM5zmb/OeDF30
         +oVeyoJbuiPfqdQ6l+xp/rpPS+LOH7mIozIJgisGqtTYoRN6ozUa/WjbThk641hF6/T8
         Eanw==
X-Forwarded-Encrypted: i=1; AJvYcCWKykRAfuqhclDOWyiDueKyDvQ4oSOIYfBFvCS9xhf7cZ6wckicZ3HAUqYquAn+OrGRQ1Kd0iEZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zQuCYNjSuTnNzvpSgDhXOFY50X7wjBTxDsGiygo71ez2n//W
	CVRzvjvzJXpxYNV2u6nbRTkFSN3+6oSNNhx017n47xmF37amaRev8bfmOiqrnJaiXv4Hfvft5N0
	grfP3cUlOQWR6fK/fL63xJ7g2kg==
X-Received: from plbla13.prod.google.com ([2002:a17:902:fa0d:b0:2a9:622c:47d6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:9cf:b0:2a7:d5c0:c659 with SMTP id d9443c01a7336-2ab3b1581a3mr5091465ad.5.1770856657375;
 Wed, 11 Feb 2026 16:37:37 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:18 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <3803e96be57ab3201ab967ba47af22d12024f9e1.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 7/7] mm: hugetlb: Refactor out hugetlb_alloc_folio()
From: Ackerley Tng <ackerleytng@google.com>
To: akpm@linux-foundation.org, dan.j.williams@intel.com, david@kernel.org, 
	fvdl@google.com, hannes@cmpxchg.org, jgg@nvidia.com, jiaqiyan@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, mhocko@kernel.org, 
	michael.roth@amd.com, muchun.song@linux.dev, osalvador@suse.de, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterx@redhat.com, 
	pratyush@kernel.org, rick.p.edgecombe@intel.com, rientjes@google.com, 
	roman.gushchin@linux.dev, seanjc@google.com, shakeel.butt@linux.dev, 
	shivankg@amd.com, vannapurve@google.com, yan.y.zhao@intel.com
Cc: ackerleytng@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13874-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EBAB128AF7
X-Rspamd-Action: no action

Refactor out hugetlb_alloc_folio() from alloc_hugetlb_folio(), which
handles allocation of a folio and memory and HugeTLB charging to cgroups.

Other than flags to control charging, hugetlb_alloc_folio() also takes
parameters for memory policy and memcg to charge memory to.

This refactoring decouples the HugeTLB page allocation from VMAs,
specifically:

1. Reservations (as in resv_map) are stored in the vma
2. mpol is stored at vma->vm_policy
3. A vma must be used for allocation even if the pages are not meant to be
   used by host process.

Without this coupling, VMAs are no longer a requirement for
allocation. This opens up the allocation routine for usage without VMAs,
which will allow guest_memfd to use HugeTLB as a more generic allocator of
huge pages, since guest_memfd memory may not have any associated VMAs by
design. In addition, direct allocations from HugeTLB could possibly be
refactored to avoid the use of a pseudo-VMA.

Also, this decouples HugeTLB page allocation from HugeTLBfs, where the
subpool is stored at the fs mount. This is also a requirement for
guest_memfd, where the plan is to have a subpool created per-fd and stored
on the inode.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h |  11 +++
 mm/hugetlb.c            | 201 +++++++++++++++++++++++-----------------
 2 files changed, 126 insertions(+), 86 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e51b8ef0cebd9..e385945c04af0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -704,6 +704,9 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
+struct folio *hugetlb_alloc_folio(struct hstate *h, struct mempolicy *mpol,
+		int nid, nodemask_t *nodemask, struct mem_cgroup *memcg,
+		bool charge_hugetlb_rsvd, bool use_existing_reservation);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1115,6 +1118,14 @@ static inline void wait_for_freed_hugetlb_folios(void)
 {
 }
 
+static inline struct folio *hugetlb_alloc_folio(struct hstate *h,
+		struct mempolicy *mpol, int nid, nodemask_t *nodemask,
+		struct mem_cgroup *memcg, bool charge_hugetlb_rsvd,
+		bool use_existing_reservation)
+{
+	return NULL;
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70e91edc47dc1..c6cfb268a527a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2844,6 +2844,105 @@ void wait_for_freed_hugetlb_folios(void)
 	flush_work(&free_hpage_work);
 }
 
+/**
+ * hugetlb_alloc_folio() - Allocates a hugetlb folio.
+ *
+ * @h: struct hstate to allocate from.
+ * @mpol: struct mempolicy to apply for this folio allocation.
+ *        Caller must hold reference to mpol.
+ * @nid: Node id, used together with mpol to determine folio allocation.
+ * @nodemask: Nodemask, used together with mpol to determine folio allocation.
+ * @memcg: Memory cgroup to charge for memory usage.
+ *         Caller must hold reference on memcg.
+ * @charge_hugetlb_rsvd: Set to true to charge hugetlb reservations in cgroup.
+ * @use_existing_reservation: Set to true if this allocation should use an
+ *                            existing hstate reservation.
+ *
+ * This function handles cgroup and global hstate reservations. VMA-related
+ * reservations and subpool debiting must be handled by the caller if necessary.
+ *
+ * Return: folio on success or negated error otherwise.
+ */
+struct folio *hugetlb_alloc_folio(struct hstate *h, struct mempolicy *mpol,
+		int nid, nodemask_t *nodemask, struct mem_cgroup *memcg,
+		bool charge_hugetlb_rsvd, bool use_existing_reservation)
+{
+	size_t nr_pages = pages_per_huge_page(h);
+	struct hugetlb_cgroup *h_cg = NULL;
+	gfp_t gfp = htlb_alloc_mask(h);
+	bool memory_charged = false;
+	int idx = hstate_index(h);
+	struct folio *folio;
+	int ret;
+
+	if (charge_hugetlb_rsvd) {
+		if (hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg))
+			return ERR_PTR(-ENOSPC);
+	}
+
+	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg)) {
+		ret = -ENOSPC;
+		goto out_uncharge_hugetlb_page_count;
+	}
+
+	ret = mem_cgroup_hugetlb_try_charge(memcg, gfp | __GFP_RETRY_MAYFAIL,
+					    nr_pages);
+	if (ret == -ENOMEM)
+		goto out_uncharge_memory;
+
+	memory_charged = !ret;
+
+	spin_lock_irq(&hugetlb_lock);
+
+	folio = NULL;
+	if (use_existing_reservation || available_huge_pages(h))
+		folio = dequeue_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
+
+	if (!folio) {
+		spin_unlock_irq(&hugetlb_lock);
+		folio = alloc_buddy_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
+		if (!folio) {
+			ret = -ENOSPC;
+			goto out_uncharge_memory;
+		}
+		spin_lock_irq(&hugetlb_lock);
+		list_add(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
+		/* Fall through */
+	}
+
+	if (use_existing_reservation) {
+		folio_set_hugetlb_restore_reserve(folio);
+		h->resv_huge_pages--;
+	}
+
+	hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio);
+
+	if (charge_hugetlb_rsvd)
+		hugetlb_cgroup_commit_charge_rsvd(idx, nr_pages, h_cg, folio);
+
+	spin_unlock_irq(&hugetlb_lock);
+
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, nr_pages);
+
+	if (memory_charged)
+		mem_cgroup_commit_charge(folio, memcg);
+
+	return folio;
+
+out_uncharge_memory:
+	if (memory_charged)
+		mem_cgroup_cancel_charge(memcg, nr_pages);
+
+	hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg);
+
+out_uncharge_hugetlb_page_count:
+	if (charge_hugetlb_rsvd)
+		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg);
+
+	return ERR_PTR(ret);
+}
+
 typedef enum {
 	/*
 	 * For either 0/1: we checked the per-vma resv map, and one resv
@@ -2878,17 +2977,14 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct folio *folio;
 	long retval, gbl_chg, gbl_reserve;
 	map_chg_state map_chg;
-	int ret, idx;
-	struct hugetlb_cgroup *h_cg = NULL;
 	gfp_t gfp = htlb_alloc_mask(h);
-	bool memory_charged = false;
+	bool charge_hugetlb_rsvd;
+	bool use_existing_reservation;
 	struct mem_cgroup *memcg;
 	struct mempolicy *mpol;
 	nodemask_t *nodemask;
 	int nid;
 
-	idx = hstate_index(h);
-
 	/* Whether we need a separate per-vma reservation? */
 	if (cow_from_owner) {
 		/*
@@ -2920,7 +3016,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (map_chg) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0) {
-			ret = -ENOSPC;
+			folio = ERR_PTR(-ENOSPC);
 			goto out_end_reservation;
 		}
 	} else {
@@ -2935,85 +3031,30 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * If this allocation is not consuming a per-vma reservation,
 	 * charge the hugetlb cgroup now.
 	 */
-	if (map_chg) {
-		ret = hugetlb_cgroup_charge_cgroup_rsvd(
-			idx, pages_per_huge_page(h), &h_cg);
-		if (ret) {
-			ret = -ENOSPC;
-			goto out_subpool_put;
-		}
-	}
+	charge_hugetlb_rsvd = (bool)map_chg;
 
-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
-	if (ret) {
-		ret = -ENOSPC;
-		goto out_uncharge_cgroup_reservation;
-	}
+	/*
+	 * gbl_chg == 0 indicates a reservation exists for the allocation, so
+	 * try to use it.
+	 */
+	use_existing_reservation = gbl_chg == 0;
 
 	memcg = get_mem_cgroup_from_current();
-	ret = mem_cgroup_hugetlb_try_charge(memcg, gfp | __GFP_RETRY_MAYFAIL,
-					    pages_per_huge_page(h));
-	if (ret == -ENOMEM)
-		goto out_put_memcg;
-
-	memory_charged = !ret;
-
-	spin_lock_irq(&hugetlb_lock);
 
 	/* Takes reference on mpol. */
 	nid = huge_node(vma, addr, gfp, &mpol, &nodemask);
 
-	/*
-	 * gbl_chg == 0 indicates a reservation exists for the allocation - so
-	 * try dequeuing a page. If there are available_huge_pages(), try using
-	 * them!
-	 */
-	folio = NULL;
-	if (!gbl_chg || available_huge_pages(h))
-		folio = dequeue_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
-
-	if (!folio) {
-		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_buddy_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
-		if (!folio) {
-			mpol_cond_put(mpol);
-			ret = -ENOSPC;
-			goto out_uncharge_memory;
-		}
-		spin_lock_irq(&hugetlb_lock);
-		list_add(&folio->lru, &h->hugepage_activelist);
-		folio_ref_unfreeze(folio, 1);
-		/* Fall through */
-	}
+	folio = hugetlb_alloc_folio(h, mpol, nid, nodemask, memcg,
+				    charge_hugetlb_rsvd,
+				    use_existing_reservation);
 
 	mpol_cond_put(mpol);
 
-	/*
-	 * Either dequeued or buddy-allocated folio needs to add special
-	 * mark to the folio when it consumes a global reservation.
-	 */
-	if (!gbl_chg) {
-		folio_set_hugetlb_restore_reserve(folio);
-		h->resv_huge_pages--;
-	}
-
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
-	/* If allocation is not consuming a reservation, also store the
-	 * hugetlb_cgroup pointer on the page.
-	 */
-	if (map_chg) {
-		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, folio);
-	}
-
-	spin_unlock_irq(&hugetlb_lock);
-
-	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-
-	if (memory_charged)
-		mem_cgroup_commit_charge(folio, memcg);
 	mem_cgroup_put(memcg);
 
+	if (IS_ERR(folio))
+		goto out_subpool_put;
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	if (map_chg != MAP_CHG_ENFORCED) {
@@ -3046,17 +3087,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	return folio;
 
-out_uncharge_memory:
-	if (memory_charged)
-		mem_cgroup_cancel_charge(memcg, pages_per_huge_page(h));
-out_put_memcg:
-	mem_cgroup_put(memcg);
-
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
-out_uncharge_cgroup_reservation:
-	if (map_chg)
-		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
-						    h_cg);
 out_subpool_put:
 	/*
 	 * put page to subpool iff the quota of subpool's rsv_hpages is used
@@ -3067,11 +3097,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
 
-
 out_end_reservation:
 	if (map_chg != MAP_CHG_ENFORCED)
 		vma_end_reservation(h, vma, addr);
-	return ERR_PTR(ret);
+	return folio;
 }
 
 static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
-- 
2.53.0.310.g728cabbaf7-goog


