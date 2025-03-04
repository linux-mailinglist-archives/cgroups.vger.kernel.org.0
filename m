Return-Path: <cgroups+bounces-6813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443BA4E4A5
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C770424AF9
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8212D27933D;
	Tue,  4 Mar 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/kSqW2V"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D324EAA5
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102445; cv=none; b=S3uzfKekT9BnqnJ5xuNFI8eT9UJ8Qr6CXETR6xZoiZL0OIC1tNJSik1qNwlqki0nr+Y5zFA25xmJhkf1wg4VvtgjU0w8lO1JtOCg2PfMe8/SL3TuQcXuRBHkN7tSd/uRW7KDP8+Ttcu6PbWccdeFRsqsS/fII2kVGaLH9n1Ifoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102445; c=relaxed/simple;
	bh=g9/2udOETvmToZrTCGb+qEZ+kSThEsu8wt6yi5lFMWo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kb7csIDhSoqK1qA1Vm/5OnP0muYzYHyQ3gWO9xviZQI46uGfANCOxiKEWnVlD/Jal0A6eJn50rbL7AyUililoC0kvJ8Hy5LTs6WGTYn+yyRRIbVcWl7EEYObUoW1gTI2NYzfcamfMjsIfUfSAadxDmDfwvBpgqNDkF1PkXm4iBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/kSqW2V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741102442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwJDnZ8tY9IELE2tx6CxJ71JiDXg4oK+AyaLx02RRac=;
	b=Y/kSqW2VKcLVjeF1hX+sTpe02S7O4unkNy/xPkUQKgd4aQZlm9h3MyMbXRKEZPp0IXtwEr
	oN9Ewxu9xM2W4NKHEUxI6ZYJHdvUDsQiuRvvfXLD97lcDZ44urw7bSOMH69fOkEFa3U61C
	8A+EmtWpzBRxngBokd4i0HSlRaSYzhA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-sLWG9srdOq-issg_nx4ZLQ-1; Tue, 04 Mar 2025 10:33:56 -0500
X-MC-Unique: sLWG9srdOq-issg_nx4ZLQ-1
X-Mimecast-MFC-AGG-ID: sLWG9srdOq-issg_nx4ZLQ_1741102436
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4721d9703ecso125608531cf.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102436; x=1741707236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwJDnZ8tY9IELE2tx6CxJ71JiDXg4oK+AyaLx02RRac=;
        b=LI8UPWlWg2tEhGPmwBZvY6Y5kTFOCYEnVjEnqAzhSIxqCjMp1UrHfHsLhv19KiAXHd
         gPBm1uzY7QxiieOpeFWFoE3K93Uh1C35qxD1NVmZ8UOFITQ1if830omTb/IaRRi32HAi
         5/YAmqcu9wv4cz9dBbkmRCgx4rJJRetn6FNUL9bk6nVS9GgCOIQQjf7fB5/noDSh8T2m
         F146DkS96g0acp7SC5729RFBKFLa3EOTa+LvU4xwc7fc6QMeUHV/AkmNWhJDfTBNzCrk
         4GmK1WSCWzsc67Db0UttTX6mTiKcM4lt2lIvaiGX2BuHjCNC/zcHz7y6GvocZsqLtFY6
         xnCg==
X-Forwarded-Encrypted: i=1; AJvYcCWwX9zbWHeYAPdL4bu64tRDkbWVaCldzVz24dhOa/ZfB++Q25UA6jVOyFe1Sp2nYC8j2SwiiKiB@vger.kernel.org
X-Gm-Message-State: AOJu0YyiP0Q7aF29VvarAm3XhEKmg6yQOz6CbSjNioPE7LVodF/KuT7G
	Y5QlvMfvQKL0hgUB41wcBvzRXUfKC+N1PVG/onGry81DWJS1Jw0NqgcMfQlyflprYSqD+nEyxvO
	gu60ad96LZDRhL+G9pwLuJo7+7KcQp8DH8HRbyS/UTanpSx6uJEVRx8Y=
