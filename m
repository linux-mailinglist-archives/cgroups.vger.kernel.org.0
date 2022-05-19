Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E252D23A
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbiESMOi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiESMOe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 08:14:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59DBA98C;
        Thu, 19 May 2022 05:14:32 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3pg52mbhzhYy9;
        Thu, 19 May 2022 20:13:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 20:14:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 20:14:29 +0800
Subject: Re: [PATCH -next v3 2/2] blk-throttle: fix io hung due to
 configuration updates
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <geert@linux-m68k.org>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-3-yukuai3@huawei.com>
 <20220519095857.GE16096@blackbody.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a8953189-af42-0225-3031-daf61347524a@huawei.com>
Date:   Thu, 19 May 2022 20:14:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220519095857.GE16096@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/05/19 17:58, Michal Koutný 写道:
> Hello Kuayi.
> 
> On Thu, May 19, 2022 at 04:58:11PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>> If new configuration is submitted while a bio is throttled, then new
>> waiting time is recaculated regardless that the bio might aready wait
>> for some time:
>>
>> tg_conf_updated
>>   throtl_start_new_slice
>>    tg_update_disptime
>>    throtl_schedule_next_dispatch
>>
>> Then io hung can be triggered by always submmiting new configuration
>> before the throttled bio is dispatched.
> 
> O.K.
> 
>> -	/*
>> -	 * We're already holding queue_lock and know @tg is valid.  Let's
>> -	 * apply the new config directly.
>> -	 *
>> -	 * Restart the slices for both READ and WRITES. It might happen
>> -	 * that a group's limit are dropped suddenly and we don't want to
>> -	 * account recently dispatched IO with new low rate.
>> -	 */
>> -	throtl_start_new_slice(tg, READ);
>> -	throtl_start_new_slice(tg, WRITE);
>> +	throtl_update_slice(tg, old_limits);
> 
> throtl_start_new_slice zeroes *_disp fields.
Hi,

The problem is not just zeroes *_disp fields, in fact, the real problem
is that 'slice_start' is reset to jiffies.

> If for instance, new config allowed only 0.5 throughput, the *_disp
> fields would be scaled to 0.5.
> How that change helps (better) the previously throttled bio to be dispatched?
> 
tg_with_in_bps_limit() is caculating 'wait' based on 'slice_start'and
'bytes_disp':

tg_with_in_bps_limit:
  jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
  tmp = bps_limit * jiffy_elapsed_rnd;
  do_div(tmp, HZ);
  bytes_allowed = tmp; -> how many bytes are allowed in this slice,
		         incluing dispatched.
  if (tg->bytes_disp[rw] + bio_size <= bytes_allowed)
   *wait = 0 -> no need to wait if this bio is within limit

  extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
  -> extra_bytes is based on 'bytes_disp'

For example:

1) bps_limit is 2k, we issue two io, (1k and 9k)
2) the first io(1k) will be dispatched, bytes_disp = 1k, slice_start = 0
    the second io(9k) is waiting for (9 - (2 - 1)) / 2 = 4 s
3) after 3 s, we update bps_limit to 1k, then new waiting is caculated:

without this patch:  bytes_disp = 0, slict_start =3:
bytes_allowed = 1k
extra_bytes = 9k - 1k = 8k
wait = 8s

whth this patch: bytes_disp = 0.5k, slice_start =  0,
bytes_allowed = 1k * 3 + 1k = 4k
extra_bytes =  0.5k + 9k - 4k = 5.5k
wait = 5.5s

I hope I can expliain it clearly...

Thanks,
Kuai
> (Is it because you omit update of slice_{start,end}?)
> 
> Thanks,
> Michal
> 
> .
> 
