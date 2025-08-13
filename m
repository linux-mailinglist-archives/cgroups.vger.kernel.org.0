Return-Path: <cgroups+bounces-9112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE6B23DBD
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 03:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3263B685675
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 01:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B319992C;
	Wed, 13 Aug 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRPDiH5k"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A82C0F8F
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048827; cv=none; b=qji/YuMofK5jre7aCxNoithK+yaXp/YlRGlkAaVP5wQDdp8UnK+b3x6t+dO0raRdAVc0slUbdziAaMHOk22+vEHAAfodJ32tkNbNM5Ovml/G/2tEFVkjdyJE8yh7A/wUyqZ0/K02AEUG8dvVvti81jJUaZEu6myYvW0IrKsr1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048827; c=relaxed/simple;
	bh=amt9fQ+hzqhUzUaBuuFUSSschCXSCkytR0vGDT1aRso=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eDLcM0exQXfIdY60z/00JRvzDEK6gqaA2HKIeQGxUenIDJzjWcTS+imp4iOUhYC3cpS83aMNQmUeMfASMKOLczG/qFvGCG7EKsqyAzhfnFoeZHAWJ802nFXkczBI2eXqacTIqwT/T5qH/cKn0ijnk+4DP+hNLJLjQEGCafZUSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRPDiH5k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755048824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMkXgqdgmkLcM/jJiNxIyh4VhtxDGX3we5dKE2An65U=;
	b=DRPDiH5kAdOoAa0Nf0ytnU9VDzle7uCH7A07N3eQuIud0T3HDp4pWbbN08WiADz+VpKaaN
	GQAyPeTFQ1mv+Z3qPQfLDkUjMKufE6D/IR4qD5LEsTclmiThJpmJvvtm0pEVgF8TZxXSm8
	cn0gTMePIh4l1d4dXLdAPFKPoLW8o90=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-l-IWkR6iO7mAgGAI7pDJoA-1; Tue, 12 Aug 2025 21:33:43 -0400
X-MC-Unique: l-IWkR6iO7mAgGAI7pDJoA-1
X-Mimecast-MFC-AGG-ID: l-IWkR6iO7mAgGAI7pDJoA_1755048822
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70741fda996so109717576d6.0
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 18:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755048822; x=1755653622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMkXgqdgmkLcM/jJiNxIyh4VhtxDGX3we5dKE2An65U=;
        b=qOODQ9Mo9KYarK6eS/v44TKjMSvnX6FbrPGnANPu3fW+bnkf8nh51uTTFXcQ86GCYP
         d7HPG76mkF7EJleRXQ6PFOgmZ6zIMo9c6t9Ms00vi3H7encI1ispKVLBXLMl9PowKgRZ
         1XZYcuCApLXCLZ1reV1Q5EhNo5199vuwKywRpQoRBjJuFhZXhYR4J85kVCdi9KL0TbWc
         uuU7fW7QongjUlretCdC7U3vD5fppXq5ynFs09mdyLa+WLF+0UVsJqM79k7mFVWwBBPl
         ZEk2OpjPuX2Ldm0eJJgR8MZu7lov4w2J4oAGOeD8mE33+/P2Ah5Ls8DTqbP/iouOGkLz
         hIzA==
X-Gm-Message-State: AOJu0YxwG+/o9P9bPeq3c9SvpnTXEmO4llLsRm0S7kvCvVSvdMUzTIgK
	8dCzMsEG/9pP+q1gQP3vMcFC9Gs5hgAw9zzH5cwe3HWuoxq2qcmFrM0lPcmMee3UA0pSUgpnQp+
	d6KeWM18VB4toz2GP6hu6DRgu4VEtnf4ZaT3kmJwFPYuYLlazg9i1iiJn6CQ=
