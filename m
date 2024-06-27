Return-Path: <cgroups+bounces-3428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015591B225
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 00:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4BF28132F
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7F21A2542;
	Thu, 27 Jun 2024 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6H+k8SN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7691A2556
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526963; cv=none; b=gcWT2WYu98fVKR/+GYRrnoAM0rfkVCJFhZnAz0TpmJuKXutXzWXnvfWlSo7/6i89FbTHxvJWbCcl9jHFteXYTCCb73KKgpuy8jF9699VDfYk1/0g/Sby63N4C0fqp58pYE2vRvrIY4Fgy07A8vQfXoU8ctZGCGiBgQvhzP1sbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526963; c=relaxed/simple;
	bh=Pvtqh3CUEzXVv71E6R2MTdLyKseJmls10vMiB2nPl1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8VNRkiuVxq8DTwXbDdyDi0UXUrO1f6u8HxO6gMEeITAl3aSbvwZZ5N9se/60RYQcmyosXMEUb4KT2JlL7vHgItsqrJCnrGpvLuwcYnMVwIVi0RqV0zUYPztYrPQEDTBhTKKq/ueEBdeFemtDlIeaKM7dDHy6C8VfCcoAQhzyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6H+k8SN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719526960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8Y8sRPgLs0p8pfHCw8O8kar0+6k5OzXteERRqt0u8g=;
	b=X6H+k8SNzTMfB1UPKiH1qg+KwHkye/CGSyw6YhWEVUv6N4iPgut1cMh/CrSniL2azxsF8f
	RfEF0AVP6vSwk+V6Ixnm5fyZXajm4etvv+7uCf8gtLGK/Ow/l4hEHqE/aAXZorxlSUTlh1
	j11leaYHCmEkoEkFHkDiY1E+25zGApE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-lnK5EB3wMoaHtQ06oPb_5g-1; Thu,
 27 Jun 2024 18:22:37 -0400
X-MC-Unique: lnK5EB3wMoaHtQ06oPb_5g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E26919560B2;
	Thu, 27 Jun 2024 22:22:35 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87CDA1955D8C;
	Thu, 27 Jun 2024 22:22:32 +0000 (UTC)
Message-ID: <08062501-f3fb-4e4d-b72c-f1b0f964640f@redhat.com>
Date: Thu, 27 Jun 2024 18:22:31 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] cgroup/rstat: Helper functions for locking expose
 trylock
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 cgroups@vger.kernel.org, yosryahmed@google.com, shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <171952310959.1810550.17003659816794335660.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 6/27/24 17:18, Jesper Dangaard Brouer wrote:
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   kernel/cgroup/rstat.c |   40 ++++++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index fb8b49437573..2a42be3a9bb3 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -279,17 +279,30 @@ __bpf_hook_end();
>    * value -1 is used when obtaining the main lock else this is the CPU
>    * number processed last.
>    */
> -static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
> +static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_in_loop)
> +{
> +	bool locked;
> +
> +	locked = spin_trylock_irq(&cgroup_rstat_lock);
> +	if (!locked)
> +		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, !locked);
> +
> +	return locked;
> +}
> +
> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
> +				       bool check_contention)
>   	__acquires(&cgroup_rstat_lock)
>   {
> -	bool contended;
> +	bool locked = false;
>   
> -	contended = !spin_trylock_irq(&cgroup_rstat_lock);
> -	if (contended) {
> -		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
> +	if (check_contention)
> +		locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
> +
> +	if (!locked)
>   		spin_lock_irq(&cgroup_rstat_lock);
> -	}
> -	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
> +
> +	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, !locked);
>   }
>   
>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> @@ -328,7 +341,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>   			__cgroup_rstat_unlock(cgrp, cpu);
>   			if (!cond_resched())
>   				cpu_relax();
> -			__cgroup_rstat_lock(cgrp, cpu);
> +			__cgroup_rstat_lock(cgrp, cpu, true);
>   		}
>   	}
>   }
> @@ -348,9 +361,16 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>    */
>   __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>   {
> +	bool locked;
> +
>   	might_sleep();
>   
> -	__cgroup_rstat_lock(cgrp, -1);
> +	locked = __cgroup_rstat_trylock(cgrp, -1);
> +	if (!locked) {
> +		/* Opportunity to ongoing flush detection */
> +		__cgroup_rstat_lock(cgrp, -1, false);
> +	}
> +
>   	cgroup_rstat_flush_locked(cgrp);
>   	__cgroup_rstat_unlock(cgrp, -1);
>   }
> @@ -368,7 +388,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   	__acquires(&cgroup_rstat_lock)
>   {
>   	might_sleep();
> -	__cgroup_rstat_lock(cgrp, -1);
> +	__cgroup_rstat_lock(cgrp, -1, true);
>   	cgroup_rstat_flush_locked(cgrp);
>   }
>   
>
>
Will it be cleaner to add a "bool *flushed" output parameter to 
__cgroup_rstat_lock() so that the caller can respond differently whether 
the flushed flag is set or not? In that way, you don't need to expose a 
separate trylock() API. Also your commit log is empty.

Cheers,
Longman


