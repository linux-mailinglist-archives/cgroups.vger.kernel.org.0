Return-Path: <cgroups+bounces-12044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F7C64FD4
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 28D19289BD
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC629BDBA;
	Mon, 17 Nov 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw11Mq0f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r4vzNwJo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0D29BD80
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394985; cv=none; b=l9++5HbtgbVVronRcBRCKRRBRJjWuendQJyb2BCHLngyqCk30Qi785Rvx4uHb6e0+QAW8lMfVc7SEmZL8rtenq4BU3M/s4TIj+GAgeMoZYEN/ICuFYDxFHOTlZNdNo9w1CPeEpzdurwdUE63GQmF8liHKx8ptGpaUwLVQr9WAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394985; c=relaxed/simple;
	bh=tTZhsNRVLWfEpLCgxNhJjA6kY43D7elTeo9B6cxCYfw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f5TzAhRcG4NODpSod4HaA9IDj7Ns34JPE9HqASWhMtPkpxvsmCpXsJvpYpnzL1ybWXurgP/1dG6CuZs5MnzXPpX4OiIZgp5Z0q2qh2C40W3sS5LD8oGrRsIUOSLdJv92tHShK6tp0iRfEhXIE9gLOVwR5MGFvnS1/DrdZfEVg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cw11Mq0f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r4vzNwJo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763394982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1RJNJZ82F8TzhuH6RX+KFV7V9KN5X1jSm+ZEyTowtI=;
	b=cw11Mq0fj9dtm4MC3PA/RfZAsQwCnzwYSlQ3jkqpSNN4s6YP7Y693IEjtHeUUxPlTmqxDe
	GmnJTKDWmPBzeG+hU7lojq6ZQWkCC/ZEsLvARuDPMny5Mf2NB3wzBrsNQT4iymeCEVVYwE
	/muazJawvG8soBtBmHSYC6gBiFdSLfY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-dvkACfgAOdKA69s99jkSXg-1; Mon, 17 Nov 2025 10:56:20 -0500
X-MC-Unique: dvkACfgAOdKA69s99jkSXg-1
X-Mimecast-MFC-AGG-ID: dvkACfgAOdKA69s99jkSXg_1763394979
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22ab98226so2141890885a.2
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763394979; x=1763999779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1RJNJZ82F8TzhuH6RX+KFV7V9KN5X1jSm+ZEyTowtI=;
        b=r4vzNwJoNNQ2pwvO+fCY/52e9AueFRj8ybbXnldhYaasl9KSm2Y4TmDfeBsR04jaFY
         mABtoOQpFPkYDEKCj8UIJBIa/bhOlJwSUkPLIjboqT2/G3MIOjtXBmvOtlaaCvluMPk9
         /gnVvrLlpMApwhOfdMUVO4TyeP696FT81gKiHdn2ENFK8IFCkVU5A56BnuqzahKL4sVb
         vKlC3LbJYqq3CbIj3czt424B2jk608xuBHUgHXA531zd8Z2gcB8ryLIWssSAo35SnI3n
         ze2Kl8jXoMt4DyZU9//Y4pMw7S9I394DxPxIs98aOfbC3CvhcQ3xf65TO6cesxdePZgF
         TptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763394979; x=1763999779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1RJNJZ82F8TzhuH6RX+KFV7V9KN5X1jSm+ZEyTowtI=;
        b=ZcrvFuzB2+hQj6AJhi2l6+4tGrNJLuByE8HVPTuS5kUvf298kHP6Owgk7cSkfPB1PE
         Rn98xwOfgbZ7Ttw8lL7k+gBOlw543TUIVjcezMpM2sRHIA+I0PCB63oHJJMTgTKxN8IP
         E2ykPmXh7FrpXCt4WGxDAvawB/6wEfrb7kqFsssxxKsM8kqmrP+UORFIJvWWCLLwnD6b
         nXi2kU89MVoPigJ4omDfmRQBSJsUI6XF0nAoMeNeCKFhwoOMuNnhT+SLPo6tlDwEZajN
         vzqyssFDi3giTwXSv/6wmb7jpzdrC4GwdDXD5fuL37zyYUnLqUTa8FHqD1Abg8lghGJL
         UGgA==
X-Gm-Message-State: AOJu0YxOyYRvS8HAw54NPBdxKiqsxhrEnujTWmkC0/N0p/E014W089V/
	kKTnOt9G/U+Cp4k9jbgqXoZTqvAYuzhxcz8hDsncojFjGNFen9qxE+wF2AGK9+N1Y6dk21+HqJC
	ETW4WmFEMIMg5qHuDyDgoUO7zFBt5EVDI+B2Qsuodb2SPnaHwavxn68+XZwQ=
