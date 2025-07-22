Return-Path: <cgroups+bounces-8816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B38B0CF38
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 03:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B9F1C2167B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 01:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4931B043F;
	Tue, 22 Jul 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fypZouky"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAB1D6DB5;
	Tue, 22 Jul 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148457; cv=none; b=E6M/vyZB/hnKbyn+RHvj5mPEWqApXUPQ9kOb4YjtSehzIAdpV6jC/LmYgMN+/JZknnvmJxfHBmirILIYG9I+m8/4Q29Q319viaDIqBtnqiarim+Z1Ed+jie73K5sZfUa4jTd/Xos+gbsvy/4p6BKEokyFIqLsGUSDxBGnfjRq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148457; c=relaxed/simple;
	bh=WfWKoVZm8XPwL8Mbv5vvFzivXuPSwIHqBgnu7JeC+gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4Repcmds3lz4evDpkxYUH5ICchHKZ4fpH67ltTphVww/V9O+qf//IJNVB1G9ows40ppLPrs1mzo7+Z6BWOpE1LxOoOoN7b5jtDBaZnLMJ/BaQDc7hy9VQU1Cl8aUGLEomdy70iAARJJJM7WEFUnxkg6jVJdwfF0KFOpyt7nC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fypZouky; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7490702fc7cso3095137b3a.1;
        Mon, 21 Jul 2025 18:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753148455; x=1753753255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guAQVHgNFsnXVgjuX+YcMM52ay1Yzole51FqU6vTCMo=;
        b=fypZoukyGsGjrMmlpOiKpIyDekcP+99M2/jj7M7waiz9/X7EEcBHRIzOs+2S9f+iFg
         17MBJIiArHF7AkOrqWmc4vDIEkb+VoLFToGYeYEhcgaWexbSPsKoKS4M+MIGqE0Y1gnt
         yuEGz5UZHoINteutk7+Bu9iSdPFiYsYwc1lUBLDIMDf2Srd8yaGGwBb/QPk3x4WBtAme
         +eSiIxk7UR0a3chacWmM15KH3zjWDKc7/M+pW0BXmagsx5iKj+oSfOjzNMM/yzPM5o6v
         W4fvKyDB+ykcxWeFKh5K3dI0N02ouSMScCkt/u4EiuHUgHkSIBVdrT2GSP+vLm3r/p8v
         Vx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148455; x=1753753255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guAQVHgNFsnXVgjuX+YcMM52ay1Yzole51FqU6vTCMo=;
        b=Zmq9jbWoNh7+W1b5QK6tUN9VOEgPcv0whLHVWikTJD7JPlY+hpSpHOIvHbJ2QL7/Pf
         DXL228Eqm212pghF3rvpFjql81mCNOVj4JiF5M51IMvJC2AgZKBu/LIjh+krfoS+JqVZ
         XbrXk3Sn2iIVGZTj3IcpjaTlcvLdCYjjJw2hXUTLCBY/JYp+RUqkdnHXaTEmdh/rc5sx
         bS/MfC05JdcphDJmeupmgsM2sZ96cub4rtDEjLtXzFqa4Aj6VEZkomhj9nYz0RQBk0L4
         deHUg0T7Q/bNfq5YsZH4wRI0RL88X4cBur+jZxDXxJ4mw+moXB6cJdmIYC7x59zeVAz9
         zq2g==
X-Forwarded-Encrypted: i=1; AJvYcCVaNGtQ3TCbQ7jh6qIIY/sLvKy92kgZiv1oot7wLk1jiT7O9P+DkzUBH7vpsmQpIhbdyKVFkadH@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGEP3p0sijQdxc0Cz0LVgBurMpvzd+kX0n/YCMT+Rtfr8LXUe
	fbf9lRtm8p7izbcUBCYEeZi9M4P/XY7t2IiS/fNeuobBrXMJFyZkBLeh
X-Gm-Gg: ASbGncvaW8j7VN3NMGVAlF9dKe8i2VscdeW3XhN8nIwnlBrz+r8SaT/yBemCQLSJ3JD
	geXzql6gCJ8seKo99d+EqD8J1cdsqPYCJW5yQmepsamoR9DcL2v5oGseD5RDJNhfG3PQr1D6VVw
	81+Gp3ECVtWqshIb65Q79qoxr+Nl7/m1MJ99QqIijeucqTEAuKvp72e+XcDPjAeH8fyrm2SFrS4
	BxbR1sGw3n/VaVML1PPhYGKOtJW45XB46+uAmqyc+kD0NW6WIlAF32YcWFkZYFGTEb0eF0VgZif
	C20Bzytz3D/XNAxMsc+nqkv9Hulfcvxp7RcsKLkyZZ1+Zz5mBaKI0M5mNNfwOEv2Kw7YDR31ym7
	vpMKwpyopG9w06NL2vijtVAkdYPlEhPxqQPtpejHitlTkGQyMmOHQqj5fxgg=
