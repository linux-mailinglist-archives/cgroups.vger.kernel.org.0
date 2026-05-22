Return-Path: <cgroups+bounces-16222-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGMTCwzWEGrYeQYAu9opvQ
	(envelope-from <cgroups+bounces-16222-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:17:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C837C5BB133
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D59303A274
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618539479F;
	Fri, 22 May 2026 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXgjwohL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9F3932C3
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487596; cv=none; b=E4pBhyWNLFAWLa6e2hfluQ4yZAgYXHsEeo0p66YiD5vZbF+yffcKeWca4JJ/+XUzNZFY4ZgUR/IWQP0w4Bg2amx/CPDqZI49Q4YRPpEoQxUJyWzvjko1xF/5pZNHRilqrgDk14KyL6+TNMXxpWTgAv8HH4hrcq1Bbj8ntnY6Jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487596; c=relaxed/simple;
	bh=ob+VYgFU6m5S1jM4nkjA7iYLIdVS3X8bkqvXmzMrSvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZSV3Ss5hZ9A31zgez0UfjQrmIWWCLzU1YIiQfnzbsX7gBrYhGhxP6DLF8q8HNEtnO+W+Xfpk9TRdD7zleWlRu2/cF+cCSNb0ebiPQbAykpDKPdOQLeO/ryr2GOhWDysKqHs62ubVe2wg88ozZ8gj54KfkB2A7ec65bTI8CZQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXgjwohL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dcd17e19b6so4432621a34.1
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487594; x=1780092394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieNLELksxQ12VWfSTE2wcDumq9qPO5WfoZYKitlIUko=;
        b=MXgjwohLqY33VXXjW436tp0GNuIjXwIKMPptm+adFVNjY808wXPnrkGPKPdLRiQ+eS
         Eu8wEo7NidO/cI0vUN7nXFRiGMw2VHWzpf0WbRgd1YPXV0jwByeaouW55vUQF1GvTN+o
         EeMtk3R5zmzcqanCkPoRqdU3En9BTHCQCRysvJ/cQPv55XHHaeCgFIw1lBDq69TwvEkN
         yezWM1UQxG9+EtGDp22DwTWuwMJfu80fxuqV4l2SviOW5zKi/9YxDusZFspB4FrPu96F
         Cp+wZeU8rl0Kux0KuvtaDmSZ2+TxKIT5vSmhNJ1i25TkWLmdMjCIOyK4kLYaROfysPnd
         7JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487594; x=1780092394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieNLELksxQ12VWfSTE2wcDumq9qPO5WfoZYKitlIUko=;
        b=K9O/8KedophCZBHkV3zG+e00uwipUcLdnOGH/1BKvn8NaH2FjS+a7nrdVD1VdTEt/G
         Fgyt/6/AbEo5bhWjhe08GOreuVigxCXmgpcVJztAY2KN01tJVp4cOOq92efMjApktOKs
         UfxFv592AzHl/euNKgFO6d1IGLGSv+bbZCnFTpc5R5Vh99homHNLuWcDyZ1wkwG6hLHq
         qjG+FD7OArnwecW7LI/Ygs2zSm8vPZSS/nJwWAQtVHVCU7uzWjdx1O5gPWP8VTwW+BAr
         kpUm0hNj2TC2Plx3glEnEG0Vzp02PFldNRZdoe3nE6xwe1Kvpmc9jkXB4jG7Xi/oJ3r7
         24Pw==
X-Forwarded-Encrypted: i=1; AFNElJ9FA9vZVCLYVd0cAY/9Zme1urL3PZWdjIy1x+uXWqh2OhwwkuywWZYbQCKdtVs3GCM/oFMFxI1g@vger.kernel.org
X-Gm-Message-State: AOJu0YzOl7rlkiQXYY1ztsRR79JtzJi0ogP4Y2qQ+gLE81HMD6DVEwDY
	lEiT/WZxmqpuoJQP+Ap3QM2RcRHRFANxMBqrzCBeRf+bBdVHGmtHs1kE
X-Gm-Gg: Acq92OHUmfaqqBZ7XkPfEvyfJutLIlc9eNMHHGHxEjyJowdwtlJTyqYMfbnM+gw9Ud8
	Azoc+dzLxehuCQ802nVnN351yIPVB/hWnDYKHnjeMu3HzrO0IB4FhGnhu6XX/WGiLvJNawMxEWn
	t+3JC6wdCKFlbp+dPAtHyVivYd9HC4gAeZETXKTzcjeshQKMf24uwAsaD91C6OMUndJMTAp3NRC
	im1zdkby5LeNi5mNA+1+mKDFTDSiGdSzBhlVRdQiRljGhhnqqoxVx9/Eyl93Aer1yANOR/jM6Jj
	ANgj36n2SHHREX2VXBAUHNlwqi9PXYTEsXafOgadRzNwZwnSRWMlgLQPodapeoeA2x9h+LJbX51
	PMoLuNgLj9G/zeIPO0l+vnngsiupaM6bqtmHzA7JyDDgn4qG4JHN4OS5nv6bXcr7B0UZDWvM9BJ
	vITSYUrCx/rdnLkJtPG3mVIknni6+Pjm5H47d3c5UKu7kMpcz4AywV
X-Received: by 2002:a05:6830:6d4d:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-7e5fea05c4dmr3245063a34.0.1779487593743;
        Fri, 22 May 2026 15:06:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6064aa0bbsm1941729a34.12.2026.05.22.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:33 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/7 v2] mm/page_counter: use page_counter_stock in page_counter_try_charge
