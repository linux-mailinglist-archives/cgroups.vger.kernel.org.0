Return-Path: <cgroups+bounces-5251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D69AF6BD
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 03:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369A1283933
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 01:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739414375A;
	Fri, 25 Oct 2024 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FyQBMk5A"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36016136672
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819423; cv=none; b=Ah1dU0OFzb5tm0DNZj5tWqKGWgBktgsE1JBcxk13C9aV0zg7SM47bOF15cwYp2g848pQbEtwTNoRKp8s0CfMULaYoVbmODb/2uBNiJHiz6okCVTmBjLyQgI/HR3qSe32M12EC2SqKcQPK4WJdRpM38QkF051DIOrq+mTf+5Ucec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819423; c=relaxed/simple;
	bh=Hlu/iJwKH/7x+qGas7oxnqiwG5bj+lfrJ+SxT4lsYgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5U2XhMmNiUZAdpDC/E+lcVZHSoCiMj605aS69ObEdzTo+oJBMCoACI43OmHJxPfgL/3GweNW4MskfcabR5972lqAn09stgjz9dl58RkScrAtq0X2QjxDuKxLSw6S7VMPiki/4aoTl+DyG4BP3PkA8fqflrW5ShBUFHHZ8quMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FyQBMk5A; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wiuyjy0zmQLWgqvTUEEYQB7YbC8EAAKeOqIvPyT1kA=;
	b=FyQBMk5AhTU+B75oVA+oWUlAvWNvk+tsSDX0Snyy95VoOAUeapV7M6ETpL7FGJzvOFBblq
	h1ob8GVon/ncRKjwN1/gbkrdP2Q6N/PGtjFTKB5tsUnTA8uQOkhNwestaeF4grzP4JmMTn
	PxF+k0emd7XdYjJE4En9YYVB5PEuewc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v1 4/6] memcg-v1: no need for memcg locking for writeback tracking
Date: Thu, 24 Oct 2024 18:23:01 -0700
Message-ID: <20241025012304.2473312-5-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-1-shakeel.butt@linux.dev>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

During the era of memcg charge migration, the kernel has to be make sure
that the writeback stat updates do not race with the charge migration.
Otherwise it might update the writeback stats of the wrong memcg. Now
with the memcg charge migration deprecated, there is no more race for
writeback stat updates and the previous locking can be removed.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/page-writeback.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a76a73529fd9..9c3317c3a615 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3083,7 +3083,6 @@ bool __folio_end_writeback(struct folio *folio)
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret;
 
-	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
@@ -3114,7 +3113,6 @@ bool __folio_end_writeback(struct folio *folio)
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 	node_stat_mod_folio(folio, NR_WRITTEN, nr);
-	folio_memcg_unlock(folio);
 
 	return ret;
 }
@@ -3127,7 +3125,6 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 
 	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
 
-	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
@@ -3168,7 +3165,6 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
-	folio_memcg_unlock(folio);
 
 	access_ret = arch_make_folio_accessible(folio);
 	/*
-- 
2.43.5


