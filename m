Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5D1CB55D
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHRHD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHRHC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 13:07:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A9C05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 10:07:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id 18so2090963pll.3
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BNj9Z6arsMIsAVorXWKDmEgiJTCFic/kTsm/LbalWf8=;
        b=cWd8iE2BULhsuzGBLhEY2ZykQklRkw+mBHU/UMcTu++CnkoD19Vwbyu9ZXAq+Hvjm3
         eKnZGz1RV/GJTLIu+z8x3At8UyE3gi6rwQ2pKfNtHATsjtlhYJDACFP5XqkImrYM4REU
         o+Cqrm1AXu9jkv3QQPIjtPsZLxcHhocu8oRlAndWoiWFd4gsXxte2X28wRZ3L6ck0q1U
         fbOVueB3efN0mUTnXzEm1dz447Ij8sdDOPniira68MQcgRhGm0xO5FH37HOmdlVHeoTl
         61LMlaKmNqqB299IJUdkAwrLrEj457QuNL3sBadYKkE8dCyJi8rIl7w0ts4Nwgy2jbxC
         Z4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BNj9Z6arsMIsAVorXWKDmEgiJTCFic/kTsm/LbalWf8=;
        b=VM1J9PfwwJHCqV4Wm64DCis+MCqWAR49c1FUOoPd3GnqZz7U9WE1D1Ea5O33eC9doA
         hWiMneflli+pZFtFmEEybB/rwkU6s5sroRMX4zem1YPSx34JZW4bRWTL+WH2rLirxO5z
         A5oBXWbIa1b4mnIHzfzxW7b7+ZbZ/kX9X2BI6QoSmEgVCpTR2ucw5RtA82Oc/S7Vp1Ik
         wLH3M9b0rt45YOGJHv0GJXxMdRNUJaWlW5yOIki6NUSkOgmLHdh9stW3wnea8Ldl1FAm
         KxiNAJblVWRKIylaRub0AMSETbsMmuamolgSvj6gLNL+nN/TMgTQdvsa6M6PKGcuhxbQ
         q5mg==
X-Gm-Message-State: AGi0PuZT52/JbGOzQmvYKgBYNR0/jcTBDK5T0WZQ3ogR4Lb2UrAr/1D6
        4iJHXB/tAUBLy6kutTh6iC3Yt0wDIrNFUw==
X-Google-Smtp-Source: APiQypKrBLgMtrlcvFvqs+YYSq+BuahkN4i99V9L7awg8oZ90Mopdcdc1Orq4jfGV/zJgBCe2sQ+Pg1xRpgTLQ==
X-Received: by 2002:a17:90a:d312:: with SMTP id p18mr6749590pju.200.1588957619633;
 Fri, 08 May 2020 10:06:59 -0700 (PDT)
Date:   Fri,  8 May 2020 10:06:30 -0700
Message-Id: <20200508170630.94406-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] memcg: expose root cgroup's memory.stat
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One way to measure the efficiency of memory reclaim is to look at the
ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
not updated consistently at the system level and the ratio of these are
not very meaningful. The pgsteal and pgscan are updated for only global
reclaim while pgrefill gets updated for global as well as cgroup
reclaim.

Please note that this difference is only for system level vmstats. The
cgroup stats returned by memory.stat are actually consistent. The
cgroup's pgsteal contains number of reclaimed pages for global as well
as cgroup reclaim. So, one way to get the system level stats is to get
these stats from root's memory.stat, so, expose memory.stat for the root
cgroup.

	from Johannes Weiner:
	There are subtle differences between /proc/vmstat and
	memory.stat, and cgroup-aware code that wants to watch the full
	hierarchy currently has to know about these intricacies and
	translate semantics back and forth.

	Generally having the fully recursive memory.stat at the root
	level could help a broader range of usecases.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 05dcb72314b5..c300d52c07a5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6230,7 +6230,6 @@ static struct cftype memory_files[] = {
 	},
 	{
 		.name = "stat",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = memory_stat_show,
 	},
 	{
-- 
2.26.2.645.ge9eca65c58-goog

