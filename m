Return-Path: <cgroups+bounces-9004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19363B1CACB
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C696D3A334F
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685042AA5;
	Wed,  6 Aug 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJyquuY4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FEA41
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501443; cv=none; b=aG105YNGijbKTRVCv1GokhQrVT3FLy4Nu0eW1y9clgH+DX3GIMITdqKXR5vyQbp3cKlAWxhdpD9ojvGjfYNPE4FEMBUcDTl2rYt6O404kiiAYu4Wr6yWotQvWnBm8TmkH7GHgAQI2QfF2BUVXUdo+6RcNzw0Xs6HmzUlfD8S0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501443; c=relaxed/simple;
	bh=rwu7EbHnd6wQb+iO4s/C8em34k2dJwqajxQ0+wzSRO8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lsQP0XKSlb1oUsaVqhchLzY3AnLN0oe4wuLetsTe10VZlv9UPC3GWpXxlT0iGhh1wXwbeYHqmYgPHhClGEmmWCybqX7acWgVSRZ611dAcQyZkPrMSZ8O5cvHDBxGjLa0N/GazZwLoqu3j7eVOLRXf001evK/oxLaSuSz0AyJxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJyquuY4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754501440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0FtVJ+cvvsMupVuJOSmNRM6v2yyfUsa12kAjP3d/wU=;
	b=TJyquuY4xsHIa0/HVV8zVEc+uCOAzg1ArRTvwvBy6138Hj3UepyUFswMlYvsBk5CEKesI3
	t2qbzewU1NdB2xz4KKlExeH1Sdsom9yh4siDmwd3Xn8xXL74wcIdeS9nNXNHLr8A8Hg7hz
	OtYr2/Go4MtL/gY+osE1iEaCdTZFUFA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-WNYCmkYCOKuknqwDtXahqA-1; Wed, 06 Aug 2025 13:30:39 -0400
X-MC-Unique: WNYCmkYCOKuknqwDtXahqA-1
X-Mimecast-MFC-AGG-ID: WNYCmkYCOKuknqwDtXahqA_1754501438
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8072f828cso12127185a.0
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 10:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501438; x=1755106238;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0FtVJ+cvvsMupVuJOSmNRM6v2yyfUsa12kAjP3d/wU=;
        b=she+xwLc7U7D9Y9D3059j9CiNgYPoAYSdqxnT8UFuCcIH6VBrYjCTRGVHSft+AnJ85
         BI8etVWYtSmOntpXiPs8RcRKsr4m6Me4oH0lDDMNqXNZz4txaz0VS6cCnUIuMx96Mh3a
         AxQOZtS4iHQj0OUUuP6kAm3bqyl2BAHyxlXnW5VxMaMFYlXOMbex7QMxgZIaQKBWkiBp
         xyT+trnKeP/SUatfhBznf4eRcbCrDLgtFLtUgm+aZOG8dj7sACwjZWUEIgO8ZteNleAw
         wxO1/6ou3TlLzUJVXZ4cW3ucXnvDOPTtkDf2DkAdEbKCU1HW+1NZmXcZgGhNsxwuHejr
         GJOw==
X-Gm-Message-State: AOJu0YzGjj0vhUULtu0pquH4DJNLXZxrch2pDdj14u57M6odHbrNxTmz
	FEwoiKXWzs1MDoANWGTkzwRzCjAa8Z6Mhz0B6ccdCU5uDOaxzVPtbNUpMb/yjtrf0BC+FYL82A0
	BfQxX1UDTVeF7UogN5MIMKnnWDyi45G6KUS0hYtDiPWxjgthIHnnRg+5RCh4=
X-Gm-Gg: ASbGncud8Zh2tg1KCc62S+qip0b01E5fYTsiGuCZeeZ0jmXsOcintbkTbXdzPRSb6CK
	tErlyftQIf2ZS0maaCpqbP0DmqNiPZL3LGF2+Ycqs7ooNiB83eWSWGyFoa6XiwF1PlpCTENPWM1
	ZxReT7X9RIP/DmwQ6y6s4hrL5LJH5WLWtM03Np8f0YpiYGmqkhPW/cr3kNVCE3d7mL0kxlU3KWM
	3ZIa7I+skZA734sB8XhDuLJao0Ytum/ePvXS3e1RbA6MjAdSGA460TxopIKznZWj1hLEQLLAXzU
	X2oCWLItPiqLEOxJ1ecbX+cmyA30AiCEVIhw79hwHQnAGmRk4Gylyzl91hJxanQSM7BiACID65X
	a1PFPH6LI4Q==
X-Received: by 2002:a05:620a:2546:b0:7e3:363f:2c19 with SMTP id af79cd13be357-7e816709015mr540442885a.50.1754501438340;
        Wed, 06 Aug 2025 10:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUY/YEaX2Klj4Ymjnw1Oc1ae8Dt5bDFRXWaXaUiPkMDaNaMn8PLlQGjoTN+3PRBhj6S9Strw==
X-Received: by 2002:a05:620a:2546:b0:7e3:363f:2c19 with SMTP id af79cd13be357-7e816709015mr540430185a.50.1754501437403;
        Wed, 06 Aug 2025 10:30:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5947dbsm829284385a.12.2025.08.06.10.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 10:30:36 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4ebbbe0b-0f4c-4002-b13b-263b7efc9f69@redhat.com>
Date: Wed, 6 Aug 2025 13:30:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup/cpuset.c: Fix a partition error with CPU
 hotplug
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-3-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250806172430.1155133-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 1:24 PM, Waiman Long wrote:
> It was found during testing that an invalid leaf partition with an
> empty effective exclusive CPU list can become a valid empty partition
> with no CPU afer an offline/online operation of an unrelated CPU. An
> empty partition root is allowed in the special case that it has no
> task in its cgroup and has distributed out all its CPUs to its child
> partitions. That is certainly not the case here.
>
> The problem is in the cpumask_subsets() test in the hotplug case
> (update with no new mask) of update_parent_effective_cpumask() as it
> also returns true if the effective exclusive CPU list is empty. Fix that
> by addding the cpumask_empty() test to root out this exception case.
> Also add the cpumask_empty() test in cpuset_hotplug_update_tasks()
> to avoid calling update_parent_effective_cpumask() for this special case.
>
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: Waiman Long <longman@redhat.com>

Oh, forget to remove the unneeded ".c" from the patch title.

-Longman

> ---
>   kernel/cgroup/cpuset.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bf149246e001..d993e058a663 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1843,7 +1843,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			if (is_partition_valid(cs))
>   				adding = cpumask_and(tmp->addmask,
>   						xcpus, parent->effective_xcpus);
> -		} else if (is_partition_invalid(cs) &&
> +		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>   			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>   			struct cgroup_subsys_state *css;
>   			struct cpuset *child;
> @@ -3870,9 +3870,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   		partcmd = partcmd_invalidate;
>   	/*
>   	 * On the other hand, an invalid partition root may be transitioned
> -	 * back to a regular one.
> +	 * back to a regular one with a non-empty effective xcpus.
>   	 */
> -	else if (is_partition_valid(parent) && is_partition_invalid(cs))
> +	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
> +		 !cpumask_empty(cs->effective_xcpus))
>   		partcmd = partcmd_update;
>   
>   	if (partcmd >= 0) {


