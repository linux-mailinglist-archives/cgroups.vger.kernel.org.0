Return-Path: <cgroups+bounces-16671-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RyhWAbbvImrOfQEAu9opvQ
	(envelope-from <cgroups+bounces-16671-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BA649748
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="W388OB/M";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16671-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16671-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABA5311A2BB
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC54419302;
	Fri,  5 Jun 2026 15:36:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE663D0939
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673773; cv=none; b=bcBj/iyTvIupRv72kzRvFMQ/0Vlqesbdh0Zq1uSE6bkMAe3ei2yB5wtndvsLd3rV9TNfuYS14iFBkrz6lzEo++UyfaHgM2Cvioam1QITnAlE7l4PBhfNybzs4Xqv6PJm0OntS+VXosqPKefsmzBWnLrY6XhE/q8bZsuQ86Cm4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673773; c=relaxed/simple;
	bh=0y//4rDUHeoMAcQaZSh0ER1HWxLRRPwRxRm1NwYVOyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiYjinV9jNV/icThccvO2PxyzDRw1JXFfmKjuuPHqbLI4mSzw1xIOmK+OBXUKa0LYeT9RkeSo4ZyoadyLxFQTJXkxIBc3b3+4gMv8F24RgMVmTIvnVuShGK8FleBI8FkbJTdhDfZlRgpWbGcyenJM1yTIKds1yc+A7UYNL4Qatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W388OB/M; arc=none smtp.client-ip=209.85.160.53
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43d3454f643so864570fac.0
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673768; x=1781278568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhnCvvePHahC4Io7XyZr75rJ8BiYNr3mH21CPC3C4jQ=;
        b=W388OB/M5YtmAtJid8sd7D2hKxIFIgF34XEM6OvL814KTIITld9mvcPxen7jbhkeRT
         o/iEAs3xq9nZVW4lKJ/JKE6pgoMpTCZ5tsEsHd4Ou1qE9m7/Lq1QDV1N+4OcfNIJttCC
         SjKy7RMCp68QeP4VMByM6Mfj+e8j/x5WOcq2Va80k3+iE/Hi3bbNsbP7mjRS2s5nCfV3
         /NFa8+iPBzwShxV8aWx+FY+bwYxwb+yaFu4vF2Fd7oA7rWNULiTO2MblwSc4j/OeIUIX
         09WOwPG7c3lgtT81NEkbKzraTf5X2Yv94JYqt8z4DR7M83ns6APHW38VXaYWAlSng1kO
         iTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673768; x=1781278568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhnCvvePHahC4Io7XyZr75rJ8BiYNr3mH21CPC3C4jQ=;
        b=gVNKjYJHYISMW+uQUDA4YBnuLtcYVYTkXhdC3FgSuWu4mLb+IeCrC4jy6hHTLjzSZw
         LOqk+A3JIbXeEkjfmb2041iwBYm+4N9zxPRFC/5ydWwQ4/y0LtNWECmNWl2R7w2D0kl/
         IGwUZMHqJyWH2v24i6Nx7+PEBGscPnrkGzl16rsec45yQ13CugMaYbPlbxdN+UfLan+u
         QaB2lofHHqCX/AB1d1hxJyquhD2zGWpdfY1d3bbkNVD4b2qZVMCpZpwimjgrZFmFFs/a
         VcjQgbvOXh9qhoXOMl4BB3TgS0LRn6nj85ONhcgZqfka3DIieJOYrH7yZ4cLHN3tbKG9
         X0qA==
X-Forwarded-Encrypted: i=1; AFNElJ8NlY/SmycFDj77ixNk8Q40+D/DPcTy+SwQvTYrr11R9VkBgQtx1j7Zta7ky+N4KBqYOMhKTD0v@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLodwdp8Xu4InYXeHVjFMVq6oDh1YsZdEotq+wcE4Eg8Op3OZ
	/nyeqCq1sTnoULR5OCoJCTE3HfF4kg/TRv1XoPFItaBkpgBPkbIGc6b7
X-Gm-Gg: Acq92OFE0BZuxF5vpiYtuj8+GKzIiBwvKcABf52JMGmamVAEqTtMt0/3Vem6gH2jw/n
	8FRw0mQisaAakGdXCyRhOmXPtWQZHnFSOR3nCagSep/ZQyBRxJVgpnUjNcSdKm9w4A+ibzmpAQ+
	ODc3TC7lz3yl1+g/wEmhpUyirokj0tMx1UhtUO1WgLogdc+XQ1JyktBP+u5lvlWKzvsbi3StsVH
	PBWOG9G0o7VbB8Idha0NHvf9b4L3KroSLsxlVrEO333rn4oG/K8Y/kNvAkwvHr9UlXenGwrMFUS
	m+CWVLiYatu9KmyC/X0QwzJQhykhVVgNKWvm04CbeaMipC6tA9IOFKfi6FQdKIIAgUefu56m5ED
	AU4++Uy9CiT3tH9DCUeGbxYg7XTcxjfHBofaMYIon6SLTU0ctdCvchbqvTfVLTay1igZngdHRhp
	bG0eMdcTdkKOKMQ24V4k6M806e+jkSwj/Nm9QcwdfJ+KXQ1J3mZpdnUXpFS000XXE=
X-Received: by 2002:a05:6870:6c16:b0:42f:f368:e025 with SMTP id 586e51a60fabf-4413d373994mr2318480fac.10.1780673768386;
        Fri, 05 Jun 2026 08:36:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8500f0esm7271313fac.18.2026.06.05.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:08 -0700 (PDT)
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
Subject: [PATCH 3/6 v3] mm/page_counter: introduce stock drain APIs
Date: Fri,  5 Jun 2026 08:35:59 -0700
Message-ID: <20260605153603.234296-4-joshua.hahnjy@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16671-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D5BA649748

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
index c92bb2ee2a581..4a88874019af0 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -111,6 +111,9 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 int page_counter_alloc_stock(struct page_counter *counter, unsigned int batch);
 void page_counter_disable_stock(struct page_counter *counter);
 void page_counter_free_stock(struct page_counter *counter);
+void page_counter_drain_stock_local(struct page_counter *counter);
+void page_counter_drain_stock_cpu(struct page_counter *counter,
+				  unsigned int cpu);
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 1a71de4f43fd0..7e7eb683472d9 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -378,6 +378,40 @@ void page_counter_free_stock(struct page_counter *counter)
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


