Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB14FF57A
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiDMLNt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiDMLNt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 07:13:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F992315A;
        Wed, 13 Apr 2022 04:11:27 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kdfyx4VGnz1HBn8;
        Wed, 13 Apr 2022 19:10:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:11:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:11:24 +0800
Subject: Re: [PATCH -next 02/11] block, bfq: apply news apis where root group
 is not expected
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-3-yukuai3@huawei.com>
 <20220413095044.uwxeqli2ytcdanem@quack3.lan>
 <20220413105932.lzvlafeilinuqcw3@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7b99bbcb-9d65-387f-0c1e-4377a7beff58@huawei.com>
Date:   Wed, 13 Apr 2022 19:11:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220413105932.lzvlafeilinuqcw3@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/04/13 18:59, Jan Kara Ð´µÀ:
> On Wed 13-04-22 11:50:44, Jan Kara wrote:
>> On Sat 05-03-22 17:11:56, Yu Kuai wrote:
>>> 'entity->sched_data' is set to parent group's sched_data, thus it's NULL
>>> for root group. And for_each_entity() is used widely to access
>>> 'entity->sched_data', thus aplly news apis if root group is not
>>                               ^^ apply
>>
Hi,

Thanks for spotting this.
>>> expected. Prepare to count root group into 'num_groups_with_pending_reqs'.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/bfq-iosched.c |  2 +-
>>>   block/bfq-iosched.h | 22 ++++++++--------------
>>>   block/bfq-wf2q.c    | 10 +++++-----
>>>   3 files changed, 14 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 69ddf6b0f01d..3bc7a7686aad 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -4393,7 +4393,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
>>>   	 * service with the same budget.
>>>   	 */
>>>   	entity = entity->parent;
>>> -	for_each_entity(entity)
>>> +	for_each_entity_not_root(entity)
>>>   		entity->service = 0;
>>>   }
>>
>> So why is it a problem to clear the service for root cgroup here?

This is not a problem in theory, however 'entity->service' should always
be 0 for root_group. Thus I think there is no need to do this.

>>
>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>> index f8eb340381cf..c4cb935a615a 100644
>>> --- a/block/bfq-wf2q.c
>>> +++ b/block/bfq-wf2q.c
>>> @@ -815,7 +815,7 @@ void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
>>>   		bfqq->service_from_wr += served;
>>>   
>>>   	bfqq->service_from_backlogged += served;
>>> -	for_each_entity(entity) {
>>> +	for_each_entity_not_root(entity) {
>>>   		st = bfq_entity_service_tree(entity);
>>
>> Hum, right so how come this was not crashing? Because entity->sched_data is
>> indeed NULL for bfqd->root_group->entity and so bfq_entity_service_tree()
>> returned some bogus pointer? Similarly for the cases you are changing
>> below?
> 
> Oh, I see now. Because for_each_entity() currently does not iterate through
> root cgroup because it has root_group->my_entity set to NULL and thus as a
> result immediate children of root_group will have their parent set to NULL
> as well.

Yes, currently for_each_entity() and for_each_entity_not_root() are the
same, they will stop before root_group.

With patch 5, for_each_entity_not_root() will stay the same, while
for_each_entity() will access root_group's entity in addition. And
because bfq_entity_service_tree() will access 'entity->sched_data', thus
I change to the new api here to avoid null-ptr-deref after patch 5.

Same reasons for below changes.

Thanks,
Kuai
