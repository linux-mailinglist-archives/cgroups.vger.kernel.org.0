Return-Path: <cgroups+bounces-10735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351BDBD9E7F
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB76192295B
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4943314B95;
	Tue, 14 Oct 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmHUBqwK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96969314A8E
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450949; cv=none; b=M5QGO0sNOv4qM8v3X7CAVCaMK1WMcUZV97N1+wcHnA43Fhze90OR+HEQ0EG4uw58neAMpgBvkkWJo7YcA3XuTxWZbM9aoJGU1PljWj3VldOzPNMhM69epro11I8R6TddhvrN631Hv/oQxFvki1+YrVASD21gHcILLBexPiqFtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450949; c=relaxed/simple;
	bh=PBU4fhmS7xNaU4hsexHHxQh75ZgP+S8EWiuxCN5cjGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/8OiNuhzSx00WKt8NGcKSgdUylGw4baQvOd1d0jssH3ZpgUwK69o/ldNZ4703psX3eWj4A6vCl6jBTEwlibE+mh3rWS8wWIlaMR2QgyHZmyr6tpIKWxbw/7htqJiafGMNVJ6hTrEGqA4ioafTOAg3PB0/CRPwW5jnwbb/LJo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmHUBqwK; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760450944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HTt/KzKieiee5hMQF+Yl+hZuVbxPhLlk+WHV6D9guo8=;
	b=qmHUBqwKWNT5vYFudzOiUF4zcASTLZYuSKIEBYKIYVECM3evlnYbwtVC8+wujvSBGhkRvY
	OyuizPA56TwSUlr7qmo4GZLrjp3R+5oetCgXTIS7kckygImIJsFsBocWRNnvc2skNg4ZEq
	Ug6JIGrNsyZQALcEojvwDxh6J+Z7bGw=
From: Hao Ge <hao.ge@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] slab: Add check for memcg_data's upper bits in folio_memcg_kmem
Date: Tue, 14 Oct 2025 22:08:15 +0800
Message-Id: <20251014140815.383823-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

This is because OBJEXTS_ALLOC_FAIL and OBJEXTS_ALLOC_FAIL currently share
the same bit position. Therefore, we cannot simply determine whether
memcg_data still points to the slabobj_ext vector by checking
folio->memcg_data & MEMCG_DATA_OBJEXTS.

We can distinguish between these two cases by checking whether the upper
bits set:

1) MEMCG_DATA_OBJEXTS is set, but upper bits are not set,
   so it should mean obj_exts allocation failed (OBJEXTS_ALLOC_FAIL),
   thus do not report error, or

2) MEMCG_DATA_OBJEXTS is set, and upper bits are also set, so someone
   did not clear a valid folio->memcg_data before freeing the folio
   (report error).

So let's add check for memcg_data's upper bits in folio_memcg_kmem.

Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Per Vlastimil and Harry's suggestion, instead of introducing a new bit,
    implement this by checking if the highest bit is set.
    Many thanks to Vlastimil and Harry.
---
 include/linux/memcontrol.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..f9f7ba14be04 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
+	VM_BUG_ON_FOLIO((folio->memcg_data & MEMCG_DATA_OBJEXTS) &&
+			(folio->memcg_data & ~(ULONG_MAX >> 1)),
+			folio);
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
-- 
2.25.1


