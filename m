Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BA67FD0F
	for <lists+cgroups@lfdr.de>; Sun, 29 Jan 2023 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA2GGT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Jan 2023 01:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjA2GGS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Jan 2023 01:06:18 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453531CACC;
        Sat, 28 Jan 2023 22:06:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P4LR65qgnz4f3nZ1;
        Sun, 29 Jan 2023 14:06:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CHTDNZjq3uBCQ--.42076S3;
        Sun, 29 Jan 2023 14:06:13 +0800 (CST)
Subject: Re: [PATCH -next v3 0/3] blk-cgroup: make sure pd_free_fn() is called
 in order
To:     Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
        tj@kernel.org, hch@lst.de, josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
 <bd1c347b-cbf8-3917-401a-ed85c6ccb956@kernel.dk>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0ddce9e4-d027-0bb0-d260-093ccc4c2d4d@huaweicloud.com>
Date:   Sun, 29 Jan 2023 14:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bd1c347b-cbf8-3917-401a-ed85c6ccb956@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CHTDNZjq3uBCQ--.42076S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4kuryDWFy7ur1ruryUKFg_yoWkArc_uF
        Z8K3ykGa48JF1xCa1FyFs8ZFWFk3WDZ3y8XrWUJF4IqryUXay3GanrCFyxWa1rJFWFkryf
        Arn0934Yq39FvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jens

在 2023/01/20 2:54, Jens Axboe 写道:
> On 1/19/23 4:03 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v3:
>>   - add ack tag from Tejun for patch 1,2
>>   - as suggested by Tejun, update commit message and comments in patch 3
>>
>> The problem was found in iocost orignally([1]) that ioc can be freed in
>> ioc_pd_free(). And later we found that there are more problem in
>> iocost([2]).
>>
>> After some discussion, as suggested by Tejun([3]), we decide to fix the
>> problem that parent pd can be freed before child pd in cgroup layer
>> first. And the problem in [1] will be fixed later if this patchset is
>> applied.
> 
> Doesn't apply against for-6.3/block (or linux-next or my for-next, for
> that matter). Can you resend a tested one against for-6.3/block?
> 

This is weird, I just test latest linux-next, and I can apply this
patchset on the top of following commit:

For latest for-6.3/block, this patch 2 can't be applied because
following commit is not here:

e3ff8887e7db blk-cgroup: fix missing pd_online_fn() while activating policy

But this patch is already merged into 6.2-rc5.

Thanks,
Kuai

