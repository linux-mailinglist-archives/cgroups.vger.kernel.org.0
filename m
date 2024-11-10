Return-Path: <cgroups+bounces-5502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F929C3091
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 03:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7449E1C20B7B
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41F42A87;
	Sun, 10 Nov 2024 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGDvkbDT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2C2D600
	for <cgroups@vger.kernel.org>; Sun, 10 Nov 2024 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731205173; cv=none; b=TahqEVo1GGRPwwiy11jZnXUpxshoszEeahsgBgo6i/Ee5G9T3EfMQvHy+71elEHMK6l9SSpPcU4M97flS/b3f3Pp/Sm0YIgUMtndEm33kM85O63fE7Aq3Dca/FOQeoxb5UekXOZ0ApVOO25x20lFp1CgON7IE5DKM7dyMsqHiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731205173; c=relaxed/simple;
	bh=+pD7XKkk7a2kvnad7+CqzCvmXc+hzqXdXdhSGLuRglg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BvuOBa/YyZxHI8vNdKEer5szTWyQqehW109SBmdfJqRPqYYR+pu7JtyqFU8YZC7yKTcXpC3ybhLVQokVo68lHCymKmRG0QjXuwKUgvEPt6gv1gNNob8Ha5FtvzW9F4ulsDyiQhUKE1+W96occvjivR3Jz1KYPvNDyfsD+WiTSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGDvkbDT; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so158745ab.1
        for <cgroups@vger.kernel.org>; Sat, 09 Nov 2024 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731205170; x=1731809970; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtYxf79bGu9AQ23SIiIULXTG3CqHwpSP3g6NHEutdz0=;
        b=PGDvkbDTUZlrFV0XwDHfKC/xqpV7eA2G5OVVtsbdZSHm/t3LzHM/x47NcuJfvVeFIw
         UO3o+QlH1OLiyFP85fCnohJTGdGJju3UA7vZZsu9NpJn+AKJLmXPUsz9oT2rp3xr/f+m
         HkhQBVS63X+LvPLcZzJxdP0dCGohfC71COwGYs5lIWTbg0TORDekM8/Ua2FkhXh3a+JV
         DvB6f2SgDwJ54fEuiZ3I1jaUIGp6EEPrTAx22pNWbhY3QxM2xfT4Dx45fk/Zl4jfvyS5
         rr+425fqBgZM2AMe1MYPYaFiGRftZT6FuzzQ9aX3PtTkUoQshkWtkVLoXdkCjCsaINc2
         Qf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731205170; x=1731809970;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtYxf79bGu9AQ23SIiIULXTG3CqHwpSP3g6NHEutdz0=;
        b=qAi85BeaG4Ua3JuHNkOljKnjbq9oPnZHhwTEjeSMzNsWcBrbYOyFK+3QLeonFbfdPH
         6YHf+/B2tElLV3z/jC7Bab11YBT2QJdkZsrMNHXKM+d/2HEgCkPlz2MRau0dSfUgt6d9
         3DRwpLcZy1QoafEFq8WPQPIKCFRd0pcKl8pOhv6gbN0ZH9ivM2VgpuobPosM89VLUDSA
         7BwtKvJKcu1AUO9VeNASfnYJFIH4xfhVWQeyMzqDHGjpi52Pt7+LZNN42ku/tENUPtgC
         YfDQiK+FzZ4iSVRRVQBIkfVlI3OcRlHcnxsB7Zo5qA239ylObAs/FuT0TdoN8ti+JDkE
         saUA==
X-Forwarded-Encrypted: i=1; AJvYcCXpa4rWAb6lQaWpehNblpFHUxxEcTjZonFuJ1PyihEr9m5PA2XkWtrctqw4ZgErUpj2MrbLna5Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dxdK6zxE6jVeMI6qZ8jattkAXl0B7Hm1UQAg7CpmPuNRe++W
	7zOKjZPOqlsWXNbMkuKllU3mQKgEL1GwLLmE+pKuHfGK0MZcHudEdWKHOAZUtg==
X-Gm-Gg: ASbGncun83ToDrNfYgwWpoAuQBmL7AoGNEpioubRndrLXmtr8Fa0Vf0mAKtwR+jvibh
	Ls9wtCjL1ALuHjnwM8de4d7nax8TxmChyvF2Xcq2Za6xPsyT4pUIl7LkmmWLFcmiE5R6AgGEGwX
	Az1JIqg/gO1XI+YkWN78YPEdkqEnIdCXhfyGbFVDjotcLaBKt9jF8kPprOlnWsgX8+6EYsVQTV2
	WPoHM/QJvRUDkPerjSGvCAqBgqaLvEpU2IYNAWBC7kJo0FKjXpuZ4ZCfasUKw7fh5IN9blAcjmr
	gIAP
X-Google-Smtp-Source: AGHT+IGOlRHUbzZ277/dq/Etm+M1ZnIxeb6x0lBP5+1k9gAuZMD69+G3KnUOpKIiYz3VJ0FVMcaicg==
X-Received: by 2002:a05:6e02:1946:b0:3a0:a224:eb2c with SMTP id e9e14a558f8ab-3a6f9564132mr2137955ab.25.1731205170261;
        Sat, 09 Nov 2024 18:19:30 -0800 (PST)
Received: from [2620:0:1008:15:c964:b0b2:aab1:6944] ([2620:0:1008:15:c964:b0b2:aab1:6944])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5f048esm5013642a12.50.2024.11.09.18.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 18:19:29 -0800 (PST)
Date: Sat, 9 Nov 2024 18:19:28 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
    shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
    chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
    mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
    linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
In-Reply-To: <20241101204402.1885383-1-joshua.hahnjy@gmail.com>
Message-ID: <72688d81-24db-70ba-e260-bd5c74066d27@google.com>
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 1 Nov 2024, Joshua Hahn wrote:

> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69af2173555f..bd7e81c2aa2b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1646,6 +1646,11 @@ The following nested keys are defined.
>  	  pgdemote_khugepaged
>  		Number of pages demoted by khugepaged.
>  
> +	  hugetlb
> +		Amount of memory used by hugetlb pages. This metric only shows
> +		up if hugetlb usage is accounted for in memory.current (i.e.
> +		cgroup is mounted with the memory_hugetlb_accounting option).
> +
>    memory.numa_stat
>  	A read-only nested-keyed file which exists on non-root cgroups.
>  

Definitely makes sense to include this.

Any reason to not account different hugetlb page sizes separately in this 
stat, however?  IOW, should there be separate hugetlb_2048kB and 
hugetlb_1048576kB stats on x86?

