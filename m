Return-Path: <cgroups+bounces-11895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240AFC54B0A
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 23:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF87E3AAFF7
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957562E9EB1;
	Wed, 12 Nov 2025 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJ7MoR/8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIyZtu5o"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2A2D97BD
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985421; cv=none; b=aGVJGGARi+EqMCk+AaOrkEfDYfII8KDsAxLZqN7lgQN6LcyVVJJ+FfDXh9Um1xRrfgtfilnNN3Crldua9GEQpm9jE8Li30cDqCWI3g3BfKo3NpXQ9yjzoz6hnjyCiUJb2oQ0W7xDuYOZt+kprbhfPQUTuW5SCgkYnDOScEJ6mNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985421; c=relaxed/simple;
	bh=RVRXjndE3LLUqlKF77wcqkvlvGQQFvstRXN4Zk8k5HQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e6LUi01xTGg1FNdxsoyLKw634sOv8EiP8yAr3GRvzPJqLU+JOTgXCdu9rNwziVS+7SDlFvO3lM/hI8C2Fxr03lQZUbM+M7OD664uDdn5kYTM7/Tjqbbi0I7KbH/FKHU1bey2hGUA0X5VFqdN41H+OkWnGfA2ecTw9u6Jup1t7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJ7MoR/8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIyZtu5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762985418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N/Yn6FOW3ySwfhCn5fVGDZbRep3BociADSKvJQX9zA=;
	b=cJ7MoR/82Rt68ipHfVZK/2f4WjXzsfM9O4k4FHtm9EA04fzyTD3zSWsA2wCM4fNUrNx182
	3bdQDgu8FgNQhApAaY6VvjkWNfX7ByMp5g9MSXlZUjaJD1i6JhEJ27EYvnElDyAlbDSWaa
	Oipms2OG/HyBh7mwqc32YAoIkYfWuaU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-XLqLlYA8MRetHIb1Mf20iQ-1; Wed, 12 Nov 2025 17:10:17 -0500
X-MC-Unique: XLqLlYA8MRetHIb1Mf20iQ-1
X-Mimecast-MFC-AGG-ID: XLqLlYA8MRetHIb1Mf20iQ_1762985416
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88238449415so7313876d6.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762985416; x=1763590216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5N/Yn6FOW3ySwfhCn5fVGDZbRep3BociADSKvJQX9zA=;
        b=cIyZtu5oIqDCBBhGO6qNQyKalzFoDAF/pafN4+JQWCVEHLKRYyvkvvQgjmJsrBnZTp
         1N1diZ69qnzcLHLbqnDFmOL20WXho2usFEEjoK38lGOIBvzPiXkNmikUwU66+ptBJ18h
         DNVtWmIgkBUGxcFK0YKyP/Ay2pkgfDzvZKNkfpaQ+mxCd74r/lnufCN1m18Vg8bkpXzH
         3hyBECJ4TdHM2ihToo+vdLypvzNEjgDKLnHhqlwOkQwuAfgDXgXVjCGzY7Pz6z/DN8N2
         WlKQDb3qGo40licuBFBgTHypn8KwmSCxQPXI3eIKgMRlTA0I8icllH+wt8ymjnMKzhor
         aueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762985416; x=1763590216;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N/Yn6FOW3ySwfhCn5fVGDZbRep3BociADSKvJQX9zA=;
        b=LYC9H9R6jdXpf9yRj9nVPgF80jk4tuVmaPfW3fTy/XQdX1OslE/LrZPCvttbuhrbTr
         8yhDWflpjDbO1oC+2WItl4ilHhzIS5EmWqSoTgTjWFCGGL6ZAHbrTAOAB0H8K3fSws5a
         gx4vNp3/Nos3xYBUk+FE+9r5yW82xOXb/2fLjrwX0ATCIlM+Gec6cD6F467gm4L2in7R
         NEv+7gQOzasOU7eCjP6Z15k5sVsw2itkqil3o1zl/38x5JemjZ6e28eyrR9qOt3znbbz
         pkMw5mz1KjTqt6SnqPi/mhieP0ADTXIMj1jMmldI0ubRpigLz30BzR80n61cWzh6djNI
         0Okw==
X-Gm-Message-State: AOJu0Yz3R6eIpIDGs88cixcNV2VMEZQM8NSVzHz5X0eSx9anSeuAyzyt
	pSp7dBju4jWqL7S4pZtUPQvhAKtCj6wp6sXd4bD8ZfeguOx82k1FFhnKRhUaQqcwq6EiZXAOymo
	MsCYrcfu2C/y7//CgbAt+UJ/CFZcoc0sEW4On4dLuPos1pU1jjA9OWmk/IDY=
