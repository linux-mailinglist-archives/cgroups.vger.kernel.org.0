Return-Path: <cgroups+bounces-14420-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHAaFIk0oGnyggQAu9opvQ
	(envelope-from <cgroups+bounces-14420-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 12:54:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B661A564D
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBC063032648
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10D37A4AA;
	Thu, 26 Feb 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9Nh2WP7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFE377546
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106758; cv=none; b=ovbOi9gLBT9t7pSDF8SGBl1jqpG04bLxSLuiku6Ku9+/wrLPpQ65YX7400Sme9a53AgRBE2quGy99hs3pbiSZWHJNUH7bqT6ropzxcN3k51JoFMXmFUcirREPfwJ41wzH9JYnc1WFBqkpoUyzYT0strEciI823Ua6kbQZabvHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106758; c=relaxed/simple;
	bh=CXr5VJhif1+yrnl2535K5q8dU3AJN+r4Eg/m9tx77Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ma+o3JDF91wrDpUGCD/qzADQNE0rLvkDuOSELx4miIgq2FqWXKWMnH3P6dAjHs4ktGxZh/Zfg482sZ25BO60r6bsjaxFjYLG7QyKZSurq3gS5W7DRaTVDThKaqhIHoeDC5RG4AWMcYaujykKzWPdKCzxNxNwaNMwHaEJ/87pln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9Nh2WP7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772106755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e4UtDCLPK6MdNbkYxpreAAQYHqOm0mkD391PTP+crYQ=;
	b=T9Nh2WP7sIe3MKc7LtjuySVNIG+4vS4bCG6ibBNIgH/EGfbZUmKHR+N4SLz2Cw/z9Dn2Bv
	8CUeCxnA/vlAsvcgSYCJWJyZ+Mkuyq5/31fFV3qnnDEftqvePsDkZIPf3qrcRg0NMnaxnT
	LDxjti2DMHk6vQJBOzzWh0B372MvaJw=
From: Hao Li <hao.li@linux.dev>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Li <hao.li@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] memcg: fix slab accounting in refill_obj_stock() trylock path
Date: Thu, 26 Feb 2026 19:51:37 +0800
Message-ID: <20260226115145.62903-1-hao.li@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14420-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64B661A564D
X-Rspamd-Action: no action

In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
than nr_bytes.

Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Li <hao.li@linux.dev>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d6dfba540d4..683f9f9bf47e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3060,7 +3060,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	if (!local_trylock(&obj_stock.lock)) {
 		if (pgdat)
-			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
 		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
-- 
2.50.1


