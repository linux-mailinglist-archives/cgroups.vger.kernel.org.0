Return-Path: <cgroups+bounces-6471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A915A2DB45
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 07:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAC01659B2
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2F43AB9;
	Sun,  9 Feb 2025 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H9ccN0Zs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6A3A1BA
	for <cgroups@vger.kernel.org>; Sun,  9 Feb 2025 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739081630; cv=none; b=LSGPXoCfk3Ns13MP6lSKBH9ZzAZ4T8B8OVvK5H4IWmUfWjoJ8pxptEtFIfDN49pT/ir+XDrOyW9dCp7HaVPvb/nzQAGQ2BgyUnC3L5DMNCqXnCrrKGOUtqmEhpL1oCdK7ngQJ3WAs4PZ9mrlgMzfcKhRMzrFuGJfeBSorBPor7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739081630; c=relaxed/simple;
	bh=LKw6HaeW05jbHUxXDx+rmwHbEdYlclYGnPRLLJQzy60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK5npLp1J4e/oRwcKMnbFMsJsu2hMUR2br83K4ReCKQJBmkJstp6B2tWCpS8wnZJbdVpIZ0Ft9BgX1xB2qZCqMBQN7XP9ugAZHv2/6zoSg6btu6uMvj20i3F2aoM+Ntx32qnlOuYBsGUxFy2cVW6VDOu+0vWrSfSFmTuIhrzDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H9ccN0Zs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so842269a91.1
        for <cgroups@vger.kernel.org>; Sat, 08 Feb 2025 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739081628; x=1739686428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=H9ccN0ZseS4y15P+AXw8rC2y9kMrGrwXpPKM3jsXraTpdjclAgp2Hu2opRCQcQKInB
         fxA3ySVrlqCpo/zvK++PLM6QbxpQ7JyxvIFP8mPCwIalXKlUnKLew3kvBUhVHpN6oilG
         E9noWaKqRt2qmvr6xGG1UVabgKxB5ZkLJFYyUAlKfHvgVcmCJQ5aYosfvS2yhVU94hnE
         eKM/nN7FOcxx/MiRC2ezptBNXqh+nUNWde8AvJEc3ynaJStKc/7WePjVSHsraoYeprhW
         mSJgqhhFt0KEGSoyL/p9mQhAmvJ3rp4e6AbfasGbteMiHzNI2AwSPA0urUaya07iB2YH
         l9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739081628; x=1739686428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=EwepaNnBN1wVFQ5MGl8Udpp7bGPSqexe7ipsJLJD2XYRpr/5cj7+LpdgdIJuQwbAA0
         4OJZKteOMKM2+zJZBQQm11PHyO3KNToZPekXFk6G3FTQ34ySg2GS8kDFFJzk9i2IQU17
         VuKSIjOAJWU4EYDZaY/EE1nm11HlhCApwT0sHVF9bR7d77b3gTkcvFfizt4B3itWz4SF
         7V/mXd/24wGugx7KVEtSWGwrLDMYfE7y0npvL36KOF5IC0qWE+zdyVE5XOMPHIgsLJz7
         NYKKNyhB7PDEMg6ufvht6kEoqSPgrtjiJopRHO9AOdwAujfkEO8307BzOL1zYBW02/KA
         HgCg==
X-Gm-Message-State: AOJu0Yy95yGDg8kDp5KFb0XufGUKUHYtavEon3tCeCzxEPjs/ZxylSso
	OED7KONz2akLL9gyDatNyvutH1ykUJowTmZI133XcuIzNYOMTc7ktFQPw0LXf3s=
X-Gm-Gg: ASbGncv/uObu5rmsayW5AQ6gtaU7x2Ht5aQ8Shrq8iCdyAVeVnApE1m+fuThkIb4Nib
	8l/68VM8EIU+huqn9siEQsXC+dcZm/w4sjVtlrKhpXdxBRiu2YIYeQ2D0KGgTglbumuyE5xoCSb
	K7eZzW992PYJ54QmCPl2XreflfHINaetl0ox9tmtveE0XbMKXL53/GDCNuR5zHFnbNoGcHSGG12
	cCRwZb38DdnrEroJHQ/I4Gofa6NGYpkOMXNCUJzPS13ZRBRbkIt8Dv8uc1sn2Ew2Oc/OdiEL7UD
	8V70HWoJMHE57axDJ+wpOKOgTtpz4h0kLY19nSMfEYkXNaumo9baLA==
X-Google-Smtp-Source: AGHT+IGRgPIlfYH1ct5Tu30ErenkcRUA1vil+502uZDCnpli5A1imHo8KSrBBiH8PxnY1CraKeS7OA==
X-Received: by 2002:a05:6a00:1955:b0:730:8a0a:9ef5 with SMTP id d2e1a72fcca58-7308a0aac96mr244659b3a.3.1739081627747;
        Sat, 08 Feb 2025 22:13:47 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad26b9sm5550700b3a.50.2025.02.08.22.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 22:13:47 -0800 (PST)
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
	Bitao Hu <yaoma@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] cgroup/rstat: Fix forceidle time in cpu.stat
Date: Sun,  9 Feb 2025 14:13:11 +0800
Message-Id: <20250209061322.15260-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250209061322.15260-1-wuyun.abel@bytedance.com>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
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


