Return-Path: <cgroups+bounces-16547-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAdSD4NdHmo/iwkAu9opvQ
	(envelope-from <cgroups+bounces-16547-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 06:35:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2662819B
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 06:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C18E7300E25B
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 04:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FD1A681B;
	Tue,  2 Jun 2026 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZ+Ve0Mr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB714A8B
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374909; cv=none; b=AbAq/nrKAwh4Du1wwwipn3rMx+SJl1QqJq+S2fCoFwEpcO913Tej7eMuG6XeFq51K6Ky0El9PnbgLqCxb9PSx8j+SDaM/EztzcH4parMYUNn//SURy768IuANTAc9Z5KzOMKHTftVvRp7wiiDSyBrNr6GePMJf6MqERFcPNQw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374909; c=relaxed/simple;
	bh=AjUrIUN8kJ+V9mftkXkX7P50uAZ8iF3w3J3ZF+ZMY7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jI99S3HJ5oO7SQx0z2IKLFjMQCbLOWC8sbe0/o09AhrrjNXzHcv1o/7tNPTGx0Jj1SJmQ315ZoyPIDKKW6MR6q63b2URqfxu2J7Qn8expKXORec9w5naNjI6bwaU3C1DVtlr1Rsg5psmJPzzasSahxs38FM+LxgkYIWsyVmTbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZ+Ve0Mr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780374904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NgwzeQZYBkXu7U3Vz6FCT3bGFgzALNC0m/GPi7PoAp4=;
	b=HZ+Ve0MrPDFwnU/cx5DmPS2k6/sGmTO0W/b3GRkYbj77VOarf2rpNjDKEg8UAOg9dAH/Gu
	JD5P6kAiy0GMeCbgqbwCi5CiPopgiF3Um7JCF70Iz9FPRueWQ/DrMKyCfFX4U16fFsY0KV
	nohz4Rxi1ky2NiAvslzJpJjlWtgCEjA=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	david@fromorbit.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	qi.zheng@linux.dev,
	yosry.ahmed@linux.dev,
	ziy@nvidia.com,
	liam@infradead.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	vbabka@kernel.org,
	ryncsn@gmail.com,
	zaslonko@linux.ibm.com,
	gor@linux.ibm.com,
	wangkefeng.wang@huawei.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/thp: clear deferred split shrinker bits when queues drain
Date: Tue,  2 Jun 2026 12:34:53 +0800
Message-ID: <20260602043453.67597-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,huawei.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16547-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 8FC2662819B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lance Yang <lance.yang@linux.dev>

deferred_split_count() returns the raw list_lru count. When the per-memcg,
per-node list is empty, that count is 0.

That skips scanning, but it does not tell memcg reclaim that the shrinker
is empty. shrink_slab_memcg() only clears the memcg shrinker bit when the
count callback reports SHRINK_EMPTY.

Return SHRINK_EMPTY for an empty deferred split list, so the bit can be
cleared once the queue has drained.

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/huge_memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 72f6caf0fec6..62d598290c3b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4397,7 +4397,10 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	return list_lru_shrink_count(&deferred_split_lru, sc);
+	unsigned long count;
+
+	count = list_lru_shrink_count(&deferred_split_lru, sc);
+	return count ?: SHRINK_EMPTY;
 }
 
 static bool thp_underused(struct folio *folio)
-- 
2.49.0


