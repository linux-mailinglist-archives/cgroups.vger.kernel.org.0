Return-Path: <cgroups+bounces-6670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C4A428BF
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCD17CFCC
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F075267384;
	Mon, 24 Feb 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C96mrv11"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C3266EE2
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416195; cv=none; b=XODJXDaNpZzWTe8zg/d65BmEvVlfLsYrRj24+3LBoYSTuNaril8XayOnxY5hqvQxZ41oHQBeF+VBOv8Cj6Tfxj9XeBshAEREr8bzGtiQeK12/eXMm37ToibxTLfcYKxB4huo/TkkRnwri0cZe9jB5IVNmXEwLUmTnJt1tVzsPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416195; c=relaxed/simple;
	bh=RlWl3fpiF9O9sdm/iMb9TRR2Zh30yDuqbmqk7QeHHkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7tA+K/JFiIJCaM0I4riQLZHq/iowRuHYNJ4hJ1FzXDZyDyem5qAXNSjTyQu2YeEa8JCwtEj+ZnXqYOoJ9DQPuyoPyQx+aUxvZbBRfdInVgb08sY+NxbUmo/rZ+GIi1dgRHDnH5kp2FdNPoToz0Ux+zANlaJZaUyaQey5zanq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C96mrv11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqnqolcXMjdbgOoHxDkquZtgq0jreZJuwmbRkc4obqU=;
	b=C96mrv11VU1w+OFNr9HTCPEH4tOUM1aRqjCgQ7ZiiLVGKD3QjW+SS0rKErAjmFvmpcjCqW
	GDELqCMH6R7E9zKm05iMYveNN4KvaqpfXkqFDTcRROTTXfZFKkROeSvbOmG9dwCcxfwKTp
	NAjM4p8SxRIAmzm+XfsJgbNG8NfG0gQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-nbjovzCzMS-H1437emsHpQ-1; Mon, 24 Feb 2025 11:56:29 -0500
X-MC-Unique: nbjovzCzMS-H1437emsHpQ-1
X-Mimecast-MFC-AGG-ID: nbjovzCzMS-H1437emsHpQ_1740416188
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f4bf0d5faso2472269f8f.0
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 08:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416188; x=1741020988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqnqolcXMjdbgOoHxDkquZtgq0jreZJuwmbRkc4obqU=;
        b=PIMZEMig2AKbbaX27oMusoq/MjtfB9FX6N0822sALPipSafLuGHHLiKonBHAJvHN6h
         7+iJi2Rre95GfI333WS6CJy7AT+jvumvBPSgnLN8vG3oNPs0Vm2qBiTmT84+WGUyzb4I
         lf3GAP6x7LeaURsTuBUIsQIsRqTmAacTwyAe1VPeGsNdnIv55NgNHAjZeIXjX/eDjEy8
         ruUmV333dPTuFpu3ObJHaYPz2xvNRr/NGMS1GCC6tK01Q1pavZ2TNCmMnTDRvPZzsn54
         q091jQPAYsotDBpSGYDniB7gT7WpsRvhNYPBd6C6m029qTJEDGO2i6kAX/bPazwkbyAO
         KSSg==
X-Forwarded-Encrypted: i=1; AJvYcCXoWSPSrqNF8pcFoVeoM9qHKp71FPc/j5Pl2r1AJYchG415/CaPQNI82PjE4tCvieXQboZ0Tuco@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TMuZ6HY+kfXXVD//GUHTeSNCNQCM9oU7zf3Fa1glH8oI6n3r
	s4D7exy3slW8DyQxruPmoJrIeGP10GeSW1QmWXNWjRfPieuUR7rY0x8R7mDCISelm0kYuVl+jR5
	UF8jSzIOIK2Z5DCA6AqXlL5Q7mDx+wctJ6ZhnSr+SWrR02bi1nMf0VAU=
X-Gm-Gg: ASbGnctfP/TkveIOO8nYHeBA+yser0CDhUy3mWGbCVnxLpPA8+QcIVRPXPBz49FWP3h
	x+OAWObLJv60ph0FdD7TSuYfoABFr1iWkGLri39QwR7NCHDgJgMoEY2FjlzOw11lM9QaS2cetVT
	Qb/M9GBJxL9e+CkrmIIZT5W4ch7smvCvmigznPShxEvc1ipRnnHkPHj0rdzC29bw7Wu130r+dhc
	dxgm5Tb/ROPlKueiWWEj4JRcWhiE4sR3PS81xOe0gpEU9ehKxOKjIEpwpmzrm5J9KYO5HXREUDN
	SW+ofeRkv7JKphy6Rx7kuOKxKoieNhYL+5tCMAED2Q==
X-Received: by 2002:adf:e50d:0:b0:38f:2f9f:5249 with SMTP id ffacd0b85a97d-38f6e95b1acmr9525763f8f.19.1740416188301;
        Mon, 24 Feb 2025 08:56:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFpYW1I6Rdgq9wh83UDsQAXL1XjDcZxKn17wlosPtiSthbm9EkXmkPxjrqhOMZ4wG7mJ1LrA==
X-Received: by 2002:adf:e50d:0:b0:38f:2f9f:5249 with SMTP id ffacd0b85a97d-38f6e95b1acmr9525729f8f.19.1740416187961;
        Mon, 24 Feb 2025 08:56:27 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f8121sm31621063f8f.88.2025.02.24.08.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:27 -0800 (PST)
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
Subject: [PATCH v2 11/20] mm/rmap: use folio_large_nr_pages() in add/remove functions
Date: Mon, 24 Feb 2025 17:55:53 +0100
Message-ID: <20250224165603.1434404-12-david@redhat.com>
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

Let's just use the "large" variant in code where we are sure that we
have a large folio in our hands: this way we are sure that we don't
perform any unnecessary "large" checks.

While at it, convert the VM_BUG_ON_VMA to a VM_WARN_ON_ONCE.

Maybe in the future there will not be a difference in that regard
between large and small folios; in that case, unifying the handling again
will be easy. E.g., folio_large_nr_pages() will simply translate to
folio_nr_pages() until we replace all instances.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 08846b7eced60..c9922928616ee 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1274,7 +1274,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				nr_pages = folio_nr_pages(folio);
+				nr_pages = folio_large_nr_pages(folio);
 				/*
 				 * We only track PMD mappings of PMD-sized
 				 * folios separately.
@@ -1522,14 +1522,11 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
 void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
-	const int nr = folio_nr_pages(folio);
 	const bool exclusive = flags & RMAP_EXCLUSIVE;
-	int nr_pmdmapped = 0;
+	int nr = 1, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio);
-	VM_BUG_ON_VMA(address < vma->vm_start ||
-			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 
 	/*
 	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
@@ -1547,6 +1544,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	} else if (!folio_test_pmd_mappable(folio)) {
 		int i;
 
+		nr = folio_large_nr_pages(folio);
 		for (i = 0; i < nr; i++) {
 			struct page *page = folio_page(folio, i);
 
@@ -1559,6 +1557,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
+		nr = folio_large_nr_pages(folio);
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		folio_set_large_mapcount(folio, 1, vma);
@@ -1568,6 +1567,9 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		nr_pmdmapped = nr;
 	}
 
+	VM_WARN_ON_ONCE(address < vma->vm_start ||
+			address + (nr << PAGE_SHIFT) > vma->vm_end);
+
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
@@ -1681,7 +1683,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pages = folio_nr_pages(folio);
+				nr_pages = folio_large_nr_pages(folio);
 				if (level == RMAP_LEVEL_PMD)
 					nr_pmdmapped = nr_pages;
 				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
-- 
2.48.1


