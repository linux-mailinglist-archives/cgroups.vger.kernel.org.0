Return-Path: <cgroups+bounces-7801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E6A9B4D9
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C492E1BA6913
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41799289372;
	Thu, 24 Apr 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVUsWvUp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424D199938
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513957; cv=none; b=BQ7xK4pfjpKk23/1uIn0N+TDr++sfi2cMz5tBXpFw/BgsEzCU471dO4YLcE6t7WU9qnXREwseiBftvjcGjHCkRcCJdZW4yffso54ze/YHlwWNPSMl8o4Wb0YiEXx+6FctHYnskqu3WTPaSC/8Y82w3zhHAgLqVekNyYPkI+Ec90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513957; c=relaxed/simple;
	bh=0VXoTVfLhV6usPltUG5Ri6Tg3PrO0wdKSkizOcCqOXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f06RCBxP1CzYqm56CMZ6V5ILhIas0Gjx8hZn8BDbYG7TFLye4LndyyDnuWijFjISfxoloIg7l6AiqIcKJiGsc9ugHPRE4qd4Hx49e392xYTa4is91XWJC7lxDH9ZF7crIO8bZNL4Hs4p2q72ceiD7ogm0rWY/KrKi48lXIYo27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVUsWvUp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1352659b3a.0
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745513955; x=1746118755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azGIvknsWdh6k5YLGDD1PNwdlPs8Yy0ARh4x0n37n5I=;
        b=gVUsWvUpgXXKtdGzUn8q2wcLuNuhuih94Llw2WgIFOuh2gJ2VHtAGdgFy067FrpLc1
         k9ItENdiv/emYPhyeUXU2F5gKzn41MTchC+Kk6INDvPhNlxiiS3/HgGzmxZoQBrwdt+s
         eX/c6BvuE8QG2EBYRDQkbWPULhbLxZGN09DCRRc/fMPdPZM+C0qCMhyxC0Qr00XNMNPI
         wa3HE58CeEZfLmqKZ71RaaRErExku4womMyFl5yqNCakISfWM0MqbooEOVE1YGvCIpYK
         7YsO5QzCHR/B6uvQSEebTZfaq5JKaq5uKtxh/eUNXVtdNdyvaeqMZc3QZetO5zhpc4sk
         V1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513955; x=1746118755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azGIvknsWdh6k5YLGDD1PNwdlPs8Yy0ARh4x0n37n5I=;
        b=JlKENQK4+hb52W8nsrtCPMfzlTte/j2F+zkCGZcVn5NXYFgJb10fymOY7RkzzrBf80
         bSix4s9KvZjmDHH1C9u4F5IzKyivWvcLnQLLlr6fApKRnBCWylNWKYiNpW+WmUa56wR1
         r7S8ayqzAfBL5FjUM95DhsF5sraCxX+zcZD2ntY4rMDumb9Vk6e/WeWTEktMGz3Jlg0s
         jq5iBZIEXlHZn5dv+XBu9f9xLc+4kH+noMa2oIh6miHp3ld8Vlcwk3byZGcNHNW6KYc3
         FgTLZhxq3RhFi3FPKSnuQH4TAm+W0AHlQ1KkbJDupINlOV9ImOcoR6nK0/dZLOJDWzxm
         XBQw==
X-Forwarded-Encrypted: i=1; AJvYcCUFyrBhmZ4vJobK7+TrnWWFJGRqgvvqr8RtB6nIYSH/yAzxKt7NudRt612CbCylNm8X1bMyZp4h@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnE745fuvquTNg74FOFlaWZB0lNJRp+eX3bdf05ZdHtMyoiGA
	9enefm70G8zD6k30mJyIgegwfNf+FOCVe0Ik4wDebkSqN2HWYV6b
X-Gm-Gg: ASbGncsMHXvFMxOKSIkp1u8EUORdGylgDE513EOkcEpG99uomHPMuKyZKR2+1+rhlwA
	5qQ+n0ChyVp3cSyc9L4chWysD0sgYxUKlIsoq15Glan87lvI01ZVuaaQjvNBdMb1QlhveHdKT1T
	bsiJt1f4GG0GbWkM2FfuJuHHKO9pCnOZJInb4gLzGxIibnacrGC12nV0yCDWhdJSWu8XEEqPNqR
	0bpkWjw3UGyMscyzTTDjBw6o1pVsqxtm538xGPPg6xvqjqBXZL1X3qCUJWSuXM7s0zrzwTNb682
	6J6BHt1R/uDkxybTi5S7K3ctlRzebwcaoi9enbAufmb3RysxqSI3nfeaBww3gCjIGIDzs8TU
X-Google-Smtp-Source: AGHT+IHAoC8aVgfD/8cAgUvVK3A6T83NWS/BjOsk4NM9SKcTuPFC6bfZGZmiq0I79DNn1WhFz/9TIg==
X-Received: by 2002:a05:6a00:3001:b0:737:6e1f:29da with SMTP id d2e1a72fcca58-73e330e299emr511217b3a.21.1745513954790;
        Thu, 24 Apr 2025 09:59:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:fd6c:bb6:36da:5926? ([2620:10d:c090:500::5:5d68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912c70sm1635484b3a.29.2025.04.24.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 09:59:14 -0700 (PDT)
Message-ID: <d9e18f8f-6784-4219-875d-586fd7f32e1a@gmail.com>
Date: Thu, 24 Apr 2025 09:59:12 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] cgroup: add helper for checking when css is
 cgroup::self
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-3-inwardvessel@gmail.com>
 <68078968.5d0a0220.2c3c35.bab3SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <68078968.5d0a0220.2c3c35.bab3SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 5:19 AM, Yosry Ahmed wrote:
> On Thu, Apr 03, 2025 at 06:10:47PM -0700, JP Kobryn wrote:
...
>> +static inline bool css_is_cgroup(struct cgroup_subsys_state *css)
> 
> I think css_is_self() or css_is_cgroup_self() may be clearer given that
> we are basically checking if css is the same as css->cgroup->self. As I
> write this out, I am wondering why don't we check css ==
> css->cgroup->self instead (and perhaps add a WARN to make sure css->ss
> is NULL as expected)?

The check for css->cgroup->self seems reasonable. The intention of this
patch was just to replace explicit checks for existence of css->ss.
Regardless, since patches 1 to 3 of this series already been merged I
think we can consider changing the implementation outside of this
series.

> 
> This seems clearer to me unless I am missing something.

If the implementation changes, I think adding "_self" could make sense.

