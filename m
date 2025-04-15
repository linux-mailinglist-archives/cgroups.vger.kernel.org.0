Return-Path: <cgroups+bounces-7571-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B965CA89238
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D8817D937
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B3235355;
	Tue, 15 Apr 2025 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iPMPiQYU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98182235341
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685293; cv=none; b=PZ3nIVs/rrV3JgBKufXVzxHf+LlTrri/Nqx7CeuBmpCW9SERROnz+5gIDT5SCPRtyYexkMDhLszuWoRKzTabmG+twu4JEGP/FbjePGwzu5GzHZ5/jROCJt2VTtXRU3U9ULF90UMfR20di5+y0fE6VttR3fuB/654MSsxUYj6rRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685293; c=relaxed/simple;
	bh=b6WgT5AaIyycVV1DlaIxlbeB9KrtvSXL+2l330r8XW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aqz6HPyZ+0K0G1TsLi+SXMktWCOKAqUdJU6ob6c6Mv5FSQi0PZlT6MJF3BS4mB/cLzcQFSsxYRImFU9uuvdR0K9qsrCORBJe4GdhIixiWZp3At2W4xnNvGhK2xCN4S8HMa3S/pqyq6QRapq+V/Ukn5wWsowR27KylYtvX8UwgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iPMPiQYU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-226185948ffso53594405ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685291; x=1745290091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzey8goXEog+ZffEsOrcu6z/kqiEK8l86D0gwmtPc7Q=;
        b=iPMPiQYUKy0rh8fGJ73HTK8N8RjpFAX/nGm9ovu690ajo+aQyVkKd39wsEVWKum1Fe
         lc4kjWq2aN7cDDV9FEbs0AT2/dkgz09I/9nOhSdObb5OxYfHRGUsj7TC1L6FLTtSEUJ9
         FO03ofZIgWYDHSs9vdOmk6GZccUo7v/p8jRcyfuuOvvty9LgHMGi7XUxy+ZZ2SZziYqj
         jxyIQFrvlRtT7MlgTZbpIE49zGmEdx2WBpMo/JbeOr2M7xPdEoW3ECPLdPL5+aToRfYn
         SiUBlV4B9bfo4imXtCJ1dicbs17gh0tQ4a0y1qZUGj80D6aB6XOAeMAA317LXGZ9Biwg
         AyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685291; x=1745290091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzey8goXEog+ZffEsOrcu6z/kqiEK8l86D0gwmtPc7Q=;
        b=dqQsUoo3h92vBEy4sw/Fttzq+bAI5zi22V+UA1E+7US7IVS6tj0It83zH6DdcF2AVM
         60hFPjyxahFFUBb/wDfmmHur27nl1KwDYPFI5K7WyekRS2iyRvwYhUqwPZelq52W0jEk
         RcUvgIG8MX8aY3nsfr1DgfOS7rxqo5KwTD6g1sGExuOAW4aFIf9IccjUIHDr/X2L3glH
         85R5pvy3Rl0WEUjH14efUK09sdPuGBa3dUhDW3CbsWaPRO+4qwOH9VskueGR/iBasMOj
         DHFbKdfKbUCgIhY69YJSSrH/26C433njsco9YwLnISDKjG8Jq/62xjCqCRgeS+XYOopy
         CQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvAxu1ChjE4Dl0b0LdSe+1Fjj2AtByJ5fWhaKq8GNrTzGeKtN9B26dro9DoUEdvWGo07wtraMF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sft8dmDhYNPfpOwaV+/NlFgG2+4EA+/LGhfT++AUcLzTClsJ
	2n5I1FIqdMQ1LR7PlqMAZZ/2+oGCq51GPY5NCSeyue7q8F3Dggc7xGEfD+gwoes=
X-Gm-Gg: ASbGncuobt16k/NuANgC1wHx6gGYuBoiqj2v10NK5OAxEH/LaDeDcIoSucmpLNoPbJH
	PpCtUCCN2+kKRzcd0Q88f1IsKTYIpjmG/moVMilc3jTIjnWHa+Is6J99bEqEqo36gTjaSm8ya2R
	01AA8EhbSyOy+YPXvDUb6ahQeK65SIrmDH3XkKTmF4Zglz660Y0DebMMT6tLvUab4lUpxzG+AIM
	/Led8A2U2ALpZ69SmlvSuyXgym+/3mTs1Vzb08+UUgx+gyGvreUOsUXPXRhJXf1s5BdZlTnzkSt
	mFZW5J7wGO0IyePgEAcW6i68Y2spVrENv4AZNSmAKe83UHwQevtqg3MqF1h3J9CHqNJvh1SNkIq
	SXR0Tqy8=
X-Google-Smtp-Source: AGHT+IGKYbRxT9nU7SMJ0Zxzh0coEyzVb1MW3k+CSg2YANyZzMz0FPRUg+d3lPphVCyM8bkhwJIXdw==
X-Received: by 2002:a17:902:eb8a:b0:220:c813:dfce with SMTP id d9443c01a7336-22bea4f273amr208688465ad.39.1744685290927;
        Mon, 14 Apr 2025 19:48:10 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.48.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:48:10 -0700 (PDT)
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
Subject: [PATCH RFC 25/28] mm: thp: prepare for reparenting LRU pages for split queue lock
Date: Tue, 15 Apr 2025 10:45:29 +0800
Message-Id: <20250415024532.26632-26-songmuchun@bytedance.com>
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

Analogous to the mechanism employed for the lruvec lock, we adopt
an identical strategy to ensure the safety of the split queue lock
during the reparenting process of LRU folios.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d2bc943a40e8..813334994f84 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1100,8 +1100,14 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock(&queue->split_queue_lock);
+	if (unlikely(folio_split_queue_memcg(folio, queue) != folio_memcg(folio))) {
+		spin_unlock(&queue->split_queue_lock);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -1111,8 +1117,14 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+	if (unlikely(folio_split_queue_memcg(folio, queue) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -1120,12 +1132,14 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 static inline void split_queue_unlock(struct deferred_split *queue)
 {
 	spin_unlock(&queue->split_queue_lock);
+	rcu_read_unlock();
 }
 
 static inline void split_queue_unlock_irqrestore(struct deferred_split *queue,
 						 unsigned long flags)
 {
 	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
+	rcu_read_unlock();
 }
 
 static inline bool is_transparent_hugepage(const struct folio *folio)
-- 
2.20.1


