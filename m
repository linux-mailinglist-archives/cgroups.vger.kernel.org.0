Return-Path: <cgroups+bounces-9630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48320B40D10
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A235E1DDD
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FFA34AB06;
	Tue,  2 Sep 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaDVq98M"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CC34AB07
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837298; cv=none; b=NPpYQ4YxEBBD8tO+ddxVjLhRXYIweKITFz8Rodyfw1OuWyw5t+rcz2KWp32LcbYdaoIB4N9X0Fg3FMq9sGhYq2ZnLHwyeWM0NrVw+VS1+GR33pQVPaBddaeBc4URA+BDnjg2CJoE/+hN+QHOJmZed+MTFSLDNPCq94fB+37newA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837298; c=relaxed/simple;
	bh=ujvP5ppYIq+mrTdhQyLILyCVzNShUHT9r5skpRwxy6k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ginYe159/63GBxlsRi9oVHIcrbBC0oO99mRBJjd12obbD+US7+SMpq8v92TOtvcA3S93LV2Z927yMec+HfYyGwdhghROcjXOirhpywUZbiVog1XOSG4/HgGYYW6llUZAi0Ec62jQVsuIHqalH4sISFJUtCduit7iBc6ukbaYjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaDVq98M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756837295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7RY1WsUY1lF18R/9EMCOt/PXAzdHUz71EA85shZ7EU=;
	b=aaDVq98MuIgtGes5mtIuHEiUb8ZCmOcicv0GQi37DAALx6HnwO9Fe1rIfhXrcMBd41tHsR
	ln0faB6YrWZeTUX4VMhiV5Q7gxa7eg9CgnxDKIQgzLMuOa++5KiCA+5ReoIKlBoPEBOgLU
	B5LTrtXH8vJZHsfV9bbdBpku+T7t1MU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-LTDmDzc6OSCNHydsB8O0sg-1; Tue, 02 Sep 2025 14:21:30 -0400
X-MC-Unique: LTDmDzc6OSCNHydsB8O0sg-1
X-Mimecast-MFC-AGG-ID: LTDmDzc6OSCNHydsB8O0sg_1756837287
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-806a4452050so158936185a.1
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 11:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837287; x=1757442087;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7RY1WsUY1lF18R/9EMCOt/PXAzdHUz71EA85shZ7EU=;
        b=kHE69czjPMlX9Ukr57kcIZ2VYTQcqc5bpdOxK60NLGHAJKs48WmCt8SoEPxl8ZgzKj
         VDzvUrOePg98gVoYeGeXKEqY655zt3hX5+9ynZTukiYco/b91B2waHup5PW4hKSif5ov
         qtBrJYwWXRxTctlyagqKbd2BlAOJrhpdBzl3rD/uxRu0SlUw+RtPKX/8IJpQLV0/Nreb
         QR0DL+Fy0ko8IW12bPi+3/pn/E1MKC3seyfD/mE4ysD7uLxhSNFV3t08aoAo4GZ4115k
         A1BS2yEaUp8m1He10t4TTjwOL4eFI5cmB6EoxF1MmDA+RCoB8K+qBNj1M/ZKwOb1fGtz
         EQ7w==
X-Gm-Message-State: AOJu0YymeFrEhIEK1k92t/QG9ALzstySDCLNofrxTEL6VlDOVy6Zlhpc
	PND6Yq9sH82OiYHhjPAEP0SW+BuDi2MOh+CVjxlBpvk8C34+C9ra2PgQBzeiOXavtZdhweBbpxL
	+Sjlim1/rv2Z2xB3shBeKPEcEkawN+pMhTC0UzHWRuUItIrwLYlwTNTpEXxA=
X-Gm-Gg: ASbGncu+yRUwcnViows2Xoi8dE+SU2jF4C/s/g1wwSkdSzrqRi7nMbwLZtQTFzXENDp
	ptPycgAwFE9TwVBrLOtzc4aYBcMM7RvyvRNnblB1yCl95e0FhhBNAi018jRdKDm9FDaxMOWHd4V
	VKXo4gU3xMY1KrXLFnSjoF4CMEKjISBbduLjSeET/cqD9OHtnlsVJyNmjYJcb/vJlR5b4AlQRiJ
	5y3TbW+Xj5BXdmBUIzNQftFnVF32HtDFY9GIyLPh/CNYRv50HUxbycQ8dDadKffz0DUWRXLa7j4
	kvFC6vbMfCaWZ/w4UnEKpybt9wToqDf4wJzP4xB+czuQw6eGcckTQQFCI5SILqWpIfrI7Y19gv7
	lVBYRSPfHew==
X-Received: by 2002:a05:620a:1a83:b0:802:6dc6:4f32 with SMTP id af79cd13be357-8026dc65a5bmr816925785a.78.1756837286767;
        Tue, 02 Sep 2025 11:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtHLm2OtG+zzbOosERCZVrDaqy0yh4F5L/NztF4x8PsJuHDw2CVmuA9sllL/wLi9X6VpZ5Mw==
X-Received: by 2002:a05:620a:1a83:b0:802:6dc6:4f32 with SMTP id af79cd13be357-8026dc65a5bmr816922985a.78.1756837286340;
        Tue, 02 Sep 2025 11:21:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-806975c37e5sm177580185a.10.2025.09.02.11.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:21:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <927f1afc-4fd4-4d42-948b-5da355443a4a@redhat.com>
Date: Tue, 2 Sep 2025 14:21:25 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
 <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Content-Language: en-US
In-Reply-To: <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/25 1:14 PM, Waiman Long wrote:
>
> On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
>> In cpuset hotplug handling, temporary cpumasks are allocated only when
>> running under cgroup v2. The current code unconditionally frees these
>> masks, which can lead to a crash on cgroup v1 case.
>>
>> Free the temporary cpumasks only when they were actually allocated.
>>
>> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
>> ---
>>   kernel/cgroup/cpuset.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 
>> a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 
>> 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>>       if (force_sd_rebuild)
>>           rebuild_sched_domains_cpuslocked();
>>   -    free_tmpmasks(ptmp);
>> +    if (on_dfl && ptmp)
>> +        free_tmpmasks(ptmp);
>>   }
>>     void cpuset_update_active_cpus(void)
> The patch that introduces the bug is actually commit 5806b3d05165 
> ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
> removes the NULL check. The on_dfl check is not necessary and I would 
> suggest adding the NULL check in free_tmpmasks().

As this email was bounced back from your email account because it is 
full, I decide to send out another patch on your behalf. Note that this 
affects only the linux-next tree as the commit to be fixed isn't merged 
into the mainline yet. There is no need for stable branch backport.

Cheers,
Longman


