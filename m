Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFA621212
	for <lists+cgroups@lfdr.de>; Tue,  8 Nov 2022 14:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiKHNPP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Nov 2022 08:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiKHNPO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Nov 2022 08:15:14 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103B27B20;
        Tue,  8 Nov 2022 05:15:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N67qv3Tfsz4f3mJP;
        Tue,  8 Nov 2022 21:15:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAn0a9cVmpjc06yAA--.42643S3;
        Tue, 08 Nov 2022 21:15:10 +0800 (CST)
Subject: Re: [PATCH] block, bfq: fix null pointer dereference in
 bfq_bio_bfqg()
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221108103434.2853269-1-yukuai1@huaweicloud.com>
 <20221108124841.et6cddvczncp2cz7@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6cd64e77-e14d-ff9c-d97f-055165a7b214@huaweicloud.com>
Date:   Tue, 8 Nov 2022 21:15:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221108124841.et6cddvczncp2cz7@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAn0a9cVmpjc06yAA--.42643S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFykGr45WFy5AFWDXF43ZFb_yoW3Crb_Gw
        10yw10yFyDA3ySyr1qyr1aqa9YyrZ2qwna9r1YkFZ3Z3WkJan7A3srGw48JrZxCry8Cr1a
        vrn8Xwn3GFn5ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkI
        wI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi!

ÔÚ 2022/11/08 20:48, Jan Kara Ð´µÀ:
> 
> Hum, that is indeed contrieved ;). Your fixup makes sense so feel free to
> add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for the review, our test do many unusual operations together...

Thanks,
Kuai
> 
> 								Honza
> 
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index 144bca006463..7d624a3a3f0f 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -610,6 +610,10 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
>>   	struct bfq_group *bfqg;
>>   
>>   	while (blkg) {
>> +		if (!blkg->online) {
>> +			blkg = blkg->parent;
>> +			continue;
>> +		}
>>   		bfqg = blkg_to_bfqg(blkg);
>>   		if (bfqg->online) {
>>   			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
>> -- 
>> 2.31.1
>>

