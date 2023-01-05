Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55D65E25E
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 02:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjAEBO4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 20:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjAEBO2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 20:14:28 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847B44353;
        Wed,  4 Jan 2023 17:14:12 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NnT5B6cFzz4f3vf5;
        Thu,  5 Jan 2023 09:14:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBfJLZjS1R6BA--.60579S3;
        Thu, 05 Jan 2023 09:14:09 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
Date:   Thu, 5 Jan 2023 09:14:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBfJLZjS1R6BA--.60579S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3tryxWryxJry8tF18Krg_yoW8GrWDpa
        97Gas0k398Xr1IkFsFya1jq34rKw4rXrWrGrWkGryrA3yxCwnF9rWjyrW5Ca4rZF4fXF1Y
        qF1Sva1UGw4jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/05 5:44, Tejun Heo Ð´µÀ:
> On Tue, Dec 27, 2022 at 08:55:01PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> iocost requires that child iocg must exit before parent iocg, otherwise
>> kernel might crash in ioc_timer_fn(). However, currently iocg is exited
>> in pd_free_fn(), which can't guarantee such order:
>>
>> 1) remove cgroup can concurrent with deactivate policy;
>> 2) blkg_free() triggered by remove cgroup is asynchronously, remove
>> child cgroup can concurrent with remove parent cgroup;
>>
>> Fix the problem by add refcounting for iocg, and child iocg will grab
>> reference of parent iocg, so that parent iocg will wait for all child
>> iocg to be exited.
> 
> Wouldn't it be better to do this refcnting in the blk-cgroup core code
> rather than in blk-iocost?
> 

The problem is that I can't find a proper way to fix the competition
that pd_free_fn() can be called from different context:

1) from blkg_free() that is called asynchronously from removing cgroup;
2) from blkcg_deactivate_policy() that is called from removing device;

1) is related to blkg, while 2) is not, hence refcnting from blkg can't
fix the problem. refcnting from blkcg_policy_data should be ok, but I
see that bfq already has the similar refcnting, while other policy
doesn't require such refcnting.

Any suggestions?

Thanks,
Kuai
> Thanks.
> 

