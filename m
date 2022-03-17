Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4AB4DBCA5
	for <lists+cgroups@lfdr.de>; Thu, 17 Mar 2022 02:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358345AbiCQBug (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 21:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348344AbiCQBug (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 21:50:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313115A00;
        Wed, 16 Mar 2022 18:49:20 -0700 (PDT)
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJqgl4t78zcb2M;
        Thu, 17 Mar 2022 09:44:19 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 09:49:18 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:49:17 +0800
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <e299180e-cdbd-0837-8478-5e397ac8166b@huawei.com>
Message-ID: <11fda851-a552-97ea-d083-d0288c17ba53@huawei.com>
Date:   Thu, 17 Mar 2022 09:49:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e299180e-cdbd-0837-8478-5e397ac8166b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

friendly ping ...

在 2022/03/11 14:31, yukuai (C) 写道:
> friendly ping ...
> 
> 在 2022/03/05 17:11, Yu Kuai 写道:
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>>
>> This patchset tries to support concurrent sync io if all the sync ios
>> are issued from the same cgroup:
>>
>> 1) Count root_group into 'num_groups_with_pending_reqs', patch 1-5;
>>
>> 2) Don't idle if 'num_groups_with_pending_reqs' is 1, patch 6;
>>
>> 3) Don't count the group if the group doesn't have pending requests,
>> while it's child groups may have pending requests, patch 7;
>>
>> This is because, for example:
>> if sync ios are issued from cgroup /root/c1/c2, root, c1 and c2
>> will all be counted into 'num_groups_with_pending_reqs',
>> which makes it impossible to handle sync ios concurrently.
>>
>> 4) Decrease 'num_groups_with_pending_reqs' when the last queue completes
>> all the requests, while child groups may still have pending
>> requests, patch 8-10;
>>
>> This is because, for example:
>> t1 issue sync io on root group, t2 and t3 issue sync io on the same
>> child group. num_groups_with_pending_reqs is 2 now.
>> After t1 stopped, num_groups_with_pending_reqs is still 2. sync io from
>> t2 and t3 still can't be handled concurrently.
>>
>> fio test script: startdelay is used to avoid queue merging
>> [global]
>> filename=/dev/nvme0n1
>> allow_mounted_write=0
>> ioengine=psync
>> direct=1
>> ioscheduler=bfq
>> offset_increment=10g
>> group_reporting
>> rw=randwrite
>> bs=4k
>>
>> [test1]
>> numjobs=1
>>
>> [test2]
>> startdelay=1
>> numjobs=1
>>
>> [test3]
>> startdelay=2
>> numjobs=1
>>
>> [test4]
>> startdelay=3
>> numjobs=1
>>
>> [test5]
>> startdelay=4
>> numjobs=1
>>
>> [test6]
>> startdelay=5
>> numjobs=1
>>
>> [test7]
>> startdelay=6
>> numjobs=1
>>
>> [test8]
>> startdelay=7
>> numjobs=1
>>
>> test result:
>> running fio on root cgroup
>> v5.17-rc6:       550 Mib/s
>> v5.17-rc6-patched: 550 Mib/s
>>
>> running fio on non-root cgroup
>> v5.17-rc6:       349 Mib/s
>> v5.17-rc6-patched: 550 Mib/s
>>
>> Yu Kuai (11):
>>    block, bfq: add new apis to iterate bfq entities
>>    block, bfq: apply news apis where root group is not expected
>>    block, bfq: cleanup for __bfq_activate_requeue_entity()
>>    block, bfq: move the increasement of 'num_groups_with_pending_reqs' to
>>      it's caller
>>    block, bfq: count root group into 'num_groups_with_pending_reqs'
>>    block, bfq: do not idle if only one cgroup is activated
>>    block, bfq: only count parent bfqg when bfqq is activated
>>    block, bfq: record how many queues have pending requests in bfq_group
>>    block, bfq: move forward __bfq_weights_tree_remove()
>>    block, bfq: decrease 'num_groups_with_pending_reqs' earlier
>>    block, bfq: cleanup bfqq_group()
>>
>>   block/bfq-cgroup.c  | 13 +++----
>>   block/bfq-iosched.c | 87 +++++++++++++++++++++++----------------------
>>   block/bfq-iosched.h | 41 +++++++++++++--------
>>   block/bfq-wf2q.c    | 56 +++++++++++++++--------------
>>   4 files changed, 106 insertions(+), 91 deletions(-)
>>
