Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065395035C4
	for <lists+cgroups@lfdr.de>; Sat, 16 Apr 2022 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiDPJZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Apr 2022 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDPJZ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Apr 2022 05:25:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB11031;
        Sat, 16 Apr 2022 02:23:27 -0700 (PDT)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgSNp34w6zFpcL;
        Sat, 16 Apr 2022 17:20:58 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 17:23:25 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 17:23:24 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 0/5] support concurrent sync io for bfq on a specail occasion
Date:   Sat, 16 Apr 2022 17:37:48 +0800
Message-ID: <20220416093753.3054696-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changes in v2:
 - Use a different aporch to count root group, which is much simple.

Currently, bfq can't handle sync io concurrently as long as they
are not issued from root group. This is because
'bfqd->num_groups_with_pending_reqs > 0' is always true in
bfq_asymmetric_scenario().

The way that bfqg is counted to 'num_groups_with_pending_reqs':

Before this patchset:
 1) root group will never be counted.
 2) Count if bfqg or it's child bfqgs have pending requests.
 3) Don't count if bfqg and it's child bfqgs complete all the requests.

After this patchset:
 1) root group is counted.
 2) Count if bfqg have pending requests.
This is because, for example:
if sync ios are issued from cgroup /root/c1/c2, root, c1 and c2 will all
be counted into 'num_groups_with_pending_reqs', which makes it impossible
to handle sync ios concurrently.

 3) Don't count if bfqg complete all the requests.
This is because, for example:
t1 issue sync io on root group, t2 and t3 issue sync io on the same child
group. num_groups_with_pending_reqs is 2 now. After t1 stopped,
num_groups_with_pending_reqs is still 2. sync io from t2 and t3 still can't
be handled concurrently.

fio test script: startdelay is used to avoid queue merging
[global]
filename=/dev/nvme0n1
allow_mounted_write=0
ioengine=psync
direct=1
ioscheduler=bfq
offset_increment=10g
group_reporting
rw=randwrite
bs=4k

[test1]
numjobs=1

[test2]
startdelay=1
numjobs=1

[test3]
startdelay=2
numjobs=1

[test4]
startdelay=3
numjobs=1

[test5]
startdelay=4
numjobs=1

[test6]
startdelay=5
numjobs=1

[test7]
startdelay=6
numjobs=1

[test8]
startdelay=7
numjobs=1

test result:
running fio on root cgroup
v5.18-rc1:	   550 Mib/s
v5.18-rc1-patched: 550 Mib/s

running fio on non-root cgroup
v5.18-rc1:	   349 Mib/s
v5.18-rc1-patched: 550 Mib/s

Yu Kuai (5):
  block, bfq: cleanup bfq_weights_tree add/remove apis
  block, bfq: add fake weight_counter for weight-raised queue
  bfq, block: record how many queues have pending requests in bfq_group
  block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
  block, bfq: do not idle if only one cgroup is activated

 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.c | 90 +++++++++++++++++++--------------------------
 block/bfq-iosched.h | 26 ++++++-------
 block/bfq-wf2q.c    | 30 +++------------
 4 files changed, 56 insertions(+), 91 deletions(-)

-- 
2.31.1

