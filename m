Return-Path: <cgroups+bounces-17421-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D941OKtaRWp0+woAu9opvQ
	(envelope-from <cgroups+bounces-17421-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 20:21:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F14456F08DF
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 20:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b="YpruxKr/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17421-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17421-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20EB8300B9CF
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7294C77BC;
	Wed,  1 Jul 2026 18:21:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951954C9018
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 18:21:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930073; cv=none; b=PrhuA2C5yM/O5bPZgBoWKRiDqMhdnJWuTQVwG1ghaDgaMbndi/qTtbAghHC9ih3Ws6FHn1aLlorDnwZFEsrlPKs32ApY0PEDEaPG36emC5V3dOXEqUXHOCTFuL9EoCPT8c7YJYgoy/Vrn8ZGm4M3VhI3T6sBDL0iCD344HsOWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930073; c=relaxed/simple;
	bh=nItfjWaMhvqTGGPSuKIqP4AzvuW18zPSx/dsB/4uVmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTrPumm0NXWnI+obDsaMjIRuPvLBAH0MYJH03aROGOFsZYxELT5InLQb30IfZ2giOe9twdvEvXHa07DFJ3u8mdNg3Aul/EZcKVOjM7GMtlZl4skzHoW8WSPr44NOYpzr8/5U5iCzCVYAXbu0dE/7ab2uDiX6/1cshB8phlFU1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=YpruxKr/; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e512a9a6bso52225585a.2
        for <cgroups@vger.kernel.org>; Wed, 01 Jul 2026 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782930070; x=1783534870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBjYQGhoBP1Rzw+O9Mu9B3KRHSZGqqE2WAhtEsoN9xY=;
        b=YpruxKr/yMqtePjYGl05hlhSvC9cuGcUInAFV7Ra2TgWxO3trfbGyJoZWK88q1nASV
         xtwNvhSXt7DnHtD+2yEa9WrA7oSn84XmgryL0P67QvFMVcEws9K6TNObywd74YfkNJq+
         g6W6HMtDKU3m5c7Uu50DeDyc3E1NTyyJSiTMUANIHS8hrhtOHyxhVMOl4eahuYOO6zXT
         DGHA216kKbQeOQSkzLtovdmWx6ZGE8Gb4j5GZf2VoO6j6RgWlrcN1nRxY/Mb7S659Zr9
         n0wOoD9/O9fjKs2lITVwdUiY0MWmscUyq7H4Mxxc0zw/S/Ep4QRM4Dbtz1m50UfLca/Z
         N8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782930070; x=1783534870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBjYQGhoBP1Rzw+O9Mu9B3KRHSZGqqE2WAhtEsoN9xY=;
        b=lsyFzdoX+4foTL/mnWCOeLOMVSj2IVLBcevYOIZ6wbZ4zUFdBdCUTwUEynTZNc75f+
         Wc+x4uFU88j6Jv4Nw+xo5iqudb9bV472M5xALqNCoROPQJGXvNFMGA26kgOxqQn8ExWF
         enX5NKZEBHPxghMTMP+JFEB5lpOfVHzeVi6dyQN5uCSlQ6UEPOC8PbGzxd1zgcjy4CfI
         LKKgoJvEgbw1pW/RqyQ8Eo1TdUmGgBm1/oWSomjqj/GUIUsu3t/U2QI6tqYxpvn1lCof
         ZlfX8SBL/EFgqh1w7Qkb2ytVWtMaLQbyjktngCi1B7jLCJb9hC2OSKTJJEwk0RKzgfWk
         rcYA==
X-Forwarded-Encrypted: i=1; AFNElJ/5TTQdId6aNJgzaY8OlkJeBGFUkPEupCLXCbgsFOQMFq8bvTS8qsKj9yBK8NfetHrVa8fWeJ4A@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGY9QGtNy+rQH9WSynHyFZEKSS8lfGwSfiubMUfbKzyHSmHQh
	N4mvAwgdoqxUpH3d9cSxnUk7EMcq8Fj3lZSNtewxiK8FvpodZprK/bmLE+2z+HYuDDo=
X-Gm-Gg: AfdE7ck1Teip77/uhfgpV7jajiEm+VRXaEzjRmDRNbB07QIz0IF9eM/XNfNmG+Sp4Rf
	S9yqpEZ6o8z1wLGZPjITWA4WVtoyVLlALA/q87WohlAJulOIYwP/dM7fyznykWtFsUfPi1JBYDs
	f5muhBDbzz3TGadKdOm02K+kYqOL0XDYKRSJ1gzHRQHeeW0l8Qji7io6ISgxzAbx9JJhnkilpt0
	120eTKuPwVKXyQjqGXpZ520iu/l6sF4/dwjXeug4uy22DzMY8cQV3NLMZDAWvLNilB9ddqYhDpU
	DvhhGjBTkRKswRiW1xbn18M9GSUhob/JbKfB0OhTfVk8F2+3oDY4aVCoGtJvnaYHH+spo39mopI
	WbC1xIWfUlUlhTMLzJR8EZz5FN/ch3qjIoHjiNhvSCeIXRxbbGpBfLZr3ToABizR3JxWNXxNYmO
	nW4rbgCpydiQxoSBYFydesgQ==
X-Received: by 2002:a05:620a:2851:b0:92e:52df:3523 with SMTP id af79cd13be357-92e781dc83emr395697685a.8.1782930070154;
        Wed, 01 Jul 2026 11:21:10 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80009552sm9286785a.11.2026.07.01.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:21:06 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gregory Price <gourry@gourry.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: gfp_types: fix __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT documentation
Date: Wed,  1 Jul 2026 14:21:02 -0400
Message-ID: <20260701182102.1586784-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17421-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:gourry@gourry.net,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:david@kernel.org,m:ljs@kernel.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:from_mime,gourry.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F14456F08DF

Gregory points out that these descriptions are cursed and confusing,
considering what these flags actually do. This is mostly due to
historic implementation choices and cgroup1 baggage. Improve the
description of their actual effects.

Reported-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/gfp_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 54ca0c88bab6..463b551d12d9 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -136,7 +136,8 @@ enum {
  * %__GFP_THISNODE forces the allocation to be satisfied from the requested
  * node with no fallbacks or placement policy enforcements.
  *
- * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ * %__GFP_ACCOUNT causes the allocation to be accounted to the active
+ * cgroup context.
  *
  * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  * mark_obj_codetag_empty() should be called upon freeing for objects allocated
@@ -320,7 +321,7 @@ enum {
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
  *
  * %GFP_KERNEL_ACCOUNT is the same as GFP_KERNEL, except the allocation is
- * accounted to kmemcg.
+ * accounted to the active cgroup context.
  *
  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
  * reclaim, start physical IO or use any filesystem callback.  It is very
-- 
2.55.0