X-Gm-Gg: ASbGnctZY12XsgQlOFGRHZtwJNfLPk9hC4V39GsYF4ZtrCEKZn2S7pKJiaQYxWW4iZr
	0+f1korKmPtg9DTSW45b35lipBcoXCnro1mlrOxLchxjphj+ZpT4fVfDzO+yRumA3UbHfnPNXut
	vN04qELJ8RvWXHr2ojzj0HoyfkdGrltfswzfeUiVbVA+wlKcrMsFNfEp/9HUqipMMAR+xkq5EJG
	c0BG8z+zPinysOcxBktFzglTP/eMk4zUcKwuSvr5ibWO5/Zz1lRmFbhniVIZFk8SNrKPopsHx/a
	Dyw1nwwNA3eGBb4SYJKjMjvKqkKE+LJwRzP0yJ8YjJ7Gd0lFsh1rBUFfhYCXWAsuNcRBj157iAv
	tTuH0DCaFMFZ/P42kUzj1OKkMjMINSbA1tZmmo7hRRTWCMA==
X-Received: by 2002:ad4:5f07:0:b0:880:55e4:dde with SMTP id 6a1803df08f44-88271a4485emr68003166d6.63.1762985416460;
        Wed, 12 Nov 2025 14:10:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8fi+pUQJ49PuCmgYdZtBN+A+yE5FZ/FDxLtz8qqMqXmLOhW+IeicaAyOGqHjlJKVTIWmfDA==
X-Received: by 2002:ad4:5f07:0:b0:880:55e4:dde with SMTP id 6a1803df08f44-88271a4485emr68002796d6.63.1762985416080;
        Wed, 12 Nov 2025 14:10:16 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm294646d6.11.2025.11.12.14.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:10:15 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4adcc3d-577d-4065-b419-581f67d5e724@redhat.com>
Date: Wed, 12 Nov 2025 17:10:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 11/22] cpuset: introduce local_partition_disable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-12-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-12-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The partition_disable() function introduced earlier can be extended to
> handle local partition disablement.
>
> The local_partition_disable() functions is introduced, which extracts the
> local partition disable logic from update_parent_effective_cpumask(). It
> calls partition_disable() to complete the disablement process.
>
> This refactoring establishes a clear separation between local and remote
> partition operations while promoting code reuse through the shared
> partition_disable() infrastructure.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++------------
>   1 file changed, 39 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b308d9f80eef..f36d17a4d8cd 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1877,6 +1877,43 @@ static int local_partition_enable(struct cpuset *cs,
>   	return 0;
>   }
>   
> +/**
> + * local_partition_disable - Disable a local partition
> + * @cs: Target cpuset (local partition root) to disable
> + * @part_error: partition error when @cs is disabled
> + * @tmp: Temporary masks for CPU calculations
> + */
> +static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_error,
> +				    struct tmpmasks *tmp)
> +{
> +	struct cpuset *parent = parent_cs(cs);
> +	bool cpumask_updated = false;
> +	int new_prs;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
> +
> +	if (!is_partition_valid(cs))
> +		return;
> +
> +	new_prs = part_error ? -cs->partition_root_state : 0;
> +	/*
> +	 * May need to add cpus back to parent's effective_cpus
> +	 * (and maybe removed from subpartitions_cpus/isolated_cpus)
> +	 * for valid partition root. xcpus may contain CPUs that
> +	 * shouldn't be removed from the two global cpumasks.
> +	 */
> +	if (is_partition_valid(parent))
> +		cpumask_updated = !cpumask_empty(cs->effective_xcpus);

If cs is a valid local partition, parent must be a valid partition. So 
the is_partition_valid(parent) check is meaningless. Also the 
effective_xcpus must not be empty. IOW, cpumask_updated must be true.

Cheers,
Longman

> +
> +	partition_disable(cs, parent, new_prs, part_error);
> +
> +	if (cpumask_updated) {
> +		cpuset_update_tasks_cpumask(parent, tmp->addmask);
> +		update_sibling_cpumasks(parent, cs, tmp);
> +	}
> +}
> +
>   /**
>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>    * @cs:      The cpuset that requests change in partition root state
> @@ -1967,19 +2004,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   	nocpu = tasks_nocpu_error(parent, cs, xcpus);
>   
> -	if (cmd == partcmd_disable) {
> -		/*
> -		 * May need to add cpus back to parent's effective_cpus
> -		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
> -		 * for valid partition root. xcpus may contain CPUs that
> -		 * shouldn't be removed from the two global cpumasks.
> -		 */
> -		if (is_partition_valid(cs)) {
> -			cpumask_copy(tmp->addmask, cs->effective_xcpus);
> -			adding = true;
> -		}
> -		new_prs = PRS_MEMBER;
> -	} else if (newmask) {
> +	if (newmask) {
>   		/*
>   		 * Empty cpumask is not allowed
>   		 */
> @@ -3110,9 +3135,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		if (is_remote_partition(cs))
>   			remote_partition_disable(cs, &tmpmask);
>   		else
> -			update_parent_effective_cpumask(cs, partcmd_disable,
> -							NULL, &tmpmask);
> -
> +			local_partition_disable(cs, PERR_NONE, &tmpmask);
>   		/*
>   		 * Invalidation of child partitions will be done in
>   		 * update_cpumasks_hier().


