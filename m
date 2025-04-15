Return-Path: <cgroups+bounces-7547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9778A89206
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C618997C4
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F821CC68;
	Tue, 15 Apr 2025 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EyDAunD/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60A21A42F
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685163; cv=none; b=Ti6GEaxlrPeGa5YypLgelL9lmtjewkvBRbErfp95nh7ARC7q004MqZ41RKX5ZWwgPfRL0PRZBucCIj29K3YzzW3hiZjwt5W/QPbHPapBu/+7vZX2H3Zf9QHxeN1Gc8LX9w80ofCY8MO7APAxsg0estGrqW2aayK/n6AlMR15YDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685163; c=relaxed/simple;
	bh=IbU9S+gNd9H4vOMxRrhOwxpGymSk9IS2B1xUn+hKwUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1xlCe802a+5tXIWICTf5AL0tp7pDf6+gXv0D0bMV7I3nKfNshy2WQS2fPpLxeQlfDIKw9R1wGAnRON8aROADijhCDe7eYRSXFHwsLzzcmmDrp/oBzE4oE9fby3WIJ94AmlEXpi4YbivW8Oh1I6UnaMj0bj6vej7eddgML1epwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EyDAunD/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b06e9bcc986so1679420a12.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685161; x=1745289961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8KzBx499Eh3TwCUOfkq+U0TMdvhQzDUhsoXtCDxKvc=;
        b=EyDAunD/dohhiGW9sb9mdr1h04B1Sp+y1TCwYmeUUdwIhuXAth0jBjxwOboAVKWSmj
         fzPSykXT6rnX5VfWfUQHXEBoo2WQfk4j7Mz8bpiKyBA+TFdZp3wSjH1s77KUhqjbZitT
         67eDbekpKJZpqVIOJxETII0a6h6iaDvNyvn8Gntnnd4bEEgpvzYt8dtnXD+5MwZwL2PK
         HteGVj/5I+POEe7TERQMOfBn7OZsTPVQRgPCWd2N7PYiiQMM12h/FsYhobjjLd5HyW/g
         Fm9+Rk/JFZHRjbR4YlC23cfa9TTSRu23K9gP7xl97By8/p7OpJGkmj3sHnNHAKZhbEGz
         v2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685161; x=1745289961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8KzBx499Eh3TwCUOfkq+U0TMdvhQzDUhsoXtCDxKvc=;
        b=kGdYszYeQ/cHl6/CaHHp4v8gQmsBMGO+BPHIvomTsQn2TZ7nknhm+Qx9OFbmGFFSNM
         d26gbUw4cphRSpdRd9FHvWHuJFnKHFCpaacVfqmg0K2T6V1YX1zwzBTaCb+jHAQbW4oK
         6LkfFqdoKOVJToZrlhYmMc5EuEA30VU1naWfzX5D2/xfsSwvvLjov/9o4CpXfxkOhFYH
         ZNKlJhr1bshb//0TqVgiBI9WrOIMIVUPoRG36qElMlWAxWWvQY5Ll1JC5O8XlQiZCiCL
         dNhYtE4q7a7GXlrbZAEZTrjszmg+VXLag3jZxuIF8j/MKsd8g069/kNYWmG7nfEF+8q9
         qCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV72Efm4i+nHeMil/IDflbZIJe22m3gatDf5YBxlk4mYmAv3P12vYm3yW/HKB/NWI/HFXePmaVG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WOYGZnUrcMFG3cnhTHVAB7BGETKusPA2ZGILBB8fH9GEGa7d
	dPPcotTY/NcXWKeOMfLjHS2r9JsU/MxQAq0yvTwxNYtfUhW6M1W9BkrLWAgqShE=
X-Gm-Gg: ASbGnctV8EYKsitLSQRHj2WKd4aY1qiZqBg1W1+1qIU8uQBkSDqr43HppPwM1gF8tzD
	ihlmt854OFSS7eywM0RZyxjk8WIlqlL5eCiK7xWRjXPSW3xg0KUAwr9vGNg/AoImK1z+SV6kcM1
	ThPvZJ70+/m8lunp3AiYAB07HnD0s6KulGJlE5VwBcId3lf+p8qBuhzsWdgzY4oqJbkGr8+zZeA
	LXcNh/sfi9FWDv4e6jtVTvI+9jboXM/1TA/hrbBzOCusCZ0gnO5JDQC5ruiFZqkjfrFdIouBnfJ
	ojdI8g97U+ZrLkYOKHotiAgeWBXkMNicmTpXQkwXjGGM551dCwXdyFSStYZb7v03CqUoAKZV
X-Google-Smtp-Source: AGHT+IGjusvGNjKHuKsmMzFyHvfJ71DX0fIRnpQJPK83MJ7aTNHlxqG7qwINGqRKJ0KYDTG88Uch2Q==
X-Received: by 2002:a17:902:c40b:b0:223:88af:2c30 with SMTP id d9443c01a7336-22bea4b3c03mr161252765ad.16.1744685161415;
        Mon, 14 Apr 2025 19:46:01 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.45.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:00 -0700 (PDT)
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
Subject: [PATCH RFC 01/28] mm: memcontrol: remove dead code of checking parent memory cgroup
Date: Tue, 15 Apr 2025 10:45:05 +0800
Message-Id: <20250415024532.26632-2-songmuchun@bytedance.com>
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

Since the no-hierarchy mode has been deprecated after the commit:

  commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode").

As a result, parent_mem_cgroup() will not return NULL except when passing
the root memcg, and the root memcg cannot be offline. Hence, it's safe to
remove the check on the returned value of parent_mem_cgroup(). Remove the
corresponding dead code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 5 -----
 mm/shrinker.c   | 6 +-----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421740f1bcdc..61488e45cab2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3196,9 +3196,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		return;
 
 	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
 	memcg_reparent_list_lrus(memcg, parent);
 
 	/*
@@ -3489,8 +3486,6 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 			break;
 		}
 		memcg = parent_mem_cgroup(memcg);
-		if (!memcg)
-			memcg = root_mem_cgroup;
 	}
 	return memcg;
 }
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 4a93fd433689..e8e092a2f7f4 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -286,14 +286,10 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 {
 	int nid, index, offset;
 	long nr;
-	struct mem_cgroup *parent;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct shrinker_info *child_info, *parent_info;
 	struct shrinker_info_unit *child_unit, *parent_unit;
 
-	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
 	/* Prevent from concurrent shrinker_info expand */
 	mutex_lock(&shrinker_mutex);
 	for_each_node(nid) {
-- 
2.20.1


