Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F76300BC2
	for <lists+cgroups@lfdr.de>; Fri, 22 Jan 2021 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbhAVSqj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jan 2021 13:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbhAVSoY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jan 2021 13:44:24 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA334C06174A
        for <cgroups@vger.kernel.org>; Fri, 22 Jan 2021 10:43:44 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id r77so5928897qka.12
        for <cgroups@vger.kernel.org>; Fri, 22 Jan 2021 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9fNjhrnoyOFnHJ9WQ+/Ta+coPGgxGkP5OqAw7eb4FE=;
        b=jZfX+8gSvsMknjij2NXiIkewNvE/gS0U3cVGRcyPmCqSxmENCBZB94bg9qNEDpz1/6
         EraLaqdwbEc4JCtd9r5PpiJZrDTX7sq3ubzrQkZDk37siT5lhYY+2d86mkxF/54wMn6I
         FFW2rpjqkRxx58b4cmvX5LghbDFYl6D9T1qiLQIrf9H0/Bm4zCQjT3lPd29XyUUTsyWW
         JErij86cT0276L6OHd2ics2wWE8glvLdLu7uHZiKNM6MBGiI+DCKpcAUKMGjRuiCo+tE
         5IOV2/n++vOYBzOW3Dja7cVPBGgJKROdI78/O8suUL/c0aHEqbgDjxPMVcUaAYd1rEuH
         YIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9fNjhrnoyOFnHJ9WQ+/Ta+coPGgxGkP5OqAw7eb4FE=;
        b=G+BZ+ZRfBtk3Geg/7xUhUpKAXuidGPi38uHiL30PDpS0nSrq4zq3/5VyaUEymYelhl
         JPFQu5n5PDu4ocZEA6/Z+0qJoMU64Kv+RjMYgdIIkq0fwwArdqVmS65f6feU0RfZCxNI
         uWiiHGzx8b+uCf/gxGOFtoxJo0dhJyyF+3FqYMVdTNyx4Rl5PjU2VEqLY7mtwtYzhSzb
         qJH0SLBSA2NaOOesoarLTvPaLu6DT0RdPc1iikA1PPds/WpmA7UGPch10PwL853o2M+n
         be2+A5daMzcWSM3eHhIloeWx8jUF1AGaErdy2MiCiwTsNdJ3B0WMztI5uLLZKI/TSWzu
         Pyrg==
X-Gm-Message-State: AOAM531aPW4JcUZH5Shq/8CgcbMCTpiH0+uz3dYvm+y+5xksn3v644Uc
        /rTrHZLja59vyBUZCA/Ur6s3vw==
X-Google-Smtp-Source: ABdhPJxPINKbhhsKe9/jTOjmTNsgfz8lXr+DTPt12mOvOHrzFu8u8RyYYax30EeJNoeW4KXB6egXuA==
X-Received: by 2002:a05:620a:205a:: with SMTP id d26mr2334943qka.288.1611341023991;
        Fri, 22 Jan 2021 10:43:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:589b])
        by smtp.gmail.com with ESMTPSA id l204sm6940425qke.56.2021.01.22.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:43:42 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] Revert "mm: memcontrol: avoid workload stalls when lowering memory.high"
Date:   Fri, 22 Jan 2021 13:43:41 -0500
Message-Id: <20210122184341.292461-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This reverts commit 536d3bf261a2fc3b05b3e91e7eef7383443015cf, as it
can cause writers to memory.high to get stuck in the kernel forever,
performing page reclaim and consuming excessive amounts of CPU cycles.

Before the patch, a write to memory.high would first put the new limit
in place for the workload, and then reclaim the requested delta. After
the patch, the kernel tries to reclaim the delta before putting the
new limit into place, in order to not overwhelm the workload with a
sudden, large excess over the limit. However, if reclaim is actively
racing with new allocations from the uncurbed workload, it can keep
the write() working inside the kernel indefinitely.

This is causing problems in Facebook production. A privileged
system-level daemon that adjusts memory.high for various workloads
running on a host can get unexpectedly stuck in the kernel and
essentially turn into a sort of involuntary kswapd for one of the
workloads. We've observed that daemon busy-spin in a write() for
minutes at a time, neglecting its other duties on the system, and
expending privileged system resources on behalf of a workload.

To remedy this, we have first considered changing the reclaim logic to
break out after a couple of loops - whether the workload has converged
to the new limit or not - and bound the write() call this way.
However, the root cause that inspired the sequence change in the first
place has been fixed through other means, and so a revert back to the
proven limit-setting sequence, also used by memory.max, is preferable.

The sequence was changed to avoid extreme latencies in the workload
when the limit was lowered: the sudden, large excess created by the
limit lowering would erroneously trigger the penalty sleeping code
that is meant to throttle excessive growth from below. Allocating
threads could end up sleeping long after the write() had already
reclaimed the delta for which they were being punished.

However, erroneous throttling also caused problems in other scenarios
at around the same time. This resulted in commit b3ff92916af3 ("mm,
memcg: reclaim more aggressively before high allocator throttling"),
included in the same release as the offending commit. When allocating
threads now encounter large excess caused by a racing write() to
memory.high, instead of entering punitive sleeps, they will simply be
tasked with helping reclaim down the excess, and will be held no
longer than it takes to accomplish that. This is in line with regular
limit enforcement - i.e. if the workload allocates up against or over
an otherwise unchanged limit from below.

With the patch breaking userspace, and the root cause addressed by
other means already, revert it again.

Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
Cc: <stable@vger.kernel.org> # 5.8+
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Andrew, this is a replacement for
mm-memcontrol-prevent-starvation-when-writing-memoryhigh.patch

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671203ef..a8611a62bafd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6273,6 +6273,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
+	page_counter_set_high(&memcg->memory, high);
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 		unsigned long reclaimed;
@@ -6296,10 +6298,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			break;
 	}
 
-	page_counter_set_high(&memcg->memory, high);
-
 	memcg_wb_domain_size_changed(memcg);
-
 	return nbytes;
 }
 
-- 
2.30.0

