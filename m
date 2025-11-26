Return-Path: <cgroups+bounces-12207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D97ECC87F2A
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 04:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FEBC4E1BB7
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B330DD22;
	Wed, 26 Nov 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPtkj3Xx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYhycvr0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B0306B06
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127579; cv=none; b=lwSrp2rTIbfKew7Z3kNyVHuLr1uMfJcVT+OOtSzkVrO0c6TpoJIRwKHAdKQXzx+7RxdWhaFteDqUbicnvg8Ur8PJoXPeh8LTri14q2+/H+9gidiXw+DZWgvNCE4L6b1lbtbEMIANkFD+5yTvaoccmdZ1Ua7YjgdG5URiiCMRjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127579; c=relaxed/simple;
	bh=Sia2yxR8V7Pcxur4TtpiiyVbyxm4JnMGYfaNB44J6BM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bC7hzv1Ltc9926EgdfchVqFIOxRCEy9HPD/A1kzFL6X+olXoi6643ANTT4+qIU5p3MmVOf1BcSPY/uonOVq+n5PN5ct50QZWUQ2LBtBxfi1qmQ746W009L2joe32Xvs3XJpgkCQt703j65RElpX16B6RXXhpDwzF9Xt2mrktkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPtkj3Xx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYhycvr0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764127576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abOUtLUsvu/QAaSWZZCQTqM++QBrk8MYEct289JwQg4=;
	b=SPtkj3XxUa5GSowBh71AoveNqzTVBaRSs3J7RBVJTcMwD3g1/sY174Ph33mwQRS/xsp0nR
	ZKM9/G+j9/aUvxPc4Ucve3MHnNkDW7T5+zEq2ttLj3Zl/YAy1D0DpWLK8NnlQMqcJX/g40
	n1VKQqU0EvgB+S7DWjze+hYU53+TGns=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-PIV_n9O-MKiMguQNQ0UFdQ-1; Tue, 25 Nov 2025 22:26:15 -0500
X-MC-Unique: PIV_n9O-MKiMguQNQ0UFdQ-1
X-Mimecast-MFC-AGG-ID: PIV_n9O-MKiMguQNQ0UFdQ_1764127575
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2de6600c0so1766152285a.1
        for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 19:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764127574; x=1764732374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=abOUtLUsvu/QAaSWZZCQTqM++QBrk8MYEct289JwQg4=;
        b=OYhycvr0QJvvfjgbd8U0Ff5hrocxh2QVHAdptzd232+111yCQY6JDJ3gKRSrVqR9w3
         dA9oR5sK4a7piG1Di7IudgD2J9HtUjtK4lf0OouOePOotbw5YTGlF0eY4HaUjSwQQcYa
         Xvx2L9ISfje5U27VkfuJQw63w3bNnQGrnkZTahxOAZf7Mx5Yd+jIGanVuFGxjU/OtnTi
         bUjg330PlwO0WGNqixxF10UWDp9WyA4YurzmbR171F6Wm9tWP9DZrgBAgxTxcMZ2Aro8
         vu79kPJAxG9KVNSajQT6CWLTHF5cWhNn/noj11SqkEGLenm/J1CWyXYdMKH9br2KOO8K
         8YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127574; x=1764732374;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abOUtLUsvu/QAaSWZZCQTqM++QBrk8MYEct289JwQg4=;
        b=Nw7DCatFqx7i0f01VcZMA4X//xtrn8HJfpoyUHMsJrGT7bJ23sy2BDe8r/IM0HBNQq
         ngLIQWCgGSuKjvoLXLYi8WA088cF9SbkWFPFz7PDpWyTTF00DunoGYmEUkYJwRIZRvZa
         E95wx60RlhEe4dv8RdmP76NAJLPK9bYOZq5gmeV5Hhbzci1UMppFomeMaUMdR17dJNMe
         A7foxoU9gY9nuM5JIC2JK7gXJQQUMbkwtVd9MUcfKMdxiCXu2+2Op+DdDq/rh3LQ7tcC
         MIuGdUXXmoCtr6IQK07B39MB9sUKTFeaCXZN1FW3Fkui8qMF/bWRIgOyqgw072sgqFo3
         A30w==
X-Gm-Message-State: AOJu0Ywkfj4yp1s++8tAoi7Cdqnj/if7S8UXPzmhwCGOoiHtTmFzzQPC
	pz1/sWb3LwbnFpJDqLP3p35NKuJmVPsuLT+50vwnSpryZaCG7TkzQA6gEXxGLTm2NLBdL/I9ARr
	WcbcfFb+rY0E+fKxewD9Pzqr78rR7BNva/kDDCJeXprUbfBUSuN0lLxpWta8=
