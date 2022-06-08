Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6E543045
	for <lists+cgroups@lfdr.de>; Wed,  8 Jun 2022 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiFHM1r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiFHM1p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 08:27:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD223C67D;
        Wed,  8 Jun 2022 05:27:43 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LJ61Q3TQsz17HMS;
        Wed,  8 Jun 2022 20:27:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 20:27:41 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 20:27:40 +0800
Subject: Re: [PATCH -next v9 0/4] support concurrent sync io for bfq on a
 specail occasion
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <tj@kernel.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220601114340.949953-1-yukuai3@huawei.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <3e2aea7f-a6a9-04aa-e22f-5d08b5686116@huawei.com>
Date:   Wed, 8 Jun 2022 20:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220601114340.949953-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/06/01 19:43, Yu Kuai Ð´µÀ:

Hi, Paolo

Since there is no response from you, I assum that you didn't receive
these emails(probably end up in your spam). I'll try to resend them
soon.

Thanks,
Kuai
> Changes in v9:
>   - also update how many bfqqs have pending_reqs bfq_bfqq_move().
>   - fix one language in patch 4
>   - Add reviewed-tag for patch 1,3,4
> 
> Changes in v8:
>   - Instead of using whether bfqq is busy, using whether bfqq has pending
>   requests. As Paolo pointed out the former way is problematic.
> 
> Changes in v7:
>   - fix mismatch bfq_inc/del_busy_queues() and bfqq_add/del_bfqq_busy(),
>   also retest this patchset on v5.18 to make sure functionality is
>   correct.
>   - move the updating of 'bfqd->busy_queues' into new apis
> 
> Changes in v6:
>   - add reviewed-by tag for patch 1
> 
> Changes in v5:
>   - rename bfq_add_busy_queues() to bfq_inc_busy_queues() in patch 1
>   - fix wrong definition in patch 1
>   - fix spelling mistake in patch 2: leaset -> least
>   - update comments in patch 3
>   - add reviewed-by tag in patch 2,3
> 
> Changes in v4:
>   - split bfq_update_busy_queues() to bfq_add/dec_busy_queues(),
>     suggested by Jan Kara.
>   - remove unused 'in_groups_with_pending_reqs',
> 
> Changes in v3:
>   - remove the cleanup patch that is irrelevant now(I'll post it
>     separately).
>   - instead of hacking wr queues and using weights tree insertion/removal,
>     using bfq_add/del_bfqq_busy() to count the number of groups
>     (suggested by Jan Kara).
> 
> Changes in v2:
>   - Use a different approch to count root group, which is much simple.
> 
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
> 
> The way that bfqg is counted into 'num_groups_with_pending_reqs':
> 
> Before this patchset:
>   1) root group will never be counted.
>   2) Count if bfqg or it's child bfqgs have pending requests.
>   3) Don't count if bfqg and it's child bfqgs complete all the requests.
> 
> After this patchset:
>   1) root group is counted.
>   2) Count if bfqg has pending requests.
>   3) Don't count if bfqg complete all the requests.
> 
> With the above changes, concurrent sync io can be supported if only
> one group is activated.
> 
> fio test script(startdelay is used to avoid queue merging):
> [global]
> filename=/dev/sda
> allow_mounted_write=0
> ioengine=psync
> direct=1
> ioscheduler=bfq
> offset_increment=10g
> group_reporting
> rw=randwrite
> bs=4k
> 
> [test1]
> numjobs=1
> 
> [test2]
> startdelay=1
> numjobs=1
> 
> [test3]
> startdelay=2
> numjobs=1
> 
> [test4]
> startdelay=3
> numjobs=1
> 
> [test5]
> startdelay=4
> numjobs=1
> 
> [test6]
> startdelay=5
> numjobs=1
> 
> [test7]
> startdelay=6
> numjobs=1
> 
> [test8]
> startdelay=7
> numjobs=1
> 
> test result:
> running fio on root cgroup
> v5.18:	   112 Mib/s
> v5.18-patched: 112 Mib/s
> 
> running fio on non-root cgroup
> v5.18:	   51.2 Mib/s
> v5.18-patched: 112 Mib/s
> 
> Note that I also test null_blk with "irqmode=2
> completion_nsec=100000000(100ms) hw_queue_depth=1", and tests show
> that service guarantees are still preserved.
> 
> Previous versions:
> RFC: https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/
> v1: https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/
> v2: https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/
> v3: https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
> v4: https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/
> v5: https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/
> v6: https://lore.kernel.org/all/20220523131818.2798712-1-yukuai3@huawei.com/
> v7: https://lore.kernel.org/all/20220528095020.186970-1-yukuai3@huawei.com/
> 
> 
> Yu Kuai (4):
>    block, bfq: support to track if bfqq has pending requests
>    block, bfq: record how many queues have pending requests
>    block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
>    block, bfq: do not idle if only one group is activated
> 
>   block/bfq-cgroup.c  | 10 ++++++++++
>   block/bfq-iosched.c | 47 +++------------------------------------------
>   block/bfq-iosched.h | 21 +++++++++++---------
>   block/bfq-wf2q.c    | 47 ++++++++++++++++++++++++++++++---------------
>   4 files changed, 57 insertions(+), 68 deletions(-)
> 
