Return-Path: <cgroups+bounces-13048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E43D10858
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 05:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8716F301D31C
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 04:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9030BF6F;
	Mon, 12 Jan 2026 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbv6sQ+u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cENsLiYz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901E3064A3
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190668; cv=none; b=ENj7keWEp/2vTIpRvgo27C/zXkMa53MWEtn0IqYDHKHU6IhzLdQMwrYKw7TvXW3OXpOATmdC52acZjCA2a47MCSUwsnqb5ZUDGeMfU3Fih66TzN3hZjTUHZIhOHTJVAEcjLyGromyXloPPVrZsKXSGDvR4pEijJrs0pxx20mCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190668; c=relaxed/simple;
	bh=dPeott3inavuGH7Qzod25D5H8K+DWgldzTF10XScIdQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W0lTM0BzTyh2wRKKEI4LKVdMNYJdC7OZFmnoBoSTIOuIXEREgBDeDel5XGIY1yjY327XOfMr5K7/JL6A7CyQWT1vKtNUEiizr9Mg0nz09YfnsRNLfHWhlUf5hlGu67FSMkNAgwruiZ39D2pRNTC41x07uXC7Bv/OcGWnNH5vy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbv6sQ+u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cENsLiYz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768190665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBZ2OmMI17pXJOhW5QFDE7NEPJ604PeqGMZr0wMWGNg=;
	b=cbv6sQ+uyho0duQEtizeB9O2Ef1Yt5FA99bGK01TK97JEutDS/dxi1um1Xipc8TF5zcoRQ
	N281D7cRjwLCn1QMW1mQl2mc1DjeIJI7+6qpJ7l1DY2P/KXdI2s1pm2QY0ron5eg1b4HKI
	B+6a3gZXdyl/pocG4pUCxNjPHcBbT7E=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-byG2iMnkM86hl13B1ShNig-1; Sun, 11 Jan 2026 23:04:22 -0500
X-MC-Unique: byG2iMnkM86hl13B1ShNig-1
X-Mimecast-MFC-AGG-ID: byG2iMnkM86hl13B1ShNig_1768190661
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ed079ef8dfso10721658137.0
        for <cgroups@vger.kernel.org>; Sun, 11 Jan 2026 20:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768190661; x=1768795461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VBZ2OmMI17pXJOhW5QFDE7NEPJ604PeqGMZr0wMWGNg=;
        b=cENsLiYzDlIOv5c/hGKF6VBlGmh5XoxEe36dzkiVOFRCcKMosDbA/yl5IFOgefrznU
         d8J4IpaG0pt6pzFieLMUlz69Zd3yTrJ8/sruJxqDUcfuDnOpa+lcVxvp5jL03hHhrpd3
         qAQqj8We6qfeoEJsaf8pKgFg2u9iPmd9rvz8/7dhd1oJTqEMct33rZzxLllrhyMcapLH
         CVwA3yMbaGvOQ7hwORrs9P2mGxPTkHGMmvJbVibzWI+G99BrQUJJgKklARjBNvEpRJnQ
         oxtWZ5/BWHJqRw5JrPgsxsKKTOInoz/610Otgb9NNihBjIB+oToLqZvO1JUWmn1XnqZC
         l0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768190661; x=1768795461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBZ2OmMI17pXJOhW5QFDE7NEPJ604PeqGMZr0wMWGNg=;
        b=QI3JEFnfyV1sZ+HBds2vN1FMDI6OFf7A7owtjof0O6BbmWXeIozii32IH7ZIz/AhwV
         DY6PYKhiYuYggX808XtiIw3qXpkb6DX3tNzgtH6Y6Bn43Or8SsKIWfhgNdAc+jT0IoRJ
         R5iGc7baGXY7bb+Rq8rM0yqOhTnOyR1x/LanmyD/PKkzEdYUnWUvBbCgdVuTbVwpK8sI
         T1Prdh9WiAUjqZ00h8LZqa0XJJ1JUAkPq0sp0darcuk5gTXWJhrhTpjqmL1U4pt1Qhi3
         dSnt1AeYpCGQJpGs/ps3rLV/Vyaidz4fGfaSbj/zIAXE/xqxI/8HGilLxGlQbeVCBJx5
         wflg==
X-Forwarded-Encrypted: i=1; AJvYcCXs/L1kWfRktz0HGSh1CobtMj16C0WhqHvabhRfn14iUztcjn8IC/mUuHHL183zft0ByeCSKMKz@vger.kernel.org
X-Gm-Message-State: AOJu0YySGQpXpD+sK77D2Abh8MKY/GxFEFk/mheEi8meBWOterc4TYjz
	McEDc1yqAb0Qg2u0qXgdWNS+Cy8hlxT4NK7lwuFa7dgigNRJbRNbHwkBsfe1RTTAiiZMyfQjexB
	qFE6OLahGchamuxbVn8ncmunjvCHCgVCwdZIjnS1/pMOdQAglSU1djycmwqg=