Date: Fri, 22 May 2026 15:06:20 -0700
Message-ID: <20260522220627.1150804-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
References: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16222-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C837C5BB133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make page_counter_try_charge() stock-aware. We preserve the same
semantics as the existing stock handling logic in try_charge_memcg:

1. Limit-check against the stock. If there is enough, charge to the
   stock (non-hierarchical) and return immediately.
2. Greedily attempt to fulfill the charge request and fill the stock up
   at the same time via a hierarchical charge.
3. If we fail with this charge, retry again (once) with the exact number
   of pages requested.
4. If we succeed with the greedy attempt, then try to add those extra
   pages to the stock. If that fails (trylock), then uncharge those
   surplus pages hierarchically.

As of this patch, the page_counter_stock is unused, as it has not been
enabled on any memcg yet. No functional changes intended.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_counter.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index a1a871a9d5c49..e002688bf7f1a 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -121,9 +121,25 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     struct page_counter **fail)
 {
 	struct page_counter *c;
+	unsigned long charge = nr_pages;
+	unsigned long batch = READ_ONCE(counter->batch);
 	bool protection = track_protection(counter);
 	bool track_failcnt = counter->track_failcnt;
 
+	if (counter->stock && local_trylock(&counter->stock->lock)) {
+		struct page_counter_stock *stock = this_cpu_ptr(counter->stock);
+
+		if (stock->nr_pages >= charge) {
+			stock->nr_pages -= charge;
+			local_unlock(&counter->stock->lock);
+			return true;
+		}
+		local_unlock(&counter->stock->lock);
+	}
+
+	charge = max_t(unsigned long, batch, nr_pages);
+
+retry:
 	for (c = counter; c; c = c->parent) {
 		long new;
 		/*
@@ -140,9 +156,9 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * we either see the new limit or the setter sees the
 		 * counter has changed and retries.
 		 */
-		new = atomic_long_add_return(nr_pages, &c->usage);
+		new = atomic_long_add_return(charge, &c->usage);
 		if (new > c->max) {
-			atomic_long_sub(nr_pages, &c->usage);
+			atomic_long_sub(charge, &c->usage);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt which is only used
@@ -163,11 +179,31 @@ bool page_counter_try_charge(struct page_counter *counter,
 				WRITE_ONCE(c->watermark, new);
 		}
 	}
+
+	/* charge > nr_pages implies this page_counter has stock enabled */
+	if (charge > nr_pages) {
+		if (local_trylock(&counter->stock->lock)) {
+			struct page_counter_stock *stock;
+
+			stock = this_cpu_ptr(counter->stock);
+			stock->nr_pages += charge - nr_pages;
+			local_unlock(&counter->stock->lock);
+		} else {
+			page_counter_uncharge(counter, charge - nr_pages);
+		}
+	}
+
 	return true;
 
 failed:
 	for (c = counter; c != *fail; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+		page_counter_cancel(c, charge);
+
+	if (charge > nr_pages) {
+		/* Retry without trying to grab extra pages to refill stock */
+		charge = nr_pages;
+		goto retry;
+	}
 
 	return false;
 }
-- 
2.53.0-Meta


