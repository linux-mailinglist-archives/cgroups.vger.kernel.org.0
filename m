Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01D6F2016
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfKFUuC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 15:50:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43122 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbfKFUuB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 15:50:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id z23so566872qkj.10;
        Wed, 06 Nov 2019 12:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CiK8igEDVXgKaHvMads6gYnmVhNv244fVisSAjJVZyQ=;
        b=L1igbyJIS3B3Z6CUwNO8Av0YgANed5N5Nac+ANz7oSf+L6b3WdT62vZknFaWMMHcto
         yeHa5jGPJRCOXyTLOwq2RjTjSIFjqxWfke9qtXc2EWCRJZl8iTY8PuKsdkLuywa9qMXo
         GUkxWVgHEuA0jWHXDQJtkKUPYDFOq5Y06GTwkgr1JPJILt5Pcc/CLL4bqhmkJtJYgRwz
         JWVFI3EX9FJRqttzXCJVbIS5T7oxMsmG5p3M9WUDWTZoC6Xd7gbo0mXQ1ToeNkC9UGlm
         2cpnIlYKVDXusG3s4V22kIvMBVmIOSjvYjcSne5VfMzjwJKOOAGAcwcrYXqO4YLcyx8M
         P8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=CiK8igEDVXgKaHvMads6gYnmVhNv244fVisSAjJVZyQ=;
        b=DNUTRyFsqiHELRMw1E5wykXqFthY60tX8Hd7IZ/sUAkMnFP0C6yI0RjSv+RZDPx1uv
         gEn5a2NET2mjApEgqcAaHErYcnb/52MpKPEBipRIL9DsNzckUDk9AQFFpj2ahyHl04pn
         ejKWtcOyrtP0ANYG0dxk8vFSGU6/TQKXbC941uQ/vx5ZLIn9qrbiieJ8zBlmeMernf1Q
         AnQDaPJ3kQhs1f2lmEby8JCuBPOVKhurp07q2rj6Jpxsp/gJZoGAAcakeYpGW3G0oFVP
         E6t5It0KcnDhdRszy+7i1muHgYN/kIXnalRlD1n2sWsX82YzK1vAWs5WTFHDmcLsmW1A
         WO4Q==
X-Gm-Message-State: APjAAAW7k7Iqf7/0xt0/zlLiS8UDZsEygvNrH8tnWqsHK7e5/4oe5D2i
        4/rR45l5iPby4sqt4P5TEAiK1xob
X-Google-Smtp-Source: APXvYqwOhnRWgIky9jY4TKVQ3orEZlRl3NtxCGDBiQzZ8OtIR+HX+drX7zMSWGgQ4QYDdxqUuhbovg==
X-Received: by 2002:a05:620a:12cb:: with SMTP id e11mr4065334qkl.247.1573073399941;
        Wed, 06 Nov 2019 12:49:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5bd1])
        by smtp.gmail.com with ESMTPSA id u189sm12924792qkd.62.2019.11.06.12.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 12:49:59 -0800 (PST)
Date:   Wed, 6 Nov 2019 12:49:57 -0800
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-5.5] cgroup: use cgroup->last_bstat instead of
 cgroup->bstat_pending for consistency
Message-ID: <20191106204957.GT3622521@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup->bstat_pending is used to determine the base stat delta to
propagate to the parent.  While correct, this is different from how
percpu delta is determined for no good reason and the inconsistency
makes the code more difficult to understand.

This patch makes parent propagation delta calculation use the same
method as percpu to global propagation.

* cgroup_base_stat_accumulate() is renamed to cgroup_base_stat_add()
  and cgroup_base_stat_sub() is added.

* percpu propagation calculation is updated to use the above helpers.

* cgroup->bstat_pending is replaced with cgroup->last_bstat and
  updated to use the same calculation as percpu propagation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applying to cgroup/for-5.5.

Thanks.

 include/linux/cgroup-defs.h |    2 -
 kernel/cgroup/rstat.c       |   46 +++++++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 22 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -458,7 +458,7 @@ struct cgroup {
 	struct list_head rstat_css_list;
 
 	/* cgroup basic resource statistics */
-	struct cgroup_base_stat pending_bstat;	/* pending from children */
+	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
 	struct prev_cputime prev_cputime;	/* for printing out cputime */
 
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -304,44 +304,48 @@ void __init cgroup_rstat_boot(void)
  * Functions for cgroup basic resource statistics implemented on top of
  * rstat.
  */
-static void cgroup_base_stat_accumulate(struct cgroup_base_stat *dst_bstat,
-					struct cgroup_base_stat *src_bstat)
+static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
+				 struct cgroup_base_stat *src_bstat)
 {
 	dst_bstat->cputime.utime += src_bstat->cputime.utime;
 	dst_bstat->cputime.stime += src_bstat->cputime.stime;
 	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
 }
 
+static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
+				 struct cgroup_base_stat *src_bstat)
+{
+	dst_bstat->cputime.utime -= src_bstat->cputime.utime;
+	dst_bstat->cputime.stime -= src_bstat->cputime.stime;
+	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
+}
+
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-	struct task_cputime *last_cputime = &rstatc->last_bstat.cputime;
-	struct task_cputime cputime;
-	struct cgroup_base_stat delta;
+	struct cgroup_base_stat cur, delta;
 	unsigned seq;
 
 	/* fetch the current per-cpu values */
 	do {
 		seq = __u64_stats_fetch_begin(&rstatc->bsync);
-		cputime = rstatc->bstat.cputime;
+		cur.cputime = rstatc->bstat.cputime;
 	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
 
-	/* calculate the delta to propgate */
-	delta.cputime.utime = cputime.utime - last_cputime->utime;
-	delta.cputime.stime = cputime.stime - last_cputime->stime;
-	delta.cputime.sum_exec_runtime = cputime.sum_exec_runtime -
-					 last_cputime->sum_exec_runtime;
-	*last_cputime = cputime;
-
-	/* transfer the pending stat into delta */
-	cgroup_base_stat_accumulate(&delta, &cgrp->pending_bstat);
-	memset(&cgrp->pending_bstat, 0, sizeof(cgrp->pending_bstat));
-
-	/* propagate delta into the global stat and the parent's pending */
-	cgroup_base_stat_accumulate(&cgrp->bstat, &delta);
-	if (parent)
-		cgroup_base_stat_accumulate(&parent->pending_bstat, &delta);
+	/* propagate percpu delta to global */
+	delta = cur;
+	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
+	cgroup_base_stat_add(&cgrp->bstat, &delta);
+	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
+
+	/* propagate global delta to parent */
+	if (parent) {
+		delta = cgrp->bstat;
+		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
+		cgroup_base_stat_add(&parent->bstat, &delta);
+		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
+	}
 }
 
 static struct cgroup_rstat_cpu *
