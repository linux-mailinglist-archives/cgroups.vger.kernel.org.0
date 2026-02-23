Return-Path: <cgroups+bounces-14172-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF72CfLWnGkJLAQAu9opvQ
	(envelope-from <cgroups+bounces-14172-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:38:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8917E709
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47B5D301BDCE
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B737BE64;
	Mon, 23 Feb 2026 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPjEDf68"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED237A49D
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886319; cv=none; b=u2mhPA564CVrKhiEPsaAexCyI1/YgJBQrf7QU7ANVASPlyq8FHbE9EEp9xTvbnGxdbnL8HO+PdFJoPRVerxxmjJoL4MhMO5TU75/CtdR2Smaz2u9tfLI0PpNYGptP0b+eWAKMgmagrABhTVR/tkc5YXAIVA24WSERHNoiF0evU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886319; c=relaxed/simple;
	bh=CaHKfHzTnSEHysdxeu/IeDFU49MuR1XQ3fwEJyAveAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ebxwh8PDW2GiVozbFazoKeUTq3JRf7aWWXSRaQnE3Qv+/o1998oBGrRqNDXlUN/5xB9zUQsQBv57sz6e6QWwbHllWeUyVCvZbCuynpHPQFa6sHDrixYpVYSJgcBOzZ+UFLRIWV67x6WARlnfyM4QQrmXro0TJPFcFqxv0N+/aKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPjEDf68; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d19d3c7208so3437235a34.0
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886316; x=1772491116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQzkmrIS51etVi0n5gq17TgjaIpr+hzH+jF14jX4sdo=;
        b=mPjEDf68l6hiid2EqfuyhHlTz9lrGl+PBYPGHQ1en0dIe5lvtm0LOs62bAOS4YOfeu
         HML0WyfVtO/UqJ8XW2UNq9YciWUpNdaSxVmau5iQV9uA8EHcMsbXzUq+B3JOD0Q6Af+e
         3slCfmkOeW6AB9u3nOmytd4n9703GagipNDPaFCZes1Xz8X1Ge3yuz3IMjP6ctjpYIM5
         6LnhFWfQDQija+JRiIqG7PH1iDpwF4DqNN7VJhYWZXosAk5fYffmSuQKVwriPOBlwWdn
         TXcffbl2FkfBuN2kDoJMJ1Cp7qmxV+8Dxjmk37CF2mUFP4udyb79LNBAPJrYG3J2d5Wm
         6bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886316; x=1772491116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQzkmrIS51etVi0n5gq17TgjaIpr+hzH+jF14jX4sdo=;
        b=WfAXfS/+AlqP8kWjXtUmFfRRjjfAiGuNX8/zSopVmLYxZoQpxKzAZ5QszfuGQQ6sMi
         v60+YUiXBRIrpI/2b4tYCJFuFyQgn0eN1bHs7tfyZ/HLNQ9kE1FjS3ikCkDngUP80E3B
         ZGmRI8A4TkMwrPphe/pWUlmG0WxuegdLKPL45kijeuTIWLDQLgAPrHRrnX8sUMYkTXVl
         ylIIKACEPbKsmozhZXJHsklpMlRBS7JmV1eC0oCfipkmuNfqYvf3FR2ekiUG/1nlcTnR
         WdpTw196T7D8l/Q9Dor/GCeA+Cg4tfzu3WsiWvtZGCKSTBtDKGfFiFzZz/wVXbFVyMHI
         BR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5QHVL7vOvi36k7gkr7Fi9Vz3gXKZZK0q4PtK/sQPFv4Gm5OnfqsqwOAOJcdefPMHEYHtWO3En@vger.kernel.org
X-Gm-Message-State: AOJu0YxwAZf45ySnfYjkX6XadiEmNrNsMK+wFTZmJCjdZD0IaK1kb6g5
	X2PmlIIyCVYXFnkDRMLxcVVmFTvdz2dF9rv6yWPoYWsa+3qy4sS+ISxO
X-Gm-Gg: AZuq6aINYxYxn9/kp5hcakX5Kn5FQsCT92VQgoO6dAMizZFXQGganPkTiLOEXCSLyAj
	EBC3L0R//qQU02u7fWYWK2zTSXTXWzdziRDIfYuHx3EQ/1eWRXWH/qXGh5V2NdOnrteGRAYM5iZ
	uNN5Ea4bR0LAT8eDB8+0YS6UzO7HYX5jZMA+b1uR5Ed2t/vaek9tCFo83eXYJxKTTculKEXnm/H
	HZiQyuL4/JIAQ+bHNj2nPhBWmIPKqJATOGd8quaKApipqcS1Z05mReTY00knJhgjm/7urz2mtle
	xMwfFk3pm461c210TwvYg+yc0dkoYM/zW/G9F8XIf4vcf0MztdhbJAiO+c7Govd80SXJPtYvE91
	3h4JkB+ZK8JfWXwo4rEtfLe2Zm0BUfnvBPvzs5cnHRoDE67LEyqIRFInQAm2Ewecq15CCSREv9G
	r3YFecNgmb+zGzewKx4P7g
X-Received: by 2002:a05:6830:369b:b0:7c5:2dbf:4a7d with SMTP id 46e09a7af769-7d52c1c04c4mr6267036a34.31.1771886316479;
        Mon, 23 Feb 2026 14:38:36 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cfa03bcsm8389594a34.10.2026.02.23.14.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:36 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 2/6] mm/page_counter: Introduce tiered memory awareness to page_counter
