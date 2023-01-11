Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AE665243
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 04:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjAKDTV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 22:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjAKDSm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 22:18:42 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40BF13FAD
        for <cgroups@vger.kernel.org>; Tue, 10 Jan 2023 19:18:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id d10so9612883pgm.13
        for <cgroups@vger.kernel.org>; Tue, 10 Jan 2023 19:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGHT4vYdNOhHiGD97YLPBDr6shSnsxjPas88Q21AiMY=;
        b=jFBW2mIkZHMNoZLfVGNPbAdx519BSUVMAo/NE6OsGHp70A8bQeEAib8cs1pv8IRqJe
         l39fAfpTcLoYmCNR/21reJI/7kUZVE2XGnC9KWa6LFRXeCmyVbchb6SMVvb6mmOl2zVx
         MgKYhNd74n2Q0qgNwoWJUdnXi8pbtxGmWuCfe5fi/bDwY3QxLhf6bVxhNjJkRF4Q30Wd
         wojCogkEvN6Y17CTJ4dFaIqvVJOpUkZRqD84gAnoN7kT0rayzlAhXfzlYWlVE4JL/8gY
         iwbLX8tju52Z1cpQ0xftM+D9qE+TQF/yZQg5mRdekQwpZ6MQVQ9LoTpIlByjhxLBAATj
         b5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGHT4vYdNOhHiGD97YLPBDr6shSnsxjPas88Q21AiMY=;
        b=JqynvtHV0txaOA785gJyHWZG/WOujNCrgC8Nfa757/bAPwl3c0igriFhjIbbotod6t
         Trmg2eR/yHXlTmbHlGi2a615r4Q9XQaCMY74r+aNnlNZLckMewx9m4M7/V19QSjM7rjQ
         kY794Yi7TH4timwu3o/I4/oD8mUMXwHJkmZOh9U+kesE2vRsWA4mo/r2qM7S/tcuviLZ
         zZYP3T7tkZQVo5qhea0LJBYjOOIU+bjn8cqiFfK87GDGvhTgWBIBu7g3jnd22dr1TcIZ
         dnOavXK/vtPcJauixaCKw/cAbedB/c8JAtIAZ3epai0BEHPT+DbbDTJjgljH2FRlfIM7
         jhYg==
X-Gm-Message-State: AFqh2kro2n5UMC8fxAJXylL14dJOWzdBWbx+wv5PoZae6Lq4J1PsM825
        dUDuCz59a2og+1g5WZOenK9AQg==
X-Google-Smtp-Source: AMrXdXuVINS6yFtiYkAMSSYGJg1gD6z09uXLy6JvidaRG+/s5pb+gLQtz5/4pq/EtUuvG4KQDItHAQ==
X-Received: by 2002:aa7:87d0:0:b0:57e:c106:d50c with SMTP id i16-20020aa787d0000000b0057ec106d50cmr502082pfo.17.1673407098427;
        Tue, 10 Jan 2023 19:18:18 -0800 (PST)
Received: from [10.254.85.126] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y127-20020a623285000000b0058abddad316sm2111846pfy.209.2023.01.10.19.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 19:18:17 -0800 (PST)
Message-ID: <f152b853-6f22-bce5-a1b2-3ea29310f628@bytedance.com>
Date:   Wed, 11 Jan 2023 11:18:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v4] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20230107130738.75640-1-hanjinke.666@bytedance.com>
 <Y7x7yq5YmcXhVkQf@slm.duckdns.org>
 <b4cf040e-a9d9-8b7a-10cf-80b01d02848f@bytedance.com>
 <Y73k04BhpY/SuwGB@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y73k04BhpY/SuwGB@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/11 上午6:21, Tejun Heo 写道:
> On Tue, Jan 10, 2023 at 11:59:09PM +0800, hanjinke wrote:
>>
>>
>> 在 2023/1/10 上午4:40, Tejun Heo 写道:
>>> On Sat, Jan 07, 2023 at 09:07:38PM +0800, Jinke Han wrote:
>>>> + * Assumed that there were only bios queued in ASYNC queue and the SYNC
>>>> + * queue was empty. The ASYNC bio was selected to dispatch and the
>>>> + * disp_sync_cnt was set to 0 after each dispatching. If a ASYNC bio
>>>> + * can't be dispatched because of overlimit in current slice, the process
>>>> + * of dispatch should give up and the spin lock of the request queue
>>>> + * may be released. A new SYNC bio may be queued in the SYNC queue then.
>>>> + * When it's time to dispatch this tg, the SYNC bio was selected and pop
>>>> + * to dispatch as the disp_sync_cnt is 0 and the SYNC queue is no-empty.
>>>> + * If the dispatched bio is smaller than the waiting bio, the bandwidth
>>>> + * may be hard to satisfied as the slice may be trimed after each dispatch.
>>>
>>> I still can't make a good sense of this scenario. Can you give concrete
>>> example scenarios with IOs and why it would matter?
>>>
>>> Thanks.
>>>
>>
>> Assumed that there are many buffer write bios queued in ASYNC queue and the
>> SYNC queue is empty. The buffer write bios are all 1M in size and the bps
>> limit is 1M/s. The throtl_slice is 100ms.
>>
>> Assumed that the start/end_slice is [jiffies1, jiffies1+100] and
>> bytes_disp[w] = 0. The next ASYNC bio can't dispatch because of overlimit
>> within this slice. The wait time is 900ms and the slice will be extended to
>> [jiffies1, jiffies1 + 1000] in tg_may_dispatch.
>>
>> During the waiting of the ASYNC bio, a SYNC 4k bio be queued in SYNC queue.
>> After 900ms, it's time to dispatch the ASYNC io, but the SYNC 4k bio be
>> selected to be dispatched. Now the slice is [jiffies1, jiffies1+1000] and
>> the byte_disp[w] = 4k. The slice may be extended to
>> [jiffies1, jiffies1+1100]. In tg_dispatch_one_bio, the slice will be trimed
>> to [jiffies1+1000, jiffies1+1100], the byte_disp[w] will set 0.
>>
>> After the 4k SYNC bio be dispatched, the WAITING ASYNC bio still cann't
>> be dispatched because of overlimit within this slice.
>>
>> The same thing may happen DISPACH_SYNC_FACTOR times if alway there is a SYNC
>> bio be queued in the SYNC queue when the ASYNC bio is waiting.
>>
>> This means that in nearly 5s, we have dispathed 4 4k SYNC bios and a 1m
>> ASYNC bio.
>>
>> In our test, with 100M/s bps limit setted, the bps only reach to ~80m/s
>> when a fio generate buffer write ios and fsync continuous generated by
>> dbench in same cgroup.
> 
> That makes sense to me. Thanks for the explanation. It'd probably a good
> idea to expand the explanation in the comment tho.
> 
> Thanks.
> 

I will be glad to do so and send the v5.

Thanks.
Jinke

