Return-Path: <cgroups+bounces-15739-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OwdDWe2AWr2igEAu9opvQ
	(envelope-from <cgroups+bounces-15739-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:58:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB1F50C621
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66C43040FB2
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4C3D812D;
	Mon, 11 May 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw796Hjk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433833DA7F0
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496746; cv=none; b=RCHYGhSyvEQYGwRp7GGUvgI0z6iFTifdPZDzSXqC/61MUQ1HCLWVC8zdl53h273KXER4vwvzNIUMImJ0Z7/WW2FfqB+sekTLguuZgVlEDQ45HYLeDeex+dSTYKH2EFbQ8xrTpPSbWHIk2tonJpBdiQHQLT1H5pwOfpluR8+hR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496746; c=relaxed/simple;
	bh=Leh1MEBHBCTSKNFe7cTJpIBEvX0LcJ1AgIVCFnqVjmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FR2mDWE7YSDg9Rr+ZpTGlO0h0iTtUzs51RUxSIK4pneG+BATi1sPQaO8wRo3GY8SqyWA0+JXdkK2m55gCWL4gc5F19xW8bS7cuebbeW2xQTP+F/WOES7eb+5MPwoCatgjeLKw139OnbfIlW0YzXJBLENGRNcUTeX9fYDmtikLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw796Hjk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba6485d219so25954285ad.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496745; x=1779101545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6WtgpEfVE+ktty/21d7K0edFsjegj7CB2gJFywRNtg=;
        b=Gw796HjkLoA35cR6fFwk8989XD1QCyOm5rl0t6e1HLhIbJSeGfbso0SecXLqqUMeqT
         tpXGoFDJPpl09luRmkccF6LKJTl/vVJM4yzMzISPOo3V7kn2/O5sEalxReVDshyy53Y8
         MwoL2hew/cNeevylvP3hGyCXti8fEXBqOtlVWDnfATRs9oYfelV4GE5qnMWQ8dysDoIG
         2m1D2csGZLeuVUuriS9lIOCqfFk2zA9hxRdzDe5EKXITo1pnZXFvDe++tTtRVeCwLLvH
         H+vRjSddq4z9iClNRs2cFNkJQ1PLmErgjpBx4pmJXFEX4ykVTYgZSzr3YONrGRzgeCr4
         k+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496745; x=1779101545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6WtgpEfVE+ktty/21d7K0edFsjegj7CB2gJFywRNtg=;
        b=CuPiocxg5A2wMd1SCaxcOretPgUbetBrpeevroHrcJ0Mbjz9ufEnur5Wb7110G8bDS
         b98ZSwJrDUQ5skvy1eY3S/UocvH+EtNMJvmhvTxuxq2qILGP/W38sEx2M0v/UU4QMinU
         mfk2LKKLL6xkK5yVzcCS2D09Z8Vns3wD63CfMm+Dt9wHQATit8Q+Vgv4DE8bAEf6fuld
         96AaLVghdLWB9Hn/aPTicZU9gwC/HBnZEEkSZ64pUuO1Szbdk+IVUUkqLoOxsN4MD+uZ
         dfoFWABdz9joqvdDxjIBSb8eTHyDfpcWypHviV/j8RRHLA2QEbHY3+UcYUqSZTxYAx6I
         XrZQ==
X-Gm-Message-State: AOJu0YxxxHQFMEyDV5fF2QmToUbzpFwCSqqMREZTsJxAqRZ25+LvNvKv
	m4E9epzwpN8Xmvseg57TlI4TVkopKf/BvpFBu4KLuxmNK+tpDVfWl63I
X-Gm-Gg: Acq92OE8U0ns5ixBvq2/R0V0OP5U1qdlydxU/8rdaG+8t7i8oy3Nwcj1fBaUH7jPCm7
	L+tzc3rHZ4azuezMVFUxo8vkH/WCM4cCOlfAvvUZohw93yvhFOKkq2q0uOL3wMBXvOCKObc2+m4
	xN2GMJuMmy6AoK90lQrTpnj6aHdnpRGPTQbZ+zaUxH6WPx5p14CQ8s+mbLXJanIbXqQ3gnMSy9m
	iDo4iSvlAOnXXo38fWu1KxVsErbke13fiatrUlO0Ss3/N6z0L9khLi6Vn4sEGGKQ7ma8wuDw2Jr
	7k52exflVDohwh+vEK0LErNwUHypuz4mWDa0V+nYCrYZ+BuKIRilbV8nmB8JNW9ASZrGnaOhjCK
	C8WdUchaelAD/3c0x4E08/WcNLstDk94aPAG402TVxT6N3/TvNWHvC5ds8nKQP6dL5Dq6DzqakA
	pbxNefdu8MoSMb5dYruxLljXaOMiLgKSwRf7AdFwWNR3fFHCXvt90+T+GHhY+zng==
X-Received: by 2002:a17:902:ee92:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2ba798c279emr168316355ad.25.1778496744462;
        Mon, 11 May 2026 03:52:24 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm98571745ad.32.2026.05.11.03.52.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 03:52:23 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH 3/3] mm/zswap: Add per-memcg stat for proactive writeback
