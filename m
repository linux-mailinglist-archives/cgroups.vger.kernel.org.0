Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B67539BC6
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 05:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349482AbiFADni (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 23:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349470AbiFADnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 23:43:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343687A06
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 20:43:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g12so626422lja.3
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W7vfILUssSyP23AGrtSDYqv4u1/JSYP5phSCaaUA1Rs=;
        b=GR0zsF7gUEDBICmr/LC7lhrvebr0YnWX6PTUvNpYSoT3sIGjlLS06lJED8iGQPjfk6
         wHKJxC1UB408Dnn3xjBbGSr53xSGJeWhcj10QNJk4jTPo199lPUHrTp/C7NBpc7T6G95
         gj1kWh+2GLZQsEUxaLGjslLIvMTihIZIe0jD6Dq9FcNE3Sl8NP6sjoAPI6H4B1WnFeM4
         8tfw+YBrf9LeN/v5lnsmXmEloXWYs/1XjlfsA0NlrTL01XFUjd/eFC7zjfymWufbVh2N
         FSTzJGM7zrVSwuPfsdMoPHnN5VC6j1AVHEMhir+PU//Rqu6/c/JvOJXgLKWELRTTLPD/
         bqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W7vfILUssSyP23AGrtSDYqv4u1/JSYP5phSCaaUA1Rs=;
        b=bPNmzrBrGYRlLqPdQE23BQhVvMLHD8y1zvKErhAjNJ4K6GcZisqNDALQgvuDrPnYpN
         Pzif2DeRYQp/32PQHI1yysG9DAovYj3k4SGmwpE5/pUR70RGr7rZXWXga4MvxuF1YEOT
         UOSPIH2BhmnCKJmWcbqoZnRyxj4V3IniqspXV7XznhozWmP3AVm5nijERmE+T4vzpq04
         9HfooztMOaDVr5VE2bYFA69ihYTDkff4yHg5mf7uz5w9XbgmwSnHgGKahYmcTbGhouxX
         r38FmeQnPrnw05xVIqC1OHyaYbWBQ8R3CZkIw9E5PJC7LDtqdLGIvZaaAn1rWPwZKysc
         CCjw==
X-Gm-Message-State: AOAM533PYW4bN1k+QcdOHjp5t6I+L1BPnoPLuRoFYMXTn8vuBYKjr19F
        wl/o6ddd8fkQiS3ZYG3mDfZJCw==
X-Google-Smtp-Source: ABdhPJx9S1ehYyeCDRB/2B49+gyRSA5K4T8U2AvCt5zHsr+v0/qDs0nsQ3qPnHcZs1MFevul4bMTKg==
X-Received: by 2002:a05:651c:98d:b0:250:976b:4a0e with SMTP id b13-20020a05651c098d00b00250976b4a0emr37208150ljq.494.1654055008960;
        Tue, 31 May 2022 20:43:28 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id y27-20020a0565123f1b00b0047255d211c4sm91175lfa.243.2022.05.31.20.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 20:43:28 -0700 (PDT)
Message-ID: <118bcb39-1281-0d1d-b163-3f6bcc99c3e2@openvz.org>
Date:   Wed, 1 Jun 2022 06:43:27 +0300
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
 <3a1d8554-755f-7976-1e00-a0e7fb62c86e@openvz.org>
 <YpXA35F33hvrxNLf@dhcp22.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YpXA35F33hvrxNLf@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/31/22 10:16, Michal Hocko wrote:
> On Mon 30-05-22 22:58:30, Vasily Averin wrote:
>> On 5/30/22 17:22, Michal Hocko wrote:
>>> On Mon 30-05-22 16:09:00, Vasily Averin wrote:
>>>> On 5/30/22 14:55, Michal Hocko wrote:
>>>>> On Mon 30-05-22 14:25:45, Vasily Averin wrote:
>>>>>> Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
>>>>>> 4cpu VM with Fedora and self-complied upstream kernel. The calculations
>>>>>> are not precise, it depends on kernel config options, number of cpus,
>>>>>> enabled controllers, ignores possible page allocations etc.
>>>>>> However this is enough to clarify the general situation.
>>>>>> All allocations are splited into:
>>>>>> - common part, always called for each cgroup type
>>>>>> - per-cgroup allocations
>>>>>>
>>>>>> In each group we consider 2 corner cases:
>>>>>> - usual allocations, important for 1-2 CPU nodes/Vms
>>>>>> - percpu allocations, important for 'big irons'
>>>>>>
>>>>>> common part: 	~11Kb	+  318 bytes percpu
>>>>>> memcg: 		~17Kb	+ 4692 bytes percpu
>>>>>> cpu:		~2.5Kb	+ 1036 bytes percpu
>>>>>> cpuset:		~3Kb	+   12 bytes percpu
>>>>>> blkcg:		~3Kb	+   12 bytes percpu
>>>>>> pid:		~1.5Kb	+   12 bytes percpu		
>>>>>> perf:		 ~320b	+   60 bytes percpu
>>>>>> -------------------------------------------
>>>>>> total:		~38Kb	+ 6142 bytes percpu
>>>>>> currently accounted:	  4668 bytes percpu
>>>>>>
>>>>>> - it's important to account usual allocations called
>>>>>> in common part, because almost all of cgroup-specific allocations
>>>>>> are small. One exception here is memory cgroup, it allocates a few
>>>>>> huge objects that should be accounted.
>>>>>> - Percpu allocation called in common part, in memcg and cpu cgroups
>>>>>> should be accounted, rest ones are small an can be ignored.
>>>>>> - KERNFS objects are allocated both in common part and in most of
>>>>>> cgroups 
>>>>>>
>>>>>> Details can be found here:
>>>>>> https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/
>>>>>>
>>>>>> I checked other cgroups types was found that they all can be ignored.
>>>>>> Additionally I found allocation of struct rt_rq called in cpu cgroup 
>>>>>> if CONFIG_RT_GROUP_SCHED was enabled, it allocates huge (~1700 bytes)
>>>>>> percpu structure and should be accounted too.
>>>>>
>>>>> One thing that the changelog is missing is an explanation why do we need
>>>>> to account those objects. Users are usually not empowered to create
>>>>> cgroups arbitrarily. Or at least they shouldn't because we can expect
>>>>> more problems to happen.
>>>>>
>>>>> Could you clarify this please?
>>>>
>>>> The problem is actual for OS-level containers: LXC or OpenVz.
>>>> They are widely used for hosting and allow to run containers
>>>> by untrusted end-users. Root inside such containers is able
>>>> to create groups inside own container and consume host memory
>>>> without its proper accounting.
>>>
>>> Is the unaccounted memory really the biggest problem here?
>>> IIRC having really huge cgroup trees can hurt quite some controllers.
>>> E.g. how does the cpu controller deal with too many or too deep
>>> hierarchies?
>>
>> Could you please describe it in more details?
>> Maybe it was passed me by, maybe I messed or forgot something,
>> however I cannot remember any other practical cgroup-related issues.
>>
>> Maybe deep hierarchies does not work well.
>> however, I have not heard that the internal configuration of cgroup
>> can affect the upper level too.
> 
> My first thought was any controller with a fixed math constrains like
> cpu controller. But I have to admit that I haven't really checked
> whether imprecision can accumulate and propagate outside of the
> hierarchy.
> 
> Another concern I would have is a id space depletion. At least memory
> controller depends on idr ids which have a space that is rather limited
> #define MEM_CGROUP_ID_MAX       USHRT_MAX
> 
> Also the runtime overhead would increase with a large number of cgroups.
> Take a global memory reclaim as an example. All the cgroups have to be
> iterated. This will have an impact outside of the said hierarchy. One
> could argue that limiting untrusted top level cgroups would be a certain
> mitigation but I can imagine this could get very non trivial easily.
> 
> Anyway, let me just be explicit. I am not against these patches. In fact
> I cannot really judge their overhead. But right now I am not really sure
> they are going to help much against untrusted users.

Thank you very much, this information is very valuable for us.

I'm understand your scepticism, the problem looks critical
for upstream-based LXC, and I don't understand well how to
properly protected it right now.

However, it isn't critical for OpenVz. Our kernel does not allow
to change of cgroup.subgroups_limit from inside containers.

CT-901 /# cat /sys/fs/cgroup/memory/cgroup.subgroups_limit 
512
CT-901 /# echo 3333 > /sys/fs/cgroup/memory/cgroup.subgroups_limit 
-bash: echo: write error: Operation not permitted
CT-901 /# echo 333 > /sys/fs/cgroup/memory/cgroup.subgroups_limit 
-bash: echo: write error: Operation not permitted

I doubt this way can be accepted in upstream, however for OpenVz
something like this it is mandatory because it much better
than nothing.

The number can be adjusted by host admin. The current default limit
looks too small for me, however it is not difficult to increase it
to a reasonable 10,000.

My experiments show that ~10000 cgroups consumes 0.5 Gb memory on 4cpu VM.
On "big irons" it can easily grow up to several Gb. This is quite a lot
to ignore its accounting.

I agree, highly qualified people like you can find many other ways
of abuse anyway. However, OpenVz is trying to somehow prevent this,
not in upstream, unfortunately, but at least in our own kernel.

Thank you,
	Vasily Averin
