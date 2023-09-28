Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31F7B1108
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 05:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjI1DDc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 23:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1DDc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 23:03:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383CB94
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 20:03:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fa455cd94so8332711a12.2
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 20:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695870209; x=1696475009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVp3VI4K1tI9SqzvKTAU71U5E0qC9V90AnWjuaLY+n0=;
        b=gHnPdTHQ/RX2AVk0MZM+VycTcxVn6i1U1E2DeFOpVdW28ZdrNuqBgO4pahLXhZVt2l
         r1fRmXRXYQnV7ahea8Zijyy6r5OWAzQ1iCQD486s3cJcisdn/QdDMfk+InCmb/juVX5w
         uFZhHgfSGm8xeH6i6lPJdrRadokC+C8/nEVQ/OsOVjf2Lu1Lw5qMMaP/owx6hGYxspbN
         u8S6vXuMAuneYSZBKeXT2oS9n71lG/H37tjihK05minFrNmplD8rbDkejRtNXbSGmgH4
         NRrF14BaeMA3rnpJPP6wXtnzRnoprdG11cWoWeX/JA6JYfGOsPF1l5vyBAwnypixW01w
         V8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695870209; x=1696475009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DVp3VI4K1tI9SqzvKTAU71U5E0qC9V90AnWjuaLY+n0=;
        b=U+UhaUn9WDYQhRDKRMiMKD6CQDz1tAcaLzQm+a24y4V+ITgqWTlOz5+Thyl0xQ188u
         L9URB2CHdKqecJ+4DF28Bt9RFJNpbuAvdLduI8USguBwK+MZNqP90aAT8lCl5K7eN4J7
         b6aEg+Zd5iaxEb5sPnBZ4vjfjBUQuCPC55VpW73KMXY4URhJd9/DBrFhuEDCpIpG1gea
         pkV+zh2YaEiftoxcoQ15mIGe1h3le0AaC5yUJp3HNWWDKQEgXYOZBC0q0HfAOCEuGB+S
         hUr2cG2MKgnL5nZypVdLZh2rSQJy1adHcdKBGUvCxpo+ZZ/7wkoctt4Bdph/V3CBhkGv
         h8TQ==
X-Gm-Message-State: AOJu0Yz5vkI2d7dAoVxC6XmN6TF4N1bFmojHMXdgnVLyyF3z6OnmXu09
        IvvF+wzLeDRmxlTL+DJwMCLqUw==
X-Google-Smtp-Source: AGHT+IGvIh+DVVXT4Vgsra6G3wWuOvOrgvQvGGBf6PALSSJvSJKEcN+WnYghw13AeOn3cwjWdbPnOQ==
X-Received: by 2002:a05:6a21:6da4:b0:14c:e4d9:de46 with SMTP id wl36-20020a056a216da400b0014ce4d9de46mr16585pzb.39.1695870209638;
        Wed, 27 Sep 2023 20:03:29 -0700 (PDT)
Received: from [10.54.24.10] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001c72d5e16acsm775522plj.57.2023.09.27.20.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 20:03:29 -0700 (PDT)
Message-ID: <9b463e7e-4a89-f218-ec5c-7f6c16b685ea@shopee.com>
Date:   Thu, 28 Sep 2023 11:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
 <6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
 <ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
 <94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
 <ZRF/CTk4MGPZY6Tc@dhcp22.suse.cz>
 <fe80b246-3f92-2a83-6e50-3b923edce27c@shopee.com>
 <ZRQv+E1plKLj8Xe3@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZRQv+E1plKLj8Xe3@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/9/27 21:36, Michal Hocko wrote:
