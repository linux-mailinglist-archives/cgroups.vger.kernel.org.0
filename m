Return-Path: <cgroups+bounces-10907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C7BF48AB
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 05:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DD6467DF1
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 03:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E01246798;
	Tue, 21 Oct 2025 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvboJjdm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC01EBA14
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018604; cv=none; b=bc0aYD4w2fhcGUF6bdKDV2WQSztlljpbN2W7BJXbyOymuR3ehZya44HytqC56EE7Nz0MsgblzWVy1G0aXSl1pDRMfvmGB2NwnKQt7Jqa5Ca8Rjs/GwghhUjv9sIjiPllJIJKTvZvqJ7YiIBSd/1saYg2qIPHPLrTysN8sKghDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018604; c=relaxed/simple;
	bh=5wHRWII5YqV0H1234MXs40PJ+FJPQo2Fuwf1/Zu6dL8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Al8O0CZNGFZb3H84h7Uyug8GuRWz2AkhzlhpWJVgUiyFho8OaJeZqd723BltWMCZQXQH/xezJsKfCTU1dsSRvHEKgzQZcJxL9f+zAiRIGY6Tx1UB69B64NXx9GA7kLHfhcfs7zKlrSF3w3a2snzSOkaUVoRzLgVkk4kpRwgWVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvboJjdm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvtwqFSdwBIJ1DhFupvj6yUOG7znXFLvI8hL6gZ8038=;
	b=XvboJjdmIihWo7+/gD2ilhJTaBrTcn4A0qwoTl5RF4qI9zYm+3/je/YNW7YUIP2I34iRjn
	gDX6kL8qArUK7ieyziZVn0ntJsNbgeGbKQx/Kbu+rLA31+vX+22uC5dOACrdCRl2++un2c
	Ukw3O8ZRzLKCWRwaJEdFW91baLwkivI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-XXEtiaYtOPeEpq3r2sh99g-1; Mon, 20 Oct 2025 23:49:59 -0400
X-MC-Unique: XXEtiaYtOPeEpq3r2sh99g-1
X-Mimecast-MFC-AGG-ID: XXEtiaYtOPeEpq3r2sh99g_1761018599
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81a8065daf4so93658566d6.0
        for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 20:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018599; x=1761623399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvtwqFSdwBIJ1DhFupvj6yUOG7znXFLvI8hL6gZ8038=;
        b=BBktX+h84pbHACvFpYo8tUlNDYmZ7Q7sHMF1O3AoJgPCL8GRFwD3xQlJKzMjdUsB5A
         OCUcGV/kgkLXCUelorb+tThpFIKjlyMmy5X3NFQnRvS0Ywznu9KPpG4iOUUzJO+32zLy
         1AiFaozPEX4RRkAE558lwKauMBVvo83p9IPZcXbm7JlHph12ieSunloao7ugx2aT2Zcr
         aQLzSIENSUTqB86CwXMkbVWljHk9j5ao9ZTtYLtietv3tttTf6SXLgf/p9NkuClc+fmj
         i/bP6a4UrZeCLbljkFqrKKDZQJlDYJuXdgS0thNNg3SpY3VRdnU2WnQtCP9zURpJB6GV
         383w==
X-Forwarded-Encrypted: i=1; AJvYcCVmrDk3HF25t3zU7TL6CQGIjc3Wo/SfPQVfr5csJ7PillU54w5jK559eURoI78lJ4Fjdoo6T5HN@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfWDNzZo289+YGSqgeZ/OhJrNrl5QxJLt3QORqLjmNqEAec+K
	80vPFLNOdQowqGmiaTC5V0fu356hIJtRoVsWyj7P+xwjyI32QdlIMbrtiU73aikxeF++VAjXyZ2
	zK/vKH2HGlEbclcHDDQ27OzVKv+dNdNm+ukm2I/gVsBcAl2FRgPcYzuYjEFw=
X-Gm-Gg: ASbGnctMoXuhsVdRKu0PalVgf75HZWVLE8YICFsT+yF43gyTilqlnEY4HM+s6sTsbeN
	DYgQA51SzC99QcigT0EqlZfeWJg0+sgnTMOMFG0rvp89TL+e7FUwLLa6JEEQq6+mXVvTkGg6MDt
	Q3n7VKRtGY32ogk46DHwfnKZB/Eiu9jrfTeeVHjtBWiNoK+qhY7msdGSKLV0RjNj0tzpWMgsXI5
	AlqeYXPt4FAAavDC8q7nDUbu7gnshflu4acBF+yElSK6/VGnMHFaxqSZ4LdAa0YyLSRc7UDlrws
	L2iZp4go253D83gBD+4WArvXiLLvTBYCzzV/DGVdE1d0myXn3/wKimPbG4UNOqNGiMPSzV1lNzK
	yBBuc66T5aeiHbJHY3q9gxNfp2v1aDn/u1Jno3nnFnGv2wA==
X-Received: by 2002:a05:622a:14d1:b0:4e8:ac66:ee45 with SMTP id d75a77b69052e-4e8ac66f422mr138856611cf.43.1761018598807;
        Mon, 20 Oct 2025 20:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYxTQpPj871EoIMw1y246oGNNWS2hGT92x0DCSyPVsnjuqhhKKjEAvaY7EAUAoH4h5eayPQ==
X-Received: by 2002:a05:622a:14d1:b0:4e8:ac66:ee45 with SMTP id d75a77b69052e-4e8ac66f422mr138856231cf.43.1761018598358;
        Mon, 20 Oct 2025 20:49:58 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd6717desm684147885a.26.2025.10.20.20.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 20:49:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <083388fb-3240-4329-ad49-b81cd89acffd@redhat.com>
Date: Mon, 20 Oct 2025 23:49:53 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-13-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
> A synchronization mechanism is then needed to synchronize the updates
> with the housekeeping cpumask readers.
>
> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
> cpumask will be modified, the update side will wait for an RCU grace
> period and propagate the change to interested subsystem when deemed
> necessary.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>   kernel/sched/sched.h     |  1 +
>   2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 8690fb705089..b46c20b5437f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>   EXPORT_SYMBOL_GPL(housekeeping_overridden);
>   
>   struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>   	unsigned long flags;
>   };
>   
> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +{
> +	if (static_branch_unlikely(&housekeeping_overridden)) {
> +		if (housekeeping.flags & BIT(type)) {
> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> +		}
> +	}
> +	return cpu_possible_mask;
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> +
>   int housekeeping_any_cpu(enum hk_type type)
>   {
>   	int cpu;
>   
>   	if (static_branch_unlikely(&housekeeping_overridden)) {
>   		if (housekeeping.flags & BIT(type)) {
> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
> +			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
>   			if (cpu < nr_cpu_ids)
>   				return cpu;
>   
> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
>   			if (likely(cpu < nr_cpu_ids))
>   				return cpu;
>   			/*
> @@ -59,28 +70,18 @@ int housekeeping_any_cpu(enum hk_type type)
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>   
> -const struct cpumask *housekeeping_cpumask(enum hk_type type)
> -{
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return housekeeping.cpumasks[type];
> -	return cpu_possible_mask;
> -}
> -EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> -
>   void housekeeping_affine(struct task_struct *t, enum hk_type type)
>   {
>   	if (static_branch_unlikely(&housekeeping_overridden))
>   		if (housekeeping.flags & BIT(type))
> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
> +			set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> +	if (housekeeping.flags & BIT(type))
> +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>   	return true;
>   }

The housekeeping_overridden static key check is kept in other places 
except this one. Should we keep it for consistency?

Cheers,
Longman


