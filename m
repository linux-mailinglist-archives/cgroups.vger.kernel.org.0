Return-Path: <cgroups+bounces-1114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A272829D72
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 16:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E3EB26C4E
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A94BAAB;
	Wed, 10 Jan 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOLCOJmX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADBB4C608
	for <cgroups@vger.kernel.org>; Wed, 10 Jan 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704900110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAxvn7n382nb2JvBceqLwG06b5S0HtkbsTWBf6oLhXo=;
	b=QOLCOJmXT3jTF1YB8SrCDDFK8NOaMxU8a6mm3XXwNDql2SwTmxIloxZ905QKdS748f3E8s
	PveKPPIbJNI23JeeI1kJJa6WmBKCMjlaMOQ8T/A8KNPsSzlBil/h2T9cgzduaSzRtKHG77
	zS3zP6UGD1s2J489gOH/Ua4mz8aVrNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ZwH3KG3NOI2BD9ypO7kKaQ-1; Wed, 10 Jan 2024 10:21:46 -0500
X-MC-Unique: ZwH3KG3NOI2BD9ypO7kKaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66838881F0A;
	Wed, 10 Jan 2024 15:21:46 +0000 (UTC)
Received: from [10.22.9.232] (unknown [10.22.9.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9EBA5492BE6;
	Wed, 10 Jan 2024 15:21:45 +0000 (UTC)
Message-ID: <163ab1ad-e768-46f0-a6bc-dec1759c3d71@redhat.com>
Date: Wed, 10 Jan 2024 10:21:45 -0500
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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

This statement cannot be removed as it is used in the following 
statement to size the allocation. This change the behavior to make doms 
NULL rather than a 1-entry array. This is probably the cause of the 
kernel test robot failure report.

NAK

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
>


