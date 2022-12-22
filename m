Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C03654466
	for <lists+cgroups@lfdr.de>; Thu, 22 Dec 2022 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiLVPim (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Dec 2022 10:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVPim (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Dec 2022 10:38:42 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF8429369
        for <cgroups@vger.kernel.org>; Thu, 22 Dec 2022 07:38:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 17so2405130pll.0
        for <cgroups@vger.kernel.org>; Thu, 22 Dec 2022 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pOD6qK21JMmHtZu4DKvodAq25Aw2OJGG1BCa4STcTM=;
        b=S8hUijCrZmz9w4BtoqIFcausqra1NaLhcNe6XM0w/SlphSKuE4EJO5T/eUeE49HZv1
         SeEj0wpgcKkvbM0XZrs348Utuun9If7AP0hrXdRM2HoyUoz+Htu5KoNvHGDbBbGqIq6G
         98dlnuF+RVoRzmx7lY70fKWKyZMKcpxQvw1N68m+H0ipwVJS3G9brjZroZqpck0oCT5P
         EnDIIs+rEBFZ/P15LXtHOzB9scSEXEnvBwIhhAnaqlwGR9oBAXKOY0qTBtYuGSXL0Xlz
         5+4+6hIIF1v4EnFCeJxSnT9USAbP0KEDC5TyTqmy+8NqQdTUPhE84lgGv+oCaSugCQxo
         12Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pOD6qK21JMmHtZu4DKvodAq25Aw2OJGG1BCa4STcTM=;
        b=rgEF91P6N0gThzDD/pL1DVBPTYZR74IL9CCkWcdX3PcXbqLTgbfKCQRXS3AdOtaRJL
         yvPdv7pF+wyKUd4E/t5keHR29sdUijPNaq+qeKiRyGXsZl0usLGKQRTucwF9C1fOeEDL
         EiXfOV30Pq00bHTVqBydlOUClHHYLjZnxU3bcmcBVVeU9lOKjmgXGzX0KRW1AlOx5fT2
         C6Gr7pMJYpuTxiFxJxyWYPY44FrRH70Z8VBidvckZiLXd2eyve6U9d8uxw0FuPSgycno
         dnH2rRcRo9YovFsJfzFykAbGF+IG6PuqonW1QLTGKnMJjjA7jn5EpI8U4hAMBpG5vuat
         IrJA==
X-Gm-Message-State: AFqh2koUijJ/pH1u+wGChc/r5Fz5Av28T+Yu/QbHlhUeXlNZVj3kVnAg
        MdGfyWQK1X8mYmlt4x0+23egFcwrbsvzg2US0w4=
X-Google-Smtp-Source: AMrXdXsY3aG2CDjoYFn0g5dZ8Cckt4U22dyIJHZQwhtekv0YmqxlayHLsCIlOjp87IVfr5LoDARskg==
X-Received: by 2002:a17:902:b402:b0:188:d434:9c67 with SMTP id x2-20020a170902b40200b00188d4349c67mr6046512plr.32.1671723520207;
        Thu, 22 Dec 2022 07:38:40 -0800 (PST)
Received: from [10.254.61.32] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172fad607b3sm669185plf.207.2022.12.22.07.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:38:39 -0800 (PST)
Message-ID: <8c25e591-34d6-7c42-b3a8-dcde86643fe7@bytedance.com>
Date:   Thu, 22 Dec 2022 23:38:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v2] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20221218111314.55525-1-hanjinke.666@bytedance.com>
 <20221221104246.37714-1-hanjinke.666@bytedance.com>
 <20221222133912.GA20830@blackbody.suse.cz>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20221222133912.GA20830@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/12/22 下午9:39, Michal Koutný 写道:
> Hello Jinke.
> 
> On Wed, Dec 21, 2022 at 06:42:46PM +0800, Jinke Han <hanjinke.666@bytedance.com> wrote:
>> In our test, fio writes a 100g file in sequential 4k blocksize in
>> a container with low bps limit configured (wbps=10M). More than 1200
>> ios were throttled in blk-throtl queue and the avarage throtle time
>> of each io is 140s. At the same time, the operation of saving a small
>> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
>> the sync ios of fsync will be blocked by a huge amount of buffer write
>> ios ahead. This is also a priority inversion problem within one cgroup.
>> In the database scene, things got really bad with blk-throtle enabled
>> as fsync is called very often.
> 
> I'm trying to make sense of the numbers:
> - at 10 MB/s, it's 0.4 ms per 4k block
> - there are 1.2k throttled bios that gives waiting time of roughly 0.5s
>    ~ 0.4ms * 1200
> - you say that you observe 280 times longer throttling time,
> - that'd mean there should be 340k queued bios
>    - or cummulative dispatch of ~1400 MB of data
> 
Hi
Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s 
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdb              0.00   11.00      0.00      8.01     0.00     0.00 
0.00   0.00    0.00    7.18   0.08     0.00   745.45   3.27   3.60

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s 
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdb              0.00    8.00      0.00      9.14     0.00     0.00 
0.00   0.00    0.00    7.38   0.06     0.00  1170.00   2.62   2.10

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s 
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdb              0.00   16.00      0.00     12.02     0.00    12.00 
0.00  42.86    0.00    7.25   0.12     0.00   769.25   2.06   3.30

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s 
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdb              0.00   11.00      0.00     10.91     0.00     1.00 
0.00   8.33    0.00    6.82   0.07     0.00  1015.64   2.36   2.60

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s 
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdb              0.00   11.00      0.00      9.14     0.00     1.00 
0.00   8.33    0.00    6.27   0.07     0.00   850.91   2.55   2.80

I used bcc to trace the time of bio form submit_bio to blk_mq_submit_bio
and found the avarage time was nearly 140s(use bcc trace fsync duration 
also get the same result).
The iostat above seem the avaerage of each io nearly 1M, so I have rough 
estimate the num of the bio queued is 140s * 10 m / 1m.


> So what are the queued quantities? Are there more than 1200 bios or are
> they bigger than the 4k you mention?
> 
"fio writes a 100g file in sequential 4k blocksize"
Bios may be more than 1M as ext4 will merged continuously logic blocks 
when physical block also continuously.
> Thanks for clarification.
> 
> (I acknowledge the possible problem with a large population of async
> writes delaying scarce sync writes.)
> 
> Michal

If the 0.4ms oberved by iostat, the way to estimate the throtle time of 
the bio by 0.4ms * 1200 may not work as the 0.4 is duration of the 
request from alloc to done.

If the average size of bio is 1m, dispatch one bio should cost 1m/ 10M = 
100ms. The queue is fifo, so the average throtle time 100ms * 1400.

Thanks.
