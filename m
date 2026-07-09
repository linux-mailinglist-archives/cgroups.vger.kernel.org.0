Return-Path: <cgroups+bounces-17628-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GNspGZi3T2runAIAu9opvQ
	(envelope-from <cgroups+bounces-17628-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:00:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ACA732942
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:00:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Dyxhg7J+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17628-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17628-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCE4C31091AB
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D5389460;
	Thu,  9 Jul 2026 14:52:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562C19DF62
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 14:52:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608723; cv=none; b=BWYmexSSvfFKo6AxpN+QPqwdSH5WCtcEPNaEoB1PMKFZqfGH2JVUstJRQRgwt4cqZX0sN1614jQc96aRN1CIdnoN3Vy9IaQJ3+KteOpFSUfRpeVH9ONi208BttvdVbdjq9iKr7dhBayMWOAi8ue0ihHTv3MO/wXDkT5aMxeiN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608723; c=relaxed/simple;
	bh=2aWhzNwCb1BPCutP5oLGQCez7hpPKAKMLp03Caf1XA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SL9Ekc9unxfSVEIpmk9vdK1292m6C8CQxR0y9agJxkf7WmI36gqfWsvfv0V9pnq7vxCS1wMrY0xVGzWfKIjPsxiC1qApRi2UloBnTrCWu/n2ZM8uWod6pmt0hx0w3zGfx9ol/wEmSCRHb/5yAMacWv6CeKLwInH4aYj0i5dJSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dyxhg7J+; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca132e9c54aso143290a12.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608721; x=1784213521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TomD5kQp4QDVC9gWt3p58S/rBPFQXp4PWIaI11lLUvQ=;
        b=Dyxhg7J+eRX9GjnoCLZSilWVAW3yQ+rCspOyMrKZPtGN5XTquiwjwcS7bHtDLb18rO
         iMmAiDDfQbZxJfWdo/nsMbzMZL+GvndWQdtXM/m9J729VnIyLldZjHOf/7i4mLX7VHRp
         xuqFFWYOxcx9224OKakmVmBSb1qUwZgZWeFOCFVxovxlC6roru1yR400TzALl8DXYAm9
         PGw7WszWiwFMZFQ5WOMDNcHa4LLwFM2N2KkSRGf4yZ/4PBTDBs17520Og9vz3A319K0r
         RHi9v3s6Suolsf3BdrDJ7fmkEfJ8f66v7eYdQz6aehm5ZzxepIeysSckmqU/HNzXR1Df
         57pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608721; x=1784213521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TomD5kQp4QDVC9gWt3p58S/rBPFQXp4PWIaI11lLUvQ=;
        b=BzkWx1yJWUSSMC7ODdYe1D5ZBgnJhrwhRDGuRqMJa4tJO48wNdQQEe4EAgX4n3R5Kd
         r2Oxjc8/Yrwxe91O3b3MD+EbwgSO7RcS+zhAl7EeVo7/6VroNf3E6mZZ60LtJFCYM+2h
         9DJnCm5q0Se+2rrbjwuH1IG71LFrn0M/klHD3B2LVqKklh9HA+tZTZCFQVknpmFKhlIi
         J1eiKijAXhHtJXtVLJTMCOHObElO53AHMTBfFb1Z82LKEaF4pezFmAhd6hf4J1mSydz7
         c0f3NJndsHLO+5hKjz7ZMoNYWXc8usGzM4hAjk8cES4kCoJQKPmNKWt1IQW74XIS8NQ+
         2gYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRy/JBroGaTziDFNz5qVzcuEZdXf4GGwQbWKfvFE6GbrPAnfzq9nUSmzuy3I4gSBSLROxP6unq@vger.kernel.org
X-Gm-Message-State: AOJu0YxWk7YCp9Nakm+1Y0Zj5znwKsWiWxCH28n7lqyZY94CzKOtSEea
	rwRipJYtvm2oUDF1zK+IyiQFB37hc7kSG/ilHX9e/H5Um4mFuK+zkFWK
X-Gm-Gg: AfdE7clNqW9B3yHjZx4ohRztT13Hxz0EJ0VksLVzD7uam/0DF3o8UjXlDmj0mwFJkF2
	g07skEb3KaY/K+iWuhgxm4/4JLJuF3MsoAWLWoR5TuC8gHThl3T1U3ENqtrXuNsk+nER7b7Vw9T
	s+upW49EpQLxfcrmvAAfLEkuiVMPvs/FIwRut/c/VF9O+99YlBtSGQpqlJpfLAQdRQ/AtxWdTPK
	CNztebeRaPt4COUTn5+JnC+iA/u8c2k5Ew0yG8wIODNI0fZ0Hiz20dOEXhHaU/1zP8in9K/15Rn
	lQTaAsAbPV4f9pAT4B9OOMP1AxKwFW3+TlStPpVo+ecnqEHBm9+WgsaKKFLIMBRc4bDhM4BpOsu
	Lhl3iNXrSa/tPsdqCKHDJ1L3ZugzaFbXJcg+oLf3vNmdoXGShtMVFMHaRcfjC0XV4yV9U4Hx5I7
	nHMF2Zux1J927iSCHr0V7Qp8g3dL31rzv90TpEtMVsZs4d3e4T3KRQjd0vgLekTrigTuj+2BFrE
	EeldWk=
X-Received: by 2002:a17:90b:37cc:b0:381:6cf0:d5f5 with SMTP id 98e67ed59e1d1-38a2122afafmr3620933a91.5.1783608721148;
        Thu, 09 Jul 2026 07:52:01 -0700 (PDT)
Received: from debian.lan ([240e:391:ea3:6910:38e7:894b:82e3:a58b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc5820sm1286917a91.10.2026.07.09.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:52:00 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>
Subject: [RFC PATCH v2 3/3] mm/vmscan: avoid pointless large folio splits without swap
Date: Thu,  9 Jul 2026 22:51:24 +0800
Message-ID: <20260709145124.764807-4-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
References: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17628-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[xiaomi.com:query timed out];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xiaomi.com,cmpxchg.org,linux.dev,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,infradead.org,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12ACA732942

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

When swap is disabled, exhausted, or unavailable due to memcg swap
limits, splitting a large anonymous folio cannot make swapout progress.
The fallback only destroys the large folio and inflates split statistics.

Use -E2BIG from folio_alloc_swap() as the explicit signal that splitting
the folio might allow swapout of smaller pieces. For other allocation
failures, keep the existing activation path and avoid the split.

This preserves the split fallback for fragmented or partially available
swap, while avoiding it when there is no backing space for any part of the
folio.

Reported-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/vmscan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd1b1aa12581..40340a88f78e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1260,6 +1260,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 */
 		if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
 				!folio_test_swapcache(folio)) {
+			int ret;
+
 			if (!(sc->gfp_mask & __GFP_IO))
 				goto keep_locked;
 			if (folio_maybe_dma_pinned(folio))
@@ -1278,10 +1280,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				    split_folio_to_list(folio, folio_list))
 					goto activate_locked;
 			}
-			if (folio_alloc_swap(folio)) {
+			ret = folio_alloc_swap(folio);
+			if (ret) {
 				int __maybe_unused order = folio_order(folio);
 
-				if (!folio_test_large(folio))
+				if (!folio_test_large(folio) || ret != -E2BIG)
 					goto activate_locked_split;
 				/* Fallback to swap normal pages */
 				if (split_folio_to_list(folio, folio_list))
-- 
2.47.3


