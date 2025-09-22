Return-Path: <cgroups+bounces-10363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB1B9364A
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D43B7377
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 21:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B12F657C;
	Mon, 22 Sep 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBfQ5XPg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D092FD1C2
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577064; cv=none; b=qrjtnpTaQlu15MbyMTwnf/kLm56YmsDEa9aRYKp5dt1Kz6IGvswTvKVcm0oaSAd2570AnbQEK11+qMrBMVBPfrqCxqmw135Ks+f225Vhr4UqeL1uubNhmqcU9ZOKC1rQqKzSLkytj2+UfGgw5T7H6BM0lGsba3f6eBCZTqOOGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577064; c=relaxed/simple;
	bh=2xRByGZWaFYp+yJDf9/2jDxhNXjmPcIroUgG7n6lLAU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rwXqoDC0fubbiDvykZNuBGNNFtLiEXx+uPiIDMk3lgeQuOtfMw9+zoA2wZoVpvya2Wx+Sidi2oBUggZ4lgkFVRwWzgfgfqKmBtMDw7qnY4cZYV8mhxoUHePwKHn8WHLa+f5JZT5iKgN5x0HPPzg+1ztp1CxZrUhXuWDeDWvAlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBfQ5XPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHx9GFljDLp4HKMuRTlHK8PpeM3Uys9a7nlqWQ8x1JI=;
	b=gBfQ5XPgBXIHwy3wHNyNX9tobP3ZOa9jcxh0Bh1SY0z3YjjGBniFTvJzkEOxlQZET07N3Q
	3HsDlbPDk8vcrHuJdCvkKfUjGHbB+UQQNadt4dUXYItGpWUpUlJ65vskJuq3jaXpfyyQ/F
	psTau4vufLf1OAAibmGMD5fY2Xw6atM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-srlS5wbmOVOhhCaguoibkA-1; Mon, 22 Sep 2025 17:37:40 -0400
X-MC-Unique: srlS5wbmOVOhhCaguoibkA-1
X-Mimecast-MFC-AGG-ID: srlS5wbmOVOhhCaguoibkA_1758577059
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b548745115so105852301cf.0
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 14:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577059; x=1759181859;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHx9GFljDLp4HKMuRTlHK8PpeM3Uys9a7nlqWQ8x1JI=;
        b=Knz90D4ErdSIED32FTtP2lQzhZ3SmXOgFW9mr+RARQvfRU+tVlazgzvHsRCFVLGrLM
         hi6/pNxLGVoPaGxPyncUSbOfxTcgzcsWiZZ4DWzJKe+oGUggtgUWlQD87UtwxUSfOOpO
         QQp9/UTFjYodUeQPQL3T/2KpghTbvHDt8G6Dz1s9c02fXXhromvXVm6r4l55rJKIaqxI
         WvFtJmGQyczRe7/mc7XWjGDdmCc8sN5fXAnRPVn0+RLI4vY3X+aaoYrZnQ2A1r3P8mi9
         a12TuhvTSde3wZmXx3Dv98FCVb7d37rTYbtT2dhEKW3tafYs+SJQYK40Gc8xW4Qme506
         3DgA==
X-Gm-Message-State: AOJu0YwEyYtsbhAn+/XeZaPHH2IXxApmy/g2CHXmaw7J1bDfebapxsAP
	fSVmYbbaBrIYJMeqDsIPLdz8HDcFcOGoN/vZwVnAw8CW4E9rnmvKm2cwncyU6QrDlNaYdxkqxM0
	jUqFP5FedipHg2pZFZNGPv3eEjt6NEAloQkRx6ZFd1bP62Kqf5+KYegZrFdw=
X-Gm-Gg: ASbGncv76WGo7kltOmGJLEspTtEllf1pJeirhKVl4xrSfVtXMMnBGd0YCkgULYe0JCG
	miM7MmdOGMmi+4ZcNpCB09FnlejqI/X9QOuPQrfMSDoPuLlFx0+zZ9Lrso/yi2bZV+VsQRakssS
	jOcP9f2XD+ocGgxBtfrtXATp+vAD/n/ccHvrC3SxSZ75wAu8342T0vOUx29K3sDb0sVPL8Hp8xi
	gpOzoA/F+aevG5YeRiCJl+FiUKWylhnejrLaJRKPU1XJPLPgiy1JwRZ0te1EeuuhO5y5dW8+DEc
	AOqMZa10QQYCmrHhPY8zZGZgrKVPx5sRx2m5BzG4JufOa6jgJyAdAbyRe4WkLpM+cWUwiGkPLzT
	S2g3SQVq2tfo=
X-Received: by 2002:a05:622a:1a90:b0:4c7:e39a:388a with SMTP id d75a77b69052e-4d3830ea28amr3416041cf.0.1758577059494;
        Mon, 22 Sep 2025 14:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF65sFLcUY2meuKw1Ms7ZsIIJeyCSdxc8t3NjAE5Ax7Mh9ZfaXbvNEG1GYuZczXHHGoaefyDQ==
X-Received: by 2002:a05:622a:1a90:b0:4c7:e39a:388a with SMTP id d75a77b69052e-4d3830ea28amr3415811cf.0.1758577059075;
        Mon, 22 Sep 2025 14:37:39 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-848b1f5b5f6sm283872485a.31.2025.09.22.14.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:37:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f5288f26-0d4a-4b89-8119-7c3b966df1fc@redhat.com>
Date: Mon, 22 Sep 2025 17:37:37 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] cpuset: remove is_prs_invalid helper
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
 <20250922130233.3237521-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250922130233.3237521-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/25 9:02 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The is_prs_invalid helper function is redundant as it serves a similar
> purpose to is_partition_invalid. It can be fully replaced by the existing
> is_partition_invalid function, so this patch removes the is_prs_invalid
> helper.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 196645b38b24..52468d2c178a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -132,11 +132,6 @@ static bool force_sd_rebuild;
>   #define PRS_INVALID_ROOT	-1
>   #define PRS_INVALID_ISOLATED	-2
>   
> -static inline bool is_prs_invalid(int prs_state)
> -{
> -	return prs_state < 0;
> -}
> -
>   /*
>    * Temporary cpumasks for working with partitions that are passed among
>    * functions to avoid memory allocation in inner functions.
> @@ -1767,7 +1762,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   	old_prs = new_prs = cs->partition_root_state;
>   
>   	if (cmd == partcmd_invalidate) {
> -		if (is_prs_invalid(old_prs))
> +		if (is_partition_invalid(cs))
>   			return 0;
>   
>   		/*
> @@ -1874,7 +1869,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		 * For invalid partition:
>   		 *   delmask = newmask & parent->effective_xcpus
>   		 */
> -		if (is_prs_invalid(old_prs)) {
> +		if (is_partition_invalid(cs)) {
>   			adding = false;
>   			deleting = cpumask_and(tmp->delmask,
>   					newmask, parent->effective_xcpus);
> @@ -2964,7 +2959,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	/*
>   	 * Treat a previously invalid partition root as if it is a "member".
>   	 */
> -	if (new_prs && is_prs_invalid(old_prs))
> +	if (new_prs && is_partition_invalid(cs))
>   		old_prs = PRS_MEMBER;
>   
>   	if (alloc_tmpmasks(&tmpmask))
Acked-by: Waiman Long <longman@redhat.com>


