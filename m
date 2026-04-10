Return-Path: <cgroups+bounces-15212-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKRLOz9n2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15212-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:10:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF373DCC0B
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204443058DE7
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF23A7F74;
	Fri, 10 Apr 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4Ga4Ul+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592D3A874F
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855270; cv=none; b=pUKoy218wBCRHg+Uip1/EnhPyycXMW6scRfPjLYR5lI9S4wntNXRtNUWg8cZR53eOFo/UGEdCP5IsYZIaXV7ccOekCrnIxLM/U2q7aladxAcX4VBxz/36L+qYu9luqhLm77rOBIIJZP+Mu3vYRrSBLu7kttLvAIeyccf9I2qiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855270; c=relaxed/simple;
	bh=cUF+TCsFr+schEecVTCKTIfvNZvIK6t/KRC4PIJ9c3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBj0I8TUNPK2LZ8CPluJOUxN+vuSvXM4sPCp8RdQa2JVeBt4LKUoFRemUD1339gmgFPUVXPYv+2UPlh/80l5o4rVRD5q7XbroCpHDIAxscn9WEqtRJ+3X9QOoaaS9LAXcHHJybrRLOGieCWPKh5EhsT5nH0xuA0Aam0KyiLcBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4Ga4Ul+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dbec19732eso2301798a34.3
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855268; x=1776460068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc/5SAW/hlzwTRYBBK07KZ6zfX2jO27FY+LfQ7kQsVY=;
        b=o4Ga4Ul+vHznqkwIZ0R9+pHO3B9As+aY4C4IRAECwWjG9lxhXZWJvxIFEEX1p9fNfv
         A+ydKpJspKEFfBGVDGKE/DYr1EhFuxZRowe/7W4lG/zz0mn36bWrmySyBifhYz8alsGA
         CsueoW93b0qAcggHL8BAnFpNyLZaT7zz9U2NO77ld84d940MjY4sjG+fL+/yeKody2d7
         Gj2U5Ka6OqnC93DfurJ9zaqIRbSpMl9nhP+qqJ0xMXl36tLUDmVFOQFZcfxWQeyrJiD0
         UuGUOejUwasiUM9JxDjzIwYKlU9PUz2yAVZJ8i2Wsw/i0Ypnu9QpaVUktLKsdR/d8n+J
         LAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855268; x=1776460068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uc/5SAW/hlzwTRYBBK07KZ6zfX2jO27FY+LfQ7kQsVY=;
        b=EsSEmt0glTFajPY4WYiXiRiLIl6LFvrAUbpDcsEUuQVXa6pW8MoxWOnUfidjY0mDqN
         C92/3/9Es9+3O7SEZTwqCIqNpsLhiI2T+wnLBvDmz0NCKvexlVjvYg1g30gUzfAq0Q6n
         nCZBrbGroKcsOJ/TAbFfFTcNXTtWMK+DyZ31Cbf3BmNq+CvP0TI8yCNtG3mubVYNsexx
         Zou0zOIX/1WycG14jDfqk0gSyjNcoeRJ7POb1t/md2YErZtmHsU1yv7XKkP6bJcMi+DB
         IQTK/6CiWS1keyuKU8lBqhVUyXMF/uAJD0ntAm0zQlnM7EfkJygIRtOo9HFHdAhmXqUm
         3ZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhbA4tK+U7EuGRTJyS+RtNKAUO+GjHfU9B20px93fHs/uoTF6+9MxkJV5mrj3v2rRqJ48WAqpw@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfOzcCcPoDRJ5S3xCx1gKByBbgygEnJC9ZU4v7sLKDBdgioaI
	rc/09GWhEgjLg5zQ4v3K5e0HT7+muF1qFuUg2FqiIyooeJEoKANv50Nx
X-Gm-Gg: AeBDieuD1kC/HRsdISeA0Rem9PeR0JiEHhc8MFu3SuYZDfvQ/GA1ZtKKJri1jGDBcU9
	K7AELWqvtfFwU+mQblHxk0VYH/hTbUGaWp/u2GGnkXCUzbFG/8wRybP2tCdjYNrSi3/kMOM4o8w
	yw6cdgctm7s5YBm8cNfOrlxuAEW6XwiMr1vD6qDyGIAU5JAeprtIgfg2Wdv9yf+PoXX4JQcm1Hn
	WnSvhK6XW71Hb2BEkM1uOVQ4ZNkkagFFEFaHzGgUHJ31B+c+1+Z9Jdbz66GXyq6e5covQly+zNC
	9wk/8Gp7EYJgpGMqWiIWDRH7ah7V4q3psiei8Vb/vDrW6UcZas8+fGNo0Lx+uiAVU7UeS59o2lQ
	iMgZoSADXu9J5sxepV69tPgxb+zqFhbJ20XibCftl8v2X1ltjzkXO6wCdDukSGY6zOaCMhcFGtZ
	xaYeL2G0byMHvNzJnLcLlb
X-Received: by 2002:a05:6830:81f7:b0:7d7:e844:7f4e with SMTP id 46e09a7af769-7dc27f1ca2emr2973075a34.22.1775855267769;
        Fri, 10 Apr 2026 14:07:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc3959099fsm214769a34.9.2026.04.10.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:47 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/8 RFC] mm/page_counter: use page_counter_stock in page_counter_try_charge
Date: Fri, 10 Apr 2026 14:06:56 -0700
Message-ID: <20260410210742.550489-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15212-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CF373DCC0B
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
 mm/page_counter.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index 965021993e161..7a921872079b8 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -121,9 +121,24 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     struct page_counter **fail)
 {
 	struct page_counter *c;
+	unsigned long charge = nr_pages;
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
+	charge = max_t(unsigned long, counter->batch, nr_pages);
+
+retry:
 	for (c = counter; c; c = c->parent) {
 		long new;
 		/*
@@ -140,9 +155,9 @@ bool page_counter_try_charge(struct page_counter *counter,
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
@@ -163,11 +178,31 @@ bool page_counter_try_charge(struct page_counter *counter,
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
2.52.0


