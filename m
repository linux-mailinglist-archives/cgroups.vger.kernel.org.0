Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC497000FB
	for <lists+cgroups@lfdr.de>; Fri, 12 May 2023 09:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjELHED (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 May 2023 03:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjELHEA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 May 2023 03:04:00 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F87A84;
        Fri, 12 May 2023 00:03:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QHfr14XYGz4f3nwY;
        Fri, 12 May 2023 15:03:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHpALR5F1k1LMlIg--.57523S3;
        Fri, 12 May 2023 15:03:47 +0800 (CST)
Subject: Re: [PATCH -next 1/6] blk-wbt: fix that wbt can't be disabled by
 default
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com>
 <20230511014509.679482-2-yukuai1@huaweicloud.com>
 <20230511151919.GA7880@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <43cbe02a-a4bd-7e6b-6b3c-c35b2e045136@huaweicloud.com>
Date:   Fri, 12 May 2023 15:03:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230511151919.GA7880@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHpALR5F1k1LMlIg--.57523S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1xZw1kKF13Jr1DJFy8AFb_yoWDWrXEgF
        WvvrZ7X3y3CrWftw4kJFyjkFZ7JFs8AryxKFZ2vF4UJF4kJFZ8Zrs7ZrZxA343Gw1FkF9I
        9ry5ZFy7ZrW3AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/05/11 23:19, Christoph Hellwig Ð´µÀ:
> On Thu, May 11, 2023 at 09:45:04AM +0800, Yu Kuai wrote:
>> @@ -730,8 +730,9 @@ void wbt_enable_default(struct gendisk *disk)
>>   {
>>   	struct request_queue *q = disk->queue;
>>   	struct rq_qos *rqos;
>> -	bool disable_flag = q->elevator &&
>> -		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
>> +	bool disable_flag = (q->elevator &&
>> +		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags)) ||
>> +		    !IS_ENABLED(CONFIG_BLK_WBT_MQ);
> 
> Not really new in your patch, but I find the logic here very confusing.
> First the disable_flag really should be enable instead, as that's how
> it's actually checked, and then spelling out the conditions a bit more
> would really help readability.  E.g.
> 
> 	bool enabled = IS_ENABLED(CONFIG_BLK_WBT_MQ);
> 
> 	if (q->elevator &&
> 	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
> 		enable = false;

Of course, this looks better, I'll do this in v2.

Thanks,
Kuai
> 
> 
> .
> 

