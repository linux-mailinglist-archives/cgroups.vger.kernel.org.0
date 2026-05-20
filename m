Return-Path: <cgroups+bounces-16106-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMiJBjxHDWrvvQUAu9opvQ
	(envelope-from <cgroups+bounces-16106-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:31:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFB587C66
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872533026313
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 05:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B52E8DE3;
	Wed, 20 May 2026 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GzrO3ZU/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0882A1B2
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255094; cv=none; b=rrDAgZFXkQcNvFH2rGK8IuK3hKc2vbCl3Hkic9vrkbYANOGUxBRBK4N8siK0Z8Oc16d2fKxT+RuJdQoSSMzR6CBOV/26+iy1sLUcadAOpaEjCI9f9jO+BHSsE96CEBfw31Ztmdm27YmQRQjRlPNOQZ7tXQl4A71ZhABA5BmDeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255094; c=relaxed/simple;
	bh=73hjRAr0YftTq0WZs0M2L0a0A82EJnKVBxl1ZETxMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AahriP4ORbcBRmUL2gD/3qqlL4JaVe8XQ3fLoru9CY5jo5lhCKU960yuI9AEkQk0pcVakMz9wVyMHCfwOTc8Vd7N2vtcp3eQ+6sxptususSJK+VicJNs3hlmiYmR37sMzrrM8bqVMppNh8ywDwmJRCCV1uLjpLafnIYZTbExPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GzrO3ZU/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779255091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w9644gpBoOdPB14uQ67yzVOzo6y2pa74KkqSttfHrQ0=;
	b=GzrO3ZU/2Y+tqIZ1TZ3hLZ53OwRP/Dgfxc7Xoi4ikVGmYzjrsiw/iIuHN9So5e9BWqQGjt
	E1J9Ug+2qb2K6GEbX/i9Z3UoeSzrR/WHVY57qvRldi2PqIDnL0aC/BnmernotrhtG06lcH
	Ye4abrA8khI2O+PSYOL9TKda/C8DWqw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Harry Yoo <harry@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 0/4] memcg: shrink obj_stock_pcp and cache multiple objcgs
Date: Tue, 19 May 2026 22:31:18 -0700
Message-ID: <20260520053123.2709959-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-16106-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66CFB587C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
per-node type") split a memcg's single obj_cgroup into one per NUMA
node so that reparenting LRU folios can take per-node lru locks. As a
side effect, the per-CPU obj_stock_pcp -- which caches a single
cached_objcg pointer -- thrashes on workloads where threads of the
same memcg run on different NUMA nodes. The kernel test robot reported
a 67.7% regression on stress-ng.switch.ops_per_sec from this pattern.

Commit d0211878ce06 ("memcg: cache obj_stock by memcg, not by objcg
pointer") landed as a temporary fix by treating sibling per-node
objcgs as equivalent for the cache lookup, intended to be reverted
once per-node kmem accounting is introduced. This series takes a more
general approach: cache multiple objcgs per CPU using the multi-slot
pattern memcg_stock_pcp already uses, so the per-node objcg variants
of one memcg can all coexist in the stock without ever forcing a
drain. The temporary fix can then be reverted.

To avoid increasing the per-CPU cache footprint, the first three
patches shrink the existing single-slot obj_stock_pcp fields.
The final patch converts cached_objcg and nr_bytes into
NR_OBJ_STOCK=5 slot arrays and reorders the struct so the entire
consume/refill/account hot path fits within a single 64-byte cache
line on non-debug 64-bit builds (verified with pahole).

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Tested-by: kernel test robot <oliver.sang@intel.com>

Shakeel Butt (4):
  memcg: store node_id instead of pglist_data pointer
  memcg: uint16_t for nr_bytes in obj_stock_pcp
  memcg: int16_t for cached slab stats
  memcg: multi objcg charge support

 mm/memcontrol.c | 214 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 157 insertions(+), 57 deletions(-)

--
2.53.0-Meta


