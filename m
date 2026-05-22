Return-Path: <cgroups+bounces-16223-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBRgKxXUEGrYeQYAu9opvQ
	(envelope-from <cgroups+bounces-16223-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:09:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2585BAF61
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56D37303B25D
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA2395DB8;
	Fri, 22 May 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxPSIi/4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E843955E3
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487599; cv=none; b=iVxKBtVRxDLUgZF89hHpoToq/53g2s4iG6czOvjqs6M5Yu56w89G0mDDvATZ1asjIFoCB54N2N1sJS1X3KOR4sn2i5cp1rHgtq1cdTqF0ZrITSBY+iBhtz1ucPK7MIYMIlvePjGFHPnEYCgBCaToai5/UwqX5s/88+gVwfzxFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487599; c=relaxed/simple;
	bh=bTlx5xfQqrhQmXD9/D84ZEOgc8v5KD0QPZ0MqCBJAak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URfbGjdjP/eotfEPEX5z0IDTdyyExwvMx2PEJCwv8RMp3sdZ+RG9uUJP6liqDxQ5oWwM8K8BC5A1PiCmeVSd77gST1wEI6J3CXBXvHSWyjPQPG0kh3/4gvl8Y7KqJPyVhKeJHxlJIeZJuCkuXKzBZBrW/yv4f0VyS2Pwj85R608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxPSIi/4; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d7e72b052so1003603eaf.2
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487597; x=1780092397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMrn8GveLC1NdRQvZAymrZa6CvaW/GKC3sRoShkKmw8=;
        b=mxPSIi/4k6JBre2aaBdze56tkWq+g26v7BlVrm0H6xbeMR4bRznxIzK0F7063CXFKj
         lOXzJGoUAZ3ztiwqUCY2r2OrsMqz88byrw9WUPRnH7Qo6UyAnSuXR/Q/U1Iy0Nkgw8hP
         178zCqh9J7aLXP4x1OFnUuoc8SI6cAG/A3SB1b8ROpweLWNJ/ktLxeDTNGGrI8koZO6v
         l+OAGCzy0nH+04vgnDmiTDW4YPS/Wlyxoc6MC80LK0ttBkDCblracVSrAgznpRQ8qLMc
         M3U8YCj5UqI5GX7XCiC9QMCjfRE2Ba4bj+ES0zeoeRcFGpDaE6GIeazWXSZvNE6KyuoS
         fOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487597; x=1780092397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMrn8GveLC1NdRQvZAymrZa6CvaW/GKC3sRoShkKmw8=;
        b=jALym5qXRXjz7pZsRATQtpaO+Ipc6Z7/gvAjMou3u24HwKqgcygvlj8bqL49c354ak
         +TEqmPPTBGApG9/uNMdYYiaiS37duDdgVWzNa3cI0HvVMLl4++1Df0M73EpPYJuuEs7N
         zqlX182g8h6yERXAQ2G6wEl2I3J6tZWYP6ZRATF3kRn6SsQY69W+BxglZMmmZzij736n
         FNY4FEXBL1ksc1+nwiOrUrCX4KEDLUItO6sh7Q5nEA99Jh3PhU36L6DnIGUo6aIrItvt
         qBLiMmg5+5y9/y5eyTGh4Vn1e/hsLLIVP9gK6RyEHfNa5D9R+L8jgEpvvPOGrz1BzPl9
         ixnA==
X-Forwarded-Encrypted: i=1; AFNElJ/AYMmiwwk1i4N6cCY+PpT0M5Wt2OKH6YldmeVICmuXUDLefi1tt5vpKvQsD/h77MtbNzk4Y/Gc@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhRO+mDggQxAPauQuRG6y3gotbuvGBQi9uaMe0/g/32ChHDDm
	LPvSm42pxGLuSkfEkdlkc6n1zKDgk6yJ6gCMBYOoOqUA//eldeR+HfVs
X-Gm-Gg: Acq92OHWneww5uZzhcNjAiuLRObQqCzor7NrLas+cXtgU2b1I3JnjCPAcqb/B3Hk05n
	gmMnURquWMkPICXsV3tsnYfPJq9lYX8Ev1G/b9uN4f3i0hVSYJQYLhwMAv1BnCk96x8ERfA7qBv
	Vv9HjrCvUgrWyxB3DDfoAL7L4SchpXImjthw/bFBXptudpc6u2n/PQZAuckg2PAr/Scm5zj8B4J
	lcAdsIan3HiYvSNHaWfFkM2SyZUeNMJh0fNt009zqYUqv0Xgmh7uOKEyrvo9a4Ai/b0MafFxbYj
	Ghgu19VzmjmlawwMTrpVT2u0S2vQCw5Ejc/Tl1ZPIjR0SnSEy3rk01ng7hOP4BrQnQ1bxOY4L0E
	/BP7F+J4LYg9LapYtplwANx3VTqLJrMKa84lf/URLc3I0xaPu0MoH69SPCbFq65KH58sdkjjY2e
	lXb57kwk/EriwI4XLRUv7LGHPVyx54bop56JdQCF/BFzd3BrmwNceo1A==
X-Received: by 2002:a05:6820:1995:b0:67b:b8d0:a7d5 with SMTP id 006d021491bc7-69d7ecb113emr2975215eaf.53.1779487596841;
        Fri, 22 May 2026 15:06:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83709124sm1455347eaf.5.2026.05.22.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:35 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 3/7 v2] mm/page_counter: introduce stock drain APIs
Date: Fri, 22 May 2026 15:06:21 -0700
Message-ID: <20260522220627.1150804-4-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16223-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E2585BAF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce page_counter variants to replace memcg stock draining
functions.

page_counter_drain_stock_local() drains the stock of the local CPU,
taking a local stock lock to serialize against concurrent charges.

page_counter_drain_stock_cpu() does the same, but without taking a local
lock. This is possible because it will only be called from the CPU
hotplug path, where the CPU is dead and there cannot be any more charges.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h |  3 +++
 mm/page_counter.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c7e3ab3356d20..ffe13224213c9 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -111,6 +111,9 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 int page_counter_enable_stock(struct page_counter *counter, unsigned int batch);
 void page_counter_disable_stock(struct page_counter *counter);
 void page_counter_free_stock(struct page_counter *counter);
+void page_counter_drain_stock_local(struct page_counter *counter);
+void page_counter_drain_stock_cpu(struct page_counter *counter,
+				  unsigned int cpu);
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index e002688bf7f1a..fbfe9a1b29d2e 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -389,6 +389,40 @@ void page_counter_free_stock(struct page_counter *counter)
 	counter->stock = NULL;
 }
 
+void page_counter_drain_stock_local(struct page_counter *counter)
+{
+	struct page_counter_stock *stock;
+	unsigned long nr_pages;
+
+	if (!counter->stock)
+		return;
+
+	local_lock(&counter->stock->lock);
+	stock = this_cpu_ptr(counter->stock);
+	nr_pages = stock->nr_pages;
+	stock->nr_pages = 0;
+	local_unlock(&counter->stock->lock);
+
+	if (nr_pages)
+		page_counter_uncharge(counter, nr_pages);
+}
+
+void page_counter_drain_stock_cpu(struct page_counter *counter,
+				  unsigned int cpu)
+{
+	struct page_counter_stock *stock;
+	unsigned long nr_pages;
+
+	if (!counter->stock)
+		return;
+
+	stock = per_cpu_ptr(counter->stock, cpu);
+	nr_pages = stock->nr_pages;
+	if (nr_pages) {
+		stock->nr_pages = 0;
+		page_counter_uncharge(counter, nr_pages);
+	}
+}
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.53.0-Meta


