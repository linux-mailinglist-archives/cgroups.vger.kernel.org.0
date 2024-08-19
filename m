Return-Path: <cgroups+bounces-4352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F379573C7
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CBE284FFF
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D03189BBB;
	Mon, 19 Aug 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX/SPZgE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD620189914
	for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092997; cv=none; b=RqKgmatFxGP67LJJ3Oj/FT0LVzAqQRPnapPNvUDVDp+c4BocQNxtT/vkbGP8r+VVsJOwS9FY4WUS2rAKmrvGmYT3CisJyomCTE2CurwYseZXNnHYrqcpVhlSTgCnsYK4NhIRGoOK9BaahIFN2M74yfOa8ZcKMBceCkacM6Yt578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092997; c=relaxed/simple;
	bh=ZA4Ddu6RTLMYnTBOiugiqP4MrcYzD3TCTNr77tOlBZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKkaj1UaVi+aLqGkcELFIa1+8/kDDFXLEoEs0VLwlpTdHjp7+lHQmXk5nmtv0Ztt5e2o5VurHnQaHu456uM2Y14GMCw6ii2e+iwzmWnr9MkeyS08ckw84rzy9S0YGVCI8/0+oLByCEYqkTRsNn+SGK+TPH66IhF3MU0LKmj9/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX/SPZgE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724092995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntqvq2bnjwCbw4hyu3UVPxjEzgOFDjLoy4IE9avUl8U=;
	b=CX/SPZgEOsHW/NxrWfTJH34ggEYVQjVwHlPT8E4vv3CzdYG/Zw3AA/eVETtakB8mewGtKh
	ad/o7jsi5RiYYOSXYQzj2s7g2fTkDM5BbN+8Ggq18xC0fXbMBSzTs0APSDHOEp1DLLCHJp
	rQGYqY+5cEtTebKmYKD6jXPj4tG7OZM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-Q3HetUM8MQuL4Fd7RTJerQ-1; Mon,
 19 Aug 2024 14:43:13 -0400
X-MC-Unique: Q3HetUM8MQuL4Fd7RTJerQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F8B71955BFE;
	Mon, 19 Aug 2024 18:43:10 +0000 (UTC)
Received: from [10.2.16.112] (unknown [10.2.16.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EC7D1955F44;
	Mon, 19 Aug 2024 18:43:07 +0000 (UTC)
Message-ID: <ca2721e6-b134-41a1-b303-988ddfe057b1@redhat.com>
Date: Mon, 19 Aug 2024 14:43:07 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] cgroup/cpuset: remove use_parent_ecpus of
 cpuset
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816082727.2779-1-chenridong@huawei.com>
 <20240816082727.2779-4-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240816082727.2779-4-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/16/24 04:27, Chen Ridong wrote:
> use_parent_ecpus is used to track whether the children are using the
> parent's effective_cpus. When a parent's effective_cpus is changed
> due to changes in a child partition's effective_xcpus, any child
> using parent'effective_cpus must call update_cpumasks_hier. However,
> if a child is not a valid partition, it is sufficient to determine
> whether to call update_cpumasks_hier based on whether the child's
> effective_cpus is going to change. To make the code more succinct,
> it is suggested to remove use_parent_ecpus.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 30 ++++--------------------------
>   1 file changed, 4 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 8be0259065f5..71c24542966b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -185,12 +185,6 @@ struct cpuset {
>   	/* partition root state */
>   	int partition_root_state;
>   
> -	/*
> -	 * Default hierarchy only:
> -	 * use_parent_ecpus - set if using parent's effective_cpus
> -	 */
> -	int use_parent_ecpus;
> -
>   	/*
>   	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
>   	 * know when to rebuild associated root domain bandwidth information.
> @@ -1505,11 +1499,8 @@ static void reset_partition_data(struct cpuset *cs)
>   		if (is_cpu_exclusive(cs))
>   			clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
>   	}
> -	if (!cpumask_and(cs->effective_cpus,
> -			 parent->effective_cpus, cs->cpus_allowed)) {
> -		cs->use_parent_ecpus = true;
> +	if (!cpumask_and(cs->effective_cpus, parent->effective_cpus, cs->cpus_allowed))
>   		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
> -	}
>   }
>   
>   /*
> @@ -1683,8 +1674,6 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>   	list_add(&cs->remote_sibling, &remote_children);
> -	if (cs->use_parent_ecpus)
> -		cs->use_parent_ecpus = false;
>   	spin_unlock_irq(&callback_lock);
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   
> @@ -2309,13 +2298,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		 * it is a partition root that has explicitly distributed
>   		 * out all its CPUs.
>   		 */
> -		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
> +		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus))
>   			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
> -			if (!cp->use_parent_ecpus)
> -				cp->use_parent_ecpus = true;
> -		} else if (cp->use_parent_ecpus) {
> -			cp->use_parent_ecpus = false;
> -		}
>   
>   		if (remote)
>   			goto get_css;
> @@ -2452,8 +2436,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>   	 * Check all its siblings and call update_cpumasks_hier()
>   	 * if their effective_cpus will need to be changed.
>   	 *
> -	 * With the addition of effective_xcpus which is a subset of
> -	 * cpus_allowed. It is possible a change in parent's effective_cpus
> +	 * It is possible a change in parent's effective_cpus
>   	 * due to a change in a child partition's effective_xcpus will impact
>   	 * its siblings even if they do not inherit parent's effective_cpus
>   	 * directly.
> @@ -2467,8 +2450,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>   	cpuset_for_each_child(sibling, pos_css, parent) {
>   		if (sibling == cs)
>   			continue;
> -		if (!sibling->use_parent_ecpus &&
> -		    !is_partition_valid(sibling)) {
> +		if (!is_partition_valid(sibling)) {
>   			compute_effective_cpumask(tmp->new_cpus, sibling,
>   						  parent);
>   			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
> @@ -4128,7 +4110,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   	if (is_in_v2_mode()) {
>   		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>   		cs->effective_mems = parent->effective_mems;
> -		cs->use_parent_ecpus = true;
>   	}
>   	spin_unlock_irq(&callback_lock);
>   
> @@ -4194,9 +4175,6 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>   	    is_sched_load_balance(cs))
>   		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>   
> -	if (cs->use_parent_ecpus)
> -		cs->use_parent_ecpus = false;
> -
>   	cpuset_dec();
>   	clear_bit(CS_ONLINE, &cs->flags);
>   

LGTM

Reviewed-by: Waiman Long <longman@redhat.com>


