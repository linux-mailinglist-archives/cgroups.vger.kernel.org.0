Return-Path: <cgroups+bounces-6842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB36A5018A
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 15:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1CA1894F2D
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6CA24BBE3;
	Wed,  5 Mar 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmtLfcgN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFE155751
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184053; cv=none; b=VwUavMrTFZYdDpXQB3aiGvECgNLq5ik4bVkHc0DK207kStntzREa7MYyq7FLMMCKY8PFU8eU/b7zfPS61924okbQm3k0HoYCX78EgHn6kmMq/BaGDVdL8aXIgAzgydQxrjV/NiFP3h5mx/5pWRyfRpSjpledajgQVLsYEE4XAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184053; c=relaxed/simple;
	bh=EDOWiuz48EaOHCMVG5zuO1N25iNFE4iKpu3KXcX0EqI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPX1fO6lOyOxuxTajlNZ3zB4+1wSXzVsvmY8jPNUiokRc+8l6REpFqc3lBFLhWJTbGFRDBB8emLQcJWcIOz7eUFSUzdnPeY1OVYCvcWdSdMnRHOwmwutHYbvVMm0SfvzYpiPhUwfntMpWQJOSYHxmrGrcYm8ARqRqVO6Jh0psE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmtLfcgN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741184050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W+VuZVYcnV3HyAvSTpbUUrhFmo350QWrg+wnsTs7g4=;
	b=HmtLfcgNhXZH2CO0E+a1Gt9+JCZ1Ezy75I+msaKSAioyW15Rg5HN7H1RtVe6WDuzU67epU
	jC0iPmMw5Xvv8MSPHguLUrf8lMsjEeEbJlH3Gbzun18qZjM5aVMagirQEX/484Ga3A1rdw
	P8FU2hSfMpZXq+Wre5wgKOdXyw58Cwg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-OGd41DAlOTaL-KhVUQPzjw-1; Wed, 05 Mar 2025 09:13:54 -0500
X-MC-Unique: OGd41DAlOTaL-KhVUQPzjw-1
X-Mimecast-MFC-AGG-ID: OGd41DAlOTaL-KhVUQPzjw_1741184032
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c0ccf1d3so184069585a.0
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 06:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184032; x=1741788832;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W+VuZVYcnV3HyAvSTpbUUrhFmo350QWrg+wnsTs7g4=;
        b=HtIm9C1flmJDm8rAcuPD7zRldnHH8plHm3AQSfh+Wn4Vrdd4IAkJqBtvEpVBshrYoq
         6sxubcra/E0fmzfCY1I7fjknE3gAp0lP0VOVYl0D46nLB7qVdkeEODH9w3rgiwbE9aXW
         8uWl6x+hmvSKnwKAPrtQSKMEeTOwAV7FGD5sw0yyEkyRt6mazO2VWsIdjnT/CEroBZiG
         kZYCOMWqQRoYI5erDrEJYglEqyHD4DKpxp6gv1WyF0OYvYFl3nHcLPZg8+qxFFzv6Wws
         3inPHvrjBwPMhc1chKA1FXJznf0zEqDnwiv9x3ABN3G3u+Q/38pv8HKQTYftCBnAkAGq
         5vgQ==
X-Gm-Message-State: AOJu0YzRcQ9q5J4KtoIFpn7rKhPOjhGsJvQBXhnJVFtWXX4ZLOFxdmvY
	67KXUaIPiyt+q34ikLrKiJTMyhf6b+pmhkSltqUDxuAkgmFtQyuYzv8gKI8J2sxzaSvjj52BrZS
	G+7egHYQuWOvZgJ4CrmkotG58f1Qp2BZsNVKOxFm5ZSNlbcr20rxYJiU=
