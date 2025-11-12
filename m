Return-Path: <cgroups+bounces-11893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45AC54874
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4191A3A955E
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEB2DCBEC;
	Wed, 12 Nov 2025 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HctSb3c/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOgRbWow"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C312D6E4A
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981092; cv=none; b=kTrx4+DbzccVzzcftvFwNdXlJbu2FTrowP25XuOxywD+TWczdcc6A1Q6VS0ciEXyAlRzxmfx5264xg01c7nVPpERmoj/b5uwt5ysVIYLPKujAaINXRCPd0Sa3JirrQvnxQ9hIIhRuDvYFABAMGKWGi0kL03uZDFpyjiwDmfCAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981092; c=relaxed/simple;
	bh=AagDWdOBppQWSYzA9tVtQ+1NN/5U2UCNvVcwCAoYND4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SKgrNmt2ZsqN2Jomfv8m19AUZqZG/TqjMy3T4nzJ6C3iHbYcU+i0L7ibyFJJeXIZJsZKpWc7ysVm/3Tk01B0N21a6gu6RVeLfpGCxKi/yY8+LR9asCCWi8zilRYh08D367RBsCQEdPRb9MC8NRi0KgzgHAYC583qQdsguixZI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HctSb3c/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOgRbWow; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762981088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3qyywzMcYqyk3Ae6Ps8PBByhEa/6CN7lJvjKibJCTQ=;
	b=HctSb3c/jsnJOtQpumNu1HDuqfV5wUDZlCCFgVfqU+b17yH8/6enXDuQqb9PTGHMIDQRko
	XGMWKyswWhAsA1H8d5/WsFuIGHa0NN0kTo+9F9RA2Kspz0oD8n/p/aYP6fDYu+cOZ2K2AF
	sz852ylNAZ/AEwhc+mB++IeMPwwL2jM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-dFItZSsYM4mgrAuCda2MHQ-1; Wed, 12 Nov 2025 15:58:07 -0500
X-MC-Unique: dFItZSsYM4mgrAuCda2MHQ-1
X-Mimecast-MFC-AGG-ID: dFItZSsYM4mgrAuCda2MHQ_1762981086
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89ee646359cso46329785a.1
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762981086; x=1763585886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3qyywzMcYqyk3Ae6Ps8PBByhEa/6CN7lJvjKibJCTQ=;
        b=aOgRbWowOfa2PpsyQEBaGZk0J6bQy6EfA7St5QRgbT6egpQGtGyjid/FYoOxG1Q3K1
         wRqmsiqd92bTfjqTdK0h/KL3j6LShUh1kANleaUuc/3PdicDONZipMz9LFSzpqQgJiKd
         me8fA70MxlIJLlsrX4P7CyYMajz28rzpw5tYOjt/rtdN4vY9AdLi5ixhTTx+93joSxHe
         issOon7PVkDPZ5UkJYOOAjbxu36K7CQ5BbeKlihYZch8+ozYQ3t66TyQrH+id8HqbHzn
         OUaSRyZqN3EqTcEQ5ATxckYf2gT7uL3AT+WdwHxPoGaLewp40Pa72spyU09pEeWQx+CS
         fcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981086; x=1763585886;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3qyywzMcYqyk3Ae6Ps8PBByhEa/6CN7lJvjKibJCTQ=;
        b=ScXwL6MY7Bjaj6/eMn1eCOdMUrIFTegoabMHpl7CqKKNLZEWd+CfWIpKSxsjI1wTn6
         DcQFR1ay04RIK32YTnbBHo3aC/cpwqnWmVX0QjyZx/ebUw3VK3vp8fhK75lFY/cfb88f
         E3quloD2XFLQ4gtWVxtNC5eTOHxQBsDII2l9yz3FGoxIokQK0FRQvejkeMdPyqwt2NXU
         Hv/TrUt4BiWXncxgcISgj8D3uKmJv/J6yji/IF8ZC3LaNPHqFfZXDrcSY2CJMwMHyzXM
         Dg89sZXuJ5louA091k0Y2drK4dpEeQvZdxiQJ+HwmsVH2O49hP6i0uFoLWfbWqO/n58x
         q/5A==
X-Gm-Message-State: AOJu0Yyd0WemOM7ar75IL2P4Zme7/olm9zn9kqBpsGp42I0gXAFMfaFR
	DKh9/kVlZaCfXbbp9a9wx+lKSdMxyqD+MqHtNVmD4N1r0+9sTrr7z3N4gH+oAhPHXK+Vklcn93w
	+0eUzuX623KOCxH3uU05Fq7JTSHm6e0mHIa9FR7a105yzFFHPIvd07jPm9Q4=
