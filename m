Return-Path: <cgroups+bounces-13872-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE5ZBhghjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13872-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:38:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BEC128B06
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1426B302E71A
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353421A459;
	Thu, 12 Feb 2026 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoQsVpqB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456D1C8626
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856656; cv=none; b=r9FgzjAC6LqAZCwRzP0KpL+JhAP1snO513xm4bu3jZEP1JCH7V1SXmWURijTaZnNF76+QGdsZqjSn5RfHCafnO2m+NiRm5NGefIqvLTVK4x30UIKk9PzodbI87jNl0C4R/h0A5NpuSJd5QThtP3hnncuvdIyByMdnUBgVizR6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856656; c=relaxed/simple;
	bh=kKS15axEk0LsRuKNrmNoFDsiye0vhaIHHxcdpf45fME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TVJAjW9Ljzn8D9fZQglvHYVb1Thct5uOt3t3NeXHlzPX/XaRitDvsnC+TRagDZAZCvY08GqAzIq31aCHlRgunnvymveAu4qPRPE2xA5UIS8GVrHR3KgpBtMPNiZ6b1uqXHxbRC8xCe5C6LFf84nGq+qgHl3vyy7bn4iWhks99FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoQsVpqB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a75ed2f89dso63690525ad.1
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856654; x=1771461454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe2F5DK4zZDtXkI/xhYQlRYGmZxVF2QOYK8cN8BDaKU=;
        b=BoQsVpqBtetDc2ujO21ye/Cdy2gQmK3Xi63AXlvOiTTQazLjjWA6ZRQ7MfRCq68jhX
         p9hS20ja/67qa62rmx0oV3riclxWmZrN7/wSxwqRM2LTWe+n5I0DQsqs+elzIozHWIQH
         pzQ75osmzL+T1DUCmZv1sfCppcc9vsTnF4s+YZh+tkKZ/gt6JUUvGbCaJRmN5oAVMN68
         YW/Q6KaNd/23FaTjcFuPOVPdHaJs0pnbmyAL1Ft+K3a93iT41bhsNqNMn4wxyY4e+fMl
         u6QmVfYvuWv2apqGNP9aL+mfDiDBhIG3Z1kKK2Q32L3J9Z6+oig7F/c68lb/vqs70dp3
         pmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856654; x=1771461454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe2F5DK4zZDtXkI/xhYQlRYGmZxVF2QOYK8cN8BDaKU=;
        b=nGnb5IvvwklD6IP4wcpWZOjvOGyhbBWetDravNit6CPdHJhFdIRuNAIk4m9fsR6arj
         wJdYNlonaQDiAuL+5Eycs9Jlto4FbraAc/EjMdnFfGhRNQ/6YPve4MF/6wDU0gfc0r/5
         OxRYtHdzzwm/eIEEAPVsbl5ij8C10hOh53miW2oNI+sz4wVEQFbrPVXpoeF2UqGs1gLI
         AjD6jaWUHcBgtWJ4HkmFStdrkcZB/0Z7r/PoFkdQd0fJ30VbV6Qm6NVIz80jwSZ2uPU5
         Ug0gBBzChq+7ed/okyLfKu3lnXAjwN1/ohPSG7SOofoXc+Z/a6Xb3720SR1vXm13qykP
         EE4A==
X-Forwarded-Encrypted: i=1; AJvYcCV0tA/O8SxWVj1qWw177uEB6DpmHYRYM0i3uajgO6O5inUif3tlqTsKrvDt4mF/LJrlN8Mv177d@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47mmru5rI9SEBY4BpaxJEzpO3/6H5NYiz1LsePI662QxrrUfs
	N4Ki2Ur/IIW5gPQ3mIjDtKCO0qssVq6702SwTX/ytKwp9BNRFAiOvusWYlJMYudWBxUWrjotTnG
	svF1UtC/KrxFwJwRn/BEYBRFoQw==
