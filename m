Return-Path: <cgroups+bounces-6073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D2A06591
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE571889486
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254F20127F;
	Wed,  8 Jan 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkjvaZPl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04022611
	for <cgroups@vger.kernel.org>; Wed,  8 Jan 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365827; cv=none; b=oGWEfs7XVOiFeMdF29ZRLgFO91ZZ8TbzpsGjumIR7dfNIQjMD+7DP1qCfRZdSt/7WhshLSqWbO4NhQhUE9fRsog8U+leWCxIv/4w/10wV/LuVGnkpnfBvdM9zZ7Aj4DQnHNSSPdO/WUMJ3J5wpIDO9vRdrLHUOrhVYksaZ0Ipps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365827; c=relaxed/simple;
	bh=ynb8Dba1VuIVNQtCjarPDOwrVU2kRUZGRBmcUlA+eIc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gY1o9z7msEqx+CKor8bKJTM2lZPaXwoirUU6BV7XB7+udHIsjX2nl14toRlEFTLJnSry9gC743oA2XC6CjluwgcoSfdi5TlHTLWE14dnoC+cscy/pvjyY6FH5he9lX91y2DOnW+WffJ0Y6StWilfVVZQdvSaYWzbh9yfDliGOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkjvaZPl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736365824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVyNkvJBDY0tt3wrjEJTz3HCaKjkfL4l8QAfzujgTDc=;
	b=DkjvaZPlFhelz6FKT3im1RdwyXVTh211UF3q7DV8K/QXk4gRu9Y1g52PJ6ggrOkUwHWitl
	6xilFnPP9te+T6LPtdImujhDOJUajphcRGp3OV3Qzp36pQULYwxjQCyjh4JgnpDEoquCA1
	FQFpgBLu588FjJSZgoruVJD/ZX2Kfa0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-E815zvdEM1C_coSHpgKIEQ-1; Wed, 08 Jan 2025 14:50:23 -0500
X-MC-Unique: E815zvdEM1C_coSHpgKIEQ-1
X-Mimecast-MFC-AGG-ID: E815zvdEM1C_coSHpgKIEQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f8b9d43aso4555266d6.0
        for <cgroups@vger.kernel.org>; Wed, 08 Jan 2025 11:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736365822; x=1736970622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVyNkvJBDY0tt3wrjEJTz3HCaKjkfL4l8QAfzujgTDc=;
        b=dz6ImkBVc/1/eKZJ584xZdlDNAeYI99+sdGsud7AztXy3/WpSuU4AiYQcNjQmLuF9S
         K+Jo7iFJmLmVgRuLqBr1K27cE7rbG+OSBCDaDFAktDxpD80Tw6gXBYw8+9G5NJeGzb9z
         VVzEhBFHguH9IgKvGf9F5hMFieQ9x2AajDy4f5zjDZPXaX/xoJe/yn4Kd/+IRt0hcGeL
         q7Y8w7KKeIHw0ZEr3CfJu0NoIWTqFkotLPgAjJikJGBC8/Pz2zC5z1BpDT89I2OF14So
         TjlEVsrUpJfrYwK3CvSsx7FYr6MhHja3E4EixQZ72Hn9gI26TKWr9KmJseQvXNnsquhD
         LK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCViDTMjcPBZYWb6Hipss7q3wIuiw8/N1cp6jIVo3iVraY72vIRqQCnk13vLmk4WxssUUch4RHZY@vger.kernel.org
X-Gm-Message-State: AOJu0YzNU5pMP0TocE+vkexCbxO/pdL5/3K+3LCdl5tlRciQ6TyVc2wM
	GnNZugp9ulvZyWtuPGHvN6uBCHfYhtg9hAZqtlkyYagHluWcnj24eWR4fojopQ0nLn5CMCqrjIT
	YSS6y34lmizD9EqTt8g3U2VjA51KhrVDafpkSeCExWj8dWd7jCRJtmoA=
X-Gm-Gg: ASbGncsoHgQdhtNyJ6lYJIJEOe3/V3g9mjmSCJVq59coU+QH5mYEvmQYHEFooGxf6z7
	1MNSw+/ZP3hYHgp7mEzf+ngHvA4M4PAtwZMea3RCE1VjBmkx+9Jgys2YU63CcfcOCEdN0Lp7h1u
	D6QkNhoOgPmMtbOp0ZNVsxYLi5QRXV8agrNTIR+fVe1CqcUoBDUYQJ4R4LMEUNz2pqildXpNmHk
	YKEzV4Vz0U+oZwQ/IYTbwjmfEA26mB9k4ALja2BVOhfyvxBbpQ4XChlHHvNjcisNvuK7sX4uz+L
	7tknjNG58tqXMp14S44fZ/SK
X-Received: by 2002:a05:6214:daf:b0:6df:9771:978e with SMTP id 6a1803df08f44-6df9b2ff13amr6376256d6.34.1736365822389;
        Wed, 08 Jan 2025 11:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFroD2c+9NE24B9CpwxkOqr8P3LcnYS+/6xhSIcmWUvXDjUGsDUGCwc/mbKU3TFrY15bBfeDg==
X-Received: by 2002:a05:6214:daf:b0:6df:9771:978e with SMTP id 6a1803df08f44-6df9b2ff13amr6375776d6.34.1736365821945;
        Wed, 08 Jan 2025 11:50:21 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea715sm193598676d6.11.2025.01.08.11.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 11:50:21 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <625d03cd-302f-41b1-9502-dfd25eb677e1@redhat.com>
Date: Wed, 8 Jan 2025 14:50:19 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
To: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z36th2ni0q32gsUE@slm.duckdns.org>
 <c40d5b49-1955-42ee-b95c-37ed580e9933@redhat.com>
 <Z37TiId4rFkwc0Mc@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z37TiId4rFkwc0Mc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/8/25 2:35 PM, Tejun Heo wrote:
> Hello,
>
> On Wed, Jan 08, 2025 at 02:27:07PM -0500, Waiman Long wrote:
>> On 1/8/25 11:53 AM, Tejun Heo wrote:
>> This patch looks good me. However, this does raise a question that I
>> overlook when I made hotplug operation synchronous while task transfer, if
>> needed, remained asynchronous. There is a very slight chance where we keep
>> removing tasks added after execution capability is restored. As cgroup v1 is
>> in the process of being deprecated, do you think we still need to do
>> something to address this issue?
> I *think* that should be fine. In cgroup1, the kernel is making irreversible
> system config changes when a cgroup loses all its CPUs. I have a hard time
> imagining use cases that would depend on the the exact ordering of
> operations at that point. The auto transfer-out was always the last ditch
> measure to not leave the system in a broken state after all. If someone's
> depending on the transfer out being strictly ordered w.r.t. the cgroup
> losing all CPUs and then gaining some, let's hear why the hell that ordering
> matters first.

Thanks for the explanation.

It is not the strict ordering that I am worrying about. It is all about 
the possibility of hitting some race conditions.

I am thinking of a scenario where a cpuset loses all its CPUs in 
hotunplug and then restored by adding other CPUs. There is chance that 
the css will be operated on concurrently by the auto-transfer task and 
another task moving new task to the css. I am not sure if that will be a 
problem or not. Anyway, it is very rare that we will be in such a situation.

Thanks,
Longman


