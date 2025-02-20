Return-Path: <cgroups+bounces-6621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A07A3E13A
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A823188C4D1
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F091DF749;
	Thu, 20 Feb 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jw2lEOeO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F462116F6
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069970; cv=none; b=E0MDrstGvJJRN/AWHZxR7OLafFzwPGkQOqveoe98kzOMvusLvpgDDUwcPBnvAhp7SFs9iBFli02vhSH2xWTmuL9E/RIGpN3Rs9mD1rG99tut3g1Oy/Jjx/rkyMREDwC8evUKtUZL93Ai7SC6MkcpiXOCf5aXqaA19Vfw63UeTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069970; c=relaxed/simple;
	bh=Q96fH2ufnyrRSkdVqFWpIfJckWGdN24HBgnQJQFk4P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJAT/37s5MITxtNGa0dJ3XzIRbEwpCqOypgRWL1ySyFmkc/OgPibOnyVA0orADpsANuqCm4hG+ju4IFNoZk3b+Xk2F7oHndw/XfbiADAmzaucoAo0lNTytBqUjP0UJ807pF/cWFatZkoQAfcuQN7oQXrbXENfVrcEuisXzvO2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jw2lEOeO; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce85545983so3528905ab.0
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 08:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740069966; x=1740674766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
        b=Jw2lEOeOqtUCX24vu+Jh0LDfwu6zr2LDOafKLp9WXTaTnAbjtai/gChG7SmoUIkVMu
         ndEVVTLqlYRLW4sJu1syFSw1Sx8PcfyPaTTNdM6Wk32jwKxkEm+b4qriHBwKurV+1mAf
         jHCC5/OvIrnlnG0rF4VQE3SicENiTBdHK7cUPWh26garY/KyZTb2+SEnCGXuVmVMkc2V
         D6zJKwVKClWXK8xVGRvhMioWfiLnD/81xxF0wgfkItPRHeCC5ciFjf+NK4YyXXRruyNn
         zVR1Tp7b1CYjmcv+WfODQqO6SwxVDWEU5QU2hNRGHrJ/cMOG726zb+oWPVYfBa2mTrD/
         UBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069966; x=1740674766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
        b=ElZAyGsMFQRChE83kV+KappXuEpWVln3Ult/rWh+c/6urfKWBLPDpcjYIPGbyYY2Cj
         UOIkb72ScIOsIK5Vbpv0us1qEWzMkDGWE4Wc8tHE35HSrmTtlNOkR2T6DLcFmnFQWYp0
         Dt98mjPvdN8A56kVIvYrLw4vpONd5GC0ifs3D+b2vsE/LeThaRK4RR2Xl3emYta5dLS5
         WRx0eUDL+lyDrPDPudAo7vBQod5egBZgpTsMLCTf/iRrQLDEbxTht8ogaqwbNzPN9ReD
         jODIKJSQMOKx737sfx8+Bex372NYNp6xYlOPIzujCY7TpthiUVm5CRmvFHYsXO0hPwau
         EhWg==
X-Forwarded-Encrypted: i=1; AJvYcCWwPy/ApOwjiJimYIVNm0wKdkH6s5Zx0wxkfmigMAkqX3V7u9AyJrf9ahFndEmRgAb+1n69dvnw@vger.kernel.org
X-Gm-Message-State: AOJu0YwvR0MP2XOoD0cqigZ854ne2d2kBQiYoST+AIqM26fMaBXtBVkn
	HxbyvH0R7tg82pgU+VqMH+bGD0tx0XPrrToVhYcnc/gNMeZ2RFhm9VloCFtK1Ag=
X-Gm-Gg: ASbGncsLDDtb0i3PLMSamIDxvhA/48Hcl0UenmNMzWFy//NsyT0xmXS0TbWAthZTlZn
	5gYsx3mJ5kaqpQdmb5MTGqF2f5t/C15chqNQr8tVR7LlD7tnvIbUN3kg2OiQSrItVJBowxVhaum
	pkiXXvoXqwdvScHONj313uGT8R73KMMy8zva+9TDL2e9T1Pq/JU8y4/6b8EKkE/PM5uMdWAT9tf
	2f/pHFvPlY84+OArslkifvuabu+GXK72fmmGLTQLzap4q6RpIqP1Yzzrz9wfKI7PJje/msPf5Hm
	IacYuzsA0AU=
X-Google-Smtp-Source: AGHT+IG+EYLLqM6THWYE8hAauMhRAcU2Nk6bktOc2WtjLtNwvqYq1DbYMyEayXYWgyo4XXN/dzNAHg==
X-Received: by 2002:a05:6e02:12e8:b0:3d0:26a5:b2c with SMTP id e9e14a558f8ab-3d2c01cbd32mr32793245ab.8.1740069966144;
        Thu, 20 Feb 2025 08:46:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9f935135sm1841325173.42.2025.02.20.08.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:46:04 -0800 (PST)
Message-ID: <d178e65f-0168-4046-b516-1304db75820d@kernel.dk>
Date: Thu, 20 Feb 2025 09:46:03 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250218: arm64 LTP pids kernel panic loop_free_idle_workers
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, Cgroups
 <cgroups@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Roman Gushchin <roman.gushchin@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 9:13 AM, Naresh Kamboju wrote:
> Regression on qemu-arm64 the kernel panic noticed while running the
> LTP controllers pids.sh test cases on Linux next 20250218 and started
> from the next-20250214
> 
> Test regression: arm64 LTP pids kernel panic loop_free_idle_workers
> 
> Started noticing from next-20250214.
> Good: next-20250213
> Bad: next-20250213..next-20250218
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Should already be fixed in the current tree.

-- 
Jens Axboe


