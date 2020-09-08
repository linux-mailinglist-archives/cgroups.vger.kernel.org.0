Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32CF261B34
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbgIHS6x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 14:58:53 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:22168 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgIHS6w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 14:58:52 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 14:58:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1391; q=dns/txt; s=iport;
  t=1599591531; x=1600801131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m2WVpZpXrtQFXh3Ql4JrliPwX+fM66/2SHqLhNxgwkY=;
  b=KnYh3lHP4/Pu4OSlhFDHLVbfoxOVsRcMaYRNRv459un7R/dOKJu/TVfZ
   knVJe3j1CGYS+0nTi6yI2AAbBjKCaDRKp537mXeHkDVYbh9mHX4Esi4E0
   spzQSsk0yz4pU8CBK7o05+KtEyqKAqKdiHtDVeOhk+uBaODMXfKpMSj26
   Y=;
X-IronPort-AV: E=Sophos;i="5.76,406,1592870400"; 
   d="scan'208";a="732158731"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Sep 2020 18:51:43 +0000
Received: from sjc-ads-9087.cisco.com (sjc-ads-9087.cisco.com [10.30.208.97])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 088IphYE005304;
        Tue, 8 Sep 2020 18:51:43 GMT
Received: by sjc-ads-9087.cisco.com (Postfix, from userid 396877)
        id D89BFBFD; Tue,  8 Sep 2020 11:51:42 -0700 (PDT)
From:   Julius Hemanth Pitti <jpitti@cisco.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        Julius Hemanth Pitti <jpitti@cisco.com>
Subject: [PATCH] mm: memcg: yield cpu when we fail to charge pages
Date:   Tue,  8 Sep 2020 11:50:51 -0700
Message-Id: <20200908185051.62420-1-jpitti@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.208.97, sjc-ads-9087.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For non root CG, in try_charge(), we keep trying
to charge until we succeed. On non-preemptive
kernel, when we are OOM, this results in holding
CPU forever.

On SMP systems, this doesn't create a big problem
because oom_reaper get a change to kill victim
and make some free pages. However on a single-core
CPU (or cases where oom_reaper pinned to same CPU
where try_charge is executing), oom_reaper shall
never get scheduled and we stay in try_charge forever.

Steps to repo this on non-smp:
1. mount -t tmpfs none /sys/fs/cgroup
2. mkdir /sys/fs/cgroup/memory
3. mount -t cgroup none /sys/fs/cgroup/memory -o memory
4. mkdir /sys/fs/cgroup/memory/0
5. echo 40M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
6. echo $$ > /sys/fs/cgroup/memory/0/tasks
7. stress -m 5 --vm-bytes 10M --vm-hang 0

Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d6f3ea86738..4620d70267cb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2652,6 +2652,8 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (fatal_signal_pending(current))
 		goto force;
 
+	cond_resched();
+
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
 	 * a forward progress or bypass the charge if the oom killer
-- 
2.17.1

