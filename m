Return-Path: <cgroups+bounces-7388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F7A7E281
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02E4188BDC6
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C391E5B80;
	Mon,  7 Apr 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fv3CaEMu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB01E47DD
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036576; cv=none; b=Jr7Tns/3eO2ibY49M5w4YJbnOKe5BP2Lq/JaT29fLBN8bxgRwqtIAZdYAVoHT2zowHNonMAdH8Hxq9QSNGvuFMpY1nIHu1cxjpEGBMyte14s3p76ptS2wP+iTGPGO8xPTNYMKSIrGO1F+kBarBbK6TJqvJpbpIaC0k2whKX2R/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036576; c=relaxed/simple;
	bh=cGNyz+WOFZZfNQEOkJkIG2uYIRO4WjMsJbUDGsYid5o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NLoo25v9xPW71kC/VVqQmB89FeCGx8l545xKwPeV22G/EGACJVoXbhoGIxpRFRHZ+qdMR5Vcnq/t87H172J0ery0H/e7cNUHjS/LwvPL+dK6ldAzdGCUpUcY4IbKAVL2sak5o03Drzn/hLulYCXb6bzRKhOfyAZNpxAvSvHKIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fv3CaEMu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744036572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5DJg/Yndiod0rCSXdIIJltN9dcYDMLjV18CCekaRB0=;
	b=Fv3CaEMu5AoWxNsjhCbLoFNK8hSvcYPMQtwyghXW8cfNRwF6OmJq/657OYClpa8W1bmQI6
	MrKjl7UkyD23yPE/bq9+bGOqCzzHzC6NDr5zvVlpG3c+lRV2hyL9qxhbkrlgPOqnWpJH3h
	HmOGfyWZ8++8Rwo1nveHv+tVFiG9MqQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-2BMLIs-2PUqc8J-HUh9jAQ-1; Mon, 07 Apr 2025 10:36:11 -0400
X-MC-Unique: 2BMLIs-2PUqc8J-HUh9jAQ-1
X-Mimecast-MFC-AGG-ID: 2BMLIs-2PUqc8J-HUh9jAQ_1744036571
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f184b916so114733586d6.3
        for <cgroups@vger.kernel.org>; Mon, 07 Apr 2025 07:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036571; x=1744641371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5DJg/Yndiod0rCSXdIIJltN9dcYDMLjV18CCekaRB0=;
        b=QkBqHSa40KRDvwEoQAi8lgc2DRL3w3Cz5DnhFXkDSfRQDYbmdH6mV9Xy5C7W3EjtI6
         nIZSSmpbz7ZG4VzGBejfLeRX15AdgGvCvehsWVfEoEtu/BAsSCP/ltu6+0NOx9qjWZaI
         vmR7S8edEfdNqP4fv1scLQdlNsJ8LJZsNnp9tKbyR/LVFKnsAOdNg2xzp+eHz4EtCcay
         vZ7Lx385pGkvIaIxOjXoP6GbJECeR6o/+Qyj2J0nroG57YLRYRaJedrs7fd55GdxRVZT
         lCIXnBd7CcXE5CVR2D6aljUhn767BQPUhale2DPM1LgexGlQCYgZcTLFUzV7nf7W3IEh
         /zfA==
X-Forwarded-Encrypted: i=1; AJvYcCUDAqagaviBFjPCEm5cezRkDAbv2S4zHV6uE9W8zx/0wlfrm1/A3QwSvDeHLd2TEn55128Ja8wy@vger.kernel.org
X-Gm-Message-State: AOJu0YysQa5BDTLuHR1HTEC1anProYhl9F7+lgnDqAz1EricreeXMr3m
	KucdJjdLSG6g1dWfFK/ZA1bFjHbpm0Pa1LW0umNaL+bU2UC7trussbfqJkvOz9tLRnwCooOS8Ju
	lAlhdqSAEnziPS6wn/R3aOg/cFndqFPTOyBjcP/vi4urI6a8whOFaZPs=
