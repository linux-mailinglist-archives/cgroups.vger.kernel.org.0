Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8147BE94
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 12:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhLULIt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Dec 2021 06:08:49 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29273 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhLULIs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Dec 2021 06:08:48 -0500
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJDGH3hx4zbjY2;
        Tue, 21 Dec 2021 19:08:23 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:08:46 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:08:45 +0800
Subject: Re: [PATCH 2/4] block, bfq: avoid moving bfqq to it's parent bfqg
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-3-yukuai3@huawei.com>
 <20211221101659.GB24748@quack2.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <d1c91a5f-33f3-ffad-e1ad-fb91482eb864@huawei.com>
Date:   Tue, 21 Dec 2021 19:08:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211221101659.GB24748@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2021/12/21 18:16, Jan Kara Ð´µÀ:
> On Tue 21-12-21 11:21:33, Yu Kuai wrote:
>> Moving bfqq to it's parent bfqg is pointless.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Did you notice that this is happening often enough that the check is worth
> it? Where do we do this?
> 

I noticed that this will happend when root group is offlined:

bfq_pd_offline
  bfq_put_async_queues
   __bfq_put_async_bfqq
    bfq_bfqq_move

I'm not sure if there are other situations. I think bfq_bfqq_move()
is not happening often itself, thus the checking won't affect
performance.

Thanks,
Kuai
> 								Honza
> 
>> ---
>>   block/bfq-cgroup.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index 24a5c5329bcd..0f62546a72d4 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -645,6 +645,11 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>   		   struct bfq_group *bfqg)
>>   {
>>   	struct bfq_entity *entity = &bfqq->entity;
>> +	struct bfq_group *old_parent = bfq_group(bfqq);
>> +
>> +	/* No point to move bfqq to the same group */
>> +	if (old_parent == bfqg)
>> +		return;
>>   
>>   	/*
>>   	 * Get extra reference to prevent bfqq from being freed in
>> @@ -666,7 +671,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>   		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>>   	else if (entity->on_st_or_in_serv)
>>   		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
>> -	bfqg_and_blkg_put(bfqq_group(bfqq));
>> +	bfqg_and_blkg_put(old_parent);
>>   
>>   	if (entity->parent &&
>>   	    entity->parent->last_bfqq_created == bfqq)
>> -- 
>> 2.31.1
>>
