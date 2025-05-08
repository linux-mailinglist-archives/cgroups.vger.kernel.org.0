Return-Path: <cgroups+bounces-8099-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197EAB03BE
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EDB3AE9F4
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168BF28A713;
	Thu,  8 May 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEtfDoTs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FF21D581
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732984; cv=none; b=frbFVKnUUCZI6wHrM1Ql2van1g2Wn9/UkQXsL4/6zD1ix6gDFP990bPCwkb9nd/1awY3tTfIwPxxWIIEIXMgD3wldqp/77UHj7lQ7xLpo/Kld6Pkcnelt6MhowLvmn9zY0M45gFA1oFUjnS/ixFGDVSgrroQiyHJzQyf2dnl+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732984; c=relaxed/simple;
	bh=sskzmfRBKrtyrvaDO+90bHXI7VeTet/0CWNnw2B6jzM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=S+4Gjl2lUw1Tr192JInVyWZRlzEw/hB2zdMa2uW07yMXs4xPjMVXGs+5P3z4lWI8MWIDZXemevc4cXX0uBL3AtdVOmmzZ8NXWIyrGsrfia5rtGS5qIQt1B/dcTKMvZG8Alu53lMrbCQNfz9Qk+6OfI5BT4Z2HIFJC583ZM6gUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEtfDoTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746732982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMSK5ZAn41rIA+tVFhgcK/VSjG2CjNRjiAb9AYqMURE=;
	b=NEtfDoTsR+iSJUfunLxxRzIKu58B/IX3W/KH5VfWm4KOIswWCMVZoHexU0v4reEhBTlRze
	WAnFXS4KW9PePLvg4sJmGF/ifVmyU2WMrBAYAN5JvCHynM2xcvoLuqBK8DsNiGXwdYOgYO
	dd5ciqSg0pTS7BUEAQ3idIU/32m5IcU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-7FFW5mW_Oj6u5M-dvgeLAA-1; Thu, 08 May 2025 15:36:20 -0400
X-MC-Unique: 7FFW5mW_Oj6u5M-dvgeLAA-1
X-Mimecast-MFC-AGG-ID: 7FFW5mW_Oj6u5M-dvgeLAA_1746732980
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f53d9cf004so24385886d6.2
        for <cgroups@vger.kernel.org>; Thu, 08 May 2025 12:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746732980; x=1747337780;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMSK5ZAn41rIA+tVFhgcK/VSjG2CjNRjiAb9AYqMURE=;
        b=rT2fjrlyqiEmqXJ5MAScSubLxxhZL6ZTSLw2QNyrHhdGhGeHQC+5QUvYvoavYBP27i
         Kdw786bgJIkWFM4JypRr6AuWQ/NJSkwQtLd0IBaBixHz0Hf8dgT949uNYx71mrg5lF0Y
         52vFfK+fO3S6sBML0Fllle4Y0snIw/SZNgaTY5LU9EDydfVyjngsTe5qPhosl/hVLGtU
         +ff0zDwtJDHBAClonxQtCgvBrmX4O+QkCmgZuHQO07e2AOikieEQB3mj80WyJK6LbgOL
         t8/vKyO910wJaNXBVJKLBQPwqD7LSiRDsaYd1VXAMGNCPsSKw0dc/uUWTFBdPDfPTg77
         61Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWCxTmgpdEf7GubPk17Mq2BVJaY9IawSxa/bgOgjZtZ4wxtMCURHMEBwHwU7JBm2ZGc+Jex5c5E@vger.kernel.org
X-Gm-Message-State: AOJu0YwWafZrzW/2hpQF/ltL8nlHDZqAI5E1jPTdbgfk6YrRihP9Hy5L
	GmrgeYWYjmHVs3lL+HE8PLJYlDW6zFigQPune60wJ7OZ9H8ZtoN3KYIlyRwUEWnMcjGyRvXN65B
	QAvCqH5W3wrFX8IGQbaVkHoZFJjCSbjus36IORGqWTQJOOWJRp17KVAw=
X-Gm-Gg: ASbGnct8I+wAuaHbGbaxnxANXKVoSfRbhnOK1TRqkkFcv22voEnwFXP50HxPOISqPD5
	Ss17MR3qoZZuJWwkP6n1b8VcyFvOVFV+smMlsPgLbE09YpAUKZA2nxVRCE60Ep5M7fft2/rHlAq
	0eXTTNryfSvKDA+gmuEYh+lkS7YZPVVAWp2g0Mh3Uew0eqW9V6oC2nDThtYftyfsb8fsn/6KNuY
	goZQcP0RKfiCU5Al1ZMhXnurgcq8o0qcEh2lci02gdSiL8+vf0Ni+HyZ+/wOJPaGxGj+q9LK0pg
	Km98+oioGFHDsc3cechd2CZ7oas+KF5lnIvNEhW+6z0e2TiBovgoskPgCA==
X-Received: by 2002:ad4:5dcf:0:b0:6e8:f4a1:68a4 with SMTP id 6a1803df08f44-6f6e480e30bmr7967996d6.39.1746732980491;
        Thu, 08 May 2025 12:36:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Sy72JbcvF90NKSywmPl3GyTkaZYXxFFXeLkdg2Kj45kGhvABU/5pAtNzbQo2gxKgW2G90A==
X-Received: by 2002:ad4:5dcf:0:b0:6e8:f4a1:68a4 with SMTP id 6a1803df08f44-6f6e480e30bmr7967546d6.39.1746732979922;
        Thu, 08 May 2025 12:36:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:9c40:1f42:eb97:44d3:6e9a? ([2601:188:c102:9c40:1f42:eb97:44d3:6e9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a538f8sm3316976d6.114.2025.05.08.12.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 12:36:19 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1b558608-6496-4078-afde-5f0e10086781@redhat.com>
Date: Thu, 8 May 2025 15:36:18 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: drop useless cpumask_empty() in
 compute_effective_exclusive_cpumask()
To: Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508193207.388041-1-yury.norov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250508193207.388041-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 3:32 PM, Yury Norov wrote:
> Empty cpumasks can't intersect with any others. Therefore, testing for
> non-emptyness is useless.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   kernel/cgroup/cpuset.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 306b60430091..df308072f268 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1388,14 +1388,12 @@ static int compute_effective_exclusive_cpumask(struct cpuset *cs,
>   		if (sibling == cs)
>   			continue;
>   
> -		if (!cpumask_empty(sibling->exclusive_cpus) &&
> -		    cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
> +		if (cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
>   			cpumask_andnot(xcpus, xcpus, sibling->exclusive_cpus);
>   			retval++;
>   			continue;
>   		}
> -		if (!cpumask_empty(sibling->effective_xcpus) &&
> -		    cpumask_intersects(xcpus, sibling->effective_xcpus)) {
> +		if (cpumask_intersects(xcpus, sibling->effective_xcpus)) {
>   			cpumask_andnot(xcpus, xcpus, sibling->effective_xcpus);
>   			retval++;
>   		}

You are right. Non-emptiness check is useless.

Reviewed-by: Waiman Long <longman@redhat.com>


