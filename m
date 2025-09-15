Return-Path: <cgroups+bounces-10124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB2B58551
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 21:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8C207701
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 19:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC6242D78;
	Mon, 15 Sep 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdJi8K8/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E0320F
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964891; cv=none; b=Qud/6gnIuqrVxUegsM0mjxbgZHZZPFyaci3ytpTNYnISpq/zCs+1KM3LwhcwEUAosRirGvBuLfQzifYVITIPVs6xMSqLyusbRgT65L+DTPOnXm3mv7xy9LbbA4MdZsz7u3mjWcJd1rZyVBl7h0Di1l1cCScDtL2axwe9pXZCs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964891; c=relaxed/simple;
	bh=3OylFzCxyqrYsaki4/jnUQTLUWQ5Z5c28iz6wCKca3c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fagAdSa/VW+siSmZcYRL5kuIXptJFXFr+y1Mvrk5CHDPOzhi017VnNLD9rLot50hBcClWrKjETcU8PQNrZ9RBio3uobFu5cc9muTAJyjV2dqe4ZuwcJJ3nLo83nkQ2WP1B6uU/cD4yNRF8wyB/kbq06Uz5FUJTX/4b1mLLSPC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdJi8K8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757964888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRRCNR/18bUiMOu25vR/TxJnnyI0vGX8L+bMpJvMvu0=;
	b=WdJi8K8/b6F1ncuQei3p+ZmN+sAyaxfrHTD3zyOD3B0x4dTOrDrKZnjA5p4e7BnBB7b9hT
	bbMqV7zBbALgcVLbyY1v1R5oQZXCdUHNyOwperRKoxXtFxZKxECdo4mTUEmrzw6sAv/mjX
	AZiLQEE8iBnt9TKzMHVO6XGH4mr7Ipw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-zWPqGZktP_iw55-UiNIPLg-1; Mon, 15 Sep 2025 15:34:46 -0400
X-MC-Unique: zWPqGZktP_iw55-UiNIPLg-1
X-Mimecast-MFC-AGG-ID: zWPqGZktP_iw55-UiNIPLg_1757964886
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b60d5eca3aso111446521cf.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 12:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964886; x=1758569686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRRCNR/18bUiMOu25vR/TxJnnyI0vGX8L+bMpJvMvu0=;
        b=eAvniP3ox/UWGQc5ZFuigidJwr6ayXvtChfzEAUycDm/l/7z3C/MMF4tjpouIueqPZ
         SrwKDpE0BEQz/HV+H5DFAk4r2PtI2ILLI1NQQlqu4ytGeoTEwP1myKlcMeqJOsPv5KJF
         DfPTJpG+pt8y5X+tWYY+q+RLQaj0qP1oJ9ri197CsXrhULJUJnwzf+hXwopjxFTlYOSD
         tsZR1leKNgg32rs+ej6XVieTm3orYAHbozXvrnRZVqzn39LzLFC9BfG50n/2qHBZNJDS
         0qRsM/tNoIAXysWERkITR8Q5bjr6z5HKO1NWNi8dQS5lG5BtyFfh1Bu+8ZFtu7kOO6E3
         1AXQ==
X-Gm-Message-State: AOJu0Yx5dYxiZcVAZ/53grPswhbyST0Onb4mlGwDH5o7su5/FziZ3FNp
	fsq0pB2PBHA9X3ks1hktI8g7w6nH3DmS8VuKHeYVKAbZFl5BtSXrhWC/e7s7cs/Rb57+tfnNkxo
	locwpHSRCm2kYbG9f3Zg3uG2ir8ls8oS482Ke/O+Yu1ESXL52EBXNt+Akxn0=
X-Gm-Gg: ASbGnctBas9GdA3Rh/NDbxnuUmw3FPLgqpZUVjnERVwyq9iPwYvFOR8qbkjOuWaIFax
	Q80WC/vjmmYESW1FlRg3lIb4UDvG3iOvPPT2XO6AJ68QlMKaeE04HutHJucRWVHmOry7j4JK+a1
	npWGXx8Hld0mLh0dawRqlCTw4B8D92U6wtVc32ouf++MiO3vlc/XbtqBjHN2F+39IOSVHdWIxuh
	GfduRufZCc4G0dJY6aCBrxLtcXo4nzzkNEpKwGd8zpMEf0MrtBfLI2uccXE7sLnMeRlNEkZqvZY
	GFbdGbJpeoRQTRX2pHMio1JnowxkcYQndNy3ZIJEXB/GF152PW5rFARkXL0W7ViezqGwT5M0P6y
	M/t7PKIVdhQ==
