Return-Path: <cgroups+bounces-9623-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6D6B40963
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14A47AEA03
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006DE33438D;
	Tue,  2 Sep 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXJ1v5/h"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990432ED5B
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827847; cv=none; b=PtBw/Bj+YKci1UgFJbJ3Wgy3Fx5AtXFo/twbWD85Utp1rKBxCiJir3mkAPIfxMZV+FMFwfhEVpQixPKEw0V5RdiGEbFZCdE2HYVh5g/sQN5qZCIZGAHqyEhQkVIsUxsq1MTrRcXPgEroB4LuBfmXPJBIkNptDvilQo0Eeo0Fw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827847; c=relaxed/simple;
	bh=nCOD/GgJeF9jFumtQqGF2tdEx3YT1s+rTWk1dHIavmk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nZcVj3LRT7S8r62RSDk9YIKf5395DzkKhf6hxezOdAZY0mOcNDIhFTCCIdzjn1nHoJoAQHN8TFKDW6bRlFRTbbflImwbf8Rl1+0eTqKzrKMQyvIvbrgEVSkmar9N7TH0y1tiop+Dv/X+qM5Zcv/c1GVrPFp5hiszHk65a21k8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXJ1v5/h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756827844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7v6IZWbDzzjbXLUhKiCpcBQpIRj6qcPMeJox/MtUR4=;
	b=BXJ1v5/hzs/mPGwJpwsBZUDy/ETA6zXqixixZkUDt+MLZSfAWdrQd04lGKLqHP5R1tleqi
	e4PZbNqKQtdE2ymwSISvIG3NwGH4L1MrZb+n6umo0beXHP6nMdhIcEHVvwdphYo5RSLY4y
	QTdmqBiBkzNSWs7qrlcAYm4gj+Iz/FA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-tDnm1lojNJ2XXPhdAni6sw-1; Tue, 02 Sep 2025 11:44:02 -0400
X-MC-Unique: tDnm1lojNJ2XXPhdAni6sw-1
X-Mimecast-MFC-AGG-ID: tDnm1lojNJ2XXPhdAni6sw_1756827842
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70de0bdb600so91334426d6.1
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 08:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827842; x=1757432642;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7v6IZWbDzzjbXLUhKiCpcBQpIRj6qcPMeJox/MtUR4=;
        b=BApguVKNOlctwOLBDeQQPvGUMGKNfehelGaFLZQ5+jwkde6LbWDZ3p3yYllzVc3TMg
         UyRe9T1nzngBDZWD7gEbTIX8w/8WCOFW4SZfbTnSUhFy51CQBPRp0XZI4EUmBo5B+UoS
         +bMkszRLTlfXisf1HdIbgNkaIOgp6hat3a9zIJYkMpe3xCdvVGsWysjaE5q4y8dvc3KO
         NTihaPSKWClfuusvms2XkpY4joIuIH1URbU3tbUucHQbPAzEyHLtJvou92zUliQrlopw
         XCMSQJcskue5QTzEnFJvBdt+gwWXbU1VePAg2SOFy30XZudrSPjvNNoS7TrsqdbjWYRX
         VqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvj6gxTKYMcqqxuWtPQ7NPJAGOT68HBMuNlA6QfCSg0Ab/syow5LPOQTheaW8yXE4XgOHazzP8@vger.kernel.org
X-Gm-Message-State: AOJu0Yymhk+N++YVvWt+Xz80eCuXVKMQUijmD7YTg1LPdYNvnpgEvx54
	QrVEuprYqmMpRowwRvwqFi4zocakrMRFFuedRbJntpo0v5meHkZE08f3IlZWDWxoxGzMbQY16gE
	kizOYbKWDnh5bwoyaxhFhCAvG3Jeo5L96ZVwKoevRakR4G3usq79+5u9FJxA=
