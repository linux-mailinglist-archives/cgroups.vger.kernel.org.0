Return-Path: <cgroups+bounces-12223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31993C8BAFA
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 20:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 471B44E54FF
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083721CC51;
	Wed, 26 Nov 2025 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6GBQsPG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oDLsx5W+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5621E572F
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186465; cv=none; b=jonRlQUPb4sv5uOb0phFxLxkE4ngs6mA4s5Ra/QndjJtlnsMPkqYHMAJYS9BojLK8rRzcPjnZfBIfLIsNbd+KArtGoxaezK5Rgf18xjvLYmczbsaoOvwf3tzVjR4QinT+CQC2N9leX+qEpAR+9cmmthHbyVxPvMp1OrUK+/kbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186465; c=relaxed/simple;
	bh=H0Raj8bCqIFy34jb+PSSirLLFnAevg0X5tuM3UuKiwQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mk7olx2qK6HVg1oRpcca2oYIUzJ1CBYaoQSWowD9/3A1UzjYZZnJtyu9nSEsHqkiZYl5DYZeSRXa5/qXXYZRoowtnCpYOQ2im/jIWui0QfTdV0ThxBfLutOhxB9VQHaQ0s15He7kh7/Cm2hezPloIrOCd4dST5h9qjCVd2LVMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6GBQsPG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oDLsx5W+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764186462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaHKoDXDVLWZdBdMfSh8jwakrweAtMjUSMOWyc8lJu0=;
	b=f6GBQsPGjqXpKtI2gQmJZlMFn17zO3LkH6f8UC/IK5xqNnY/BJzCQ4McoQb+3vf9xcG9Dd
	dN/6w/BqtuO2x6aQmTWIGK5p2XsK94I+EOcWeSe1R4N1SY4O60ufZp6XeNgBvPoqptw3Cd
	0kSJIP017wTKqOEGAF+M6RynoWM1hfE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-i2zuC9yKO-mnJBOAxIy3NQ-1; Wed, 26 Nov 2025 14:47:40 -0500
X-MC-Unique: i2zuC9yKO-mnJBOAxIy3NQ-1
X-Mimecast-MFC-AGG-ID: i2zuC9yKO-mnJBOAxIy3NQ_1764186460
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b245c49d0cso18390685a.3
        for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764186460; x=1764791260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iaHKoDXDVLWZdBdMfSh8jwakrweAtMjUSMOWyc8lJu0=;
        b=oDLsx5W+hsle2XytYsSC23W9PwM9QcZGc3YatUjwR6ORIWCcvAZ5+R+4KjVr/ePYUn
         TUZ49OBCFdOU/yrF+NDT4H9dOmfBmt7a5qnqyBgKIqRMTOOHP8v4OuOno3rbCMqrMBb7
         zZi28a54YmEO8KNYCLr6OEf+Ubr+EBn0HndFbe79AzyvzMjB+Z7qatGwZFdGQz7xE4yh
         X58hoTl55vYUmlUgogIvIq/iODIUZUEfZKtHMzihsm6jheSTvKZxEn5+xYBv1toshC4I
         7ogDX6eZjWa0x35pnPn7S/e4Qfjy5XEM4lV6kqbfqLaDGEKmfl827uRmSB5nxizawdiK
         utlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186460; x=1764791260;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaHKoDXDVLWZdBdMfSh8jwakrweAtMjUSMOWyc8lJu0=;
        b=mas+HaYUnhkj74CqN4dLbrg6n6LNeFcKdcvQx0msuzlcK8pTzHNVkdPsYr1dw31nbU
         d+ZP1hebHNROjXOVcz7uXEvZLW7MsomgB3mAUanjbaoyfs8/IGukWqI0dIKFO1tySE1X
         awq9kcuBNKshoOmrA0ctdXKOfXbuGLWcu5VRxmUfikHRtd1tPu4HWwmr4tWDaHSSf2op
         0wgUSITQajeE7HFYSk4M4/s3Y/NBBr645yWEnVuriu3253kSz1ApI7115Jkdxac52S1Y
         WuJXGquoiAPA8GBnI+yjg2FO8x2mJBt8hLBtD/w6bb0jG8JaL/q/Zzj0j2SsBi2s/evB
         KIyw==
X-Gm-Message-State: AOJu0Yx4tAofSrWFi3L/RjEGNnr28h7q7/XRYtU6lPWQ8KQxWrbHcrHj
	igLAF6dl32ZxYsmZi7cQzRUAQ2+9Xn2+pX4rQH3hmRjqDIRI8XywwQ8snVh/h3SuXgShys5uQJh
	FCz/LYntUmXu3lPYaaKBci5TlW2WRW54lRqDGhtX41x6sU945OhGLYXi2Pps=
