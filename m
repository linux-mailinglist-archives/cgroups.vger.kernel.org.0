Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768C5387F0
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 21:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiE3T6f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbiE3T6e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 15:58:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC766202
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 12:58:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so2309854lfo.13
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ApxSBjwUCGt3x4hULPMqV5gemfrp+1rLUwdv7gH9FfE=;
        b=BJRwaKGIHurHh1ayULGoMhnnQuepxbgbughY+CV7pJx306lnZ7xkS+kUjIX/lf1YS6
         qIsBi2XP0heGd6n4ZjLXIk5IbO99lbTkIsxmNzjc6iOwDJ6UyNPdYgL7yadcmECBQE/d
         oV+ngN27o/LB47/miz7JEekrKNTPAbGoB7IbeTY6AP4sU3ojpcQzmmwGx2+rnbTfYzJT
         nk9Pr4LAY+uSVcTvhrb9Yw6Nn7zPxQmSy/4Jp4qZHpqpIyw7hQAD8Ph17R2cYAmGsqRO
         KZLTGKTBXn9q3X7xta3JgKgCGu/uWsj7paK27MQ3WiJxjEfZmNXyqcaAx7C5AyvnUwnD
         wf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ApxSBjwUCGt3x4hULPMqV5gemfrp+1rLUwdv7gH9FfE=;
        b=0bj2M4NxWdBlbcgVs/luj/AEwPMs/m9bbFdtRgMN3qCP01lSuh3eW+SsTLgAL5cDul
         wqYkV/t2VBa7KW0OU5osHiGHI5quIwGXgmmE+2ttpGYdO4fljcZpuw2a6sdPG9itw64F
         kbb+81/hrPpxzJeORcc7oqMy8VvsA+10TXwtdqyXvSDUq0ApvZsKnFO9rKzKLOvGfgS3
         KRjuiFsEL9jbOVvNWP9GGyyIeJVW/EJGE7o8m63164mEwD7H6yoK+u3jURZFBo56r00g
         LE6AWZ3bz6qMtlytMSmAgmpGX++cKDIcKZ0MplOtPb+5/ONbB245HeYXTrFypZ4k1cKU
         flyg==
X-Gm-Message-State: AOAM530KdrPhHQGcRVgDjUo47KNd2iLh23itON13FPfmTczJVjGqcWNN
        wO1dHCquCV5MvSyYApeRQSlXhA==
X-Google-Smtp-Source: ABdhPJyfXXXYUNr6ZlQivxBML7NoU0xLbas9bVs01Cmn0n7kH8UAHDpPdZSZOo/Hh+rfAL9IJ57DFg==
X-Received: by 2002:a05:6512:ba5:b0:477:ab03:5fba with SMTP id b37-20020a0565120ba500b00477ab035fbamr40475552lfv.220.1653940711668;
        Mon, 30 May 2022 12:58:31 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id m10-20020a05651202ea00b0047255d2111esm2484877lfq.77.2022.05.30.12.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 12:58:31 -0700 (PDT)
Message-ID: <3a1d8554-755f-7976-1e00-a0e7fb62c86e@openvz.org>
Date:   Mon, 30 May 2022 22:58:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH mm v3 0/9] memcg: accounting for objects allocated by
 mkdir cgroup
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
 <YpSwvii5etfnOYC9@dhcp22.suse.cz>
 <ef9f7516-853d-ffe4-9a7a-5e87556bdbbe@openvz.org>
 <YpTTL3Ys35kgYyAW@dhcp22.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YpTTL3Ys35kgYyAW@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/30/22 17:22, Michal Hocko wrote:
> On Mon 30-05-22 16:09:00, Vasily Averin wrote:
>> On 5/30/22 14:55, Michal Hocko wrote:
>>> On Mon 30-05-22 14:25:45, Vasily Averin wrote:
>>>> Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
>>>> 4cpu VM with Fedora and self-complied upstream kernel. The calculations
>>>> are not precise, it depends on kernel config options, number of cpus,
>>>> enabled controllers, ignores possible page allocations etc.
>>>> However this is enough to clarify the general situation.
>>>> All allocations are splited into:
>>>> - common part, always called for each cgroup type
>>>> - per-cgroup allocations
>>>>
>>>> In each group we consider 2 corner cases:
>>>> - usual allocations, important for 1-2 CPU nodes/Vms
>>>> - percpu allocations, important for 'big irons'
>>>>
>>>> common part: 	~11Kb	+  318 bytes percpu
>>>> memcg: 		~17Kb	+ 4692 bytes percpu
>>>> cpu:		~2.5Kb	+ 1036 bytes percpu
>>>> cpuset:		~3Kb	+   12 bytes percpu
>>>> blkcg:		~3Kb	+   12 bytes percpu
>>>> pid:		~1.5Kb	+   12 bytes percpu		
>>>> perf:		 ~320b	+   60 bytes percpu
>>>> -------------------------------------------
>>>> total:		~38Kb	+ 6142 bytes percpu
>>>> currently accounted:	  4668 bytes percpu
>>>>
>>>> - it's important to account usual allocations called
>>>> in common part, because almost all of cgroup-specific allocations
>>>> are small. One exception here is memory cgroup, it allocates a few
>>>> huge objects that should be accounted.
>>>> - Percpu allocation called in common part, in memcg and cpu cgroups
>>>> should be accounted, rest ones are small an can be ignored.
>>>> - KERNFS objects are allocated both in common part and in most of
>>>> cgroups 
>>>>
>>>> Details can be found here:
>>>> https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/
>>>>
>>>> I checked other cgroups types was found that they all can be ignored.
>>>> Additionally I found allocation of struct rt_rq called in cpu cgroup 
>>>> if CONFIG_RT_GROUP_SCHED was enabled, it allocates huge (~1700 bytes)
>>>> percpu structure and should be accounted too.
>>>
>>> One thing that the changelog is missing is an explanation why do we need
>>> to account those objects. Users are usually not empowered to create
>>> cgroups arbitrarily. Or at least they shouldn't because we can expect
>>> more problems to happen.
>>>
>>> Could you clarify this please?
>>
>> The problem is actual for OS-level containers: LXC or OpenVz.
>> They are widely used for hosting and allow to run containers
>> by untrusted end-users. Root inside such containers is able
>> to create groups inside own container and consume host memory
>> without its proper accounting.
> 
> Is the unaccounted memory really the biggest problem here?
> IIRC having really huge cgroup trees can hurt quite some controllers.
> E.g. how does the cpu controller deal with too many or too deep
> hierarchies?

Could you please describe it in more details?
Maybe it was passed me by, maybe I messed or forgot something,
however I cannot remember any other practical cgroup-related issues.

Maybe deep hierarchies does not work well.
however, I have not heard that the internal configuration of cgroup
can affect the upper level too.

Please let me know if this can happen, this is very interesting for us.

In our case, the hoster configures only the top level of the cgroup
and does not worry about possible misconfiguration inside containers
if it does not affect other containers or the host itself.

Unaccounted memory, contrary, can affects both neighbor containers and host system,
we saw it many times, and therefore we pay special attention to such issues.

Thank you,
	Vasily Averin
