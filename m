Return-Path: <cgroups+bounces-4887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCE9797D6
	for <lists+cgroups@lfdr.de>; Sun, 15 Sep 2024 18:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D943E1F21998
	for <lists+cgroups@lfdr.de>; Sun, 15 Sep 2024 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8251C8FAA;
	Sun, 15 Sep 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJEsQi+Y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F017C6C
	for <cgroups@vger.kernel.org>; Sun, 15 Sep 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726418327; cv=none; b=gBCnWRVOFGypx8ae79GWLWF/PCcj40iQTTOBKel+WkU3eHF9n1aTP3x2oMDkAFV8CvzkdZ3gt+3ZghiVo0u4Ksnh3aP8p3vo57NTD3u7CUhdvm6H4pvVu//w3nvmdg0YM9A+QwAYS6JXv7liP4mB8fH6j3wKjCVKOgUwD2lH9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726418327; c=relaxed/simple;
	bh=BYxn53eXh5mYSIch8yw2meXhZd/ieuZ0cJj1ScsxNVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azFpdbsf1QZ7vLIOKXBgYITtD3GzSUoQvFrkNedailWzj5PQDQOPan/mh1+1acAnb9Wv3P84zedLGNsYaIEg/BHFhCcBar05CW7jdBbic3G227fanBT5mMjm7toBfPK1NV7Miua84JB+SPhrOWwIA0HXHVMQQwf6DWQuzyQY9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJEsQi+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726418323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7VzktdIxg3zaQqZTm+Yk186VqXUQn4e9GJhTx0JvPE=;
	b=SJEsQi+YF82mrebrVCjT5o410RBbcXg0PmJ5p68atp05aXaYplFoXcYwHFSB2V0gdBAsv4
	q1l1PP+9Pc/H0AJwkk8VJfZGpg8hcp/W8LfwedQUntzhK+k8Z/ssZPOsiUKyiieZxqVgMi
	/bFr3hgLyvvLOWzkkhg12TLO/QI/wzE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-K3IWdi7aOtGRPow19dKc9g-1; Sun,
 15 Sep 2024 12:38:39 -0400
X-MC-Unique: K3IWdi7aOtGRPow19dKc9g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E931219560A2;
	Sun, 15 Sep 2024 16:38:37 +0000 (UTC)
Received: from [10.2.16.6] (unknown [10.2.16.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A2651956053;
	Sun, 15 Sep 2024 16:38:35 +0000 (UTC)
Message-ID: <9046c67d-0982-4386-b4f1-f42b6e9fd2db@redhat.com>
Date: Sun, 15 Sep 2024 12:38:34 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix spelling errors in file kernel/cgroup/cpuset.c
To: "Everest K.C." <everestkc@everestkc.com.np>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240915082935.9731-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240915082935.9731-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/15/24 04:29, Everest K.C. wrote:
> From: everestkc <everestkc@everestkc.com.np>
>
> Corrected the spelling errors repoted by codespell as follows:
> 	temparary ==> temporary
>          Proprogate ==> Propagate
>          constrainted ==> constrained
>
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   kernel/cgroup/cpuset.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 40ec4abaf440..205aabcd95f6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1654,7 +1654,7 @@ static inline bool is_local_partition(struct cpuset *cs)
>    * remote_partition_enable - Enable current cpuset as a remote partition root
>    * @cs: the cpuset to update
>    * @new_prs: new partition_root_state
> - * @tmp: temparary masks
> + * @tmp: temporary masks
>    * Return: 1 if successful, 0 if error
>    *
>    * Enable the current cpuset to become a remote partition root taking CPUs
> @@ -1698,7 +1698,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   
>   	/*
> -	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
> +	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
>   	 */
>   	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>   	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
> @@ -1708,7 +1708,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   /*
>    * remote_partition_disable - Remove current cpuset from remote partition list
>    * @cs: the cpuset to update
> - * @tmp: temparary masks
> + * @tmp: temporary masks
>    *
>    * The effective_cpus is also updated.
>    *
> @@ -1734,7 +1734,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   
>   	/*
> -	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
> +	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
>   	 */
>   	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>   	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
> @@ -1744,7 +1744,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>    * remote_cpus_update - cpus_exclusive change of remote partition
>    * @cs: the cpuset to be updated
>    * @newmask: the new effective_xcpus mask
> - * @tmp: temparary masks
> + * @tmp: temporary masks
>    *
>    * top_cpuset and subpartitions_cpus will be updated or partition can be
>    * invalidated.
> @@ -1786,7 +1786,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   
>   	/*
> -	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
> +	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
>   	 */
>   	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>   	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
> @@ -1801,7 +1801,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
>    * @cs: the cpuset to be updated
>    * @newmask: the new effective_xcpus mask
>    * @delmask: temporary mask for deletion (not in tmp)
> - * @tmp: temparary masks
> + * @tmp: temporary masks
>    *
>    * This should be called before the given cs has updated its cpus_allowed
>    * and/or effective_xcpus.
> @@ -2534,7 +2534,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   			return -EINVAL;
>   
>   		/*
> -		 * When exclusive_cpus isn't explicitly set, it is constrainted
> +		 * When exclusive_cpus isn't explicitly set, it is constrained
>   		 * by cpus_allowed and parent's effective_xcpus. Otherwise,
>   		 * trialcs->effective_xcpus is used as a temporary cpumask
>   		 * for checking validity of the partition root.
Acked-by: Waiman Long <longman@redhat.com>


