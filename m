Return-Path: <cgroups+bounces-4575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31209964C3E
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6462B1C23116
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394C1B5EB7;
	Thu, 29 Aug 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Knp5avh+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6A1B5832
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950628; cv=none; b=jX6inRtSuw/0+/ANGqlB4V7DhuyU1vV9HSUQZfucPf+dD7cIcgUDLyPz/XPeHonit99R+tyiiM3Lp2ETjdXicWZuBv8jhdiTTy1WFc0pOQMeXc6i+ZX3jr52x4vPLXGpTawR/0H0Ps5OgATh6qzJ/HOvSZC3GNsbPB6HrvnId1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950628; c=relaxed/simple;
	bh=mRUSwjzIKgUm6C6IsJ/V836vgCXG/9gWFoTwA7mi2ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCovUe9dAle09/pp7cK95aT8Ty3a5Iurn7hZauQSfEw6VTHJbc7N9tvdVcuF4jXoA2Q6MGWK7YvBeO+28h6RC5P9aep1MJfu1pH8kMx+jBAz8CD+/fsoDzD74cLqH0sFCVEImG12LyLj5ZLpqAL4B66cmLuUAL1HHqS7OROPAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Knp5avh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JqLQO5zRqaD9D1zDEVy24po9QCWNVhICktX5RsFGi4=;
	b=Knp5avh+Fzc2Ehz5rv0fp2SWyfNe8dAQdUkFY5196vKlM+KbQKd9gcPTdTPWXAE2SLoDN9
	7FQP9tdgQvmW4frE/a48ZFJs+GM8Fyb85yFxwalvU1yCrv+i5g3hVAnsKHf7/7eu9JpNYD
	HMFdZbvBdBcdN1pLecUaRMpMWaxA/X0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-Dwmx9zCBO_qNwGe7_gEFEw-1; Thu,
 29 Aug 2024 12:57:03 -0400
X-MC-Unique: Dwmx9zCBO_qNwGe7_gEFEw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FBF21955D52;
	Thu, 29 Aug 2024 16:56:58 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02D9E1955F21;
	Thu, 29 Aug 2024 16:56:47 +0000 (UTC)
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
Subject: [PATCH v1 01/17] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Thu, 29 Aug 2024 18:56:04 +0200
Message-ID: <20240829165627.2256514-2-david@redhat.com>
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

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b31d4bdd65ad5..3c6270f87bdc3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1071,6 +1071,11 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+static inline unsigned int folio_large_order(const struct folio *folio)
+{
+	return folio->_flags_1 & 0xff;
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1084,7 +1089,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 /**
@@ -1100,7 +1105,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2035,7 +2040,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
@@ -2060,7 +2065,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
-- 
2.46.0