X-Gm-Gg: ASbGnctyyFUIjxnZIlQloVSJ4M0V0g9kG9YPNwqfTCoO0GlwDwwQNCLAvGg4TrYBmtM
	Zhf5oZMRzp7PeBeCWvxCqrZ1D4poGwD4ZSVcIDYelXydC2UUgotBTl0eA2d76PD/oGJKiYAb8zq
	RHO1X/Fmiz2j/HWqGmZzi1pnKCro3Nfqkm8Y2xdH2e21kAvgUzODdVd+cAe8YVY7EWdYtrA9Mo/
	D3g+ZuENDwOUqyjLhwgujKe7phG1eY9yBz2HSSMLn0C/KD1HhEuQJl2wL2ZG4hWZZ3S9ESWVgml
	uad/aOYXSyzaYRMRfXL+GVrm4sQSvB3crIXTZq3o4bFNBFOixjtQKuBkGEsD4FFkvNC1B+NOqUB
	R2EX4kkIKqg==
X-Received: by 2002:a05:6214:4019:b0:70d:d5eb:cb09 with SMTP id 6a1803df08f44-70fac741625mr120651886d6.20.1756827842200;
        Tue, 02 Sep 2025 08:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiGCzvqsDFaL+2XUR0jmbF3BnfpeLZNOh8MzFtgTYm01Gnbfw1aHMydaJvOj0Teny7OPG0Rw==
X-Received: by 2002:a05:6214:4019:b0:70d:d5eb:cb09 with SMTP id 6a1803df08f44-70fac741625mr120651506d6.20.1756827841738;
        Tue, 02 Sep 2025 08:44:01 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4947b0fsm13770536d6.46.2025.09.02.08.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:44:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6457dd87-95cb-4c4d-aaab-6c9b65414a75@redhat.com>
Date: Tue, 2 Sep 2025 11:44:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] cgroup/cpuset: Fail if isolated and nohz_full don't
 leave any housekeeping
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 cgroups@vger.kernel.org
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-27-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-27-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> From: Gabriele Monaco <gmonaco@redhat.com>
>
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
>
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index df1dfacf5f9d..8260dd699fd8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>   }
>   
> +/*
> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
> + * @prs: new or old partition_root_state
> + * @parent: parent cpuset
> + * Return: true if isolated_cpus needs modification, false otherwise
> + */
> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
> +{
> +	if (!parent)
> +		parent = &top_cpuset;
> +	return prs != parent->partition_root_state;
> +}
> +
>   /*
>    * partition_xcpus_add - Add new exclusive CPUs to partition
>    * @new_prs: new partition_root_state
> @@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	return isolcpus_updated;
>   }
>   
> +/*
> + * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> + * @new_cpus: cpu mask for cpus that are going to be isolated
> + * Return: true if there is conflict, false otherwise
> + *
> + * If nohz_full is enabled and we have isolated CPUs, their combination must
> + * still leave housekeeping CPUs.
> + */
> +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> +{
> +	cpumask_var_t full_hk_cpus;
> +	int res = false;
> +
> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		return false;
> +
> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> +		return true;
> +
> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> +		res = true;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}
> +
>   static void update_housekeeping_cpumask(bool isolcpus_updated)
>   {
>   	int ret;
> @@ -1453,6 +1496,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>   		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    isolcpus_nohz_conflict(tmp->new_cpus))
> +		return PERR_HKEEPING;
>   
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1552,6 +1598,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>   			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 isolcpus_nohz_conflict(tmp->addmask))
> +			cs->prs_err = PERR_HKEEPING;
>   		if (cs->prs_err)
>   			goto invalidate;
>   	}
> @@ -1904,6 +1953,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			return err;
>   	}
>   
> +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> +	    isolcpus_nohz_conflict(tmp->delmask)) {
> +		cs->prs_err = PERR_HKEEPING;
> +		return PERR_HKEEPING;
> +	}
> +
>   	/*
>   	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>   	 * only).
> @@ -2924,6 +2979,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (isolcpus_nohz_conflict(cs->effective_xcpus))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it

In both remote_cpus_update() and update_parent_effective_cpumask(), some 
new CPUs can be added to the isolation list while other CPUs can be 
removed from it. So isolcpus_nohz_conflict() should include both set in 
its analysis to avoid false positive. Essentally, if the CPUs removed 
from the isolated_cpus intersect with the nohz_full housekeeping mask, 
there is no conflict.

Cheers,
Longman


