Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9B779C52
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 03:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjHLBmd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 21:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjHLBmc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 21:42:32 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90830F8;
        Fri, 11 Aug 2023 18:42:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RN3Lq25LTz4f3lgP;
        Sat, 12 Aug 2023 09:42:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnBaiC49Zktr0CAg--.15227S3;
        Sat, 12 Aug 2023 09:42:28 +0800 (CST)
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     josef@toxicpanda.com, mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <169176317573.160467.10047297090390573799.b4-ty@kernel.dk>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b93e426e-d9b6-34df-be28-90b715c7a711@huaweicloud.com>
Date:   Sat, 12 Aug 2023 09:42:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <169176317573.160467.10047297090390573799.b4-ty@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBaiC49Zktr0CAg--.15227S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4DtF47AFyrur1xtF1DWrg_yoWkXwbE9F
        48JF9Igr4DGa1Yywn8KF43G3sYgaykur17CFy7X3y3ur4fJrZ8CF42y3s8WFW5GrWIkw4k
        Gr1Y9w1xKr1rujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jens

在 2023/08/11 22:12, Jens Axboe 写道:
> 
> On Thu, 10 Aug 2023 11:51:11 +0800, Li Lingfeng wrote:
>> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
>> a mutex named "init_mutex" in blk_iolatency_try_init for the race
>> condition of initializing RQ_QOS_LATENCY.
>> Now a new lock has been add to struct request_queue by commit a13bd91be223
>> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
>> held in blkg_conf_open_bdev before calling blk_iolatency_init.
>> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
>> remove it.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: remove init_mutex and open-code blk_iolatency_try_init
>        commit: 4eb44d10766ac0fae5973998fd2a0103df1d3fe1

This version has a minor problem that pss in mutex for
lockdep_assert_held() is not a pointer:

 > lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);

should be:
lockdep_assert_held(&ctx.bdev->bd_queue->rq_qos_mutex);

Perhaps can you drop this patch for now, and Lingfeng can send a v4?

Thanks,
Kuai

> 
> Best regards,
> 