X-Gm-Gg: AY/fxX7VmQxEJ8FazrYqKNn064fiC90OLG5jjAIo30bR4UDG77DqPsv9ebZTqBukUTV
	k1CXVADIk329TomBLxp0yZUlJfqCsTDNfwWQDACl5wN+Wr7sFNXOrtcrj3JEf6Ld4Ik3Mfogh0Y
	8ieri0kXUcp3igXg0IvRU6etodCF4Fiqd1Tnh5CnIC8oL7Km/4Sf8kqFuRb27d0fYHMUWZI0cSW
	axqsjQOY6r46ZSmD2jiv+f3HM5Zwxu7MXIcFmqZ8f8YroK+KAhn+NTImWDfHvrABMqBrZ75tvIy
	dQFUfrr4wQyjTuzA5l1Si+a/oUet251QsSR7GRzmjBEOKh9oZRJJe+iiLo4KCFMZj1Yx1TGi8ku
	Dr9xxK1BxmhVoc4giTczjIkYs9PjiA0dw6HlSoXCzRwuSZ1HR6XNKLlY2
X-Received: by 2002:a05:6102:1175:b0:5ee:a6f8:f93b with SMTP id ada2fe7eead31-5eea6f90ebbmr3744396137.2.1768190661353;
        Sun, 11 Jan 2026 20:04:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfUaZzju+C/qgiKAiFXMuKARgml5PiHee7HYykHF5NDi6W40I1mwrUKTxqA5xFGORYHEWHRw==
X-Received: by 2002:a05:6102:1175:b0:5ee:a6f8:f93b with SMTP id ada2fe7eead31-5eea6f90ebbmr3744388137.2.1768190660958;
        Sun, 11 Jan 2026 20:04:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9fe7f478sm11275691137.3.2026.01.11.20.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 20:04:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ceeac2e6-7a6d-4f08-9afa-b99b8f0ef0fe@redhat.com>
Date: Sun, 11 Jan 2026 23:04:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v3 5/5] cgroup/cpuset: Move the v1 empty
 cpus/mems check to cpuset1_validate_change()
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260110013246.293889-1-longman@redhat.com>
 <20260110013246.293889-6-longman@redhat.com>
 <6812a73c-ace6-447a-9f92-4bc8783b3ed5@huaweicloud.com>
 <66132ea0-d096-4ac8-b6c0-eeef2833766b@huaweicloud.com>
 <624437fd-86c9-443d-b20f-edaaad869ea7@redhat.com>
 <94d62350-c449-47b3-a423-9fa5ff5b984c@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <94d62350-c449-47b3-a423-9fa5ff5b984c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/26 10:56 PM, Chen Ridong wrote:
