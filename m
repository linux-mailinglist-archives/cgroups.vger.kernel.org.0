Return-Path: <cgroups+bounces-16254-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCNBOGudFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16254-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A65CDE75
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AE38300ACBB
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1A3750B2;
	Mon, 25 May 2026 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkpwdsXA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BEA388E62
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735904; cv=none; b=NTNWO85CqCfyGW+AtSRQXYQTPITDp0fVSO0eaaDBFMgLiv9SiPRsQRgQVF1zJQcPdeZhTtpeGldoifkIooCSFjLWsPQVpwaI5CGpJ08E+kguIQnAb6Dd/F4CPemIDgjoyIqklkpwBLQmKBYwPJfZla+ngRgYaPTYjFGmFfAveEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735904; c=relaxed/simple;
	bh=ob+VYgFU6m5S1jM4nkjA7iYLIdVS3X8bkqvXmzMrSvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHfHByxTK8BeiAKEjEg2VS7zQ8srbepaVTEGoEF+EHbo7nv/6xR5aZNKNQ/elDkY/S0xCBwhKTe8dO4hAqFzTvattHnsasTj1pDazQsWyubQEVsoRQWhx5u3dwcq8wOJaw8Y82++FhGVUHieK5w6GElIMWglwuIW2RZiSXZ0Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkpwdsXA; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e36bb16a92so5351103a34.2
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735901; x=1780340701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieNLELksxQ12VWfSTE2wcDumq9qPO5WfoZYKitlIUko=;
        b=IkpwdsXAVvNV1xx+KtG/7+0+bxXc+fUBGQXwLL3ScsBJXtFD7sv/fk1YEi9TGFtRRI
         bRffVHe0FDjXA4Rxi4m1GpPoUnPMd+dqgYawI8b66Sj0MJsOaPskdS+vu9uHEhKKJU6a
         1QvTufAvtxbUxcQOZQg21UWlTA3AI0BWvp8ZhPO683zwkHYa1aQzrBOfjRL3gaNpeom9
         mfwHUCxVe5PT19aF/UBP/GgwmDvYyT+czdJVAZJirIjlk9h8zaOzjj8gDBHWGBCOw+1E
         R6UC3y+60CYVO4lyG8PtOKL6qFVPuY5/GfcABjdqty2zhlAVT4Jsffa0AKAVHtN9Uiiq
         cl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735901; x=1780340701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieNLELksxQ12VWfSTE2wcDumq9qPO5WfoZYKitlIUko=;
        b=d6yevApMPnlezGUMbTmVCMFppl6rPF9YUTgH+6s4ztZ0FLpX68ZeLw5ywJclp4g2S8
         SPLt2zY0S4CrEo5Z975LXXStwnr5Z77Fa5waSRWZThhg+e6RsE5YYvtB9pDm3IGp6jWU
         G96nUrKagSjMHUAlxXbpLbvq7Czxt/o+g2uLJunJwnfoQZ4I43/wvz6nehgfsy1VA5H3
         ynO+Ex+sGoc6G3G2nNY8usW/ws7RGzJXD0myO0LL8L9J7PM5UCX/NxMl6eoAe5TZ2nMe
         6XjX37xZfXA6BEn5v+XhtfNusTG+0yOeMpi4Q9opefvRsChWg9opsl7WyNygVT26mvW5
         s6iw==
X-Forwarded-Encrypted: i=1; AFNElJ/8/vp0IuDN9OEQhKNakCVXrzK7eS91TNsNa979eRcDwwouEOSgwi8xXwJvWBbuOIHZl9QaYorQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bVG4RljXdQCvuYYKF6cacfsyB+txCbewqsdHEpoC4V9mQ9GS
	XdiRNwMwfdkT8wfumAswjUUc2nTIRgE8l4LCgLTupMva5raL1O5mMGjk
X-Gm-Gg: Acq92OFcetG2PfCm3OOZcQ0H+oIF5iqh4MCe7BVk6pe29a8oCYRIV4G+YZKlnUs8BLQ
	6RsOinQK0L5/X74M9pVeQ6b3uuIxJhNee7pRnhcuVOytb4GyV01jhd3ho01zwfiYFAuxvnP4Sfi
	XnXqL3wkHZjkB6aPDEYlWhWGpajKIOlDp+Xcq7+2+LU45YNDK9oeSaSOnNPi4JIq4ajsY+YOQkj
	XFWB5lVddKtFnM6/57SlIFWFbKEaDzBqxwsCR/tmaEKCP3z4AHRIKYM17UiSDoJpm3pDKXE+cJx
	yZDvd47s32We4G8RAQ9O4iN6Uzk1A4g+L28iUzzRTC/p1q3H+qiMHAjJVAwxFfpN+zkzZmWmfUL
	fjEmqvd77ZC3z36LCoaG1Mr7KU0PhggtUDciUc+a40nOWauO7fzh4i2zfW/cBd7C1Ce7v8Q01i5
	Jaya1rAAudB9ao83pnqBmnPiingH/NGAU22wk4QmpOKvGGlgL/aGy7pQ==
X-Received: by 2002:a05:6830:6a91:b0:7d7:d510:4bf9 with SMTP id 46e09a7af769-7e5fedd5083mr9959038a34.12.1779735901451;
        Mon, 25 May 2026 12:05:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6065e7cb6sm7850039a34.16.2026.05.25.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:05:01 -0700 (PDT)
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
Subject: [PATCH 2/7 v3] mm/page_counter: use page_counter_stock in page_counter_try_charge
Date: Mon, 25 May 2026 12:04:49 -0700
Message-ID: <20260525190455.2843786-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16254-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD0A65CDE75
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


