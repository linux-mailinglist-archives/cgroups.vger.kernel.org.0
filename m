Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6D450A03
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhKOQub (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 11:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhKOQuB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 11:50:01 -0500
X-Greylist: delayed 137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Nov 2021 08:47:04 PST
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C2C061570;
        Mon, 15 Nov 2021 08:47:01 -0800 (PST)
Received: from vla1-a78d115f8d22.qloud-c.yandex.net (vla1-a78d115f8d22.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:2906:0:640:a78d:115f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1EDD42E1259;
        Mon, 15 Nov 2021 19:44:42 +0300 (MSK)
Received: from myt6-10e59078d438.qloud-c.yandex.net (myt6-10e59078d438.qloud-c.yandex.net [2a02:6b8:c12:5209:0:640:10e5:9078])
        by vla1-a78d115f8d22.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id YdQFLIuhMD-ifsSNGmc;
        Mon, 15 Nov 2021 19:44:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com; s=default;
        t=1636994682; bh=tKgob4UDDd5k1op7XILIrY6rAd3bCvER424NTeWbm4Q=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=t0fIktdpmSujm36dDAZrA6JrmNIqtt4UIS5RJhmDT0xCPsE8zwJn5eCt6Lue5LBRQ
         d/VnuoMc1+8QL42CErTA2SkL0wZNvRU5gHh3DWckPZyTNxCAlj1dQ1D8KEG8SrISYc
         RknrySiVPuc2bDmD2FBGosdgSq1z7o0/9B9mGSC8=
Authentication-Results: vla1-a78d115f8d22.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.com
Received: from dellarbn.yandex.net (dynamic-red3.dhcp.yndx.net [2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by myt6-10e59078d438.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPS id 7goUWCU60O-ifwSrl6f;
        Mon, 15 Nov 2021 19:44:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Andrey Ryabinin <arbn@yandex-team.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrey Ryabinin <arbn@yandex-team.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH v3 2/4] cpuacct: convert BUG_ON() to WARN_ON_ONCE()
Date:   Mon, 15 Nov 2021 19:46:05 +0300
Message-Id: <20211115164607.23784-2-arbn@yandex-team.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115164607.23784-1-arbn@yandex-team.com>
References: <20211115164607.23784-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace fatal BUG_ON() with more safe WARN_ON_ONCE() in cpuacct_cpuusage_read().

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
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
2.32.0

