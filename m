Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6215F8687
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 02:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLBkU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 20:40:20 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34896 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbfKLBkU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Nov 2019 20:40:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Thqegz6_1573522817;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0Thqegz6_1573522817)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 09:40:17 +0800
Subject: Re: [PATCH] iocost: treat as root level when parents are activated
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <1573457838-121361-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <20191111162538.GB4163745@devbig004.ftw2.facebook.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <7be6fb71-7e08-e369-cbbe-678129cc62ff@linux.alibaba.com>
Date:   Tue, 12 Nov 2019 09:38:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191111162538.GB4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi Tejun,

On 2019/11/12 上午12:25, Tejun Heo wrote:
> Hello, Jiufei.
> 
> On Mon, Nov 11, 2019 at 03:37:18PM +0800, Jiufei Xue wrote:
>> Internal nodes that issued IOs are treated as root when leaves are
>> activated. However, leaf nodes can still be activated when internal
>> nodes are active, leaving the sum of hweights exceeds HWEIGHT_WHOLE.
>>
>> I think we should also treat the leaf nodes as root while leaf-only
>> constraint broken.
> 
> Hmm... I'm not sure this description makes sense.
> 
Should I change the description to something like this?
"we should treat the leaf nodes as root while the parent are already activated".


>> @@ -1057,8 +1057,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
>>  	atomic64_set(&iocg->active_period, cur_period);
>>  
>>  	/* already activated or breaking leaf-only constraint? */
>> -	for (i = iocg->level; i > 0; i--)
>> -		if (!list_empty(&iocg->active_list))
>> +	for (i = iocg->level - 1; i > 0; i--)
>> +		if (!list_empty(&iocg->ancestors[i]->active_list))
> 
> But there's an obvious bug there as it's checking the same active_list
> over and over again.  Shouldn't it be sth like the following instead?
> 
> 	if (!list_empty(&iocg->active_list))
> 		goto succeed_unlock;

iocg has already checked before, do you mean we should check it again
after ioc->lock?

> 	for (i = iocg->level - 1; i > 0; i--)
> 		if (!list_empty(&iocg->ancestors[i]->active_list))
> 			goto fail_unlock;
> 
> Thanks.
>

Thanks,
Jiufei
