Return-Path: <cgroups+bounces-17433-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t+loK6TRRWrjFgsAu9opvQ
	(envelope-from <cgroups+bounces-17433-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 04:49:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119B6F319D
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 04:49:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sSVpF917;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17433-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17433-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53CD2302B87D
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599BF2E2665;
	Thu,  2 Jul 2026 02:49:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F32749C1
	for <cgroups@vger.kernel.org>; Thu,  2 Jul 2026 02:49:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960544; cv=none; b=Kq+mU9MakyfW5BV1Nql8P2BeNTqt85kFYPbg3yS6vbusIbihWzuEHrIhbuknafCLuN+MAlmX/xOq6YAX/OrLgwCDKnUDgKlX/hXjRzHLYR2LINYvD1RnDgxEhO40gMBIvzCr/VgXOsyKlYUwXxx+0TRphOz4LE5aXtXrR+a9OFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960544; c=relaxed/simple;
	bh=nvja8xV5G7n7v0vpf2vN3eTl1JihoovKmJQaBGb0s0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSvzrjuhdOnmQd4jR6RPxUWIf1hnVfnS1467Qy7KFCCXtr3aJUvJXof4Hr6+mGF6j9uBY1CwuNBkPZ5s9MQfYJ4DS1X6j7nlWEE78Ro4N32usM1Qs0TxX0qtZTP+DSt+93QwliAoIwaVBrLxPVfACXFdFh0s1l0eOZd1i8fOMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sSVpF917; arc=none smtp.client-ip=95.215.58.180
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782960539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fMys5hj8WmPeVOAnmVPIAqv5e6nGUhoaL0ql6VR/72o=;
	b=sSVpF917gMVb1rB3N8+CDOLXr6qRde7sh+4XbfJweyj5phPZG6Oxy0EQ6R7tLssz2WdDg7
	wDYxg9YBbL0F4ZOWddgHUBcNNBHDIbQS+tKcE+cnNPagjISxMKEJEDek2aCkSLojdJ49Tw
	uTpncc20krT/Ka8UMyJCxmVYS6woB+A=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: memcg: reset zswap settings in css_reset
Date: Thu,  2 Jul 2026 10:48:25 +0800
Message-ID: <20260702024827.353185-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17433-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:jiayuan.chen@linux.dev,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0119B6F319D

From: Jiayuan Chen <jiayuan.chen@shopee.com>

mem_cgroup_css_reset() is called when the memory controller is disabled
on a cgroup but the memcg cannot be destroyed because it is pinned by a
subsystem dependency -- for example, the io controller declares
.depends_on = 1 << memory_cgrp_id, so memory remains in the cgroup_ss_mask
and the css is hidden rather than killed.

The purpose of css_reset is to revert the memcg to its vanilla state so
that no policies are applied and the css can be safely made visible again
later.  Currently, all page counters (memory.max, swap.max, kmem.max,
tcpmem.max) and other limits (soft_limit, memory.high, swap.high) are
reset to their defaults, but zswap_max and zswap_writeback are not.

These fields are initialized in css_alloc (zswap_max = PAGE_COUNTER_MAX,
zswap_writeback inherited from parent) but were missing from css_reset.
As a result, stale zswap policies remain in effect after css_reset: the
zswap charge path (obj_cgroup_may_zswap) continues to enforce the old
zswap_max limit, and the writeback path continues to honor the old
zswap_writeback setting, even though the memory controller has been
"disabled" on this cgroup.

Reset zswap_max to PAGE_COUNTER_MAX and zswap_writeback to true, matching
their defaults in css_alloc.

Test:
	echo "+memory +io" > /sys/fs/cgroup/cgroup.subtree_control

	mkdir /sys/fs/cgroup/test
	mkdir /sys/fs/cgroup/test/child

	echo "+memory +io" > /sys/fs/cgroup/test/cgroup.subtree_control
	echo 10000 > /sys/fs/cgroup/test/child/memory.zswap.max

	# child/memory.swap.max and child/memory.zswam.max disappear
	echo "-memory" > /sys/fs/cgroup/test/cgroup.subtree_control

	# re-enable memory control
	echo "+memory" > /sys/fs/cgroup/test/cgroup.subtree_control

	# before this patch
	cat /sys/fs/cgroup/test/child/memory.zswap.max
	    8192

	# after this patch, same as memory.swap.max
	cat /sys/fs/cgroup/test/child/memory.zswap.max
	    max

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
v1 -> v2 : add WRITE_ONCE.
https://lore.kernel.org/linux-mm/20260630100832.107062-1-jiayuan.chen@linux.dev/
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d20ffc827306..c20ef3c1d6fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4362,6 +4362,10 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
+#ifdef CONFIG_ZSWAP
+	WRITE_ONCE(memcg->zswap_max, PAGE_COUNTER_MAX);
+	WRITE_ONCE(memcg->zswap_writeback, true);
+#endif
 #ifdef CONFIG_MEMCG_V1
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
-- 
2.43.0


