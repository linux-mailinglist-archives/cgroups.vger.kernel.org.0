Return-Path: <cgroups+bounces-10742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C73BDA70F
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 17:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85610545D0B
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C013A8F7;
	Tue, 14 Oct 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gN/wTTWG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF762877E3
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455720; cv=none; b=Wpv0KlU//D1s6v2sFuxYPijnZzfY/K8/kJmtl/cmYxvoz02JPBjEC3iRsgILaSmVBEymlEtLsk79Q1FgW1/wh1rNAWHiHOeLOphCJfLQ28KulX6Juw+21mX8CEENTrlh/IIYDzKuhdN3MXlybO5FMx69SnYDFlEaKoSLTbAb1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455720; c=relaxed/simple;
	bh=sseQkxVw01RGGymMZQnYe0MAonlReqfHRFNRr3ke7iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hifh3xco4+NchZyABENwilUYH6puKbG/yShhvRJJCMa87rejNqjyCmxW7qVzsiG1S1RySRb6XiKkBBXhlFyXxEA71K5DHO641LMqkdEEN27Ij35kyP1jbOzY5t66nWb31ptI8YoqTEGao8pL4xpV31eRNCTbhy/1qGtLjzsAVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gN/wTTWG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760455715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3LfrRntdqnp7+Z8riKYEbqCkp0MkSxiqZIXsXw6PRKU=;
	b=gN/wTTWGL9N/luOOdsW4j68R1OpjZ71pxwaSmzY8QKH20jAP2ifGFglkGhFL6+YRWzzyRp
	YzuTakDCxjxTj+eMz/WOaxFF0o370GIkCcjAxMNpXDhJeA0Nlsc3syciZ9KNI5IEZzd4++
	BbDLfbsATBqqetEgJ2hse9wRlW17Hzw=
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
Subject: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem
Date: Tue, 14 Oct 2025 23:27:51 +0800
Message-Id: <20251014152751.499376-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
the same bit position, we cannot determine whether memcg_data still
points to the slabobj_ext vector simply by checking
folio->memcg_data & MEMCG_DATA_OBJEXTS.

If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
and during the release of the associated folio, the BUG check is triggered
because it was mistakenly assumed that a valid folio->memcg_data
was not cleared before freeing the folio.

So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.

Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v3: Simplify the solution, per Harry's suggestion in the v1 comments
    Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/memcontrol.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..7ed15f858dc4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
+	VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
+			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
+			folio);
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
-- 
2.25.1


