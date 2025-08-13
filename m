Return-Path: <cgroups+bounces-9110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA595B23D69
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 03:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FA1AA2AC0
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 01:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971545009;
	Wed, 13 Aug 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jK+2Q2jg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E520EB
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046839; cv=none; b=jvK1AVS9PwS/LS8r7Vo6LJfY5nFOzhsA5a8XqwbuIE2nZvc27pVp3W59VGz89ejHbnJ04LcYr1I1R0tlZhl/bnnOwYnmofZeov8VwJdIWwVFfQipfKbi+6sjSkqSd+n2AvLXi03IZbUYOlyMEfSdVK8V/7byYCexJYKxnH5nNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046839; c=relaxed/simple;
	bh=htQAX+OzsH70tP/0GrB98EgcTRPGF50t0O9za0wQ9wU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UXx9cSx3oF9o2KyqB3wu959bqNJokZftq+dCdJKoZSO/PYfbH8Su0eGZLzUHG8HHZcYjMH47louP2D7OcQ94hMM1Ony9MuwTdXsVpJIQ7oXzgVWFauRTplpe+tfqFSf5LawTK03wJ0vrQsZad+bgRWqhVjxAwf6aszc0Ci+qGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jK+2Q2jg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755046835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcpobIPomX39ZrN09qOVRsZUqzFXp2tUC2xT5amPN7U=;
	b=jK+2Q2jgN3cj3kaFhn5ebOBUwY6Xl8yY/IdnfXkBKCwG5T+JAjtBWVzmTi1/k200GWTdLZ
	f7UjXgUmKj35nR2JhVwydjo5z0EQtQvASnrFFqtPFX+NyebNhntdwHfqcN0MpPz+MvziTq
	B5nfQnpDgq5gg6dj93zgk9jmY6a+vV4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-IlmTP2FLOeupXyQaID_nuw-1; Tue, 12 Aug 2025 21:00:33 -0400
X-MC-Unique: IlmTP2FLOeupXyQaID_nuw-1
X-Mimecast-MFC-AGG-ID: IlmTP2FLOeupXyQaID_nuw_1755046833
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0de38c71fso33369081cf.3
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 18:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755046833; x=1755651633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcpobIPomX39ZrN09qOVRsZUqzFXp2tUC2xT5amPN7U=;
        b=uMue65ihx5gnuydh45B+ad08BA7ddj/GworZnh++Cr7756/3NFHtjo2gHfLkoTrQ9s
         uqyWfDtPSyXUsCRZXWvx/2OpL9/SoovkJoWt7hdWlgvZKoMac9ZYQlJRsPwAEd5ml9rg
         /SwUZNHFQGMtRCEqfb853DbwJxiDwrlkKxKlNoeLyV6/GdcfsFG/vOi8ik2HtS6ccS4E
         bIuBElaLhHdfEh1WLCuOHSjNJwDkpRjG8sgd09yDQdEaXQt3XzIGReeWZYeaRYYg0mUH
         Dk59EnTfhBP5j6Num4B8d5eiB3648gBrjYE4dMoMb+FaZbn87qdUY+BN+aql16aTVYF5
         v4cg==
X-Gm-Message-State: AOJu0YxiK+vK5ssQhVpHRv3F2Cu8ziB70rttHX1Ji9nb0PF6TSpfn4Zv
	7qZbC4kQ0IN6WADBXthT0POWhQA5MVBm7jzX7QATGE3DOwAN5XBmqkZqlnYZ3CPjR8AvgcNLXnW
	JFZHoB/b8Dv1CSJ1fYAVpn9bvtmM7TaJN/fcBmfPjATucWE6hDj5UxTshM+8=
X-Gm-Gg: ASbGnctXY1NsPR5F2vNiBo+xsVqPyRZB2qyjO1JBvXFPt0LqKwHaH1HG3Q6LFs/pxSw
	8v8MRrIBO00jIcIjmvvH0+R2D+Z7BwVyrqPcpX35fuHaHNhy76Y6quE/ffNYSoLrCSJNFXYx+mx
	o8lkudXM9upTdMfkP4InKC6KiyJujWTCn7zKst8rQH/n+BzK1RuMG2YmDq7IrRNnWb0DVkMIz20
	0lyRq8HtidCxqgnW3dNudXZYXPVdzFp2ZQlEHKh6qAZzixXl0RfYqskO1/6pMTPmbgYAlOZvNZ0
	iYuSjtgMqGOKrfMZFEs+vnwi9tc6fd+YXprzIHft4WKupkLRrPxza81Bqsqsip4eAh4uy2SQ+Df
	nBW3dUomvQg==
X-Received: by 2002:a05:622a:4249:b0:4b0:8392:80e4 with SMTP id d75a77b69052e-4b0fc736d1amr14285131cf.14.1755046833159;
        Tue, 12 Aug 2025 18:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGncbtkTJp3cSK/ZGz+AnSN/WgWxRBGbLB1QNY9dEAFHyzGGi9nvzBQh9DGnNgj0od4QlzZpg==
