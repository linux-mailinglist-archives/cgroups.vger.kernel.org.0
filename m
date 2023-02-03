Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F51689E0A
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCPX2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBCPXO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:23:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D886AF0E6;
        Fri,  3 Feb 2023 07:21:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44CEE34A4B;
        Fri,  3 Feb 2023 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675437670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+71rVrs5ZtdXbUgSgq6MBdY/wG/sltNAW0iIaM9D09U=;
        b=k5S9UVYKf/aovkCa8B4Dl6MXE7YfOvX+foI5ZXfG/2sotHPrv7SJRxEqcpu6Q6LXB/Yne7
        yf8F690NY4F0U9QNOOSmEAqkoR7wY0NbCc0oqX46KuZR9PO4nzXKkIChygBlio4kLsri57
        xmr6ZvvrrXx1WRqSO0Tqp+oiDndKnQQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25F211346D;
        Fri,  3 Feb 2023 15:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VzHZBmYm3WP0OgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 03 Feb 2023 15:21:10 +0000
Date:   Fri, 3 Feb 2023 16:21:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y90mZQhW89HtYfT9@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
 <Y9PYe1X7dRQOcahg@dhcp22.suse.cz>
 <Y9QVWwAreTlDVdZ0@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9QVWwAreTlDVdZ0@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

OK, so this is a speculative patch. cpu_is_isolated doesn't exist yet. I
have talked to Frederic off-list and he is working on an implementation.
I will be offline next whole week (will be back Feb 13th) so I am
sending this early but this patch cannot be merged without his one of
course.

I have tried to summarize the reasoning behind both approach should we
ever need to revisit this approach. For now I strongly believe a simpler
solution should be preferred.

Roman, I have added your ack as you indicated but if you disagree with
the reasoning please let me know.
--- 
From 6d99c4d7a238809ff2eb7c362b45d002ca212c70 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 3 Feb 2023 15:54:38 +0100
Subject: [PATCH] memcg: do not drain charge pcp caches on remote isolated cpus

Leonardo Bras has noticed that pcp charge cache draining might be
disruptive on workloads relying on 'isolated cpus', a feature commonly
used on workloads that are sensitive to interruption and context
switching such as vRAN and Industrial Control Systems.

There are essentially two ways how to approach the issue. We can either
allow the pcp cache to be drained on a different rather than a local cpu
or avoid remote flushing on isolated cpus.

The current pcp charge cache is really optimized for high performance
and it always relies to stick with its cpu. That means it only requires
local_lock (preempt_disable on !RT) and draining is handed over to pcp
WQ to drain locally again.

The former solution (remote draining) would require to add an additional
locking to prevent local charges from racing with the draining. This
adds an atomic operation to otherwise simple arithmetic fast path in the
try_charge path. Another concern is that the remote draining can cause a
lock contention for the isolated workloads and therefore interfere with
it indirectly via user space interfaces.

Another option is to avoid draining scheduling on isolated cpus
altogether. That means that those remote cpus would keep their charges
even after drain_all_stock returns. This is certainly not optimal either
but it shouldn't really cause any major problems. In the worst case
(many isolated cpus with charges - each of them with MEMCG_CHARGE_BATCH
i.e 64 page) the memory consumption of a memcg would be artificially
higher than can be immediately used from other cpus.

Theoretically a memcg OOM killer could be triggered pre-maturely.
Currently it is not really clear whether this is a practical problem
though. Tight memcg limit would be really counter productive to cpu
isolated workloads pretty much by definition because any memory
reclaimed induced by memcg limit could break user space timing
expectations as those usually expect execution in the userspace most of
the time.

Also charges could be left behind on memcg removal. Any future charge on
those isolated cpus will drain that pcp cache so this won't be a
permanent leak.

Considering cons and pros of both approaches this patch is implementing
the second option and simply do not schedule remote draining if the
target cpu is isolated. This solution is much more simpler. It doesn't
add any new locking and it is more more predictable from the user space
POV. Should the pre-mature memcg OOM become a real life problem, we can
revisit this decision.

Reported-by: Leonardo Bras <leobras@redhat.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab..55e440e54504 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2357,7 +2357,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
-			else
+			else if (!cpu_is_isolated(cpu))
 				schedule_work_on(cpu, &stock->work);
 		}
 	}
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
