Return-Path: <cgroups+bounces-10126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ADB585B0
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C907AB196
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16292283FE1;
	Mon, 15 Sep 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb51ttJN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2227B4F7
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966753; cv=none; b=a8GXHD75YC5rGZmAxU7qxnfR2cmjGej552kROuuO8xpC7kxf90AfOdDM7olNX+ucKSHeeF4LMy6OljtAyMWFqjiPQyEGUQEy1vSYdFEUzcEGCduQI2rhBG2xhubAHsnWV91mFJY/fw3aNbRUrQV139//7UAXzYNLf5IHCSLJUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966753; c=relaxed/simple;
	bh=kc2vtL6IWZ9uC931/Y1//L5UMfqVfj7OQmbrDCkKoZE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PCD/QqCdfNbA8gI6kV+SZs4Q9J/eQarQINBDI1mzVdaERLwvq1wh2rLV4MajHY93rBWXixNSZV5UpXwRY2SmWHEaWbSdhB7iYap65giNMh/wPuowa+cB7teo5tKrNsnb+0TQgjTCBBfTDVpTaa1bmA1yaoUhTvRAfF1N+4oOScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb51ttJN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757966750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tud+qFvr8mcEuYu+zIpuPvpugJ9JnVlqxpX9p0purRo=;
	b=eb51ttJNNsqJGh3JKNTBL0TvcqKeYNrU04k0ypICIm2GSFyEPv4hTbaRK6ptZfTTdsDPEJ
	uShYyLttOIZa7EbH+I5sXCSrje7NJ1oz9cHvz/k/7MUNvQQ/4/waX8cI+IevtAov3Qj97x
	OfJDW+ZX6/ecIpkk4ZMfmQdEntLoN6k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-aOzxb1rFOn6gJwM1mxLb-Q-1; Mon, 15 Sep 2025 16:05:49 -0400
X-MC-Unique: aOzxb1rFOn6gJwM1mxLb-Q-1
X-Mimecast-MFC-AGG-ID: aOzxb1rFOn6gJwM1mxLb-Q_1757966748
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-827061b4ca9so418531085a.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 13:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966748; x=1758571548;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tud+qFvr8mcEuYu+zIpuPvpugJ9JnVlqxpX9p0purRo=;
        b=vRUI9ZkKhqa83pnQ4vIz2Ct6Ih9+n9MpN1YTGOWpDNZLelLqpPvTEfCMBNwkbYN8Wq
         1h33NID7XBDEIR3KRfxcSRTyfJJvyV1FoSGSpIxfRc9/Qdd/Zi3E5Yf+LdKgRkkUi6TP
         sDmtM76Vqgl6E7Xh81tkxjBG/v9B3fIpLSFqV8KOcMFO9cMJAjMZFt+x9zZA5nePr1yb
         lMIySQXqIFg/NUwzw67beQyvm8s2uYQjmVBnAwtS2AJSX9ILjOyMVM+jXyRKjUq6sQAh
         3POJWGrm2NtXxXpPJgQ6o7cdUPcwMU5h465t9op0mae3dg21sTffFES72JLEmwTIs684
         t6vw==
X-Gm-Message-State: AOJu0YxdDGayaSPaWRzpKvj2nWC2SEShQTjYOJrwtpAhPdAiQDz92ahA
	TuPJ6SFvY7PgkDBCBDFXRH+F3zkbuwb6M6/rTzV/6wo7nK1b3CJmOgalinGZaHUj6o/CRbH/Pw6
	+YYGiKBu7r2uPqwtiPY+YhGOda681Z6L9M+iHV2JiIqzevT/rPm8FJdsCdvc=
X-Gm-Gg: ASbGncuVRRGLDAIEUqAdDFHTgKhJxT3XoZiULyKV+h2iVrj8S8dtIP25arZrXZK70I6
	INU3Nd5yuz4Aqv9JfKNtPjoShrRQ0ejVWKTusW0J0XIbthaiwHh8ZhG7ZFqMutho8CGYV8bxn+L
	XUq8D8/wm85ReG1ai/DdiXKtmKgoIoKQziWa+rjUkiI5XiY5bXSky53X75L4iFafuWcKOE5Qapm
	bial54qVMfkQGUKwmhVQpJTtDuGSMGC6ODfy3D7V60e+51E6+6tF8er5kA0uXLU1uQHS7Ymod75
	6NR0b0KEuY//mMbJyyaEkhjfyQtE7SzIlyqUiEvV957KtV8zFZTBvaUdTPlCKEqtlvEWpI4U4/W
	+0g7t8OJpSg==
X-Received: by 2002:a05:620a:408a:b0:813:8842:93c3 with SMTP id af79cd13be357-82402afe9ebmr2021630485a.81.1757966748140;
        Mon, 15 Sep 2025 13:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7t8TrGzGCl9m2tTah9RZQU8U56F+r3rZCRWmTBzJhsX73BL+Xi9NDTIjbCTBhvNTuYHXBmw==
X-Received: by 2002:a05:620a:408a:b0:813:8842:93c3 with SMTP id af79cd13be357-82402afe9ebmr2021625085a.81.1757966747579;
        Mon, 15 Sep 2025 13:05:47 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639daba5dsm73805271cf.31.2025.09.15.13.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:05:47 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7937af93-9652-4032-93c9-7d7d8571c52b@redhat.com>
Date: Mon, 15 Sep 2025 16:05:46 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 11/11] cpuset: use partition_cpus_change for
 setting exclusive cpus
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-12-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-12-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Previous patches have refactored partition_cpus_change. Now replace the
> exclusive cpus setting logic with this helper function.
Nit: The term "refactor" usually mean updating the code of an existing 
function, sometimes extracting out code into new helper functions. In 
your case, partition_cpus_change() is a new helper function. This is 
also an issue in some of the earlier patches. I would prefer using 
phrase like "A previous patch has introduced a new helper function 
partition_cpus_change()"
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 29 ++---------------------------
>   1 file changed, 2 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 785a2740b0ea..6a44dfabe9dd 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2562,8 +2562,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   {
>   	int retval;
>   	struct tmpmasks tmp;
> -	struct cpuset *parent = parent_cs(cs);
> -	bool invalidate = false;
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> @@ -2595,32 +2593,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
> -	if (old_prs) {
> -		if (cpumask_empty(trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_INVCPUS;
> -		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_HKEEPING;
> -		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_NOCPUS;
> -		}
> +	trialcs->prs_err = PERR_NONE;
> +	partition_cpus_change(cs, trialcs, &tmp);
>   
> -		if (is_remote_partition(cs)) {
> -			if (invalidate)
> -				remote_partition_disable(cs, &tmp);
> -			else
> -				remote_cpus_update(cs, trialcs->exclusive_cpus,
> -						   trialcs->effective_xcpus, &tmp);
> -		} else if (invalidate) {
> -			update_parent_effective_cpumask(cs, partcmd_invalidate,
> -							NULL, &tmp);
> -		} else {
> -			update_parent_effective_cpumask(cs, partcmd_update,
> -						trialcs->effective_xcpus, &tmp);
> -		}
> -	}
>   	spin_lock_irq(&callback_lock);
>   	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
>   	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
Reviewed-by: Waiman Long <longman@redhat.com>


