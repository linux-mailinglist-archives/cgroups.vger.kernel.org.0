Return-Path: <cgroups+bounces-1048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C12820C76
	for <lists+cgroups@lfdr.de>; Sun, 31 Dec 2023 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F107F1F21BB6
	for <lists+cgroups@lfdr.de>; Sun, 31 Dec 2023 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7400944E;
	Sun, 31 Dec 2023 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkhaDuo5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1439447
	for <cgroups@vger.kernel.org>; Sun, 31 Dec 2023 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704047353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbKtsWantMEXThLYzEBmJn42B3DxhHaKLrOeSwrFILQ=;
	b=IkhaDuo5DEHZ7dyB5WKEFx9UOPa9Ghi+P362/FL+rGFIHmnBNg1Z/AGUSyngWwCUZbrVWU
	8GlTkliciZtZkFQcBd60SuCSWfa1RmYBMg5C2984apmJdpX4O4z5Gd7Xd+SKYJISRvkm+X
	A3G1C30C3j+jg6s/UfB57BORADHcgoU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-fUJRyvvKP9-2TzsWqTYx8g-1; Sun,
 31 Dec 2023 13:29:11 -0500
X-MC-Unique: fUJRyvvKP9-2TzsWqTYx8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E4A63806636;
	Sun, 31 Dec 2023 18:29:10 +0000 (UTC)
Received: from [10.22.16.25] (unknown [10.22.16.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1CC40C6EBA;
	Sun, 31 Dec 2023 18:29:09 +0000 (UTC)
Message-ID: <9cd1ce1d-15c7-427c-9929-f3c75b97b49c@redhat.com>
Date: Sun, 31 Dec 2023 13:29:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Adjust exception handling in
 generate_sched_domains()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, cgroups@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <53be5f98-6359-48b5-955e-fd203d99d3cb@web.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <53be5f98-6359-48b5-955e-fd203d99d3cb@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 12/31/23 02:28, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 08:00:31 +0100
>
> Two resource allocation failures triggered further actions
> over the label “done” so far.
>
> * Jump to the statement “ndoms = 1;” in three cases directly
>    by using the label “set_ndoms” instead.
>
> * Delete an assignment for the variable “ndoms” in one if branch.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   kernel/cgroup/cpuset.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ba36c073304a..29ccd52eb45c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -973,10 +973,9 @@ static int generate_sched_domains(cpumask_var_t **domains,
>
>   	/* Special case for the 99% of systems with one, full, sched domain */
>   	if (root_load_balance && !top_cpuset.nr_subparts) {
> -		ndoms = 1;
>   		doms = alloc_sched_domains(ndoms);
>   		if (!doms)
> -			goto done;
> +			goto set_ndoms;
>
>   		dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>   		if (dattr) {
> @@ -986,12 +985,12 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   		cpumask_and(doms[0], top_cpuset.effective_cpus,
>   			    housekeeping_cpumask(HK_TYPE_DOMAIN));
>
> -		goto done;
> +		goto set_ndoms;
>   	}
>
>   	csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
>   	if (!csa)
> -		goto done;
> +		goto set_ndoms;
>   	csn = 0;
>
>   	rcu_read_lock();
> @@ -1123,6 +1122,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	 * See comments in partition_sched_domains().
>   	 */
>   	if (doms == NULL)
> +set_ndoms:
>   		ndoms = 1;
>
>   	*domains    = doms;
> --
> 2.43.0
>
Please clarify what this patch is for. Is it just a cleanup with no 
functional changes or is there a bug that is being fixed?

Cheers,
Longman


