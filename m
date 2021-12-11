Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3247109F
	for <lists+cgroups@lfdr.de>; Sat, 11 Dec 2021 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLKCOa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 21:14:30 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29181 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLKCOa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 21:14:30 -0500
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J9rmC4Vr3z8vlC;
        Sat, 11 Dec 2021 10:08:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 10:10:52 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 10:10:51 +0800
Subject: Re: [PATCH RFC 9/9] block, bfq: decrease
 'num_groups_with_pending_reqs' earlier
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <20211127101132.486806-10-yukuai3@huawei.com>
 <AA66019E-FD14-4821-B53D-0C56EEC38828@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <4765e7f8-48b7-3bc6-5eb6-1dc0a569233d@huawei.com>
Date:   Sat, 11 Dec 2021 10:10:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AA66019E-FD14-4821-B53D-0C56EEC38828@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2021/12/10 18:21, Paolo Valente Ð´µÀ:
> 
>> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai<yukuai3@huawei.com>  ha scritto:
>>
>> Currently 'num_groups_with_pending_reqs' won't be decreased when
>> the group doesn't have any pending requests, while any child group
>> have any pending requests. The decrement is delayed to when all the
>> child groups doesn't have any pending requests.
>>
>> For example:
>> 1) t1 issue sync io on root group, t2 and t3 issue sync io on the same
>> child group. num_groups_with_pending_reqs is 2 now.
>> 2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 and
>> t3 still can't be handled concurrently.
>>
>> Fix the problem by decreasing 'num_groups_with_pending_reqs'
>> immediately upon the deactivation of last entity of the group.
>>
> I don't understand this patch clearly.
> 
> I understand your proposal not to count a group as with pending requests, in case no child process of the group has IO, but only its child groups have pending requests.
> 
> So, entities here are only queues for this patch?
> 
> If they are only queues, I think it is still incorrect to remove the group from the count of groups with pending IO when all its child queues are deactivated, because there may still be unfinished IO for those queues.

Hi, Paolo

bfq_weights_tree_remove() will be called when all requests are completed
in bfq_queue, thus I recored how many queues have pending requests
through weights tree insertion and removal.(Details in patch 7)

Thus when calling bfq_weights_tree_remove() for bfqq, I can check if
there are no queues have pending requests for parent bfqg:

if (!bfqg->num_entities_with_pending_reqs && -> no queues with pending reqs
     entity->in_groups_with_pending_reqs) {   -> the group is counted

Thanks,
Kuai
> 
> Am I missing something?
> 
> Thanks,
> Paolo
> 