X-Received: from pllo10.prod.google.com ([2002:a17:902:778a:b0:2a7:80ac:dd82])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:17cd:b0:2a0:8e35:969d with SMTP id d9443c01a7336-2ab39b16ed4mr9131845ad.39.1770856654111;
 Wed, 11 Feb 2026 16:37:34 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:16 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <28d1cd5b7b9a628d6ca6550b8fcafe887190a9e6.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 5/7] mm: hugetlb: Adopt memcg try-commit-cancel protocol
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13872-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46BEC128B06
X-Rspamd-Action: no action

Refactor alloc_hugetlb_folio() to use the memcg try-commit-cancel protocol.

Do this to allow the core of allocating a hugetlb folio and associated
memcg charging to be refactored out in a later patch.

In addition, checking cgroup memory limits before allocating avoids
unnecessary allocation if the limits had already been hit.

Update error code propagation in the failure paths so that existing error
cases still return -ENOSPC, but if the memory limit is reached, return
-ENOMEM as before.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 53 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 74b5136fdeb54..70e91edc47dc1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2881,6 +2881,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
 	gfp_t gfp = htlb_alloc_mask(h);
+	bool memory_charged = false;
+	struct mem_cgroup *memcg;
 	struct mempolicy *mpol;
 	nodemask_t *nodemask;
 	int nid;
@@ -2917,8 +2919,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 */
 	if (map_chg) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
-		if (gbl_chg < 0)
+		if (gbl_chg < 0) {
+			ret = -ENOSPC;
 			goto out_end_reservation;
+		}
 	} else {
 		/*
 		 * If we have the vma reservation ready, no need for extra
@@ -2934,13 +2938,25 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (map_chg) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
 			idx, pages_per_huge_page(h), &h_cg);
-		if (ret)
+		if (ret) {
+			ret = -ENOSPC;
 			goto out_subpool_put;
+		}
 	}
 
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
-	if (ret)
+	if (ret) {
+		ret = -ENOSPC;
 		goto out_uncharge_cgroup_reservation;
+	}
+
+	memcg = get_mem_cgroup_from_current();
+	ret = mem_cgroup_hugetlb_try_charge(memcg, gfp | __GFP_RETRY_MAYFAIL,
+					    pages_per_huge_page(h));
+	if (ret == -ENOMEM)
+		goto out_put_memcg;
+
+	memory_charged = !ret;
 
 	spin_lock_irq(&hugetlb_lock);
 
@@ -2961,7 +2977,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
 		if (!folio) {
 			mpol_cond_put(mpol);
-			goto out_uncharge_cgroup;
+			ret = -ENOSPC;
+			goto out_uncharge_memory;
 		}
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&folio->lru, &h->hugepage_activelist);
@@ -2991,6 +3008,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	spin_unlock_irq(&hugetlb_lock);
 
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
+
+	if (memory_charged)
+		mem_cgroup_commit_charge(folio, memcg);
+	mem_cgroup_put(memcg);
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	if (map_chg != MAP_CHG_ENFORCED) {
@@ -3021,22 +3044,14 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	ret = mem_cgroup_charge_hugetlb(folio, gfp | __GFP_RETRY_MAYFAIL);
-	/*
-	 * Unconditionally increment NR_HUGETLB here. If it turns out that
-	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
-	 * decrement NR_HUGETLB.
-	 */
-	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-
-	if (ret == -ENOMEM) {
-		free_huge_folio(folio);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	return folio;
 
-out_uncharge_cgroup:
+out_uncharge_memory:
+	if (memory_charged)
+		mem_cgroup_cancel_charge(memcg, pages_per_huge_page(h));
+out_put_memcg:
+	mem_cgroup_put(memcg);
+
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
 out_uncharge_cgroup_reservation:
 	if (map_chg)
@@ -3056,7 +3071,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_end_reservation:
 	if (map_chg != MAP_CHG_ENFORCED)
 		vma_end_reservation(h, vma, addr);
-	return ERR_PTR(-ENOSPC);
+	return ERR_PTR(ret);
 }
 
 static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
-- 
2.53.0.310.g728cabbaf7-goog


