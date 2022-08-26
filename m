Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974415A1E0A
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 03:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiHZBSi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZBSh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 21:18:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DEC9E87;
        Thu, 25 Aug 2022 18:18:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDMM926bQzkWft;
        Fri, 26 Aug 2022 09:15:01 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:18:33 +0800
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:18:32 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     Lu Jialin <lujialin4@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC 0/2] Introduce cgroup.top interface
Date:   Fri, 26 Aug 2022 09:15:01 +0800
Message-ID: <20220826011503.103894-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cgroup is used to organize and manage resource available processes.
Currently there are no handy tool for gathering reousrce usage
information for each and every child cgroups, makes it hard to detect
resource outage and debug resource issues.

To overcome this, we present the cgroup.top interface. Just like the
top command, user is able to easily gather resource usage information
, allowing user to detect and respond to resource outage in child
cgroups

Show case:
/ # mount -t cgroup2 none /sys/fs/cgroup
/ # cd /sys/fs/cgroup/
/sys/fs/cgroup # echo "+memory" > cgroup.subtree_control
/sys/fs/cgroup # mkdir test1
/sys/fs/cgroup # mkdir test2
/sys/fs/cgroup # mkdir test3
/sys/fs/cgroup # echo $$ > test2/cgroup.procs
/sys/fs/cgroup # cd /test
/test # ./memcg_malloc 512000 &
/test # ./memcg_malloc 512000 &
/test # ./memcg_malloc 512000 &
/test # cd /sys/fs/cgroup
/sys/fs/cgroup # echo $$ > test1/cgroup.procs
/sys/fs/cgroup # cd /test
/test # ./memcg_malloc 512000 &
/test # cd /sys/fs/cgroup
/sys/fs/cgroup # echo $$ > test3/cgroup.procs
/sys/fs/cgroup # cat cgroup.top
memory top:
name            usage           anon            file            kernel
test2           1974272         1671168         0               270336
test1           700416          569344          0               94208
test3           196608          86016           0               86016


Lu Jialin (1):
  memcg: Adapt cgroup.top into per-memcg

Xiu Jianfeng (1):
  cgroup: Introduce per-cgroup resource top show interface

 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/cgroup.c      | 20 +++++++++
 mm/memcontrol.c             | 87 +++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

-- 
2.17.1

