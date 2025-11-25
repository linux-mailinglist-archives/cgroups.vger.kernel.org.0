Return-Path: <cgroups+bounces-12196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C512DC86891
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378DE3B23D9
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEABF32B98C;
	Tue, 25 Nov 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtiOWrXQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZhu6cWj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BA32D0C3
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094603; cv=none; b=sOZOtIeL1t/5stN8Y/xPT+9yVT2HCscIEgjsCvbafnLP0SmHs087d8eQ0ZtClI6T7Il0bMTO12hdLY7HZTUx6G23YefPYDgQXUii8rMIxnJEDWMSTZHuxGlTpOHeNMebsvtwujV2/5r5qgVz15rsfCiLeAFQ0+2VnONN2Afkl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094603; c=relaxed/simple;
	bh=kvui9xgPWoiqemLTJyDjkO5Xx1leEZGS5Rv+uwrhZFY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eb5/ram3vFFnncN+dk3TAPw8lC+aCOJVNGe4cd4N728uWMxM2rIRSLeetTx3MbaiblcDQdCxOD3fGtvMDT7SV1Cxto82v/blqQRluInuRc01J3z8W+L7mdVjqrLZ9WX+O12XDZqo0N3AWORUbUPIKI3cHb4dsyDp6++/fqf7rcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtiOWrXQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZhu6cWj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764094599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr1RL9jnaD4qqibeHFr2BzTNvUKOajxymYnHio0mwzw=;
	b=YtiOWrXQbsmKH2FLmCuZ7HYXeHsvG2n0X3ZN2k4aEsDLnQB8JZ8AP3G41pn3imHhhyRLkm
	nWpnIkltan2Ob5oudMzRTWer2qhgYNXke9NgXn5J89swrVA0kbQbID/bQoV8SeoVbanAmq
	eF7nCc/crRZ/wYfZGhgR1WFQBZhIZGs=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-3eK9gE6mOI6-gk0CxcdcRg-1; Tue, 25 Nov 2025 13:16:37 -0500
X-MC-Unique: 3eK9gE6mOI6-gk0CxcdcRg-1
X-Mimecast-MFC-AGG-ID: 3eK9gE6mOI6-gk0CxcdcRg_1764094597
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-55b29194c04so4230708e0c.3
        for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764094596; x=1764699396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kr1RL9jnaD4qqibeHFr2BzTNvUKOajxymYnHio0mwzw=;
        b=AZhu6cWjzl1ZKMwK3eLSDeB8RvQlAEyRQMI+d146CbEWTaSkTx7stJo/877eQUxJ26
         Y118dKD/OEA6/69ziwjGk3InwfNCViMk0j8eAlzXkSc7meEfys4Qgx+CcZgjfweN0CGP
         7krGsSceGtgtTXz8bWndhx85ty+8qOjCdVbw6VADkASYPq0X2VwBlHd6M5MwPzzNuXzY
         YaVhT++idQZ915JVurd06kdkWZHUqtkoJyMtTfWAtjwkF5ebiefyplEsvYUGke8tjg9T
         jcTTeRX7mqM8UhAhmn7dtSsrqMLcIAhaq5dWOhS0fjT9S2N8xehOx8rMDBvbCB37u7KR
         cc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094596; x=1764699396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr1RL9jnaD4qqibeHFr2BzTNvUKOajxymYnHio0mwzw=;
        b=Zt1g3VNASka74F1QWjukPzBkivFZs0PYDf9KOeytso0zlnsuyfRJLMNpOrUtsudyym
         rLv8ETdhOnAfqeYhaP+vVRtLiU27LY1hoN1aMjN2sY9lwxjKNwtadtUz0ykkJ1cQNMeb
         BGMERnqOfrRNKm/NxqlVv1zoXnZGveAHnNq3atNcIy7Y1vxfHqc1ilOxSTqWhUZU5jLP
         M2SOCdCZQWJps+cuoTeWK8F0WCuD+fjfzorXnN4tTm6tnOvY0L+0/+9fFodmUvF2cIGm
         DkshMkdPqBKFxt+M9/fkxYCC4h8bBQhHhwPPRIRjyCLwPPtwFfxT8EyIA81FrgGDAgIG
         zOzg==