>
> On 2026/1/12 11:47, Waiman Long wrote:
>> On 1/11/26 9:35 PM, Chen Ridong wrote:
>>> On 2026/1/12 10:29, Chen Ridong wrote:
>>>> On 2026/1/10 9:32, Waiman Long wrote:
>>>>> As stated in commit 1c09b195d37f ("cpuset: fix a regression in validating
>>>>> config change"), it is not allowed to clear masks of a cpuset if
>>>>> there're tasks in it. This is specific to v1 since empty "cpuset.cpus"
>>>>> or "cpuset.mems" will cause the v2 cpuset to inherit the effective CPUs
>>>>> or memory nodes from its parent. So it is OK to have empty cpus or mems
>>>>> even if there are tasks in the cpuset.
>>>>>
>>>>> Move this empty cpus/mems check in validate_change() to
>>>>> cpuset1_validate_change() to allow more flexibility in setting
>>>>> cpus or mems in v2. cpuset_is_populated() needs to be moved into
>>>>> cpuset-internal.h as it is needed by the empty cpus/mems checking code.
>>>>>
>>>>> Also add a test case to test_cpuset_prs.sh to verify that.
>>>>>
>>>>> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
>>>>> Closes: https://lore.kernel.org/lkml/7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com/
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>>    kernel/cgroup/cpuset-internal.h               |  9 ++++++++
>>>>>    kernel/cgroup/cpuset-v1.c                     | 14 +++++++++++
>>>>>    kernel/cgroup/cpuset.c                        | 23 -------------------
>>>>>    .../selftests/cgroup/test_cpuset_prs.sh       |  3 +++
>>>>>    4 files changed, 26 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>>> index e8e2683cb067..fd7d19842ded 100644
>>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>>> @@ -260,6 +260,15 @@ static inline int nr_cpusets(void)
>>>>>        return static_key_count(&cpusets_enabled_key.key) + 1;
>>>>>    }
>>>>>    +static inline bool cpuset_is_populated(struct cpuset *cs)
>>>>> +{
>>>>> +    lockdep_assert_cpuset_lock_held();
>>>>> +
>>>>> +    /* Cpusets in the process of attaching should be considered as populated */
>>>>> +    return cgroup_is_populated(cs->css.cgroup) ||
>>>>> +        cs->attach_in_progress;
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * cpuset_for_each_child - traverse online children of a cpuset
>>>>>     * @child_cs: loop cursor pointing to the current child
>>>>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>>>> index 04124c38a774..7a23b9e8778f 100644
>>>>> --- a/kernel/cgroup/cpuset-v1.c
>>>>> +++ b/kernel/cgroup/cpuset-v1.c
>>>>> @@ -368,6 +368,20 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>>>>        if (par && !is_cpuset_subset(trial, par))
>>>>>            goto out;
>>>>>    +    /*
>>>>> +     * Cpusets with tasks - existing or newly being attached - can't
>>>>> +     * be changed to have empty cpus_allowed or mems_allowed.
>>>>> +     */
>>>>> +    ret = -ENOSPC;
>>>>> +    if (cpuset_is_populated(cur)) {
>>>>> +        if (!cpumask_empty(cur->cpus_allowed) &&
>>>>> +            cpumask_empty(trial->cpus_allowed))
>>>>> +            goto out;
>>>>> +        if (!nodes_empty(cur->mems_allowed) &&
>>>>> +            nodes_empty(trial->mems_allowed))
>>>>> +            goto out;
>>>>> +    }
>>>>> +
>>>>>        ret = 0;
>>>>>    out:
>>>>>        return ret;
>>>> The current implementation is sufficient.
>>>>
>>>> However, I suggest we fully separate the validation logic for v1 and v2. While this may introduce
>>>> some code duplication (likely minimal), it would allow us to modify the validate_change logic for v2
>>>> in the future without needing to consider v1 compatibility. Given that v1 is unlikely to see further
>>>> changes, this separation would be a practical long-term decision.
>>>>
>>>> @@ -368,6 +368,48 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>>>           if (par && !is_cpuset_subset(trial, par))
>>>>                   goto out;
>>>>
>>>> +       /*
>>>> +        * Cpusets with tasks - existing or newly being attached - can't
>>>> +        * be changed to have empty cpus_allowed or mems_allowed.
>>>> +        */
>>>> +       ret = -ENOSPC;
>>>> +       if (cpuset_is_populated(cur)) {
>>>> +               if (!cpumask_empty(cur->cpus_allowed) &&
>>>> +                   cpumask_empty(trial->cpus_allowed))
>>>> +                       goto out;
>>>> +               if (!nodes_empty(cur->mems_allowed) &&
>>>> +                   nodes_empty(trial->mems_allowed))
>>>> +                       goto out;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * We can't shrink if we won't have enough room for SCHED_DEADLINE
>>>> +        * tasks. This check is not done when scheduling is disabled as the
>>>> +        * users should know what they are doing.
>>>> +        *
>>>> +        * For v1, effective_cpus == cpus_allowed & user_xcpus() returns
>>>> +        * cpus_allowed.
>>>> +        *
>>>> +        */
>>>> +       ret = -EBUSY;
>>>> +       if (is_cpu_exclusive(cur) && is_sched_load_balance(cur) &&
>>>> +           !cpuset_cpumask_can_shrink(cur->effective_cpus, user_xcpus(trial)))
>>>> +               goto out;
>>>> +
>>>> +       /*
>>>> +        * If either I or some sibling (!= me) is exclusive, we can't
>>>> +        * overlap. exclusive_cpus cannot overlap with each other if set.
>>>> +        */
>>>> +       ret = -EINVAL;
>>>> +       cpuset_for_each_child(c, css, par) {
>>>> +               if (c == cur)
>>>> +                       continue;
>>>> +               if (cpuset1_cpus_excl_conflict(trial, c))
>>>> +                       goto out;
>>>> +               if (mems_excl_conflict(trial, c))
>>>> +                       goto out;
>>>> +       }
>>>> +
>>>>           ret = 0;
>>>>    out:
>>>>           return ret;
>>>>
>>> A major redundancy is in the cpuset_cpumask_can_shrink check. By placing cpuset1_cpus_excl_conflict
>>> within the v1 path, we could simplify the overall cpus_excl_conflict function as well.
>> This is additional cleanup work. It can be done as a follow-on patch later on.
>>
> Okay, it looks good for me.
>
> Since you are going to update patch 4, maybe you can just add a patch to clean up.
>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>
>
This patch is a functional change for v2. Cleanup should be a separate 
patch. I would like to get this series done first as we are now in rc5. 
We can send the cleanup patch later.

Cheers,
Longman


