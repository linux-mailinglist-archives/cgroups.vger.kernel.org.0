Return-Path: <cgroups+bounces-7564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96616A89228
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C0B17D84B
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B5230BC0;
	Tue, 15 Apr 2025 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fPRMKG5g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1722FF55
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685256; cv=none; b=lFkpfmR+b8W9W6SeSS0C1bxQ46+vLUaKuvwQ7FcR5aMfj1xy1hzrF3qAQjxJQMijfkzWeF2e2e89d6WEEpeppSQlQ/J+80nsnq5DM0bJHZDpNUntoseLJr9Ho1f28Pf7h+L+gN/v0DnEd8gMOjOoYY2TN+NxWFfoWPY9VzWT+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685256; c=relaxed/simple;
	bh=wFI5xoUcr+PPoN6JLmUH0KSJpkttQ6kHDTWRm3toq2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCzbPqgrOSrYWDsluvCxpqc9eTY7/uwYom+gts2alIjh9SN41WnaDEO+d3cpAIdDy75TVX2wmN5bPXxEvYhD366frultgV2jVm//1NkQcFpBpFJ7yj54XWH+6jphdbdIWwtZGufp/H1/Y5ZLPDwBJ9uR/It0DGRd2jW17W2XpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fPRMKG5g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227cf12df27so40404565ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685254; x=1745290054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXD1JHisUM2V0YMP9gwUIK79l/C4R22oOynHqMcLpgg=;
        b=fPRMKG5g6Y4dHSqFrX0n2724FhvwdUsiZGPNJiB7fDJexa/TcNF+jVGi2OvahkabJf
         iO5817tdTejqojD61CIp2CbNG1k5HMEQQsDFPCx8j7SSREWKdI8TRRtShuSNQVIZhhBu
         7zGMRbRAHc4EtRxx6GjMFzKZzifCoj4kIGGQgyrNg8EHU7CbbYgwTk+cLUc8sv743LhN
         MKYNydY7KbEL6LuleCP4CMUAyNAcPBk3qqIx1fx1W8A5Vn6M6sFJJzsrNYbcCBwoA1Ai
         xFYLuImy5NcNEhAvT3aAEATnvDzBJjaZ7iIMiHlnhA9JT+LsrCv2PwZks9TvuJHGNClr
         2XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685254; x=1745290054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXD1JHisUM2V0YMP9gwUIK79l/C4R22oOynHqMcLpgg=;
        b=nETMJP/RgVok734IwoI5IVON/2MF67ufYw36ieQAjC1yERHNKjWvKL78hu/7d2bpVK
         413RFaqZ5VvR7Trl+M3xGR928SmDPg7NXyzfyfPTfBrwn3sNJCuSZGiBtIZFAhFnHMS1
         1mWAFLqUC8asfV8DHT493lraYJyzBhth0jOboau+9ncmcral2xsZ5Tf9LcxpUMFc7H4+
         F8fkdV7/YYyghDsSnfze+SYkdTJerCN6ggXWIuLfiIfRXWz7tSzb+ZtkUxbp/Wb9lOY+
         usRvKlEUf/LR8LqvyKBfZc+xpPbLPPCmsWKHMTm2TLGFohlrkw/UG1YXcFTWoCGCV2zj
         uHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpSOf49Csh/ksPEd9kPuYMpEFm+9Zouj33LpuZK37DwJhnTGYI+anXnc3O7vi3zivOAtvF1Wc@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqrA1qsuVlOWbvTyjhV1UZEysOML+pGZ4vEqZy2VL54bkmbwV
	rI6ahQ5CgiZhaCY2vetLBnbIuBQFQPUp/JdufEQON5U9DHlTnFTr1r1mPTdlNbk=
X-Gm-Gg: ASbGncvMpV2OohXYbTVKI4zbLNawUOzrh8FP8QJX3rn54ySn+RIjoXq9p+zHnaaZjp2
	Kww7W0L4uFKgyDSxV0z5djeuHhYgV7K785LKB0EewprgPXueojti9R/FmRbkJ2HJ3CesPmscdF7
	0WuBQ61aQdDTB2dr4XUHhI2eukZd8MuFlAjHU/T8tOHKtOBLzAzXZh53AVkoA7HzF9m3Nh+cRZk
	mWCLhmqYdFEouShdGe5A9++4xp9wOq5vDg6KL0ADuTpGpvm2QdTxnYHtmowFAEvZGr4gGacMIBM
	E+VHsqxXvwRWu2GdOWoiLP6nv2JykpJ9SeaxSoSW1j2cA07ggaZrcjjiNqT2ppkaA0Hw8GRo
X-Google-Smtp-Source: AGHT+IGov3Ukjqy6KHI2Ta9mNCWkvrqJ5tO5c4YlNBGkmYhVlyky9mFum65/WmO/B3bYIoz2x2Rf2g==
X-Received: by 2002:a17:902:c942:b0:215:b1e3:c051 with SMTP id d9443c01a7336-22c24984d66mr19690505ad.11.1744685254245;
        Mon, 14 Apr 2025 19:47:34 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:33 -0700 (PDT)
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
Subject: [PATCH RFC 18/28] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
Date: Tue, 15 Apr 2025 10:45:22 +0800
Message-Id: <20250415024532.26632-19-songmuchun@bytedance.com>
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
against the release of the memory cgroup in mem_cgroup_swap_full().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09ecb5cb78f2..694f19017699 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5097,17 +5097,21 @@ bool mem_cgroup_swap_full(struct folio *folio)
 	if (do_memsw_account())
 		return false;
 
-	memcg = folio_memcg(folio);
-	if (!memcg)
+	if (!folio_memcg_charged(folio))
 		return false;
 
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
+		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
+	rcu_read_unlock();
 
 	return false;
 }
-- 
2.20.1


