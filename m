Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED5B651D8E
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 10:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiLTJiN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 04:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTJiM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 04:38:12 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30956E7;
        Tue, 20 Dec 2022 01:38:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nbs241Ps8z4f3kp0;
        Tue, 20 Dec 2022 17:38:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J9gqFjqGHIAA--.26945S3;
        Tue, 20 Dec 2022 17:38:07 +0800 (CST)
Subject: Re: [PATCH -next 2/4] blk-iocost: don't throttle bio if iocg is
 offlined
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
 <20221217030527.1250083-3-yukuai1@huaweicloud.com>
 <Y6DXkLeOmu7VWovz@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <beb75b37-6088-5f23-6602-5aff22213e41@huaweicloud.com>
Date:   Tue, 20 Dec 2022 17:38:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y6DXkLeOmu7VWovz@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J9gqFjqGHIAA--.26945S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr4xtr17Aw1kZFWfuw4Uurg_yoW8Jr48pF
        yfG395Cr4qy3yftrWay3W8trySvFs3Zry5AryfKw1DCFWaqF9Yyr4fJw17ury5WFs7W3yx
        GF1Fvay8Xwn0y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/12/20 5:28, Tejun Heo Ð´µÀ:
> On Sat, Dec 17, 2022 at 11:05:25AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> bio will grab blkg reference, however, blkcg->online_pin is not grabbed,
>> hence cgroup can be removed after thread exit while bio is still in
>> progress. Bypass io in this case since it doesn't make sense to
>> throttle bio while cgroup is removed.
> 
> I don't get it. Why wouldn't that make sense? ISTR some occasions where we
> clear the config to mitigate exits stalling for too long but in general a
> policy being active on a draining cgroup shouldn't be a problem.

The main reason here for patch 2/3 is for patch 4, since bio can still
reach rq_qos after pd_offline_fn is called.

Currently, it's not consistent and seems messy how different policies
implement pd_alloc/free_fn, pd_online/offline_fn, and pd_init_fn. For
iocost, iocg is exited in pd_free_fn, and parent iocg can exits before
child, which will cause many problems.

Patch 2/3 are not necessary if we don't choose to fix such problems by
exiting iocg in ioc_pd_offline() in patch 4.

I'll try to think about how to use refcnting, either from blkg layer or
add refcnting for iocg.

Thanks,
Kuai
> 
> Thanks.
> 