> On Tue 26-09-23 22:39:11, Haifeng Xu wrote:
>>
>>
>> On 2023/9/25 20:37, Michal Hocko wrote:
>>> On Mon 25-09-23 20:28:02, Haifeng Xu wrote:
>>>>
>>>>
>>>> On 2023/9/25 19:38, Michal Hocko wrote:
>>>>> On Mon 25-09-23 17:03:05, Haifeng Xu wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/9/25 15:57, Michal Hocko wrote:
>>>>>>> On Fri 22-09-23 07:05:28, Haifeng Xu wrote:
>>>>>>>> When application in userland receives oom notification from kernel
>>>>>>>> and reads the oom_control file, it's confusing that under_oom is 0
>>>>>>>> though the omm killer hasn't finished. The reason is that under_oom
>>>>>>>> is cleared before invoking mem_cgroup_out_of_memory(), so move the
>>>>>>>> action that unmark under_oom after completing oom handling. Therefore,
>>>>>>>> the value of under_oom won't mislead users.
>>>>>>>
>>>>>>> I do not really remember why are we doing it this way but trying to track
>>>>>>> this down shows that we have been doing that since fb2a6fc56be6 ("mm:
>>>>>>> memcg: rework and document OOM waiting and wakeup"). So this is an
>>>>>>> established behavior for 10 years now. Do we really need to change it
>>>>>>> now? The interface is legacy and hopefully no new workloads are
>>>>>>> emerging.
>>>>>>>
>>>>>>> I agree that the placement is surprising but I would rather not change
>>>>>>> that unless there is a very good reason for that. Do you have any actual
>>>>>>> workload which depends on the ordering? And if yes, how do you deal with
>>>>>>> timing when the consumer of the notification just gets woken up after
>>>>>>> mem_cgroup_out_of_memory completes?
>>>>>>
>>>>>> yes, when the oom event is triggered, we check the under_oom every 10 seconds. If it
>>>>>> is cleared, then we create a new process with less memory allocation to avoid oom again.
>>>>>
>>>>> OK, I do understand what you mean and I could have made myself
>>>>> more clear previously. Even if the state is cleared _after_
>>>>> mem_cgroup_out_of_memory then you won't get what you need I am
>>>>> afraid. The memcg stays under OOM until a memory is freed (uncharged)
>>>>> from that memcg. mem_cgroup_out_of_memory itself doesn't really free
>>>>> any memory on its own. It relies on the task to wake up and die or
>>>>> oom_reaper to do the work on its behalf. All of that is time dependent.
>>>>> under_oom would have to be reimplemented to be cleared when a memory is
>>>>> unchanrged to meet your demands. Something that has never really been
>>>>> the semantic.
>>>>>
>>>>
>>>> yes, but at least before we create the new process, it has more chance to get some memory freed.
>>>
>>> The time window we are talking about is the call of
>>> mem_cgroup_out_of_memory which, depending on the number of evaluated
>>> processes, could be a very short time. So what kind of practical
>>> difference does this have on your workload? Is this measurable in any
>>> way.
>>
>> The oom events in this group seems less than before.
> 
> Let me see if I follow. You are launching new workloads after oom
> happens as soon as under_oom becomes 0. With the patch applied you see
> fewer oom invocations which imlies that fewer re-launchings hit the
> stil-under-oom situations? I would also expect that those are compared
> over the same time period. Do you have any actual numbers to present?
> Are they statistically representative?
> 
> I really have to say that I am skeptical over the presented usecase.
> Optimizing over oom events seems just like a very wrong way to scale the
> workload. Timing of oom handling is a subject to change at any time and
> what you are optimizing for might change.

I think the improvement may because of that, if we see under_oom is 1, we'll
sleep for 10s and check again. And the sleep time is enough to complete oom handling,
So the size of time window is much larger than the time spending on mem_cgroup_out_of_memory().

> 
> That being said, I do not see any obvious problem with the patch. IMO we
> should rather not apply it because it is slighly changing a long term
> behavior for something that is in a legacy mode now. But I will not Nack
> it either as it is just a trivial thing. I just do not like an idea we
> would be changing the timing of under_oom clearing just to fine tune
> some workloads.
>  
>>>>> Btw. is this something new that you are developing on top of v1? And if
>>>>> yes, why don't you use v2?
>>>>>
>>>>
>>>> yes, v2 doesn't have the "cgroup.event_control" file.
>>>
>>> Yes, it doesn't. But why is it necessary? Relying on v1 just for this is
>>> far from ideal as v1 is deprecated and mostly frozen. Why do you need to
>>> rely on the oom notifications (or oom behavior in general) in the first
>>> place? Could you share more about your workload and your requirements?
>>>
>>
>> for example, we want to run processes in the group but those parametes related to 
>> memory allocation is hard to decide, so use the notifications to inform us that we
>> need to adjust the paramters automatically and we don't need to create the new processes
>> manually.
> 
> I do understand that but OOM is just way too late to tune anything
> upon. Cgroup v2 has a notion of high limit which can throttle memory
> allocations way before the hard limit is set and this along with PSI
> metrics could give you a much better insight on the memory pressure
> in a memcg.
> 

Thank you for your suggestion. We will try to use memory.high instead.
