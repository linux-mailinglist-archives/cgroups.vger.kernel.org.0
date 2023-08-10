Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA616776E6C
	for <lists+cgroups@lfdr.de>; Thu, 10 Aug 2023 05:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjHJDUM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHJDUK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 23:20:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48E10EC;
        Wed,  9 Aug 2023 20:20:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLscN06lBz4f3v4f;
        Thu, 10 Aug 2023 11:20:04 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6ljV9Rkz4xoAQ--.17685S3;
        Thu, 10 Aug 2023 11:20:05 +0800 (CST)
Message-ID: <e5539fc2-9c30-3da5-ce81-fd67fc0fd53a@huaweicloud.com>
Date:   Thu, 10 Aug 2023 11:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH -next v2] block: remove init_mutex and open-code
 blk_iolatency_try_init
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20230809112928.2009183-1-lilingfeng@huaweicloud.com>
 <6dcshmol4oz4hpsm42s3ocfdg7rtykkx2vjg6fd6zdvmkbmg7w@4liecv2rxqqk>
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <6dcshmol4oz4hpsm42s3ocfdg7rtykkx2vjg6fd6zdvmkbmg7w@4liecv2rxqqk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6ljV9Rkz4xoAQ--.17685S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw17XFWxWFWDKw13urW3ZFb_yoWDJFc_W3
        95ZFn7Ar47Gay0yrn8Grs3Was5WF4DXFy8uFW7tFyUJ3s3X3ykJr48Cr98Zay3uw42yrZ3
        Ar1qvw48Ary8WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


在 2023/8/9 20:11, Michal Koutný 写道:
> On Wed, Aug 09, 2023 at 07:29:28PM +0800, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
>>   1 file changed, 10 insertions(+), 24 deletions(-)
> I like this bottom line.
>
>> @@ -861,7 +838,16 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
>>   
>>   	blkg_conf_init(&ctx, buf);
>>   
>> -	ret = blk_iolatency_try_init(&ctx);
>> +	ret = blkg_conf_open_bdev(&ctx);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/*
>> +	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
>> +	 * confuse iolat_rq_qos() test. Make the test and init atomic.
>> +	 */
> Perhaps add here
> 	lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);
>
> because without that the last sentence of the comment misses the
> context.

Yes, it looks better.

Thanks.

Li

>
>> +	if (!iolat_rq_qos(ctx.bdev->bd_queue))
>> +		ret = blk_iolatency_init(ctx.bdev->bd_disk);
>>   	if (ret)
>>   		goto out;
> Thanks,
> Michal

