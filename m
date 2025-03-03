Return-Path: <cgroups+bounces-6772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26867A4C7EA
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE8E7A6E15
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F4324E4A6;
	Mon,  3 Mar 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTZ06RUb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14E24CED6
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019450; cv=none; b=tYJm/sGPDuTMmFLptvdSF6mHghHR8vhlrnQ2C6Od2LuVsXjEgxJlvpV+7BHWZd6ThxUUnWOAeJQK5KjJSs20SbnWwsgSyVI8yzxGLEvjitGbUxSoJ4u1PBl0cEZN3ltT0FESdybF4jwJ4iJGZJLrYhIYzqNwwkrlWFTkaIkKj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019450; c=relaxed/simple;
	bh=jBMc/6KfiUuhsqx8U3JCMjpv5FKb+tGdfD4lU0RajKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8xt9pdCtooWn57NS2BMJmdC+fofLe8573U2MvSNmonVI8byi7RWC5eo1rgVLNurAj4/NepYloFXe40J7vLds7kC5DRVjpJe+L0SKmCqcURHIi5/x9kemGZyfdxEP+YYoJAqCRPWdXBGORChlCP/LVdnRd3aIJWyfPxf9K6+OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTZ06RUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
	b=fTZ06RUb6fwTRp6oS5vFzEB52lvEgMxR0hsHNw9TTtPWWPzT3QYDsAmuFB8wGFsxO6VOrg
	EusBotGzWg75iGxJgTNXjogKB0b+YXva5J7FcjQwqmXOLZlc5bc2EALpEIlWiq0cF3M4ac
	HA1upbr7Hma/pE56lEFQM4wMv+aUW3s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-wA2NSlGeNLK_5z4a12v4gA-1; Mon, 03 Mar 2025 11:30:36 -0500
X-MC-Unique: wA2NSlGeNLK_5z4a12v4gA-1
X-Mimecast-MFC-AGG-ID: wA2NSlGeNLK_5z4a12v4gA_1741019435
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43aafafe6b7so33248055e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019435; x=1741624235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
        b=RmaSRFEAT+UDWVZVAY/+EQMV0AkpwB7AuaHXLPahg9UwPqcdG2/ep9ghcus0Gw9SVa
         TGRrFXwZyi0STqdfc0oGiujJjBhn1uJfrc+qYfw54h3/E1iFwM3uUT8Yn+dsl7SV3v7o
         R6xopbGytXCQaPEIZ9o/2DWkTVRPb2tFxey1k+AhTKb/LTxj+VMpBB9iwy1fobMBClSP
         dkkmapA4/6GbSbp0SHoncbr0NE/8XtbHsOpB+RdpnahVVMJgpOBZT1TZ8gWnhwMXRsrK
         NM5RyRyik4DSisrVzt6bDDYeSsLsJXTY7XQf/Eg9TPyjyXp+EZBEINYZCQKQR/R8UBLh
         7kSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa1tNKik/caFEXyTZAtxLfw6TXM2+TIjPjr9OGbEtY1mhg+IWvYaYUJRx+ABeIGlyWtuJzf89y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/VwV9HNoJ5LPCVAzOWxZQ2crKag/SYUqmRbg87lRGN3h8tgV
	0oOWmUYPSp7WMt/xiQOh3UcKqAvhfFqAlb3Y7HVV/OQz6/xFCENisFEJx2xNBNs6FFM10dTt/UL
	MppX38C7k2GHuirEic+6KkH0DXmIUYIr0/uSpVs7AkGCICDmXdvViIaM=
X-Gm-Gg: ASbGncsg+7uMyRlCJUXX4ZasV7kzrMXi7uwvuePKr21ZWuM6ekGtLfNWt+L60zWFbiD
	eI4RMkIVEKpZF9++UaOwriWx82v3n0rPjms7fAGsI+BYxjGp9kWrzZp0cvG1W6T109oajeF01K1
	RPDT37CuciIWCrY5Vwe2MlHQQ9WKAiEeqlltEXNH6h4ra4rVadgQiVwhmjHHfGWsuMG/t1YkqHm
	mMwtH23mrkIhCRSjsREGGyuOHEjZMT9H3UIcOPp1yIADbWcjH5P/ocGSM2GRuURhZrYyDGz0DIT
	BSW3RptFTE7cE16RGKtTe8CrA0eaF+u8Zt6DPHDyr8K0tGd+55R/gWzBx01+8Zf97VilH2wApz5
	S
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-43ba6710a51mr128366315e9.17.1741019435400;
        Mon, 03 Mar 2025 08:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHH2uqcGG6+HqLvILt026VDKtCx0hMTXydneDmvGOTb2RHDZET1RLo/ABtW5TIvoZEd6mWJw==
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-43ba6710a51mr128365725e9.17.1741019434989;
        Mon, 03 Mar 2025 08:30:34 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc63877desm18077035e9.1.2025.03.03.08.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:33 -0800 (PST)
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
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 08/20] mm/rmap: pass vma to __folio_add_rmap()
Date: Mon,  3 Mar 2025 17:30:01 +0100
Message-ID: <20250303163014.1128035-9-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need access to the destination MM when modifying the mapcount
large folios next. So pass in the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bcec8677f68df..8a7d023b02e0c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1242,8 +1242,8 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 }
 
 static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum rmap_level level,
-		int *nr_pmdmapped)
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_level level, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	const int orig_nr_pages = nr_pages;
@@ -1411,7 +1411,7 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 
 	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
@@ -1582,7 +1582,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
-- 
2.48.1


