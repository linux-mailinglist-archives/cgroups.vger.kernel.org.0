Return-Path: <cgroups+bounces-6767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9468A4C75B
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A9E161D2F
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1FA21858A;
	Mon,  3 Mar 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXwftifd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8A23AE82
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019434; cv=none; b=CRiUbLwtLDShMcBGFvjz2WreYcv1sK0C8jYPo5/XrYtRqszINx+Ww8jfX8dTusjO3dsxJ77UYk/SyZwqHQaViLItvfQ+bVGMQdnN8Pv781yD8LMNSzeMHYPX04uurCo5MyUSTOS6iefgYKZKbtCrkKZHoHwkMcaIrubidCiase8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019434; c=relaxed/simple;
	bh=3SmHXztWFIDnuQM+XInecxapotD7TtFOOmhMRtX7whw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKRQRwBeDfykT1dgA8gtQuZBOsrvOtTeDPfj14ZO/BqghZlU3NWT+2FJkvQvgWFbgyWFARLYXdJbk+iVhQmos7QmGqu0HNF3iiY+sPGM9B42CArZwXUg2uhBaxCT/2/dKSu0/HSh3oKdHyADX6TvEPmDaWnDO+1XMKDYsI4HaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXwftifd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
	b=eXwftifdqjtXNg4rOosVq/AAR0tK7Q6JW55pwiPE2GZHNgvCsjdWqUiRVIRsf+kiimxae0
	VurMgcI9XGnsqHPAsuyk4ylfTV98noAJkfvT0dqBXhxDtT+AXLMaa/SJIoeIRtaCk2X7fj
	PK3H2CAhxZA71MR25fnB/3oaWZUv33Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-8FlBZ3B8OsuNx6Lr87Q1hQ-1; Mon, 03 Mar 2025 11:30:20 -0500
X-MC-Unique: 8FlBZ3B8OsuNx6Lr87Q1hQ-1
X-Mimecast-MFC-AGG-ID: 8FlBZ3B8OsuNx6Lr87Q1hQ_1741019419
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so24206315e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019419; x=1741624219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
        b=jgANgKvxeZ8v80SkH9cVwxcp9F93Lj1XK/Pt+gIHkBUQb0faSIyhFxwZCjhGn2HJeC
         CE0Ai/q3vpCY2SzpNxEmKKF6ieRr/o1roaw1oOfMgDkRdprriKnzPbnlEUJcKbcFnWYm
         tRro/EQm6a4HCwgsbLC14b1n+bXr+LAu2sFMA4FmU95FlVFBWguGGQHSWiju0qJjNpeY
         f7wQvArivpAe0B6HaLcWaiXypc8eLw+wk6Yj6wxLkqQuZ3yxznMsdLN4GXJQreR2C4a4
         B0N3OJZKjj0gSV8ZxS8EORqlpaYXv4vNJFhUTqf48nn3HJL/ymd1euCfUy+CAcRXu26R
         k6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXieaGZQ+RnetkRpFPIH3D4hmOslzaJKhgWwBWQvB3OIw6R/3l5CBeRTflaXK7jP1ZXraLhLUC2@vger.kernel.org
X-Gm-Message-State: AOJu0YzPp07GwtWvz023IxL2nC0baMyDidE4XeXGmhKSpoGIKLmTfUiK
	pkaYh6V1a59SxNrLfkE0M9jgqWxhE7E2xc1vdOfxpkhRG5YFcN7SIM3s7w/+p1WZ6YpeTpEEeSH
	eabaAhC8WvR41hvn5QbHMitqFlX8mfow0nNjuyFj8LahoDlryAOL4DoA=
X-Gm-Gg: ASbGncvoVlFpXYRIB9Kcb6DoMp8/I5xPWFwgZe/jFfLA3Wd0h8kYGADfG4xHYfdoU7g
	Y3PHwXW67QHGEF5nNqyuV8M4asjZUQE9B9/Xa7uQkwngVeAd/h5tZBF/+Xq0/mzhM64GB2GY/Gh
	Kw2dWLstkGStiV9/5hLK0sIGsHn4yAhH4qm0MHHIyE0qHe4oZbhJDj8md96rf6KDQKyXfrV5WNd
	/XbIO8keX8CqbiEqBpq+egi9eagIe8MIr6fVJxOzaG801FQR8deGyLG+MH6ON11vVJ0fViSvT7p
	DHee/H4jpTG0PpHpiUTtUdNoCIRrwy1GFR4Y4Fl8czq5eeA2WtoZ+22tBFXw2XpKIezxHJuLxHG
	D
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547289f8f.13.1741019419256;
        Mon, 03 Mar 2025 08:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzBd/+KVXhEWpKLy7bok4As8+LKdGdnCV2QCwLiXkX4QDGRFFrxDGOYHa7Hz+LJLKECZ5dQ==
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547256f8f.13.1741019418889;
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a6a5esm15196816f8f.35.2025.03.03.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
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
	Lance Yang <ioworker0@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 01/20] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Mon,  3 Mar 2025 17:29:54 +0100
Message-ID: <20250303163014.1128035-2-david@redhat.com>
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

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

Maybe in the future we'll have the order readily available for small and
large folios; in that case, folio_large_order() would simply translate to
folio_order().

Reviewed-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b21b48627b05..b2903bc705997 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1194,6 +1194,11 @@ struct inode;
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
+static inline unsigned int folio_large_order(const struct folio *folio)
+{
+	return folio->_flags_1 & 0xff;
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1207,7 +1212,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 /**
@@ -1223,7 +1228,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2139,7 +2144,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
@@ -2164,7 +2169,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
-- 
2.48.1


