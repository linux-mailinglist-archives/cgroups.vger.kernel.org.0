Return-Path: <cgroups+bounces-16670-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mhVLNJzwImoIfgEAu9opvQ
	(envelope-from <cgroups+bounces-16670-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:51:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 740536497E6
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Ox/7TD9x";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16670-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16670-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 244AD3118851
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E54192E0;
	Fri,  5 Jun 2026 15:36:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457F3E3D86
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673773; cv=none; b=OzmfXRd/oKVB/8vjCKHfWOpm4a+cNrMYpChtUs1V5jkpgG6i7ONwOQAwp9fYvs/NYg69unyzLrVHzCIZwy1xNnwbYnuzlkQhpGNzZpZp4UV3tvDYwqMmVyGx26Jp9hXbJooRFyTUcUQpUOjRBBA4ZWQ5wYSPjivp/Ze6m9ipOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673773; c=relaxed/simple;
	bh=gaqXcw7SaNGRC8ZlwI52O8ug9+jqeuYXrmBeNBSCLsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqzOS4gU8fQSZ7BE2xlPK9vo+AycPE1MKSi6xsvFlyGpjNmaKdtY5tOX6xccF0lABxScqIPlySppOa+87OnPcD/mQzXmy0FUTNl1pI4LSE/eL85j4kGKGiFeM+5TG24/OUMPM4n74AC6vlQCYN+j9U/CPVoE5IBodCi1nPaFte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox/7TD9x; arc=none smtp.client-ip=209.85.210.42
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6fa36a1b6so1460963a34.1
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673767; x=1781278567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5dsckH9YwlwdD1mktr8FrA3biFKCktv90GPZj2FBiQ=;
        b=Ox/7TD9xcte/J7liCvcvq1VpwM2SIA9mJCuDaY/LxDBlVqx3ucTYFMib8Po7MGsmD4
         igERZKncQP7PAoMnJt5ewbi/bz6n0MMrBxZyCRKpScfjpNCwrQfFeU2kqX2TAw8UU01+
         iSRgDt/vwFXNHbQeGVBAfyznpXI8AuFJ2lNsPKKj8UJ5cTODdAzzkcZYyhdqAOi6hn6y
         NHVGtclcUs741ECZ1s2e7p1+NOzlnHFRGbcF+kz+G+s5vxfXFXww62en/e7rHQxqSzbZ
         mHM5RUl5dOa/Ik0S2m0+Gjmvz72kVLyZGJsHklj/gZW4EstEPoTLIHlDa/0mYIcrc3p1
         EtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673767; x=1781278567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5dsckH9YwlwdD1mktr8FrA3biFKCktv90GPZj2FBiQ=;
        b=hqRYmX4BPp6EMojyrMMYLRCeAdDKi1PqclKLp5UMvOqEs66MvKcQeH+HoKil8GQPi1
         Z1p5KT/MX+q8yBTOdMwM/IUmqympjPg+NRaxzBxfQqYUZzKKC6WO2SvusioEdU1MQjWq
         SG1iTUFVmUld8tPBf5ZRoa0WeRyo1TneFSmkhOMttvOJQaMCoX2CMq9yseBtmp+Yo2AV
         jHqxxS7FKjj3oMmFt6zX0AHzfBBsH8nUP/fIr+P41NiBYUnPy6w1WRfPclWt+a81yVhc
         WA9h60zSZGMxSRzbkHj/hjxF/BsL/jh7tcX3J/wxJ1wcavLnW/IbdJftDDrpRSqiQZdC
         3rOw==
X-Forwarded-Encrypted: i=1; AFNElJ9hYqMjyTat6gdu7a+BUq9SPdAoO+g5S1df8XulF3yCysG1emirszEcMPvkuDgRo4WEMOdDvc6E@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyZj9jX15RvUW/8UwIRlqDBc3kEVCKg6q+rayH8FS9NYbHiz0
	AWt61v8flNk95wBOdVsERT+4q8r8P9j2gzFvqibq020fycXdqdWzYfE3
X-Gm-Gg: Acq92OF3nMy3XO+3eDU+W7LFeBEHeY/XVipTkKgFBr44DyfE4JhP8GtIfnSwuofcp4c
	6XUqnXMRVPV+f3iPy4xbrpJurwtbxo8mjFwu6hk2K1VPhkUuNBkvE0ZHPrrbKNvOFlXL2oaIYWb
	FAx4GTPJiMHd7YR1QOYYwRCheBx5QqQSbXKRUH3UjJf0CmMunwnzVYWMUmj+EQgdNYxLrZGHv4s
	geN1jT/5YCB5Pgq7ooHsxVdngf8MUX2QulD1VK+vNbcSdSSESIVSOuQsXYgw+BJwsETzQmSey3p
	UpoiwwGl5wBu/CFyDjeaXUA5Fd8TjgDJvWijZEF3oNHNeg3ZGcnDgUi9vadEZXYHMuHU3fPQa68
	9hhMof7bx4v61p0G0L8ltqrpdHbdXNntZMebP5G88+4WxlEZMKlz7WvZPHgND9M+gSK15yIMN/L
	Ol/SS9nQNtcov/OT7MCxxUpTLjnhdAnh77DOQN5erBV+Di1DuEsArORY+tLVAw/t4=
X-Received: by 2002:a05:6830:8289:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7e70c6a605cmr2472371a34.11.1780673767180;
        Fri, 05 Jun 2026 08:36:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7468f8fsm6342664a34.6.2026.06.05.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:06 -0700 (PDT)
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
Subject: [PATCH 2/6 v3] mm/page_counter: use page_counter_stock in page_counter_try_charge
Date: Fri,  5 Jun 2026 08:35:58 -0700
Message-ID: <20260605153603.234296-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
References: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16670-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 740536497E6

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
index 9f3e3f8d896c4..1a71de4f43fd0 100644
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


