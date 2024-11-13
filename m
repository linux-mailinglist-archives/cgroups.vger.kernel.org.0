Return-Path: <cgroups+bounces-5537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75E9C7836
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 17:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5B8287280
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217791632D3;
	Wed, 13 Nov 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFhW0EkP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D015ADA4
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513993; cv=none; b=F5uoaAWrwLk0Fbwb6BoEsmd5bKr29EpuHIC/XRbYkfsk/fTPlaYSZeO5bu/WPyaNdeafyL7zHQqG4+qA+8zj/SKvg0OeyzzKPzvMF8yMSxMrAkxEajIgRidPUJDVAtg1dJdmO6pWN4KYdUO26X9aaLOQe4o2Ke3QBpgPhUQpscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513993; c=relaxed/simple;
	bh=YRQU7xhVjwoSWuv8r3a4ed8v8yhNHMAcLsvLoRntKzE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bitKlwUMSd/gdS3shpoN4kHVZBm/CLd6zuiVyVhGQ5xLylHdZMUS/0+TeEokiQm46rHvw/rlnWqKLlYjbyyKvP1uNTzluc3z8CbKf3oSpAhuiQaqMCvu2hMrtIJl0sL9tZnF/EjSIbsgluFwxKIcE0Nx9s0b1GczgFTZRpQFne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFhW0EkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731513990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdYNx9SfDbRH7x4RRePSaOQOrqzcOg7lfNf10JCUKzA=;
	b=EFhW0EkPo4qZfEiSgE4RHZpAhe+THvKXAhlY2+WCoSn7yGgjJODs574CkTmhYKY4CwAvz6
	ckD+eKJXtV6DduGzaq15yDNXiTg8p4NMZR3CKGT3CQVWOo4jIyQ3yH01RHrb7oTwXWhCc0
	OkyVMshFRBOZuytfVnbCLn7XFq8OokA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-6U5MmTikMXi5XZ_gzDNmZQ-1; Wed, 13 Nov 2024 11:06:28 -0500
X-MC-Unique: 6U5MmTikMXi5XZ_gzDNmZQ-1
X-Mimecast-MFC-AGG-ID: 6U5MmTikMXi5XZ_gzDNmZQ
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71a221a33bfso3743708a34.2
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 08:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513987; x=1732118787;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdYNx9SfDbRH7x4RRePSaOQOrqzcOg7lfNf10JCUKzA=;
        b=DUzomtyCmxI0TLkUMMGvRZimRmkEhns6m4GIakv15UbglJDwvZeiszV8AAc9+BH5JB
         9JC4rxHQaOrOemD10/unXyEoaaS/1kONCWU6/oA9kNwd85o1m2egHbYpeFDJFXI7D8LN
         NwZOs2ovvVc2mdF22nw+Jco2JOQOBnWC5UMUn+NGzwnXK3uNeau+p0vo70ayOe2biSsx
         1AXavGAOkdljAes7GEaPoeQ5gf9vcjiTTNR7Txi/dyVcbsCvjJHA9zn4Iw6M7b5B11l7
         dw04sZBAJZH6FkSwFAgoNwmK8aWb/Xki11WRDi1xwwB4QGAiwKtX9zbDYlWcRY6k/oIM
         hZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWUy3iI4zz2ArqbJRwNfMvF8hT3k9c4kaeonEzUIvr7x800I592os6OEjUcwZeTrUztYEm8FvQH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyst/Z1RHKnT5LfIJxyPfMnx3EwH8JnvCeXJ3GlYH4+Do6+zca5
	eL8DBtWI5NzHxGZokUBiUlcLSvw1AcHrw8S+by0F/TpbmR3jZIRT4+XqRsbqJ3F/sTvufvIj7wk
	p0q84vObhH+TLmMOguEQ2OXPZS4vKjgGCHNxXNipUDL15ZA9xVwOr87s=
