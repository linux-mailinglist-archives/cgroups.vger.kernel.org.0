Return-Path: <cgroups+bounces-6583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97704A39133
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9C9188EEEF
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82818E1F;
	Tue, 18 Feb 2025 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjndByB7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7914C5AF
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848518; cv=none; b=CFaUgbDw276HA7+tgZRCeC5OGHSoFpkqFBbxsPiPnO+UZRGvPj+Pmi9dkrypQYjZa5luML5hOMfzTiOIcx1ilVOMMxWTmHQKt0UooshGs9eXJu2+vSOf1zje9JTw1Eg8nFlWszRCJdi+8pNGQ2+WGlrmdsYuJyJ1wOVPrGGUcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848518; c=relaxed/simple;
	bh=zDkCOZtEsgyt5M3iitPsFtL0J6ee+6Jl+VAgNwNz/4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUWPbBsxzVWhLQysnDMyneDYgRQeahGox9if03sEfDyRuIXXP85StJP5cKunYt6ItvL8AUgTkQn/NTJAA2R1wqldozd5EJwxF8WDRG5K461E64ersSXvD6qg8DKbtFJVGon39SiwRF847Zl2EnEmglJgJSQhFBgPKCoF5GwLxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjndByB7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so6282598a91.1
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848516; x=1740453316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD1jatsWdmIEiP5eGI+IqcgznEGBHRgmN/6oH6WnB14=;
        b=MjndByB7CUFcgwMbNSk5Q5h7P3cOTktxgvDwmC475lfCxORAMoBKNmUzXLGf9n4J5u
         ewL1e9rVBDB/nLUv5YRRU0DeRbeP0rbLEqUPAkDhvqejR6276UL/mxYfQA983kY9J0OF
         dBKXpgw6sE7pxmnwxMwwTM0MJBa2wEMSmWm/pLumC52rHEv7xHbaMEBKRkBVhKukdahX
         eglC/JSl+bmnQMhsDF+3Z6xUAimV2HgdCVMFSRCf2uqGdxi1a8YVZJ3AV9HlJ2m2Or17
         4VDjiAOFKLeYPYlgzabAMb+H9ZWMiQs0GdP/5CrQH2LALJO8QIep7d3i7pVoTUMrrgTS
         XyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848516; x=1740453316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD1jatsWdmIEiP5eGI+IqcgznEGBHRgmN/6oH6WnB14=;
        b=MO2LPrvomaUi8OTe3Zez04qx0X5YlSdIzsMuPYahKlAAj8bqlCQcNvJ01tUZNFjBwT
         9rav9mXN2t+9t5o68MDJ8rFMZfq+fJqro3he3sQPOwvZPGFqA9zGckMOZ9O3O4EZZoRP
         cBdCgOpHXU35vJ7YxuzVhGX1RQyoxJJVyJO4YQdhjavQDR2Riybk8bgad5nRwYNk90pk
         0FhAeXe3FPj5iHeXmpAHaSEkYyqpHgAgOXiHuhiRZy+pLo479k2a+jVghoULda5//mIX
         1gfvAzizz7maAdenjOIuUpYCF9sVI6H1aQh7U4z90unIpGT6Sv5zqwlxHvq5UDwdwli1
         NwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEdkG4GUjXhh2xwgudiu/KUX0dgSBrVxwf7P4dB26X+Vz41ObE7JWpG5GZVrzUxFdYvvM1QYy/@vger.kernel.org
X-Gm-Message-State: AOJu0YycUSepth2VNs2kTHY5IjKIsg6D+5GZyUi1aGdy0deowy+Xzmfx
	rgilqVsTwOEViYXEhM3vgz6wjtJB4G0CDha0F5CgAbvMnYTwGgvU
X-Gm-Gg: ASbGncs0A9d1QDY83DfnSSHejN4jE7F695+VTQzFoASv4w0EKsclD0hbXgX5njeAqG7
	jTBWlwEJnWMFFgjy458+y6a2g7ZFj8wKand3g3DBquWy8lot0oNaTCC7X0JVHDCKO06L3rWra5A
	joN1pVOU8mb73aHLchcOopwPnzYwrT8KjGB6xt0dBeU37IMH2QZWvV3Y+9YL9Bcu7ICrlnP23O0
	BNTNP1E/RbL4GQcnRkSN3dp7/L6eHFjKLr/4DzF2PvwXInqj45s6HZcLooXc6SgyWzt7Tpg401x
	S8ZMZK6x+nMVhWYdoAYBxZl9xgztbSI2gT0ahU9CiYQ2FaSGqOT0
X-Google-Smtp-Source: AGHT+IEZ40Ep2/y9fUsKsPY3ph6FBvkIsGW6s0OHsKOFL28M9YkkbAUChBqTJ0u+bam9kXnHkApFwA==
X-Received: by 2002:a05:6a00:124b:b0:732:1bad:e245 with SMTP id d2e1a72fcca58-7326179e7d8mr16437947b3a.7.1739848516068;
        Mon, 17 Feb 2025 19:15:16 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:14 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 09/11] cgroup: separate rstat locks for bpf cgroups
Date: Mon, 17 Feb 2025 19:14:46 -0800
Message-ID: <20250218031448.46951-10-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use new locks with the rstat entities specific to bpf cgroups. Having
these locks avoids contention with subsystems such as memory or io while
updating/flushing bpf cgroup stats.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9f6da3ea3c8c..7d9abfd644ca 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -18,6 +18,11 @@ struct cgroup_rstat_ops {
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
+#ifdef CONFIG_CGROUP_BPF
+static DEFINE_SPINLOCK(cgroup_rstat_bpf_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_bpf_cpu_lock);
+#endif /* CONFIG_CGROUP_BPF */
+
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
 static struct cgroup_rstat_cpu *rstat_cpu(struct cgroup_rstat *rstat, int cpu)
@@ -244,7 +249,7 @@ void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 __bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgroup, int cpu)
 {
 	__cgroup_rstat_updated(&(cgroup->bpf.rstat), cpu, &rstat_bpf_ops,
-			&cgroup_rstat_cpu_lock);
+			&cgroup_rstat_bpf_cpu_lock);
 }
 #endif /* CONFIG_CGROUP_BPF */
 
@@ -490,7 +495,7 @@ void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 __bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgroup)
 {
 	__cgroup_rstat_flush(&(cgroup->bpf.rstat), &rstat_bpf_ops,
-			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
+			&cgroup_rstat_bpf_lock, &cgroup_rstat_bpf_cpu_lock);
 }
 #endif /* CONFIG_CGROUP_BPF */
 
@@ -617,7 +622,7 @@ int bpf_cgroup_rstat_init(struct cgroup_bpf *bpf)
 void bpf_cgroup_rstat_exit(struct cgroup_bpf *bpf)
 {
 	__cgroup_rstat_flush(&bpf->rstat, &rstat_bpf_ops,
-			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
+			&cgroup_rstat_bpf_lock, &cgroup_rstat_bpf_cpu_lock);
 	__cgroup_rstat_exit(&bpf->rstat);
 }
 #endif /* CONFIG_CGROUP_BPF */
@@ -626,8 +631,13 @@ void __init cgroup_rstat_boot(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+
+#ifdef CONFIG_CGROUP_BPF
+		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_bpf_cpu_lock, cpu));
+#endif /* CONFIG_CGROUP_BPF */
+	}
 }
 
 /*
-- 
2.48.1