X-Received: by 2002:a05:622a:28d:b0:4b4:56a6:42b5 with SMTP id d75a77b69052e-4b77d12b5demr182036891cf.41.1757964886072;
        Mon, 15 Sep 2025 12:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFByv3gbOZ9VR86tZISSBbCkn06R2fNud9rr95ree3vKzhC+4ynu039NHFsm5ql2GZ3Vf2/bg==
X-Received: by 2002:a05:622a:28d:b0:4b4:56a6:42b5 with SMTP id d75a77b69052e-4b77d12b5demr182034621cf.41.1757964881912;
        Mon, 15 Sep 2025 12:34:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b965f2sm71327601cf.4.2025.09.15.12.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:34:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3815a523-a6d1-4612-8ec8-b955694a5792@redhat.com>
Date: Mon, 15 Sep 2025 15:34:40 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 09/11] cpuset: refactor
 partition_cpus_change
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-10-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-10-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the partition_cpus_change function to handle both regular CPU
> set updates and exclusive CPU modifications, either of which may trigger
> partition state changes. This generalized function will also be utilized
> for exclusive CPU updates in subsequent patches.
>
> With the introduction of compute_trialcs_excpus in a previous patch,
> the trialcs->effective_xcpus field is now consistently computed and
> maintained. Consequently, the legacy logic which assigned
> **trialcs->allowed_cpus to a local 'xcpus' variable** when
> trialcs->effective_xcpus was empty has been removed.
>
> This removal is safe because when trialcs is not a partition member,
> trialcs->effective_xcpus is now correctly populated with the intersection
> of user_xcpus and the parent's effective_xcpus. This calculation inherently
> covers the scenario previously handled by the removed code.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++++++-----------------
>   1 file changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6aa93bd9d5dd..de61520f1e44 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2453,6 +2453,45 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>   	return retval;
>   }
>   
> +/**
> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
> + * @cs: The target cpuset being modified
> + * @trialcs: The trial cpuset containing proposed configuration changes
> + * @tmp: Temporary masks for intermediate calculations
> + *
> + * This function handles partition state transitions triggered by CPU mask changes.
> + * CPU modifications may cause a partition to be disabled or require state updates.
> + */
> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
> +					struct tmpmasks *tmp)
> +{
> +	enum prs_errcode prs_err;
> +
> +	if (cs_is_member(cs))
> +		return;
> +
> +	prs_err = validate_partition(cs, trialcs);
> +	if (prs_err) {
> +		trialcs->prs_err = prs_err;
> +		cs->prs_err = prs_err;
> +	}

The assignment can be simplified into

     trialcs->prs_err = cs->prs_err = prs_err;

> +
> +	if (is_remote_partition(cs)) {
> +		if (trialcs->prs_err)
> +			remote_partition_disable(cs, tmp);
> +		else
> +			remote_cpus_update(cs, trialcs->exclusive_cpus,
> +					   trialcs->effective_xcpus, tmp);
> +	} else {
> +		if (trialcs->prs_err)
> +			update_parent_effective_cpumask(cs, partcmd_invalidate,
> +							NULL, tmp);
> +		else
> +			update_parent_effective_cpumask(cs, partcmd_update,
> +							trialcs->effective_xcpus, tmp);
> +	}
> +}
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2466,7 +2505,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	struct tmpmasks tmp;
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
> -	enum prs_errcode prs_err;
>   
>   	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
>   	if (retval < 0)
> @@ -2491,31 +2529,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 */
>   	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>   
> -	prs_err = validate_partition(cs, trialcs);
> -	if (prs_err) {
> -		trialcs->prs_err = prs_err;
> -		cs->prs_err = prs_err;
> -	}
> -
> -	if (is_partition_valid(cs) ||
> -	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
> -		struct cpumask *xcpus = trialcs->effective_xcpus;
> -
> -		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
> -			xcpus = trialcs->cpus_allowed;
> -
> -		/*
> -		 * Call remote_cpus_update() to handle valid remote partition
> -		 */
> -		if (is_remote_partition(cs))
> -			remote_cpus_update(cs, NULL, xcpus, &tmp);
> -		else if (trialcs->prs_err)
> -			update_parent_effective_cpumask(cs, partcmd_invalidate,
> -							NULL, &tmp);
> -		else
> -			update_parent_effective_cpumask(cs, partcmd_update,
> -							xcpus, &tmp);
> -	}
> +	partition_cpus_change(cs, trialcs, &tmp);
>   
>   	spin_lock_irq(&callback_lock);
>   	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
Reviewed-by: Waiman Long <longman@redhat.com>


