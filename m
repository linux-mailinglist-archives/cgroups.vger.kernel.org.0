Return-Path: <cgroups+bounces-8545-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93008ADBA90
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915A93B5A5D
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345621FF53;
	Mon, 16 Jun 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5sGUMSA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A71FBCB5;
	Mon, 16 Jun 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104534; cv=none; b=DGlpj2Q5wPmRpPWKjjNgIYG7/HH+6uzB4KkFWI87+jXDlnG+FsttjyTHe8s9wQDlYUxP/c4uTP+N9T5y0zmXn2qNJbBsj5AKSWaTCoP+9Ia+aRaLTg6zksrxNx/Y5VxxXNrU2BiTQ88+iKoB/lJ8s9fkNp7PE36RLy0KaeJNOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104534; c=relaxed/simple;
	bh=df5A01NXZBZc450iqPMX7TMWsUApcKxGdlIeyK0quVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyTSl396hgYxWxjdRvD6VQ7YzGuWV3GX7ozpCvlnAf2UR6kSa2XZBziHjeU28DJDvJkP1fhQPj3EB6boEh7DuNz6hkVU+A1p+FcNCZeOGYKyxsAPi5Dk+iAKQVLD+FfsZSyn81kc0YwGXwNIg/AD2BXCcHKYHe3av6xhHymqUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5sGUMSA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso4365449b3a.2;
        Mon, 16 Jun 2025 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750104532; x=1750709332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7cM7IpNYVMpXKnD6ovGoCFwerEZSHbA5k5p79ZUurg=;
        b=I5sGUMSA4KsYmG7v7hu5aHtlfPDdO/SCS1U0miMtHwMnciAqPjdFQbBMuMF5FJvsIe
         5V2XUCpgkJztgVqeOTyEgRinkGYbhJU0brHCAKv/0P4j+RZU/7ZMaZKAEupwOmogcNzY
         k2GivLFlxBeEEd80L2qQfBD/g46hGRP+SEdsa+U+UwBuAD7wBfv+eReezHBngk74ElEY
         SEWOFi3jA7rCCgXupYNfLjW/qgRIiSbxV+5KdgZ93Fxs7XZGbCCguSP2H2LiwM2P7/7E
         Wgqec0Ak4tKewoU+yxh1FgSRQMv2CdzAB3uLGGdMceKhsbWCrSzUs7+6YHLwryuLFaU4
         vUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750104532; x=1750709332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7cM7IpNYVMpXKnD6ovGoCFwerEZSHbA5k5p79ZUurg=;
        b=SkU9OfHufr/PjLa/ezuoEbdPXXql3B/TSWHeK/lrA6ajn5q5Lb8HpSX0QUGfhX9zZu
         AvfrwAt4st42/m+SaYf/3zcy2fYIo1ZCaorAAMQc47rQCRHf3hk4N+T5tFs2fuqtmj8g
         AWfhk4/ecfuFVgaspqCNzegExJB2XQwVibqOni75BY+HVu+wt9tJmHO+Txuc2nomEm7z
         a1bgQu6Uv/4KIO4rpX2CoW16Y5wM4YN8gALlps+X5aK4r7DE8ubzb2H/wqUIDEcslwXL
         4zQdfpIH6NeRpaRkIVND25P7s3wS6chfrrAsPfzUX/R5SLaXtG8W15q9EL96w4YsNjxq
         5EDg==
X-Forwarded-Encrypted: i=1; AJvYcCUiEPt3P30w7brreo48KAvbRmfgxXC6DNQW32xwe4jxnJAPKPQrptLtaF9zXDaiYarJTq4=@vger.kernel.org, AJvYcCW0PQR0f9pK5OdsQe0hu3Ov1nGtKjnH1H43KjsruWon8SmqSBbpA+Pk/NUk0fhs1Y9Fr4WyDKwdbA==@vger.kernel.org, AJvYcCX54y7+g/GoAOyWA7ZnYy5K7PhdJUoKhnrJ8GBKR3mDOJuNzyG3H6vwtxLOgtr61WJr8IewxzqHgzkRxgc8@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvTnVHqCF84wJTy+jeT1bHifGGdhIv1aM+OgBNIVZjBpQEhzZ
	ekUJhmKj2uJdTbURtzYtYGMiqJUnXRBJx5a9PjExzzy5H3+b31khq9ES
