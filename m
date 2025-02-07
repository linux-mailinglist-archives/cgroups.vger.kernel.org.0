Return-Path: <cgroups+bounces-6452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC84A2BA05
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 05:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74E518898A4
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 04:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ABF23236B;
	Fri,  7 Feb 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UlhGKpb6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBC1DE2AE
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901444; cv=none; b=kQp6Tsjh3iC9mNoDQPYRd9liKhLBFD1u9YPsLcKy2mnb5Tf0FOvVT8R5kUu3V34ZloNIRfHH2DthM8GAaol1Xw0p1zbZ+3LbRbEg2IC5UcJRH83DqOWaQfnIdalHGaECa0vaDzGRbZjHHaOC0q+u7Gn4KJSL/Gwt9BBlxqwHW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901444; c=relaxed/simple;
	bh=LKw6HaeW05jbHUxXDx+rmwHbEdYlclYGnPRLLJQzy60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhkzYEk1DzrN1q6mCemceakhOU/AqUicRSUZVzZsic1UWU34mBtFtvNuT3uTiz3ZHLHhbMYIna7KqYa6RM9xM+ezLSq/qtpRP2FBMFRbRmQoAQpxeo3PRortkV3bPIDAquks1XKfImDX8qcoVPvLzVZrE8sudkNmnd57nXQuO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UlhGKpb6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa227edb68so101427a91.0
        for <cgroups@vger.kernel.org>; Thu, 06 Feb 2025 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738901442; x=1739506242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=UlhGKpb6zXysr6SZqmUaiY2FtTJ8HiMF/75i4C3nvr7jnkkzah6EkEL0/Mu3UKYTqq
         jvV2d80ykSjq0K1tbAdLAkKFQkyJIHqdPbGGB0XNwJTOYX7je3mtIKsZefbeh/F/Ab6A
         9VhcBvjx0hsp90fz/bGDWeX5MfqllPgLtrkbiliNXMU4iyvcPWyCS7+8ix77gGWDk9T/
         eSgBz4MARdfsoGat/4E8sqiE+DqB1chv1Kg/lo7LDt0nkc1961Tifse3FLjGmNSsMBHK
         OkObHteYHG0/6BSI9ZIPWcCdHVdkvvU7GlnEKjkwpT17tkVcVdyK+AcN469qOAlIEeza
         W9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738901442; x=1739506242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=peo1w1zTBPyW1f5zTywsNeazDT0GlSaKNrZRMNkOgFtjpc8LQ6YXMdzwkqZoR4uaJA
         GTSOpSlLZlCgTv10ncFAKjwHvgFQZ1IDDiusbWysmyomuG8qINFhi4vy2C3lGmFN8VES
         6VSL+vcKbzFAscaZzz19NyVslDFiTq/RiWkNH6XjN7cw5qV7met4Px8X3f/zqK6apaTz
         39LNaJz/zRgbHxheMHBlKAvMS/eB569gQgpth/pYMeM90dji3VxA6odWepyf6anszpgM
         CCJCaFpwVUCtA47Lr/umR2QgQPzfp5/c4zMrUYlIS7FfQy5SSfDsppOEBtjZKIhj94du
         mv8Q==
X-Gm-Message-State: AOJu0Yw0snVTESo4lz+OOHPYBJ1B2DMwwwFS3erMpjdPDIJ+oEwmlC9X
	B7FMCQDGHbFmrWa8TFQr9ONLvcaixQrdxGQJ5cAL/H0VCbJ02M1+0G9odPLvsfITgf4m6gIgMja
	A
X-Gm-Gg: ASbGncuNrdlxnAnW6S3eAYTqcw5Bl7R2cMavVqfC1KZjLsb3AFfM1VSokGp1/JeC5LS
	KsOMkePjeMiBBCpOcFZirr7qmtXAufwIVHEDQG2YMpONahYogMGU268zpLY1q9QFM7DtS4b3sF0
	LQRque5cQru+jj0tQITWPMwhmFiOe4GzwdyOh9xgy/vcJ7n7xswd0RLisesumi39NtFWYL2dc3Z
	8x1siZYkLoTXifsG1boj6MTEWvBi/EUA/alJ1m1GQTt6Io085J7wr5ShcXVhvB9lu894wrSKBD1
	wBpqChEK3ZdE9Q4HrD5LFmuQQFtAxOueQ13lvEqJU3shin/1dd2RWQ==
X-Google-Smtp-Source: AGHT+IGfN8nWMRRbiHB1N/J5PGoY6ixrDg2dHrmz1XRhdmGLzjRZe+YvfBS7TcrzSJ8pWsfzRBB2Tw==
X-Received: by 2002:a05:6a20:4386:b0:1e1:a434:296b with SMTP id adf61e73a8af0-1ee03a23f1bmr1577240637.1.1738901442330;
        Thu, 06 Feb 2025 20:10:42 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee7fbasm2135485a12.46.2025.02.06.20.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 20:10:41 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] cgroup/rstat: Fix forceidle time in cpu.stat
Date: Fri,  7 Feb 2025 12:10:00 +0800
Message-Id: <20250207041012.89192-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250207041012.89192-1-wuyun.abel@bytedance.com>
References: <20250207041012.89192-1-wuyun.abel@bytedance.com>
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


