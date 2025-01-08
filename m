Return-Path: <cgroups+bounces-6071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A49A0654F
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFB73A6E76
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695D2010E1;
	Wed,  8 Jan 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtN25z7f"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E11F03C3
	for <cgroups@vger.kernel.org>; Wed,  8 Jan 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364433; cv=none; b=BomASyXQj6cneE+IcDt/h4D/NC7Vfnl8nLkI7mys6gfQJd+zt8G8efpqruImUw7PTD0pD/u9XRAKZM31b3nUVbtlOarII+4DlfvdptfghOsk8ZPrm+1RzL5BmI/q//07q6ln17RHgejHvcPGZECAecxlx6Ud4ypSq0W/9ApU17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364433; c=relaxed/simple;
	bh=pw/FsvYE+CnTiDBgvymlSNWc4Q+Zlu4oGKwvOxe+o0c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H+rQSr0HwVMiZ9mttI1C+cNy1ZpVmRzUHYYGkq5Cv3JPTUZnwlnsF357WY8jLicZ3EAN13HjNh/QVzmYOUSA52LRLxCFI141xS3szTpN6kQGQT8KpGx38usq/c+EmGscc3Q0IjBawOn1WL5KJyxS4iEeyvY42k9437IuE5Y+1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtN25z7f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736364431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gP3aIu1+OB4c7o2rwAtjitLd1P5sRrPYbvM9yHWN2VY=;
	b=KtN25z7ft1++WVnseLCioBkc6EaRveL2IWRKr6I1IZuUVD61inJ/I83QAwJsUx/Ey+36LC
	TSd8m5y3NTxVigFWB8pP3TKvTpQXvQdkJ1rfmTsR3PCFzU08U1RfZA2dIWUkKXE7iyaka6
	SePeBkV0+qobV2PkGjJjdHZGL9nBtEc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-H39HXUJONb2doUUIpi88LQ-1; Wed, 08 Jan 2025 14:27:09 -0500
X-MC-Unique: H39HXUJONb2doUUIpi88LQ-1
X-Mimecast-MFC-AGG-ID: H39HXUJONb2doUUIpi88LQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8edb40083so21521656d6.0
        for <cgroups@vger.kernel.org>; Wed, 08 Jan 2025 11:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364429; x=1736969229;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gP3aIu1+OB4c7o2rwAtjitLd1P5sRrPYbvM9yHWN2VY=;
        b=YAJwDg59PCkuiXL5Y1PN8cd8VmAbMWF6/eMn5JTAJpfSOipkOt0JmEmzEIJOQrwOBg
         QkeDclmBQVMf8br9UwW1Car7iiEDNGoCMUFP3dWeU7ouHwfWGa4bXGNXvatplKU01uTk
         COvCHUT3USXs1fix/2j4AS3m2ImthD5z22wIQEaPP7qpWRlvTSiWX69ouD3sVyAd8Idy
         uL5FFrEKAqZr+AT8T/FSF1HCVSNLd64qr0BDUuvIiQtqwoZvyOpGHTOsGZUmiEDxEakv
         x34PhXaRqQfcnYmVev9hpmQnJIaegqGhFWtmcdQCa97+QLynVxqXGwB64xI/i8AljvFB
         Cm3A==
X-Forwarded-Encrypted: i=1; AJvYcCWmzjhi70+4YtMZzV6gOnHXKxNTpJDEBlEpwO7BS5tX/KOpFZF56VyDZj/KO68oiVje2dSlNcjX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9N7DiId5hDWgFfowHn0X+m7FPI965jeYJUu3vCY+1YMwJJ8XX
	NPA5yde2bKHVHXH/UT6AetPtcjPEuEkmMLX1o/JhT8bOGu4EzhhifwFlWqk+BXrdRhTCu8EQJCk
	lEZOwrLOKDrLLZBoKUu1VQ+bIoBTCPBc4HPEU3niojiDRtVjf1bttOZE=
X-Gm-Gg: ASbGncvPckWMOSyhBqWDMsf/RUa2rwgtQX1sjiX6N1wVwSJPtV1DI50Rj8wf1NmWGQk
	jd+K8sywODGSt02mY3bwfgOIVNNX1b/aAODSBZ8QOvVyQprad4y/1/+nFYlYgTCL9tsjLhJjtUI
	1cktcmm8lD+HYQfvU1U42EhQLPtDNkFZnCxZ5IFNw8kCOeal+7ELNQvGgvXvGPfpx0L8rvbqN2a
	H0L28UrMw3IJb4uO66JaQsC+tBu7JYkFxRosStS9xbPQ+xqsr/i/MsR1/Gv8bXoddETMuKf9XAX
	qXl4CqJWtEPIYSKt6KU/eXep
X-Received: by 2002:ad4:5c49:0:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6dfa3a44bb2mr7841376d6.1.1736364429279;
        Wed, 08 Jan 2025 11:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsdEUM/Ng0/IdiFwFJ2tD5qvpbj9umQ3m+xwFAGWmJp3c4NTcSTr78qkCRq6vExpQlKdy+3g==
X-Received: by 2002:ad4:5c49:0:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6dfa3a44bb2mr7841116d6.1.1736364428965;
        Wed, 08 Jan 2025 11:27:08 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea73esm192292546d6.18.2025.01.08.11.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 11:27:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c40d5b49-1955-42ee-b95c-37ed580e9933@redhat.com>
Date: Wed, 8 Jan 2025 14:27:07 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
To: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z36th2ni0q32gsUE@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z36th2ni0q32gsUE@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 11:53 AM, Tejun Heo wrote:
> Waiman, what do you think?
>
This patch looks good me. However, this does raise a question that I 
overlook when I made hotplug operation synchronous while task transfer, 
if needed, remained asynchronous. There is a very slight chance where we 
keep removing tasks added after execution capability is restored. As 
cgroup v1 is in the process of being deprecated, do you think we still 
need to do something to address this issue?

Cheers,
Longman



