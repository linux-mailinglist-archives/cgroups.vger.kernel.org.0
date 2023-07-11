Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB374EF32
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 14:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGKMms (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGKMmr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 08:42:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA91705
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 05:42:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6682909acadso3038353b3a.3
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689079359; x=1691671359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF8p9HwwgSPuKR34SMZuqSQ7aAssq/odh5sAxqcKAUo=;
        b=PfObz486Wz+B8XCRMJmNpdOHd0bdAenCGoIFIrS0nn6pqgOGHIHHLLi/E7y4xelPQs
         oV1L5cDtGQ4gFHo4+itEHIwzUsNI9UXysv8UU/Pza3CLcUbZHUcxkt1As11YdvxnX8RF
         H17ZVvTu4nrEDSvdfN39NUxyIGNfeoTwnjdkSADFNYnqT8BI11t6wbWjHwH7o/9kadrH
         e5S5yw3IMsz3lksjyY+6iOF1Q4m7p0LVb07p4UTqbAdR2d9VI1K3CWAVsuHGT4SgzzBo
         xLZVs2ZfUmoYmSJPyCtnkjpSavzGDmGYFi8eCIFGc6qahboTah/quQSujY0SX5PCPa3e
         hfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079359; x=1691671359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF8p9HwwgSPuKR34SMZuqSQ7aAssq/odh5sAxqcKAUo=;
        b=ccCwDC/F0l2XNIAi43UdFcqPWXTlT4daBKzNbHhm5UmIgCTdCBN7NE+FaJO1cEMPiv
         q41IT3XMHO0xbpZOXbUpxFlsL73Ud5E1BNGixVdjuFqVWZiXRDvM+oPO1Y7WPVpoQhJs
         RztCrhXcLdhZFo/0nbKLYEDYtulg3aMB79ofL1/qdMnCMJNAQO/YakoaQwT6MGke/XnT
         H9/HkWG8wHNDP+cyaY+HZmj8t1i69dwK/XljDZ/8Nr89Q38xJlGMzOCGv/C5AXA32fVt
         3qKnikQkKBZyxjNt9Kn2s0ZSF1g+IlJlXtViETyvyVt219JkA1PjPpMEZuqDARYGtYkV
         uWgg==
X-Gm-Message-State: ABy/qLZ1hu9i9P8NB1R01uJfPYoQMApi0wePHLONGR7SJiujc8qQeXFr
        sa2wKOCxNf8ASwCzfo7i19Lnlg==
X-Google-Smtp-Source: APBJJlF8Ng7++YijKQqg29ZCVWXJRwBhX6TmRTz/uJVTeJyWO9yu17EmSQrDts1Z+LLhsS5GxNFl2g==
X-Received: by 2002:a05:6a20:1456:b0:12d:d17d:c811 with SMTP id a22-20020a056a20145600b0012dd17dc811mr13827670pzi.21.1689079358984;
        Tue, 11 Jul 2023 05:42:38 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d27-20020a63735b000000b0055c0508780asm1512222pgn.73.2023.07.11.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:42:38 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH RESEND net-next 2/2] net-memcg: Remove redundant tcpmem_pressure
Date:   Tue, 11 Jul 2023 20:41:44 +0800
Message-Id: <20230711124157.97169-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As {socket,tcpmem}_pressure are only used in default/legacy mode
respectively, use socket_pressure instead of tcpmem_pressure in all
kinds of cgroup hierarchies.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/memcontrol.h | 3 +--
 mm/memcontrol.c            | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5860c7f316b9..341d397186ff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -288,7 +288,6 @@ struct mem_cgroup {
 
 	/* Legacy tcp memory accounting */
 	bool			tcpmem_active;
-	int			tcpmem_pressure;
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
@@ -1728,7 +1727,7 @@ void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
+		return !!memcg->socket_pressure;
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..e9e26dbd65b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7292,10 +7292,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 		struct page_counter *fail;
 
 		if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
-			memcg->tcpmem_pressure = 0;
+			memcg->socket_pressure = 0;
 			return true;
 		}
-		memcg->tcpmem_pressure = 1;
+		memcg->socket_pressure = 1;
 		if (gfp_mask & __GFP_NOFAIL) {
 			page_counter_charge(&memcg->tcpmem, nr_pages);
 			return true;
-- 
2.37.3

