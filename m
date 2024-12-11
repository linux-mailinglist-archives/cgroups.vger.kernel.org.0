Return-Path: <cgroups+bounces-5792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF89EC403
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 05:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7191684F7
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15EB1C07F3;
	Wed, 11 Dec 2024 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EDZWvep3"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EB1C07E5;
	Wed, 11 Dec 2024 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891581; cv=none; b=QCCb+ZsDr+JBXTotYmgAmxKsnEat4qpNwPgP3C+JgIjJG+UsgQrYQDy4G7+w3breUM+s2KFk8mC50hO7fOlsdqx0Vd3uPONScnvmTGf+iJE+4kfgo9B3EWbTOSDZUQnXSO/9ob4kT+UB5XWEiWJXygDbovOpOZ7jC/+SF38GgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891581; c=relaxed/simple;
	bh=e6UWtCinHeIICkjQN7g/iZ67VT2oKWM1jkAmKwWxW+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaU+SnIVJiyEHUhVfpECCJQWUm2gCZiOi4XbefXW3KgTY8djvEzAwEEa/6DCAafTzTC0bN4FJj2yur84zFE62QgPxyytoXvYDvRdikmUPKAyYJaTh0beqQRc/CUQnpvekMXPlcGfnk8Ku32K/WcKIlEMbaJEl9XjEMQpHylQwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EDZWvep3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=lJ3CGzKytUYmJ3F2enw41nIOea2qq4EU4o9MW/pKz3I=; b=EDZWvep3NFgLMs6GvSouLTYmC6
	W1UxA0/qNxUbipKzXswAFHMdDk/fzN/UiG14Er/MgKU1bghr6WJPHVljX67WaTQ+TtRN0G/xSRbBn
	KjNn7zKPSKgnOutqBT4awHa89PW25cw5TXeJPDJQrfYzR7NiG/6UIexAPrqxvGNUOqeG96TbHvLEK
	rDYlUo5x6L8EDleYYrNSPBjzlV74s1NhF+hh1aQN3TQL2ckwPbNIT6NFIZmY4+K3rcrky2Iz/Ijle
	MjVYgRc2aASpL9ETyOCHTdZ4kTtr5DZx/T/5mxSQvaqaMEGkLeZrUIzsDij0qavK9JtZl1h4isiS8
	d79Mt7ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLEP7-0000000DpR4-17Cr;
	Wed, 11 Dec 2024 04:32:53 +0000
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
Subject: [PATCH 1/2] vmalloc: Fix accounting of VmallocUsed with i915
Date: Wed, 11 Dec 2024 04:32:49 +0000
Message-ID: <20241211043252.3295947-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
i915 driver), we will decrement nr_vmalloc_pages in vfree() without ever
incrementing it.  Check the flag before decrementing the counter.

Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f009b21705c1..bc9c91f3b373 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3382,7 +3382,8 @@ void vfree(const void *addr)
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


