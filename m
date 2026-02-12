Return-Path: <cgroups+bounces-13868-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PBtEtggjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13868-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A8128ACA
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDA07302961B
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A91D6DA9;
	Thu, 12 Feb 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWwt34gR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F51AC44D
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856649; cv=none; b=RyISkU/HMB9LOF0anamUpZBOF4PDx7W4qymrU5hFQrrkjP/P7RDEVsqkna8qWJWBB3mMOz2O28xNLM0pMClnQI/68cljrRu3UTLYm0NWpAu/y9ozlvDF0EU95jnQ/8ZKbSfknVJHcv51gAiFosQuYXCC6UZjbfuVuyNSn5d6CQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856649; c=relaxed/simple;
	bh=LM4IDRwtUxJyRCp0kUE1qgZT5L1HEBFTk6wT4AL7YaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFDQrRzorlm+yLkOidFlAOgO37wAS0SnQUjzIb4mTbdoe14FOl8WLkQYHT1/JJLnCvO/x35/SQBbkDxHoXxyMdOOy7iURPo4Ejaqxu3bJKGvxf4HT53+J8RSYxJ/uCZ3UA2hXtqJY0zErAFPsZbdzR9nRQaZrC8M2fIzW6aTrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWwt34gR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35678f99c6eso1272648a91.1
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856648; x=1771461448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JnA227LuyuHWxtahECJXUZ4BvkZ1hdR9r/VpPR8oGw=;
        b=lWwt34gRcEoQKHR52f7m0mprMvta85z7Kl+YRjoeQuFli12rq3Z6JuvgWq1WcZGldL
         JL4p6Q+ltNTwhEqpJW8S0ate+1RH4GQNSXXoaMOl3ixfSEtkrTiRK9L6K9yTFtJGDFwz
         CNXEeb0lK6PQvmS7IExlAh3IwMhezAszqM6Qbu1PSB3JmB/deMckSKigsD1pzif3P8/G
         Sqe2ylvlkh3Yv0erQBk1OU5rPBSHK4YewDlD5D00SMc917VLPu0OQRbuuYqU1+yeJnC6
         UFcY0BbQYqxZfoEJjlzSgen5wIw57Lm3oAV6idIoMWdvkYR86WTZXAtM23mI1fc5/yNk
         V6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856648; x=1771461448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JnA227LuyuHWxtahECJXUZ4BvkZ1hdR9r/VpPR8oGw=;
        b=ta5jN91FM84vQOpmX5pPU8+GU4mTPUrmvEXQORB31Co2XayOtzAn+zMRU9rY87Bbpo
         VxRTvOoSn5tJwrRrE35Tqf3VHpqX5IZywYGCGM7cTZ/MiHT+rPWP5LmGWuT0Pe3Eo49o
         TA5Y5eSxgxz7uc/zD/Zb05LWh413KfRX3dfAmfqrMKn1Q3LhS0/SUwned4bd+7fweHdZ
         +9wk2yert7alcWrXXH726q22ZnXPlIeDK3SwAljwWZ+EKZErEOPI7Tlc5aTgXm/qXBGL
         7Ur7y/7gF7/bx1dQtyaaoTXwNUfiZwGpnPtcJmoF+lWKzZ8jjU5kTgkr2BzcwHXfihww
         ZyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBBpS9wiTIC7NES85fcVKGN9gJ1lj4A+bbXiLiYPAXCedcTXg1Z5BainB9fbmIl+JjbmHehhzr@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEWVRUzeOSi6BX7z9VFbO/5h1G3ZDUdWjM3RXAU4/Zik71HP5
	6xRJmcDu4bqVwl2z/qpaWZbTKCiWWu1O7WoGG49xSe6IASrStFQhCbDSmlTT1gIlMW3HiAGSGl4
	LqKhRcveiVCBOxULAk8legWwPVA==
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:c6c:9940:fac3])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:495:b0:38d:ebdc:3546 with SMTP id adf61e73a8af0-39448477cb9mr923997637.6.1770856647927;
 Wed, 11 Feb 2026 16:37:27 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:12 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <fa4172f57caf8fd3013d13d96211de6bb8cf6d38.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 1/7] mm: hugetlb: Consolidate interpretation of gbl_chg
 within alloc_hugetlb_folio()
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
	TAGGED_FROM(0.00)[bounces-13868-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: F37A8128ACA
X-Rspamd-Action: no action

Previously, gbl_chg was passed from alloc_hugetlb_folio() into
dequeue_hugetlb_folio_vma(), leaking the concept of gbl_chg into
dequeue_hugetlb_folio_vma().

This patch consolidates the interpretation of gbl_chg into
alloc_hugetlb_folio(), also renaming dequeue_hugetlb_folio_vma() to
dequeue_hugetlb_folio() so dequeue_hugetlb_folio() can just focus on
dequeuing a folio.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1832da0f6236..fd067bd394ee0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1380,7 +1380,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, long gbl_chg)
+				unsigned long address)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1388,13 +1388,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	nodemask_t *nodemask;
 	int nid;
 
-	/*
-	 * gbl_chg==1 means the allocation requires a new page that was not
-	 * reserved before.  Making sure there's at least one free page.
-	 */
-	if (gbl_chg && !available_huge_pages(h))
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1412,9 +1405,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 
 	mpol_cond_put(mpol);
 	return folio;
-
-err:
-	return NULL;
 }
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
@@ -2962,12 +2952,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		goto out_uncharge_cgroup_reservation;
 
 	spin_lock_irq(&hugetlb_lock);
+
 	/*
-	 * glb_chg is passed to indicate whether or not a page must be taken
-	 * from the global free pool (global change).  gbl_chg == 0 indicates
-	 * a reservation exists for the allocation.
+	 * gbl_chg == 0 indicates a reservation exists for the allocation - so
+	 * try dequeuing a page. If there are available_huge_pages(), try using
+	 * them!
 	 */
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
+	folio = NULL;
+	if (!gbl_chg || available_huge_pages(h))
+		folio = dequeue_hugetlb_folio_vma(h, vma, addr);
+
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
-- 
2.53.0.310.g728cabbaf7-goog