Date: Mon, 23 Feb 2026 14:38:25 -0800
Message-ID: <20260223223830.586018-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14172-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCC8917E709
X-Rspamd-Action: no action

On systems with tiered memory, there is currently no tracking of memory
at the tier-memcg granularity. While per-memcg-lruvec serves at a finer
granularity that can be accumulated to give us the desired
per-tier-memcg accounting, relying on these lruvec stats for limit
checking can prove touch too many hot paths too frequently and can
introduce increased latency for other memcg users.

Instead, add a new cacheline in struct page_counter to track toptier
memcg limits and usage, as well as cached capacity values. This
cacheline is only used by the mem_cgroup->memory page_counter.

Also, introduce helpers that use these new fields to calculate
proportional toptier high and low values, based on the system's
toptier:total capacity ratio.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h | 22 +++++++++++++++++++++-
 mm/page_counter.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index d649b6bbbc87..128c1272c88c 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -5,6 +5,7 @@
 #include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/nodemask.h>
 #include <asm/page.h>
 
 struct page_counter {
@@ -31,9 +32,23 @@ struct page_counter {
 	/* Latest cg2 reset watermark */
 	unsigned long local_watermark;
 
-	/* Keep all the read most fields in a separete cacheline. */
+	/* Keep all the tiered memory fields in a separate cacheline. */
 	CACHELINE_PADDING(_pad2_);
 
+	atomic_long_t toptier_usage;
+
+	/* effective toptier-proportional low protection */
+	unsigned long etoptier_low;
+	atomic_long_t toptier_low_usage;
+	atomic_long_t children_toptier_low_usage;
+
+	/* Cached toptier capacity for proportional limit calculations */
+	unsigned long toptier_capacity;
+	unsigned long total_capacity;
+
+	/* Keep all the read most fields in a separate cacheline. */
+	CACHELINE_PADDING(_pad3_);
+
 	bool protection_support;
 	bool track_failcnt;
 	unsigned long min;
@@ -61,6 +76,9 @@ static inline void page_counter_init(struct page_counter *counter,
 	counter->parent = parent;
 	counter->protection_support = protection_support;
 	counter->track_failcnt = false;
+	counter->toptier_usage = (atomic_long_t)ATOMIC_LONG_INIT(0);
+	counter->toptier_capacity = 0;
+	counter->total_capacity = 0;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter)
@@ -103,6 +121,8 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
 				       bool recursive_protection);
+unsigned long page_counter_toptier_high(struct page_counter *counter);
+unsigned long page_counter_toptier_low(struct page_counter *counter);
 #else
 static inline void page_counter_calculate_protection(struct page_counter *root,
 						     struct page_counter *counter,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 661e0f2a5127..5ec97811c418 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -462,4 +462,38 @@ void page_counter_calculate_protection(struct page_counter *root,
 			atomic_long_read(&parent->children_low_usage),
 			recursive_protection));
 }
+
+unsigned long page_counter_toptier_high(struct page_counter *counter)
+{
+	unsigned long high = READ_ONCE(counter->high);
+	unsigned long toptier_cap, total_cap;
+
+	if (high == PAGE_COUNTER_MAX)
+		return PAGE_COUNTER_MAX;
+
+	toptier_cap = counter->toptier_capacity;
+	total_cap = counter->total_capacity;
+
+	if (!total_cap)
+		return PAGE_COUNTER_MAX;
+
+	return mult_frac(high, toptier_cap, total_cap);
+}
+
+unsigned long page_counter_toptier_low(struct page_counter *counter)
+{
+	unsigned long low = READ_ONCE(counter->low);
+	unsigned long toptier_cap, total_cap;
+
+	if (!low)
+		return 0;
+
+	toptier_cap = counter->toptier_capacity;
+	total_cap = counter->total_capacity;
+
+	if (!total_cap)
+		return 0;
+
+	return mult_frac(low, toptier_cap, total_cap);
+}
 #endif /* CONFIG_MEMCG || CONFIG_CGROUP_DMEM */
-- 
2.47.3


