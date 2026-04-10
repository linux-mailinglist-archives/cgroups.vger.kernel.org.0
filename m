Return-Path: <cgroups+bounces-15213-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF4tMmJn2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15213-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:10:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211443DCC1B
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D7030641FE
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F33A7595;
	Fri, 10 Apr 2026 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu2WG49k"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309843A9D87
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855271; cv=none; b=YMnVUPzpIm3bwcga6hrXsOsAC8LDv8cOCXCCGdHPLPjlGp19SmDT86Ez32C2w4VQxKl8ZhmprL7XPjqERgQAhBTEd9Peo1M6hwCFs/+5YpPddWj1F2APYJ0fonCBSaPR4MQoOimk7xPYOt5kQozgyxe8Dw5AlVhFupkzsdqZ4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855271; c=relaxed/simple;
	bh=CVQ20RllDi00A02ezby1KNQZkIpJboxutLoOO03cGmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9GkwGOKQoPh2J5cW9rtOxD1osVNlVFHhgB/egWIlhK4eJZrC5Q7bXeJbP7rwP4CL5EFFwmktmz8uSocAn2HjEPdevK8UFxxQ9FPsCe2d+UIGg0nT6Mbdf5JlJPtz2pZJSozEYMgU4DFvo+6pgQ3nb+f2Gm5Wubrz9H6LYVH3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu2WG49k; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbcd61429cso1244990a34.2
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855269; x=1776460069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqJC8Gmg2c8f/XCk9+e6dccXNeaFU07UyyA9/we+nYU=;
        b=Wu2WG49ktKAmJXvTovsACGm3LDfDYHFhdEwe8Fsc/lVmBZy1Ylbb2yPhDrMovubJwn
         YmXzek3EOMAScdzdCwffzxSHjbwOkhI1RqCseKOc7ZAYmXoNMhLi2wZ/poeVgyQ0znQi
         tR4HA8uvfu+69lJinKjRHL/n7cZ/Wlb0hba/EJ/pruegfSzA8ekLJV0iJJAPgzG+fH3N
         vmlgQBw3GNhYKjJRvwENAyCZMZYWesJiPO5esJ4vAOL/h1a3GiM+LGwlSi3bD0708+fx
         iCjQJBqjVM/GLNDM0zinsom10FZoWzcXNszR2sTYMJQxORDHBOG7BF2lu1ulAjJ5E9cM
         vpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855269; x=1776460069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqJC8Gmg2c8f/XCk9+e6dccXNeaFU07UyyA9/we+nYU=;
        b=O9y+3VTEOWZ5yEdenv32uFhLavGgKtHBt2Z6eosso+z10XbgjN6p9SyjuR390FkN/Y
         XsAcXUCv3noiEJcFJTgaNIdOSiU6wPeUU4PwXRnqS5isKyHbBK6p1pdDNFusCefAMcJj
         36dP9/t8VoWqpYgTKg5YkpLgb3expelIGJS5hwGtH/Zu81VzK6x6gm0ExH1rMnNG8xo3
         QyM4O6wRom9em5HscG/mLTatvJ5B+JshoI9wu1kTLtqxCjsj38JuC6CaL6gSAOTwq4fd
         5bvI90tu7cZmNQSyn/oql/QE4mlNqYiSbLWHbqkqkFsh3PkU3uVLF6q5O7dPg3yy76lG
         mowA==
X-Forwarded-Encrypted: i=1; AJvYcCWlEK3Jfeocjk7DdkJOR5kIbXKi3LDCrbcw0dRMl6QxHRRj4rVB7IdQ16d3JL4dI4z9JJ8XnBSM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PCh76iaxOqN64SjqZQA23jUhT7GBHYXiuOE06ovND6Bmr372
	6VXrGf5JZ59np6azMItjpKjzO1PxZ06ZN/81LtPkVSuvZJ/uQ/wg9pPd
