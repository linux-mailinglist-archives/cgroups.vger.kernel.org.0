Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22C3DA38A
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhG2M6D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 08:58:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7896 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbhG2M6B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 08:58:01 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gb9TG4cBPz81HB;
        Thu, 29 Jul 2021 20:54:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 20:57:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <shakeelb@google.com>, <guro@fb.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing in mem_cgroup_init()
Date:   Thu, 29 Jul 2021 20:57:54 +0800
Message-ID: <20210729125755.16871-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210729125755.16871-1-linmiaohe@huawei.com>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

rtpn might be NULL in very rare case. We have better to check it before
dereferencing it. Since memcg can live with NULL rb_tree_per_node in
soft_limit_tree, warn this case and continue.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b4592d1e0f2..70a32174e7c4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7109,6 +7109,8 @@ static int __init mem_cgroup_init(void)
 		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
 				    node_online(node) ? node : NUMA_NO_NODE);
 
+		if (WARN_ON_ONCE(!rtpn))
+			continue;
 		rtpn->rb_root = RB_ROOT;
 		rtpn->rb_rightmost = NULL;
 		spin_lock_init(&rtpn->lock);
-- 
2.23.0

