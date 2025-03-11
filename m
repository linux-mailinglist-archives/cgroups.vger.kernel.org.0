Return-Path: <cgroups+bounces-6981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C57A5C530
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65FE189884B
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9325E828;
	Tue, 11 Mar 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5zYq44x"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFA249F9
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705764; cv=none; b=hIHSmQ487BFFxcipRzOraHBoxOVx61G2YZrzhU1+SzBO29G0A6QP8v3SAfbc3BWBb8J4SsT9HoU4hgZQxswMHlCfaSryBgJNuJg88P1QFLMbbSPSgYtVtOjgjkHomIR3f+y2kAo9r48ukv3pYG6EMFsIlTsRjUQIZahpIJJf6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705764; c=relaxed/simple;
	bh=vb9WVjdXujyqG9HdkP9fDFqYDOXfh1MwdGvNDloJU5k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c+VvZzmwBfEuzkYD2Kv94wscsSijh2tehlWSJ1h38oDE3UMnjCu5mPnnqatx7A5Ju/TihJzX4MKsPXgKwodNzv9zAQaKoeXxbm2Fn++hre1EAzogw1ky8KhtooG6Fb0/LAYHp17U5MKNvO+Ix68TAkCmmRrp1uXtFYb3NQz6a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5zYq44x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jm5p6f/MWK5U7DpW+NpwXR9aqI/JKbBrooREb2Q78R8=;
	b=P5zYq44xbxy2cVT2aVemQ9QqXgIUuNU/gM6CV1+uoZLkOzU1atJMX27aOCWVkwYVJd0zKw
	gNHWfD3hVe7i0TFFdZVKjLxtOB1OS9xpUkJDb54RFxCBhbvby2wU8OhTDqmu7HSKPK6LuA
	mbGnF7d4B49q05ORECEMB5t5N2Pa3pQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-JKikLAi6Os2i6euP1Vc1CA-1; Tue, 11 Mar 2025 11:09:20 -0400
X-MC-Unique: JKikLAi6Os2i6euP1Vc1CA-1
X-Mimecast-MFC-AGG-ID: JKikLAi6Os2i6euP1Vc1CA_1741705759
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0b7ee195bso1124713885a.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 08:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705759; x=1742310559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm5p6f/MWK5U7DpW+NpwXR9aqI/JKbBrooREb2Q78R8=;
        b=I4vGJ8ffmVjiDoaA35RFbo0U5cTjGvbaPT6IuZe27myRUVb3ZyDsj+I93/WbwCJFuC
         yg+wO8a9xHom7SnBXgVDurLJhp5xySx40hbHijaxLbLdbI2tLHUnCxvHi/+6WI8jbDlk
         GTAv2i5khF3fEa2S9uCCBpGQG18hgAn6HOcfTDfcMtLvyRod4zUyGXiOb7aNunQ3i7tB
         9RRzCwjpqsUtcK/dYBL4e03ATdFNJRaMGBf/Ufk7OJ7I8Ebfj9R4h18lyoo0HgbYPcbF
         ewonMdlzw3oBmsw3FER9EJdq5Xi8kkkUSjtdaE/eicc9wc9u+IYfeIxzyJBP9ggum2YO
         E4HA==
X-Forwarded-Encrypted: i=1; AJvYcCUTeIS0XTEKu8Bz5UKS2+m9AgeUeUKPsVkBOY6iJ6eDfXe1kyxSux44WxYv8uTcSawQpKlcprjW@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxfJTpT101r+NvcrFHFJAcfoeLGA+g3jC2kMQZZmRzGdTFqO7
	hELwc+JdzH/+K0k/AO8iQ8u7Q2jbQZV4HwbnRDtl9BuEmnCO6L2HsYffknjhBcM92J8KvB6xC55
	XA8CKk2R1BLJY/9rfPrTow8rxZM+mnAUwWjvV5dTskFVLVavo7qyWk1I=
X-Gm-Gg: ASbGncuR8wPisVWcrzfbGXn0GXWiyx4jOG9bceFCcvd7z3EAuV8XtD1SUwOiWVVM15e
	1MtI94T1jXazzqHSHyaSNz/K4qSDNPLNqF/xAVzszQVPZi1E6Bc2HzRNbDtSm7liRfC3OF/YPRW
	1My3XIJjsvnld+plRss43xEBhXD52y4jevvEHS78lrQmomnZGjL4bJmOFbvY9vUj2HDAcvSbbSx
	2pixeRAYQD6q+iSs2dPLIEpciiGL88ssp1nbkVK9YZOHg+LD4uNqUYr3aZAC1YwmguZvqJF3zKf
	+OIcEN+JEvw7I8S6jRe8ebAUszyJg+w0IQwZGR17OOSw5ZdGqxYQwVkrLUqdeA==
X-Received: by 2002:a05:620a:2856:b0:7c5:65fb:fe0e with SMTP id af79cd13be357-7c565fbfffcmr271088985a.6.1741705759558;
        Tue, 11 Mar 2025 08:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgw7eoIv2Vhl38GQs/MzX9nIqjX6y3ka9V536jOtKWJtrjsXcbVnJyTgSX7O+tWt6UW0RICQ==
X-Received: by 2002:a05:620a:2856:b0:7c5:65fb:fe0e with SMTP id af79cd13be357-7c565fbfffcmr271085485a.6.1741705759324;
        Tue, 11 Mar 2025 08:09:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c553a1e421sm349610085a.116.2025.03.11.08.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:09:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4570dbe-77de-40e2-8fce-b672e014ac57@redhat.com>
Date: Tue, 11 Mar 2025 11:09:18 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] cgroup/cpuset-v1: Add deprecation messages to
 memory_migrate
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-7-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-7-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> Memory migration (between cgroups) was given up in v2 due to performance
> reasons of its implementation. Migration between NUMA nodes within one
> memcg may still make sense to modify affinity at runtime though.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index b243bdd952d78..7c37fabcf0ba8 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>   		break;
>   	case FILE_MEMORY_MIGRATE:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>   		break;
>   	case FILE_MEMORY_PRESSURE_ENABLED:
Acked-by: Waiman Long <longman@redhat.com>


