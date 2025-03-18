Return-Path: <cgroups+bounces-7132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A9A6736A
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180417A465C
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1220C00C;
	Tue, 18 Mar 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT8axBdQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA51DD0C7;
	Tue, 18 Mar 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299435; cv=none; b=ANe8Kfqc7HzxzSaQ8gbXU7CoWz/54srVdBdSAYswu78W3YP7b3YvSq4q8iaHdKlnHMSDbyU29EZD8kopJoSwd2HZiFkxO6kDwgq0xEQSArwRJUCsqaHI/IZiXje43kCoinnUWYhlGBc2oxZGXEKLdgb7z7LyQ+4cbCjJRdXcdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299435; c=relaxed/simple;
	bh=mKWN17AgP7RXAQMl5UNpPp2xTFqkRLwFBlYzV8Iy08w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TG3kAYxpfyPH2VT6mdH7964bP+pWFO1emzoKeKo6yrzH/cMzB1l+T9mQAK+4L8rwTs8L8Np3biZhtIho4xw6Z2hTmM34GcBq1JaMMrTRdOyEehnT7I+kFeaj5pXacABPB96+VR2HDVhaO7TpHSVKy8bJOqoTM7FGjFEX4XD+auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT8axBdQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so5243975ad.3;
        Tue, 18 Mar 2025 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299432; x=1742904232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g286AmrqJFZCIXU6diWj4M9nrpngO7iRskShEc5/HSI=;
        b=FT8axBdQbX6/JvDuLsNRM9cUDBCsozv3/edJWQsqnc8sKinXfuCweKuAd6OWjh5eyO
         Qke1cYZ2lmqJurfKUucz8Y9pkGDdUeTvClQKrvDKT7ZdgzcyAEvlEX3GnD4k27GmLdCD
         9BtS+uKsbZV6nMQJ2J2z7TWd7QjWKhJReEl/gLPbciL/W11k9Wr4BRnYGsAyaG30VNd9
         wXhaNXQ9a2FeSafJ8VFeRyVum4QPe9eDVdrXRbiaOkPPBWbCrRPKaN6d9M7lT8NwZbUE
         1y0hBLvmjCJrNxSxc4hWnrts0JGplLDMS9Ta4EQBss9pv+80m6R78Llamh4UCYcBCHOd
         +yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299432; x=1742904232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g286AmrqJFZCIXU6diWj4M9nrpngO7iRskShEc5/HSI=;
        b=UcjmcmWSv0HTBBLxf0LY9ZoSi4oq2V3wUy67Bm8+mc0raGJjecuEl9nDWDI3/6AvVU
         uquOmeoy/r9wU5hKhbqBJklJJBVj5Oo5l2FLTtyX+wyTXr57HpJVKVvGXrzG6VskLG0d
         ki38crXZXd0ZCkH41Ajb27jD6HHS3JUZYDLLoID6HfaCWdKkkIWgxov3IIuFbdo7mL+Y
         /oy7Mt8UL0w3xbea7XBbxhLMxP3oesPwiJgGC0ocTI4z9fZ91MZpLxFoCGOfa0Gr2ioa
         vkLyxeTCZDwoDTWOlGtTGJyAuml8TXobzu8pR12dQ/4jpVFvWR692ubTi0PV/CblAiCj
         Palg==
X-Forwarded-Encrypted: i=1; AJvYcCW52S3KossYoGMQoMKNRrCBDbBYMxZ/gmVi0czq7waqgywCtOzawBxDr7Lf1JDzoq50S+z/i352@vger.kernel.org, AJvYcCXRA7TGtq3EJnGLm43uh9TZjHphD38nz9SXk38WWpkyGYc/GnrJ0lv2Ze+pIus2egwHHZxICPBn75ktdNMu@vger.kernel.org, AJvYcCXrN2cYUnxaCb6DqpfG7EUYitF6LvmTGeT+Vuj/LrZRBDyD4QwMCsI6j5oZK5sXh9M6gBtqFqkWkq3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgbkBcInpVc4dZOXbs7j5AvWU7MXJasxAZ14xOaInjW4lcJRf
	+98o/RIEBROHNT0tRch2bfI3BJynIa/5ioVLEk8uTIMSiCYtEoLkmfxMHw==
X-Gm-Gg: ASbGncuXXYQu2HC+z3+pFtWqHGJQrqIn3tRtpdsT93JCGQ+HSipLtUzvQspdrNPYiZM
	X9rbP77yUJWA5o7jV2lrMZAYyz5rAra79qgnrCusNIge16tTKbqEAyMbLdnIKbCRDaVLm8/PYGk
	3Sd8mZK8/+FhiCz8DmtiAYycgnZbUxYIw4tFBIeZwGFuAL/auYQfPOHchF03qcXk8aJaANMN6R0
	T/69wA+UN7RvfQ5YtBtfL+AfJKpBULMGlouXTlnn7oln+Wp8yyMqLyZ/9zCwJHzrfrmoGrNe/Af
	GtD5PXxerJs0W4gEzGp7M6P2xQ0ltgzJ23ocoMgJowTzDULJenIkuF2rT3Q2T0KV
X-Google-Smtp-Source: AGHT+IEUry7uNBfZfrQXJDmQ4UWuDItAhEZlRZebCkdsdMrUuE7/GeKzZVaB0DmYQEiGHfspFpm1bw==
X-Received: by 2002:a17:903:1a26:b0:224:c46:d166 with SMTP id d9443c01a7336-225e0b18f50mr251057845ad.40.1742299431758;
        Tue, 18 Mar 2025 05:03:51 -0700 (PDT)
Received: from [10.125.192.74] ([103.165.80.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68884fcsm92974765ad.16.2025.03.18.05.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:03:51 -0700 (PDT)
Message-ID: <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
Date: Tue, 18 Mar 2025 20:03:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org,
 corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/3/18 18:17, Michal Koutný wrote:
> Hello.
> 
> On Tue, Mar 18, 2025 at 03:58:32PM +0800, Hao Jia <jiahao.kernel@gmail.com> wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> In proactive memory reclaim scenarios, it is necessary to
>> accurately track proactive reclaim statistics to dynamically
>> adjust the frequency and amount of memory being reclaimed
>> proactively. Currently, proactive reclaim is included in
>> direct reclaim statistics, which can make these
>> direct reclaim statistics misleading.
> 
> How silly is it to have multiple memory.reclaim writers?
> Would it make sense to bind those statistics to each such a write(r)
> instead of the aggregated totals?


I'm sorry, I didn't understand what your suggestion was conveying.

Are you suggesting that the statistics for {pgscan, pgsteal}_{kswapd, 
direct, khugepaged} be merged into one?


In our current scenario, userspace proactive reclaimers trigger 
proactive memory reclaim on different memory cgroups. Tracking 
statistics related to proactive reclaim for each memory cgroup is very 
helpful for dynamically adjusting the frequency and amount of memory 
reclaimed for each cgroup.


Please correct me if I've misunderstood anything.

Thanks,
Hao



