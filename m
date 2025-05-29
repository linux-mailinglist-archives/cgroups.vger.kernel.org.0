Return-Path: <cgroups+bounces-8386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0CAAC7799
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F44E4637
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05421B90B;
	Thu, 29 May 2025 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyGN4Jvj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A713AC1
	for <cgroups@vger.kernel.org>; Thu, 29 May 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496195; cv=none; b=K4b5J2os0Win4ap7Tzu/l/gCIngLTBi2PHRzc4jMCZPX+a7STcW/KNUZn4j4ktM8gycbWszIqTCvIL3jlOB+vrz3tZ1NlAsJ68gfIxyrQb2CuCDQDhlyWHcSCOihaxvcY4CI1YMOBiPEs7VaU5bfbgegYaypJ9hOzxr4L2RAMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496195; c=relaxed/simple;
	bh=HPWnF681xrF7dRy5GHtJdMGGmQCOYgSrE1oEli8DaYc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qmp6BbBGNK/TUnD5A14F0UsHAdgWAhjw+1tChVdsalPBSvpOSgZeqV4WMZwlIfqrftITDr4WGxWdhWHZD1SADn2oUHoBqOEvaAgByjRivlhEUFz1JPntOAvJw59qmQis1SFYbGrUIu5GHJUiA7xcjVu7GMkxmrTX/CWqavOk1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyGN4Jvj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748496192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ve9B8auhdwoIyDoCiwdQzeIKouOsgdKN3AISgA9FEU=;
	b=QyGN4JvjSfBDkonE5whIYqvPFowrsfDQKGfVUlGGJdhAzSw5WhsxhIZ49t9x1nXAldZkpd
	qhnWYTyQlHaJjTJplJ/2dZl5G/YrS6qingmgufWL//Vcg6rF7g1PLlylYrv3Pkrrd8eIuk
	kBLrde1U1EneTpLw54YdDd2w7L9+H6I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-lSmGvYd2NHKsCAH4tL4PsQ-1; Thu, 29 May 2025 01:23:10 -0400
X-MC-Unique: lSmGvYd2NHKsCAH4tL4PsQ-1
X-Mimecast-MFC-AGG-ID: lSmGvYd2NHKsCAH4tL4PsQ_1748496190
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-476623ba226so8129111cf.0
        for <cgroups@vger.kernel.org>; Wed, 28 May 2025 22:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748496190; x=1749100990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ve9B8auhdwoIyDoCiwdQzeIKouOsgdKN3AISgA9FEU=;
        b=udoMZluOb3CMKFkcxkh0j5wlEDj0HyA+rsTEPWtEtYFfCpbI6EZ9v3qkkwoVIs+pV1
         buLWf3I/4YpX8Y6OZEy3jKnPy4TcvDnkua/es/eXWrVxDudI8vZvH28Xcca5k3umiaER
         1BM/A0lS6UoYwuLRN6z/9PYIuVAYKGHpuMJW69UbWSt6htl5jYCIFOwakm5wC66EhWkz
         r16a+qKn683AFn+PkisxLZ2e9AM3+O+Bc9Tv96UduVdvT+fm/XuH0jQMyo7TTvPkwzvX
         HK9YLYUoDxrp4y83sIrA4mrgPs5TC/WTsYMSDbH1p5zI2MQag9y7l3BUXBzGO1qcACkT
         zEGQ==
X-Gm-Message-State: AOJu0YyhfsOUGxlDBWLW81nnzJqzzrL/1AnDiBJGTvuceC+H3fBXu1ue
	2HSe2lY5R9aePtFQ5I+OnqurhhxcOkHnUWGkGQR+8auCTHVTsR8mAckd6mRo9WnvXlq69S52o+e
	JwZf9Pzck3QDSSKFddOUQdRMj7SL/zC2eL0I+pl2VIdKByV+4wNkmJ3EzZnA=