X-Received: by 2002:a9d:7d90:0:b0:718:118d:2be8 with SMTP id 46e09a7af769-71a1c29bd6fmr17093564a34.28.1731513987670;
        Wed, 13 Nov 2024 08:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfQDKrXTTWiHAc6FMskhOsSgX7OYxTS+iSuK/1+Qd2I9y6q4e52nHIki8NMN5gGI14JaP8tA==
X-Received: by 2002:a9d:7d90:0:b0:718:118d:2be8 with SMTP id 46e09a7af769-71a1c29bd6fmr17093532a34.28.1731513987319;
        Wed, 13 Nov 2024 08:06:27 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f0ae8sm2749194173.131.2024.11.13.08.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:06:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>
Date: Wed, 13 Nov 2024 11:06:24 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20241113125724.450249-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 7:57 AM, Juri Lelli wrote:
> For hotplug operations, DEADLINE needs to check that there is still enough
> bandwidth left after removing the CPU that is going offline. We however
> fail to do so currently.
>
> Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> that overflow conditions (not enough bandwidth left) are properly
> checked. Also account for dl_server bandwidth, i.e. discount such
> bandwidht in the calculation since NORMAL tasks will be anyway moved
> away from the CPU as a result of the hotplug operation.
>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/sched/core.c     |  2 +-
>   kernel/sched/deadline.c | 33 ++++++++++++++++++++++++---------
>   kernel/sched/sched.h    |  2 +-
>   3 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..d1049e784510 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8057,7 +8057,7 @@ static void cpuset_cpu_active(void)
>   static int cpuset_cpu_inactive(unsigned int cpu)
>   {
>   	if (!cpuhp_tasks_frozen) {
> -		int ret = dl_bw_check_overflow(cpu);
> +		int ret = dl_bw_deactivate(cpu);
>   
>   		if (ret)
>   			return ret;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e53208a50279..609685c5df05 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3467,29 +3467,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
>   }
>   
>   enum dl_bw_request {
> -	dl_bw_req_check_overflow = 0,
> +	dl_bw_req_deactivate = 0,
>   	dl_bw_req_alloc,
>   	dl_bw_req_free
>   };
>   
>   static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   {
> -	unsigned long flags;
> +	unsigned long flags, cap;
>   	struct dl_bw *dl_b;
>   	bool overflow = 0;
> +	u64 fair_server_bw = 0;
>   
>   	rcu_read_lock_sched();
>   	dl_b = dl_bw_of(cpu);
>   	raw_spin_lock_irqsave(&dl_b->lock, flags);
>   
> -	if (req == dl_bw_req_free) {
> +	cap = dl_bw_capacity(cpu);
> +	switch (req) {
> +	case dl_bw_req_free:
>   		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
> -	} else {
> -		unsigned long cap = dl_bw_capacity(cpu);
> -
> +		break;
> +	case dl_bw_req_alloc:
>   		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
>   
> -		if (req == dl_bw_req_alloc && !overflow) {
> +		if (!overflow) {
>   			/*
>   			 * We reserve space in the destination
>   			 * root_domain, as we can't fail after this point.
> @@ -3498,6 +3500,19 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   			 */
>   			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
>   		}
> +		break;
> +	case dl_bw_req_deactivate:
> +		/*
> +		 * cpu is going offline and NORMAL tasks will be moved away
> +		 * from it. We can thus discount dl_server bandwidth
> +		 * contribution as it won't need to be servicing tasks after
> +		 * the cpu is off.
> +		 */
> +		if (cpu_rq(cpu)->fair_server.dl_server)
> +			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
> +
> +		overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
> +		break;

This part can still cause a failure in one of test cases in my cpuset 
partition test script. In this particular case, the CPU to be offlined 
is an isolated CPU with scheduling disabled. As a result, total_bw is 0 
and the __dl_overflow() test failed. Is there a way to skip the 
__dl_overflow() test for isolated CPUs? Can we use a null total_bw as a 
proxy for that?

Thanks,
Longman


