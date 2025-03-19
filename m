Return-Path: <cgroups+bounces-7144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9C1A68540
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AFC3A9291
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065D42A93;
	Wed, 19 Mar 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJmTxEzs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1924EF87;
	Wed, 19 Mar 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366554; cv=none; b=FCMZ1ToEm4hZ8aLEIntwTCzBPTyqiMgOBDtNv/s+qlJ3ReyNMW0cOy4evc2JjN/hiAa3/E///wDU1woNpEwLgtxtqY3TuuEdqoPBNy9go7z9M70F14WAhzTRZBIPwFmspn1mNyywbAIs9S4t3khhRO+/Gp5CM5JLmSo9dsfhHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366554; c=relaxed/simple;
	bh=uwPVGWmIAA6vjSh3MMDGl0gpuzjGJtL12wVwx5zcRBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cci1+GArkd5rvxFEK5adcig8FWMBuKOiELXmHHiYDtXxev/U4UqNYgC7p1KZrdluPyEpwSGeeHKQ5Rttufb7Ve37f0aGygdzS+4eGev4Qo3F7PZRNUIPOY2r/f/WnmbBiF+Bwy9bGC6E6OViAEW1ukMETAF2TVq2Ul2WecyDoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJmTxEzs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2254e0b4b79so24660815ad.2;
        Tue, 18 Mar 2025 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366552; x=1742971352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDGgoAuFU1j/4cPuHxdFsXeRUQzRKuxaJDEI2tA88sE=;
        b=MJmTxEzsMfOWora5PAlwLqTUVhM6mTNaE0w7NtD3AxOE4ZBG/ltLpXCavVY/+dgcy4
         QNBraYRA7d5Mj/L5Mq89E06jddhSOuNpdpJ2t15doWEZXYrblTF3WJBi5PX69N/2DQKP
         v3mY+DHdlZrIVn1a0P9tOiePTbhV1a9bxAbOEzTd+4xmBZ7ZPw+kmDD9G6EBvqR9uy7M
         jli6Cr3DCeNPU1JlCk3TMGB4jjMmtuh28tieZ6jkqAdefChR8RTEYiblv2R6kmsR1WUK
         CN0UvmmuAiAhxgFZfFXV/t13b1lbKM1Cqlqn4Bhr8JqVhzS8pZchy0UmINdjDX0LJSpC
         S/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366552; x=1742971352;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDGgoAuFU1j/4cPuHxdFsXeRUQzRKuxaJDEI2tA88sE=;
        b=oLtALAyYEzP4SZsEcJwdit4wN1hTnMnsqXZlFEsXqxgT7c8LR6GlIRDNrbRFzTDp5t
         RYP7KKSaURSvZC81zfevZBX77fD7/T1QkBHZq+IEWJXNQz7gMRfXWyiNrBC3AlSaPu9K
         IaLanI+HEUkgmG4KSKSUB/KgOYsTzBvV1DNtoNXV3FE3wDCYMJr/HqgtzWg8ILEC2fMu
         rgP4Pip2JWEzjJ1OQWSe8Pn7PWSfJFXbmzCTllKg6OKvItZQjRUf033EcrcAxy+I+6tP
         iD8O555AnL2MaAKFrqTwIiQCVyZ0iDWTPHLiZ5rQjNwqhLDCs/HMbFTXsS2o23j00auS
         yC+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOKdbYJaoL/yDZNP5g3ohByQw4QM+Atq393fTw79T4aNNjM5Iu1hCCetrQxlBzc+4ek0ce0KIx/KQmzTuq@vger.kernel.org, AJvYcCVSMeJHwadRwHnXtPivmwV71nE8iBiRfR/dPSu/2Cemc3rBlhGInkuXphbPdpCRnoP72C1ZR1Up@vger.kernel.org
X-Gm-Message-State: AOJu0YypHs2VJMkLk2cXpbklIO3m6KSmhp/bGzUb/Lu1qJHHnmzSrokc
	K3R+oKVNIdlpPkJ8IRFD2+hVZIp2/ipGPJfHecoRqSDpCapGmWO9
X-Gm-Gg: ASbGncuczj6F0B7kMN87t6OQVZQ4QHtozlLiggYPV46oxmo+bZFzc2IyGjGsnCgXOwe
	1qik9JQHmo/I92TxCRUlndU8bL/CD1rMEBcSrvIQqk+d+Q8vfbHsjQppxdZcW/IOfqWUfVhhUVo
	Kcx+sikSuOJUnadOX3nnPT8+vfYOG3fl3LgJfGgel6VU2DgvJz0/JDxnGu9r8/udgHOuTuhdpF6
	ix51kdaReHULqfhAFcY6DQoltrk4V4E8/XSkhs/IMBZpfGSnnti1MxLiFBQGZ71YB+ayVFD4mUY
	GSqZO2FiKUS/EawCi8StbOhRQ8VcOpSn6MX7Adbgtnwd1xvo5OWQnbYLi37lq1aky/Q01Yd2lLp
	HkEEg4RZOL3HGmQ==
X-Google-Smtp-Source: AGHT+IFAyKOiSRtBqjl5fZO4kWvi3a/4Npr3QIWJv0iu9jfu+/+dq5oOshJJhEmDYcMoWP8ZUFn2hg==
X-Received: by 2002:a17:902:f688:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-22649935c2cmr20608265ad.19.1742366552101;
        Tue, 18 Mar 2025 23:42:32 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm106191835ad.70.2025.03.18.23.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:42:31 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [RFC 3/5] mm/memcontrol: do not scan anon pages if memsw limit is hit
Date: Wed, 19 Mar 2025 14:41:46 +0800
Message-ID: <20250319064148.774406-4-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

When memory recycling is triggered by the hard watermark of
memsw, anonymous pages do not want to be recycled any further.
This is consistent with the processing method of cgroup v2.

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 mm/memcontrol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1171fb2bfd6..623ebf610946 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5072,14 +5072,21 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
+	struct page_counter *pg_counter;
 	long nr_swap_pages = get_nr_swap_pages();
 
-	if (mem_cgroup_disabled() || do_memsw_account())
+	if (mem_cgroup_disabled())
 		return nr_swap_pages;
-	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+		if (do_memsw_account())
+			pg_counter = &memcg->memsw;
+		else
+			pg_counter = &memcg->swap;
+
 		nr_swap_pages = min_t(long, nr_swap_pages,
-				      READ_ONCE(memcg->swap.max) -
-				      page_counter_read(&memcg->swap));
+				      READ_ONCE(pg_counter->max) -
+				      page_counter_read(pg_counter));
+	}
 	return nr_swap_pages;
 }
 
-- 
2.41.1


