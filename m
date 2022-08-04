Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABDD589D14
	for <lists+cgroups@lfdr.de>; Thu,  4 Aug 2022 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiHDNvt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Aug 2022 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiHDNvk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Aug 2022 09:51:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D9B33359
        for <cgroups@vger.kernel.org>; Thu,  4 Aug 2022 06:51:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso5405131pjq.0
        for <cgroups@vger.kernel.org>; Thu, 04 Aug 2022 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zD3BFnts15iHCWRPhU8Gog+NmQ8cf5xvVsVfiuX4De0=;
        b=b4Os43C6zAFVcQDrf81Rv4I14peZHBpxPHbuzw/tn6Xt6vcEPzx/MDxvcsgBz/k3pF
         Ud8rYDGlvKEV5xE1EAgv/vECXgT+weHHFj4avDCpDfGGk+sO8n5NbivCvkI7W1sfveYO
         oS/F/KV7FWRRJ0hciFdksYAl/U8a1lBHE1NJuq1BN9ivJlmF0p6bCNALwXr44pQHbmgy
         o3y3sA2IpTktoadQBylIQavSHbDuu3ZbBrK304Dfjq70B4f4D5QlUj893p/iYWz9Pf0A
         pxq/q2tQVM+E91JOPQOoy7WwRQDTOJPMfnNjnqQuNyYuLzrvq0UBBf0x6V/TWeCVsRj6
         S2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zD3BFnts15iHCWRPhU8Gog+NmQ8cf5xvVsVfiuX4De0=;
        b=HrAb8QFKVCq45UbrL3kwWyiwPXiDT4spP6K/+vIUXuYPG0pPX8mnzCdZP/Us/CVrmX
         zuCOiyN/vnHYc5FwCMucdGPFH1l2hhCjz0Yof/2iihAprR0SRRcT/gORI+lFeb4ljgcy
         NcFQUEiOjv5zOVA3Lz25zKSv0dn3zcVOi05mOPTrvOnltj0oSbSWJ1Un4CHtag2A0/DW
         gUPrJndKKCS4U2KUHphK7TcyQix2ok5izIs4H8UBU2hAzI1P18KKpwQbE2IZtdlxaTZb
         DKDHVrwuIaNcTd6UGDb/o4D+Co0gSMqRAVNZGFH1EMgl1PWx9ZFTFj8SzPJMaDlTb+EL
         xyNA==
X-Gm-Message-State: ACgBeo1CuQZdHCYxbrnwQUu11FpfAMK0akNLq13LLLOKFxsjyvEN1fOn
        rhSMmAbAsNq93poryrLSoHbAqA==
X-Google-Smtp-Source: AA6agR6K+4+6LuC7G5BQ1B5QYUcEO3ystRbiiSbPk85O+0hba2twThU42ORCydz3NXR9yWNuateAmw==
X-Received: by 2002:a17:90b:1e0f:b0:1f5:37f5:159c with SMTP id pg15-20020a17090b1e0f00b001f537f5159cmr2230830pjb.189.1659621098633;
        Thu, 04 Aug 2022 06:51:38 -0700 (PDT)
Received: from [10.4.84.52] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id r7-20020a634407000000b0041c9a4001ebsm1154689pga.21.2022.08.04.06.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:51:38 -0700 (PDT)
Message-ID: <f8444db4-3235-d108-698a-6772e03a6b67@bytedance.com>
Date:   Thu, 4 Aug 2022 21:51:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        corbet@lwn.net, akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org> <YuAqWprKd6NsWs7C@slm.duckdns.org>
 <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
 <Yuq3Q6Y9dRnjjcPt@slm.duckdns.org> <YurK6MXdJPrV2VYS@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YurK6MXdJPrV2VYS@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/4 03:22, Johannes Weiner wrote:
