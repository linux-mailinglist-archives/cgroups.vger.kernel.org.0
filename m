Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C041A3A30
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDITIR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 15:08:17 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46786 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDITIR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 15:08:17 -0400
Received: by mail-qv1-f67.google.com with SMTP id bu9so6054902qvb.13;
        Thu, 09 Apr 2020 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayL215ffxl6RjJBBrVofm8B1vxSMDd7VbUsUyBtw+QM=;
        b=bCjHWWd3Hfo9Zwt/UN+F0Hmriun0dZN9aT7DnbdFO67O+uTY8o4uHtiVMRsX+dpyJN
         uqSC7XBHSdVmBnjTb+GzXMxHG0leQir/TIZQehT1LbKR5q3MGPV4VDAXhy2xrBN7l9Gh
         ZajFf8FvKF10zqVXppmyPMPJ4I1g3bRutLOaQ2tdae0/BtP0lFDAlUfDlz9TyG8YvKsR
         s29MqYvn1Pi0UMZ5IDyJ2dEiekkwhXDhzTXrlcT5uetSE3RTRP55s7Qfd0nuI1BagM2J
         9eI0erzZctXjuuGgwj504H5ML+j0VUeK7dfkRyPIo7Tjr+6brZ00OPJwJqwjqtr8LsFS
         9S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ayL215ffxl6RjJBBrVofm8B1vxSMDd7VbUsUyBtw+QM=;
        b=kLdrvgp6ZoCK1ABIC8YzTrvmVe7K1J+XzQhqOUJ4l7436FL/8sfkrsbWcmwileVW8a
         Vx8fJJ7jRzhbd+CbhZEyFXZ91aJkfV3IGGjRY+HmpyWmFjCC2PKDPESP3qnWcQvdjtU6
         RyJ2XMUw+rq20tAnfBkD81ddU0z0P4STqbslbi7kKmzo0m4C02D9Uut3UcjXmRQsk7Ch
         aO+E3phZDra51NQp14Eq32A9Hbg1LkRgqLdZJCaiiC5NEYOHdiiMwOW2rPBN2nmvik0h
         q5Xk9foJaeUQYGXH9E+X8c1OnGMbuMjVTF2xro0m+jqsO2GuDDNKJNJmgrq8iC4asuAA
         3OrQ==
X-Gm-Message-State: AGi0PuY34/uq8SncUJkkaPGscwAFR1y1COf0q8+6L7+4iiK/tXMto/xp
        PkT8POQ3YmXLdtw0JzRAwIY=
X-Google-Smtp-Source: APiQypLnt+6zVmfQ9hqx9DH8q8ecuGIo+Iqvzrff47Vh7roL00Z5OuaUYmLyG6u64qYsJWLh+i3QeQ==
X-Received: by 2002:a0c:ee81:: with SMTP id u1mr1635057qvr.187.1586459294676;
        Thu, 09 Apr 2020 12:08:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::74a8])
        by smtp.gmail.com with ESMTPSA id z43sm23415759qtb.92.2020.04.09.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:08:13 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:08:12 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org
Subject: [PATCH cgroup/for-5.7-fixes] Revert "cgroup: Add memory barriers to
 plug cgroup_rstat_updated() race window"
Message-ID: <20200409190812.GB37608@mtj.thefacebook.com>
References: <20200409154413.GK3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409154413.GK3818@techsingularity.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From d8ef4b38cb69d907f9b0e889c44d05fc0f890977 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 9 Apr 2020 14:55:35 -0400

This reverts commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
cgroup_rstat_updated() race window").

The commit was added in anticipation of memcg rstat conversion which needed
synchronous accounting for the event counters (e.g. oom kill count). However,
the conversion didn't get merged due to percpu memory overhead concern which
couldn't be addressed at the time.

Unfortunately, the patch's addition of smp_mb() to cgroup_rstat_updated()
meant that every scheduling event now had to go through an additional full
barrier and Mel Gorman noticed it as 1% regression in netperf UDP_STREAM test.

There's no need to have this barrier in tree now and even if we need
synchronous accounting in the future, the right thing to do is separating that
out to a separate function so that hot paths which don't care about
synchronous behavior don't have to pay the overhead of the full barrier. Let's
revert.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Mel Gorman <mgorman@techsingularity.net>
Link: http://lkml.kernel.org/r/20200409154413.GK3818@techsingularity.net
Cc: v4.18+
---
Applying to cgroup/for-5.7-fixes.

Thanks!

 kernel/cgroup/rstat.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 6f87352f8219..41ca996568df 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -33,12 +33,9 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 		return;
 
 	/*
-	 * Paired with the one in cgroup_rstat_cpu_pop_updated().  Either we
-	 * see NULL updated_next or they see our updated stat.
-	 */
-	smp_mb();
-
-	/*
+	 * Speculative already-on-list test. This may race leading to
+	 * temporary inaccuracies, which is fine.
+	 *
 	 * Because @parent's updated_children is terminated with @parent
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
@@ -134,13 +131,6 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 		*nextp = rstatc->updated_next;
 		rstatc->updated_next = NULL;
 
-		/*
-		 * Paired with the one in cgroup_rstat_cpu_updated().
-		 * Either they see NULL updated_next or we see their
-		 * updated stat.
-		 */
-		smp_mb();
-
 		return pos;
 	}
 
-- 
2.25.2

