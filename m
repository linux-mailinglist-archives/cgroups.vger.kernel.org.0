Return-Path: <cgroups+bounces-10001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BBB53D6E
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 23:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30A43A8B42
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460F26FA54;
	Thu, 11 Sep 2025 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWlgtXps"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E224A063
	for <cgroups@vger.kernel.org>; Thu, 11 Sep 2025 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624630; cv=none; b=o9kyvf5BmM6lekxK9Ii7C/sJYWPNc2697L48yWt0af/AYbuXhMRT8vjBxWDosX23e+zLJyTNSD+AsNECtW+y9zZgzMCDeg+sxtk4K4tbG9vCWuw24HSd+U6TSPrMac59tuy45P1Q1D54c/wLCCT/TZTXfOjJ2zxzzvfwIMDC2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624630; c=relaxed/simple;
	bh=YhNZdeyzUVCwID4sMF0uEuw7hjzOX2t4Y7z/au/BFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho2nr9QyQ/4qUidFkx3Q3LcUf0wBaDY4j/zbPwxtnl9TxaSW4bk0BT9JSYntEZZBO4RR8qyR2DYRfCGA+BG+tE4kjbyR5/an3+Mk/hUAm8HmAeeq8Jdt/NI2OsxbtHAKtA0vWYHNFXdiw0J32No/36+AqzAG74EBKu1e3oHrUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWlgtXps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757624628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvedPzat5MF8+xygNKs3CNs0BjQSQTziKoItNi6TYn0=;
	b=VWlgtXps3lbPRcAh5zUHEXVNM5Fj5aSBJXegmx+nVcZ2DqNGued3W+0vKRUAAwh/YAp2/W
	wutqnBn/FF/WTP/bdOYltysUneaO2TY4mTkAwzStEiQNsNiWLM7dTHT7ZlriUgJ0XucbwY
	A8BgSRgP3NIX0cKSLgx7CTUBqsjJf6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-tseBjTjnPkmPEjiL9Uh5HQ-1; Thu,
 11 Sep 2025 17:03:43 -0400
X-MC-Unique: tseBjTjnPkmPEjiL9Uh5HQ-1
X-Mimecast-MFC-AGG-ID: tseBjTjnPkmPEjiL9Uh5HQ_1757624622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86EE51955E88;
	Thu, 11 Sep 2025 21:03:41 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87987300021A;
	Thu, 11 Sep 2025 21:03:38 +0000 (UTC)
Date: Thu, 11 Sep 2025 17:03:35 -0400
From: Phil Auld <pauld@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Michal Koutny <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 07/33] cpuset: Convert boot_hk_cpus to use
 HK_TYPE_DOMAIN_BOOT
Message-ID: <20250911210335.GC7235@pauld.westford.csb>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-8-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829154814.47015-8-frederic@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Aug 29, 2025 at 05:47:48PM +0200 Frederic Weisbecker wrote:
> boot_hk_cpus is an ad-hoc copy of HK_TYPE_DOMAIN_BOOT. Remove it and use
> the official version.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

This, along with #6 LGTM.

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil


> ---
>  kernel/cgroup/cpuset.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..b00d8e3c30ba 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -80,12 +80,6 @@ static cpumask_var_t	subpartitions_cpus;
>   */
>  static cpumask_var_t	isolated_cpus;
>  
> -/*
> - * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
> - */
> -static cpumask_var_t	boot_hk_cpus;
> -static bool		have_boot_isolcpus;
> -
>  /* List of remote partition root children */
>  static struct list_head remote_children;
>  
> @@ -1601,15 +1595,16 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   * @new_cpus: cpu mask
>   * Return: true if there is conflict, false otherwise
>   *
> - * CPUs outside of boot_hk_cpus, if defined, can only be used in an
> + * CPUs outside of HK_TYPE_DOMAIN_BOOT, if defined, can only be used in an
>   * isolated partition.
>   */
>  static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  {
> -	if (!have_boot_isolcpus)
> +	if (!housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
>  		return false;
>  
> -	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
> +	if ((prstate != PRS_ISOLATED) &&
> +	    !cpumask_subset(new_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)))
>  		return true;
>  
>  	return false;
> @@ -3764,12 +3759,9 @@ int __init cpuset_init(void)
>  
>  	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>  
> -	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
> -	if (have_boot_isolcpus) {
> -		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
> -		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
> -		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
> -	}
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
> +		cpumask_andnot(isolated_cpus, cpu_possible_mask,
> +			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>  
>  	return 0;
>  }
> -- 
> 2.51.0
> 
> 

-- 


