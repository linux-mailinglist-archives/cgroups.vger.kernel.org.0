Return-Path: <cgroups+bounces-7562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075CA89224
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F47E17D7D3
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E522DFB4;
	Tue, 15 Apr 2025 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OQOaleIw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF121ABC6
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685245; cv=none; b=WlXj2682s8ZGCI3+SQin+jrdSFIqHKxMOTVlfKLB1Euz//qmGIzWcMPeeYqZnEAylLWTtkjCwhCH+6WVPbT3jZBzG5qLamA+FWb4JyihL/PR7TjctqWIeDEL70FDWY5TvMSHOlTKZhU74D20iZxoL717guk1Ml8xwiMtdTBUun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685245; c=relaxed/simple;
	bh=v5yMn5IixgDIQc8oleyaSWuKuE9z67T/Dq0pK11nZuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qka+6FSY59cRvYr5m+EiCTVbIj8gDyFhYht24SnfcrC8UtsBzufyMiC7ovJ1v89fq/tNBy2Oo3pNjkNSayRuNDQccSrh/lKih0lcM5DUjSi5gvHmZjJAXuRIi7aPQw5flExfiJK22bwN1sHhqzKm3po55OoWjPj4OUBQfkTvxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OQOaleIw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2295d78b45cso70683185ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685244; x=1745290044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5EyQKk8+6fTeRtjB7wRmwigOpyCG4thZQUtLcFoNss=;
        b=OQOaleIwWH8SiioPA7QjEmUZKtNsgGvNAClUiOjgHKllSTzbhThqIOh2R2FKNlGlV4
         NhGVzNHLrrC1JjcivD1R/3lucZD504VLoOOmgUaEACPQkQY+Mv+65wbipbjY0tUrjm3a
         tL4X4hkswJBuqirz4kCSU9kBWhMFzid7IfEIe4e6Hy4kTFoM4GDO57jP8oMwoM8sK2V+
         SiM4t4laA2I8kav++Yj73sV5I7Qiy9iIZsSAppwCLdUL+o1mrWNlaHUHMim0VpYiLCbT
         c1dfj5DuApjBJWUG41fatIpI8yDFLqLn5ZZcnWy0umwuv9ZVD3VvhidnnVpq7SYpYpON
         +pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685244; x=1745290044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5EyQKk8+6fTeRtjB7wRmwigOpyCG4thZQUtLcFoNss=;
        b=G+1mJToxvQIxaIhptJL04d7/DIE7uFO5smlMNBxbIDwoqYHXdL0DmH7NdKnkQIz8CD
         echQSWXkBtMogOKSY6FybdTxXZb9MHML5vFxpTowjvOdP8P/OPHmtyzadjcFPts8kt2E
         OMMQ9u/VX9/aok06ruZkOo38/KoWiwE3a1xq4bp5peDACVXzVYJBuf+eCBRdd3CP6xAY
         v64rgJwKechTP424dZxsqMfwba2R0yD/1ajEZlRlUZoN9Mf6bmtL3qJ6M0ZQgdEyC8IS
         jWYHnd054TiedgUDVdAzS+oL5G/jch+ZkHSSeGllZWCVFEplALpfwC4KAwrBeiVdTENj
         Ll/g==
X-Forwarded-Encrypted: i=1; AJvYcCWL5Smxsc3JV9hg+drEJKi1agHPtlcTBOrIfrHhYCXPGywSi5ZHDMLzMcgzw8yHQTLIzcy0DtiU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EsVWo0RJxOY7EKFGr/7GuV0Y04tBCt/dZ6OWthTiZaiBFbE6
	Ic857dHn3MnIgxErWkguOqC6mKsCx1OzFYqhZx55NxtEeGtBQmTj6IU+XaFQ+hI=
X-Gm-Gg: ASbGncumXAWPmg/WZx8M1xo0DMDvsos3Ro4lT7Enjr896wejtP2GNnHuOMfHeht9YUp
	tIyjLY38eP1RY50duKKOFMRNBq96lqzAFtCGowKYnPEkLbp4tInBJlvUHKL0kDfKZPdKCKWqwUL
	xln1Z6iuaw+srNCmC7q2RQt0beotPrYHCvO2o2Xq3p4huHr214qp3szVbsnE8nL5tvsBv+TIGex
	BBdcY6uHLAgeLQer7cLJ1f7h5fKAMxpD1s68yYu6RqMa40xntTosnL6K5L+X95CbLvhHYPIz1YA
	TNnn6r1Hd1iawT/wIkUUr3YUIQxwX4aBFHQFQ1AsTCd+1Hukh+2KlA1gWubp9WH+ywEwL6QS
X-Google-Smtp-Source: AGHT+IHMPzkkwvrvPUMjLd8RH358czmXgq5CB+tWd2lPWjwDGWGWGLk2G1vtiG4B5iGYuVvrrbfcCQ==
X-Received: by 2002:a17:902:f70f:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22bea50ba50mr238795615ad.43.1744685243640;
        Mon, 14 Apr 2025 19:47:23 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:23 -0700 (PDT)
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
Subject: [PATCH RFC 16/28] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
Date: Tue, 15 Apr 2025 10:45:20 +0800
Message-Id: <20250415024532.26632-17-songmuchun@bytedance.com>
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
against the release of the memory cgroup in folio_migrate_mapping().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..2ff1eaf39a9e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -565,6 +565,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
+		rcu_read_lock();
 		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
@@ -592,6 +593,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 			__mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
 			__mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
 		}
+		rcu_read_unlock();
 	}
 	local_irq_enable();
 
-- 
2.20.1


