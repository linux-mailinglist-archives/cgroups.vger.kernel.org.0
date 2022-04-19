Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E217506B29
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiDSLo3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351841AbiDSLmM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 07:42:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0931D37BE7;
        Tue, 19 Apr 2022 04:37:20 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjMCl1XB7zFqT6;
        Tue, 19 Apr 2022 19:34:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:37:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:37:12 +0800
Subject: Re: [PATCH -next 10/11] block, bfq: decrease
 'num_groups_with_pending_reqs' earlier
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-11-yukuai3@huawei.com>
 <20220413112816.fwobg4cp6ttpnpk6@quack3.lan>
 <f3ed507a-7c85-cd69-3ad5-3e9c0e75c372@huawei.com>
 <ef7bad8c-b8dd-f625-330c-9a22e303844b@huawei.com>
 <20220419094955.ucjxadnhdyonfjdo@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <d088c184-b67f-1afb-5f1c-0e166c665c50@huawei.com>
Date:   Tue, 19 Apr 2022 19:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220419094955.ucjxadnhdyonfjdo@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/04/19 17:49, Jan Kara 写道:
> On Fri 15-04-22 09:10:06, yukuai (C) wrote:
>> 在 2022/04/13 19:40, yukuai (C) 写道:
>>> 在 2022/04/13 19:28, Jan Kara 写道:
>>>> On Sat 05-03-22 17:12:04, Yu Kuai wrote:
>>>>> Currently 'num_groups_with_pending_reqs' won't be decreased when
>>>>> the group doesn't have any pending requests, while some child group
>>>>> still have pending requests. The decrement is delayed to when all the
>>>>> child groups doesn't have any pending requests.
>>>>>
>>>>> For example:
>>>>> 1) t1 issue sync io on root group, t2 and t3 issue sync io on the same
>>>>> child group. num_groups_with_pending_reqs is 2 now.
>>>>> 2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 and
>>>>> t3 still can't be handled concurrently.
>>>>>
>>>>> Fix the problem by decreasing 'num_groups_with_pending_reqs'
>>>>> immediately upon the weights_tree removal of last bfqq of the group.
>>>>>
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> So I'd find the logic easier to follow if you completely removed
>>>> entity->in_groups_with_pending_reqs and did updates of
>>>> bfqd->num_groups_with_pending_reqs like:
>>>>
>>>>      if (!bfqg->num_entities_with_pending_reqs++)
>>>>          bfqd->num_groups_with_pending_reqs++;
>>>>
>>> Hi,
>>>
>>> Indeed, this is an excellent idle, and much better than the way I did.
>>>
>>> Thanks,
>>> Kuai
>>>
>>>> and similarly on the remove side. And there would we literally two places
>>>> (addition & removal from weight tree) that would need to touch these
>>>> counters. Pretty obvious and all can be done in patch 9.
>>
>> I think with this change, we can count root_group while activating bfqqs
>> that are under root_group, thus there is no need to modify
>> for_each_entity(or fake bfq_sched_data) any more.
> 
> Sure, if you can make this work, it would be easier :)
> 
>> The special case is that weight racing bfqqs are not inserted into
>> weights tree, and I think this can be handled by adding a fake
>> bfq_weight_counter for such bfqqs.
> 
> Do you mean "weight raised bfqqs"? Yes, you are right they would need
> special treatment - maybe bfq_weights_tree_add() is not the best function
> to use for this and we should rather use insertion / removal from the
> service tree for maintaining num_entities_with_pending_reqs counter?
> I can even see we already have bfqg->active_entities so maybe we could just
> somehow tweak that accounting and use it for our purposes?

The problem to use 'active_entities' is that bfqq can be deactivated
while it still has pending requests.

Anyway, I posted a new version aready, which still use weights_tree
insertion / removal to count pending bfqqs. I'll be great if you can
take a look:

https://patchwork.kernel.org/project/linux-block/cover/20220416093753.3054696-1-yukuai3@huawei.com/

BTW, I was worried that you can't receive the emails because I got
warnings that mails can't deliver to you:

Your message could not be delivered for more than 6 hour(s).
It will be retried until it is 1 day(s) old.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                    The mail system

<jack@imap.suse.de> (expanded from <jack@suse.cz>): host
     mail2.suse.de[149.44.160.157] said: 452 4.3.1 Insufficient system 
storage

Thanks,
Kuai
> 
> 								Honza
> 
