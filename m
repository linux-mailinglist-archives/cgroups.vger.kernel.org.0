Return-Path: <cgroups+bounces-11974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93AC5F4C4
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13DD835C0A3
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662E72FCBF0;
	Fri, 14 Nov 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ixD2vmHs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328072FAC16
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153511; cv=none; b=IgzSKNih4iJGYX9765bK/7ZpGFhc1EbQaFJkPqiMPI5plBFIwIZ5Tb4cFrijs4gqsR/Aqv78GIvk/zxbt3eTrJJ+H977WCucco5kItf61jLL01OkoGon42QPNhijKcgdV99DScSgTyFiK5dvdcPCCadrQPH400bAo4IVp0Cjf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153511; c=relaxed/simple;
	bh=QHanXXg+OyeerrpmISPQdni+CiKbUE36s486c89hzlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpBqTmjcUWoNt5MnermqxcgFLP0uriWjjj70VHr2DDgmV5ZI9ZxxKS/r0e+HsiRPBQ1y2t9V+FbACxXEeYbXA06Xh2nuDUWhBf83xYjdbO6LJ+0kXgqexLrMQCkAvVZt9jjyG3SLTpob+XDdCscq7DjUGgFVhCRVUWwg+vNif3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ixD2vmHs; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-948e03b096dso105685439f.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763153508; x=1763758308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5fX1MysWhFmcB+WwiW0z8iIPBJH7K9A9qIpnyNOJTI=;
        b=ixD2vmHsXg35O4bIBmbhneRW/CKwiInwhj3TAw85SNWfYBCLS+GSJKE4FnIEqxaQZw
         ztLuSEqeJB7KV2RQxROAiGVebCfkYBUYecYBhczavZekmWsmhJVvx5cVJju5jwMhjNs4
         lTCCt23pt967NU27UpABTrtyVqO7LZCNSwXKDTt0/3IPdszFAqiV19MLjMK/vHDDPTlr
         INFVrYe/uBWMFKVPdd5S6xym0PgwHTeiwkYax+mVXGdHs9VwuNrBaWWwuU8WY5e/cmQb
         ZjOAU9/DHA8xjzRIw76HY/lWL/WClwMnJ59JCRmxUmZ5mhhfiGI3f/62b95Ns7ElDUDT
         2v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763153508; x=1763758308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5fX1MysWhFmcB+WwiW0z8iIPBJH7K9A9qIpnyNOJTI=;
        b=hWSyiBBzArkwGYMQowA4nHRmDw1eqeWnCFuo2/MbEAwT/+OIFVfK8ZN1/BhWIbSwnD
         KO+8Z/+2A/fiW9R0wSelXJ0IWoYSiu0ye+0xAmKBWIql38AYSQILVc4CFeeOKUnnzPN0
         8nvfa0hPOJ/iV3Ypshz1OMjSgkWnSle4pEWcZCP1qeYaAW6sbB03rxgET8WgB+oV2m1E
         Vc56L4cp9PUgKUtNwQjM/HpW9O+GAWpNyL7nPP9x59wmPf6Y1qnGRDUDwhVZOilmmL/h
         I+vJz9W3W4M8XuISCycvv0kVK13P265QvWAAJhkJQjRNSnNfFVAFxToAiCRe5RG0ufE0
         1PnA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8h1stafuBCv2T11XRQj/w1sMwH0XcgtzEEpbOdEYj3g3URUjdD/14ZBIXCCXZwugGsoaaEMk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AUbd0H+sSbej6goPvXpJXyuo6TUT6WR7a2Q/9FoWQE73m58O
	YOkR/daJ5Zg3HbXJBvbfwxDg0WUZro1F95znpO6y8qMn47Xc+mAfAj88HB+MRhVhklE=
X-Gm-Gg: ASbGncuU1yQ9+/dENTNr3PANVqiFahl4TSmRT+Z1rZ1U8PeGJXqffgpjznDzqoHD4A+
	GZ23cSO3IdTY1ELWK0BgG1sEcBrihu402eNV6YyyUt00uhZlNJtKRLSAA7obwangNdOy70DYGgN
	ZXsmfrO6+6CyP9sK4fCapX6N42R3cBLFL0KqBoRx1Jx1OUCRDKYUM3w0mRePCxcrNGt6IaRNMAI
	V5eBhqhtb9pvDQHvAG4Ct16Bn29ylAZpGFTNnSFoen+RGivDEee+tmRX/PQqtI3yfC8yy4CUN71
	WzMvgx1vQL8yiOOyKFWgX0EUs3ww2U2IVyrEKBeWcd2PTufTrmNDFHs5kYFZOxSX2Isn9RO+t3Z
	Eu2adPTYxpmQjb1j58OXJUbX+ZjgZhdDsENlUROPTjdyJ7tT6Y954LVn54H5HZXh34RsEiQCdCg
	==
X-Google-Smtp-Source: AGHT+IG159UiYhWVCcgUydPpcwCRAFvTjZEVsHbRkwXu7EKFm7a9S1w4iE/kFuWeNmbtfLLSP6dEbw==
X-Received: by 2002:a05:6602:6d03:b0:948:75e2:dccd with SMTP id ca18e2360f4ac-948e0dcae10mr730655839f.15.1763153508234;
        Fri, 14 Nov 2025 12:51:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2f8e339sm351975439f.19.2025.11.14.12.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:51:47 -0800 (PST)
Message-ID: <b9efd5cb-d3cc-48df-8dda-2b3d85e2190b@kernel.dk>
Date: Fri, 14 Nov 2025 13:51:46 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: Khazhy Kumykov <khazhy@chromium.org>, Tejun Heo <tj@kernel.org>
Cc: yukuai@kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai3@huawei.com>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730164832.1468375-1-linux@roeck-us.net>
 <20250730164832.1468375-2-linux@roeck-us.net>
 <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org>
 <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
 <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 1:26 PM, Khazhy Kumykov wrote:
> On Wed, Jul 30, 2025 at 4:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/30/25 11:30, Yu Kuai wrote:
>> I had combined it because it is another left-over from bf20ab538c81 and
>> I don't know if enabling statistics has other side effects. But, sure,
>> I can split it out if that is preferred. Let's wait for feedback from
>> Jens and/or Tejun; I'll follow their guidance.
>>
>> Thanks,
>> Guenter
>>
> noticed this one in our carry queue... any further guidance here? If
> my opinion counts, since this is a fixup for a "remove feature X"
> commit... I would have done it in one commit as well :)

I agree with Yu that a split of patch 1 would be appropriate.

-- 
Jens Axboe


