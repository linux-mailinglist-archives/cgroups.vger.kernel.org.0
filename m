Return-Path: <cgroups+bounces-15591-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDeHB2SX+GknwwIAu9opvQ
	(envelope-from <cgroups+bounces-15591-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 14:56:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD364BD48C
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 14:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABDCD301A148
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456683D7D7C;
	Mon,  4 May 2026 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpNjXDzz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AD333730;
	Mon,  4 May 2026 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899357; cv=none; b=X1/f46HBypyruH+PUXm6EQO2ABNfQ1uvHKvBnWxhjxeJe+XtKuiINdp7sktxPBj3kiUJNnJ5JRxIath6UhWIZG13pM2O6T+bw7owMDPSFP0HABtOPieyfoASlehXnuJZ26aznRW1KXuxm+HqTUW3oh8iYdp2PkBXyAiY0oXW7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899357; c=relaxed/simple;
	bh=t5OfcCVJYbLenPvZDFNRz9sQX96KmPTLbcL/NKnx1AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PkFhtCFLxDCKPLW0Yo5zQ24rCbDavALy9aykadxSxgmmYHqIBLI9oYvGW0cHwwJSpRaAllMnoZiOcCpz+6hiXfav0OCOQVg1U9blhg33AI4ekL1qhBWxbejdH9bqgP6haQxtob6PDP7qk8m2cEfd/yw8Gf4Sd0+gZh028kCejtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpNjXDzz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777899342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xkSPJSdtSlIYcN/7W3fB90ZDg2RbpoO3LlLAO8rSbLw=;
	b=JpNjXDzzxXd0csPoMAtWz2LjLcw/qa/YsWVq2sPGYE3pYjuCFWfpWtTxkAaZ5Au38h6yZQ
	Reye66yAvGCgHQJpUKc+V8vWFj+w0syusJLF2nojx6sZaYIJkLrDMNFy6w1djEq4WDFdcf
	jnM9u/Mc4D3AD1lMfR9xRAJFdzDqtjU=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Mon, 04 May 2026 12:55:17 +0000
Subject: [PATCH] mm: swap_cgroup: fix NULL deref in lookup_swap_cgroup_id
 on swapless host
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-swap-cgroup-fix-7-0-v1-1-f53ff41ee553@linux.dev>
X-B4-Tracking: v=1; b=H4sIADSX+GkC/yWMSQ7CMAxFr1J5jUVaRnGVikWSuqmRSCK7BaSqd
 yeB5fvDW0FJmBRuzQpCL1ZOsUC7a8BPNgZCHgpDZ7qzOZkj6ttm9EHSknHkD17QIA1m9IO7jq0
 5QHlmoVL9rP39z7q4B/m5qurCWSV0YqOfapSEA8f90+pMAtv2Bctw2NyXAAAA
X-Change-ID: 20260504-swap-cgroup-fix-7-0-ed0fcdb8f103
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
 David Hildenbrand <david@kernel.org>, Barry Song <baohua@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>, 
 stable@vger.kernel.org, 
 syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9FD364BD48C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15591-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com,syzkaller.appspotmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jose.fernandez@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups,e12bd9ca48157add237a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

lookup_swap_cgroup_id() passes swap_cgroup_ctrl[type].map to
__swap_cgroup_id_lookup() without checking that the type was ever
registered via swap_cgroup_swapon(). On a swapless host every
ctrl->map is NULL, so __swap_cgroup_id_lookup() dereferences
NULL + a scaled swp_offset().

Since commit bea67dcc5eea ("mm: attempt to batch free swap entries
for zap_pte_range()"), zap_pte_range() -> swap_pte_batch() calls
lookup_swap_cgroup_id() on any non-present, non-none PTE that
decodes as a real swap entry, without first validating it against
swap_info[]. A single PTE corrupted into a type-0 swap entry takes
the host down at process exit.

We hit this in production on a swapless 6.12.58 host: ~1s of
"get_swap_device: Bad swap file entry 3f800204222bb" (do_swap_page()
being correctly defensive about the same entry) followed by

  BUG: unable to handle page fault for address: 000003f800204220
  RIP: 0010:lookup_swap_cgroup_id+0x2b/0x60
  Call Trace:
   swap_pte_batch+0xbf/0x230
   zap_pte_range+0x4c8/0x780
   unmap_page_range+0x190/0x3e0
   exit_mmap+0xd9/0x3c0
   do_exit+0x20c/0x4b0

syzbot has reported the identical stack.

The source of the PTE corruption is a separate bug; this change
makes the teardown path as robust as the fault path already is.
Every other caller of lookup_swap_cgroup_id() is downstream of a
get_swap_device() that has already validated the entry, so the new
branch is cold.

Fixes: bea67dcc5eea ("mm: attempt to batch free swap entries for zap_pte_range()")
Cc: stable@vger.kernel.org
Reported-by: syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/69859728.050a0220.3b3015.0033.GAE@google.com
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 mm/swap_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index de779fed8c210..95c38e54dd587 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -124,6 +124,8 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 		return 0;
 
 	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	if (unlikely(!ctrl->map))
+		return 0;
 	return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
 }
 

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260504-swap-cgroup-fix-7-0-ed0fcdb8f103

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>


