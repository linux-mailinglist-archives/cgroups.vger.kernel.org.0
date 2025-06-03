Return-Path: <cgroups+bounces-8420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8421ACBFF0
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 07:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862B63A60DE
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED91F3D54;
	Tue,  3 Jun 2025 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5msuKJI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB2125B9
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930001; cv=none; b=jD2aANHStVnYcdMfEOWhyMZ9lb+O3RtFBxCKDGFkCYfoKWB6l55mmkc0R1LUGsiPGtj/+hUq5ODsO6/dJh2M6bWhPqGc2prOorg5UWKqPPgQOFjhd1IRw+m1WjzJXe2AEhlaFa1GhzNOleXwYk2bq3QYyiH9KxUT87NXfYWOxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930001; c=relaxed/simple;
	bh=DcYlcvFjBzR+NhLXvFPlwaWQAP2e2OOoMFhR8k4Wemo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srJ9eZ6Mn94MoJJ/9OZIH2TdKg1BrsNrOiP/v/e50O3xwhj8kjkn8mAHUiSm2bwsRq+OBVSa0aIHUX48Vp4ttX6ZYE+d1fAP8jCeOHvGOwUPAWsItu7M4slIatBZR6GCVLaqpk8NmxDtdlonqMro+e6aPGvuq2XRMIMn5m4EoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5msuKJI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so4990398b3a.0
        for <cgroups@vger.kernel.org>; Mon, 02 Jun 2025 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748929999; x=1749534799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9ZsKjmFhtaY36tAAcwoIAAlEIMh9GdhcJMr+u+RRCU=;
        b=U5msuKJI/DocXKHWzT5ISmTMzUMTxh1+yD77OnD4KGavLOqTQBxNB6o4Hymd+cpxnE
         ZBKKBgRiHvz9SIp6sBkyb9QSt3ixsxI+h6Nef91ZnG09TISyNYiJA89RlI2cv216l3zX
         yWfUP50IWiwRBlKjK5lYzZrw/CS5onlBXSpHtlu2/G/lqZQ97RLruUx34QnVKu4Nojr6
         NcXZz7b+k6HlFWDUb53/W2gnppKIDncIBWP2cBWX48xIeOkO7FAdwc4o73deBJnWOLsH
         i+mtsZdPN06WK8gr0GcRxzKZo0rP91Jh4cp80QjhV5TpxfZq+MXHXnV09dUbrj4nkU7W
         P8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748929999; x=1749534799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9ZsKjmFhtaY36tAAcwoIAAlEIMh9GdhcJMr+u+RRCU=;
        b=S9CutpXHmG4pJ2Bs0OhoDaK8CfBPmSN+mJ/QTFsjqMchFj4qDuJgBHIE3OD65GCxO4
         PqTP8sWZxF06laa/l3kkvIKV3EjS1pbklEho2PB6O2lkAsY7GkR2kPJ5vBSf0/3Vodvz
         wfFrQ3KjazOz8D/mp5SvUbmhAe3jQhbITC7XI6Hx+tlSbRO+1ehC1HbsnY71XWP0bozU
         oZkzJcWWbLaj1btQbyWESgkP65WNlHqVXvuKcbQI4J19tc+g7hGBhYEI7RG1NubVOtJH
         hZURrg6gdGqSksyed1yh8GC/AB9IHsbwI42+NvTwLcAo40iRIwBs74Qjppmfy7ur+FNn
         pLOg==
X-Forwarded-Encrypted: i=1; AJvYcCVzd50zNVjX4WwhgZyYCLIV6TIiu9KDsfi6W+Xm9wD50vsf0tt/+O2hNuf7DsOCvjQ+xo1o5xoS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4H6YxsGyKR7IWeBriJw4Gt+tsfnZnx+iGJp80V+Mc/OwRZ3ws
	EuCyRO1Alew/27i+9Vv1JKDF7TXUq/CsfjD9L2KK0hbjd8a36KzXA1Rr