X-Gm-Gg: ASbGncvN9mANLsVq4j7DgbnCZPvnGgqm/HJwUJWdXYsPaJr4IUwF5PuNtSO3WQhCa/h
	7W/JP24DkSDinaDQG161/40kOzDLKUj5UA/eYpZHwucvIOFQVb/o5NoYPg0CqrO8KDvAqqwxgml
	m0HzdUknkf1Hi9+/S/dTHLcz1j6TRnAXjbmsZJqrqH1AaqgGHR2ifwNCWBRY00IkiNCCO7uHhyC
	N3mqwiqithm7acsx6XheZCNBrt1HZdxwk3O0s5naQL+zlm0T370eAD6dxuP5UtBRpVL4QYdSOdK
	unM4jGJONFEpEfjKForuj2rswlFjKcTX7p56Wgk8+Nrnoz4Z1SY1dsHK4FK6EPcf0AitkI6JRsS
	zpAyVg8/7vw==
X-Received: by 2002:ad4:5aa7:0:b0:707:430e:dc00 with SMTP id 6a1803df08f44-709e899099emr19101426d6.39.1755048822254;
        Tue, 12 Aug 2025 18:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6sHvbCHj/mN3gkdBxFJ5MFYqpAWh6qVfC8b7SInzTw6ddl7QL7pNleVjOpscQwsuVLkOkcw==
X-Received: by 2002:ad4:5aa7:0:b0:707:430e:dc00 with SMTP id 6a1803df08f44-709e899099emr19101106d6.39.1755048821705;
        Tue, 12 Aug 2025 18:33:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da463sm186228176d6.9.2025.08.12.18.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:33:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8ed8cac1-4cf1-4880-9e7d-4e8c816797fa@redhat.com>
Date: Tue, 12 Aug 2025 21:33:39 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/4] cpuset: remove redundant CS_ONLINE flag
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
 <20250808092515.764820-2-chenridong@huaweicloud.com>
 <db5fdf29-43d9-4e38-a5a8-02cd711b892a@redhat.com>
 <775ef75a-b796-4171-b208-df110a73c558@huaweicloud.com>
 <a27c39d5-7470-475e-aefa-0841bd816675@redhat.com>
 <95c78188-bf8d-4453-b74f-b8a7dc6ae14d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <95c78188-bf8d-4453-b74f-b8a7dc6ae14d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/12/25 9:20 PM, Chen Ridong wrote:
