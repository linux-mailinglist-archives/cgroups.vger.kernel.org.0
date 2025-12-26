Return-Path: <cgroups+bounces-12762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C99CDF0B9
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8BA3011A7C
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388D22126C;
	Fri, 26 Dec 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6bWDWCc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaeVBzda"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE241487BE
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766784427; cv=none; b=qddQU1GknTLP2Qm1hkfRFlzcihfIk+Dp+XHMErobaAxFL5Vfq1PaJ1eLGRur+baKl16aXKs8mALQvs7pLXNVVx7J9fCxc9BrbBIlyd/gUUIHO9UDGyfRPErRXH3FCSP03bYKp7psN1ZDuRMyU9k3GXGr+gSHr9YSnQFt5pcLvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766784427; c=relaxed/simple;
	bh=EVYVJsyRRz0shMqFnKsULoSUbGZk5zLkzZoCXi8IKXU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rJhmi+qvwWx7UIKlHO7VQIgveMYWQNKlbtIrHMUc3hAugHUONctS8iGb7pJxSOQbU0+YjnVJuXEfiFD/6TRKjaeDIRNRiwsvJL9Z/r0hjDzMOKzNFWFlkeR3uROjCGsWKnnUmt1TkRYH3S1t6MJWCxYzDh7E1jYns3Da724xYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6bWDWCc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaeVBzda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766784423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
	b=H6bWDWCcL8wVuFVqiMAzLJ0f3/CGvYQQI4S9cqR4a4Ehx2Cu5Mer3nxciKJ6/cBdtB6AeN
	B6VAd3yw09ukSys9l9QkXKWsFXrmJUT1wucPMS+tB2amtPprWYhb0dAsHPz23SLZiqFkSy
	e48ASbtcFo4/4F3jyYqngPWj94hDGb4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-HYvdIKaKNY-O6U4ztpnabg-1; Fri, 26 Dec 2025 16:27:01 -0500
X-MC-Unique: HYvdIKaKNY-O6U4ztpnabg-1
X-Mimecast-MFC-AGG-ID: HYvdIKaKNY-O6U4ztpnabg_1766784421
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88888397482so229350336d6.1
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766784421; x=1767389221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
        b=FaeVBzdam3yTjkRXFFvifhDtPNljjImA33hHnQmiEDX1zd8E0DJNrY8JMgRFaE8MXf
         HiOnCjJW0umymCr2Si/STRTaGPcDsBaAVPnZsWNp2FRrmK+skMY2tNL8C9ObYFVhqpCV
         mcm3WGJ5V8R45Un6bk/3NovUPjswl3E7x4bo7sdSGM/JzEWbIlrWliNSYztCmrtNhRCv
         GL04Bk3HDy2VRc7rZ+vRU4yxftmGgZJ4+e3uVhrTwcOu8NcEQlt1V6WVLsqsczoHB1jx
         lcgFIa/hoUUvBZYU+QkRHDD6e7NgURgMQ2k+UHoWrfKSZ5GtBdxySacFtk2uqNxp09iQ
         tn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766784421; x=1767389221;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
        b=ZXtj6DO77jU/3UwQb/OTOXtaLi1Mh8Yp50/Z8plPS8ZmtrMJNSNCJoYMN3dedvwMSi
         QbBfAYOOp9XVJmjK4ldQOuuUUY16/pbW3uBSfIIcdW76l7cEe3IIaq7snOO0xBJsEDwf
         WIXy5fgF7YXq4ay0Vg0pI6/zalcDFi65Ze1fS9zwbDpJmH2rg6Z3tomxRh9KUE1Q2Efp
         ZpPy9qotoXEpoRdwq0PmBcIl3/sLk4eDjMDwOR/QiBaqQvVvAJCpJfNsU4GUD1MCZtbr
         4Mr1W7180J1mDUt1NngHUC5c5qlthR6Nv5a4zvWg9mmP5gzslgZzwVmF0VzljG15bj7b
         qj5A==
X-Forwarded-Encrypted: i=1; AJvYcCVW4kC/h9gKEdTwyQ6+mmLMkX+Bw6/0cmQxdIBgZuVZKYfvDSq4TALtx671EEqv6HTklMf2+zg+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kju0Fy6/QAljnVRUx1E0gfoAoA+h7OpIAH/teWbeLPNKQizQ
	7QV0cE0B1CvYgLV+psnJvWe+CUsFXSZQgJpWy+q+IzeZjeXqOho+KiVgaWnIN+RV+friiXXtwX3
	WXXyxMWrk1oFHZHRWPi9sk5zpFyc+ckrMZhlopssjx0dyHT8YoWM5IDuGBw8=
X-Gm-Gg: AY/fxX7tItayAIyPWw1SxCu0cNjyxK+T+cfYCdngxvftJtT36OFvuPbubsL88QOen4n
	V2+a7hCPikgLCjN3felTi507yBYc6QTXDuWnNluLTazVWluWobNdyLx+ipOF3spIaMU10wUES7i
	N3j/fsogGeA0cOYe87CCfi6WiJn7A2e3FceG7y1elTG+9d3NP4JjWXlVSqOr62VmIBQkrmla/EI
	gouPMB9NTGMpd025sazZ64t1cOlgOY9cnBOp7XgaAq16qZrN0Mqp/wWh+n06cRWS08510DE7eMt
	ueTJHrYSU6LGapoWNT3M/rYGwh6y1mRGC6S1ux/l+nsXJIBBQtGVaVGFXbz+3eGuzqoyIcw5OWe
	P0pcuQw65Demp0QIg6WFy58P07AOJwpw2ItI5H77U16TB0z7VlKJvUyDR
X-Received: by 2002:a0c:fb45:0:b0:88a:529a:a530 with SMTP id 6a1803df08f44-88d82041773mr328947906d6.23.1766784420883;
        Fri, 26 Dec 2025 13:27:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfZAYYIQ2fUbZyPMB45iQArY9ihsQ/fJKmBvKtaCb5+ZXeC6tWw3vCNx5szpnr8D6LkXzAiQ==
X-Received: by 2002:a0c:fb45:0:b0:88a:529a:a530 with SMTP id 6a1803df08f44-88d82041773mr328947536d6.23.1766784420468;
        Fri, 26 Dec 2025 13:27:00 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa3ac8fsm175993226d6.56.2025.12.26.13.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 13:26:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bc573163-c5a8-4bb9-a280-45ca48431999@redhat.com>
Date: Fri, 26 Dec 2025 16:26:55 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
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
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-23-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-23-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> It doesn't make sense to use nohz_full without also isolating the
> related CPUs from the domain topology, either through the use of
> isolcpus= or cpuset isolated partitions.
>
> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
>
> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> alias) should always be a subset of HK_TYPE_DOMAIN.
>
> Therefore if a CPU is not HK_TYPE_DOMAIN, it shouldn't be
> HK_TYPE_KERNEL_NOISE either. Testing the former is then enough.
>
> Simplify cpu_is_isolated() accordingly.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 19905adbb705..cbb1d30f699a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -82,8 +82,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   
>   static inline bool cpu_is_isolated(int cpu)
>   {
> -	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
>   }
>   
>   #endif /* _LINUX_SCHED_ISOLATION_H */
Acked-by: Waiman Long <longman@redhat.com>


