Return-Path: <cgroups+bounces-13089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D6D14A83
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1725730265A3
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52D35FF78;
	Mon, 12 Jan 2026 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/U0VGcp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3YoxmpC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F137F0FC
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240452; cv=none; b=GxZCfFaFKMv8pJgBTSGejmOHIG5b9yZIiuT/ryhlNgt5wKRXWCj2OG1ftQy+kUg0N5iV4ut5//CVDGUS3xaLVaP0DnpM7DwcHTMHex7+9/irN3wzPZgRj7Wu+uXNVVM8ktWfDFGhbkM9StnjSFhKgLPPbqQPhnN0AeOo+nP84TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240452; c=relaxed/simple;
	bh=69fqmCRd2Tf1nBFL5gD9s9xWKdbIFwrikt2C7UGqOuQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pzEE5j7sAODDq2tLg2JaB+ODcy1q95BCC/JGaGQN2ljDJ9QPDpqv3FfD23xYivEWuOwtEhTDxQw+/hgZdFAebn9yUsaftlxohIT6mexlhKJaRMmcu6rBoRRngzUpyqxJxwRAULA2lDZBRvnN+HciC62SFL+vuez0kgwPsqSoiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/U0VGcp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3YoxmpC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768240450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
	b=G/U0VGcp0CDOdjslhIwLMH2gfOnn+lgZFs97VD/EhmEElR/V+2Fm5/O6OdlpUpzAbeQZoT
	CB/EPgu+hLDWRciI0NA4J0dzmha14fSuwdrl41Jvf1VyLdZN4aHXL4ouBGCzUANZB2CWjm
	wKGEqVmiS2oE2VQinLdp7bTYEvu656I=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-MQTEzj4jPWiOWr2QsMn1jA-1; Mon, 12 Jan 2026 12:54:05 -0500
X-MC-Unique: MQTEzj4jPWiOWr2QsMn1jA-1
X-Mimecast-MFC-AGG-ID: MQTEzj4jPWiOWr2QsMn1jA_1768240445
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-94125ded3dbso19454413241.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768240445; x=1768845245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
        b=J3YoxmpCEw0QC/p5+ibRD4fsS7S1I+Bg8/jZv/NVs8qpd5ZexZNWKr18rhUkW3HiYF
         S4o3tVfkk6gTfzqp3560jEGnlPzaw4/FPXMi7qA1h91rjytJYTkMfQZBmZyi7j3uhzcp
         Xekxmim6/O0XSg1EIm2tWUpreRlFl4j6trkivAnq+MAC6Wy+k9bzUQa/E7LNGZeaUGLZ
         EsooXhJDSVZ7GN+bzuHFcYT6W1Fuwv3PGXPQuZwsmkAUU1iyTfBD3fYF0/avhxCPuj27
         TUYnOdpRq5VJWGArSdXdym9dZK3YP7iCZU2Nngd2Ou7kzOxwg20ruGTOBRMkwcsP/IYa
         ccuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240445; x=1768845245;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
        b=kuVeKStGVRh6sIp6na5gN7iUgmkZ48VW/oxv61A/mfRcwFj/2IEhE+/SfTGNC2AZTZ
         4dUOkaTVO0ydHFvldtUt4x1A2JoM4ImXhBj2k/bLoQBKGsvvxrZEuy+jz8yDMdWbHaLO
         hhehjEidmaJlvQtE6ZRy9DLO6xdcY2oo0KZc3Q4oJY1hMfLW0lTfdvs79Di9mvyKBZxk
         3wiEJ4Ma2YGQvWyS7kS5TXxXgUrEeJwhP51QjlOS5mlssjsNFL8c35QIX9l6d9nPHbF9
         V8/ZUZ4AmdVRxqs7YefOVF6rUjWOzw8pIVli52w+1zMbRaYWgpJaB9u5qkLbzbUadckA
         Qlrg==