X-Gm-Gg: ASbGncvslwLrzCG8ixtyJpmhAtfd16PIAvSu9U9yhUABHZGTmKDrFrqjStO0tq43SUL
	YNpJNi6Qc5YGYyjcPFgrA+yS8ycFbcU08GaFpirTgRqj7PpdAthcJMDUBAspYJOI0q9XiTBxU6r
	gCrUfLYKCfbQg9zEN9jXIQyG+q5WO4U2TtAleSJ8roKjJqafsh5h5LrXHFUfa1nMbmUR7FDxXFW
	KO/hyWETLCXSuEY8ndP4iCXETkuOFXZ8RoiwVMVI4fmnpDqo3pl5OQ8TQRiUxE1tD1Ks/GXvYoL
	X7j0BiVyhfPV
X-Received: by 2002:a05:622a:17c8:b0:477:6f1e:f477 with SMTP id d75a77b69052e-4a4370e9259mr12836311cf.19.1748496189691;
        Wed, 28 May 2025 22:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNyMcgSb+tq5l7TItwFkXj9s8Aax/qLbo0IJqkIIHRYPClYDPvWpOmgdKirrkkYTAOOa/lAg==
X-Received: by 2002:a05:622a:17c8:b0:477:6f1e:f477 with SMTP id d75a77b69052e-4a4370e9259mr12836021cf.19.1748496189371;
        Wed, 28 May 2025 22:23:09 -0700 (PDT)
Received: from [172.20.4.10] ([50.234.147.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a840bdsm4414541cf.77.2025.05.28.22.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 22:23:08 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <35bd4722-cd02-4999-9049-41ba1a54cade@redhat.com>
Date: Thu, 29 May 2025 01:23:06 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
To: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, llong@redhat.com,
 klarasmodin@gmail.com, shakeel.butt@linux.dev, yosryahmed@google.com,
 mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250528235130.200966-1-inwardvessel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250528235130.200966-1-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 7:51 PM, JP Kobryn wrote:
> Previously it was found that on uniprocessor machines the size of
> raw_spinlock_t could be zero so a pre-processor conditional was used to
> avoid the allocation of ss->rstat_ss_cpu_lock. The conditional did not take
> into account cases where lock debugging features were enabled. Cover these
> cases along with the original non-smp case by explicitly using the size of
> size of the lock type as criteria for allocation/access where applicable.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Fixes: 748922dcfabd "cgroup: use subsystem-specific rstat locks to avoid contention"

Should the commit to be fixed 731bdd97466a ("cgroup: avoid per-cpu 
allocation of size zero rstat cpu locks")?

Other than that, the patch looks good to me.

Cheers,
Longman


> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202505281034.7ae1668d-lkp@intel.com
> ---
>   kernel/cgroup/rstat.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index ce4752ab9e09..cbeaa499a96a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -47,8 +47,20 @@ static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
>   
>   static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
>   {
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
>   		return per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu);
> +	}
>   
>   	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
>   }
> @@ -510,20 +522,15 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
>   {
>   	int cpu;
>   
> -#ifdef CONFIG_SMP
>   	/*
> -	 * On uniprocessor machines, arch_spinlock_t is defined as an empty
> -	 * struct. Avoid allocating a size of zero by having this block
> -	 * excluded in this case. It's acceptable to leave the subsystem locks
> -	 * unitialized since the associated lock functions are no-ops in the
> -	 * non-smp case.
> +	 * Depending on config, the subsystem per-cpu lock type may be an empty
> +	 * struct. Avoid allocating a size of zero in this case.
>   	 */
> -	if (ss) {
> +	if (ss && sizeof(*ss->rstat_ss_cpu_lock)) {
>   		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
>   		if (!ss->rstat_ss_cpu_lock)
>   			return -ENOMEM;
>   	}
> -#endif
>   
>   	spin_lock_init(ss_rstat_lock(ss));
>   	for_each_possible_cpu(cpu)


