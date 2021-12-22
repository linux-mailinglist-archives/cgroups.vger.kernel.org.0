Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1247CB8D
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 04:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhLVDMu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Dec 2021 22:12:50 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29279 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbhLVDMt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Dec 2021 22:12:49 -0500
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJdfc1ff6zbjM8;
        Wed, 22 Dec 2021 11:12:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 11:12:47 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 11:12:46 +0800
Subject: Re: [PATCH 4/4] block, bfq: update pos_root for idle bfq_queue in
 bfq_bfqq_move()
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-5-yukuai3@huawei.com>
 <20211221115001.GD24748@quack2.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6ca1e924-47fa-b94e-598c-69a9549eb68e@huawei.com>
Date:   Wed, 22 Dec 2021 11:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211221115001.GD24748@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2021/12/21 19:50, Jan Kara Ð´µÀ:
> On Tue 21-12-21 11:21:35, Yu Kuai wrote:
>> During code review, we found that if bfqq is not busy in
>> bfq_bfqq_move(), bfq_pos_tree_add_move() won't be called for the bfqq,
>> thus bfqq->pos_root still points to the old bfqg. However, the ref
>> that bfqq hold for the old bfqg will be released, so it's possible
>> that the old bfqg can be freed. This is problematic because the freed
>> bfqg can still be accessed by bfqq->pos_root.
>>
>> Fix the problem by calling bfq_pos_tree_add_move() for idle bfqq
>> as well.
>>
>> Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> I'm just wondering, how can it happen that !bfq_bfqq_busy() queue is in
> pos_tree? Because bfq_remove_request() takes care to remove bfqq from the
> pos_tree...

Hi,

It's right this is not a problem in common case. The problem seems to
relate to queue merging and task migration. Because I once reporduced
it with the same reporducer for the problem that offlined bfqg can be
inserted into service tree. The uaf is exactly in
bfq_remove_request->rb_rease(). However I didn't save the stack...

I guess this is because bfq_del_bfqq_busy() is called from
bfq_release_process_ref(), and queue merging prevert sunch bfqq to be
freed, thus such bfqq is not in service tree, and it's pos_root can
point to the old bfqg after bfq_bic_update_cgroup->bfq_bfqq_move.

I haven't confirmed this, however, this patch itself only cleared
bfqq->pos_root for idle bfqq, there should be no harm.

Thanks,
Kuai
> 
> 								Honza
> 
>> ---
>>   block/bfq-cgroup.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index 8e8cf6b3d946..822dd28ecf53 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -677,7 +677,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>   		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>>   	else if (entity->on_st_or_in_serv)
>>   		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
>> -	bfqg_and_blkg_put(old_parent);
>>   
>>   	if (entity->parent &&
>>   	    entity->parent->last_bfqq_created == bfqq)
>> @@ -690,11 +689,16 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>   	/* pin down bfqg and its associated blkg  */
>>   	bfqg_and_blkg_get(bfqg);
>>   
>> -	if (bfq_bfqq_busy(bfqq)) {
>> -		if (unlikely(!bfqd->nonrot_with_queueing))
>> -			bfq_pos_tree_add_move(bfqd, bfqq);
>> +	/*
>> +	 * Don't leave the pos_root to old bfqg, since the ref to old bfqg will
>> +	 * be released and the bfqg might be freed.
>> +	 */
>> +	if (unlikely(!bfqd->nonrot_with_queueing))
>> +		bfq_pos_tree_add_move(bfqd, bfqq);
>> +	bfqg_and_blkg_put(old_parent);
>> +
>> +	if (bfq_bfqq_busy(bfqq))
>>   		bfq_activate_bfqq(bfqd, bfqq);
>> -	}
>>   
>>   	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
>>   		bfq_schedule_dispatch(bfqd);
>> -- 
>> 2.31.1
>>
