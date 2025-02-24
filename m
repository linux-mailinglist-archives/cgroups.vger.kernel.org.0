Return-Path: <cgroups+bounces-6661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2C0A42876
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 17:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C045166643
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62734263F26;
	Mon, 24 Feb 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajrnV068"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4772641D4
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416175; cv=none; b=ViLMt27popnj/LftZKtVHPAfwWrpdKx127n1j/Jxwqx/sq1ydPzcVo3GwJmjTH8rf+0Eny5+cmDyToF5uVofiGX1iP+6oeoJCEkk0GSGOwUzlLZeeGmFPO7AyirKhyY2xyEnINkAmQD21RSKXuCDbyd8JHVmvAh2uZgu8LvvfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416175; c=relaxed/simple;
	bh=+NZ/1EFzSZLxmiTEzceGSJVCP7MjSwgxhuOimjZWqPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAXMcbHSR4wsrifPeh4nH4zI4lXgrn+RvUgCNrPrYwgjoe6U3dUIVzWwnBJ92ma3YROlIBJTNIEBDXnfYqzBkn5lrT7zcnV0MHK7ScV234z1VN7XM38iArqy1MTY6CnxyCYJobsF1xT+ThB4jiWLBH3jA28YyuYo9IBwvxSD3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajrnV068; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW/SnbGZfnRd/ZrL3KWYJ9GZqWtDH7XgQk5JORWTALU=;
	b=ajrnV068IOCawFF2zNofKPpLZ1n0My0iToY73M8Ho7ZX+GWpl2+0rym8Ys1penVewyyqcd
	1p2kx2Erc6U5nHxNae+bzOLxJx6DNXOGuD5C7l2veq5BFmXGE39HTxN/Txg7v9AJuhrRzb
	cO9JitTvAPRA2IXFoSRRplgQsaTT9a8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-b_g4topGNhGc6cy85SYonw-1; Mon, 24 Feb 2025 11:56:11 -0500
X-MC-Unique: b_g4topGNhGc6cy85SYonw-1
X-Mimecast-MFC-AGG-ID: b_g4topGNhGc6cy85SYonw_1740416170
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so19851585e9.3
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 08:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416170; x=1741020970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uW/SnbGZfnRd/ZrL3KWYJ9GZqWtDH7XgQk5JORWTALU=;
        b=JGgt30O9zZjGrZPPit26FRQnPJZXxptnfum71wDwqdYM4fCc4cn3mAHdkrUjYCOLpn
         gOuj5un7j6P5SvDYZcPu6a0ro/Fwc5RgRGBvS/ELWF9Zc1mrO6kF+m8T+YO1sOp43YR7
         EsdwjDfEFm0uyknjm4cFTYiVhaswTk3FN9HVX8TAVEJYcV/Ss9WKZoGY7/hd4EEI0Vwn
         sg2ZYq25JhnrO11S6/eBJL3SoVeUFZM5PySv+wnpl/LC6wsT9anqtJErDje1TB0CBtUw
         oEOj2RzzSB4WX3BHUuUMPqcvxs3glYiC52b7jE1OpUXxtEHyxtENoilmjQbUl3hcIWej
         rDsA==
X-Forwarded-Encrypted: i=1; AJvYcCXWTdDMqr5cBgWa/dlid+mnP9XtzuWhphapRqUg9XQlaloNhtLZfpxjV9J+xpDFR56HGrx85FaW@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoPHk8H01dzFbD3RFeeTVcST/EG3ixOvGqG4z7ICIkrvl/YKM
	ZGdfwXU4+GBkuSugEpg+LNHthcJ7UfCL00qgkRxCUZfAolfww9UaPIvxkHGFXO6LrrGOqSpQsAK
	oLzeLnGikj/jTEUrqNxqclxghbF1S53XigvLrQvjUqMDcNqeisGYB1Kg=
X-Gm-Gg: ASbGnct87Qilf/XLAlT3fva/UqFg/RYfp+s69NjG8MGUrbzH7W7Lw78HyMuGa6sxDLn
	Rg4WKozSDGWMlC5qLYODI78IVBBxlxnW4TZxjz5+x7wHEX+T93/AU4u1J3SKrUwFvGLtwPqfNsz
	m3Li4YzkbqxellnwEvOivrbvNjGo1MrEMuImtYu+9jIebF2jzvq2i32f8egkUXk4oL+gCa9tsgB
	rAwPElx67gajsDvQ9eksCMXqKKLLFOAKDMGiu3t465W06ozeYOdoaJyJpSsxaQ8Pme6VIysaKOc
	zqPfQ1a2CLSDHC/+ZFmzMO/Uuxs64I6oy0vmyTekTA==
X-Received: by 2002:a05:600c:34c2:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439aecf1426mr121409215e9.17.1740416169802;
        Mon, 24 Feb 2025 08:56:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMOxvVak9cDaBV2o8+q98fYh3JQOIg7zVYXNoNjPQAK1ZeuqEa4rOOZBLfaDjBIQaJ00l68A==
X-Received: by 2002:a05:600c:34c2:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439aecf1426mr121408975e9.17.1740416169419;
        Mon, 24 Feb 2025 08:56:09 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b02f3eaesm111237045e9.24.2025.02.24.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:08 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 02/20] mm: factor out large folio handling from folio_nr_pages() into folio_large_nr_pages()
Date: Mon, 24 Feb 2025 17:55:44 +0100
Message-ID: <20250224165603.1434404-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

While at it, let's consistently return a "long" value from all these
similar functions. Note that we cannot use "unsigned int" (even though
_folio_nr_pages is of that type), because it would break some callers
that do stuff like "-folio_nr_pages()". Both "int" or "unsigned long"
would work as well.

Maybe in the future we'll have the nr_pages readily available for all
large folios, maybe even for small folios, or maybe for none.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d00214e22a174..7c5a8fd29cfcd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1199,6 +1199,18 @@ static inline unsigned int folio_large_order(const struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
+#ifdef CONFIG_64BIT
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+	return folio->_folio_nr_pages;
+}
+#else
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+	return 1L << folio_large_order(folio);
+}
+#endif
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -2141,11 +2153,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
@@ -2160,24 +2168,20 @@ static inline long folio_nr_pages(const struct folio *folio)
  * page.  compound_nr() can be called on a tail page, and is defined to
  * return 1 in that case.
  */
-static inline unsigned long compound_nr(struct page *page)
+static inline long compound_nr(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /**
  * thp_nr_pages - The number of regular pages in this huge page.
  * @page: The head page of a huge page.
  */
-static inline int thp_nr_pages(struct page *page)
+static inline long thp_nr_pages(struct page *page)
 {
 	return folio_nr_pages((struct folio *)page);
 }
-- 
2.48.1


