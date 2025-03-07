Return-Path: <cgroups+bounces-6890-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92568A56B9B
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8C41789B3
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DD21E0BC;
	Fri,  7 Mar 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSHq4WkL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44A21CC43
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360494; cv=none; b=qQcUI8KuosaZLUxdHU8VJdrUJ0EFaqia0Wg8xItiIKXgjUXUlbH7+DXIbdF5wTWBraY1d9lnZLOx1bisrYathf7XvqoXy5ydA/YWyyXy0OMQdg9xC/h1Pns/WITjhksbJN2zYKreWZn1e+plF76sei11tX7Cgc9iDVYAk7TIG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360494; c=relaxed/simple;
	bh=fA41Y+uCuWDGDV6cfmusKKYNoYIcYlCPGSFe9l+arqg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=th5IMKHTAGZNmBSYgclj6TmU4uBzeINtE0b8xhqnFiyahAZ5NnpKV87i7KZ5YyTZG0qX+zJV130bE5n54pNDGVjt4Ew+n8YZj4ec5d1UifIfCPUGfcj3XyUhj4w895GVFHWXG2yQohNJY9co2RyLaqsKnyWElKwL9wvTllp0B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSHq4WkL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vCaAjA10n4eQuZKup3eqGeapTr8OclBkkEU+k0x70I=;
	b=BSHq4WkL7JRI3T61rpRW2yT2zGH6BVvz4sI4AqTw4Gp3VBRDRRLhf2iP7ISmFl98EyJj3j
	c8c6+e+8pKmKSVVrbGUYkR8blnCQEF94a5wbzasWiTXrKvn6LH2VxqyVtzI3wZ2yQ8A+0G
	UfcehB56oFyvqfcXV3ad8B/JOl1NHtM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-wc-WUPpdPvm4UztMyCGRVg-1; Fri, 07 Mar 2025 10:14:50 -0500
X-MC-Unique: wc-WUPpdPvm4UztMyCGRVg-1
X-Mimecast-MFC-AGG-ID: wc-WUPpdPvm4UztMyCGRVg_1741360490
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3c2610b41so345190585a.1
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360490; x=1741965290;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vCaAjA10n4eQuZKup3eqGeapTr8OclBkkEU+k0x70I=;
        b=HXvfLqvoTdcSN3pU/CETW18GHrn21GvBL4fp+ktL6zKTQQZvADAqIwV7eBfNznCm5U
         7oKvGsSRDUeTG67GL/SAh+HIe4nyHE/WBcMvt28dKb0OHqYpLvuPay2D8YM++hsZhzku
         cX32br6kjkHI9wGTL4LtSrYtWXIHYNATiGWm+KNtNcc3qePDsBmC9dbgFuwdqDmFmNwq
         4PjmOzHMQ2vUv1+JK81PXmyF90L4s85h2gkbsejqlMbS1bbbt6oq9mNgSzhp8WSBCUwI
         L7bGsVnxrTpFj1NvY5H53UnBVc8KiZOujJX89ZTdsAY1N/yIOmaQewcSgsMwspqZ9L44
         i+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkRw42CCgzOdKbvNZzGgqMEUxWvT4rDT1BbZcyCXeHdfO6+8g4HTum6dSNfQryToP3IGPps2CY@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBk1PhNjgSnr/C+shI6g770+Tab27oVg2M+Qlkav7yIscWDM3
	iejX3rwgmuftOWS5xwxgoMMmrzaI1SB9jg7w8wXdYRqWmHUExBgeD5TfGaD2cf5vY8VntV2iBLJ
	vKT2egeLndQG+dRydDdVmgSRC6v+2sbu0+BSE4NCIEAeBH9qQYt20Sjs=
X-Gm-Gg: ASbGncvAu593Lfdi4ob1N0Vu7hxGeuybLb8dVAPbPaqGeg+3JcI8AJ5/QdxOd40HfHn
	a03XJ9/d65EXo8a965Z9xwC5XXaXgb4Injmuh7O80ztH8phYTY3zrIzUOCCsL/M6X3tHwXgHxnR
	e9U4xc9FzpzR4rjw/zIRAQndTHk469kqY05Q/5hEdDm5cpbym1isHEl6LZXWWXOt3eWHjTAPul/
	/NersqePl+OGXlOncl3OyX4hvPC4M2ZmKvYQCgho73zQBr7RRHMAD2xEGAC00nvPPvKX6cNSb4p
	Gv2g0Hj1dvtl/PNFs7g2wyp0vwuhlyDBafA6WHc9v9oWic+KdLGg+6vUkjc=
X-Received: by 2002:a05:620a:2612:b0:7c3:c8f6:59bd with SMTP id af79cd13be357-7c4e619e966mr650347285a.54.1741360489759;
        Fri, 07 Mar 2025 07:14:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Io38CiHNusxosf4AFVfsbGHbOHIccVZXZl4TgpD2GU8x8/XQ3qPW8XavtCzqZIKHkX/I4w==
X-Received: by 2002:a05:620a:2612:b0:7c3:c8f6:59bd with SMTP id af79cd13be357-7c4e619e966mr650342585a.54.1741360489485;
        Fri, 07 Mar 2025 07:14:49 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e553e418sm251280485a.117.2025.03.07.07.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:14:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4bc436b2-1667-42a6-9afe-1c51e5b3d131@redhat.com>
Date: Fri, 7 Mar 2025 10:14:47 -0500
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