X-Gm-Message-State: AOJu0YzD8UpZHUJIi1iyv8GcKwZ3o9T0iAcAB1tMp8fo0YTpHxGCirrV
	xaYACeWVW6J6y8YYH8lunkUkKwf2vndDuaDoiMB9QojkyYHa1scfkWUC3HGwi9SCL9wjA3Puqpg
	YkvppKo3bMBv7UfQzImevwatC8ouYLRzN8Ul/jR0WQeYVh3tQ2QSLKkVTON0=
X-Gm-Gg: ASbGnct7TTvzfKJdDFGa/Rt4kOUD+THQ+lVAwBpvJD+D9Pqn/HHrGrJBvdVUbH6MgwL
	Qcu7kiRt/lxXpo4K/DrIz5MZtAoS1pEVQNZKN/DNzuWx2CF8lBxsg8zD7d0e4XIl+BxVwswVpgI
	elS0vAoH7eJ+UrSdtSkwS5dnAoQWIKoz/av8+kz1vbVfnZ/th1ymkA/3ZtlX30TmJiZeVGQ8qn2
	2Yxs6qEkI08EBrWJnfm61Xh7hwJtQcjhkg/0J270wE1yUvw0fInhLhcPrcJibIsC8Ve3Lzx24wF
	zfjC8a4myZCGmR6yc22eDs2foxs2DurY9qMhLCYm7lCWiBmxzT6FaI3Ca4pn2HfF51s8fH/yV3l
	tesULBg/pMUjRdAA2v8/eAHCpNvxW6nT8Y//tdDMJ+Q==
X-Received: by 2002:a05:6122:891:b0:559:6e78:a43a with SMTP id 71dfb90a1353d-55b8ef46ef0mr5728379e0c.9.1764094596627;
        Tue, 25 Nov 2025 10:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1ZB7q/ZOXG/y2KuRQffSAQEhVztGzfYYlmo1J0mCN+2L8CuJlBcRweI3SS02SzlwfhAM7WQ==
X-Received: by 2002:a05:6122:891:b0:559:6e78:a43a with SMTP id 71dfb90a1353d-55b8ef46ef0mr5728321e0c.9.1764094596119;
        Tue, 25 Nov 2025 10:16:36 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee4905d285sm109405931cf.14.2025.11.25.10.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 10:16:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <27ed2c0b-7b00-4be0-a134-3c370cf85d8e@redhat.com>
Date: Tue, 25 Nov 2025 13:16:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.m.jordan@oracle.com, lujialin4@huawei.com, chenridong@huawei.com
References: <20251118083643.1363020-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251118083643.1363020-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 3:36 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Commit 406100f3da08 ("cpuset: fix race between hotplug work and later CPU
> offline")added a check for empty effective_cpus in partitions for cgroup
> v2. However, thischeck did not account for remote partitions, which were
> introduced later.
>
> After commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug processing
> synchronous"),cgroup v2's cpuset hotplug handling is now synchronous. This
> eliminates the race condition with subsequent CPU offline operations that
> the original check aimed to fix.
That is true. The original asynchronous cpuset_hotplug_workfn() is 
called after the hotplug operation finishes. So cpuset can be in a state 
where cpu_active_mask was updated, but not the effective cpumasks in 
cpuset.
>
> Instead of extending the check to support remote partitions, this patch
> removes the redundant partition effective_cpus check. Additionally, it adds
> a check and warningto verify that all generated sched domains consist of
"warningto" => "warning to"
> active CPUs, preventing partition_sched_domains from being invoked with
> offline CPUs.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 29 ++++++-----------------------
>   1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index daf813386260..1ac58e3f26b4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
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

In fact, the following code and the comments above in 
rebuild_sched_domains_locked() are also no longer relevant. So you may 
remove them as well.

         if (!top_cpuset.nr_subparts_cpus &&
             !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
                 return;

> @@ -1107,30 +1106,14 @@ void rebuild_sched_domains_locked(void)
>   	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>   		return;
>   
> -	/*
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
> -	}
> -
>   	/* Generate domain masks and attrs */
>   	ndoms = generate_sched_domains(&doms, &attr);
>   
> +	for (i = 0; i < ndoms; ++i) {
> +		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
> +			return;
> +	}
> +

If it is not clear about the purpose of the WARN_ON_ONCE() call, we 
should add a comment to explain that cpu_active_mask will not be out of 
sync with cpuset's effective cpumasks. So the warning should not be 
triggered.

Cheers,
Longman

>   	/* Have scheduler rebuild the domains */
>   	partition_sched_domains(ndoms, doms, attr);
>   }


