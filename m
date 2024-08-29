Return-Path: <cgroups+bounces-4584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF8964C60
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A368D284236
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EDF1B9B43;
	Thu, 29 Aug 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTvJgRCP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB11B81B5
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950717; cv=none; b=sxKVPgxgEm2NqKrbbKbPSAjpVjQ6wGapYY/Gw565whSGbJ2eTPAUJKlrnacznaE5T2sAcSJ2LWgKgWpPFHHn/Plc9iovQmEhLX5g8qbCvnp1WdMULvhEXJh/r7PWnWKBjYTLRHfGUt9DNSeiC11LMQyHg6j/s3waE4cWIDVQ7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950717; c=relaxed/simple;
	bh=3ItMPhJsWAcR246rqGNvmSIbS4Cml/6W9Jk2oUh5LQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubjEp1CZiWdQG2y7YSWfgOvQni+IZthG+ZfD7SH5wOL19jSwAGejAl5O2C9/EaQ3zIGfbhBfLdBkynSLhuG+PpjDprDlYG/di6n8cSKn08hQUIFsznJweeTSUAmV9ZqhmeWoaUtb/CWQagA5pBSUrtr95y5SmwVC2SzG/chligk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTvJgRCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjSkhPyRz/5fIFSM96q39YLgP24AQs1QkGAT42V2m6c=;
	b=CTvJgRCPM9NKKqXuIJBzbSRPOKtFYpfvfi6DC+hscmQHii02dErw8jo8PbgoWHbcwa4I8x
	RKCkAMQ4pXu2uRvewAqQa0DIK+WevVewqvtlV97I8106M7Zl20tItpdXXEVMOGOx2ghjtY
	a7ikegOhPnhmAU78sszeRMTK/WsIB9s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-ZwwKUWzxPCORnd2cpciv7A-1; Thu,
 29 Aug 2024 12:58:27 -0400
X-MC-Unique: ZwwKUWzxPCORnd2cpciv7A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E98818BC2F6;
	Thu, 29 Aug 2024 16:58:23 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 120621955F66;
	Thu, 29 Aug 2024 16:58:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 10/17] mm: COW reuse support for PTE-mapped THP with CONFIG_MM_ID
Date: Thu, 29 Aug 2024 18:56:13 +0200
Message-ID: <20240829165627.2256514-11-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's add support for CONFIG_MM_ID. The implementation is fairly
straight forward: if exclusively mapped, make sure that all references
are from mappings.

There are plenty of things we can optimize in the future: For example, we
could remember that the folio is fully exclusive so we could speedup
the next fault further. Also, we could try "faulting around", turning
surrounding PTEs that map the same folio writable. But especially the
latter might increase COW latency, so it would need further
investigation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c2143c40a134b..3803d4aa952ed 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3564,19 +3564,90 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 	return ret;
 }
 
-static bool wp_can_reuse_anon_folio(struct folio *folio,
-				    struct vm_area_struct *vma)
+#ifdef CONFIG_MM_ID
+static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
+		struct vm_area_struct *vma)
 {
+	bool exclusive = false;
+
+	/* Let's just free up a large folio if only a single page is mapped. */
+	if (folio_large_mapcount(folio) <= 1)
+		return false;
+
 	/*
-	 * We could currently only reuse a subpage of a large folio if no
-	 * other subpages of the large folios are still mapped. However,
-	 * let's just consistently not reuse subpages even if we could
-	 * reuse in that scenario, and give back a large folio a bit
-	 * sooner.
+	 * The assumption for anonymous folios is that each page can only get
+	 * mapped once into each MM. The only exception are KSM folios, which
+	 * are always small.
+	 *
+	 * Each taken mapcount must be paired with exactly one taken reference,
+	 * whereby the refcount must be incremented before the mapcount when
+	 * mapping a page, and the refcount must be decremented after the
+	 * mapcount when unmapping a page.
+	 *
+	 * If all folio references are from mappings, and all mappings are in
+	 * the page tables of this MM, then this folio is exclusive to this MM.
 	 */
-	if (folio_test_large(folio))
+	if (!folio_test_large_mapped_exclusively(folio))
+		return false;
+
+	VM_WARN_ON_ONCE(folio_test_ksm(folio));
+	VM_WARN_ON_ONCE(folio_mapcount(folio) > folio_nr_pages(folio));
+	VM_WARN_ON_ONCE(folio_entire_mapcount(folio));
+
+	if (unlikely(folio_test_swapcache(folio))) {
+		/*
+		 * Note: freeing up the swapcache will fail if some PTEs are
+		 * still swap entries.
+		 */
+		if (!folio_trylock(folio))
+			return false;
+		folio_free_swap(folio);
+		folio_unlock(folio);
+	}
+
+	if (folio_large_mapcount(folio) != folio_ref_count(folio))
 		return false;
 
+	/* Stabilize the mapcount vs. refcount and recheck. */
+	folio_lock_large_mapcount_data(folio);
+	VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(folio));
+
+	if (!folio_test_large_mapped_exclusively(folio))
+		goto unlock;
+	if (folio_large_mapcount(folio) != folio_ref_count(folio))
+		goto unlock;
+
+	VM_WARN_ON_ONCE(folio_mm0_id(folio) != vma->vm_mm->mm_id &&
+			folio_mm1_id(folio) != vma->vm_mm->mm_id);
+
+	/*
+	 * Do we need the folio lock? Likely not. If there would have been
+	 * references from page migration/swapout, we would have detected
+	 * an additional folio reference and never ended up here.
+	 */
+	exclusive = true;
+unlock:
+	folio_unlock_large_mapcount_data(folio);
+	return exclusive;
+}
+#else /* !CONFIG_MM_ID */
+static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	/*
+	 * We could reuse the last mapped page of a large folio, but let's
+	 * just free up this large folio.
+	 */
+	return false;
+}
+#endif /* !CONFIG_MM_ID */
+
+static bool wp_can_reuse_anon_folio(struct folio *folio,
+				    struct vm_area_struct *vma)
+{
+	if (folio_test_large(folio))
+		return __wp_can_reuse_large_anon_folio(folio, vma);
+
 	/*
 	 * We have to verify under folio lock: these early checks are
 	 * just an optimization to avoid locking the folio and freeing
-- 
2.46.0


