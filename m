Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0A3F2966
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhHTJks (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhHTJkr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 05:40:47 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569DC061756;
        Fri, 20 Aug 2021 02:40:09 -0700 (PDT)
Received: from sas1-3cba3404b018.qloud-c.yandex.net (sas1-3cba3404b018.qloud-c.yandex.net [IPv6:2a02:6b8:c08:bd26:0:640:3cba:3404])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 0292C2E14D0;
        Fri, 20 Aug 2021 12:40:06 +0300 (MSK)
Received: from sas1-9d43635d01d6.qloud-c.yandex.net (sas1-9d43635d01d6.qloud-c.yandex.net [2a02:6b8:c08:793:0:640:9d43:635d])
        by sas1-3cba3404b018.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id M5FCuBHUdG-e4uqxH64;
        Fri, 20 Aug 2021 12:40:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com; s=default;
        t=1629452405; bh=mk3pzEbe7hMn1PKFNH+h5kr4+QThbJ4FJbuURvEL6qs=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=g0VyrVHaOuAMmjd2ZJWhXG2vo65VTUvXvchTdCfP2AfxefsmvcYahKaaGiUfmKExi
         ZB+KhnnPoK4UUcnxXFVFSULaYzfNO59fiGR51VkiItQM9p2b83oVYzBYLRRPhscEHw
         yMvN4iH1D3EBfDV0Sx2Y98v9HCmkwxuL3kGvcVQE=
Authentication-Results: sas1-3cba3404b018.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.com
Received: from dynamic-red3.dhcp.yndx.net (dynamic-red3.dhcp.yndx.net [2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by sas1-9d43635d01d6.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id G4f2cCJGSV-e424BS5u;
        Fri, 20 Aug 2021 12:40:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Andrey Ryabinin <arbn@yandex-team.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bharata@linux.vnet.ibm.com, boris@bur.io,
        Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 2/5] cpuacct: convert BUG_ON() to WARN_ON_ONCE()
Date:   Fri, 20 Aug 2021 12:40:02 +0300
Message-Id: <20210820094005.20596-2-arbn@yandex-team.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820094005.20596-1-arbn@yandex-team.com>
References: <20210217120004.7984-1-arbn@yandex-team.com>
 <20210820094005.20596-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace fatal BUG_ON() with more safe WARN_ON_ONCE() in cpuacct_cpuusage_read().

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 893eece65bfd..f347cf9e4634 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -106,7 +106,8 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	 * We allow index == CPUACCT_STAT_NSTATS here to read
 	 * the sum of usages.
 	 */
-	BUG_ON(index > CPUACCT_STAT_NSTATS);
+	if (WARN_ON_ONCE(index > CPUACCT_STAT_NSTATS))
+		return 0;
 
 #ifndef CONFIG_64BIT
 	/*
-- 
2.31.1