X-Google-Smtp-Source: AGHT+IE2VBTMdvtyEwgX+a0IEZtG4zffgz92TQCPj5wSen6lHXTE+sEYHZdNpPxoF9bMCZyg3CDdww==
X-Received: by 2002:a05:6a00:1410:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-756e7acfa48mr33653521b3a.4.1753148455463;
        Mon, 21 Jul 2025 18:40:55 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm6584089b3a.82.2025.07.21.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:40:54 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/5 cgroup/for-6.16-fixes] cgroup: break up the internal rstat init/exit logic by subsys and base
Date: Mon, 21 Jul 2025 18:40:30 -0700
Message-ID: <20250722014030.297537-6-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014030.297537-1-inwardvessel@gmail.com>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __css_rstat_{base_,}init/exit() functions have complexity in how they
distinguish between base stats and formal subsystem stats. Eliminate this
complexity by breaking up these functions and moving the logic for base and
subsystem directly into their respective public API functions.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 72 ++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ba656a53136a..30fdf92a21a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -437,29 +437,15 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 	}
 }
 
-static int __css_rstat_init(struct cgroup_subsys_state *css, bool is_self)
+int css_rstat_init(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	if (is_self) {
-		/* the root cgrp has rstat_base_cpu preallocated */
-		if (!cgrp->rstat_base_cpu) {
-			cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
-			if (!cgrp->rstat_base_cpu)
-				return -ENOMEM;
-		}
-	}
-
 	/* the root cgrp's self css has rstat_cpu preallocated */
 	if (!css->rstat_cpu) {
 		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
-		if (!css->rstat_cpu) {
-			if (is_self)
-				free_percpu(cgrp->rstat_base_cpu);
-
+		if (!css->rstat_cpu)
 			return -ENOMEM;
-		}
 	}
 
 	/* ->updated_children list is self terminated */
@@ -467,19 +453,12 @@ static int __css_rstat_init(struct cgroup_subsys_state *css, bool is_self)
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
 		rstatc->updated_children = css;
-
-		if (is_self) {
-			struct cgroup_rstat_base_cpu *rstatbc;
-
-			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
-			u64_stats_init(&rstatbc->bsync);
-		}
 	}
 
 	return 0;
 }
 
-static void __css_rstat_exit(struct cgroup_subsys_state *css, bool is_self)
+void css_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
@@ -494,35 +473,44 @@ static void __css_rstat_exit(struct cgroup_subsys_state *css, bool is_self)
 			return;
 	}
 
-	if (is_self) {
-		struct cgroup *cgrp = css->cgroup;
-
-		free_percpu(cgrp->rstat_base_cpu);
-		cgrp->rstat_base_cpu = NULL;
-	}
-
 	free_percpu(css->rstat_cpu);
 	css->rstat_cpu = NULL;
 }
 
-int css_rstat_init(struct cgroup_subsys_state *css)
+int cgroup_rstat_base_init(struct cgroup *cgrp)
 {
-	return __css_rstat_init(css, false);
-}
+	int ret, cpu;
 
-void css_rstat_exit(struct cgroup_subsys_state *css)
-{
-	return __css_rstat_exit(css, false);
-}
+	/* the root cgrp has rstat_base_cpu preallocated */
+	if (!cgrp->rstat_base_cpu) {
+		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+		if (!cgrp->rstat_base_cpu)
+			return -ENOMEM;
+	}
 
-int cgroup_rstat_base_init(struct cgroup *cgrp)
-{
-	return __css_rstat_init(&cgrp->self, true);
+	ret = css_rstat_init(&cgrp->self);
+	if (ret) {
+		free_percpu(cgrp->rstat_base_cpu);
+		return ret;
+	}
+
+	/* ->updated_children list is self terminated */
+	for_each_possible_cpu(cpu) {
+		struct cgroup_rstat_base_cpu *rstatbc;
+
+		rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
+		u64_stats_init(&rstatbc->bsync);
+	}
+
+	return ret;
 }
 
 void cgroup_rstat_base_exit(struct cgroup *cgrp)
 {
-	__css_rstat_exit(&cgrp->self, true);
+	css_rstat_exit(&cgrp->self);
+
+	free_percpu(cgrp->rstat_base_cpu);
+	cgrp->rstat_base_cpu = NULL;
 }
 
 /**
-- 
2.47.1


