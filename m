Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8426C0937
	for <lists+cgroups@lfdr.de>; Mon, 20 Mar 2023 04:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCTDM3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Mar 2023 23:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTDM1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Mar 2023 23:12:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA98B83D0;
        Sun, 19 Mar 2023 20:12:25 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pg08w2XsmzKs5v;
        Mon, 20 Mar 2023 11:10:08 +0800 (CST)
Received: from ci.huawei.com (10.67.175.89) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 11:12:22 +0800
From:   Cai Xinchen <caixinchen1@huawei.com>
To:     <songmuchun@bytedance.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <longman@redhat.com>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>
CC:     <cgroups@vger.kernel.org>, <duanxiongchun@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yosryahmed@google.com>, <mpenttil@redhat.com>
Subject: [PATCH 0/1] Fix vmstat_percpu incorrect subtraction after reparent
Date:   Mon, 20 Mar 2023 03:06:47 +0000
Message-ID: <20230320030648.50663-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.89]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, I see the patch-series (Use obj_cgroup APIs to charge the LRU
pages).
Link: https://lore.kernel.org/all/20220621125658.64935-1-songmuchun@bytedance.com/

There are two problems left:

     root
     /  \
    A    B
   / \    \
  C   E    D

1. In some case of reparent, some page cache may be used by other memcg
D but it charges to the parent memcg A of dying memcg E. D is getting
away with using the page for free while A is taxed.

For this problem, the page may be shared by many memcgs. Which memcg
should be recharged to? It is hard to select. And for recharge method,
for example, the user rmdir E. If we recharge the page to D, some pages
of process attached to D may be reclaimed. The user may feel confused
about the phenomenon that I rmdir E but the processes attached to D are
reclaiming their pages and running slower.

And for cgroup v2, the page is charged to the memcg when it alloc and the
stats is counted to its parent. The method of reparent seems to follow
the rule.

2. The stats problem of vmstats_percpu. When memcg C is offllined, its 
pages are reparented to memcg P, so far P->vmstats (hierarchical) have
those pages, and P->vmstats_percpu (non-hierarchical) don't. When those
 pages get uncharged, P->vmstats (hierachical) decreases, which is correct,
but P->vmstats_percpu (non-hierarchical) also decreases, which is wrong, 
as those stats were never added to P->vmstats_percpu to begin with. If the
reparented memory exceeds the original non-hierarchical memory in P, some
arg such as cache which is show in memory.stat will be zero (if x < 0, it
shows 0)

I think propagate vmstats_percpu stats of dying memcg to its parent can 
solve this problem. If we do not propagate, the reparented memory exceeds
the original non-hierarchical memory in P, (hierarchical_usage -
non-hierarchical_usage(shows 0, but exactly negative number) - 
children_hierarchical_usage) may be meaningless.

And I want to ask for your opinions about problem 1, how to define the 
actions of charging pages to memcg when the memcg is died.

Cai Xinchen (1):
  mm: memcontrol: fix vmstats_percpu state incorrect subtraction after
    reparent

 kernel/cgroup/cgroup.c |  5 +++++
 mm/memcontrol.c        | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.17.1