X-Gm-Gg: ASbGncsFpgaEY0yJNO6fhePje9lS/HdZSCnrr0IVG1ytyc1F/LY1alPrZu5qTY4Vaqb
	EJUlrjGx3uFL11fMfF628tm8EN0qwtbf9pCkl0399VOife0JZYR5/xwSrBl7zsexpYjW9pcIQR/
	9v9ybCjURl2R6uNrzxXFwPAcnPxmV3kLuw6P3jWd70qx2eRc+cvo7yEhXA5w5X+zIA9RLN7dSzy
	vq7aY/QDPS2vym4q85mYttLRCq3IVM9gPMfqcg40eXfqIu+Ud07wCTn/v2PnATxvGl/YZbJpMU+
	5T2kaimqay/qsDrNtvYrkGobagXAkAEa7ygjLIRWObadQ8gwQ7cY2yQyDzk=
X-Received: by 2002:a05:620a:43aa:b0:7c0:a260:ec1b with SMTP id af79cd13be357-7c3d91e8cafmr444389985a.25.1741184032531;
        Wed, 05 Mar 2025 06:13:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9ffpu0YZWhyUhYlZlVs8VrgC/jNuyM8WRbs000jc8OeU6/te1fV87F/+guN7+iQlwfItbJg==
X-Received: by 2002:a05:620a:43aa:b0:7c0:a260:ec1b with SMTP id af79cd13be357-7c3d91e8cafmr444386885a.25.1741184032217;
        Wed, 05 Mar 2025 06:13:52 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bfb2a5e3sm392543585a.41.2025.03.05.06.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:13:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6a6d4c61-a318-444f-b089-1776beb8873d@redhat.com>
Date: Wed, 5 Mar 2025 09:13:50 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
To: shashank.mahadasyam@sony.com, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Content-Language: en-US
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 11:12 PM, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>
> The cgroup v2 cpu controller has a limitation that if
> CONFIG_RT_GROUP_SCHED is enabled, the cpu controller can be enabled only
> if all the realtime processes are in the root cgroup. The other
> controllers have no such restriction. They can be used for the resource
> control of realtime processes irrespective of whether
> CONFIG_RT_GROUP_SCHED is enabled or not.
>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index cb1b4e759b7e267c24d7f4f69564c16fb29c4d89..f293a13b42ed69e7c6bf5e974cb86e228411af4e 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1076,15 +1076,20 @@ cpufreq governor about the minimum desired frequency which should always be
>   provided by a CPU, as well as the maximum desired frequency, which should not
>   be exceeded by a CPU.
>   
> -WARNING: cgroup2 doesn't yet support control of realtime processes. For
> -a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group
> -scheduling of realtime processes, the cpu controller can only be enabled
> -when all RT processes are in the root cgroup.  This limitation does
> -not apply if CONFIG_RT_GROUP_SCHED is disabled.  Be aware that system
> -management software may already have placed RT processes into nonroot
> -cgroups during the system boot process, and these processes may need
> -to be moved to the root cgroup before the cpu controller can be enabled
> -with a CONFIG_RT_GROUP_SCHED enabled kernel.
> +WARNING: cgroup2 cpu controller doesn't yet fully support the control of
> +realtime processes. For a kernel built with the CONFIG_RT_GROUP_SCHED option
> +enabled for group scheduling of realtime processes, the cpu controller can only
> +be enabled when all RT processes are in the root cgroup. Be aware that system
> +management software may already have placed RT processes into non-root cgroups
> +during the system boot process, and these processes may need to be moved to the
> +root cgroup before the cpu controller can be enabled with a
> +CONFIG_RT_GROUP_SCHED enabled kernel.
> +
> +With CONFIG_RT_GROUP_SCHED disabled, this limitation does not apply and some of
> +the interface files either affect realtime processes or account for them. See
> +the following section for details. Only the cpu controller is affected by
> +CONFIG_RT_GROUP_SCHED. Other controllers can be used for the resource control of
> +realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
>   
>   
>   CPU Interface Files

LGTM

Acked-by: Waiman Long <longman@redhat.com>


