Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B853A350
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbiFAK6H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFAK6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 06:58:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169F81997;
        Wed,  1 Jun 2022 03:58:04 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LCmLc2MrVzjX9B;
        Wed,  1 Jun 2022 18:57:12 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 18:58:02 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 18:58:01 +0800
Subject: Re: [PATCH -next v8 2/4] block, bfq: record how many queues have
 pending requests
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <axboe@kernel.dk>, <tj@kernel.org>,
        <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
 <20220531140858.3324294-3-yukuai3@huawei.com>
 <20220601083529.oz26s6jefxz6fnyg@quack3.lan>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <3ab7ab6e-474d-d5d7-a1c0-f75b3b092bbe@huawei.com>
Date:   Wed, 1 Jun 2022 18:58:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220601083529.oz26s6jefxz6fnyg@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/06/01 16:35, Jan Kara Ð´µÀ:
> On Tue 31-05-22 22:08:56, Yu Kuai wrote:
>> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
>>
>> Add a counter in bfq_group, and update it while tracking if bfqq have
>> pending requests.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Looks good, except I think that we also need to update the counters
> 'num_groups_with_pending_reqs' in bfq_move_bfqq()?
Yes, you're right. I'll do that in next version.

Thanks,
Kuai
> 
> 								Honza
> 
>> ---
>>   block/bfq-cgroup.c  |  1 +
>>   block/bfq-iosched.h |  1 +
>>   block/bfq-wf2q.c    | 12 ++++++++++--
>>   3 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index 09574af83566..0954a258a107 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
>>   				   */
>>   	bfqg->bfqd = bfqd;
>>   	bfqg->active_entities = 0;
>> +	bfqg->num_queues_with_pending_reqs = 0;
>>   	bfqg->online = true;
>>   	bfqg->rq_pos_tree = RB_ROOT;
>>   }
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 3b9b1a0e7c1c..a5f7c0c1a3b3 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -943,6 +943,7 @@ struct bfq_group {
>>   	struct bfq_entity *my_entity;
>>   
>>   	int active_entities;
>> +	int num_queues_with_pending_reqs;
>>   
>>   	struct rb_root rq_pos_tree;
>>   
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 12d20f26ad69..b533e17e9f0c 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -1651,16 +1651,24 @@ static void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>>   {
>>   	struct bfq_entity *entity = &bfqq->entity;
>>   
>> -	if (!entity->in_groups_with_pending_reqs)
>> +	if (!entity->in_groups_with_pending_reqs) {
>>   		entity->in_groups_with_pending_reqs = true;
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>> +		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
>> +#endif
>> +	}
>>   }
>>   
>>   void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>>   {
>>   	struct bfq_entity *entity = &bfqq->entity;
>>   
>> -	if (entity->in_groups_with_pending_reqs)
>> +	if (entity->in_groups_with_pending_reqs) {
>>   		entity->in_groups_with_pending_reqs = false;
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>> +		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
>> +#endif
>> +	}
>>   }
>>   
>>   /*
>> -- 
>> 2.31.1
>>
