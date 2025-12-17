Return-Path: <cgroups+bounces-12439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA47CC9000
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF38B317AE9E
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982CC1F0991;
	Wed, 17 Dec 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/9jzDPd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qRPrxBID"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703E32D0DA
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990985; cv=none; b=crlq25wc4i7yaWEW244rW95QxMp0p4nUkns3iKnMRaq4P5CPi0me5BgH/nlIrV8J5iTpGNPat9R9wUx7GeeL1pBXwwI8gdWupuDG+tYJRQI2d2KD7ySVH86529TBTZDbmR5YpMh7+Vd76YImln7msT5tv9+sn9RZU0pVa26gjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990985; c=relaxed/simple;
	bh=MkAOw2BSglp2aTNFcNu2h+CZ00Ka1yjH+aL1APkD2FU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BKUX6L752vF3S3lLbMFH5FsUxT8wT843fo2LOJo2+roQxIuhLQWQ+cKdAepPkHWvOK/dDbOQAn9HkWcF4IdoXkedMzeCRZm+dLPMDxCE3hwfHWH5zZNoA9XNmN9RVuBWnrNyV+jbSs3gA8U//aR1ZgiB0A9jDBdWRJsnETep/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/9jzDPd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qRPrxBID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765990982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6D/twUjpVaN7/2LE7FByWy0dht+yFlBfxvyhXSnqag=;
	b=R/9jzDPdFUWT8oQOk3AkzEL2MA8o8KFfzOQtm5tho1LxuoWy7UieP6rNQMa2mCop/RqKdw
	uwzCUgbFr9rnsHVjzR5LSFXoOjepjysvfH4ZkH/44R/TzRXFGDFE1PyJpU1xMNiBKgJlnw
	rTCwKIf6wEHn/SGqA+u6q5z+D7eH0I8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-vtX6SDBnPR-h2y8iAlNgYg-1; Wed, 17 Dec 2025 12:03:01 -0500
X-MC-Unique: vtX6SDBnPR-h2y8iAlNgYg-1
X-Mimecast-MFC-AGG-ID: vtX6SDBnPR-h2y8iAlNgYg_1765990981
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b9fa6f808cso1578928185a.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765990980; x=1766595780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6D/twUjpVaN7/2LE7FByWy0dht+yFlBfxvyhXSnqag=;
        b=qRPrxBIDfZXpJ04FH2b0w1jqGYk7N9txa+dCsAP4uVU7TLkhlDYTWhzyRDyCi4KdEp
         INNWAiFxBvATwjOdy846uCg434AdIiRc95qxCrjG6gnyVC9o6mIomecPHODWPepfBV+Z
         2Hj7K85Aszm132mPHgag4EXXXZHhBRn0UHecK+WB2gto4qT/c7pguVwuPjYXl5cTm6J7
         cw4D0XHS4ABOO+g7YeH4m26ugGqs6cMzG8Lg9b/6XVeFns+syAgxloLhJIk15gCjRBDw
         7OwfJTCngbUgucGyn9AFj+jOZyx7Vx7ZizRtCUPKG9uAEA+CQPaZwLpB/8rdaRTiYUxc
         DC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990980; x=1766595780;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6D/twUjpVaN7/2LE7FByWy0dht+yFlBfxvyhXSnqag=;
        b=WjPIjUqtKdof4oUaW6I3lEPreTyQaTLa8RR3K2aCT6bHcb8j/ohG0qV81IKp8yScLT
         szk9S9QpQTUU66lk4OH2MOK2YsxRQY08TtZgJ6dgTv0R6KFTv1FJlF2LyBPe5VBiGyXv
         lXuyCSYd4EE6AQIF9C+BtQpmxnVkJHOYvqcpur8H0F2OGwM1gyAKfOSGHL0+tadff90p
         47xA4XrCrvg20bkhfKL1mICcp+Ifz4Xovr+PK826iU6HBLoisLOuFrv2cb/I64HbnAYo
         ieihWaDOctwnGYqQUnC1wmsRPRjMuydEpkwfpnQUDKQcy98rgQqic4HFZ09t8Ao19ex/
         1JDA==
