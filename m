Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7F5297B8
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 05:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiEQDMl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 23:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiEQDMi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 23:12:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1E1EC58;
        Mon, 16 May 2022 20:12:32 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2Ljp3wbHz1JC5q;
        Tue, 17 May 2022 11:11:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:12:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:12:29 +0800
Subject: Re: [PATCH -next] block: fix io hung of setting throttle limit
 frequently
To:     Tejun Heo <tj@kernel.org>,
        Zhang Wensheng <zhangwensheng5@huawei.com>,
        "ming.lei@redhat.com >> Ming Lei" <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
References: <20220516014429.33723-1-zhangwensheng5@huawei.com>
 <YoKmCOAzwzw3Lz7g@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <ca251645-8d52-7a93-6ac2-579d97922a9e@huawei.com>
Date:   Tue, 17 May 2022 11:12:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YoKmCOAzwzw3Lz7g@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/05/17 3:29, Tejun Heo Ð´µÀ:
> On Mon, May 16, 2022 at 09:44:29AM +0800, Zhang Wensheng wrote:
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 469c483719be..8acb205dfa85 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -1321,12 +1321,14 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
>>   	 * that a group's limit are dropped suddenly and we don't want to
>>   	 * account recently dispatched IO with new low rate.
>>   	 */
>> -	throtl_start_new_slice(tg, READ);
>> -	throtl_start_new_slice(tg, WRITE);
>> +	if (!timer_pending(&sq->parent_sq->pending_timer)) {
>> +		throtl_start_new_slice(tg, READ);
>> +		throtl_start_new_slice(tg, WRITE);
>>   
>> -	if (tg->flags & THROTL_TG_PENDING) {
>> -		tg_update_disptime(tg);
>> -		throtl_schedule_next_dispatch(sq->parent_sq, true);
>> +		if (tg->flags & THROTL_TG_PENDING) {
>> +			tg_update_disptime(tg);
>> +			throtl_schedule_next_dispatch(sq->parent_sq, true);
>> +		}
> 
> Yeah, but this ends up breaking the reason why it's starting the new slices
> in the first place explained in the commit above, right? I'm not sure what
> the right solution is but this likely isn't it.
> 
Hi, Tejun

Ming added a condition in tg_with_in_bps_limit():
-       if (bps_limit == U64_MAX) {
+       /* no need to throttle if this bio's bytes have been accounted */
+       if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {

Which will let the first throttled bio to be issued immediately once
the config if updated.

Do you think this behaviour is OK? If so, we can do the same for
tg_with_in_iops_limit.

Thanks,
Kuai

> 
