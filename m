Return-Path: <cgroups+bounces-6770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFEDA4C7A0
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05283A94FB
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646E23F271;
	Mon,  3 Mar 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIetGfiR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24B23F412
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019440; cv=none; b=fnwoQm92pJGPcxgQPMG6LudJzB2pXnaWZK6EtGJQ2/yQSNYIFLP0RwLOYdH7IAIzZeID5l2jNGPCLj8ZjxljOV5OSjPW6Mzp4EtzEmaXs+yLr1IK22QDzr4X9LPK60pOhkZ72ptWnghifqnZQaTih8IVIyd1YEr8J0B7yyxqqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019440; c=relaxed/simple;
	bh=8JZSTfKBKXDMVjBypXt5216219IvKwBRt9fqFMOGvw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btsHMRL13v2rms0JRJqCzByhXKvKNt9rtIvaUnfHPp7DfmQ7MluxsSzcBj0lK4dbrLiuE70yLzEChCgL72l7NkjbUdS8q5aAloRgecxAk8LZoZhrb3P9DXEQxMWq9CjEBtDRWjEiCxrLK0agMTfXWQ8caBBzoMM7MF+kM2bSqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIetGfiR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CNQID9OyUlmGzlaLMJyJN9WCGZqSjZdKvQcCGQkCwE=;
	b=dIetGfiRbae7JZJFcK/I75VsqrMwDxhWgkOh+O5ACmdi2PUaGMQ2VVPI+S1hP2iyo7iPas
	3s3j55RLTpMLKVLKK5Na6+TnMmygWFZNDR1KvNQUzuAbKNh4qBrxVKGSOQ2yJNG7QTo7rj
	94iigBog0XEqahg50U0faWpdsjNHxKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-mwdoJkfDOk-ATKF-LaTt7w-1; Mon, 03 Mar 2025 11:30:31 -0500
X-MC-Unique: mwdoJkfDOk-ATKF-LaTt7w-1
X-Mimecast-MFC-AGG-ID: mwdoJkfDOk-ATKF-LaTt7w_1741019430
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f000e962so1098077f8f.2
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019430; x=1741624230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CNQID9OyUlmGzlaLMJyJN9WCGZqSjZdKvQcCGQkCwE=;
        b=nPBI84tnoPIsDB1Ir/eHNF/6fIaUxBs/6n9zkOc8gsOnX3fYwYLAJ5zrUbLACNwiBH
         ndAxu/sCr8KJqotfmenvqoFAP1Q3+jlFjDNzAEwxb4QCjhBYAvM5jt8ErdpQwsIrkFG+
         rcWwo+8V08lsaBD7biAd3Z1iYTX0A+TOWZ39H8H0zVtMYSKdFdn4M3zDJH276+Kko2+l
         sxwa9b94cZklWoKsB/lWTFK1AJUdK5CDG8T7RXA9MbHhJzIa23LGGIirBZ9obJKU9amt
         Ft3e0mRqCcFf9fUgBhtRgi5XKEv3NGABgrwn3J4sZMdnvtlcNw7aPrAzK3iAgCehqRz6
         xjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQl23jmL/vb6G+f9/zk6kzwaoOFV9YYMW2n9w4wjlGMkYGiMQD8yZ6w7zQOUT6uv1eYpI8QOy4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3u0WUyO3sQo6Yb31IDSdHr64NFIjhXFLFrlRe0erht0aWdG/V
	Z7Tp8YdgV+xl8tk7A15RODg+8c8CI2O4xSxf2U9AdIgcNk1u1/iEI3dshWl9ycw0F+mGP5C4sqG
	nW383/vniUK4VYu/yNdHBOsV/WvsFrDpvAOYWCNg3iU23zUmQvwMCaOA=