X-Gm-Gg: ASbGnctvX6QOCLtFwiuBAKpaaGddBYNUd3YeSI8d4xPu0X2KSgrUtIqoFOebtbK0J5M
	iTV2jcAuKn2G/oV7cVqz6i7Mzconsqnw6BQg6NMR6nxX8k3B3Z32DByVdFzDx11JfVsdFaDl8rX
	VvtYffxPiuTUjK7YNVasG4QXAgK1LcoF6GA9gLNpAWqTJOdfw6sJ9BKbyu/ovnsFUQ3PtZmWZig
	vBimxdGcdhTeosQPQsbVsJft7LTj0mXlXAyIfS7gByHVoEXmmVSRyAc88ne+okhhFUsdunthqhZ
	TZ5EjLwk2CJ/M/9JzT5hwysrrX9e0yfG2x5oh63tPSwE3NqFWj9RrPGTGgE9eHaeClym7mM0zx8
	=
X-Google-Smtp-Source: AGHT+IG9KE8+DIj+ZP6FaPkID1QKzdPPcnl9HRYKDW8mUB361O/bT33y0Uo6PuygBNf9QCu3cwlsxw==
X-Received: by 2002:a05:6a20:9e4b:b0:1f0:e2d0:fb65 with SMTP id adf61e73a8af0-21d0cfd937fmr1619559637.2.1748929998756;
        Mon, 02 Jun 2025 22:53:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd441asm8619224b3a.153.2025.06.02.22.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:53:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Jun 2025 22:53:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, llong@redhat.com, klarasmodin@gmail.com,
	shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
Message-ID: <9eca911e-67f1-46b1-b5a6-df36b1758f60@roeck-us.net>
References: <20250528235130.200966-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528235130.200966-1-inwardvessel@gmail.com>

On Wed, May 28, 2025 at 04:51:30PM -0700, JP Kobryn wrote:
> Previously it was found that on uniprocessor machines the size of
> raw_spinlock_t could be zero so a pre-processor conditional was used to
> avoid the allocation of ss->rstat_ss_cpu_lock. The conditional did not take
> into account cases where lock debugging features were enabled. Cover these
> cases along with the original non-smp case by explicitly using the size of
> size of the lock type as criteria for allocation/access where applicable.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Fixes: 748922dcfabd "cgroup: use subsystem-specific rstat locks to avoid contention"
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202505281034.7ae1668d-lkp@intel.com

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  kernel/cgroup/rstat.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index ce4752ab9e09..cbeaa499a96a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -47,8 +47,20 @@ static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
>  
>  static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
>  {
> -	if (ss)
> +	if (ss) {
> +		/*
> +		 * Depending on config, the subsystem per-cpu lock type may be an
> +		 * empty struct. In enviromnents where this is the case, allocation
> +		 * of this field is not performed in ss_rstat_init(). Avoid a
> +		 * cpu-based offset relative to NULL by returning early. When the
> +		 * lock type is zero in size, the corresponding lock functions are
> +		 * no-ops so passing them NULL is acceptable.
> +		 */
> +		if (sizeof(*ss->rstat_ss_cpu_lock) == 0)
> +			return NULL;
> +
>  		return per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu);
> +	}
>  
>  	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
>  }
> @@ -510,20 +522,15 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
>  {
>  	int cpu;
>  
> -#ifdef CONFIG_SMP
>  	/*
> -	 * On uniprocessor machines, arch_spinlock_t is defined as an empty
> -	 * struct. Avoid allocating a size of zero by having this block
> -	 * excluded in this case. It's acceptable to leave the subsystem locks
> -	 * unitialized since the associated lock functions are no-ops in the
> -	 * non-smp case.
> +	 * Depending on config, the subsystem per-cpu lock type may be an empty
> +	 * struct. Avoid allocating a size of zero in this case.
>  	 */
> -	if (ss) {
> +	if (ss && sizeof(*ss->rstat_ss_cpu_lock)) {
>  		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
>  		if (!ss->rstat_ss_cpu_lock)
>  			return -ENOMEM;
>  	}
> -#endif
>  
>  	spin_lock_init(ss_rstat_lock(ss));
>  	for_each_possible_cpu(cpu)
> -- 
> 2.47.1
> 

