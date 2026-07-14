Return-Path: <cgroups+bounces-17766-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JKvPEz8CVmpuxwAAu9opvQ
	(envelope-from <cgroups+bounces-17766-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 11:32:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48E752DFB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 11:32:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="A4RY5/zI";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17766-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17766-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AECC3046940
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1D18DB2A;
	Tue, 14 Jul 2026 09:32:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B43F4101
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 09:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021540; cv=none; b=ZbAsaeQP0i+Vo76LtixZ16D7NKJ9/BtDDhYrabfoZb/nTSdQ1myRo1heFek+LoDFMZQRmtrafoShSC4q7ZG4/m/vnl0lWbWDY3loVfPz/OhvkMIURRCb8YURZ1t6sMeXQU+fEqXRcBOvBGmROyt/zUQ8yryiCgtWdaK/Am8AmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021540; c=relaxed/simple;
	bh=2l1s6SY91BitDP9Fk7cMfVdIRCiEIScYANH9F3mzM9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OpXE6a51fI7K4FA1HNpm9iNZYYOuOswprOr4eKDl7ZE0j4aLoOngGvmxP3mV46R4VzS3IIUGPUVpN8FqYW8yC6CV7+eThGZC8Bk4UkOuzatcTy/gq4cPQUbtYVgs14p5EUga0LGUEBRUED+t6hwu8oMpTicr2b15Vz5xOo1Up6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4RY5/zI; arc=none smtp.client-ip=209.85.221.74
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4767036f8faso2441271f8f.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784021537; x=1784626337; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZCDTy++eofJtCdYVj/00BJntfZC5+UGNjKSKN7oKjA=;
        b=A4RY5/zIh0TYZFedQYRVq4GibqudS/PGANFqULJJkI1AeHSF25GC9aGJI6IIj7fmz8
         GoRtz9Fduf0d8coiB3t0GZgA9NdzwYtTehv5Rx8j3QC5cORvB0Dv2fk3bJqL+TBVXY/p
         Hq96JLyRP/BjLDQj+cvEAkma4WEL72YGwufL83QJEVUt5MBZw6Wt2/rVIqrnQ32j3+xJ
         liSuBQlfbfScSbjyNB8iMaj7QUNuX77jJdAstKfOLyBNHcfpdNLWSH/O9KmJGs8FByLS
         Mgr7a6WQzNMzERb8Y7xWWNaSSN28qBWPVHLfZWz8h/tOkAf5dotv1jg3PC7j5NaeJZ8Q
         A42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021537; x=1784626337;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZCDTy++eofJtCdYVj/00BJntfZC5+UGNjKSKN7oKjA=;
        b=hoNt5KwBecE4rnqU2W5mesKFvTMQXdRJClYiju0Xo/0HdW5rB4W+rWxk1EcqwcNeOQ
         JOGKgPeFnv01lGZyM1vk+nSjbE5Vhrf25+YeQEF739a5xSFzUMYz9k9VZeNFkTHjgf9B
         Orxrx+ZHLo3fEBXX/9ixylFvgRMidz1bYs70La30LAajPdYOWtFujbRt0MLVro/Dzc2n
         E9N64lSCEXf115JAPKcWUHgdbvHgRHqEUNC5BmxfVpFyaVUQT//zNQbFTRKdr+eAneyw
         zvKk2bBVay4Zpuu02WFr+DHHc5oU6RK+1uZmdUc3TXKQ1RbHPFgzPra+qBKsjEeBV+or
         ci4g==
X-Forwarded-Encrypted: i=1; AHgh+RoPjqTHqLdiS1R33tP7b0TaJLGHQZbu6/T2ALadxiDE0qbwdTBhz5mGA79lPqHndDrIeOoTrQTJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywin4dtoNqiUEO7o1BZlJDRLxsDVYWtPW9Rc+Q+Dn0Hq35zwYcx
	vlHRDa4rsvA627aZGrY0Ivs4ArnBYnKV0eSCs3zW562u5Vz27horyvG4YAAyz2RzyRB/CKulGfp
	XvCTxZYaJ/wYUNA==
X-Received: from wmcv10.prod.google.com ([2002:a05:600c:428a:b0:493:bc21:e2be])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5297:b0:492:454c:347c with SMTP id 5b1f17b1804b1-494013134aemr75960445e9.7.1784021537240;
 Tue, 14 Jul 2026 02:32:17 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:32:01 +0000
In-Reply-To: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260714-spin-trylock-followup-v2-3-3c20ed032b14@google.com>
Subject: [PATCH v2 3/4] mm/page_alloc: fixup alloc_pages_nolock_noprof() comment
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17766-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC48E752DFB

Update the comment to reflect the recent change to allow flags in
gfp_nolock.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f3f08d0313cfc..d53f858e518f7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7994,7 +7994,8 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 }
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
- * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, plus some flags that get set
+ *             internally regardless (see @gfp_nolock) are allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *

-- 
2.54.0


