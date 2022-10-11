Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895F15FADD4
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJKHxf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJKHxe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 03:53:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38089937;
        Tue, 11 Oct 2022 00:53:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmnzV6CGMzl43H;
        Tue, 11 Oct 2022 15:51:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHB8n5IEVjptVhAA--.24519S3;
        Tue, 11 Oct 2022 15:53:30 +0800 (CST)
Subject: Re: [PATCH 3/4] blk-cgroup: Add NULL check of pd_alloc_fn in
 blkcg_activate_policy
To:     Tejun Heo <tj@kernel.org>, Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-4-shikemeng@huawei.com>
 <Y0SAneaJadYJwAkr@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8de2f8d1-f3ec-4d93-f7e8-403d609ae9e7@huaweicloud.com>
Date:   Tue, 11 Oct 2022 15:53:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y0SAneaJadYJwAkr@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHB8n5IEVjptVhAA--.24519S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw48Aw1UZrWUCFyfJr17GFg_yoW8Jr4Dpr
        W3GF9YyasIqFZF9F4Ig3WSqrW8Xw4rJry5J348W345ZrW7Cr9akw1DZ3ZYq3WxZrsrCF45
        XFW5tFW09F40ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

ÔÚ 2022/10/11 4:29, Tejun Heo Ð´µÀ:
> On Mon, Oct 10, 2022 at 10:38:58AM +0800, Kemeng Shi wrote:
>> Function only make sure pd_alloc_fn and pd_free_fn in
>> pairs, so pd_alloc_fn could be NULL in registered blkcg_policy. Check NULL
>> before use for pd_alloc_fn in blkcg_activate_policy to avoid protential
>> NULL dereference.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>> ---
>>   block/blk-cgroup.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 463c568d3e86..fc083c35dc42 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1404,6 +1404,9 @@ int blkcg_activate_policy(struct request_queue *q,
>>   	if (blkcg_policy_enabled(q, pol))
>>   		return 0;
>>   
>> +	if (pol->pd_alloc_fn == NULL)
>> +		return -EINVAL;
> 
> This isn't the only place this function is called, so the above won't
> achieve much. Given that this is rather trivially noticeable and all the
> current users do implement pd_alloc_fn, I'm not sure we need to update this
> now.

It's right all the current users implement pd_alloc_fn, can we check
pd_alloc/free_fn NULL instead in blkcg_policy_register()?

Thanks,
Kuai
> 
> Thanks.
> 

