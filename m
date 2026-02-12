Return-Path: <cgroups+bounces-13870-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LwjBPggjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13870-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:38:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33F128AF0
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 814DE3048047
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B61EDA3C;
	Thu, 12 Feb 2026 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHHpOsnM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C771E5B88
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856652; cv=none; b=k9RKZ5R1bhcS2WRPr1EQmO0OyekyHU76SffHWhwARPi/d7hftlFc9Rmuaktsm2Pb7r5i6eU/g5rWf8C1yg22dw6Y4XiBrvj7Cj9eKuVNQ+HtjNAc9suMxeZjPS0aqiOhHsjZvCiMyxQqz7o/43OPj8fmKK49JxvujFNAgaBa1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856652; c=relaxed/simple;
	bh=8aZtrmhjCVIJaB3u3GcD2XUcVSdoXF1ZdqytqPqNHW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P9y5arFtXOwgJK1iY/57Tf5TbdsivsaR/TzYBcE50oSry9seBbq5+b5ZfddOILCtQ2dLU3fjCcrjl54G2cUqLndSEmwAZOjLbtuEbGjoiLHhhmpWeg9cEIwF0w4q8Nfyc0DOH2kITUGrbwHYuTyFdfVzpUDGQLNYU3Ql6G2RZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHHpOsnM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso16085289a12.3
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856651; x=1771461451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcMLX2Xy1jOIpMds+I1gs4yK1mnZMXU9mzbbwG+o564=;
        b=ZHHpOsnMKJ2Va2p8ZXdT2tHQaQB1BnoFg7Vryz+UgfeJeO4wEpKrY1Duuo1xM2NnVB
         6bfsImLyfdpqwGwTc3tbxj/4k21lplCj0z58gusTaBcbjp0azIIPYxuDhMWd5+JpQz2V
         meTnXZ9Z907Q1Q79XOw37VBVsTgpVTmMB/x7I+S2WR7TmSNy5jnp3mfGXGL8LZqVvhxN
         hWfaEDJq4V1WIR5hvdX9gut3guJZONPd0yS8R11Q4IbaeuxsRsgia0BIopdLGlFgF8Kw
         zhcAq20tGLOdIbDOJ1nWAyeo14R0VSe7w2B4T8jct4aw0MFz5BAvsL/bxGhpkzyRh5OA
         TO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856651; x=1771461451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcMLX2Xy1jOIpMds+I1gs4yK1mnZMXU9mzbbwG+o564=;
        b=trTmDYqYXuGLD8HBoRzbEWVSw4XffeJriaRzuYbONJD82I8r2ySu3Ui4f9lj2aplSx
         Gk1EKh76bKQoxHGa9H6qq2PUxs5hvT3RtoFFyvXmKDRn8jDUb2SW2QHvPOtVOvb7H58Q
         CzcvDNL1pp+5Tv/DTSpQkZ0nXxntbxvRYqks0/Ns4AD/PJQK6qgn8n+3lt6h8C+g7AiM
         WFZOcYu5oPn9vpbrU7rZeo7NisvCISb87qwQ9IB9gO0ddjmWHE5ZClIBDFu2fofqZAjp
         cE8nkc4ONxtR3zzRlUEq0L96cG9iyH8atAPU5u6sgmgrkHE9V+9GuI0zhJANKSP+5Dfm
         hpQw==
X-Forwarded-Encrypted: i=1; AJvYcCXQak8UuNzJ6HjNDpqahy99YC40C8WOTYdeT4YpctCOeDORESBFgfhDKh3hyGSKroUAc1IISntK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72LTVme1kxhozxUCeSu/4LAb2Kj+yYoYoLqYPnBu9V7uZ30Kb
	xtYNi6sVDeyJN+d+lXJbMSnBafPCTKGkxqkPnUfy1qW+5/ZLFmdxqIfBq0msSQiO5m6NeaYHdTY
	tqp6hB57fhC8MB3PHtvCuFjKI8Q==
X-Received: from pfnz7.prod.google.com ([2002:aa7:85c7:0:b0:824:9b2f:783])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fc3:b0:81f:4d18:65c4 with SMTP id d2e1a72fcca58-824b05ce226mr768557b3a.59.1770856651067;
 Wed, 11 Feb 2026 16:37:31 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:14 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <67a62716952c806c2a512e98bcac1f5224ada324.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 3/7] mm: hugetlb: Move mpol interpretation out of dequeue_hugetlb_folio_vma()
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
	TAGGED_FROM(0.00)[bounces-13870-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: AE33F128AF0
X-Rspamd-Action: no action

Move memory policy interpretation out of dequeue_hugetlb_folio_vma() and
into alloc_hugetlb_folio() to separate reading and interpretation of memory
policy from actual allocation.

Also rename dequeue_hugetlb_folio_vma() to
dequeue_hugetlb_folio_with_mpol() to remove association with vma and to
align with alloc_buddy_hugetlb_folio_with_mpol().

This will later allow memory policy to be interpreted outside of the
process of allocating a hugetlb folio entirely. This opens doors for other
callers of the HugeTLB folio allocation function, such as guest_memfd,
where memory may not always be mapped and hence may not have an associated
vma.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aaa23d995b65c..74b5136fdeb54 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1378,18 +1378,11 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
-				struct vm_area_struct *vma,
-				unsigned long address)
+static struct folio *dequeue_hugetlb_folio_with_mpol(struct hstate *h,
+		struct mempolicy *mpol, int nid, nodemask_t *nodemask)
 {
 	struct folio *folio = NULL;
-	struct mempolicy *mpol;
-	gfp_t gfp_mask;
-	nodemask_t *nodemask;
-	int nid;
-
-	gfp_mask = htlb_alloc_mask(h);
-	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
+	gfp_t gfp_mask = htlb_alloc_mask(h);
 
 	if (mpol_is_preferred_many(mpol)) {
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
@@ -1403,7 +1396,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	mpol_cond_put(mpol);
 	return folio;
 }
 
@@ -2889,6 +2881,9 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
 	gfp_t gfp = htlb_alloc_mask(h);
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+	int nid;
 
 	idx = hstate_index(h);
 
@@ -2949,6 +2944,9 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	spin_lock_irq(&hugetlb_lock);
 
+	/* Takes reference on mpol. */
+	nid = huge_node(vma, addr, gfp, &mpol, &nodemask);
+
 	/*
 	 * gbl_chg == 0 indicates a reservation exists for the allocation - so
 	 * try dequeuing a page. If there are available_huge_pages(), try using
@@ -2956,25 +2954,23 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 */
 	folio = NULL;
 	if (!gbl_chg || available_huge_pages(h))
-		folio = dequeue_hugetlb_folio_vma(h, vma, addr);
+		folio = dequeue_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
 
 	if (!folio) {
-		struct mempolicy *mpol;
-		nodemask_t *nodemask;
-		int nid;
-
 		spin_unlock_irq(&hugetlb_lock);
-		nid = huge_node(vma, addr, gfp, &mpol, &nodemask);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, mpol, nid, nodemask);
-		mpol_cond_put(mpol);
-		if (!folio)
+		if (!folio) {
+			mpol_cond_put(mpol);
 			goto out_uncharge_cgroup;
+		}
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&folio->lru, &h->hugepage_activelist);
 		folio_ref_unfreeze(folio, 1);
 		/* Fall through */
 	}
 
+	mpol_cond_put(mpol);
+
 	/*
 	 * Either dequeued or buddy-allocated folio needs to add special
 	 * mark to the folio when it consumes a global reservation.
-- 
2.53.0.310.g728cabbaf7-goog