> On Wed, Aug 03, 2022 at 07:58:27AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Wed, Aug 03, 2022 at 08:17:22PM +0800, Chengming Zhou wrote:
>>>> Assuming the above isn't wrong, if we can figure out how we can re-enable
>>>> it, which is more difficult as the counters need to be resynchronized with
>>>> the current state, that'd be ideal. Then, we can just allow each cgroup to
>>>> enable / disable PSI reporting dynamically as they see fit.
>>>
>>> This method is more fine-grained but more difficult like you said above.
>>> I think it may meet most needs to disable PSI stats in intermediate cgroups?
>>
>> So, I'm not necessarily against implementing something easier but we at
>> least wanna get the interface right, so that if we decide to do the full
>> thing later we can easily expand on the existing interface. ie. let's please
>> not be too hacky. I don't think it'd be that difficult to implement
>> per-cgroup disable-only operation that we can later expand to allow
>> re-enabling, right?
> 
> It should be relatively straight-forward to disable and re-enable
> state aggregation, time tracking, averaging on a per-cgroup level, if
> we can live with losing history from while it was disabled. I.e. the
> avgs will restart from 0, total= will have gaps - should be okay, IMO.
> 
> Where it gets trickier is also stopping the tracking of task counts in
> a cgroup. For re-enabling afterwards, we'd have to freeze scheduler
> and cgroup state and find all tasks of interest across all CPUs for
> the given cgroup to recreate the counts. I'm not quite sure whether
> that's feasible, and if so, whether it's worth the savings.
> 
> It might be good to benchmark the two disabling steps independently.
> Maybe stopping aggregation while keeping task counts is good enough,
> and we can commit to a disable/re-enable interface from the start.
> 
> Or maybe it's all in the cachelines and iteration, and stopping the
> aggregation while still writing task counts isn't saving much. In that
> case we'd have to look closer at reconstructing task counts, to see if
> later re-enabling is actually a practical option or whether a one-off
> kill switch is more realistic.
> 
> Chengming, can you experiment with disabling: record_times(), the
> test_state() loop and state_mask construction, and the averaging
> worker - while keeping the groupc->tasks updates?

Hello,

I did this experiment today with disabling record_times(), test_state()
loop and averaging worker, while only keeping groupc->tasks[] updates,
the results look promising.

mmtests/config-scheduler-perfpipe on Intel Xeon Platinum with 3 levels of cgroup:

perfpipe
                                  tip                    tip                patched
                              psi=off                 psi=on      only groupc->tasks[]
Min       Time        7.99 (   0.00%)        8.86 ( -10.95%)        8.31 (  -4.08%)
1st-qrtle Time        8.11 (   0.00%)        8.94 ( -10.22%)        8.39 (  -3.46%)
2nd-qrtle Time        8.17 (   0.00%)        9.02 ( -10.42%)        8.44 (  -3.37%)
3rd-qrtle Time        8.20 (   0.00%)        9.08 ( -10.72%)        8.48 (  -3.43%)
Max-1     Time        7.99 (   0.00%)        8.86 ( -10.95%)        8.31 (  -4.08%)
Max-5     Time        7.99 (   0.00%)        8.86 ( -10.95%)        8.31 (  -4.08%)
Max-10    Time        8.09 (   0.00%)        8.89 (  -9.96%)        8.35 (  -3.22%)
Max-90    Time        8.31 (   0.00%)        9.13 (  -9.90%)        8.55 (  -2.95%)
Max-95    Time        8.32 (   0.00%)        9.14 (  -9.88%)        8.55 (  -2.81%)
Max-99    Time        8.39 (   0.00%)        9.26 ( -10.30%)        8.57 (  -2.09%)
Max       Time        8.56 (   0.00%)        9.26 (  -8.23%)        8.72 (  -1.90%)
Amean     Time        8.19 (   0.00%)        9.03 * -10.26%*        8.45 *  -3.27%*


Tejun suggested using a bitmap in task to remember whether the task is accounted
at a given level or not, which I think also is a very good idea, but I haven't
clearly figure out how to do it.

The above performance test result looks good to me, so I think we can implement this
per-cgroup "cgroup.psi" interface to disable/re-enable PSI stats from the start,
and we can change to a better implementation if needed later?

Thanks!

