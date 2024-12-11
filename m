Return-Path: <cgroups+bounces-5826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17699ED733
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E7161190
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD365200BA9;
	Wed, 11 Dec 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PE2iUvat"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE7259497;
	Wed, 11 Dec 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948747; cv=none; b=spmaPhxe8XEyVKPfBzvH2v8YX+5ZoIYTBAqVhR43XPDDg8koD9IXuel/fJM1hWTlcTE/9JTe9mu63bp/KaRXbKIPewOEEnvrxtnultIrskzQLG7Wr3PnC4o/r9DeUbr1Pwxr8aX+D5IZ0Wc1WZp7Hfmsxe3Oz7T1jWmha387bKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948747; c=relaxed/simple;
	bh=soAMBMvgU/tT6YJ3xdIXaARhZWCrAD20pN5MT+kg2Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5wAGGZ7IeneAIuFg+RlOJoCKGHyGGODMZE/OnSMgdPn6JQLwXABXYbhzoNAEIkUatjwYQK83MT+vEiIGcJspOuAgIEvJGh2EeqAlW6opCkPdxuthJITfJC73zV8o0jJjCcyy883hsAjAt81mHI+VhpuqnYlwGUugttSrbEb5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PE2iUvat; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ksbtM9EHkNTzFRsceNZ/+H1YFyjHaIe3HxlpDQ6sOig=; b=PE2iUvatkvAM0U3FfNWu9Q34sD
	QEwOEaRn+40VhLdDC4lTxR10Bl0STlZVb0cXb3bsmEN5ON2HfJiDi65DYpjc8dIggWSDHCPNJPJHb
	WL4bn/rUIrhjEBMi08fNnr/WdWhLXfj0pamIp0GydLbDhFZBwPSJueoUhPMysF8jV5uousKrG9jhH
	Qlz2sRaoSEPnJXGkD/HifohhmmQ6KRxFBvJDOKxZuVa5czhR5turirXB6I3vcB4luzkVarvCE8FzX
	y9VDdqHFWeNLHFpJ4LaOrC1fC3Imc9l3l6xZMGvizu7VvbqT47MIEgDGm39U9w8GdxJ976hq9RSwW
	w0YVn1IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLTHA-00000000hop-2yNF;
	Wed, 11 Dec 2024 20:25:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] vmalloc: Fix accounting with i915
Date: Wed, 11 Dec 2024 20:25:37 +0000
Message-ID: <20241211202538.168311-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
vfree().  These counters are incremented by vmalloc() but not by vmap()
so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
decrementing either counter.

Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmalloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f009b21705c1..5c88d0e90c20 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3374,7 +3374,8 @@ void vfree(const void *addr)
 		struct page *page = vm->pages[i];
 
 		BUG_ON(!page);
-		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+		if (!(vm->flags & VM_MAP_PUT_PAGES))
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 		/*
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
@@ -3382,7 +3383,8 @@ void vfree(const void *addr)
 		__free_page(page);
 		cond_resched();
 	}
-	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
+	if (!(vm->flags & VM_MAP_PUT_PAGES))
+		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
 	kvfree(vm->pages);
 	kfree(vm);
 }
-- 
2.45.2


