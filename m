Return-Path: <cgroups+bounces-6598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A9A3AFA9
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 03:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B7A16F347
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADED19007D;
	Wed, 19 Feb 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HFWZ/p0u"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F218BB8E
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932514; cv=none; b=cxJ1qLrZR6pmMR7t7FjGVVaCrt7zuEYSd4F8nwYoz0gKx0dJO4BALTEFmHMAjoal13mOvrXE4XrlBsyLBLey2FJhXjHzN8R1gGlZ9QwV8pvBS6oNMRoP0rYiXv+p+E8XqcssdJ8uoPrtyWknRObFFL4/enjhzpPDm/4W/8zjsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932514; c=relaxed/simple;
	bh=xMj+a3horZECbsUTp70ryecXzS79kAANH3UKAZQH/Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afI5c6B+RuzVtzBjZeiiN1aO65rpo/1uCCeyJAG2pNuR4zOhOC3Ls8xihtNMJ8JBEgT/EmN5GyklKsmJPLLc2xTzZY1LrwxMZ+bS9SrRap2KPk4guSVcOAZGiaGQpREXhIw0rrk+R+ZTx7ED1656zTBYFleuzIqol0h7Wha14VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HFWZ/p0u; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc8482c62dso566451a91.3
        for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739932512; x=1740537312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09crVdPJ6DNP+ajj0y1kahMC/P/o19M63rERtGCBZHg=;
        b=HFWZ/p0u64B7il8VVyHfZpBfORrgijgprKfvMMfNtpL70oS7jQAiEpAzbEE7vP8HxQ
         cvO81QILcCVbA9zGptcJIGEjwBPA/UEuxWTu2hZwv+GMfokKYMThdMbGmNqRSX+tO5eW
         svDAneuNxXAZ+Ye7ozZQUQXZkNnU4u5wjfzGmB5/w+VkPKAWNfqD+jwG6My6ntD8m0wY
         JWG03WQfSlZ1BG5PxXKMPVDaE0CbKcCUk1Le6vPWLYZ7rJlee8rRYE8e73Gn6Abg1m2N
         kEnbkEURYrYWgRlUkz0VFvzYtVDS//M50V1+xYmCCsbyylmlkhTMHKC8JmChxp4BoRTT
         N5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932512; x=1740537312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09crVdPJ6DNP+ajj0y1kahMC/P/o19M63rERtGCBZHg=;
        b=EBGz6gPN7mye4d2kQYZPzGeE324/wl2rviuIPWtSGNPfHhJpzqs4dM4fc4gIMSc1ce
         /5bsvy6qksNGTwqFhbsV3JCsvzWn1qprQDwCHRA9gscPLttkNTmu9Oy5peHIyEXG6Lty
         LnMFtLPvbOUy0tUHDeiUapiIwqN9oogEc3Hd24s9Iz67FBfumw0PYTerYMkDdZrKRJlH
         VLmcu45FIrpvBYWsX3W4MfKRUOkt7d7yHsCkDk74jfHtXrrXAzZ/K4/FEzHiIQYuD4gv
         a6Ixz3ZDp/w+kSXZZnUPpA+BTCp82cWU6X5fTvR+cRX3Z99t9XcP0/JwjplQ7iya8dwm
         1kZQ==
X-Gm-Message-State: AOJu0Yx6UfJOj/emjbIXwbuWCccJGTXoszGSmnEModSW5ShhNMJu5p5f
	TnqubQdz8ChXgj1n6geMPjA95Qt+s6SUadFxsu4XBp5QaM6mT9aRAuYaK49QjQQ=
X-Gm-Gg: ASbGnctLaVBXJt6UxFzJmjmzzJInqRGLVpGfLL4BAs6xS7IFwHcJC+CB6KbGofdjDaJ
	bpzBJIhK/uE0FierfI8eBKIBUnBnGU5ug9N4GN+JsGw3zLsZatyKGYvAOe7AKOiyStsYEwk70E1
	XsHmA2GpHp4qDHbvbCEmkPQYGrzFX0VAsx32X17X1rfhEvSIMh41JUP5Bl9SZW/8+MudRwrbt9t
	YLTHhsPE1uGm/EtWYRdifjkaS6tCcc7xWgAYkKWEj+sUMX1nF09UNSi47IZptji0YcZ89l8JFeX
	xJYPrA3e+mZZIEVWtVtL5eRspg9wbV7euu5qPQ==
X-Google-Smtp-Source: AGHT+IFm/ezzRUBSTF5ubokeL2y3X3qw2EPgW1gleUK8zJWAXhnpg5Xa99tIuiNpk1+QV7gj49PhRw==
X-Received: by 2002:a05:6a00:1256:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-73261914657mr8861999b3a.5.1739932511607;
        Tue, 18 Feb 2025 18:35:11 -0800 (PST)
Received: from [10.4.186.143] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add5a4cb306sm7248480a12.3.2025.02.18.18.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 18:35:11 -0800 (PST)
Message-ID: <cc25136d-ca21-492c-9708-cd72d7d7f2bf@bytedance.com>
Date: Wed, 19 Feb 2025 10:34:58 +0800
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

Gentle ping :)

The latest series:
https://lore.kernel.org/lkml/20250209061322.15260-1-wuyun.abel@bytedance.com/

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


