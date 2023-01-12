Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6888666B25
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 07:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjALGSY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 01:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjALGSX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 01:18:23 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D931263E;
        Wed, 11 Jan 2023 22:18:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsvVv0tWQz4f3wQw;
        Thu, 12 Jan 2023 14:18:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCXtjAnpr9jeF7hBQ--.43940S3;
        Thu, 12 Jan 2023 14:18:17 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
 <Y72wF/b0/xNRmP7f@slm.duckdns.org>
 <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
 <Y77s0f741mFfGlTO@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4aeef320-c6c8-d9b4-8826-d58f00ea6264@huaweicloud.com>
Date:   Thu, 12 Jan 2023 14:18:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y77s0f741mFfGlTO@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXtjAnpr9jeF7hBQ--.43940S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15Aw4UGr1kXr1kZryxZrb_yoW8GFW8pF
        WfG3sagrWvyw1IyrnFyw4xX34Ska1UAr15KFyDG3yfCr4Fgr92kFyfAr1DAF93JFs5tFyY
        gFyYgF17W39rAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/01/12 1:07, Tejun Heo 写道:
> Hello,
> 
> On Wed, Jan 11, 2023 at 09:36:25AM +0800, Yu Kuai wrote:
>> I'm not sure, of course this can fix the problem, but two spinlock
>> 'blkcg->lock' and 'q->queue_lock' are used to protect blkg_destroy()
>> currently, add a mutex（disk level?) requires a refactor, which seems
>> complex to me.
> 
> The fact that the two paths can race each other already seems buggy. e.g.
> What prevents them from running pd_free on the same pd twice? So, it needs

I think the root cause is that blkg is tracked from two different list,
blkcg->blkg_list from cgroup level and q->blkg_list from disk level. And
pd_free_fn is also called from both blkg_destroy() and deactivate policy
for a disk.

I just thought about another solution:

remove the blkcg_deactivate_policy() from rq_qos_exit() from deleting
the device, and delay the policy cleanup and free to blkg_destroy_all().
Then the policies(other than bfq) can only call pd_free_fn() from
blkg_destroy(), and it's easy to guarantee the order. For bfq, it can
stay the same since bfq has refcounting itself.

Then for the problem that ioc can be freed in pd_free_fn(), we can fix
it by freeing ioc in ioc_pd_free() for root blkg instead of
rq_qos_exit().

What do you think?

Thanks,
Kuai
> to be fixed anyway and the intention always has been that these callbacks
> are called in the correct traversal order.
> 
> Thanks.
> 

