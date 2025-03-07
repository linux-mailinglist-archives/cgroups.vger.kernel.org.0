Return-Path: <cgroups+bounces-6892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D18A56BAE
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73FF169CDD
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15493221D93;
	Fri,  7 Mar 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUNWTMbM"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61560221735
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360575; cv=none; b=pwES0wiRxflGhZIcjNBUl77G/pN0qA/UwUwSMTe/TSrVZ5ACeK3AVKHaacxT9oSjlNgzAU9Rw4O4g49kDwl5V9/2dSsHvcSmCs3ChULSvLPAEhmoOfkmKHqaH0+UJ5Kvtaycgd+FWoeEmURbhbYCWeXT3br/qxDkqRlGNFp3dmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360575; c=relaxed/simple;
	bh=KlNfDr+cGyfO/N8Vp7xlIWFUUZyQjc+9mUFizVFZ3Bw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b86RqTIPjCsSWQjIIbvxVaoXDGvfoXvxpMxL4P3IMXkE/pMsoOqXMcHhrkogeaTjE1vJALcGw2ZsCu8slSwLeh47D+JeTahydWP9nEsS13k8vSxIh9oVgjQbLxQjRfEmiC2sQRir0yv529WHT1MrNDcWW74z2LhakfJGvJ+7iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUNWTMbM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvg56giKQi3Vw+cc9vr8B4QffnxQgjZaVaW3ou0m+jQ=;
	b=QUNWTMbM+HZWQ5WGh/JRgP8OjFgxofeRZQaRSdGW3FjHhN6R64ZhWUOstXXGVNQtQYQmvo
	psE32G63q/eqhp0dlZ9rpnvln/Bi3fM5Dl7l58HRyLbynOpRq7S6YV5VgGzoB4piQgqVs0
	F3Vk7EStZPOaEp78KhQS01FvIFE1fHI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-FTZxlpoNOQmi5IcEaqPf6Q-1; Fri, 07 Mar 2025 10:16:11 -0500
X-MC-Unique: FTZxlpoNOQmi5IcEaqPf6Q-1
X-Mimecast-MFC-AGG-ID: FTZxlpoNOQmi5IcEaqPf6Q_1741360570
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8fb5a7183so34329046d6.1
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360570; x=1741965370;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvg56giKQi3Vw+cc9vr8B4QffnxQgjZaVaW3ou0m+jQ=;
        b=B/KHkEgNTqzwjr9cb4b8nm8XajQ72LXmbU/1mlqWiMTTW+9Bw9YSvah1CRUFNNEBmL
         DpeIVQwfks+n2GJepfORH3s0ACa+L2rTnSaVBrNLtp5S2XH6D0Woi1jfk1rln+0WKnpN
         cJJnxEFdr573hf2UH0EdesLzHz7ZUJHZ6ukjMn5iWolGQpDZcs8uCABN5SSkAsdFCFAx
         vId+vIiEe4ZI5DzUySPCjtZfZ3NeDP4pqED+EpG9xi1BN7/uNlE08ZYJMyX/Yzbkq1BK
         hzpLe6BlVyJPsC2UpW208V1G7V5CVwGpdLTWK5zt1xngE+hlLXuhVMNSu/+GHL7JSfVl
         mPxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXYA0bToSOqLe47bGYiHvEhV1ijki6Bs2904amvc9+qyXItNDWTTXC0RWJrFcUSMSJsNPjJ+Mm@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9yKknAqCY//z5rxRJn5ZQScB3uqDzMj1Ne1Xa9/jtL5ooVI4
	/y17YaYPgEZkajEDxkqeVD24VjrYU6ugezcCx7CaomHeiBOef3kO9ZypQT0Rkw5XnyYl4dzJF/L
	k3toyCtTZJrRU8C132ctYIpYX1b5ODbGfcUkGuZyGYaUuTnTrypdmNFg=
X-Gm-Gg: ASbGncuPJvoAPFeceeP8DYz+CMd28Kv2piHMeGzTJBuSt14kHMusnwaVdxEDmLThRmt
	hSpZlGkg90fJc9lmlFGxsKHAN7hsrYwsOkWHkdb8CdBO1xhE1vCZuO77IDKm2umdLtKR/BHTBJa
	gVvTKCK3hT2w7bAod81g7dXk9yQWKVBByWVqc8+/RsMbbmZCJJBhz/SmY6Cf7E4O6LJHP4AMXHN
	FLN7XnCkMmaORix3m1TVG6NVE4uf18hF3EM8I4Mtr071mpr0nbsaBgTxMISfEprJ4MjGcMD4YQU
	oGnugpPPndrm1lCF9aYk1CEFcaI+PHVSNOqNhNNjNZ/maYzfH4Ot9GDbhB8=
X-Received: by 2002:a05:6214:20cf:b0:6e4:4484:f357 with SMTP id 6a1803df08f44-6e9006adc5amr38428526d6.30.1741360570550;
        Fri, 07 Mar 2025 07:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw/b2w6u//qoeC41l/SCcWWsldDpFpfYXf8Z2PBj1QJkAjmh013a2A8GgLukVtjv9HzHJESw==
X-Received: by 2002:a05:6214:20cf:b0:6e4:4484:f357 with SMTP id 6a1803df08f44-6e9006adc5amr38428076d6.30.1741360570246;
        Fri, 07 Mar 2025 07:16:10 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b6acsm20373116d6.74.2025.03.07.07.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:16:09 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <820ce062-ebce-4482-93f5-cc618a0c3c41@redhat.com>
Date: Fri, 7 Mar 2025 10:16:08 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
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
 Jon Hunter <jonathanh@nvidia.com>, Waiman Long <llong@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-7-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-7-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 9:10 AM, Juri Lelli wrote:
> partition_and_rebuild_sched_domains() and partition_sched_domains() are
> now equivalent.
>
> Remove the former as a nice clean up.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f66b2aefdc04..7995cd58a01b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -993,15 +993,6 @@ void dl_rebuild_rd_accounting(void)
>   	rcu_read_unlock();
>   }
>   
> -static void
> -partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> -				    struct sched_domain_attr *dattr_new)
> -{
> -	sched_domains_mutex_lock();
> -	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	sched_domains_mutex_unlock();
> -}
> -
>   /*
>    * Rebuild scheduler domains.
>    *
> @@ -1063,7 +1054,7 @@ void rebuild_sched_domains_locked(void)
>   	ndoms = generate_sched_domains(&doms, &attr);
>   
>   	/* Have scheduler rebuild the domains */
> -	partition_and_rebuild_sched_domains(ndoms, doms, attr);
> +	partition_sched_domains(ndoms, doms, attr);
>   }
>   #else /* !CONFIG_SMP */
>   void rebuild_sched_domains_locked(void)
Reviewed-by: Waiman Long <llong@redhat.com>


