Return-Path: <cgroups+bounces-3918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76693D967
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 22:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C6F285BDD
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C91494DA;
	Fri, 26 Jul 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C69uBCv0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C4149002
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023924; cv=none; b=MRi1SdzRXO/MlecxMNuNepEYOpACL5xTY5ogDBld8zSkP9lIT9vt4tuIEB3D3ruqrr7jeTKtD6eXcsofdH7kE6zW5qvY7HVVV4RNDAhhMiyLzakNcLatNHWuvhlhydxj7kJHxn7LT6iNnSMa5fmKPW8D0Px75lLmPxIvrhXxfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023924; c=relaxed/simple;
	bh=QutQBA4+F1mkHxd8UoybUqxKU4ZvurRY1ADm/Qy/mA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGo5pi4QG27812T6XXLBOE7/v4mztbWmiJVVOmdM3E6/Za6czNZobImBlmVkPnhs5RUawuYuLxP0inu2ZfqCNH/mBd+mCV6zpmupuHNlxOh3O6XdWK/otEVMqK3E8yKx7ErfOBNriwJOAC5w18d4+ktxOsaEGLBZJWg8hahVyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C69uBCv0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722023921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKI9yEEsS8+SM44w165mJuuRy+Lum2O5d34PkmrfIkA=;
	b=C69uBCv0pn0fZMe0gVJ1GlSAmSFeBkQQNaso1Pt6qXFnCwZyebXcywpZpF3iOdLMw23GxF
	8l8becMEYLR1kOezwTMe+aPs0/aNoGcXTgZx/cSTv15MwyC5n4gFGWFYlnlKp7054jROYI
	umMCoJ/P7/Dbgm3y9KefkVKh7iz6wQU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-CxuctCT5NyqfGWgcEHKXEQ-1; Fri,
 26 Jul 2024 15:58:36 -0400
X-MC-Unique: CxuctCT5NyqfGWgcEHKXEQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94D9C1955D47;
	Fri, 26 Jul 2024 19:58:34 +0000 (UTC)
Received: from [10.2.16.80] (unknown [10.2.16.80])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A02E81955F40;
	Fri, 26 Jul 2024 19:58:31 +0000 (UTC)
Message-ID: <5145be53-9bfc-42a9-b8e2-d035d151a115@redhat.com>
Date: Fri, 26 Jul 2024 15:58:30 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/cpuset: add decrease attach_in_progress
 helpers
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240726010502.2226806-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240726010502.2226806-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/25/24 21:05, Chen Ridong wrote:
> There are several functions to decrease attach_in_progress, and they
> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
> add a helper to make it concise.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 39 ++++++++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d4322619e59a..fa0c2fc5d383 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -490,6 +490,26 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
>   	}
>   }
>   
> +/*
> + * decrease cs->attach_in_progress.
> + * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
> + */
> +static inline void dec_attach_in_progress_locked(struct cpuset *cs)
> +{
> +	lockdep_assert_held(&cpuset_mutex);
> +
> +	cs->attach_in_progress--;
> +	if (!cs->attach_in_progress)
> +		wake_up(&cpuset_attach_wq);
> +}
> +
> +static inline void dec_attach_in_progress(struct cpuset *cs)
> +{
> +	mutex_lock(&cpuset_mutex);
> +	dec_attach_in_progress_locked(cs);
> +	mutex_unlock(&cpuset_mutex);
> +}
> +
>   /*
>    * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
>    * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
> @@ -3421,9 +3441,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> +	dec_attach_in_progress_locked(cs);
>   
>   	if (cs->nr_migrate_dl_tasks) {
>   		int cpu = cpumask_any(cs->effective_cpus);
> @@ -3538,9 +3556,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   		reset_migrate_dl_data(cs);
>   	}
>   
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> +	dec_attach_in_progress_locked(cs);
>   
>   	mutex_unlock(&cpuset_mutex);
>   }
> @@ -4283,11 +4299,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
>   	if (same_cs)
>   		return;
>   
> -	mutex_lock(&cpuset_mutex);
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> -	mutex_unlock(&cpuset_mutex);
> +	dec_attach_in_progress(cs);
>   }
>   
>   /*
> @@ -4319,10 +4331,7 @@ static void cpuset_fork(struct task_struct *task)
>   	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>   	cpuset_attach_task(cs, task);
>   
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> -
> +	dec_attach_in_progress_locked(cs);
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>


