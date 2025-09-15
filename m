Return-Path: <cgroups+bounces-10118-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9742BB584E0
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BA14C4FBB
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F542BEFE8;
	Mon, 15 Sep 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISisTkKq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993827F010
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961867; cv=none; b=g4jnAI6F/FEd87XQrKBbfG5E20B0aZkaoshyXFJm7+1Lhs6IrkjL2FVSuLsMLfBQADHLNvCfeUK3YyoLUQKZc+oy4GSMbe9ttbPMoyG/YEftbJ+hdRH02or4AGMpztEPdDA3iz/fDqve6FQtxLAl2lrwJofREW6sqrPZtdrK1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961867; c=relaxed/simple;
	bh=SE2vihbDwKAlgNROMqcmKFijlaF4+rdzsSF9AaPdOnA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=II37c6QGNAXVnnCg/Km41/S9e89gylyHXnxxNcetgkJIHkk89Z7is3OSExJLqUWDlUwx2swhwYyUurzJztiEVaE75zWeLdSmHrKMjLGt3mtS9tSu8aWzVl166MNV0KXoNKkO7P8b2l2Zp9HKdUyq5YUnhKt8ghNRqRugLEbK/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISisTkKq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757961864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVEXgGrBTb/ZutFPc/VlA9nQarWwoiDlzJd2Xlmg0EI=;
	b=ISisTkKqNGERTQQOCKUtW2Wgqj1trqrDHz3t29ACWFE36tncF4PNPn23a/YKUAgy7SMfzW
	whJGogdZWA4p9GmTMH4gO0Vk+kJhGiO80lwzyqiPdYxPpDLyZv24M1ft17z0SsW7GykmQo
	y0TIKxM5RASAHbcJlaCqrEGLURiRxWY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-sjjL0-xdN26N712RB2dAvQ-1; Mon, 15 Sep 2025 14:44:23 -0400
X-MC-Unique: sjjL0-xdN26N712RB2dAvQ-1
X-Mimecast-MFC-AGG-ID: sjjL0-xdN26N712RB2dAvQ_1757961863
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5eb7b2c05so112676311cf.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961863; x=1758566663;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVEXgGrBTb/ZutFPc/VlA9nQarWwoiDlzJd2Xlmg0EI=;
        b=obsvL7fhGl8CZUTYFIVA6RXhqc2xSGreJWs8Eugc/kMgkqRj8mJylEv+pfwM2aUOEa
         K++flfbZsNT/YKGH1dIU+ZrNFuPf18frgAILeusRsu+Q5AEMUyojqVpRACIQMlPUKsBz
         GnyBw5F3yto/zS4gAr+Cd4MYnJMx3YlS8yYktI4LZvfbte3IHKOLt9rVssJtNjRflS0z
         yfYEq7ilQhko/2+hzU5WABkVe//ozZyPQeTasIvvyu/70m4/ccXU0e6PaYsdGTU92qby
         kOiiioSa8Fsuv2wt8kDGq5gCJFvYtIKIoBH20u656xLL5bs36qw6sl1ufJsfaYf0pXZ7
         4bQw==
X-Gm-Message-State: AOJu0YzR7UBWT9ULA0BYx5xS9zAlBgPBmL3oCmvHzyzbOQe9u91pabMx
	78koIy4eFMOqY8vgzRB7MKC+jm/OItiJvhroBJwef80ESh5N9/uLZltXdBEO8q4s+BAYt60ZyMA
	0gRElwROZyQQ/anVpQgJRNnoM3HL8EVhEHM2Y4xem7uBnX0+y2W9YfPzfPu8PIyeUC6c=
X-Gm-Gg: ASbGncvKVPvuPeKu8vGSKYPwnBGtU03+CjwGRfi3JFJolOrpR+9pZ7/dly9U3RumHsD
	Kjb2fjmOsMbq8/jydRgloxS/D1/wn5y5kvsr0053IqMoYXU5LhDOVGMbPZLcoDr4+m2ZKcvS/iy
	XtiqYKnJp/xQDq6HtavGH/eAdqr/pbpA+/d0t5YSaS7BJytPwYP6Acr9lVacw1Eoh99hFMXu0Wa
	XZ92ph/eDT/LIChx5fIJGZLRunKbXfzPhSex4fTyFPabjKEvTK/jA3qJNzm/HLzd0DQuveEOMk2
	l9fns+3MiAR7n5RGiSZ9sIBI3ryuJtrHZlUBSwpADirsBHqAUgcjdlxrpMHNPcDsy2bBFItSSZ/
	KUB3CwJtt8Q==
X-Received: by 2002:a05:622a:258b:b0:4b5:d5b9:d334 with SMTP id d75a77b69052e-4b77d082f39mr156025631cf.19.1757961862509;
        Mon, 15 Sep 2025 11:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgt0OFQVYuhp0ladKUKzrNPy4Uimg9/tb4T27rKtTw64rJmHOdbOsrKnEy9flEDySde0B+Kg==
X-Received: by 2002:a05:622a:258b:b0:4b5:d5b9:d334 with SMTP id d75a77b69052e-4b77d082f39mr156025301cf.19.1757961862048;
        Mon, 15 Sep 2025 11:44:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639cb1b33sm71752721cf.14.2025.09.15.11.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:44:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f281aa93-a0cd-4767-8673-99008e0b1412@redhat.com>
Date: Mon, 15 Sep 2025 14:44:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 02/11] cpuset: remove unused assignment to
 trialcs->partition_root_state
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The trialcs->partition_root_state field is not used during the
> configuration of 'cpuset.cpus' or 'cpuset.cpus.exclusive'. Therefore,
> the assignment of values to this field can be safely removed.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7e1bc1e1bde1..d21c448a35e1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2362,7 +2362,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		 * trialcs->effective_xcpus is used as a temporary cpumask
>   		 * for checking validity of the partition root.
>   		 */
> -		trialcs->partition_root_state = PRS_MEMBER;
>   		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
>   			compute_effective_exclusive_cpumask(trialcs, NULL, cs);
>   	}
> @@ -2496,7 +2495,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		return 0;
>   
>   	if (*buf) {
> -		trialcs->partition_root_state = PRS_MEMBER;
>   		/*
>   		 * Reject the change if there is exclusive CPUs conflict with
>   		 * the siblings.
Reviewed-by: Waiman Long <longman@redhat.com>


