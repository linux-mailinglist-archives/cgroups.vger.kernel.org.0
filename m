Return-Path: <cgroups+bounces-16105-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO7BGuJGDWrvvQUAu9opvQ
	(envelope-from <cgroups+bounces-16105-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:30:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D3587C47
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DF2C3035B5B
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75C33546D7;
	Wed, 20 May 2026 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oOdT9Qjk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4D33DEE5
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779254985; cv=none; b=DNNvrT1yj7IteGqha5EN+6aV3Hsl3O0cBNMkg5fCHm3cbwoVfQdL6Nm+q/G154URK8oBDw7azn5fecF4R0o84dNyvO6YUr9FsZZliUnLqqpvtj5BQUVlDOeo3Le8oVP4OLfuOiG1aY/0/Okj6rgG0z+9FoEXI99Tr2rqWQK7fBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779254985; c=relaxed/simple;
	bh=73hjRAr0YftTq0WZs0M2L0a0A82EJnKVBxl1ZETxMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c73fisupUcU+zlkX36ptPcpR0giNDCzpPlVCX9nSAq/fL8FX5EYMbQ8Qe0IRLz4GUiQPoR9eVAaFJFtPiDdyUms9vSkS8AWZX8uOjARuvVUhbJ8M6XkvRRUBQckb7nUem+c84tvyftd+JYe0MpV9fhpyRfn/6djur05DmSvKMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oOdT9Qjk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779254980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w9644gpBoOdPB14uQ67yzVOzo6y2pa74KkqSttfHrQ0=;
	b=oOdT9QjkNL+aTBjlLReLdJ3EnXS+dfmLSkf1hJvCfaJRXr5TbQqGqYmnDT4sm8Vlg+lrJa
	ZBbuCyt9/riSrBjJHV7ewel8MUcet5SG9UxkNLjIfMGFZI3EIZVKm3q0Ge9ITu96Q6lVLE
	y+hO0sIKpsKasqvqEjtX6/uwcii3Mcs=
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
Date: Tue, 19 May 2026 22:29:00 -0700
Message-ID: <20260520052904.2673675-1-shakeel.butt@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-16105-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: BD6D3587C47
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


