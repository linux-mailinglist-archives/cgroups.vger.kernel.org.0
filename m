Return-Path: <cgroups+bounces-6826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9BA4E7FE
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A4E3BFF91
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FF24EA95;
	Tue,  4 Mar 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHyHEwAf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FF255237
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104076; cv=none; b=u2EyI2qMHE2mxnfoC6u4rTBw7D5mRI3b47VNugsTyB8DhDE3n6IBWcqdYDk+nGUAMQLmimRHVyvs7/A4l0O1fzn6ue8ZVjNNxAlxpRo1S2WtY77/ozHrDHvx3PY2l9gMfdD2PiIZbroKMbeMsJ0MFbu7+izsySa1NWsGV5afoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104076; c=relaxed/simple;
	bh=FYclQRW5qOKM3uda9/7c+NE0xSw7K7rC9el4vjYb+QY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MNfV7+st5UX/OfZSWKvhoa+RU+BEwbND3mDp680wrR0Vt6xaz48gdbAHLekNYfoG3hpVC76bbFajHrhbnV2kpLSMQ9sqCT/gm2JkEqIWCqnSc/n/fibHLkRWu2fIAUoKmWtFbB4mWYP0Nzs0XOgU6XBYywCTGBy5cxyE9jnH7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHyHEwAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741104072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrjcmiuE/a0WYPzM1Vs1HXuhCSj0v+fU7DwLGVL8lzg=;
	b=bHyHEwAfr59DRz11K+3BBBKJJaB/2McDhSbybQh7ojDJsYsxaKohRZOEw5WzdB44h5YDBY
	jvabLd6v5rS9+1dHhbBwrcgYm7KFiNT5i7IMrD6RoxZ42CUrWAOnb+vA5lejrZeYey9ahb
	nrdMemeDZtsGgRH2wEqP9tP7w+fosgE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-R-47OiGzOMSf4PTdRoSb1w-1; Tue, 04 Mar 2025 11:01:11 -0500
X-MC-Unique: R-47OiGzOMSf4PTdRoSb1w-1
X-Mimecast-MFC-AGG-ID: R-47OiGzOMSf4PTdRoSb1w_1741104070
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b53373f7so650114585a.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 08:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104070; x=1741708870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrjcmiuE/a0WYPzM1Vs1HXuhCSj0v+fU7DwLGVL8lzg=;
        b=BPWLapiOfSimk+DT4DjPrqIL9vhrRSB9OdrY1m+QjekMy5ZicgPKushTjLjf/PHSvF
         zWP3bG6YzyUObRXmQHEtG7YxuyIrSaPf9jHH+c+5V5V1eqs+8qlgXUYJNz2/5FrGE8Ry
         Fv5ZuiKJZ4GNXuWN/KLA9JiSzB+QYXkZhminV1hKJxzqqCIhdFZpgy8g4ckGJbsghKwS
         RhXI5zmAedc9qv0wUkIvDKwjcuc+G3g+mvYgC9QsSU1XLeJ8bxW3IiYOREDs/Ewv1ftW
         mc0ZxPEQIuO9nCS+pMNatpPNb3ZnXV41owAV0i0RUJGChg1parFCdZfEWK1cjh4iTxEX
         sz6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPn0GJrKxjWpKMY9pMjnwTItbEoktciisTY7VJXmT5G76xBdSAX1SaXRY4sS7LFVoJkTre6KND@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpC5d630LBPUEcuU069rfXdEfw/ggwOVFMvuKq2H8D0oQmeQ/
	dfrlY4nLfsSlBULcREvpUeXP/LQ3EEXEg5q2TgeKO4FdN35sqXGbI0kKR4m11PmD3u6hxDr6DC/
	pFJ/GFen+KgBu2JaNZlAPrVMzjCOKb4NpA+207NXYfIPR4njda/lQJhc=
X-Gm-Gg: ASbGncuS9RCwUas7PvGfOTyXpCN08lSohhCPZZ8DQNpPDGbKrGcIlZR2/IpOR+YApni
	3kltjW36U99zPzh3SSpib87KoaipFMaVr/9A683UvQt2oKfv5m1Mpr8zIf4IWxTBFv5d9JntghV
	JCJk7pSDhmnCGWGYlfXa6a7HHOySAiMPnHsN0/er9XTaKXL1LukSc40oCyLFCituMPTDwEFWsd7
	oNzhJVdz3rpYTOQy0g4WGPm4R81IpekcyNYrPF9YBmGm0QZ3K8G0GJnKfvRKx53z5UgLs+6Mj7k
	0haBiqQCfxAFmaGsZhEvebT4kvi25r/TjxSQ0Fof6Kfdmcre+MInuWDf8ek=
X-Received: by 2002:a05:620a:2621:b0:7c3:cfec:39e2 with SMTP id af79cd13be357-7c3cfec3ce9mr341170385a.52.1741104070543;
        Tue, 04 Mar 2025 08:01:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc4HXnFNztvW7EARLEgRj3YiE0qxm0boB8v7867SgoymPm/GNIxFOmiKNGytZyj04ASUctKQ==
X-Received: by 2002:a05:620a:2621:b0:7c3:cfec:39e2 with SMTP id af79cd13be357-7c3cfec3ce9mr341166185a.52.1741104070181;
        Tue, 04 Mar 2025 08:01:10 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9e2d5sm755254485a.68.2025.03.04.08.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:01:09 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
Date: Tue, 4 Mar 2025 11:01:08 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
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
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Content-Language: en-US
In-Reply-To: <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 10:05 AM, Waiman Long wrote:
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -6,6 +6,19 @@
>>   #include <linux/bsearch.h>
>>     DEFINE_MUTEX(sched_domains_mutex);
>> +#ifdef CONFIG_SMP
>> +void sched_domains_mutex_lock(void)
>> +{
>> +    mutex_lock(&sched_domains_mutex);
>> +}
>> +void sched_domains_mutex_unlock(void)
>> +{
>> +    mutex_unlock(&sched_domains_mutex);
>> +}
>> +#else
>> +void sched_domains_mutex_lock(void) { }
>> +void sched_domains_mutex_unlock(void) { }
>> +#endif
>>     /* Protected by sched_domains_mutex: */
>>   static cpumask_var_t sched_domains_tmpmask;
>> @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int 
>> ndoms_new, cpumask_var_t doms_new[],
>>   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>>                    struct sched_domain_attr *dattr_new)
>>   {
>> -    mutex_lock(&sched_domains_mutex);
>> +    sched_domains_mutex_lock();
>>       partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>> -    mutex_unlock(&sched_domains_mutex);
>> +    sched_domains_mutex_unlock();
>>   }
>
> There are two "lockdep_assert_held(&sched_domains_mutex);" statements 
> in topology.c file and one in cpuset.c. That can be problematic in the 
> non-SMP case. Maybe another wrapper to do the assert?

Ignore that as both topology.c and cpuset.c will only be compiled if 
CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP" 
above.

Cheers,
Longman


