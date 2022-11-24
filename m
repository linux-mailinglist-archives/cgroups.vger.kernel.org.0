Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0363789A
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKXMKI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 07:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXMKI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 07:10:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890A742C5;
        Thu, 24 Nov 2022 04:10:07 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHxXx0Kw5zqSdh;
        Thu, 24 Nov 2022 20:06:09 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 20:10:04 +0800
Subject: Re: [PATCH 04/11] blk-throttle: correct calculation of wait time in
 tg_may_dispatch
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-5-shikemeng@huawei.com>
 <Y35kELlFkI/BtkqC@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <fdf1aa87-b459-172a-f3f0-31afcb696c76@huawei.com>
Date:   Thu, 24 Nov 2022 20:10:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35kELlFkI/BtkqC@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
on 11/24/2022 2:18 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:03:54PM +0800, Kemeng Shi wrote:
>> If bps and iops both reach limit, we always return bps wait time as
>> tg_within_iops_limit is after "tg_within_bps_limit(tg, bio, bps_limit) &&"
>> and will not be called if tg_within_bps_limit return true.
Here is a mistake, the right word should be:
tg_within_iops_limit is after "tg_within_bps_limit(tg, bio, bps_limit) &&"
and will not be called if tg_within_bps_limit return *false*.
> Maybe it's obvious but it'd be better to explain "why" this change is being
> made.
In C language, When executing "if (expression1 && expression2)" and
expression1 return false, the expression2 may not be executed.
For "tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
tg_within_iops_limit(tg, bio, iops_limit, &iops_wait))", if bps is
limited, tg_within_bps_limit will return false and
tg_within_iops_limit will not be called. So even bps and iops are
both limited, iops_wait will not be calculated and is zero here.
So wait time of bps is always returned.
>> @@ -939,8 +926,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>  				jiffies + tg->td->throtl_slice);
>>  	}
>>  
>> -	if (tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
>> -	    tg_within_iops_limit(tg, bio, iops_limit, &iops_wait)) {
>> +	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
>> +	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
>> +	if (bps_wait + iops_wait == 0) {
>>  		if (wait)
>>  			*wait = 0;
>>  		return true;
> 
> So, max_wait is supposed to be maximum in the whole traversal path in the
> tree, not just the max value in this tg, so after this, the code should be
> changed to sth like the following, right?
> 
>         max_wait = max(max, max(bps_wait, iops_wait));
> 
> Thanks.
> 

-- 
Best wishes
Kemeng Shi
