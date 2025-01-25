Return-Path: <cgroups+bounces-6321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25699A1C10F
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 06:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF383A99B3
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D85207A28;
	Sat, 25 Jan 2025 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UiCe0ZHM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23420766E
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782764; cv=none; b=PnRXAAU+j6iaRxm4A2XwYirV6Qx8xrEBXMWTA9BJy1qu8U2qBM8SDkz3C9yXA2dCARWWwQrZ+GSW1hoLVJra/OJ2PHeI0oEdgpHOPJ+7yXvO2LLiEewFtWCsA36WegahAsQD81iKw3q8dzGZGMkcx8+r5EyLEf14LSNFma5dghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782764; c=relaxed/simple;
	bh=LKw6HaeW05jbHUxXDx+rmwHbEdYlclYGnPRLLJQzy60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qvbuf0IKrv90EYBfuJzUbQhER9aTIbXMmmyimE0onU2qtyx9T4xfqX3EjO3wRA98PpbKXAeWO7FP2c1+QuyowErTKIYEu2kItb0TvggXWiE8wctbKYm8RWvzQ4MTdHSHcW9DSwIfGcGNPJEGYXFFpInd3wRHDdyPBBqHbC8WCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UiCe0ZHM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso628735a91.3
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 21:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737782761; x=1738387561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=UiCe0ZHM79m0DJUIW7mXuZI1NCNFTQeCcmr7a2pF1sHywNWdAm6FAGSqxX63nM5sVk
         soCWx6nTw18SG0IPgk9zJH0Pf4MCPQZdL1jLVER/Nvoq6AVcBAE7967YC++cNptzSUlP
         ea2UmkJHyJVXgOuOigyCjubv+kbUsYpxCPzGuFqomXMCFRfvpNtnDaD2HYF/VCIvEXxj
         PFRXeitqvbuVwOD8oI0ghWHAKs8U7tpqxPBixp4bzORz3q4MQx+qDUQZpQw7JJ4pfm3S
         UtZed/g0sYObWYwO/jmvR7u4hXzmEgWC/KbwNfhtDHqTli1BKSlaPs8gxQz8P2KHhXkg
         e4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782761; x=1738387561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=wJt21Dj29c+nHIATAXH8FeApRb9HZMVhjB+0wtPyIPEw5neyDqqAOG0YoomNd0buag
         J4iy4hFQXvLm4rwzB0C3KsOz2ZczW7ohhAbZk/fbJNkgE9qaz3pcjvyehjzYZULtjXyK
         15PZKWRpFm8BM10Tst3tZe7vMRTN1WKE20m5ggXTb0Q0oezHU75FH1tFq7EYQf3F40mV
         4EkACgk3xMsBxmzJ7L25n2s9lzdiUQoBx7kvzrZdPZVLuRsU/scGiCCAjm70Afy0VubV
         Z9HUuI+YD/69Ez63QVKHaqG9t3t3AMTU7ZLL7HaIomLx968Pt9sKlo3bnK5bU2GYC01i
         y/Tw==
X-Gm-Message-State: AOJu0YyjCtuVxNpVLQtpaK01ka2zdIXo88Rc0+M1XNov0lbQDJA3JNsG
	FqEzvKfnDSndKawcXO7JMSW/qln37cWr8GzPf+LyE6yPX+V27oq94njrCY5mAs0=
X-Gm-Gg: ASbGncudWc3y8YSqnHL3rNW3bdZfvn8o8dgdRDsieyZq+0MoqXb3Stp7T7nGEwXHViO
	q2DKMDnqo3phynoM1ytlecAG4c4TSobbE1O2PkmaNJ5mmxMfI34mXlSOGlJC0n9SiRYXV4kk8mg
	u2mJ1K2g3ubmEUQNJb9TZnHoPThcIuFhkiSqDf277FvTKuIHyXF30bVS7X2lrlN9uX05GNfBsbL
	0OCJJGCHqQuzxDnPIgBqR82LNPceAVYLiJ7EcMMU7Yw/MkCYBBZp1A1AJRv/t9l0weW0Rcx4gd9
	SOFrPeb9ZXVaPxTZnFtMOlgKGuD40DcjH6cA2/1JUYM=
X-Google-Smtp-Source: AGHT+IH+E7+zyXLvCWAiXzV6o5l6ebSPI18pr2IFPQuGjkRm7m10xzWPBeH3vqaVimkyMkQaYvC5FA==
X-Received: by 2002:a17:902:e750:b0:215:2bfb:3cd7 with SMTP id d9443c01a7336-21c3562959bmr192927435ad.10.1737782760661;
        Fri, 24 Jan 2025 21:26:00 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496bbdc9esm2563856a12.63.2025.01.24.21.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 21:26:00 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
Date: Sat, 25 Jan 2025 13:25:10 +0800
Message-Id: <20250125052521.19487-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250125052521.19487-1-wuyun.abel@bytedance.com>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
which can be potentially inconsistent with other stats.

Rather than reverting that commit, fix it in a way that retains the
effort of cleaning up the ifdef-messes.

Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/cgroup/rstat.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 5877974ece92..c2784c317cdd 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -613,36 +613,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	u64 usage, utime, stime, ntime;
+	struct cgroup_base_stat bstat;
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
+		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
-			       &utime, &stime);
-		ntime = cgrp->bstat.ntime;
+			       &bstat.cputime.utime, &bstat.cputime.stime);
 		cgroup_rstat_flush_release(cgrp);
 	} else {
-		/* cgrp->bstat of root is not actually used, reuse it */
-		root_cgroup_cputime(&cgrp->bstat);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
-		utime = cgrp->bstat.cputime.utime;
-		stime = cgrp->bstat.cputime.stime;
-		ntime = cgrp->bstat.ntime;
+		root_cgroup_cputime(&bstat);
 	}
 
-	do_div(usage, NSEC_PER_USEC);
-	do_div(utime, NSEC_PER_USEC);
-	do_div(stime, NSEC_PER_USEC);
-	do_div(ntime, NSEC_PER_USEC);
+	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
+	do_div(bstat.cputime.utime, NSEC_PER_USEC);
+	do_div(bstat.cputime.stime, NSEC_PER_USEC);
+	do_div(bstat.ntime, NSEC_PER_USEC);
 
 	seq_printf(seq, "usage_usec %llu\n"
 			"user_usec %llu\n"
 			"system_usec %llu\n"
 			"nice_usec %llu\n",
-			usage, utime, stime, ntime);
+			bstat.cputime.sum_exec_runtime,
+			bstat.cputime.utime,
+			bstat.cputime.stime,
+			bstat.ntime);
 
-	cgroup_force_idle_show(seq, &cgrp->bstat);
+	cgroup_force_idle_show(seq, &bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-- 
2.37.3


