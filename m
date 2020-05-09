Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827A1CBCEE
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 05:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgEIDTw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 23:19:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbgEIDTw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 8 May 2020 23:19:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B481973F3FFD9566F27;
        Sat,  9 May 2020 11:19:49 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 9 May 2020
 11:19:40 +0800
To:     Tejun Heo <tj@kernel.org>, David Miller <davem@davemloft.net>
CC:     yangyingliang <yangyingliang@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <huawei.libin@huawei.com>, <guofan5@huawei.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
From:   Zefan Li <lizefan@huawei.com>
Subject: [PATCH] netprio_cgroup: Fix unlimited memory leak of v2 cgroup
Message-ID: <939566f5-abe3-3526-d4ff-ec6bf8e8c138@huawei.com>
Date:   Sat, 9 May 2020 11:19:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If systemd is configured to use hybrid mode which enables the use of
both cgroup v1 and v2, systemd will create new cgroup on both the default
root (v2) and netprio_cgroup hierarchy (v1) for a new session and attach
task to the two cgroups. If the task does some network thing then the v2
cgroup can never be freed after the session exited.

One of our machines ran into OOM due to this memory leak.

In the scenario described above when sk_alloc() is called cgroup_sk_alloc()
thought it's in v2 mode, so it stores the cgroup pointer in sk->sk_cgrp_data
and increments the cgroup refcnt, but then sock_update_netprioidx() thought
it's in v1 mode, so it stores netprioidx value in sk->sk_cgrp_data, so the
cgroup refcnt will never be freed.

Currently we do the mode switch when someone writes to the ifpriomap cgroup
control file. The easiest fix is to also do the switch when a task is attached
to a new cgroup.

Fixes: bd1060a1d671("sock, cgroup: add sock->sk_cgroup")
Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Tested-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 net/core/netprio_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netprio_cgroup.c b/net/core/netprio_cgroup.c
index b905747..2397866 100644
--- a/net/core/netprio_cgroup.c
+++ b/net/core/netprio_cgroup.c
@@ -240,6 +240,8 @@ static void net_prio_attach(struct cgroup_taskset *tset)
 	struct task_struct *p;
 	struct cgroup_subsys_state *css;
 
+	cgroup_sk_alloc_disable();
+
 	cgroup_taskset_for_each(p, css, tset) {
 		void *v = (void *)(unsigned long)css->cgroup->id;
 
-- 
2.7.4