X-Gm-Gg: ASbGncsWsfeuK6Lg9u2ORmDUBHTiiN74wG1aEN5CeFrpQRAKjj1sx8z2O0k2cGjqpIC
	R1omXGU9kUfmEyJ43aQAO95nGj4qrcEQ1DnvXinKCqAhjP0V6MQwZBUmWJ6L89pXLi1ZFQD0nDA
	Ov1D5P9ATeAdY9rBLNsGFVYziFnZ9vOapt9YOVjPRI5YLnN00xcPPmZUprAE1A2dXxRgLRB5zUI
	4ON0yuaIRJw+gwULOax1+NJMuVeDXy94ZXewwLLcuM1wTKFEeUbQ32NI5jyLU0AY2HDBGKccm5+
	udTi9cisIeTZkuzTYUdiObCACmfB4ArdhP8uzxednO9+L1djuEaJ+JYldNCeibfNQGhfGcoreu2
	fmBHSKc+WbwqWz10JY9258lioBzqNw4ui+tZ+dsqWNxfpIg==
X-Received: by 2002:a05:620a:172a:b0:8b2:e986:2701 with SMTP id af79cd13be357-8b2e9862c47mr579861385a.90.1763394979412;
        Mon, 17 Nov 2025 07:56:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0lJ+5uQ6BebjPplYNJBYDM5ltIejy4iBVBvXIno/oN341rrqjwPE0VB9cptmvx0IFEar4UA==
X-Received: by 2002:a05:620a:172a:b0:8b2:e986:2701 with SMTP id af79cd13be357-8b2e9862c47mr579858485a.90.1763394978986;
        Mon, 17 Nov 2025 07:56:18 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb2522sm996309385a.23.2025.11.17.07.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 07:56:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e042851e-6cf5-4475-bf4d-a69bb5713c7f@redhat.com>
Date: Mon, 17 Nov 2025 10:56:16 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: treate root invalid trialcs as exclusive
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <765120d5-1887-4376-b779-8294df137b9d@huaweicloud.com>
 <20251115093140.1121329-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251115093140.1121329-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/25 4:31 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A test scenario revealed inconsistent results based on operation order:
> Scenario 1:
> 	#cd /sys/fs/cgroup/
> 	#mkdir A1
> 	#mkdir B1
> 	#echo 1-2 > B1/cpuset.cpus
> 	#echo 0-1 > A1/cpuset.cpus
> 	#echo root > A1/cpuset.cpus.partition
> 	#cat A1/cpuset.cpus.partition
> 	root invalid (Cpu list in cpuset.cpus not exclusive)
>
> Scenario 2:
> 	#cd /sys/fs/cgroup/
> 	#mkdir A1
> 	#mkdir B1
> 	#echo 1-2 > B1/cpuset.cpus
> 	#echo root > A1/cpuset.cpus.partition
> 	#echo 0-1 > A1/cpuset.cpus
> 	#cat A1/cpuset.cpus.partition
> 	root
>
> The second scenario produces an unexpected result: A1 should be marked
> as invalid but is incorrectly recognized as valid. This occurs because
> when validate_change is invoked, A1 (in root-invalid state) may
> automatically transition to a valid partition, with non-exclusive state
> checks against siblings, leading to incorrect validation.
>
> To fix this inconsistency, treat trialcs in root-invalid state as exclusive
> during validation and set the corresponding exclusive flags, ensuring
> consistent behavior regardless of operation order.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index daf813386260..a189f356b5f1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2526,6 +2526,18 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>   	}
>   }
>   
> +static int init_trialcs(struct cpuset *cs, struct cpuset *trialcs)
> +{
> +	trialcs->prs_err = PERR_NONE;
> +	/*
> +	 * If partition_root_state != 0, it may automatically change to a partition,
> +	 * Therefore, we should treat trialcs as exclusive during validation
> +	 */
> +	if (trialcs->partition_root_state)
> +		set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
Nit: We usually use the non-atomic version __set_bit() if concurrent 
access isn't possible which is true in this case.

> +	return compute_trialcs_excpus(trialcs, cs);
> +}
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2551,9 +2563,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
> -	compute_trialcs_excpus(trialcs, cs);
> -	trialcs->prs_err = PERR_NONE;
> -
> +	init_trialcs(cs, trialcs);
>   	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
>   	if (retval < 0)
>   		goto out_free;
> @@ -2612,7 +2622,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 * Reject the change if there is exclusive CPUs conflict with
>   	 * the siblings.
>   	 */
> -	if (compute_trialcs_excpus(trialcs, cs))
> +	if (init_trialcs(cs, trialcs))
>   		return -EINVAL;
>   
>   	/*
> @@ -2628,7 +2638,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
> -	trialcs->prs_err = PERR_NONE;
>   	partition_cpus_change(cs, trialcs, &tmp);
>   
>   	spin_lock_irq(&callback_lock);
Acked-by: Waiman Long <longman@redhat.com>