X-Gm-Gg: ASbGncuiEgt9RjUygtOewNUrt9F2onjZY2o3nawYqYgpIDjrW3zEQAr+xmJL4ChzxRm
	213ZkWuQZsOVxKjhgYQk+aXeh7A+cf3+8Q+/ZcdXS0EXMIolFgrWVHRNfNSjvOzFwoKiwOq2ULD
	pmRbnIlkBvmQsxH+unJ6nG/rvnaPKJw46q40+7DK1/R2NhmHDT5HZnHvhKP5eVyCc8n3ybJ6QSi
	iRBIQcW0aKhBy9vwJKUuSWrI/PIjlvrSO93OwyK9AEnQOsaNR82nno9UtrU/WI836bpu6OK96hf
	ZLP24mge7ZmUfMZr/WXyTdx/lYf1E4SMxXEAOgbDjWdcEPeL70m1mqEQ7eE=
X-Received: by 2002:a05:622a:1825:b0:474:b753:e262 with SMTP id d75a77b69052e-474bc04731emr188722491cf.9.1741102435729;
        Tue, 04 Mar 2025 07:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/dfjVxJtyP8MAwXmEMza87tPVSQuOFN0UMpAqo6ILEemgvwl18p7DpTuFQl8dUDghKTziBA==
X-Received: by 2002:a05:622a:1825:b0:474:b753:e262 with SMTP id d75a77b69052e-474bc04731emr188722211cf.9.1741102435420;
        Tue, 04 Mar 2025 07:33:55 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a22f4sm74434221cf.5.2025.03.04.07.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:33:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a53c1601-81e7-439c-b0dd-ec009227a040@redhat.com>
Date: Tue, 4 Mar 2025 10:33:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
 <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Content-Language: en-US
In-Reply-To: <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 10:17 AM, Waiman Long wrote:
> On 3/4/25 3:40 AM, Juri Lelli wrote:
>> Rebuilding of root domains accounting information (total_bw) is
>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
>> is that the way we keep track of domain changes and try to add bandwidth
>> back is convoluted and fragile.
>>
>> Fix it by simplify things by making sure bandwidth accounting is cleared
>> and completely restored after root domains changes (after root domains
>> are again stable).
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow 
>> earlier for hotplug")
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> ---
>>   include/linux/sched/deadline.h |  4 ++++
>>   include/linux/sched/topology.h |  2 ++
>>   kernel/cgroup/cpuset.c         | 16 +++++++++-------
>>   kernel/sched/deadline.c        | 16 ++++++++++------
>>   kernel/sched/topology.c        |  1 +
>>   5 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched/deadline.h 
>> b/include/linux/sched/deadline.h
>> index 6ec578600b24..a780068aa1a5 100644
>> --- a/include/linux/sched/deadline.h
>> +++ b/include/linux/sched/deadline.h
>> @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
>>   struct root_domain;
>>   extern void dl_add_task_root_domain(struct task_struct *p);
>>   extern void dl_clear_root_domain(struct root_domain *rd);
>> +extern void dl_clear_root_domain_cpu(int cpu);
>> +
>> +extern u64 dl_cookie;
>> +extern bool dl_bw_visited(int cpu, u64 gen);
>>     #endif /* CONFIG_SMP */
>>   diff --git a/include/linux/sched/topology.h 
>> b/include/linux/sched/topology.h
>> index 7f3dbafe1817..1622232bd08b 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -166,6 +166,8 @@ static inline struct cpumask 
>> *sched_domain_span(struct sched_domain *sd)
>>       return to_cpumask(sd->span);
>>   }
>>   +extern void dl_rebuild_rd_accounting(void);
>> +
>>   extern void partition_sched_domains_locked(int ndoms_new,
>>                          cpumask_var_t doms_new[],
>>                          struct sched_domain_attr *dattr_new);

BTW, dl_rebuild_rd_accounting() is defined only if CONFIG_CPUSETS is 
defined. I think you should move that declaration to cpuset.h and define 
a proper wrapper in the else part.

Cheers,
Longman


