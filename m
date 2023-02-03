Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4B68A6DE
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 00:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjBCXYa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 18:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjBCXY0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 18:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CEA6BBE;
        Fri,  3 Feb 2023 15:24:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC09B82C3F;
        Fri,  3 Feb 2023 23:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A79AC4339B;
        Fri,  3 Feb 2023 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675466663;
        bh=p1w/s0O5n3VSeOMpM1vDKAz+K6RPGrIp6QpaiUCAbUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuCrVsu7EsqwcuHwg7AUSbKZd6w6kULIQHrvnJZdUFECtU5/XPaHlkkcxjMPEhLga
         KVzT7ESVrOE/BZJQFfSitLQe2lUzquK9cVIp2Iw3xIk+Iozoq0lPn/0/CP26maBNXy
         kJnaR8PUUKkTPEFx3+exk8co1JIx29PdVQ8zDWpvfr1ct+VQB2f3sNJJSC6tHoXyz7
         8u1AQd75R/OsWTxVL8XsPr0NtOj6elD8dcH+8S2k8+fk6jFIliCOej9sZNkuh0C6sE
         ds9hl+PCcLXgThtlugAUMHXnxGzGqkv4iUizOyXVr0YqhP3pgTHk/zCI9g5lYKWSRU
         iewsp3xAyNdkA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Date:   Sat,  4 Feb 2023 00:24:09 +0100
Message-Id: <20230203232409.163847-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203232409.163847-1-frederic@kernel.org>
References: <20230203232409.163847-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Provide this new API to check if a CPU has been isolated either through
isolcpus= or nohz_full= kernel parameter.

It aims at avoiding kernel load deemed to be safely spared on CPUs
running sensitive workload that can't bear any disturbance, such as
pcp cache draining.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index b645cc81fe01..088672f08469 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -53,4 +53,10 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline bool cpu_is_isolated(int cpu)
+{
+	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
+		 !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE);
+}
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
-- 
2.34.1

