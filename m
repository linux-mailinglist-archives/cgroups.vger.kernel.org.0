Return-Path: <cgroups+bounces-12774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631FCDF51A
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 08:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311B33006A8E
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D325A359;
	Sat, 27 Dec 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX52qJ0D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oSxuZa5v"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4E23D291
	for <cgroups@vger.kernel.org>; Sat, 27 Dec 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821360; cv=none; b=rTqk0qNO/UObuDq6OWk5DA4loksHN0zAd6D49msblSxhVzyeqNl2eAzvUpQb5NqiHbzkR8rmwDUzUhDMr5TbnMkh7U968o2D4CJeMyzdQqgWaTK7q9/7kBw59FyCsB4gnJoPEq2iRcSb9126LDqvyJgCVK6b4KKdPoCt4/VGm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821360; c=relaxed/simple;
	bh=BocZbYRq6z/au+ST87u3K7kwQZG0Z/SXAcjr75/GKmo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BfdoGO3k9qkZLuSnmWCdhYbKnzJZSGgf+ikxDXm3h403Kx8v52KR+eeX3gzusqXkbYERWnhCtUhKfc8FHJBUoeyrFc8/oH7UoNMlG2VqJ5Jpz5+fqQC9tOC8xKrXCKWSf918YxZGh/zYJqf6fIK8y22D7RQp9BJi98vP6Q9npz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YX52qJ0D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oSxuZa5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766821357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai5QZoNo9dRmzRpnYcu62kdxHtsGiqg1pjhwu4q+YNg=;
	b=YX52qJ0DPEwbY5aXX522mi3j98XfZbu2jJdpVgNwZ0f+btUvhrMeLIbJwqmXvdY92k7R0H
	goRfNzeAn9toTXOs7rf520X8galLKzQDUT1LTNNq6qM4HghyVsoz2nQaeA/rJyOoTh2lDl
	dCHSZwQWMYOciqMNbCsh5m3C9W9XZt8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Jsz9iaXBP9KM_7CNcXtlNg-1; Sat, 27 Dec 2025 02:42:35 -0500
X-MC-Unique: Jsz9iaXBP9KM_7CNcXtlNg-1
X-Mimecast-MFC-AGG-ID: Jsz9iaXBP9KM_7CNcXtlNg_1766821355
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b51db8ebd9so2503805885a.2
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 23:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766821355; x=1767426155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ai5QZoNo9dRmzRpnYcu62kdxHtsGiqg1pjhwu4q+YNg=;
        b=oSxuZa5vzKUr+dMw1Ahha0TB0QpuQXGgHk7N28EP1Qu2ALB7F94naW7TrEC+WSJfKu
         dRNx7ZrVj6IkrcKYOet0FiLoZnxSKdkT/MFVm6JNrhIH1FJXzLMXV/12PKqttK+Sqg6+
         nunyWwvxXcSZljJLa21eF6CDYcfg+DRvv/6c4Z3I/i8uDvq/ksd7s6LV9g+/x9yJ1dFx
         P2gUTJzlTKqeOoIgWSIjC4PuT6B7h4NdSqcfkqbNt5WW9lXhxVJB4LretWXbsjKVbtgE
         mAA7YcQ2Qm8CnUDThe5ThL28YZfFY6aIP1rxnmOSmkwlEjrqgkcJV211Adx+iHV0z+qv
         9l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766821355; x=1767426155;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5QZoNo9dRmzRpnYcu62kdxHtsGiqg1pjhwu4q+YNg=;
        b=b/0zLj68gkPQQwN+XBuTt+9A89vh7y50CXdtKj/8c71D5UZb/8fnVVEhzF6vJKpqGL
         KD3OjiqXe5Sc2g7+CSTco8Je1uinf0DrtrOO/1DeE0VFmKJTEm78atL19pqdGKCz3mXQ
         8OlA4udHwbaSylHS1YmSLfNd4gzAcm98sUWgHembDM/XAm/5sQ9y9nUpDYDqAVqVLuIq
         Cf0Y8lm5Mi83o5ku9qxKrrburhdSVRAEoAW4l+xJjhhoPu7DpRNQduiLALMSt3ykXXA0
         So4uTwGz10k7caAoZ8NE9H9P5dtwzMbqa/GJIjZhygYVYqTmNK/ErwgMS02r0/YzZwOF
         +/qA==
X-Forwarded-Encrypted: i=1; AJvYcCXlEZSa6SScGdotGkghzaCLzMlXAm5casWlHaHydWWuIR8V2S0CQvCwLQl4Gl6S/+9f9tEzk2oB@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXcE2zvkpTQlCyDYy6x3cy74EZzfxNPmacYEEuF/3IKpglIWP
	Q3MhHwbGvLCC0c/jfRISygYfit+VOjod2ghHFrIJrfbPxOmF9F8ykWDMcYRapJi00ufg2mJ5Ot3
	RiYx33lp5sBAz8XNjGcpWGQkMr/MtBCEJ6+9ehRhart2BjzAMv+BiC0zHNkMH0amMQX4=
