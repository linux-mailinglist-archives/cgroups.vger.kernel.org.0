Return-Path: <cgroups+bounces-13046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9EED10821
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 04:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6E530456A8
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD830BF4E;
	Mon, 12 Jan 2026 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwI6xHUi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ovfibuHS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615329B8C7
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768189662; cv=none; b=SRZ1FJwReWKS1hK227Vcp5DdeZWQCAwYh8//mm7ipQbgPtjwRAvIjeK+BNo59M8vhZgAxD1T703++9l0WHbyZVZp0ydkEzu0CiGzitdrMe+NwC+F0arQ3F8huH/Tm48HC8z0nT5HC/7KLkKmOPU2ru+oByqqA7wpUUDi/jCcCLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768189662; c=relaxed/simple;
	bh=IrnZ2+M+Vc5w0TFs4tu9ChhgJfrzE6RfnTlghyvn95w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TsA0FSWY8gm8NHX17F93yBzIV719oN54Qc/nGVvejxBTXkCgjd0fLrBP4RiR2j7/enb7nfGazKAHyvzztjhdA6ETYKyvp+nB++N1ra+ppJvBHtRj360AEDWCmb0GCKmz/tZX6TWHXk69WhRISgUdkGU7glgml8mZxv7SrXOMQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwI6xHUi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ovfibuHS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768189658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC3gsG0DRkCLOudcFUBN+sXXUWvTLQPruPgq340BHRM=;
	b=KwI6xHUib6P8hSLkq9aUpD2p8D/ysWMJFPo1qHSezlVmfZh1Owkp1YYXNzyqULq0bvxBmU
	zlIcB/u7kUWdhc2LFHuuClTfrq6tE9dubs/IvhI6RkxDrqkq4dzuxSHZEtqq28RIKnG2SQ
	zrXiwqQ/IytpU5sywzgM68uKC1xxUzI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-GC7OSTY0M12MS4buq9Udng-1; Sun, 11 Jan 2026 22:47:37 -0500
X-MC-Unique: GC7OSTY0M12MS4buq9Udng-1
X-Mimecast-MFC-AGG-ID: GC7OSTY0M12MS4buq9Udng_1768189657
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5ed0a71c0beso3834227137.2
        for <cgroups@vger.kernel.org>; Sun, 11 Jan 2026 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768189656; x=1768794456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rC3gsG0DRkCLOudcFUBN+sXXUWvTLQPruPgq340BHRM=;
        b=ovfibuHSGGh9jb7WdiIXPxQ3wbn8VAV+ChegPWbxGB/EGVqdhMwRDETSbRU5nigsrT
         CH9z89BcoJFlRWNt2ZOB1ELM2mxQfIUxTgRSX5nVcmK3peQ8+NuZzPhaABcyFmO5W6gs
         gU8xRmyqyWIWyACj6oMuGVJm0tazeom/gMQLuZtWXh8rrPkBm9Dv9yiV4q9VkKzT2JUV
         hbdaPMvtXQObE9LZtneeaEOl1NAh09K5ijpz+PuXINbJZZBnOab8pveP7piadZMl+btW
         15efbisXotjYSiF/oU4mCFmDmCQS57iIZAnpzUPQfwOkQYbFALOtulvAO8MSpoYujm55
         TiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768189656; x=1768794456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC3gsG0DRkCLOudcFUBN+sXXUWvTLQPruPgq340BHRM=;
        b=vfpmRN6soKF9k7lR710smnLSEGF/SWoKC2siU7BYEPIE1pymloLABU5NgARh5Gd+uF
         DKino3Am+H6UsUwObaq5y+ecFyKNfgNbSZnYNSJPAOxLPvzUMjPNP+NfTznuDKhVTl8i
         +WbscZgF45KEria2XBhsxa6Kb2EMRMJYUqkXKdqxLy3uHd9AIrXky+eQoUNX0MHe1apC
         lVFJgZgY3SQZJQeCYhLpdRUyJcL8vKbEN9LYiDJdf4NJg8KwPMOO3iByVGCBKch1E7Cu
         6TUhQlw5spOk24FhfwTzbfDFBUj0nlaih3VWdWiW6C8cnliZhoK5RrLDgnJ8rFnL26m5
         oPmw==
