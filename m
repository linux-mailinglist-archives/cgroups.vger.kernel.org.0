Return-Path: <cgroups+bounces-9362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B3B33195
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CE202D32
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9922D59FA;
	Sun, 24 Aug 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5WYlxhn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E91FDE09
	for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055251; cv=none; b=tvmFsFs6SMEP9vKBPx85SLbz6DETv9cxI/hCyA8auPwQVEfM0Fzj/engbNbSMyoOLNOoL6qQvT5dLxdQDMFKhXmPih6zRuzjMvAx3rkkGLw9HgOL8O2ohSGfHxaVZKxlNXil0xZHgkgFlhoxLpmtnBHI74dCiAYOb4JIsqIfMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055251; c=relaxed/simple;
	bh=Q1L1yzZ7ud94WvojabMeOWCugIEPeRROO5DXpiq1gpk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FOFBMStYwtV0OQOhOGgHoe6nEimuH05+fFhRE0K6iFlTCe2FqxsXSs6j/L0003neBFaZn33f0Tf7CdkXQ7cv8Jn/xzCQxLp9NUnqlk5H3Zprx6zfrRXVPf90gVzpZ+aaG+s2I8UEFoBVmz/nezatNheWLoLAaW7VT5d0RdGxGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5WYlxhn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756055249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KblgusdaX44GtEkaStJj875tSXGSeuFJK6BC8mzxMA=;
	b=S5WYlxhnrLtPrZEdxTUSLV/ltbA1sTkWWKXJNzA8cUK9C/YpXTzcbgOS9Pjj7yxxhI9rUQ
	gDUyLvVeuJcuh6v5I7BwYI+rSN/+/h3qNpGc69ccdDlN9oJPA0CRH3qvl+9lLWIp8ULZdP
	fRpoIhMec3H0NT7E5KzD0ld87cwogmc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-sRfF9lK3PpO4t0Hq_Mfn1g-1; Sun, 24 Aug 2025 13:07:27 -0400
X-MC-Unique: sRfF9lK3PpO4t0Hq_Mfn1g-1
X-Mimecast-MFC-AGG-ID: sRfF9lK3PpO4t0Hq_Mfn1g_1756055247
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7200af345a5so6358357b3.1
        for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 10:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055247; x=1756660047;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KblgusdaX44GtEkaStJj875tSXGSeuFJK6BC8mzxMA=;
        b=Ilgf8FD9vmAxjqyEEwvFoG7UUFxrIRE8AgPAfR9bfCPwIXvXYLDFZz2WrCo9bXUIat
         42A89kQj+rw+fdFuHU6SbplqM0ahzCXQigXqDwTkf6DTdtQjBza59KGo4BBgnNGG5YNj
         OPVQsQPWc+ZzP9h2yBwNjMELjQnjln65Y4TQSGhEANhwRDssfaB83Iu+ehNO2aA+NFpv
         lX3oGJiXY6xr4CmTQpugmH5kK18UE3utD90GAi8SZFrqfuzLNrplf+OTiRRxw0JyMDyl
         CE/V5dXYExrjd1Y6DuVqzeIKE+7IJrHZqZ+RwTBIb+m8hunajFpg4PcD3u8BP5zREk9Y
         7Neg==
X-Gm-Message-State: AOJu0Yy32Dhj6xzE5j6l3/f5LBKgIcnRz50PsW9Prkk5QgkzsA1NJyKt
	X7LtTrZPDzeJS7QYgoCbhD1H6rsplE50OKs9wTlmRpX09xiVs2knxvUrulGCCXy+maY0+R2aVO2
	19EjdeHiQ+swUQ1MJ7csy8mmpKMEejeSAP2HWwnKQ+oapS9JM+oSoWfBF7Zs=
X-Gm-Gg: ASbGncvp9MogAfN7tOd8G/s/J2QB8OexO93j6wQoeSKMNoOQ8wphov4CIlIUccCDIWe
	+mb357nbCJHjwY18T5aTK0xMHxtcUvOk2Ii3ptyK0d5PBMKrhbqyh28xOO7dhNDBuHVh9Gkzwed
	6QIGOJaDujc2c8vQk0sXN9frqIy+mW8VedPL/qGqA9nYM0CCgQ18KQj8BlpHD+KUTIXuOP/7IKN
	HgznXzr+QrKl3LCHoRznBalzXsHr1oOy4+0j9Z2iN7KPhB4r26G+GMdYK+RSZL6foWZP71BVfij
	Ki6coAagv4GCf97PGAR/P+H8ul7eqloF5/lnTkq8R8XF8w8wSjgXsmKNLELwXWh76EJdiP2FkwE
	xiTU+FUgfGw==
X-Received: by 2002:a05:690c:6c83:b0:71c:1a46:48f9 with SMTP id 00721157ae682-71fdc3d0a53mr101822957b3.33.1756055246702;
        Sun, 24 Aug 2025 10:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIbv6oJnhRcILnVA8ypDDZjI/HQujg/Yk0MBJjauaxWq7ni+ri5OU2DLYTcQ5PTa66rkPVQ==