X-Gm-Gg: ASbGncsb2hJagH9qndPD9Mnj81cmujr8u+FcpsLkjztBvdTysGTnWLFQ5T6unyqQMdH
	dvEpsapmPZy0a1FeZdt3h0Vi1pZeWS9r1b+vE4CnNwYSvEzNVo5zwxwui5gUes4wpuFdyOeycrh
	y6tBQhMVGyBPnTsQU47e5fnTuPFgtuJsKdu6ybOIZTmsIeEWmr/B2a9M8dlCcXf4RFuEv0R99Nx
	WKQcZAF1Dnna1kDBnGrXUjMPVy7yrx0vfLEIoScW2InTK5JlSbqophUR6fG81s0zpHbgLesfrUG
	vCr63G9S7LWCeo3ymwhUdG1ut/pznSfmzBmIAIo3HRLPqPUSZZd8QkZpLnQSrZrxY1lWnRxPsHr
	0BZV7rvCfDjYGy4/GoTk/zUPuhgeiEy6xKXA=
X-Google-Smtp-Source: AGHT+IGtI2QbWLF8zRP92H+K4S5vcroON3TXx+J10ig5ZVF2nPlaF/o1jqE6UEeo9QAOopR27zzJ9g==
X-Received: by 2002:a05:6a00:c89:b0:73f:ff25:90b3 with SMTP id d2e1a72fcca58-7489d056f18mr17312859b3a.24.1750104532330;
        Mon, 16 Jun 2025 13:08:52 -0700 (PDT)
Received: from ?IPV6:2601:648:8100:3b5:c6ef:bbff:fec0:9e95? ([2601:648:8100:3b5:c6ef:bbff:fec0:9e95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d7e0asm7523151b3a.174.2025.06.16.13.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 13:08:51 -0700 (PDT)
Message-ID: <218e8b26-6b83-46a4-a57c-2346130a1597@gmail.com>
Date: Mon, 16 Jun 2025 13:08:49 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
To: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20250611221532.2513772-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 3:15 PM, Shakeel Butt wrote:
> BPF programs can run in nmi context and may trigger memcg charged memory
> allocation in such context. Recently linux added support to nmi safe
> page allocation along with memcg charging of such allocations. However
> the kmalloc/slab support and corresponding memcg charging is still
> lacking,
> 
> To provide nmi safe support for memcg charging for kmalloc/slab
> allocations, we need nmi safe memcg stats because for kernel memory
> charging and stats happen together. At the moment, memcg charging and
> memcg stats are nmi safe and the only thing which is not nmi safe is
> adding the cgroup to the per-cpu rstat update tree. i.e.
> css_rstat_updated() which this series is doing.
> 
> This series made css_rstat_updated by using per-cpu lockless lists whose
> node in embedded in individual struct cgroup_subsys_state and the
> per-cpu head is placed in struct cgroup_subsys. For rstat users without
> cgroup_subsys, a global per-cpu lockless list head is created. The main
> challenge to use lockless in this scenario was the potential multiple
> inserters from the stacked context i.e. process, softirq, hardirq & nmi,
> potentially using the same per-cpu lockless node of a given
> cgroup_subsys_state. The normal lockless list does not protect against
> such scenario.
> 
> The multiple stacked inserters using potentially same lockless node was
> resolved by making one of them succeed on reset the lockless node and the
> winner gets to insert the lockless node in the corresponding lockless
> list. The losers can assume the lockless list insertion will eventually
> succeed and continue their operation.
> 
> Changelog since v2:
> - Add more clear explanation in cover letter and in the comment as
>    suggested by Andrew, Michal & Tejun.
> - Use this_cpu_cmpxchg() instead of try_cmpxchg() as suggested by Tejun.
> - Remove the per-cpu ss locks as they are not needed anymore.
> 
> Changelog since v1:
> - Based on Yosry's suggestion always use llist on the update side and
>    create the update tree on flush side
> 
> [v1] https://lore.kernel.org/cgroups/20250429061211.1295443-1-shakeel.butt@linux.dev/
>   
> 
> 
> Shakeel Butt (4):
>    cgroup: support to enable nmi-safe css_rstat_updated
>    cgroup: make css_rstat_updated nmi safe
>    cgroup: remove per-cpu per-subsystem locks
>    memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
> 
>   include/linux/cgroup-defs.h   |  11 +--
>   include/trace/events/cgroup.h |  47 ----------
>   kernel/cgroup/rstat.c         | 169 +++++++++++++---------------------
>   mm/memcontrol.c               |  10 +-
>   4 files changed, 74 insertions(+), 163 deletions(-)
> 

I tested this series by doing some updates/flushes on a cgroup hierarchy
with four levels. This tag can be added to the patches in this series.

Tested-by: JP Kobryn <inwardvessel@gmail.com>


