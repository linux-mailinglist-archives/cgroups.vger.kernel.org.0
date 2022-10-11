Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D145FAE18
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJKILR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJKILM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 04:11:12 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E7F84E5F;
        Tue, 11 Oct 2022 01:11:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MmpMQ68Kyz6R4sN;
        Tue, 11 Oct 2022 16:08:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3N8kXJUVj8WhiAA--.27391S3;
        Tue, 11 Oct 2022 16:11:03 +0800 (CST)
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail
 occasion
To:     Paolo Valente <paolo.valente@linaro.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <29348B39-94AE-4D76-BD2E-B759056264B6@linaro.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <011d479f-644f-0013-40bf-664b62f93bec@huaweicloud.com>
Date:   Tue, 11 Oct 2022 16:11:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29348B39-94AE-4D76-BD2E-B759056264B6@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3N8kXJUVj8WhiAA--.27391S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF15Jw4DGr4xKw18ArWfAFb_yoW7uF13pa
        ySqa1a9r4jqr13JwsxK34UXasYq3WrJryUWrn3J34rCr47ZF1rA3WIkr1F9F9rZrZ3Gr1I
        vr43tw4Fk34jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, paolo

ÔÚ 2022/09/28 0:38, Paolo Valente Ð´µÀ:
> 
> 
>> Il giorno 16 set 2022, alle ore 09:19, Yu Kuai <yukuai1@huaweicloud.com> ha scritto:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v11:
>> - keep the comments in bfq_weights_tree_remove() and move it to the
>> caller where bfqq can be freed.
>> - add two followed up cleanup patches.
>>
>> Changes in v10:
>> - Add reviewed-tag for patch 2
>>
>> Changes in v9:
>> - also update how many bfqqs have pending_reqs bfq_bfqq_move().
>> - fix one language in patch 4
>> - Add reviewed-tag for patch 1,3,4
>>
>> Changes in v8:
>> - Instead of using whether bfqq is busy, using whether bfqq has pending
>> requests. As Paolo pointed out the former way is problematic.
>>
>> Changes in v7:
>> - fix mismatch bfq_inc/del_busy_queues() and bfqq_add/del_bfqq_busy(),
>> also retest this patchset on v5.18 to make sure functionality is
>> correct.
>> - move the updating of 'bfqd->busy_queues' into new apis
>>
>> Changes in v6:
>> - add reviewed-by tag for patch 1
>>
>> Changes in v5:
>> - rename bfq_add_busy_queues() to bfq_inc_busy_queues() in patch 1
>> - fix wrong definition in patch 1
>> - fix spelling mistake in patch 2: leaset -> least
>> - update comments in patch 3
>> - add reviewed-by tag in patch 2,3
>>
>> Changes in v4:
>> - split bfq_update_busy_queues() to bfq_add/dec_busy_queues(),
>>    suggested by Jan Kara.
>> - remove unused 'in_groups_with_pending_reqs',
>>
>> Changes in v3:
>> - remove the cleanup patch that is irrelevant now(I'll post it
>>    separately).
>> - instead of hacking wr queues and using weights tree insertion/removal,
>>    using bfq_add/del_bfqq_busy() to count the number of groups
>>    (suggested by Jan Kara).
>>
>> Changes in v2:
>> - Use a different approch to count root group, which is much simple.
>>
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>>
>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>
>> Before this patchset:
>> 1) root group will never be counted.
>> 2) Count if bfqg or it's child bfqgs have pending requests.
>> 3) Don't count if bfqg and it's child bfqgs complete all the requests.
>>
>> After this patchset:
>> 1) root group is counted.
>> 2) Count if bfqg has pending requests.
>> 3) Don't count if bfqg complete all the requests.
>>
>> With the above changes, concurrent sync io can be supported if only
>> one group is activated.
>>
>> fio test script(startdelay is used to avoid queue merging):
>> [global]
>> filename=/dev/sda
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
>> v5.18:	   112 Mib/s
>> v5.18-patched: 112 Mib/s
>>
>> running fio on non-root cgroup
>> v5.18:	   51.2 Mib/s
>> v5.18-patched: 112 Mib/s
>>
>> Note that I also test null_blk with "irqmode=2
>> completion_nsec=100000000(100ms) hw_queue_depth=1", and tests show
>> that service guarantees are still preserved.
>>
> 
> Your patches seem ok to me now (thanks for you contribution and, above all, for your patience). I have only a high-level concern: what do you mean when you say that service guarantees are still preserved? What test did you run exactly? This point is very important to me. I'd like to see some convincing test with differentiated weights. In case you don't have other tools for executing such tests quickly, you may want to use the bandwidth-latency test in my simple S benchmark suite (for which I'm willing to help).

Is there any test that you wish me to try?

By the way, I think for the case that multiple groups are activaced, (
specifically num_groups_with_pendind_rqs > 1), io path in bfq is the
same with or without this patchset.

Thanks,
Kuai
> 
> Thanks,
> Paolo
> 
>> Previous versions:
>> RFC: https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/
>> v1: https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/
>> v2: https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/
>> v3: https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
>> v4: https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/
>> v5: https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/
>> v6: https://lore.kernel.org/all/20220523131818.2798712-1-yukuai3@huawei.com/
>> v7: https://lore.kernel.org/all/20220528095020.186970-1-yukuai3@huawei.com/
>>
>>
>> Yu Kuai (6):
>>   block, bfq: support to track if bfqq has pending requests
>>   block, bfq: record how many queues have pending requests
>>   block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
>>   block, bfq: do not idle if only one group is activated
>>   block, bfq: cleanup bfq_weights_tree add/remove apis
>>   block, bfq: cleanup __bfq_weights_tree_remove()
>>
>> block/bfq-cgroup.c  | 10 +++++++
>> block/bfq-iosched.c | 71 +++++++--------------------------------------
>> block/bfq-iosched.h | 30 +++++++++----------
>> block/bfq-wf2q.c    | 69 ++++++++++++++++++++++++++-----------------
>> 4 files changed, 76 insertions(+), 104 deletions(-)
>>
>> -- 
>> 2.31.1
>>
> 
> .
> 