X-Gm-Gg: AeBDiev1CjLiv+1eUN2u1OiWfAI8swJPKbQbmenYDEElQyekhx/eEu6cHpawzltqo7Z
	POqjD78T+snVeGQ5WIEfR7MJngORsEPYn56a2Fd+efVO9B1aK2xsh71sV+43KbEU2kVdXFKMhWf
	lnpeX0k6zIug2MbLUvIbqr7PlzG5sNFI+WE5+rSCdrh9YPb7W1xH72uuzeOeTl4SQaEjL19tXXT
	ByDOzM0J+wtEX//NUUHPjLxUpChI9ScJv8KH3KrQYEPgjaFt9hq6EHHi/CfN9cCqBaAiFbC6NPL
	YzgrcDhAuoP/LFoRCkISNJYT5PvaZaoRGjmtKY3VmYUc3GA71LejkkQylEAZvNW6cvf3OK/7yus
	aFvBg/YzscoZdweKn2GzYE+PZNliutgFUnHjj4S9QK0guDEoS3vpMya7Mqg7WDYL8DSM1/8T41t
	bE3Tkrr2nHAaX3A2N39l4fJw==
X-Received: by 2002:a05:6830:3747:b0:7dc:18e:b5b2 with SMTP id 46e09a7af769-7dc27cb91acmr3191143a34.9.1775855269238;
        Fri, 10 Apr 2026 14:07:49 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269402b9sm2561044a34.20.2026.04.10.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:48 -0700 (PDT)
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
Subject: [PATCH 3/8 RFC] mm/page_counter: use page_counter_stock in page_counter_uncharge
Date: Fri, 10 Apr 2026 14:06:57 -0700
Message-ID: <20260410210742.550489-4-joshua.hahnjy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-15213-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 211443DCC1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make page_counter_uncharge() stock-aware. We preserve the same semantics
as the existing stock handling logic in try_charge_memcg:

1. Instead of immediately walking the page_counter hierarchy, see if
   depositing the charge to the stock puts it over the batch limit.
   If not, deposit the charge and return immediately.
2. If we put the stock over the batch limit, walk up the page_counter
   hierarchy and uncharge the excess.

Extract the repeated work of hierarchically cancelling page_counter
charges into a helper function as well.

As of this patch, the page_counter_stock is unused, as it has not been
enabled on any memcg yet. No functional changes intended.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_counter.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index 7a921872079b8..7be214034bfad 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -207,6 +207,15 @@ bool page_counter_try_charge(struct page_counter *counter,
 	return false;
 }
 
+static void page_counter_cancel_hierarchy(struct page_counter *counter,
+					  unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	for (c = counter; c; c = c->parent)
+		page_counter_cancel(c, nr_pages);
+}
+
 /**
  * page_counter_uncharge - hierarchically uncharge pages
  * @counter: counter
@@ -214,10 +223,23 @@ bool page_counter_try_charge(struct page_counter *counter,
  */
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
 {
-	struct page_counter *c;
+	unsigned long charge = nr_pages;
 
-	for (c = counter; c; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+	if (counter->stock && local_trylock(&counter->stock->lock)) {
+		struct page_counter_stock *stock = this_cpu_ptr(counter->stock);
+
+		stock->nr_pages += nr_pages;
+		if (stock->nr_pages > counter->batch) {
+			charge = stock->nr_pages - counter->batch;
+			stock->nr_pages = counter->batch;
+			local_unlock(&counter->stock->lock);
+		} else {
+			local_unlock(&counter->stock->lock);
+			return;
+		}
+	}
+
+	page_counter_cancel_hierarchy(counter, charge);
 }
 
 /**
@@ -364,12 +386,8 @@ void page_counter_disable_stock(struct page_counter *counter)
 		stock_to_drain += stock->nr_pages;
 	}
 
-	if (stock_to_drain) {
-		struct page_counter *c;
-
-		for (c = counter; c; c = c->parent)
-			page_counter_cancel(c, stock_to_drain);
-	}
+	if (stock_to_drain)
+		page_counter_cancel_hierarchy(counter, stock_to_drain);
 
 	/* This prevents future charges from trying to deposit pages */
 	counter->batch = 0;
-- 
2.52.0