X-Gm-Gg: ASbGncupqV+eWNNVFbYdwxrA+vFj7hmmEf5J5YxkGI+HzlqoNxq9NCo8h9KUHVObpLz
	GyawT5mPB+XmizyUXVsddYNcmoLT+9hofG7P8ImU8+4xx3y7HxQt1hiiJ96rjEl0G2kMMlncmbn
	VirSaTzG10KPAN+dDOXDIgsBCcgjb2kR/acIflyOP1twUzBb9D9kFfXZyQB4ZjLh5Kl9/XPZJtp
	jEC0oys5u7B18glm1ocL2KxN7aCgwNfvH5OG0gBiPzqq5N82r4g7uO+QDqObpNBECZHZEdA6PdW
	atgATP8pgsdLiqkSMA5t2P26ZBMhk/22BeOPa8nUZwSsfa7B0EHXbvAg5YJM5uKvnS55kz7XQ6M
	emsWhtxIzKXMO8kote/55X12+OnTvPVQki/HC3EMj2BQvYToORKC6i1JW
X-Received: by 2002:a05:620a:2a11:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8b33d1b2498mr2234140785a.18.1764127574575;
        Tue, 25 Nov 2025 19:26:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUNpA4EZ5VqOhYfNsuWwom+wcXDH1ip4AgAeuaVadWiPDkq4fX/5ASRn/mpAYKFtXMvccJiQ==
X-Received: by 2002:a05:620a:2a11:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8b33d1b2498mr2234138485a.18.1764127574009;
        Tue, 25 Nov 2025 19:26:14 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b329431460sm1287663185a.15.2025.11.25.19.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 19:26:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f097b004-2307-4a29-9387-243bdb306849@redhat.com>
Date: Tue, 25 Nov 2025 22:26:12 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.m.jordan@oracle.com, lujialin4@huawei.com, chenridong@huawei.com
References: <20251118083643.1363020-1-chenridong@huaweicloud.com>
 <27ed2c0b-7b00-4be0-a134-3c370cf85d8e@redhat.com>
 <0ecb1476-2886-430f-a698-cabbe9302129@huaweicloud.com>
 <eaedf7d3-31dd-448b-9b00-60542e54260e@redhat.com>
 <d1c656bd-6d81-4f8b-96ab-41ace3509feb@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <d1c656bd-6d81-4f8b-96ab-41ace3509feb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 10:17 PM, Chen Ridong wrote:
>
> On 2025/11/26 10:33, Waiman Long wrote:
>> On 11/25/25 8:01 PM, Chen Ridong wrote:
>>> On 2025/11/26 2:16, Waiman Long wrote:
>>>>> active CPUs, preventing partition_sched_domains from being invoked with
>>>>> offline CPUs.
>>>>>
>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>> ---
>>>>>     kernel/cgroup/cpuset.c | 29 ++++++-----------------------
>>>>>     1 file changed, 6 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>> index daf813386260..1ac58e3f26b4 100644
>>>>> --- a/kernel/cgroup/cpuset.c
>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>> @@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
>>>>>      */
>>>>>     void rebuild_sched_domains_locked(void)
>>>>>     {
>>>>> -    struct cgroup_subsys_state *pos_css;
>>>>>         struct sched_domain_attr *attr;
>>>>>         cpumask_var_t *doms;
>>>>> -    struct cpuset *cs;
>>>>>         int ndoms;
>>>>> +    int i;
>>>>>           lockdep_assert_cpus_held();
>>>>>         lockdep_assert_held(&cpuset_mutex);
>>>> In fact, the following code and the comments above in rebuild_sched_domains_locked() are also no
>>>> longer relevant. So you may remove them as well.
>>>>
>>>>           if (!top_cpuset.nr_subparts_cpus &&
>>>>               !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>>>>                   return;
>>>>
>>> Thank you for reminding me.
>>>
>>> I initially retained this code because I believed it was still required for cgroup v1, as I recalled
>>> that synchronous operation is exclusive to cgroup v2.
>>>
>>> However, upon re-examining the code, I confirm it can be safely removed. For cgroup v1,
>>> rebuild_sched_domains_locked is called synchronously, and only the migration task (handled by
>>> cpuset_migrate_tasks_workfn) operates asynchronously. Consequently, cpuset_hotplug_workfn is
>>> guaranteed to complete before the hotplug workflow finishes.
>> Yes, v1 still have a task migration part that is done asynchronously because of the lock ordering
>> issue. Even if this code has to be left because of v1, you should still update the comment to
>> reflect that. Please try to keep the comment updated to help others to have a better understanding
>> of what the code is doing.
>>
>> Thanks,
>> Longman
>>
> Hi Longman,
>
> Just to confirm (in case I misunderstood): I believe it is safe to remove the check on
> top_cpuset.effective_cpus (for both cgroup v1 and v2). I will proceed to remove both the
> corresponding code and its associated comment(not update the comment).
>
>            if (!top_cpuset.nr_subparts_cpus &&
>                !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>                    return;
>
> Additionally, I should add a comment to clarify the rationale for introducing the
> WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)) warning.
>
> Does this approach look good to you? Please let me know if I’ve missed anything or if further
> adjustments are needed.
>
Yes, that is good for me. I was just talking about a hypothetical 
situation, not that you have to update the comment.

Cheers,
Longman