X-Gm-Gg: ASbGncs5TQBBG67ds3qRdPGFpYXg8R5QHj95BRUxSm6oHCAzWHXo/PRnVTkaJKAXrPQ
	ONF2LYXbVtqikQazvrHf3D7mQcECXNahUkl2OLEAOi13yjUyaUVnhWO2+2qH6gxgzI+C6aJ5GKK
	syzgBICkBEdaWnjUMFp76ai5F9+hMIVa9GVmSUqE9Y//L1Gspc+WJDCXVeI/c67PfxBS8ACWveY
	iePCcIm5Bv8GKR3OfexZFoxJ+1kwXmBn6Xylrc6UmlJGEJqMwyS3v1jQzxEge/6WBBvP3Sj9He0
	PiC32F4kkrRCm1dmo9I/o7DKZcpsjfLH3Rm6pIro+Qhfr2gyuRB4OT6TxKBYNHft9b/qCO2kas5
	p
X-Received: by 2002:a5d:6da3:0:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-390ec7c67c4mr11859528f8f.6.1741019430378;
        Mon, 03 Mar 2025 08:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRquSNZRyjpwgx3Bpqn4SKjwIglVAovJ799aL6PA2lqrvYWWUmjvtNcaSqxs0FHQnHdYBh0w==
X-Received: by 2002:a5d:6da3:0:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-390ec7c67c4mr11859482f8f.6.1741019430024;
        Mon, 03 Mar 2025 08:30:30 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc4478f70sm23988695e9.0.2025.03.03.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:29 -0800 (PST)
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
Subject: [PATCH v3 06/20] mm: move _entire_mapcount in folio to page[2] on 32bit
Date: Mon,  3 Mar 2025 17:29:59 +0100
Message-ID: <20250303163014.1128035-7-david@redhat.com>
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

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

Ordinary folios only use the entire mapcount with PMD mappings, so
order-1 folios don't apply. Similarly, hugetlb folios are always larger
than order-1, turning the entire mapcount essentially unused for all
order-1 folios. Moving it to order-1 folios will not change anything.

On 32bit, simply check in folio_entire_mapcount() whether we have an
order-1 folio, and return 0 in that case.

Note that THPs on 32bit are not particularly common (and we don't care
too much about performance), but we want to keep it working reliably,
because likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", the 32bit specifics will go
away again; even small folios could then have a pincount.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  3 ++-
 mm/internal.h            |  5 +++--
 mm/page_alloc.c          | 12 ++++++++----
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c1414491c0de2..53dd4f99fdabc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1333,6 +1333,8 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 static inline int folio_entire_mapcount(const struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio_large_order(folio) == 1))
+		return 0;
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 31f466d8485bc..c83dd2f1ee25e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -385,9 +385,9 @@ struct folio {
 			union {
 				struct {
 					atomic_t _large_mapcount;
-					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
 #ifdef CONFIG_64BIT
+					atomic_t _entire_mapcount;
 					atomic_t _pincount;
 #endif /* CONFIG_64BIT */
 				};
@@ -409,6 +409,7 @@ struct folio {
 	/* public: */
 			struct list_head _deferred_list;
 #ifndef CONFIG_64BIT
+			atomic_t _entire_mapcount;
 			atomic_t _pincount;
 #endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
diff --git a/mm/internal.h b/mm/internal.h
index 378464246f259..9860e65ffc945 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -719,10 +719,11 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
-	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1) {
 		atomic_set(&folio->_pincount, 0);
+		atomic_set(&folio->_entire_mapcount, -1);
+	}
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 594a552c735cd..b0739baf7b07f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -951,10 +951,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 	switch (page - head_page) {
 	case 1:
 		/* the first tail page: these may be in place of ->mapping */
-		if (unlikely(folio_entire_mapcount(folio))) {
-			bad_page(page, "nonzero entire_mapcount");
-			goto out;
-		}
 		if (unlikely(folio_large_mapcount(folio))) {
 			bad_page(page, "nonzero large_mapcount");
 			goto out;
@@ -964,6 +960,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
+				bad_page(page, "nonzero entire_mapcount");
+				goto out;
+			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
@@ -977,6 +977,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
+				bad_page(page, "nonzero entire_mapcount");
+				goto out;
+			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
-- 
2.48.1


