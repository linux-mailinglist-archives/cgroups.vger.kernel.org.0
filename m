Return-Path: <cgroups+bounces-13869-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAKWF+UgjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13869-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D329F128ADA
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68CE303324E
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD501E0DE8;
	Thu, 12 Feb 2026 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwALuDq4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44D1DD889
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856651; cv=none; b=XBb3LaOoawW6k0xxOz+g4FpyFgq5ZRT1QcPr0ma24PAL53GWkZX7N0GvUs9850uJ+/yJqjlVJyg3zJiUeAudRtVQKOMgZ+U3D2dn0b9+LEY1jGdE5unJTDNZ1Xdu9uJoLJB+eSH+QrFge1PLj3ZmViIcfNrBP43Q6qk+pZsQkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856651; c=relaxed/simple;
	bh=WbOu/6e8uR8HBFqHpqlKdK3+FnhdgP20V84LWErdyq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FRDGVjymPvTLb+hvM7oJgNlrNORFhNc5004psETx2oMGqkk3ZVZJFxueCXU9RhLGgGQM5LBUJX0xgMxrY6hggdbIy384s3TR0y1ySCJNqg6NqyAvpEM70jFSQix1qGCs/sPJQsYVbbhuiQ2xhFJKapZ0X354P3LyQ38Xcb+JJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwALuDq4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso11041789a91.3
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856650; x=1771461450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+fyXiA+m57FzuXOpgMoIQnVFz3nHsjbKsXBY1bNSP0=;
        b=QwALuDq4hDTWF4z2/mARw6VlkqVwFmhExhusQcQrJbZgXlo8xEVZh5M/OZ+CloAal9
         w2ZNbDjQRyWTAYizFTFfEpzgWYLxWsRxIfdWcIkY1T5TTKEJPXgxZcgOOmy0lkG7iTDF
         VwmFQwDYgAVwioT/5waJIpN+TTFtt4xmyhVq2Uu75UHfNhnLsVTg8svOzY+S8m9Z7cdg
         w2UmaVDNmmMNTFRz2PEoQv5i7U9JOydqRj5FYHotYfnzkU92eaDMIm/ggFj/BMWy23rz
         EWaIDJsCHQOe0oFcK9j/sOduMBqzqanXdUS2cVCMDqv1WlOZo1HriFC71cRYa3ON3nbE
         BuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856650; x=1771461450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+fyXiA+m57FzuXOpgMoIQnVFz3nHsjbKsXBY1bNSP0=;
        b=mIZ63cbLTkCheWPkKe3f54iYGqeslF93ikQdKhmnZZNTkwuCol3cp7G2QfTvQ83Swo
         khtBhllsYEZn8pfgLM2GJJPEivhZwh0AoNt1MjEuFxkehv3zbYZSz2f+ciS50twD9Y8V
         XZrlrHrY4yf5NHYlrsxakXgT9809p0UGPCUycHKOXcZZ/jsGPeeXiCkL6SU1552AB1kF
         xV/UZzb89vOkVkKJUBEfXRRo/naHosqVR2MiLkVd73rwFpdv6PMYFpIYOaiowuDrc+u2
         055xvEY+kF/cIeBhmyhnAag2B/53fCNRXaWwakkDPHHQhqT1h+bFhKrlYCv4O/bDdBIx
         kzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCsV6sQ4m4h5W5Xk/JrmHQLrWqDdz86wSxbH/UnDnnPIIWVm+ga3BDPHNF53a08+XYsS5dFw4S@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg51QoXZApFRfyVMvk0OoYjRUZgwtUytjs6BcWrISBNzXTdqP0
	aO/rybJbhkVQZsg7Dm7t2QzqLFgN5t6fvxCPnpFzCD7cFg41LZiInmRd6TmfktLJrsm4q0FElUP
	k/Q7ACC4xzsAvh1qIA190bXU32Q==
X-Received: from pjzr13.prod.google.com ([2002:a17:90b:50d:b0:33b:51fe:1a73])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e45:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-3568f52e24amr904712a91.34.1770856649529;
 Wed, 11 Feb 2026 16:37:29 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:13 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <18dbaf2ff9579b285d92f26b9a69e1e302f3bbcc.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 2/7] mm: hugetlb: Move mpol interpretation out of alloc_buddy_hugetlb_folio_with_mpol()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13869-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D329F128ADA
X-Rspamd-Action: no action

Move memory policy interpretation out of
alloc_buddy_hugetlb_folio_with_mpol() and into alloc_hugetlb_folio() to
separate reading and interpretation of memory policy from actual
allocation.

This will later allow memory policy to be interpreted outside of the
process of allocating a hugetlb folio entirely. This opens doors for other
callers of the HugeTLB folio allocation function, such as guest_memfd,
where memory may not always be mapped and hence may not have an associated
vma.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fd067bd394ee0..aaa23d995b65c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2223,15 +2223,11 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
  */
 static
 struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct mempolicy *mpol, int nid, nodemask_t *nodemask)
 {
 	struct folio *folio = NULL;
-	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
-	int nid;
-	nodemask_t *nodemask;
 
-	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
 	if (mpol_is_preferred_many(mpol)) {
 		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
@@ -2243,7 +2239,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 
 	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
-	mpol_cond_put(mpol);
+
 	return folio;
 }
 
@@ -2892,7 +2888,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
-	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+	gfp_t gfp = htlb_alloc_mask(h);
 
 	idx = hstate_index(h);
 
@@ -2963,8 +2959,14 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		folio = dequeue_hugetlb_folio_vma(h, vma, addr);
 
 	if (!folio) {
+		struct mempolicy *mpol;
+		nodemask_t *nodemask;
+		int nid;
+
 		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+		nid = huge_node(vma, addr, gfp, &mpol, &nodemask);
+		folio = alloc_buddy_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
+		mpol_cond_put(mpol);
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
@@ -3023,7 +3025,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	ret = mem_cgroup_charge_hugetlb(folio, gfp);
+	ret = mem_cgroup_charge_hugetlb(folio, gfp | __GFP_RETRY_MAYFAIL);
 	/*
 	 * Unconditionally increment NR_HUGETLB here. If it turns out that
 	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
-- 
2.53.0.310.g728cabbaf7-goog


