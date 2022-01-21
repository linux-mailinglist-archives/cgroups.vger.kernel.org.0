Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA82495D7E
	for <lists+cgroups@lfdr.de>; Fri, 21 Jan 2022 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379941AbiAUKMe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jan 2022 05:12:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30292 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379952AbiAUKM3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jan 2022 05:12:29 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JgFXY1yCCzbcvX;
        Fri, 21 Jan 2022 18:11:41 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 18:12:27 +0800
Received: from huawei.com (10.67.174.153) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 21 Jan
 2022 18:12:27 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <matthltc@us.ibm.com>, <bblum@google.com>, <menage@google.com>,
        <akpm@linux-foundation.org>, <longman@redhat.com>,
        <mkoutny@suse.com>, <zhangqiao22@huawei.com>,
        <zhaogongyi@huawei.com>
Subject: [PATCH] cgroup/cpuset: Fix a race between cpuset_attach() and cpu hotplug
Date:   Fri, 21 Jan 2022 18:12:10 +0800
Message-ID: <20220121101210.84926-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.153]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As previously discussed(https://lkml.org/lkml/2022/1/20/51),
cpuset_attach() is affected with similar cpu hotplug race,
as follow scenario:

     cpuset_attach()				cpu hotplug
    ---------------------------            ----------------------
    down_write(cpuset_rwsem)
    guarantee_online_cpus() // (load cpus_attach)
					sched_cpu_deactivate
					  set_cpu_active()
					  // will change cpu_active_mask
    set_cpus_allowed_ptr(cpus_attach)
      __set_cpus_allowed_ptr_locked()
       // (if the intersection of cpus_attach and
         cpu_active_mask is empty, will return -EINVAL)
    up_write(cpuset_rwsem)

To avoid races such as described above, protect cpuset_attach() call
with cpu_hotplug_lock.

Fixes: be367d099270 ("cgroups: let ss->can_attach and ss->attach do whole threadgroups at a time")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index dc653ab26e50..0af5725cc1df 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2252,6 +2252,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);

+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);

 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
@@ -2305,6 +2306,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		wake_up(&cpuset_attach_wq);

 	percpu_up_write(&cpuset_rwsem);
+	cpus_read_unlock();
 }

 /* The various types of files and directories in a cpuset file system */
--
2.18.0