X-Gm-Gg: ASbGncv4UuJ3aRR1Shr5wrQAotOKXSiZNAt07BSONps1LxuqtSeKfjxc61s7OHKpWtR
	ZJxc4/PyOpbNCG5OLiSTIviGFnnRAv3S00CXzbT15UzfFkncmwTjnnpEaHypz9bN8VL0lIVdUUE
	vjnVLfY4skXrs7hvQTh2DvCwsJCR8DdLsoYYrf24RVtj1zh7ccM2Yy3jY8TEQPXtGFIkSdmFewo
	dZMH1FiJpGHRrc0nyxwX6UEOcNjGc0tx96BAe5ddJM54zZ7UP0MTHC8IwGb1k+upgsF6QtQzKOf
	nKjlmQDURClxeuy5vfQFkQNTRv9Fw0UC/uj/sU/WEjBrth7rvqWzbPYs8BVNEuITErSz1M3sbfn
	F48gosjKXe68lJHWBH8eAu96JWeQRNLglKlM4HX0sVAj7yA==
X-Received: by 2002:a05:620a:1a1f:b0:8b2:772b:5f65 with SMTP id af79cd13be357-8b29b76454dmr607886685a.22.1762981086518;
        Wed, 12 Nov 2025 12:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtwNXcaZXsiBjiET7BW6yYn14H6fZ6yu60XPNbEB9AbYsWhYxCebg+fOwt+3xxjmdVh+jBuA==
X-Received: by 2002:a05:620a:1a1f:b0:8b2:772b:5f65 with SMTP id af79cd13be357-8b29b76454dmr607883785a.22.1762981086122;
        Wed, 12 Nov 2025 12:58:06 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84ae3csm261456285a.6.2025.11.12.12.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:58:05 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <91e163ac-4379-4875-9f08-bddebb1e616c@redhat.com>
Date: Wed, 12 Nov 2025 15:58:04 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/22] cpuset: introduce partition_update()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Introduce partition_update() to centralize updates to key cpuset structures
> during a partition update, including:
> - effective_xcpus
> - exclusive_cpus
>
> Key operations performed:
> - Adding and removing exclusive CPUs via partition_xcpus_add()/del()
> - Synchronizing the effective exclusive CPUs mask
> - Updating the exclusive CPUs mask when modification is required
> - Triggering necessary system updates and workqueue synchronization
> - Updating the partition's exclusive flag
> - Sending partition change notifications
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4a79db1cdec1..3e414e19ae31 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1604,6 +1604,53 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>   	notify_partition_change(cs, old_prs);
>   }
>   
> +/**
> + * partition_update - Update an existing partition configuration
> + * @cs: The cpuset to update
> + * @prs: Partition root state (must be positive)
> + * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
> + * @excpus: New effective exclusive CPUs mask
> + * @tmp: Temporary masks
> + *
> + * Updates partition-related fields. The tmp->addmask is the CPU mask that
> + * will be added to the subpartitions_cpus and removed from parent's
> + * effective_cpus, and the tmp->delmask vice versa.
> + */
> +static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
> +				  struct cpumask *excpus, struct tmpmasks *tmp)
> +{
> +	bool isolcpus_updated;
> +	bool excl_updated;
> +	struct cpuset *parent;
> +	int old_prs;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(!cpuset_v2());
> +	WARN_ON_ONCE(prs <= 0);
> +
> +	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
> +	old_prs = cs->partition_root_state;
> +	excl_updated = !cpumask_empty(tmp->addmask) ||
> +		       !cpumask_empty(tmp->delmask);
Should partition_update() only be called if at least one of 
addmask/delmask is not empty? If they are both empty, no update is 
really needed. Right?
> +
> +	spin_lock_irq(&callback_lock);
> +	isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
> +	isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);

I see now that there is no adding and deleting boolean flags to indicate 
if the cpumasks are empty or not, so you have to add the empty cpumask 
check in those helpers. Please state that in your patch 2.

Cheers,
Longman

> +	/*
> +	 * Need to update effective_xcpus and exclusive_cpus now as
> +	 * update_sibling_cpumasks() below may iterate back to the same cs.
> +	 */
> +	cpumask_copy(cs->effective_xcpus, excpus);
> +	if (xcpus)
> +		cpumask_copy(cs->exclusive_cpus, xcpus);
> +	spin_unlock_irq(&callback_lock);
> +	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	if (excl_updated)
> +		cpuset_force_rebuild();
> +	update_partition_exclusive_flag(cs, prs);
> +	notify_partition_change(cs, old_prs);
> +}
> +
>   /*
>    * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
>    * @prstate: partition root state to be checked


