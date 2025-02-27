Return-Path: <cgroups+bounces-6725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B236DA47A6B
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA1E189251C
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7D22A7E6;
	Thu, 27 Feb 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lKA/IUr/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402B22A4CC
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652524; cv=none; b=hZGVZpLYN3x9fAAdkO/HzZq6ucKYvm7QBJv8Qa6XV1D3db1N00m3xzwmekN/w6f/nktxT1/vuSgA/G0+ZhtkxrYo6BOcrNITY5OPpMk1VwSLSecWYZvs5b950tfgTMVldR1sgnMII9S/FUTsw1sS9zExmrzH0gjf5BjWRhxVztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652524; c=relaxed/simple;
	bh=iKpo/ANNRvS7PqVOBTD5Z1674Bqo1hkwWWaLg3oYq/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKM5mtaCW+v1pzo1ANS8pDMx4DnPyp4cwcn63CDEt9lAZcKdLSFWDXYYC9bJLKSUc0LvW73+0nnpjZs4GTsrbBiyPULfUTAU8C2gGXcFXIsUM02T7wfoDuZsLKLeN5VktzWmAKv7etgG/bZcNf2XoVMKowOt+TxMJ6o3SjWW7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lKA/IUr/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223600d7968so268625ad.0
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 02:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740652522; x=1741257322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/7qJ206YPz+4moTXTgU2pFLpIcu1g5hcyPL7GWlHTY=;
        b=lKA/IUr/ygDezzdU4Onmlp/pMdI3ui9Riz/vh8hfrtCwCgGci3iPo5bV/GXplSAd/0
         FPkc624S7RelUFbVjxFkTlPqq3KwttgW3sxL+vKsFP7r7B5x4AEnVTndnMnoMGdmyh1I
         mECNIUPzdTZ5kZPj2FM7bEwVQYvGnErj3qmAmW2/K3RLIepf0jQh0uk9G3IkUW+F9kTI
         AMfjVKQPWXeAKVNYQGwvszKXpbcDomPEw8QE5sts55a3UvQTBKpJRF5GKGfIrjYZXtA8
         Xr82c7HWUC8ehW+teJ9cAC492778mEmxlKmSdjOkR+cX6FS/YMKDlGRJMGKexqbP2Mic
         H1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652522; x=1741257322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/7qJ206YPz+4moTXTgU2pFLpIcu1g5hcyPL7GWlHTY=;
        b=bFT+714rZHwf9ok3X3mmSe4Z+PJMzW9jC4Hj7xJiKyryubbISQQJkrEEKARo/+PP52
         UcN1oirIbKYJBdU+7ljk3G+tB8XlQ4lC1G87CFlMu1LSsMgXX+zB2MTV3l1X8zJ5qKE8
         nzeJTJUn5hxeNoQW/OZxyXIdGlqn6VG2gL6ldOtQzikJIWxGaayQ46WvGY78PfVMcl6Z
         hCwK1BzJVw6ShNttqSDU9yHmgCc9Ax7iShdRDNSBgdaDRacIIu/o+TMbSVJcqNIxEAOk
         N3D0zv8sioM+1fb9U1vr6Uu+suPujBEM0yMmYx2B7CaePmzwhhSpuhqXN1FrO/f/tJoD
         HGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUD963EeBCfaFrk5DrXjtZgXphCsz0obkNdZnRinB3UE7Nrz6GM/HdQft7NZgqe1w+ONWoHAnpN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8K3C5ISntnJmzOJ6z8R8/aOldx2WVE6XlTeSuTloK3T7he7l5
	ETZ5OSUFQg1wKoZXYDEJojzBtklfEDmAGECso0DPKUbI07jskIdj99oabZ9h+dY=
X-Gm-Gg: ASbGncsL5LMAHL4/YmGO2deYXNuEjATsX2puxaxMWF6r4ZN8HnVLeM1Pfoesg8oG+jP
	eMZtv1q2W3s9lGcyZsWKoHIC9N4KvbAdMeYLDPqSfZhY2FmiWyjjXuJnsRLg6EpYkrPeQsFkgkx
	RBVTC/pDcsoWpXFpbnI4n24oZdLGVtCxwofuAI5uqMvLJuE2ftqJ8qbigNmwSimwx5ahdfn80ED
	wx7vYeWYwXIVJLSM37oX23VVbR0MgKkWmJLy3UUnseFH1CFJfOas5MU1d/UXIm8WKVndcSW96tl
	h+mmcauFbxPmQL7RMVWTYnIfCUXKN/DP5gvJAHG68LIMaGCYFw==
X-Google-Smtp-Source: AGHT+IG2eF/KWw0btmV3OvJSgHHBcrv4Gz4eHM/FMCZ95Yqt3G9ljdaRFO2LLQCu685+laUbmi9fYA==
X-Received: by 2002:a17:902:e84e:b0:223:49ce:67a2 with SMTP id d9443c01a7336-22349ce69e4mr17507655ad.9.1740652521119;
        Thu, 27 Feb 2025 02:35:21 -0800 (PST)
Received: from [10.254.225.63] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fae29sm11171955ad.95.2025.02.27.02.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:35:20 -0800 (PST)
Message-ID: <9ca0b984-7b6b-47b2-8784-1e708599170f@bytedance.com>
Date: Thu, 27 Feb 2025 18:35:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix and extend cpu.stat
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Yury Norov <yury.norov@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
 <puq53yk7guef3itr4d2uq5ka2m6cdbdflzzdumuvs2giyefwns@2e5ynejmu5ht>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <puq53yk7guef3itr4d2uq5ka2m6cdbdflzzdumuvs2giyefwns@2e5ynejmu5ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/25 11:41 PM, Michal Koutný wrote:
> On Sun, Feb 09, 2025 at 02:13:10PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
>> v4:
>>   - Fixed a Kconfig dependency issue. (0day robot)
>> v3:
>>   - Dropped the cleanup patch. (Tejun)
>>   - Modified 2nd patch's commit log.
> 
> But the modification isn't the usage examples that Johannes asked about?
> 
> Also as I'm unsure about some plain PSI values (posted to v2). Maybe
> it'd be good if you could accompany the Σrun_delay with some examples
> showing what different values tell about workload.

Hi Michal, sorry for replying so late!

I am going to drop this patch for now, and will restart once found any
solid case. Thanks for your (& Tejun's & Johannes's) sightful and helpful
comments!

Best Regards,
	Abel


