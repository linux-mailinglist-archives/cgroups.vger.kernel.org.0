Return-Path: <cgroups+bounces-11558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92593C2F437
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 05:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F95D4E6F76
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65626CE3B;
	Tue,  4 Nov 2025 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODEBl8gn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="StRmYwoE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564081F95C
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229447; cv=none; b=pY7EXr+spcdWyitdxXh6p/PF5+YEM9ITUP3ekGxp4fKA2pHbErVZiaHEhrucjkyC+jrxBz+r9X/IbUVSKDP7Jk0PtgWpkFxAY6p+UZ+1Oksy9q9Qkq50yqk+HyahAa+oJ2SFhBYqPHJf5z51mDTIdUyal0rcLqJ3vkA1LRyBbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229447; c=relaxed/simple;
	bh=LNbJ3yf0aC8xMTCcNLnDlbiEuOZI0ql9+sZXsUtOIIQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ODKBgkA7zHyCJSlT5p2Lx8XxLFBf1/VCo+tb4aU//IABMKE6e1kQo0WfuMSKg/bCxGMn7W/J3YdGwSjn8mu3LCh1YJGwoJU/mf8PupkRwlPof73ADe89/3jw56RRKjmN+DE7IkcaWrB83if4Yd/5TeolM2Pfa4xWnhdJRFhlpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODEBl8gn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=StRmYwoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762229444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3Rt74wtZQOmwVW2oBCntRpXctW+t+5prr7cQeuEVkw=;
	b=ODEBl8gnMkbn60qmJWfGLE0OUREUGUnswyEv5k6XO7RN184/40kO1aN5RyhnmI1ZkT/UEp
	E19Sg2yyJrP4P6EYzwynBh2S7tP9RDD0mXEpyxxj3LQPIfggKkEUAwU8iVFGI4KFlkePXf
	2pHDRQpUBcQJYwfD+Ov+y8IYLHFE5zs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-1yFLPjYhNsOpR56AE5phlA-1; Mon, 03 Nov 2025 23:10:42 -0500
X-MC-Unique: 1yFLPjYhNsOpR56AE5phlA-1
X-Mimecast-MFC-AGG-ID: 1yFLPjYhNsOpR56AE5phlA_1762229442
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87a0e9be970so156420196d6.3
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762229442; x=1762834242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x3Rt74wtZQOmwVW2oBCntRpXctW+t+5prr7cQeuEVkw=;
        b=StRmYwoEsvFQLijoBEJHeOD0QJBjcBuwchB1x7sF2h78ExBiFlSnzzgwZKbQJKEfvP
         2Fy83cZwHQGzUI4UK1PE06yam+0T0SVu4FjaF/rTRwcz0HhaCm4+nkdMY+OcilKR7YNS
         r2RuJBhQvpvPKo6SQzlkfJfYmXFlVO8PD4Q+O4a/OIVhMb5kXkIroTqGNMKuwvHSz3Tn
         pUunglbD+x0tw+5OzoYv9ZCtWikEFFOFYDbfyt4WJKs6bz8y5Qs/Fxw00lNUbSESxEWr
         HoOU7miXN0Pb2+iNBmULE5GqEnA0rcY1TXXHSSUWjz+iFsL4rWr1yST09V0PB73/3rnu
         19zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762229442; x=1762834242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Rt74wtZQOmwVW2oBCntRpXctW+t+5prr7cQeuEVkw=;
        b=UE9f1g7q6VVfFNTfOBbq5SkMt/XoNCl4mC9zq5H0IocJrfvVO3lv9m3d6pfIx1yZgl
         kbZdvTIh/PJu/qiq7ABCQ2ETtyOxGT7jJO2oSS+IcewAcLcg+eiA9wTnpYt1ytvvYDdl
         KF4veweeDfqw8QG0JqWHLg0vhrbyPDgLP721mmnyyO9Pb3r9+sLInTbd8p0TnQo97v0l
         dkVwhXqrmfZIS9my0axuDAGpCdJhRfhwe+/2qDEefDACIsvL1qzXXJaTeELpyRcBvtFY
         F4JQqef5HJIcX0qmYw9R1euMjCCSXyVlLJbBY4Cz+zlmo9Dlv0Pg95JfQAd006vZLGFU
         hSCA==
X-Gm-Message-State: AOJu0Yz2EGgSfytO/Rsdzab4YylFYpuOm8NVCpBAX7hd6zetEEzhSyfu
	O/X436tTpLhMJM/Y8BB3+DQRwVe4kjREvUJr8xwHPyepB5qAj8/m1YagqzQ/xLJplwSJiHPJefP
	YsXbKG8On9PXsLOsR17xZbik8rVu9YsRBg3eHs9oH4+q1OW+L3R1F3zUf0sY=
X-Gm-Gg: ASbGnctYO5OQbJF7dzQaI16YR7tti2fUisX/hCF+xgK3sT859vfl7tcwF0+3sa1ejgx
	9tK8Gmf9SjjnuQbhPbPlP6R2bxXv583oydC3keF9edsaKrvpkKnwwrEC4l7K8aO29Yy9bmVjAbp
	MIyhUxLUx6FTBhK2ZetOh8Hx5UIVX5CFfUS2bnd6MmhMes21NYk2GjG0qsQMo7k+GhD5MEzjAma
	Lt7sJ7/yvk0ZbBIELBCS74iSEP4gkOMvjyydnUjYSGjiVK65/Tu+OAA9igWxDa+UP7sGksfHjHm
	1X8kiEHwU3WBalFIgfPMZ8s7bSEc72TFdydi9bIEmFGvENGFmjF9wjB4R2H6G3bCvN4x2EtTCII
	YcEgWLUZ0qNfuduTd482ZDrhM7KD+qlZmT42JSD/+ZscuyQ==