X-Forwarded-Encrypted: i=1; AJvYcCW8j4G/XmAVrzquHws+U68wlrDt8xuDk7JN1GbvEMz27BnA6DbNU85jRWkavtBIzs6IrS8B459i@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTnowaHmnws0hxmq9rN/jQTy6asGOZtwW8zj0zbrqljz2Ew18
	2CH+6zAC1Poo48eDSPEiEEaZNXv1UeOD+mDNc+HoFJlThiPzTVPoliHPOdvnl5QpHtyNKZMFWaf
	zFqiXZ55ISi2+3PwSay2iKqoZiod2ils+7sysfRym5qMe/IvCg4PQr+OvqsU=
X-Gm-Gg: AY/fxX4uD1MvPGVCGSbzherb1wlp1pkaxuMbgVaBRmlvVsfkXk9oNejTKDylG7EREdz
	wpKbip/FeAEcatChX7sJdPxbBNQor9WYp0ItwhfPs6RanTYEhkm8qzeo3dVvpCZaEIsRbrgOVRv
	dfYmTfLI36RRbH6txXdkoYPkdLVG/4fH45T7iUgPYlliUqx8HTkxw/HjHARK49OyTxyY7xtQQ79
	J+fY6jVyVee3kOn7hgNU0f/LVUstYEirk9fZObzCWLE30RaWZxm1SVt/sKOKXpPaYQ0YNJ458Fn
	299WtgzZ9Lne0y0RSHg99yjBwxfHt20q8q4Ahdo4ssa1iLZnYICM+6RrJ0hI7NDQKHf+o1IiF6+
	Hgrrl4O1mXQoZ5OkYuXhvZ3GLP5NnHFfd6SJ9BSb7K9l7d9IMiZ1/n7VN
X-Received: by 2002:a05:6102:5e98:b0:5ee:a03c:8774 with SMTP id ada2fe7eead31-5eea03c97e8mr5579544137.28.1768189656511;
        Sun, 11 Jan 2026 19:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0vUHKa+Zmw611N5pJOS0RIE7dqnumdkx8wUXopOmRbDKXBPZ6LdivT0fJ4Q1OqRdmPoyFBw==
X-Received: by 2002:a05:6102:5e98:b0:5ee:a03c:8774 with SMTP id ada2fe7eead31-5eea03c97e8mr5579530137.28.1768189656136;
        Sun, 11 Jan 2026 19:47:36 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944121ef3fcsm15552104241.0.2026.01.11.19.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 19:47:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <624437fd-86c9-443d-b20f-edaaad869ea7@redhat.com>
Date: Sun, 11 Jan 2026 22:47:29 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 5/5] cgroup/cpuset: Move the v1 empty
 cpus/mems check to cpuset1_validate_change()
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-6-longman@redhat.com>
 <6812a73c-ace6-447a-9f92-4bc8783b3ed5@huaweicloud.com>
 <66132ea0-d096-4ac8-b6c0-eeef2833766b@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <66132ea0-d096-4ac8-b6c0-eeef2833766b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/26 9:35 PM, Chen Ridong wrote:
>
> On 2026/1/12 10:29, Chen Ridong wrote:
>>
>> On 2026/1/10 9:32, Waiman Long wrote:
>>> As stated in commit 1c09b195d37f ("cpuset: fix a regression in validating
>>> config change"), it is not allowed to clear masks of a cpuset if
>>> there're tasks in it. This is specific to v1 since empty "cpuset.cpus"
>>> or "cpuset.mems" will cause the v2 cpuset to inherit the effective CPUs
>>> or memory nodes from its parent. So it is OK to have empty cpus or mems
>>> even if there are tasks in the cpuset.
>>>
>>> Move this empty cpus/mems check in validate_change() to
>>> cpuset1_validate_change() to allow more flexibility in setting
>>> cpus or mems in v2. cpuset_is_populated() needs to be moved into
>>> cpuset-internal.h as it is needed by the empty cpus/mems checking code.
>>>
>>> Also add a test case to test_cpuset_prs.sh to verify that.
>>>
>>> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
>>> Closes: https://lore.kernel.org/lkml/7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com/
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/cgroup/cpuset-internal.h               |  9 ++++++++
>>>   kernel/cgroup/cpuset-v1.c                     | 14 +++++++++++
>>>   kernel/cgroup/cpuset.c                        | 23 -------------------
>>>   .../selftests/cgroup/test_cpuset_prs.sh       |  3 +++
>>>   4 files changed, 26 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index e8e2683cb067..fd7d19842ded 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -260,6 +260,15 @@ static inline int nr_cpusets(void)
>>>   	return static_key_count(&cpusets_enabled_key.key) + 1;
>>>   }
>>>   
>>> +static inline bool cpuset_is_populated(struct cpuset *cs)
>>> +{
>>> +	lockdep_assert_cpuset_lock_held();
>>> +
>>> +	/* Cpusets in the process of attaching should be considered as populated */
>>> +	return cgroup_is_populated(cs->css.cgroup) ||
>>> +		cs->attach_in_progress;
>>> +}
>>> +
>>>   /**
>>>    * cpuset_for_each_child - traverse online children of a cpuset
>>>    * @child_cs: loop cursor pointing to the current child
>>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>> index 04124c38a774..7a23b9e8778f 100644
>>> --- a/kernel/cgroup/cpuset-v1.c
>>> +++ b/kernel/cgroup/cpuset-v1.c
>>> @@ -368,6 +368,20 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>>   	if (par && !is_cpuset_subset(trial, par))
>>>   		goto out;
>>>   
>>> +	/*
>>> +	 * Cpusets with tasks - existing or newly being attached - can't
>>> +	 * be changed to have empty cpus_allowed or mems_allowed.
>>> +	 */
>>> +	ret = -ENOSPC;
>>> +	if (cpuset_is_populated(cur)) {
>>> +		if (!cpumask_empty(cur->cpus_allowed) &&
>>> +		    cpumask_empty(trial->cpus_allowed))
>>> +			goto out;
>>> +		if (!nodes_empty(cur->mems_allowed) &&
>>> +		    nodes_empty(trial->mems_allowed))
>>> +			goto out;
>>> +	}
>>> +
>>>   	ret = 0;
>>>   out:
>>>   	return ret;
>> The current implementation is sufficient.
>>
>> However, I suggest we fully separate the validation logic for v1 and v2. While this may introduce
>> some code duplication (likely minimal), it would allow us to modify the validate_change logic for v2
>> in the future without needing to consider v1 compatibility. Given that v1 is unlikely to see further
>> changes, this separation would be a practical long-term decision.
>>
>> @@ -368,6 +368,48 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>          if (par && !is_cpuset_subset(trial, par))
>>                  goto out;
>>
>> +       /*
>> +        * Cpusets with tasks - existing or newly being attached - can't
>> +        * be changed to have empty cpus_allowed or mems_allowed.
>> +        */
>> +       ret = -ENOSPC;
>> +       if (cpuset_is_populated(cur)) {
>> +               if (!cpumask_empty(cur->cpus_allowed) &&
>> +                   cpumask_empty(trial->cpus_allowed))
>> +                       goto out;
>> +               if (!nodes_empty(cur->mems_allowed) &&
>> +                   nodes_empty(trial->mems_allowed))
>> +                       goto out;
>> +       }
>> +
>> +       /*
>> +        * We can't shrink if we won't have enough room for SCHED_DEADLINE
>> +        * tasks. This check is not done when scheduling is disabled as the
>> +        * users should know what they are doing.
>> +        *
>> +        * For v1, effective_cpus == cpus_allowed & user_xcpus() returns
>> +        * cpus_allowed.
>> +        *
>> +        */
>> +       ret = -EBUSY;
>> +       if (is_cpu_exclusive(cur) && is_sched_load_balance(cur) &&
>> +           !cpuset_cpumask_can_shrink(cur->effective_cpus, user_xcpus(trial)))
>> +               goto out;
>> +
>> +       /*
>> +        * If either I or some sibling (!= me) is exclusive, we can't
>> +        * overlap. exclusive_cpus cannot overlap with each other if set.
>> +        */
>> +       ret = -EINVAL;
>> +       cpuset_for_each_child(c, css, par) {
>> +               if (c == cur)
>> +                       continue;
>> +               if (cpuset1_cpus_excl_conflict(trial, c))
>> +                       goto out;
>> +               if (mems_excl_conflict(trial, c))
>> +                       goto out;
>> +       }
>> +
>>          ret = 0;
>>   out:
>>          return ret;
>>
> A major redundancy is in the cpuset_cpumask_can_shrink check. By placing cpuset1_cpus_excl_conflict
> within the v1 path, we could simplify the overall cpus_excl_conflict function as well.

This is additional cleanup work. It can be done as a follow-on patch 
later on.

Cheers,
Longman

>