X-Forwarded-Encrypted: i=1; AJvYcCWiIb3WMAPbsx8C2o2yYIdCcBaki0NcXiZTmp+MoPNbs32G9YBUTKxm74swIifh/AN8EWr4u507@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpUJ0r5u1g7T4+4DlR/l9XtouLnwoJ6c+EAiCxNFLdvSZ3zrr
	XHb9arnv4KTAbDi3f8SL+z/OqNBzSXDM0r+O7vahhd6jMi6Ib/20XfEyYLMZbMIAxueiGPoBVZN
	b/mxzO5Chzqyga94j6O4afpSH5uQL5D5jY2nSmlcTD7Wp3OVNS87b8lotwv0=
X-Gm-Gg: AY/fxX7tJkISqmS5tUo8jFokrvLdttKh2EVT6kt+61Cvso5tGmnKiS62rF3g0JkxYON
	BAGggEtMWK1zNlL0uMWPvuI5svJ1Hep2NOCpNYoTdDQQrZuknBAuws2ES7jVSsXTDznSx9Neuro
	IWC50tgf/+d29dO/S4z0vxdZXZbzA3krnVkkKANEONHgECh4PpJfEHzB28L+Px/uAXerKcyemz0
	AjRoNcbCAHYp5pW6jWatXyOvG+Aya1eHLVaAjIwG9OXau6wTgcAIvKUC/nPbWegLFOUGpIhMsIU
	qyL7a4yM+Dwv367v+6/cwR/SbsUATs7V0sa9q2tL1Rhu0VI2IHwPveC8MgH0g2o/kvYhZQw5G6h
	6AgwqX8q6DBUu7+Am3EW6w0+3D/rx01icX9y2alrkTZt4pwjk2S1DFt/7
X-Received: by 2002:a05:6122:4f88:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5638335b3d9mr1837504e0c.19.1768240444524;
        Mon, 12 Jan 2026 09:54:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxwLoMJ4ylgMx4yokJUFTrQvglGoUK2cQ8cuwE9wOBcOJlyALmmG0hMGzOjgHwYtiz9Ob2mA==
X-Received: by 2002:a05:6122:4f88:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5638335b3d9mr1837491e0c.19.1768240444039;
        Mon, 12 Jan 2026 09:54:04 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5634ca16da7sm15469803e0c.17.2026.01.12.09.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:54:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f8ca375e-9051-4c7c-880d-e56e07206788@redhat.com>
Date: Mon, 12 Jan 2026 12:53:49 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] cpuset: Provide lockdep check for cpuset lock held
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-13-frederic@kernel.org>
 <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Content-Language: en-US
In-Reply-To: <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/26 8:43 PM, Waiman Long wrote:
> On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
>> cpuset modifies partitions, including isolated, while holding the cpuset
>> mutex.
>>
>> This means that holding the cpuset mutex is safe to synchronize against
>> housekeeping cpumask changes.
>>
>> Provide a lockdep check to validate that.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/cpuset.h | 2 ++
>>   kernel/cgroup/cpuset.c | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index a98d3330385c..1c49ffd2ca9b 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -18,6 +18,8 @@
>>   #include <linux/mmu_context.h>
>>   #include <linux/jump_label.h>
>>   +extern bool lockdep_is_cpuset_held(void);
>> +
>>   #ifdef CONFIG_CPUSETS
>>     /*
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 3afa72f8d579..5e2e3514c22e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -283,6 +283,13 @@ void cpuset_full_unlock(void)
>>       cpus_read_unlock();
>>   }
>>   +#ifdef CONFIG_LOCKDEP
>> +bool lockdep_is_cpuset_held(void)
>> +{
>> +    return lockdep_is_held(&cpuset_mutex);
>> +}
>> +#endif
>> +
>>   static DEFINE_SPINLOCK(callback_lock);
>>     void cpuset_callback_lock_irq(void)
>
> The cgroup/for-next tree already have a similar 
> lockdep_assert_cpuset_lock_held() defined. So you can drop this patch 
> if this series won't land in the next merge window. 

Sorry, the other new lockdep API isn't exactly the same as what you 
propose here. So it is not a replacement for your use case. Sorry for 
the noise.

Cheers,
Longman


