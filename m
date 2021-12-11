Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935074710C8
	for <lists+cgroups@lfdr.de>; Sat, 11 Dec 2021 03:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbhLKCWl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 21:22:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29122 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhLKCWg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 21:22:36 -0500
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J9rwh4Dw7z1DK2V;
        Sat, 11 Dec 2021 10:16:04 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 10:18:55 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 10:18:54 +0800
Subject: Re: [PATCH RFC 8/9] block, bfq: move forward
 __bfq_weights_tree_remove()
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <20211127101132.486806-9-yukuai3@huawei.com>
 <FA78962A-DC03-4A1F-9B79-D085A4908E5E@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <93f26416-19d9-43f6-01ad-652c1b763d09@huawei.com>
Date:   Sat, 11 Dec 2021 10:18:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <FA78962A-DC03-4A1F-9B79-D085A4908E5E@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2021/12/10 18:00, Paolo Valente Ð´µÀ:
> 
> 
>> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>
>> Prepare to decrease 'num_groups_with_pending_reqs' earlier.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> block/bfq-iosched.c | 13 +++++--------
>> 1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index e3c31db4bffb..4239b3996e23 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -882,6 +882,10 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> {
>> 	struct bfq_entity *entity = bfqq->entity.parent;
>>
>> +	bfqq->ref++;
>> +	__bfq_weights_tree_remove(bfqd, bfqq,
>> +				  &bfqd->queue_weights_tree);
>> +
>> 	for_each_entity(entity) {
>> 		struct bfq_sched_data *sd = entity->my_sched_data;
>>
>> @@ -916,14 +920,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> 		}
>> 	}
>>
>> -	/*
>> -	 * Next function is invoked last, because it causes bfqq to be
>> -	 * freed if the following holds: bfqq is not in service and
>> -	 * has no dispatched request. DO NOT use bfqq after the next
>> -	 * function invocation.
>> -	 */
>> -	__bfq_weights_tree_remove(bfqd, bfqq,
>> -				  &bfqd->queue_weights_tree);
>> +	bfq_put_queue(bfqq);
>> }
>>
> 
> why it is not dangerous any longer to invoke __bfq_weights_tree_remove earlier, and the comment can be removed?

Hi, Paolo

Here I grab an additional ref to the bfqq, thus the bfqq is ensured not
to be free before bfq_put_queue() at the end of the function.

Maybe some comments is more appropriate.

Thanks,
Kuai
> 
> Paolo
> 
>> /*
>> -- 
>> 2.31.1
>>
> 
> .
> 