>
> On 2025/8/13 9:00, Waiman Long wrote:
>> On 8/12/25 8:54 PM, Chen Ridong wrote:
>>> On 2025/8/12 22:44, Waiman Long wrote:
>>>> On 8/8/25 5:25 AM, Chen Ridong wrote:
>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>
>>>>> The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
>>>>> cpuset subsystem. Currently, the flag setting sequence is as follows:
>>>>>
>>>>> 1. cpuset_css_online() sets CS_ONLINE
>>>>> 2. css->flags gets CSS_ONLINE set
>>>>> ...
>>>>> 3. cgroup->kill_css sets CSS_DYING
>>>>> 4. cpuset_css_offline() clears CS_ONLINE
>>>>> 5. css->flags clears CSS_ONLINE
>>>>>
>>>>> The is_cpuset_online() check currently occurs between steps 1 and 3.
>>>>> However, it would be equally safe to perform this check between steps 2
>>>>> and 3, as CSS_ONLINE provides the same synchronization guarantee as
>>>>> CS_ONLINE.
>>>>>
>>>>> Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
>>>>> synchronization benefits, we can safely remove it to simplify the code.
>>>>>
>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>> ---
>>>>>     include/linux/cgroup.h          | 5 +++++
>>>>>     kernel/cgroup/cpuset-internal.h | 3 +--
>>>>>     kernel/cgroup/cpuset.c          | 4 +---
>>>>>     3 files changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>>>>> index b18fb5fcb38e..ae73dbb19165 100644
>>>>> --- a/include/linux/cgroup.h
>>>>> +++ b/include/linux/cgroup.h
>>>>> @@ -354,6 +354,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>>>>>         return css->flags & CSS_DYING;
>>>>>     }
>>>>>     +static inline bool css_is_online(struct cgroup_subsys_state *css)
>>>>> +{
>>>>> +    return css->flags & CSS_ONLINE;
>>>>> +}
>>>>> +
>>>>>     static inline bool css_is_self(struct cgroup_subsys_state *css)
>>>>>     {
>>>>>         if (css == &css->cgroup->self) {
>>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>>> index 383963e28ac6..75b3aef39231 100644
>>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>>> @@ -38,7 +38,6 @@ enum prs_errcode {
>>>>>       /* bits in struct cpuset flags field */
>>>>>     typedef enum {
>>>>> -    CS_ONLINE,
>>>>>         CS_CPU_EXCLUSIVE,
>>>>>         CS_MEM_EXCLUSIVE,
>>>>>         CS_MEM_HARDWALL,
>>>>> @@ -202,7 +201,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>>>>>     /* convenient tests for these bits */
>>>>>     static inline bool is_cpuset_online(struct cpuset *cs)
>>>>>     {
>>>>> -    return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
>>>>> +    return css_is_online(&cs->css) && !css_is_dying(&cs->css);
>>>>>     }
>>>>>       static inline int is_cpu_exclusive(const struct cpuset *cs)
>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>> index f74d04429a29..cf7cd2255265 100644
>>>>> --- a/kernel/cgroup/cpuset.c
>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>> @@ -207,7 +207,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>>>>>      * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
>>>>>      */
>>>>>     static struct cpuset top_cpuset = {
>>>>> -    .flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
>>>>> +    .flags = BIT(CS_CPU_EXCLUSIVE) |
>>>>>              BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>>>>         .partition_root_state = PRS_ROOT,
>>>>>         .relax_domain_level = -1,
>>>> top_cpuset.css is not initialized like the one in the children. If you modify is_cpuset_online() to
>>>> test the css.flags, you will probably need to set the CSS_ONLINE flag in top_cpuset.css.flags. I do
>>>> doubt that we will apply the is_cpuset_online() test on top_cpuset. To be consistent, we should
>>>> support that.
>>>>
>>>> BTW, other statically allocated css'es in the cgroup root may have similar problem. If you make the
>>>> css_is_online() helper available to all other controllers, you will have to document that
>>>> limitation.
>>>>
>>>> Cheers,
>>>> Longman
>>> Hi, Longman, thank you for your response.
>>>
>>> If I understand correctly, the CSS_ONLINE flag should be set in top_cpuset.css during the following
>>> process:
>>>
>>> css_create
>>>     css = ss->css_alloc(parent_css);  // cgroup root is static, unlike children
>>>     online_css(css);
>>>        ret = ss->css_online(css);     // css root may differ from children
>>>        css->flags |= CSS_ONLINE;      // css.flags is set with CSS_ONLINE, including the root css
>>>
>>> I think css online must be successful, and it's CSS_ONLINE flag must be set. Do I missing anything?
>> I am talking about just the top_cpuset which is statically allocated. It is not created by the
>> css_create() call and so the CSS_ONLINE will not be set.
>>
>> Cheers,
>> Longman
> Hi Longman,
>
> Apologies for the call stack earlier. Thank you for your patience in clarifying this matter.
>
> The CSS root is brought online through the following initialization flow:
>
> cgroup_init_subsys
>    css = ss->css_alloc(NULL);       // css root is static, unlike children
>    online_css(css)
>      ret = ss->css_online(css);     // css root may differ from children
>      css->flags |= CSS_ONLINE;      // css.flags is set with CSS_ONLINE, including the root css
>
> My key point is that:
> - The root CSS should be online by design.
> - Root css CSS_ONLINE flag should be properly set during initialization.

Yes, you are right. I missed css_online() call for the root css for each 
controller. Thanks for the clarification.

With that, I am OK with this patch. Though the other ones are not good.

Acked-by: Waiman Long <longman@redhat.com>


