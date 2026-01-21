Return-Path: <cgroups+bounces-13344-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDrDFYLLcGkNZwAAu9opvQ
	(envelope-from <cgroups+bounces-13344-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 13:50:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D957102
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 13:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 619675EA704
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BA481ABD;
	Wed, 21 Jan 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pztY8jU8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4C481241
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999213; cv=none; b=SSRQgytBpmAFhJfCNo4FLcvT9cpMJ/CkXk9aaND94NO0Crw9LmfO+mYm8WIrHwijgOgGzhxeDj/JPicr2FzYSYbOhDaskGTW1RbYedb7Y+mGJPjb/N2z2N4ctcFKb1m9dxMPuM4abSVLuwNEuSRtUSwqLgBCa4/n5C5W4V2KCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999213; c=relaxed/simple;
	bh=Z6XMoEdXmH4BcMhS0u/DWzfS/DQabH2lrLBwqiOvaPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmqiStYu/4YHabYtMatoTsuL46eDcW7N6BEBGFQ2/gLZEA6mx6vczYPuBbu1qT/g5vLlISGa9GznU/ofiPBxnN4vssBdXHfr7B511WTBBXBhSn4/kxf3u7L7j1VPZxPJQc1tiSPOl4Rtt/6bbLBpytdVYKVDov8iH5fz81YF+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pztY8jU8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768999206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AIgd4bOr0S+D4kFtBOGP07QN+SUDLqIaIGdlYZNzuKM=;
	b=pztY8jU84lPxHm5uxMRAKZomPFuvZe4E4WGRA0qyOTw9jwZV8Fz9G66Mz2MGFPKiY6tLbQ
	SI8WQuh3FITgIhhFTDqiLpsO/W1A2WGihUT6s9LvWvIG0V3/fjr6sWZsFJWcxk/gfemQCk
	l4jQZF2Pc7qvkMbK9S5qnz4OMuJESRk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] mm/lru_gen: add memory.lru_gen interface for cgroup v2
Date: Wed, 21 Jan 2026 20:39:46 +0800
Message-ID: <20260121123955.84806-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13344-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 247D957102
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset adds a memory.lru_gen interface to cgroup v2, allowing users
to interact with MGLRU directly on a specific cgroup without needing to
know the internal memcg_id.

Motivation
==========
Currently, the only way to perform aging or eviction on a specific memcg
is through the debugfs interface (/sys/kernel/debug/lru_gen), which
requires the memcg_id. However, there's no straightforward way to get the
memcg_id for a given cgroup path. This makes it difficult for users to
leverage MGLRU's proactive reclaim capabilities on specific cgroups.

Solution
========
The new memory.lru_gen interface operates directly on the cgroup:

  # Show lru_gen info for this cgroup
  cat /sys/fs/cgroup/mygroup/memory.lru_gen

  # Run aging on node 0
  echo '+ 0 <seq>' > /sys/fs/cgroup/mygroup/memory.lru_gen

  # Evict cold pages on node 0
  echo '- 0 <seq> <swappiness> <nr_to_reclaim>' > \
       /sys/fs/cgroup/mygroup/memory.lru_gen

This interface is available on all cgroups including root, providing the
same functionality as the debugfs lru_gen interface.

Testing
=======
Create 1GB page cache, loop access 200MB as hot pages.
After aging twice, 200MB hot pages are in young generation,
800MB cold pages remain in oldest generation.
Eviction with seq=min_seq only reclaims cold pages, hot pages preserved.

Patches
=======
Patch 1 refactors the existing debugfs code to extract helper functions.
Patch 2 adds the memory.lru_gen interface using these helpers.
Patch 3 adds documentation for the new interface.


Jiayuan Chen (3):
  mm/lru_gen: refactor to extract helper functions
  mm/lru_gen: add memory.lru_gen interface for cgroup v2
  docs/cgroup: document memory.lru_gen interface

 Documentation/admin-guide/cgroup-v2.rst |  17 +++
 include/linux/mmzone.h                  |  16 +++
 mm/memcontrol.c                         |  31 +++++
 mm/vmscan.c                             | 176 +++++++++++++++++++-----
 4 files changed, 206 insertions(+), 34 deletions(-)

-- 
2.43.0


