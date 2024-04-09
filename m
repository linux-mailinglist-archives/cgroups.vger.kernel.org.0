Return-Path: <cgroups+bounces-2406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8184689E384
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 21:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD24B2414B
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57815749E;
	Tue,  9 Apr 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/Ddhfer"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78803157A4A
	for <cgroups@vger.kernel.org>; Tue,  9 Apr 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690794; cv=none; b=fxnUgWYRmLsJVTqBy8r+vMJsrbIYzh++uoPnHIsc/mKLxvS8LCQDNeizKQ0IsMEaHXcJycP4IFCQ7rv7YcHcE24mZApYXvj4NJEFpPVhFuPRD83lWT8TH4dQyY666yi8JhpL4h5jjL+HY5uZLlYQOaKaLstgA9uFDQhWtN5xU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690794; c=relaxed/simple;
	bh=nXBxw9Nb3AKmpwNJSf0KetfSq5IM5scHwHyH6e628A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv6nTtZnQFgBrJxhJ+0qH7df6ss/jPM9E23Tsq7aj3t9xbtTNPYi8n6dmuIqU97ILoQQyJqYVUyCjZrw3g+eFKaqhrvy0DeMlSoEfgkTMEzQeE+9hd/yBvNx0//oHSEUien6REhSSbLb5UVGU1Ojme/LPWS3Egs6piELbGsupVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/Ddhfer; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NywHbuKGZjP8K2r9cm/m6NcEBx0o+/6jkDGUacCW2cY=;
	b=W/Ddhferi9MtfZkSEawsa9pVEB1fb+YFeMUrLXjGuBZwdYsfPNHyk/2XpjiupyKvQ5kdKT
	WUWjjfNn7yxRfU7OZkl6yHr4Lm50Zt6P6VyvVRXquXHV/Wv1l5OkoR0y994e+Lb4wG+vmd
	yp5LS5uvhjJfrTRHY2P5L0P3wxjcreM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-RFd2M04MNAeCUlOs7BBABg-1; Tue,
 09 Apr 2024 15:26:29 -0400
X-MC-Unique: RFd2M04MNAeCUlOs7BBABg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F246E1C0512F;
	Tue,  9 Apr 2024 19:26:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D11840B497B;
	Tue,  9 Apr 2024 19:26:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 15/18] trace/events/page_ref: trace the raw page mapcount value
Date: Tue,  9 Apr 2024 21:22:58 +0200
Message-ID: <20240409192301.907377-16-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary. We already trace raw page->refcount, raw page->flags
and raw page->mapping, and don't involve any folios. Let's also trace the
raw mapcount value that does not consider the entire mapcount of large
folios, and we don't add "1" to it.

When dealing with typed folios, this makes a lot more sense. ... and
it's for debugging purposes only either way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/trace/events/page_ref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 8a99c1cd417b..fe33a255b7d0 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -30,7 +30,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->pfn = page_to_pfn(page);
 		__entry->flags = page->flags;
 		__entry->count = page_ref_count(page);
-		__entry->mapcount = page_mapcount(page);
+		__entry->mapcount = atomic_read(&page->_mapcount);
 		__entry->mapping = page->mapping;
 		__entry->mt = get_pageblock_migratetype(page);
 		__entry->val = v;
@@ -79,7 +79,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 		__entry->pfn = page_to_pfn(page);
 		__entry->flags = page->flags;
 		__entry->count = page_ref_count(page);
-		__entry->mapcount = page_mapcount(page);
+		__entry->mapcount = atomic_read(&page->_mapcount);
 		__entry->mapping = page->mapping;
 		__entry->mt = get_pageblock_migratetype(page);
 		__entry->val = v;
-- 
2.44.0