X-Gm-Gg: ASbGnctjWNy5m5BOS5QZlEOVvV02flTjlcDQc7Grhbv0MP1pUd2kF8Gwa8YSVlKob4U
	5cgpX8IJ86cRLSbJMJeTLCFEtIIeyf8q/OpwxVWYKVHRCjpAhAutQlxeRqvO+4U/PoCqIoBC2Zn
	MW28U/iHwZbJe6XTApArcB8W5O8zLkQ16S9xHhLPokUtr2/manL9BRC2ZkDgEUbUDNMp0o2KG7u
	+pZjpiaoVu3SCbEuMGUF+glB60Jx0q9gUj/RjmmRsJmhuAcl+u1Nq9CkAO59N4yE3Rc4bL8TGqf
	J0eks4IMJ6jTe1S1ZqVjJr+Tj4aEP/a/LBQdT1dXEXCnmyH9Fb4vihn2//RQKEBwj6pXKe2xfox
	ZnwAM4dWLdlMXoA3ccdzSF2g1cBcpjR2PpLjtAg3hoxAmj42X+RDZ0H/D
X-Received: by 2002:a05:620a:2688:b0:89f:27dc:6536 with SMTP id af79cd13be357-8b33d469962mr2741182685a.54.1764186460324;
        Wed, 26 Nov 2025 11:47:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvZykvr0qlMCEyFnfOp+tDAsx0ZdcxQU7yaQpksE/e0f0PgiawBdGyHyhujR4xREckKUx0xg==
X-Received: by 2002:a05:620a:2688:b0:89f:27dc:6536 with SMTP id af79cd13be357-8b33d469962mr2741178585a.54.1764186459842;
        Wed, 26 Nov 2025 11:47:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e69f3dsm130251161cf.25.2025.11.26.11.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:47:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <518ffa19-fcb2-4131-942d-02aa8328a815@redhat.com>
Date: Wed, 26 Nov 2025 14:47:37 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251126091158.1610673-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251126091158.1610673-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 4:11 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Commit 406100f3da08 ("cpuset: fix race between hotplug work and later CPU
> offline") added a check for empty effective_cpus in partitions for cgroup
> v2. However, this check did not account for remote partitions, which were
> introduced later.
>
> After commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug processing
> synchronous"), cpuset hotplug handling is now synchronous. This eliminates
> the race condition with subsequent CPU offline operations that the original
> check aimed to fix.
>
> Instead of extending the check to support remote partitions, this patch
> removes all the redundant effective_cpus check. Additionally, it adds a
> check and warning to verify that all generated sched domains consist of
> active CPUs, preventing partition_sched_domains from being invoked with
> offline CPUs.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 50 +++++++++++++-----------------------------
>   1 file changed, 15 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e6eb09b8db6..fea577b4016a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1103,53 +1103,33 @@ void dl_rebuild_rd_accounting(void)
>    */
>   void rebuild_sched_domains_locked(void)
>   {
> -	struct cgroup_subsys_state *pos_css;
>   	struct sched_domain_attr *attr;
>   	cpumask_var_t *doms;
> -	struct cpuset *cs;
>   	int ndoms;
> +	int i;
>   
>   	lockdep_assert_cpus_held();
>   	lockdep_assert_held(&cpuset_mutex);
>   	force_sd_rebuild = false;
>   
> -	/*
> -	 * If we have raced with CPU hotplug, return early to avoid
> -	 * passing doms with offlined cpu to partition_sched_domains().
> -	 * Anyways, cpuset_handle_hotplug() will rebuild sched domains.
> -	 *
> -	 * With no CPUs in any subpartitions, top_cpuset's effective CPUs
> -	 * should be the same as the active CPUs, so checking only top_cpuset
> -	 * is enough to detect racing CPU offlines.
> -	 */
> -	if (cpumask_empty(subpartitions_cpus) &&
> -	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
> -		return;
> +	/* Generate domain masks and attrs */
> +	ndoms = generate_sched_domains(&doms, &attr);
>   
>   	/*
> -	 * With subpartition CPUs, however, the effective CPUs of a partition
> -	 * root should be only a subset of the active CPUs.  Since a CPU in any
> -	 * partition root could be offlined, all must be checked.
> -	 */
> -	if (!cpumask_empty(subpartitions_cpus)) {
> -		rcu_read_lock();
> -		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> -			if (!is_partition_valid(cs)) {
> -				pos_css = css_rightmost_descendant(pos_css);
> -				continue;
> -			}
> -			if (!cpumask_subset(cs->effective_cpus,
> -					    cpu_active_mask)) {
> -				rcu_read_unlock();
> -				return;
> -			}
> -		}
> -		rcu_read_unlock();
> +	* cpuset_hotplug_workfn is invoked synchronously now, thus this
> +	* function should not race with CPU hotplug. And the effective CPUs
> +	* must not include any offline CPUs. Passing an offline CPU in the
> +	* doms to partition_sched_domains() will trigger a kernel panic.
> +	*
> +	* We perform a final check here: if the doms contains any
> +	* offline CPUs, a warning is emitted and we return directly to
> +	* prevent the panic.
> +	*/
> +	for (i = 0; i < ndoms; ++i) {
> +		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
> +			return;
>   	}
>   
> -	/* Generate domain masks and attrs */
> -	ndoms = generate_sched_domains(&doms, &attr);
> -
>   	/* Have scheduler rebuild the domains */
>   	partition_sched_domains(ndoms, doms, attr);
>   }
Reviewed-by: Waiman Long <longman@redhat.com>

Thanks!