X-Gm-Message-State: AOJu0YyFdXeNK8PIe+l6YrYJXlVf8qxNv7a5J4hS9DIMMGFY+ipf91t8
	cBD6dhrQZjVailWvgxfdOUKIbbTUjeBw1XDccVJ0nibwn9zRKwvC9xS0iW12Hmo4YPiE1YlL0sa
	Gz4DY7toY1a7RMst9BkHhx8q9jjBulJVyj1UWyddY0I+mhCR+Q8in7PfRiZIZJjfSyok=
X-Gm-Gg: AY/fxX5hGhST1p0iNAgm/ZMTZPIYVaYkXCm9UH7AS/DbFLxLgMP79Mvve78Ams3Q6Q5
	wwB0aMwXAzsKy6DcFXT7iG1siBgLFFgzIHi5gXxFZ1bQM6I3X/CbBzP/UfK8XgBuuJ/cUVE1TUx
	/4x/MiJCAZXo/IK1qhyEWXNGwEPXZ6KGpeJVIFFmmXyX6Ny1D6X88RuNorfmt6oM26xxBeDWFd1
	U6765VI11HyHbEUtmogITqI/PzhrLPLXQMb/7xIMviTVx9Rgxd5kk/VCCAwXmIoA9Qzd95NpSBi
	bVvCc0Dg5vY+PsUKgyAhzOhrb18WXVLwMqUJ+meqrOWtX8aiQWzWq2+7tVnsD2R0tHO5bJ1aHaB
	DG+OcEyImZQTe5gHHBywVEYV0IIoRoRyC/tkIrWwTeHxETcgIG9woPeUT
X-Received: by 2002:a05:620a:4589:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8bb3a2495abmr2603900885a.74.1765990978821;
        Wed, 17 Dec 2025 09:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBDyuzbsCeW4xAU+wI9KUPEJo+vLDUjXrnECfI5NKbMOzF1M5IO7XVO1lPhXKQQ68k4qHxJg==
X-Received: by 2002:a05:620a:4589:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8bb3a2495abmr2603887585a.74.1765990977564;
        Wed, 17 Dec 2025 09:02:57 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c75b45sm430186385a.52.2025.12.17.09.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:02:57 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <198cec94-6d2c-46c0-a46a-9ab810deb7e0@redhat.com>
Date: Wed, 17 Dec 2025 12:02:55 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/6] cpuset: add assert_cpuset_lock_held helper
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251217084942.2666405-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 3:49 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Add assert_cpuset_lock_held() to allow other subsystems to verify that
> cpuset_mutex is held.

Sorry, I should have added the "lockdep_" prefix when I mentioned adding 
this helper function to be consistent with the others. Could you update 
the patch to add that?

Thanks,
Longman

>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   include/linux/cpuset.h | 2 ++
>   kernel/cgroup/cpuset.c | 5 +++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index a98d3330385c..af0e76d10476 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
>   extern void dec_dl_tasks_cs(struct task_struct *task);
>   extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
> +extern void assert_cpuset_lock_held(void);
>   extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> @@ -195,6 +196,7 @@ static inline void inc_dl_tasks_cs(struct task_struct *task) { }
>   static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>   static inline void cpuset_lock(void) { }
>   static inline void cpuset_unlock(void) { }
> +static inline void assert_cpuset_lock_held(void) { }
>   
>   static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
>   					struct cpumask *mask)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fea577b4016a..a5ad124ea1cf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -271,6 +271,11 @@ void cpuset_unlock(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +void assert_cpuset_lock_held(void)
> +{
> +	lockdep_assert_held(&cpuset_mutex);
> +}
> +
>   /**
>    * cpuset_full_lock - Acquire full protection for cpuset modification
>    *


