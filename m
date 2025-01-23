Return-Path: <cgroups+bounces-6249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E3A1A924
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219C31889FDC
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F915625A;
	Thu, 23 Jan 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B0h7By2t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E114BF87
	for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654503; cv=none; b=I7WjFXnzE5qN2NdCtUhtCvk0Lv37IdNVcYwddGmdM50EDwXYWrmwav1LcPkzcOUzHGXkjOOW1vhpT13X3yfjITRA9JkKU4ZWxpHRAIjkDDl1ufAISFSE3VfsLxKOGsUKO0MtpFleo7/RGZYK+GL0VZqjVnOMq41srGewjVyS+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654503; c=relaxed/simple;
	bh=LKw6HaeW05jbHUxXDx+rmwHbEdYlclYGnPRLLJQzy60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TneMFBi9KJZkVQyHzKB7Q7zXEbuBXcs6WLWkhkOYstFwQxljYJkEnN2Zk0jAzM5+jApDyg4ATqVjm4R5GJFZhjzMynfCZ+ZYTceMkDIy57+S29bk156kktZTGsJd1Xr6IJmmRSHmkDfAfp3sFjM1LQ+N9bWNC749MDYLGMExiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B0h7By2t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21bb2c2a74dso2695535ad.0
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737654501; x=1738259301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=B0h7By2tqMltoFaj4euT6p3nWVu3zn15QRdxf9PlIN5OHWJs7mVvnHF13rvdobRmWw
         EaUnuiOpVyQLGoNg/F1Wrni07+GHsHKrXtZPlLKCq6R23JiwsXEVrV6aefxNL2sJCF/k
         6SCJWxI/9s+unvQvu4oLKCJ8/0uSX6dquPkO5SddHpM8/7NVV+Ajxh1Ol7NyLX3MNUGk
         EjzPTFWRj2R4TfquW0tCtl/eD6IdzgGQ7Z2h8TOH50edy7e/hZz0kOhR2N6v7Hb6xREj
         lHECH26LgnRfjcgK0LuzJQIejhCw16Ss/GeUihJ6bfIzH4DXoEWHdNPO5USwytdZb1vJ
         QV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654501; x=1738259301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiWK8iJRg8z+aUiF8sWc5hRLfRD7QwQ2HIsrRNActc8=;
        b=MzXUf9hot+n7KTymqYt1zng2YvEIuc/kxYBsANgXOaOEm4anR2jzgT+7bNOOmUeCuv
         W/oJl8FNOZvtw1efEpwl76uppUZPpWgoq+V9Lx5UDzK97sJhX5/UQvwr/vvLrpgG+8GV
         1mRPF+j1rHWbD7WSHaRBaOwgAzBsfAS5phA6Qztx1iemULs+o7qpQI4Iy1n0YlP53lYy
         HDBXtpJIbBD6z06Gt0V3HXoqPJ4rOwvGTrc895rPBhdCx2Rrb7Y87w+lOLXOPwIYJgcp
         +yObvqj+FsnkYpmSDHq6kWzoouy4dcZpE0SfggZBSK7ULOAcCdqNuUzdjRNS+/hP1ZVi
         yblg==
X-Gm-Message-State: AOJu0YyA56rNVP2Bzensjmem8ZqianAoMS7HVIS3skvWfPvZfc2zADL/
	uaUe2pymXXv6KE489DTtwhTnp6N3gvWnZxXjF0Jt3rIV71FcyQSBUK4XbLVhBeM=
X-Gm-Gg: ASbGncveMXnM0TniWFmjW5v//2pPJA4ADjS1ZJ3loiVvrKDfP3NDTqv1frG95BfrdRE
	AZ9klbuR8EJledRSQKY9hTGdsgg6Sgs5DxMb754eiFXMess7hvEyuTW5VnxBJqE0iol9bnG8gwv
	OMiUURDLwFGKshUzjHWUuXXq//zKdDpDiGsUWuPjkhVwwMBF2E8eCEZZ5sYG8UE3Xn4B3Noosks
	w75MLBscLLDsxPaRDwD9O/JLWDQ0Bd6b1hA98RU0mUFSnLypNhckTO4tHhadnpJIJDdf4QhmkTj
	6gV39qY61iE7rQM/9S/xtna8b8JxbUVp6LzEqeboZ48=
X-Google-Smtp-Source: AGHT+IEqB68REsf/Kze/kPNv67JNu8zBFzaX7VHnFfW4RVplM5vlL8i36rgiPBi5eWFCEfMpK9w1Yg==
X-Received: by 2002:a17:902:ebca:b0:215:2f19:1dd with SMTP id d9443c01a7336-21d79b26016mr49359925ad.11.1737654501385;
        Thu, 23 Jan 2025 09:48:21 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141c4esm1620765ad.110.2025.01.23.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:48:20 -0800 (PST)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
Date: Fri, 24 Jan 2025 01:47:01 +0800
Message-Id: <20250123174713.25570-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250123174713.25570-1-wuyun.abel@bytedance.com>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
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