X-Gm-Gg: ASbGncs5+qxwQBeuOS4kgv4Xk79VFxbGGZGIVhYzvka3SePld1J24m+BziqNs+dxTGK
	qW/f3yAZieujsYQWBg4V9YXPN2qY8SzBmwa5a2p7d5eUKV/TKF868ltZ0afgtpYpbRyrRe0Jy3B
	Pt5Qb6PwWg0tbQpGSLRLH0OfX8WofPxnY+SlMvxp80UBfDIdj6/u5wF02LuuuVC77qcz9hOx7GK
	CRK4fR+uQ+xro+4EpDKRD9yCmkzS9wwgjy/NxXQD3nDXST3GVs8+CPlgRp6BiAO75YzUZoDNb94
	72f80Q6yY2/NLOFy2Estu7PUcjdd+4DzyMYAE4q4OBcoS5lpVqhgZU/pZKqVqA==
X-Received: by 2002:a05:6214:5189:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6f012e1adf0mr219540336d6.25.1744036571320;
        Mon, 07 Apr 2025 07:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBjeFW6/Zy3PCGjK+e4ng1QFrOqWTfMoNnO69ymICNu5TBJyk/4flMbpzGbuBr1A3OzyWJBA==
X-Received: by 2002:a05:6214:5189:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6f012e1adf0mr219539506d6.25.1744036570672;
        Mon, 07 Apr 2025 07:36:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14cf41sm58909196d6.105.2025.04.07.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:36:10 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2d50bccb-9cb9-4f28-a8a6-116b2003acd2@redhat.com>
Date: Mon, 7 Apr 2025 10:36:09 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250407014159.1291785-1-longman@redhat.com>
 <20250407014159.1291785-2-longman@redhat.com>
 <20250407142455.GA827@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250407142455.GA827@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 10:24 AM, Johannes Weiner wrote:
> On Sun, Apr 06, 2025 at 09:41:58PM -0400, Waiman Long wrote:
>> The test_memcontrol selftest consistently fails its test_memcg_low
>> sub-test due to the fact that two of its test child cgroups which
>> have a memmory.low of 0 or an effective memory.low of 0 still have low
>> events generated for them since mem_cgroup_below_low() use the ">="
>> operator when comparing to elow.
>>
>> The two failed use cases are as follows:
>>
>> 1) memory.low is set to 0, but low events can still be triggered and
>>     so the cgroup may have a non-zero low event count. I doubt users are
>>     looking for that as they didn't set memory.low at all.
>>
>> 2) memory.low is set to a non-zero value but the cgroup has no task in
>>     it so that it has an effective low value of 0. Again it may have a
>>     non-zero low event count if memory reclaim happens. This is probably
>>     not a result expected by the users and it is really doubtful that
>>     users will check an empty cgroup with no task in it and expecting
>>     some non-zero event counts.
>>
>> In the first case, even though memory.low isn't set, it may still have
>> some low protection if memory.low is set in the parent. So low event may
>> still be recorded. The test_memcontrol.c test has to be modified to
>> account for that.
>>
>> For the second case, it really doesn't make sense to have non-zero
>> low event if the cgroup has 0 usage. So we need to skip this corner
>> case in shrink_node_memcgs() by skipping the !usage case. The
>> "#ifdef CONFIG_MEMCG" directive is added to avoid problem with the
>> non-CONFIG_MEMCG case.
>>
>> With this patch applied, the test_memcg_low sub-test finishes
>> successfully without failure in most cases. Though both test_memcg_low
>> and test_memcg_min sub-tests may still fail occasionally if the
>> memory.current values fall outside of the expected ranges.
>>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/vmscan.c                                      | 10 ++++++++++
>>   tools/testing/selftests/cgroup/test_memcontrol.c |  7 ++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index b620d74b0f66..65dee0ad6627 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5926,6 +5926,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>   	return inactive_lru_pages > pages_for_compaction;
>>   }
>>   
>> +#ifdef CONFIG_MEMCG
>>   static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   {
>>   	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
>> @@ -5963,6 +5964,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   
>>   		mem_cgroup_calculate_protection(target_memcg, memcg);
>>   
>> +		/* Skip memcg with no usage */
>> +		if (!page_counter_read(&memcg->memory))
>> +			continue;
> Please use mem_cgroup_usage() like I had originally suggested.
>
> The !CONFIG_MEMCG case can be done like its root cgroup branch.
Will do that.
>
>>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
>>   			/*
>>   			 * Hard protection.
>> @@ -6004,6 +6009,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   		}
>>   	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
>>   }
>> +#else
>> +static inline void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>> +{
>> +}
>> +#endif /* CONFIG_MEMCG */
> You made the entire reclaim path a nop for !CONFIG_MEMCG.

Yes, that is probably not right. Will fix that.

Cheers,
Longman


