Return-Path: <cgroups+bounces-3938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8494055B
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 04:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F3128587F
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 02:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A72BB13;
	Tue, 30 Jul 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VLvr3CoM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3180A23
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307132; cv=none; b=FPZGilQb1UZ9OBDZYVFRJyWzRts6s0oyxOYi8kQBXKhK8DB6fgZbbb0fa/LYZohbxJbaw/HnC7uqQBcz5xmUGobW2lf2Q0DyDLjdjqTjg7M1si9FuaRm7up36vw5MPxRbENIdg2fqaT9R9nu1Jia0uFva9mLoD0FeUBoCpFlVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307132; c=relaxed/simple;
	bh=PavMPhXq78uOF4k0sgCk8akNMjXYQvjNvBovwxo8Odk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/oZETxvv9qT6TwtSnB3fdhYH+NmG6NsekYVIJ8u3pF/UKzamvOd/xMF1afX5wLYYHe42jb1+64niTN9vNepTecCmC9DsB5zKTRBFDwiGDDBoVE2Fki2XgotiNMg4Rj31VhrkPb0R+4t4aaoupmXS9Foy/65AD+cphhwQzsALy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VLvr3CoM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d7a544e7so294417985a.3
        for <cgroups@vger.kernel.org>; Mon, 29 Jul 2024 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722307129; x=1722911929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyUDu60PCAuM2zRNcpq+Dc/3a1+n03wqWjS5ucpFVHU=;
        b=VLvr3CoMSDvqRig03XitVFRaBJ3d9K5FHnK+YpwUlGEgkuKC2IkVszxA3DrY9wMai1
         L1iiaHO+imyUdj54mBlP+vfBXUVns8bzCRy2qSoF4l4yAUzXqceVxmSasG+AMtRUlQXj
         rtxdxINXk7BSc6qXf8G9DiERIurxUcPbx8+q3BvKH0vcwDPy37ft8fswC3KHgKxVtUL0
         o2ZeZ1laqFAlBpot1Lk5rgGE4xJiUMCmLZT7bAxAiKHv6Y/IFmyDqB5PlSV+JN+feYnp
         mUEKpV1AWelD9YNy9hxx67BzhUf1A1NV9Ry0POh0Rg0mToEvIwx1SXiU16PPW9hhsxmZ
         VjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722307129; x=1722911929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyUDu60PCAuM2zRNcpq+Dc/3a1+n03wqWjS5ucpFVHU=;
        b=Y/zrdx0EufTNS8B7JrT5MCU2eyrIxmW6kJXrdHQ36r7Mo6NMiXHAXQhDlrBqkxGmlz
         YPrzUdWZQQDzgHqdLULjjHRYXyba4ic+ZqDpUuryBUbXb0rNApV1zuYXvGNwXegEGjoG
         YNP+s3JQtJHpDMx4CN2GMk45fSPe8EIfcSxOq2oHBdYhjOj/kZoW9M8hWrvUubOlvGC3
         8EyVwqTWbmDZqqlWgMDT+dp7sx0LBpjntuHfx78USMWq6tRIXYCVEksOecuziWrLNnzh
         2EL++u9SRHdgbfCk+cmcbyHu5eC4PPlgQfbviYAyrxIe4AyCrQtpbrHRtrns7q7lsbBn
         M16Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxYOmlCLipElmcpgNjMlU1HGCdy8gzFz60uwjfqWvUAy8hhaZlNlkWzBBCSPjQ0/TnSHdckjivm6LwbUnh6TALDk3oGLVybA==
X-Gm-Message-State: AOJu0Yzb2eCeJo/lrH89xD31Mce2L2BG/1a/voY3kp54/yvZlF/Lf4ry
	EQSP+vNC/Yg9XIINXwgThKm84cgh9NPU0DI8+LpnnuBkr9YprAuubwsjzaZdBfw=
X-Google-Smtp-Source: AGHT+IFUGolmZq/G9ttSj13GVAYbDNH+XIHcDQUS+VIQDesWEnVNI2yCkrS+idWQDi7u+ZKdaSWM4Q==
X-Received: by 2002:a05:620a:1a1f:b0:79f:709:a38e with SMTP id af79cd13be357-7a1e524c72bmr1260215585a.19.1722307128647;
        Mon, 29 Jul 2024 19:38:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435509sm592811485a.84.2024.07.29.19.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 19:38:48 -0700 (PDT)
Date: Mon, 29 Jul 2024 22:38:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <20240730023847.GA2866591@cmpxchg.org>
References: <20240729143743.34236-1-davidf@vimeo.com>
 <20240729143743.34236-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729143743.34236-2-davidf@vimeo.com>

On Mon, Jul 29, 2024 at 10:37:42AM -0400, David Finkel wrote:
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms, but with a less racy API.
> 
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
> 
> This change is an evolution of a previous patch, which mostly copied the
> cgroup v1 behavior, however, there were concerns about races/ownership
> issues with a global reset, so instead this change makes the reset
> filedescriptor-local.
> 
> Writing any non-empty string to the memory.peak and memory.swap.peak
> pseudo-files reset the high watermark to the current usage for
> subsequent reads through that same FD.
> 
> Notably, following Johannes's suggestion, this implementation moves the
> O(FDs that have written) behavior onto the FD write(2) path. Instead, on
> the page-allocation path, we simply add one additional watermark to
> conditionally bump per-hierarchy level in the page-counter.
> 
> Additionally, this takes Longman's suggestion of nesting the
> page-charging-path checks for the two watermarks to reduce the number of
> common-case comparisons.
> 
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.
> 
> Most notably, Vimeo's use-case involves a system that's doing global
> binpacking across many Kubernetes pods/containers, and while we can use
> PSI for some local decisions about overload, we strive to avoid packing
> workloads too tightly in the first place. To facilitate this, we track
> the peak memory usage. However, since we run with long-lived workers (to
> amortize startup costs) we need a way to track the high watermark while
> a work-item is executing. Polling runs the risk of missing short spikes
> that last for timescales below the polling interval, and peak memory
> tracking at the cgroup level is otherwise perfect for this use-case.
> 
> As this data is used to ensure that binpacked work ends up with
> sufficient headroom, this use-case mostly avoids the inaccuracies
> surrounding reclaimable memory.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: David Finkel <davidf@vimeo.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

