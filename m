Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACF4FF5EA
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiDMLnK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiDMLnF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 07:43:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE35C35C;
        Wed, 13 Apr 2022 04:40:36 -0700 (PDT)
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kdgb90vMXzgYmQ;
        Wed, 13 Apr 2022 19:38:45 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:40:34 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:40:33 +0800
Subject: Re: [PATCH -next 10/11] block, bfq: decrease
 'num_groups_with_pending_reqs' earlier
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-11-yukuai3@huawei.com>
 <20220413112816.fwobg4cp6ttpnpk6@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f3ed507a-7c85-cd69-3ad5-3e9c0e75c372@huawei.com>
Date:   Wed, 13 Apr 2022 19:40:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220413112816.fwobg4cp6ttpnpk6@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

ÔÚ 2022/04/13 19:28, Jan Kara Ð´µÀ:
> On Sat 05-03-22 17:12:04, Yu Kuai wrote:
>> Currently 'num_groups_with_pending_reqs' won't be decreased when
>> the group doesn't have any pending requests, while some child group
>> still have pending requests. The decrement is delayed to when all the
>> child groups doesn't have any pending requests.
>>
>> For example:
>> 1) t1 issue sync io on root group, t2 and t3 issue sync io on the same
>> child group. num_groups_with_pending_reqs is 2 now.
>> 2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 and
>> t3 still can't be handled concurrently.
>>
>> Fix the problem by decreasing 'num_groups_with_pending_reqs'
>> immediately upon the weights_tree removal of last bfqq of the group.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> So I'd find the logic easier to follow if you completely removed
> entity->in_groups_with_pending_reqs and did updates of
> bfqd->num_groups_with_pending_reqs like:
> 
> 	if (!bfqg->num_entities_with_pending_reqs++)
> 		bfqd->num_groups_with_pending_reqs++;
> 
Hi,

Indeed, this is an excellent idle, and much better than the way I did.

Thanks,
Kuai

> and similarly on the remove side. And there would we literally two places
> (addition & removal from weight tree) that would need to touch these
> counters. Pretty obvious and all can be done in patch 9.
> 
> 								Honza
> 

