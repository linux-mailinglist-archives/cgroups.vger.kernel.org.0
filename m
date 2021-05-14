Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332F8380F55
	for <lists+cgroups@lfdr.de>; Fri, 14 May 2021 19:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhENR4k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 May 2021 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhENR4j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 May 2021 13:56:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD54C061574;
        Fri, 14 May 2021 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HdZ+Rvb3VddDC+nVIUj42YinsKumWXhl2FsoYoSKcTw=; b=MlhCqueTaVBVJquCeH+yCh0mNn
        DWQa9KPy6TjpHwTVqGPctwkRkkm7WYcbTKbR3BnJnNQwRZm2C8UaQgPY522CQoRXLO6O+1pTV+mas
        dKpzpvYnQL+t4hdwCIYtN6cLPasFRXYO+UuH58XydP4dQ8L0yW79ol4kJsBmHQ5348JfDO9SSxpf8
        0yeMNi8e254eAojsjvy+g1z52WWvIL3venwPje2pWY0s8kSNGvArS4VnB2jpLOoriOick18LHRkQP
        UuJzP9Q71riB+cDvdaQvzFEEcm1nOhmlVb9+DqMlCv6ANXJ+6XPSvnsRU9Jl0ohR2Zz9FmYy6R9+O
        LsYUevOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhbyp-00AakW-KA; Fri, 14 May 2021 17:52:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB3D6300223;
        Fri, 14 May 2021 19:52:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE4732BA998D5; Fri, 14 May 2021 19:52:04 +0200 (CEST)
Date:   Fri, 14 May 2021 19:52:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        lizefan.x@bytedance.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bristot@redhat.com,
        "Paul E . McKenney" <paulmck@kernel.org>, rdunlap@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net>
References: <20210513175349.959661-1-surenb@google.com>
 <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 14, 2021 at 08:54:47AM -0700, Suren Baghdasaryan wrote:

> Correct, for this function CONFIG_CGROUPS=n and
> cgroup_disable=pressure are treated the same. True, from the code it's
> not very obvious. Do you have some refactoring in mind that would make
> it more explicit?

Does this make sense?

--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -744,24 +744,26 @@ static void psi_group_change(struct psi_
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 {
+	if (cgroup_psi_enabled()) {
 #ifdef CONFIG_CGROUPS
-	struct cgroup *cgroup = NULL;
+		struct cgroup *cgroup = NULL;
 
-	if (!*iter)
-		cgroup = task->cgroups->dfl_cgrp;
-	else if (*iter == &psi_system)
-		return NULL;
-	else
-		cgroup = cgroup_parent(*iter);
+		if (!*iter)
+			cgroup = task->cgroups->dfl_cgrp;
+		else if (*iter == &psi_system)
+			return NULL;
+		else
+			cgroup = cgroup_parent(*iter);
 
-	if (cgroup && cgroup_parent(cgroup)) {
-		*iter = cgroup;
-		return cgroup_psi(cgroup);
-	}
-#else
-	if (*iter)
-		return NULL;
+		if (cgroup && cgroup_parent(cgroup)) {
+			*iter = cgroup;
+			return cgroup_psi(cgroup);
+		}
 #endif
+	} else {
+		if (*iter)
+			return NULL;
+	}
 	*iter = &psi_system;
 	return &psi_system;
 }