X-Gm-Gg: AY/fxX5Y1vhRQfVc2fWNl/nCMQ4TRF4AjwvLM0JAfauXKFv8B4iMLwXXGMqWvtayNR5
	KGqY7kV6ti0ISqe/URycyH21pvAWFwJEtlNpWJw3cTXVV+lkjPIx8wTgXRU+fMpiTaOB5KjRXWG
	OO1YTjXJsq/1C72O7WQvYHCprp05eJ3gBm3vXIytRfXpSMJ10cYJplYGu1B5jXPfflzPV4Rre3m
	I3DbQxtFEoO0UCaPo2CTkGdwPvEBt08zEPfZ7xnbxcZUhVfCMj0sQJOhpIf0PBriJPeNIKLqlai
	xftqAaS6wyhWxJeCFMipPHPLB8NUfEqss5/Eg/gjnh2/lcF+khiXRG5qM89p1ymQnQA577YCLbr
	/+5GM1f1A+MyMAON7hDod8bnJcsvQHYCq1Xq9xAlQhv9zEuXxFbQruTtv
X-Received: by 2002:a05:620a:691a:b0:8a3:22d7:6ca3 with SMTP id af79cd13be357-8c08f66c311mr4100430285a.31.1766821354674;
        Fri, 26 Dec 2025 23:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgUkS9lhL5RJ5RrznVdm76aY6GDLmzlCdRQHSFG0i9N6BzjWpT0CJfzF++onNseQeBYwVs1A==
X-Received: by 2002:a05:620a:691a:b0:8a3:22d7:6ca3 with SMTP id af79cd13be357-8c08f66c311mr4100428585a.31.1766821354210;
        Fri, 26 Dec 2025 23:42:34 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f08fcsm1897016385a.40.2025.12.26.23.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 23:42:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <471d1be6-db23-42b2-a5e8-5207fb4dcaeb@redhat.com>
Date: Sat, 27 Dec 2025 02:42:32 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH 3/4] cgroup/cpuset: Don't fail cpuset.cpus
 change in v2
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
References: <20251225073056.30789-1-longman@redhat.com>
 <20251225073056.30789-4-longman@redhat.com>
 <dc9cd447-6431-46f6-b93d-fd2e317aa630@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <dc9cd447-6431-46f6-b93d-fd2e317aa630@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/25/25 4:30 AM, Chen Ridong wrote:
>
> On 2025/12/25 15:30, Waiman Long wrote:
>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>> until valid partition") introduced a new check to disallow the setting
>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>> cpuset.cpus value so that there will at least be one CPU left in the
>> sibling in case the cpuset becomes a valid partition root. This new
>> check does have the side effect of failing a cpuset.cpus change that
>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>
>> With v2, users are supposed to be allowed to set whatever value they
>> want in cpuset.cpus without failure. To maintain this rule, the check
>> is now restricted to only when cpuset.cpus.exclusive is being changed
>> not when cpuset.cpus is changed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 850334dbc36a..83bf6b588e5f 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -609,33 +609,31 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   
>>   /**
>>    * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
>> - * @cs1: first cpuset to check
>> - * @cs2: second cpuset to check
>> + * @trial:	the trial cpuset to be checked
>> + * @sibling:	a sibling cpuset to be checked against
>> + * @new_xcpus:	new exclusive_cpus in trial cpuset
>>    *
> Can we rename it to xcpus_changed?
>
> The current name new_xcpus gives me the impression that CPUs are being added.
> For example: if exclusive_cpus is 1, and it changes to 1-7, then new_xcpus would be 2-7.

Sure. I will make the change in the next version.

Cheers,
Longman

>
>>    * Returns: true if CPU exclusivity conflict exists, false otherwise
>>    *
>>    * Conflict detection rules:
>>    * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>>    * 2. exclusive_cpus masks cannot intersect between cpusets
>> - * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>> + * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
>>    */
>> -static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> +static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
>> +				      bool new_xcpus)
>>   {
>>   	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> -		return !cpusets_are_exclusive(cs1, cs2);
>> +	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
>> +		return !cpusets_are_exclusive(trial, sibling);
>>   
>>   	/* Exclusive_cpus cannot intersect */
>> -	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
>> +	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
>>   		return true;
>>   
>> -	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
>> -	if (!cpumask_empty(cs1->cpus_allowed) &&
>> -	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
>> -		return true;
>> -
>> -	if (!cpumask_empty(cs2->cpus_allowed) &&
>> -	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
>> +	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
>> +	if (new_xcpus && !cpumask_empty(sibling->cpus_allowed) &&
>> +	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
>>   		return true;
>>   
>>   	return false;
>> @@ -672,6 +670,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>>   {
>>   	struct cgroup_subsys_state *css;
>>   	struct cpuset *c, *par;
>> +	bool new_xcpus;
>>   	int ret = 0;
>>   
>>   	rcu_read_lock();
>> @@ -728,10 +727,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>>   	 * overlap. exclusive_cpus cannot overlap with each other if set.
>>   	 */
>>   	ret = -EINVAL;
>> +	new_xcpus = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
>>   	cpuset_for_each_child(c, css, par) {
>>   		if (c == cur)
>>   			continue;
>> -		if (cpus_excl_conflict(trial, c))
>> +		if (cpus_excl_conflict(trial, c, new_xcpus))
>>   			goto out;
>>   		if (mems_excl_conflict(trial, c))
>>   			goto out;