X-Received: by 2002:a05:690c:6c83:b0:71c:1a46:48f9 with SMTP id 00721157ae682-71fdc3d0a53mr101822457b3.33.1756055246185;
        Sun, 24 Aug 2025 10:07:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1734ac3sm12269037b3.23.2025.08.24.10.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:07:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <36685999-17f1-479e-9895-a22ef28bce67@redhat.com>
Date: Sun, 24 Aug 2025 13:07:24 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 2:41 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.
>
> Replace repetitive locking patterns with new helpers:
> - cpuset_full_lock()
> - cpuset_full_unlock()
>
> This makes the code cleaner and ensures consistent lock ordering.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  2 ++
>   kernel/cgroup/cpuset-v1.c       | 12 +++----
>   kernel/cgroup/cpuset.c          | 60 +++++++++++++++++++--------------
>   3 files changed, 40 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 75b3aef39231..337608f408ce 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>   ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off);
>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
> +void cpuset_full_lock(void);
> +void cpuset_full_unlock(void);
>   
>   /*
>    * cpuset-v1.c
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index b69a7db67090..12e76774c75b 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -169,8 +169,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   	cpuset_filetype_t type = cft->private;
>   	int retval = -ENODEV;
>   
> -	cpus_read_lock();
> -	cpuset_lock();
> +	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> @@ -184,8 +183,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		break;
>   	}
>   out_unlock:
> -	cpuset_unlock();
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return retval;
>   }
>   
> @@ -454,8 +452,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   	cpuset_filetype_t type = cft->private;
>   	int retval = 0;
>   
> -	cpus_read_lock();
> -	cpuset_lock();
> +	cpuset_full_lock();
>   	if (!is_cpuset_online(cs)) {
>   		retval = -ENODEV;
>   		goto out_unlock;
> @@ -498,8 +495,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		break;
>   	}
>   out_unlock:
> -	cpuset_unlock();
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return retval;
>   }
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d5588a1fef60..d29f90a28e1e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -250,6 +250,12 @@ static struct cpuset top_cpuset = {
>   
>   static DEFINE_MUTEX(cpuset_mutex);
>   
> +/**
> + * cpuset_lock - Acquire the global cpuset mutex
> + *
> + * This locks the global cpuset mutex to prevent modifications to cpuset
> + * hierarchy and configurations. This helper is not enough to make modification.
> + */
>   void cpuset_lock(void)
>   {
>   	mutex_lock(&cpuset_mutex);
> @@ -260,6 +266,24 @@ void cpuset_unlock(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +/**
> + * cpuset_full_lock - Acquire full protection for cpuset modification
> + *
> + * Takes both CPU hotplug read lock (cpus_read_lock()) and cpuset mutex
> + * to safely modify cpuset data.
> + */
> +void cpuset_full_lock(void)
> +{
> +	cpus_read_lock();
> +	mutex_lock(&cpuset_mutex);
> +}
> +
> +void cpuset_full_unlock(void)
> +{
> +	mutex_unlock(&cpuset_mutex);
> +	cpus_read_unlock();
> +}
> +
>   static DEFINE_SPINLOCK(callback_lock);
>   
>   void cpuset_callback_lock_irq(void)
> @@ -3233,8 +3257,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	int retval = -ENODEV;
>   
>   	buf = strstrip(buf);
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> +	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> @@ -3263,8 +3286,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_locked();
>   out_unlock:
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	flush_workqueue(cpuset_migrate_mm_wq);
>   	return retval ?: nbytes;
>   }
> @@ -3367,12 +3389,10 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
>   	else
>   		return -EINVAL;
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> +	cpuset_full_lock();
>   	if (is_cpuset_online(cs))
>   		retval = update_prstate(cs, val);
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return retval ?: nbytes;
>   }
>   
> @@ -3497,9 +3517,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   	if (!parent)
>   		return 0;
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> -
> +	cpuset_full_lock();
>   	if (is_spread_page(parent))
>   		set_bit(CS_SPREAD_PAGE, &cs->flags);
>   	if (is_spread_slab(parent))
> @@ -3551,8 +3569,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
>   	spin_unlock_irq(&callback_lock);
>   out_unlock:
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return 0;
>   }
>   
> @@ -3567,16 +3584,12 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>   {
>   	struct cpuset *cs = css_cs(css);
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> -
> +	cpuset_full_lock();
>   	if (!cpuset_v2() && is_sched_load_balance(cs))
>   		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>   
>   	cpuset_dec();
> -
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   }
>   
>   /*
> @@ -3588,16 +3601,11 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
>   {
>   	struct cpuset *cs = css_cs(css);
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> -
> +	cpuset_full_lock();
>   	/* Reset valid partition back to member */
>   	if (is_partition_valid(cs))
>   		update_prstate(cs, PRS_MEMBER);
> -
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> -
> +	cpuset_full_unlock();
>   }
>   
>   static void cpuset_css_free(struct cgroup_subsys_state *css)
Reviewed-by: Waiman Long <longman@redhat.com>