X-Received: by 2002:a05:622a:4249:b0:4b0:8392:80e4 with SMTP id d75a77b69052e-4b0fc736d1amr14284621cf.14.1755046832491;
        Tue, 12 Aug 2025 18:00:32 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4af1bc47cd9sm142867361cf.13.2025.08.12.18.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:00:31 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a27c39d5-7470-475e-aefa-0841bd816675@redhat.com>
Date: Tue, 12 Aug 2025 21:00:30 -0400
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
Content-Language: en-US
In-Reply-To: <775ef75a-b796-4171-b208-df110a73c558@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/25 8:54 PM, Chen Ridong wrote:
>
> On 2025/8/12 22:44, Waiman Long wrote:
>> On 8/8/25 5:25 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
>>> cpuset subsystem. Currently, the flag setting sequence is as follows:
>>>
>>> 1. cpuset_css_online() sets CS_ONLINE
>>> 2. css->flags gets CSS_ONLINE set
>>> ...
>>> 3. cgroup->kill_css sets CSS_DYING
>>> 4. cpuset_css_offline() clears CS_ONLINE
>>> 5. css->flags clears CSS_ONLINE
>>>
>>> The is_cpuset_online() check currently occurs between steps 1 and 3.
>>> However, it would be equally safe to perform this check between steps 2
>>> and 3, as CSS_ONLINE provides the same synchronization guarantee as
>>> CS_ONLINE.
>>>
>>> Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
>>> synchronization benefits, we can safely remove it to simplify the code.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    include/linux/cgroup.h          | 5 +++++
>>>    kernel/cgroup/cpuset-internal.h | 3 +--
>>>    kernel/cgroup/cpuset.c          | 4 +---
>>>    3 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>>> index b18fb5fcb38e..ae73dbb19165 100644
>>> --- a/include/linux/cgroup.h
>>> +++ b/include/linux/cgroup.h
>>> @@ -354,6 +354,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>>>        return css->flags & CSS_DYING;
>>>    }
>>>    +static inline bool css_is_online(struct cgroup_subsys_state *css)
>>> +{
>>> +    return css->flags & CSS_ONLINE;
>>> +}
>>> +
>>>    static inline bool css_is_self(struct cgroup_subsys_state *css)
>>>    {
>>>        if (css == &css->cgroup->self) {
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index 383963e28ac6..75b3aef39231 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -38,7 +38,6 @@ enum prs_errcode {
>>>      /* bits in struct cpuset flags field */
>>>    typedef enum {
>>> -    CS_ONLINE,
>>>        CS_CPU_EXCLUSIVE,
>>>        CS_MEM_EXCLUSIVE,
>>>        CS_MEM_HARDWALL,
>>> @@ -202,7 +201,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>>>    /* convenient tests for these bits */
>>>    static inline bool is_cpuset_online(struct cpuset *cs)
>>>    {
>>> -    return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
>>> +    return css_is_online(&cs->css) && !css_is_dying(&cs->css);
>>>    }
>>>      static inline int is_cpu_exclusive(const struct cpuset *cs)
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index f74d04429a29..cf7cd2255265 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -207,7 +207,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>>>     * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
>>>     */
>>>    static struct cpuset top_cpuset = {
>>> -    .flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
>>> +    .flags = BIT(CS_CPU_EXCLUSIVE) |
>>>             BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>>        .partition_root_state = PRS_ROOT,
>>>        .relax_domain_level = -1,
>> top_cpuset.css is not initialized like the one in the children. If you modify is_cpuset_online() to
>> test the css.flags, you will probably need to set the CSS_ONLINE flag in top_cpuset.css.flags. I do
>> doubt that we will apply the is_cpuset_online() test on top_cpuset. To be consistent, we should
>> support that.
>>
>> BTW, other statically allocated css'es in the cgroup root may have similar problem. If you make the
>> css_is_online() helper available to all other controllers, you will have to document that limitation.
>>
>> Cheers,
>> Longman
> Hi, Longman, thank you for your response.
>
> If I understand correctly, the CSS_ONLINE flag should be set in top_cpuset.css during the following
> process:
>
> css_create
>    css = ss->css_alloc(parent_css);  // cgroup root is static, unlike children
>    online_css(css);
>       ret = ss->css_online(css);     // css root may differ from children
>       css->flags |= CSS_ONLINE;      // css.flags is set with CSS_ONLINE, including the root css
>
> I think css online must be successful, and it's CSS_ONLINE flag must be set. Do I missing anything?

I am talking about just the top_cpuset which is statically allocated. It 
is not created by the css_create() call and so the CSS_ONLINE will not 
be set.

Cheers,
Longman


