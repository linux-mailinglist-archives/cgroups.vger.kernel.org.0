Return-Path: <cgroups+bounces-10125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D009CB5856E
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A381B2258A
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C29283C9C;
	Mon, 15 Sep 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9P1LQHn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3D27FB2B
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965155; cv=none; b=uzHshM9TtPtAWhQ9GFHSfZZ82U7DwBAgASmw3t0vK1r2c0yeJQpUAZs+j+6SJBR0N2fOCCjaeJljMupiVx7vAlagamQ5GRDe3kvImgqRBf7Nmo+UuNXITB1ZhLSo+8sPPmZp+CKOzIyI+8zYtnjHxAsTX/vy4oZGRPMc00HvIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965155; c=relaxed/simple;
	bh=87rhYXHDtQiCMzx57VS1w3vd9t5iVIWXWbpAfZ5d7+Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZG0Z0ZHeMgUN+lIQ8w0hCndBYG3x4B93E03uLXBPg6po71W0Yx41oQ0SVaBJ3h0H6+yfekhaRgaKug3kVbrm+/vUdVFTHtqhu/EzBwFZKTMcSQU/+fICpfniFPbVhZ4cDjy8hqM3BoY83vyJ/v8RVogTIhc2ClE2LCB+3mTlhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9P1LQHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757965152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7HkFYGg6A427CkTE8Uu+596fVOO9ot2LNl0j4v3H3A=;
	b=g9P1LQHniy2w4LSIq1eGA+0bX7y7vlO24tN7P8L0qx2ZWOkcB/wRwqol4uS1E0dLsSpaI5
	P1GSKdPxOuGc36Xq5gkqVfxzcIDwNGhkhunx8F8NMRQfDVWqeM8C/hbya9MSnNwKE3fZTz
	jiAX645t6gzRIiAvsjlKfkQhyNeb+K0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-BrDIF0OvNX2FnnSKoXq3vw-1; Mon, 15 Sep 2025 15:39:11 -0400
X-MC-Unique: BrDIF0OvNX2FnnSKoXq3vw-1
X-Mimecast-MFC-AGG-ID: BrDIF0OvNX2FnnSKoXq3vw_1757965150
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b302991816so96373941cf.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 12:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965150; x=1758569950;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7HkFYGg6A427CkTE8Uu+596fVOO9ot2LNl0j4v3H3A=;
        b=cMwJzDikHZ4XbyqEX3PvHb5KbPyBIQRUiqxzRg2LsHfPuzXC7DBiPd+y/9Leeo4ifV
         ZGRCc7YQTYb22cR4WTTBiq74k3cES3XIIb9vsiF9nEuHED4CQiVDDF7SwUv4hGs8TQ8N
         9bXl158w2rqC/X8shkkmZb65TXkWjrfW2UwF5fY97zHThdOGgbLF1A6AfB/XBBMAXQr+
         bPCF+BXUgETFjmh2uUKXL5OazBjBfDquMy9bC/32KeM1q/weocT66ChTyZrzAKCLVshz
         F8GngWqtF5AOHfXqT4RRs8K/JpIvbfB4vfbkZ2b6Plg6B8y/5iJnJq5730vEVUNuTI22
         1OYg==
X-Gm-Message-State: AOJu0YxabFlHAR4uRvmNK/5pN9svAHYUOsy9XyYk6ik1tUlY/RKIi7ub
	RagMSLoecyHFIHwsicmqMsjUB5ThgR/wLt12MwZ+MOtJyBCMdIqqBOvEeXgr/tLMPhylx/tddna
	4MWVMjPK86Qeg1l8FJvwmcuEMIW3a+9Jh0meb0cYYe3NWJGHo2UToe/BCPhI=
X-Gm-Gg: ASbGncuzxuctslmJiiTp3EEiEHJd0Q0MZI1rViDSKh4mRRQ9SviFzRYfM4vpWC90qD/
	g3JZR68KKJDcAcEz12jMYxADeIVM7Zc7XRPH/C/8urA7wQAh8uTfspw+1FhOznkhw229JVUQTwN
	Qsgi/4r0jyhHy8rXU7sx6PVjJvehg6YJ+DhukLb5smsrmVep8r0TlLCxOosY9vSb2pujbGBT0FZ
	WgRoncGVLD2GSrcvRD3phNwqecqJMm2TkygMGv6Ji0YwK12oe8vQLtliTgbmmOjjxx4H+8qiPv+
	LKcqEDeOfz28YjP7AoSg/s5JigLZlVKilgjfPQmOIyVxQ7T/dFbQI9+J7aUOxhkHGRhaaAPOfBy
	pSHeWgy43TQ==
X-Received: by 2002:a05:622a:4e9a:b0:4b7:9972:1d8c with SMTP id d75a77b69052e-4b799dd639amr103831581cf.54.1757965150567;
        Mon, 15 Sep 2025 12:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7pID2mDTqz46UkO3VdcT/XS3fmKdEaUkct2TWo3/kc/qTZwcCyfeBGxHuQNXAXCw+g5ytnQ==
X-Received: by 2002:a05:622a:4e9a:b0:4b7:9972:1d8c with SMTP id d75a77b69052e-4b799dd639amr103831151cf.54.1757965149996;
        Mon, 15 Sep 2025 12:39:09 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dd12bbsm73788181cf.43.2025.09.15.12.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:39:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cb1e7156-8043-452e-bdd3-076f72c51bee@redhat.com>
Date: Mon, 15 Sep 2025 15:39:08 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 10/11] cpuset: use parse_cpulist for setting
 cpus.exclusive
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-11-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-11-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Previous patches made parse_cpulist handle empty cpu mask input.
> Now use this helper for exclusive cpus setting. Also, compute_trialcs_xcpus
> can be called with empty cpus and handles it correctly.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index de61520f1e44..785a2740b0ea 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2567,27 +2567,20 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	if (!*buf) {
> -		cpumask_clear(trialcs->exclusive_cpus);
> -		cpumask_clear(trialcs->effective_xcpus);
> -	} else {
> -		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
> -		if (retval < 0)
> -			return retval;
> -	}
> +	retval = parse_cpuset_cpulist(buf, trialcs->exclusive_cpus);
> +	if (retval < 0)
> +		return retval;
>   
>   	/* Nothing to do if the CPUs didn't change */
>   	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
>   		return 0;
>   
> -	if (*buf) {
> -		/*
> -		 * Reject the change if there is exclusive CPUs conflict with
> -		 * the siblings.
> -		 */
> -		if (compute_trialcs_excpus(trialcs, cs))
> -			return -EINVAL;
> -	}
> +	/*
> +	 * Reject the change if there is exclusive CPUs conflict with
> +	 * the siblings.
> +	 */
> +	if (compute_trialcs_excpus(trialcs, cs))
> +		return -EINVAL;
>   
>   	/*
>   	 * Check all the descendants in update_cpumasks_hier() if
Reviewed-by: Waiman Long <longman@redhat.com>