X-Received: by 2002:a05:622a:30d:b0:4e8:a5d6:707b with SMTP id d75a77b69052e-4ed30d91a0fmr192728771cf.14.1762229442309;
        Mon, 03 Nov 2025 20:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYPBjz5v15/Ez+BV7MsRKZPqaLP7BNztBU2I5f58YjB4DiBL+C+W6Tui/Hq/7i0hrd+msAXg==
X-Received: by 2002:a05:622a:30d:b0:4e8:a5d6:707b with SMTP id d75a77b69052e-4ed30d91a0fmr192728531cf.14.1762229441843;
        Mon, 03 Nov 2025 20:10:41 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5faf6038sm10003881cf.11.2025.11.03.20.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 20:10:41 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d6fd5e9c-d302-43db-ac89-7b09ab0770be@redhat.com>
Date: Mon, 3 Nov 2025 23:10:40 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH v2 2/3] cgroup/cpuset: Fail if isolated
 and nohz_full don't leave any housekeeping
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251104013037.296013-1-longman@redhat.com>
 <20251104013037.296013-3-longman@redhat.com>
 <c4fc973a-e142-4b29-b41f-366d93cdfd0d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c4fc973a-e142-4b29-b41f-366d93cdfd0d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 9:19 PM, Chen Ridong wrote:
>
> On 2025/11/4 9:30, Waiman Long wrote:
>> Currently the user can set up isolated cpus via cpuset and nohz_full in
>> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
>> domain isolated nor nohz full). This can be a problem for other
>> subsystems (e.g. the timer wheel imgration).
>>
>> Prevent this configuration by blocking any assignation that would cause
>> the union of domain isolated cpus and nohz_full to covers all CPUs.
>>
>> [longman: Remove isolated_cpus_should_update() and rewrite the checking
>>   in update_prstate() and update_parent_effective_cpumask(), also add
>>   prstate_housekeeping_conflict() check in update_prstate() as
>>   suggested by Chen Ridong]
>>
>> Originally-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 75 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 74 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index da770dac955e..0c49905df394 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1393,6 +1393,45 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>>   	return isolcpus_updated;
>>   }
>>   
>> +/*
>> + * isolated_cpus_can_update - check for isolated & nohz_full conflicts
>> + * @add_cpus: cpu mask for cpus that are going to be isolated
>> + * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
>> + * Return: false if there is conflict, true otherwise
>> + *
>> + * If nohz_full is enabled and we have isolated CPUs, their combination must
>> + * still leave housekeeping CPUs.
>> + *
>> + * TBD: Should consider merging this function into
>> + *      prstate_housekeeping_conflict().
>> + */
>> +static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>> +				     struct cpumask *del_cpus)
>> +{
>> +	cpumask_var_t full_hk_cpus;
>> +	int res = true;
>> +
>> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
>> +		return true;
>> +
>> +	if (del_cpus && cpumask_weight_and(del_cpus,
>> +			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
>> +		return true;
>> +
>> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
>> +		return false;
>> +
>> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
>> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
>> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_active_mask);
>> +	if (!cpumask_weight_andnot(full_hk_cpus, add_cpus))
>> +		res = false;
>> +
>> +	free_cpumask_var(full_hk_cpus);
>> +	return res;
>> +}
>> +
>>   static void update_isolation_cpumasks(bool isolcpus_updated)
>>   {
>>   	int ret;
>> @@ -1551,6 +1590,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>>   		return PERR_INVCPUS;
>> +	if ((new_prs == PRS_ISOLATED) &&
>> +	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
>> +		return PERR_HKEEPING;
>>   
> Do we also need to check prstate_housekeeping_conflict here?
Right. I missed that. Will add that in the next version.
>
>>   	spin_lock_irq(&callback_lock);
>>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>> @@ -1650,6 +1692,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>>   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>>   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>>   			cs->prs_err = PERR_NOCPUS;
>> +		else if ((prs == PRS_ISOLATED) &&
>> +			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
>> +			cs->prs_err = PERR_HKEEPING;
>>   		if (cs->prs_err)
>>   			goto invalidate;
>>   	}
> Ditto.

prstate_housekeeping_conflict() has been called earlier via 
validate_partition() from partition_cpus_change(). We don't need one 
more check here. However, I forgot that enabling a partition will not 
call validate_partition().


>
>> @@ -1750,6 +1795,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   	int part_error = PERR_NONE;	/* Partition error? */
>>   	int isolcpus_updated = 0;
>>   	struct cpumask *xcpus = user_xcpus(cs);
>> +	int parent_prs = parent->partition_root_state;
>>   	bool nocpu;
>>   
>>   	lockdep_assert_held(&cpuset_mutex);
>> @@ -1813,6 +1859,10 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   		if (prstate_housekeeping_conflict(new_prs, xcpus))
>>   			return PERR_HKEEPING;
>>   
>> +		if ((new_prs == PRS_ISOLATED) && (new_prs != parent_prs) &&
>> +		    !isolated_cpus_can_update(xcpus, NULL))
>> +			return PERR_HKEEPING;
>> +
>>   		if (tasks_nocpu_error(parent, cs, xcpus))
>>   			return PERR_NOCPUS;
>>   
> I think isolated_cpus_can_update check should be also added to validate_partition function.
>
> If deemed necessary, you may consider applying the patch below, which reuses validate_partition to
> enable the local partition, so validate_partition can be common block.
>
> https://lore.kernel.org/cgroups/20251025064844.495525-4-chenridong@huaweicloud.com/

I do think your patch series will make that simpler. You can certainly 
update your patch series to include that additional check into 
validate_partition().

Cheers,
Longman


