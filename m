Return-Path: <cgroups+bounces-7565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B5A8922A
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4887B17D812
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0C21CFEF;
	Tue, 15 Apr 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ehc7iTpC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E72230BD4
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685262; cv=none; b=KKTxQOMMnP5iqIM7J/m6WjQ687YZATtumn76dOQKgxAFrxAYnFcNFPST8LQm9sDZW04i5XJlCfKcIAJUwVq3Mqb+NAyHfdD7SMjFGuS7pkASxwYmRP4pmzjL/tJHTMwbF+DO4orLWDQGigEN8iyyI12M9m1eSm7wp2kIr355A/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685262; c=relaxed/simple;
	bh=Zzgrk1/+DtDOPybbX6ZvBHcnSmm0kFUZaAuQTqVa+nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuwFo085B3z/xxFUL+LpwJgXsSvTQ1w/11csfMAKAEZxwLqJX2wiMEkQY/JrI6qsBqbeGM9GQ3fgi52JTd6XSLF3BhrKSZk/DT+mdiJKJfmwU+MVDmayTMAtnxks0f8ZKvj2Jn4z0LkFZtUAtnywM/rwrg8bns6jQiWqi3Saujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ehc7iTpC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so74083735ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685259; x=1745290059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il+WlAu7ECEYeHNnJ6w5CmqDQz43sJSf6crApj5k5Jc=;
        b=ehc7iTpC2DdckSPuuWMaY1Wqb5WQbwFv4Xx7W3kU3v3/bUWcyHJu0jQ7AKvT+tkjgv
         UqCS8DJxBmmpKmIL5d9102+Cl/JHy+d047GmFARRPiomaspG4pjs62O09mytSw5UCrNi
         t4BMebti0+VvnSLf/OjbqHsO4KN2XEEUCTgcTX13spdUSaPYw/vOi0zBHVMHOD2jrVET
         WSm3/qUoWafT3cahRZlj3/U7MM5Gst2UcEaOp+B8QRcQy7XqyrP8v1xqFWbxWQ0+S6n4
         uFXCcn7qUv7sYEGhv9Z1FX1jYR5HFP5eEYXclRQSZ1EDSsZt8YGeqBKYxIwHvuII8ruP
         E2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685259; x=1745290059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il+WlAu7ECEYeHNnJ6w5CmqDQz43sJSf6crApj5k5Jc=;
        b=todW4sxWsHKlddiKesw0e/a27i224sygQoiaxmlooVBmDwlffj+ninwZ4ATRwM0tjy
         A7V70bQ37dGlPTY/PqHrcaEcEsdAHLjGa+vix8YHCMteZw3F6qwcprdSNhocvmMtOws/
         ZzQAWdyg7u2/5dtWa4RobUTgLKS9b9+hvay20V+526216MTz7XwmRQeAy4mVGr6xjQPg
         1/6jUGCQKkN3+qOP/bz57WGtbesh/0MOSIVeMLWwPMQcxzfO9p9DhwHdyr3Hq2rRwEGk
         nKb1vuLZ2iv/YsKZedo/+MktqeRlLOl50g8mRCsbgO3RN92WZ2I02vcWVKW7j28SKZVs
         T7fg==
X-Forwarded-Encrypted: i=1; AJvYcCVFd2zYENx7nZ0VRGwP3N58nmYSxE8JjxM9tlk/UX9YKdqxBWC3hvC9XKQw3eCUgDW+Sx0Nkj+C@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzrPORH2oaidknRp3m+cvIgKadXQtVDUHBUj5YhXTfkj5iqYC
	9CQe/5956ZhfGjcWmSqqNchFC6fWim8JeUFqCjFlGw9+6++uZV7TXJjBgvCaNvc=
X-Gm-Gg: ASbGnctEB7JAP79wT8E6yJpDczkKoy6cE50HyuiFkKigiJPI1xzz4H/VoakQoi0usEF
	kOnPX0U758d1o8Mptw4iUPzZxiTrIfi53G7azmED3c0+Q9x/oRgzZh+DId3qUubYt0MopSTn6ZW
	dvFh0GZcUMQmJye2XHnlOChjeiOS5hvSwjBtzRODf9tVEi9vrWMUya+8WArfRBBacWqiMyZ6fBZ
	ZT/pKkXGxptfGjUziKnhDDveOw9sh9S6mSL8hWjYD6JLbnbZ9NksQzgWQRFs4Fy4nk/JUEt7PC2
	/SXuBmlB5+UD+road715aNLYeB4Pt/hHVS8IbcsSZdv8UfrVaTpfqyqv6qYP5qVDTCg8/s6Z
X-Google-Smtp-Source: AGHT+IELTjYsxK3e4qqX4T5H1yTy2Tq0r1FbaCUPQTdjd2lEOKiB73ooWS5EpMEZdecB9fJL4bZ8Lg==
X-Received: by 2002:a17:902:d591:b0:224:c76:5e57 with SMTP id d9443c01a7336-22bea4ef9e9mr221732775ad.39.1744685259610;
        Mon, 14 Apr 2025 19:47:39 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:39 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 19/28] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
Date: Tue, 15 Apr 2025 10:45:23 +0800
Message-Id: <20250415024532.26632-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in lru_gen_eviction().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/workingset.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index ebafc0eaafba..e14b9e33f161 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -241,11 +241,14 @@ static void *lru_gen_eviction(struct folio *folio)
 	int refs = folio_lru_refs(folio);
 	bool workingset = folio_test_workingset(folio);
 	int tier = lru_tier_from_refs(refs, workingset);
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat = folio_pgdat(folio);
+	unsigned short memcg_id;
 
 	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SHIFT);
 
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
 	min_seq = READ_ONCE(lrugen->min_seq[type]);
@@ -253,8 +256,10 @@ static void *lru_gen_eviction(struct folio *folio)
 
 	hist = lru_hist_from_seq(min_seq);
 	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
+	memcg_id = mem_cgroup_id(memcg);
+	rcu_read_unlock();
 
-	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
+	return pack_shadow(memcg_id, pgdat, token, workingset);
 }
 
 /*
-- 
2.20.1


