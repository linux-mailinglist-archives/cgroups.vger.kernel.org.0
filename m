Return-Path: <cgroups+bounces-6573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB4A3907D
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 02:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96137188241D
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 01:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CC19D89D;
	Tue, 18 Feb 2025 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUWJSO1q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68816C850
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842640; cv=none; b=sM1ZNB/gFnWW31IFkDEfyypGIWR5Yzm/CE4EDdaXKL+p4eoO7y7InonIqfT0m7hWoTtJyW90HzOAmwPL9lsxrn2WXRdnUNba2nq5VheETMdCwYuV6/6j8dwvHVBuCzrcHDF+vgWrrJrolMSJuc/49YftTHZLXS/SvKbTV9XdbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842640; c=relaxed/simple;
	bh=cuLdQSQWAtQu7++K1x0gvp6P1Ra67Ctg9F+vEcRx6/o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kgeohnf3lOzmtEUJSSdoD4R0Mv8W5v5FdpOx2AjIG+VOYpN9GYyy2YrnL9kfTXId3N1QxgpSk9YriKZzOx0G8IMyrMVZ+9OE+3PvwflyIMyqM2xhng4ex1tBWygVf7IN05p2UewFasDA/d7DwrM76KgBGRg/y7bYxvx+v6rtlLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUWJSO1q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739842636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijVuTFzUHZtPo8upH9znQQc2eOXG2svBHZDJ4RmQxR8=;
	b=AUWJSO1qn+wfI0fXdSi/mFblV3M90gyBGne9TZffeRDuiW/i0yARjkAWQst2Xxign2Xep6
	1PQ28Z0BUO7TUyQ7QAecfW1HjGnMuFRpdFlIMIVie01Zn0fEHSo8kzIC6a7V5O09QOt23Y
	XM6S4RMKJSo+0kt5LMbFxl8y/0BeyRY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-J_S8wnJZOWe8m8jiQ3i1Qw-1; Mon, 17 Feb 2025 20:37:14 -0500
X-MC-Unique: J_S8wnJZOWe8m8jiQ3i1Qw-1
X-Mimecast-MFC-AGG-ID: J_S8wnJZOWe8m8jiQ3i1Qw_1739842634
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e65f2d9495so88705836d6.1
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 17:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842633; x=1740447433;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijVuTFzUHZtPo8upH9znQQc2eOXG2svBHZDJ4RmQxR8=;
        b=n4V4ju704kCqEcxUC2hb+fwkX2taUCh8Ybb12tHpABV5sFnx57qn3+R/TP8HPQW/ss
         AmeCARK6RHmH99tIc4R5+Mr0nw02Nn4IE1InxeWbQ8jx8Jfdxm2eyg3DUW5x9P9lReNw
         r0lOhX2I+LHeP9gMmjLLAh8Pt1vhWxulKS0B+kIZ8ZhKp1gq0ejTvEuFDHxmJnMWFno/
         qn30eK3lhYEJk0NWmRCePt7zQtuOu5gzrosFsvRT2xyAPl40KDVVqKp1nONVHSlJ517S
         WXFsVZmr5+Tv9hfUvPxkFI52Ga8gHOOWB8ZWLKkGMW3AQvHLXd83ICbRba6I3uIM7xQ6
         iKUg==
X-Forwarded-Encrypted: i=1; AJvYcCVCMYUyIpGI1kWuHjwmfil1KYwLq1H1puQYeTy1Oy4FrczPpmyVE0N3w13pfRdqk6+zpD27+p7z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64UoY7aBsJiAf9VhtM3fzSFakcfE8zsQ0iiEFB0txWCP2Gwn3
	w1tl2MgLsX4WSnWuMWOKjCmdvCogwblSdbXkSdo2LcLeiKlAVRN6ndbWUpBXE/4YW5fvYM0JPIF
	U1h9qxKcVMPtRfUf247m0yFuPaKYnASdq3jgtIIZ7AlKu2a93BXa1+cXWrXO70iHc0Q==
X-Gm-Gg: ASbGncvrx8d3TeSr+GAZ1PoTnyikznmE8kh3Wnvn4YQ0xJf1OucLyPgd2c0K8lm5twq
	dqPhhMjfyfGMiCaTSf1oDdrPTVkcl2i/sL15b5bzPqSCCV6hO8qpFCZwHCWzmErMHqlcPoV5nRC
	DzbSWJSAy/jLM4rp5BnuJzdCGm18fPdX8r7B0MvYQnn2ogsNkjjWVN+QIdsSUcL7MjnfKk69RHh
	r2CsfOlXPCggv/SXbh+iKa8rpRHsKNiT5WamW13laOITDTIZNYZ01k5BxqgXJbDIxpIfL4W4otk
	oVJm+VMZqIfgLilopsXvTbxocus0vRIwoSOZWNKM8P9uTfbs
X-Received: by 2002:a05:6214:2528:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e66d03b637mr170356176d6.16.1739842633754;
        Mon, 17 Feb 2025 17:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQD+nSBreG53VzxCnaRY9OZ4efdvjEVi6Cd4CZq5zxNmijO5yE9fKnoP7E0mrC9FHHPBKetg==
X-Received: by 2002:a05:6214:2528:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e66d03b637mr170355956d6.16.1739842633421;
        Mon, 17 Feb 2025 17:37:13 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784893sm58781506d6.26.2025.02.17.17.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 17:37:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bc7241fb-2349-48aa-8d77-dca76490673a@redhat.com>
Date: Mon, 17 Feb 2025 20:37:12 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v4] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
To: Jin Guojie <guojie.jin@gmail.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250218010316.1950017-1-guojie.jin@gmail.com>
Content-Language: en-US
In-Reply-To: <20250218010316.1950017-1-guojie.jin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/17/25 8:03 PM, Jin Guojie wrote:
> When running LTP's cpuset_memory_pressure program, an error can be
> reproduced by the following steps:
>
> (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
> then set cpuset_memory_pressure to 1
> (2) In this cgroup, create a process to allocate a large amount of
> memory and generate pressure counts
> (3) Set cpuset_memory_pressure to 0
> (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
> kernel returns a value of 1, so LTP determines it as FAIL
>
> This patch modifies fmeter_getrate() to determine whether to return 0
> based on cpuset_memory_pressure_enabled.
>
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Acked-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f..14564e91e2b3 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
>   	fmeter_update(fmp);
>   	val = fmp->val;
>   	spin_unlock(&fmp->lock);
> -	return val;
> +	return cpuset_memory_pressure_enabled ? val : 0;
>   }
>   
>   /*
Acked-by: Waiman Long <longman@redhat.com>


