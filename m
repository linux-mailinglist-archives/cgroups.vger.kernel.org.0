Return-Path: <cgroups+bounces-6411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86E3A25406
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 09:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6CB3A67AC
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8DD1FBC92;
	Mon,  3 Feb 2025 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RRNlzsnS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B851FBCA0
	for <cgroups@vger.kernel.org>; Mon,  3 Feb 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570300; cv=none; b=SAxQ1S+RCigcDgCP4IhyMeDenbwIZ/psF79cTf09EXWKx1UawuptSz2V1/CxJwrRK4Hb/lD0c1F6/FElo2/2YXHm9g/kEaTD4WsUYpoCTB1WLMa1D9giejjDhY05D77s6VeSFEKrsJ/lj+ZmsU+mrgeQgs7xdSvAuTueEfxUDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570300; c=relaxed/simple;
	bh=TR7JJGhWZGiD/N0YM2B2iYOc0Dw/MLNAyh6SBoMJ0s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwfkHPhzg4fEPn+s0emn74ugJG1gi8IcUc4k8JCIes7MkZaRypo7GhgcADzOScLTnnGuzlnPAedc8/zuf0Dgdgk2KvZc68SAIF9WQVr3l9p2wSv+4niLH45rrZOFlgZN+p+Uaz/051mU0HVmF5eBlnyEdWcCziu4tLdyU5FJWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RRNlzsnS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216325f516fso8005285ad.3
        for <cgroups@vger.kernel.org>; Mon, 03 Feb 2025 00:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738570298; x=1739175098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3b15rQOlRt6257glX/YGDFah/u5pLWNaY9BbymMcpk=;
        b=RRNlzsnSnCDi5NqT45WijDpTG2IG2SZHbdF+z/Muz9e4kMxzBSz6sEBqnbE0TfwhZ7
         3xKPsWu1mTzIR9C4yRFpOwzhU9O+zMwL4UnlfTJiLiXIdVoBopuwYqjhds+7I8mC0peS
         EV4G98eC8DJW9BSSWmqxCDEPdK5FalmfmsNInp5Xx3UAHPLpOeRkt50EHjJaWEtcD9eu
         w8SQ6KF/DWYFgDWNnDf2D43zKrwaYnx8zzc7sJk3B+iu4tzGsO9tGuBIhviM3vQ+62nn
         zc3B1p+2KPg9Ttknk3GKUGwnL57V7oaTJWwsBnq3hbtx7GzMc1CcUmQ1Cmso3mjorjDV
         dcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738570298; x=1739175098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3b15rQOlRt6257glX/YGDFah/u5pLWNaY9BbymMcpk=;
        b=WagDSNhmP1A4ff1GWYmq8u3BAhH6l2v+R1S4zB3wbQLxoq5sUfmK85YpaMyY1F4eE6
         FyfNaKfRLPXcQb7GWjkD4X/+iJ9VxXuztPPyLnAXp/raIr4NAzNi4HhXnMoi2+7Zillh
         BxXSH5wvSsF8BhyyzHowoEWGd8ngm4a071ED7DyL/x+T5Pq/8UTg0NqdYTdpcTJF18dQ
         pMp+4vXS02MUL00zuSulUldfGbelQRqq61uwNewS5YHgZydTXWSeyDXSj9lfP+VT5j7r
         N4nD90v5d10rZs+KWeERToz35NVyRoZHwDK1u959NNWSe4rYr1Wm+xymjKDq/N72W2mk
         uaDw==
X-Gm-Message-State: AOJu0YyfnBttxPB0pbeheLNQdY+Cz3sC675AIHm2rkCR2/hRxozsD6Qb
	Hg/Dcz3TGai8uml3OjQ3ZuyCRgu47zCEPC5vxTtheFGcWt6yxDZ29GlUymHvjxI=
X-Gm-Gg: ASbGncu6FcNPIlQVjB72NEo4zkUyWu3+Mg21qp+5Y2S0FeeN8waMMTytVFyuPIqX0XN
	Uq2csRSXxlx+8KYZ+x7E73R4wOUFQjDmUIRZM0uknvW/5aTeq1xXZjLYnG107H0RWnKKSmJzNtZ
	8JXh8K9LG3xb5ZTlnbGVaNVR0F7DqJmqcmc9kEUi9rci4MTaQ7zrx3rDhtm+YR/A87lA+lz+lQ4
	rcc+SatWtMI/Ux1gXreV/3icDX1pavP5nr6B4dltT8A2fOckahZoM+uSnCPvFSK/0UQN35AXn67
	FbntHarXHLHH/oWPYvaJQ2tEzvbZjQvCAanT
X-Google-Smtp-Source: AGHT+IH4x2AiZmQumRNy6RvxpMMTZpVeRTkBtlhnsq+DTT29+OF2bf4bR5NPVaMUqOxKN527WAKgpQ==
X-Received: by 2002:a05:6a00:4483:b0:725:ea30:ab18 with SMTP id d2e1a72fcca58-72fe206ece8mr9292513b3a.0.1738570297799;
        Mon, 03 Feb 2025 00:11:37 -0800 (PST)
Received: from [10.4.234.23] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427a8dsm7983950b3a.54.2025.02.03.00.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:11:37 -0800 (PST)
Message-ID: <bb16ae49-f591-4ab3-8d27-f649619b266b@bytedance.com>
Date: Mon, 3 Feb 2025 16:11:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix and cleanup and extend cpu.stat
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>
Cc: "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20250125052521.19487-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping :)

On 1/25/25 1:25 PM, Abel Wu Wrote:
> Patch 1: fixes an issue that forceidle time can be inconsistant with
> other cputimes.
> 
> Patch 2: cleans up the #ifdef mess in cpu.stat.
> 
> Patch 3: extend run_delay accounting to cgroup to show how severely
> a cgroup is stalled.
> 
> v2:
>   - Fix internal function naming. (Michal Koutny)
> 
> Abel Wu (3):
>    cgroup/rstat: Fix forceidle time in cpu.stat
>    cgroup/rstat: Cleanup cpu.stat once for all
>    cgroup/rstat: Add run_delay accounting for cgroups
> 
>   Documentation/admin-guide/cgroup-v2.rst |  1 +
>   include/linux/cgroup-defs.h             |  3 +
>   include/linux/kernel_stat.h             | 14 +++++
>   kernel/cgroup/rstat.c                   | 75 ++++++++++++++++---------
>   kernel/sched/cputime.c                  | 12 ++++
>   kernel/sched/stats.h                    |  2 +
>   6 files changed, 79 insertions(+), 28 deletions(-)
> 


