Return-Path: <cgroups+bounces-7683-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32569A95607
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 20:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B3A17147D
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D831E5B9C;
	Mon, 21 Apr 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC2O3Lym"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD71E2312
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260800; cv=none; b=iuw2kbRcVtmb7sE+SnTG1Wz884DyTLxzTeWgXt8AVWjHAlsPIHL/gTORnLSzwAhQsffP1Q8JaYmUGklcQ9APKW+CXy0/DeLzUwx4ka2wZc8qPXkIGeRNxazyyXx1F+kLMmQM8T1QPdr32fwD2gXk8FsTRlx29U3NcxgGEea45gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260800; c=relaxed/simple;
	bh=WGcrnuIH0Mcj19ES9Jw/QYzq7GYrsh67QQi8n9D7diU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukfliU0DQ+tAdwjNwbgTPc8oHd385VwQCGMQd9VEZhL9lIp5vIfFfHb8kzysLlqaYoVGsye4X5y0o4Y9rezJ2NcfSQ8IwacoMGjAhs834ABlor8dTc8fhnRzrJVKAmtDNPOia0o98z0B8OX45XXNU7GXBS2mM+lCCt6iOkGf/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC2O3Lym; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2241053582dso60245065ad.1
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745260798; x=1745865598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAIZxQy/P+3Nu1Z7kf1woofN4LtVgfCv1xgdmj9WMHU=;
        b=NC2O3Lymhsd7Al6AStPyOcFrKNYfifplszxf1NtVQhEvPuVJcr1Y3gO57S8U9hOBMk
         W9SLkVJw0DUDNrFw3wvacGtOgyagcmohxpJoKU84I2n3EqYucETjQb3Im6IRPPZieC8j
         fLoUXhouOBGbGtCcPHcNaUZZWT15+6uH3mTCgXqfNM0Ctd8C17cuODgSgpyH0eXRBz8E
         mC6iyhaGrOaySQrRow8SvOwyEhMLmoFR4YjyQgzjBTRow5kDEEgnDiv2rqr1r1HXS1IP
         L0xu8su/+4Io0DuGQTYU148BMpIsaCCj0L4KmZJUEHgwo1MDWnHq0kUubQqmnepyMk2P
         +Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745260798; x=1745865598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAIZxQy/P+3Nu1Z7kf1woofN4LtVgfCv1xgdmj9WMHU=;
        b=wYuCL/C26jw1y5Zcvh98uooGbJdNlKaWFkM+wsSf7/yYe1skWj348q8dNm8BD7cNI4
         +ETa032wSFOnoWo8hkWlsiv8masN4gQCYTD/i2HK67NHFyX92U/Y1w6tGm1zaqmXKM7e
         D/C/SmPAgLxbBHlwvlUyfHolMQC7Bg27OedYgHDsZH9KkdfXg3zJ7Qb2Ay2fWAt/YlUg
         o1OdxserQBjXinFHvuiynpoXKQvIdSoeZSbXoE5obMXVbVvikyQfhoW8I2vPPxbEWqWu
         zOCx8xc8x+ZvRtU8+ajvjnCVMahPeqJpQHc7lG/TFoJ//luh0CEwCf4lfd2oNQcWyuln
         5HAw==
X-Forwarded-Encrypted: i=1; AJvYcCVAeen9m4HUOt5xw2zab4iFytmbl0DKHcanfxEwR7sznhABmddIwksyQknUzle8YR448Mu6025F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AIIQ1TZnBHnBp9F9Q7uObUwD7urZIzaYC9DbWRjlJK3P9k1d
	92wtoYVat9uMQkhP6nUOV6tnqbg3ZcRX3ZEue4wffFc9/aI2oXsy
X-Gm-Gg: ASbGncuOHp+HlZX4M82SgQeLoY809fL7Mi28mYFjzH1cVcuN+7aqPYzdkK4TYMidax1
	0Wb38//UH7y52+jbEemqDWq4Bs1g7fGJY2p1GdYoTnQ9HxPcxonDhInpMpvsI0d5ouWslk8e6Xy
	Na7YS3UaYXUKWIo2OAFekpIpdt0f2ifsLAUrh+J6xH+ercB2qosvvEcdJBQE4oo1222B/tlddEj
	KJqH2wlTw2GpbY4DpkscPkT7p5smL/xEm01cJQf+FLDXn/NRxUaYpE4O4UU492Rg2ao9jUJJTmg
	aFF2jsWRHhUtqBsL7f9GmYee7FHCGLxOWOU33wUL2kuM+lnwPrSEnMX38ihQBN5rCInFnZV7UQ=
	=
X-Google-Smtp-Source: AGHT+IGyoj4Rh+vfqZuk2CgjmnG5MfA3k6Mav6BUL84u1b/tcnNzmceNx1bsHWamLU00lRtJUqTBaQ==
X-Received: by 2002:a17:902:ce86:b0:224:de2:7fd6 with SMTP id d9443c01a7336-22c535a7ef7mr158432195ad.25.1745260797898;
        Mon, 21 Apr 2025 11:39:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:3aff:e3c0:27f0:39c9? ([2620:10d:c090:500::6:17e0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e4932sm7178117b3a.55.2025.04.21.11.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 11:39:57 -0700 (PDT)
Message-ID: <49e38715-6fa4-4483-bdff-29732270438c@gmail.com>
Date: Mon, 21 Apr 2025 11:39:56 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: fix pointer check in css_rstat_init()
To: Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org
References: <20250421165117.30975-1-inwardvessel@gmail.com>
 <aAaQH0ELDM4x9uA3@slm.duckdns.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aAaQH0ELDM4x9uA3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 11:36 AM, Tejun Heo wrote:
> On Mon, Apr 21, 2025 at 09:51:17AM -0700, JP Kobryn wrote:
>> In css_rstat_init() allocations are done for the cgroup's pointers
>> rstat_cpu and rstat_base_cpu. Make sure the allocation checks are
>> consistent with what they are allocating.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Applied to cgroup/for-6.16. BTW, it could be nicer if you note the commit
> that's being fixed or at least the target branch (here, cgroup/for-6.16).
> 
> Thanks.
> 

Thanks, will keep in mind moving forward.