Date: Mon, 11 May 2026 18:51:49 +0800
Message-Id: <20260511105149.75584-4-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260511105149.75584-1-jiahao.kernel@gmail.com>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAB1F50C621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15739-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Hao Jia <jiahao1@lixiang.com>

Currently, zswap writeback can be triggered by either the pool limit
being hit or by the proactive writeback mechanism. However, the
existing 'zswpwb' metric in memory.stat and /proc/vmstat counts all
written back pages, making it difficult to distinguish between pages
written back due to the pool limit and those written back proactively.

Add a new statistic 'zswpwb_proactive' to memory.stat and /proc/vmstat.
This counter tracks the number of pages written back due to proactive
writeback. This allows users to better monitor and tune the proactive
writeback mechanism.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++++
 include/linux/vm_event_item.h           |  1 +
 mm/memcontrol.c                         |  1 +
 mm/vmstat.c                             |  1 +
 mm/zswap.c                              | 11 +++++++++--
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 05b664b3b3e8..29a189b18efc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1734,6 +1734,10 @@ The following nested keys are defined.
 	  zswpwb
 		Number of pages written from zswap to swap.
 
+	  zswpwb_proactive
+		Number of pages written from zswap to swap by proactive
+		writeback. This is a subset of zswpwb.
+
 	  zswap_incomp
 		Number of incompressible pages currently stored in zswap
 		without compression. These pages could not be compressed to
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 03fe95f5a020..7a5bee0a20b6 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -138,6 +138,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		ZSWPIN,
 		ZSWPOUT,
 		ZSWPWB,
+		ZSWPWB_PROACTIVE,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba7f7b1954a8..830d895e77c3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -572,6 +572,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 	ZSWPIN,
 	ZSWPOUT,
 	ZSWPWB,
+	ZSWPWB_PROACTIVE,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..66fd06d1bb01 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1452,6 +1452,7 @@ const char * const vmstat_text[] = {
 	[I(ZSWPIN)]				= "zswpin",
 	[I(ZSWPOUT)]				= "zswpout",
 	[I(ZSWPWB)]				= "zswpwb",
+	[I(ZSWPWB_PROACTIVE)]			= "zswpwb_proactive",
 #endif
 #ifdef CONFIG_X86
 	[I(DIRECT_MAP_LEVEL2_SPLIT)]		= "direct_map_level2_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index 1173ac6836fa..bf23c46e838e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1048,7 +1048,8 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
  * freed.
  */
 static int zswap_writeback_entry(struct zswap_entry *entry,
-				 swp_entry_t swpentry)
+				 swp_entry_t swpentry,
+				 bool proactive)
 {
 	struct xarray *tree;
 	pgoff_t offset = swp_offset(swpentry);
@@ -1108,6 +1109,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPWB, 1);
 
+	if (proactive) {
+		count_vm_event(ZSWPWB_PROACTIVE);
+		if (entry->objcg)
+			count_objcg_events(entry->objcg, ZSWPWB_PROACTIVE, 1);
+	}
+
 	zswap_entry_free(entry);
 
 	/* folio is up to date */
@@ -1223,7 +1230,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	 */
 	spin_unlock(&l->lock);
 
-	writeback_result = zswap_writeback_entry(entry, swpentry);
+	writeback_result = zswap_writeback_entry(entry, swpentry, proactive_wb);
 
 	if (writeback_result) {
 		zswap_reject_reclaim_fail++;
-- 
2.34.1


