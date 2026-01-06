Return-Path: <cgroups+bounces-12932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6890ACF7C87
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF2533015AE2
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00204337B9C;
	Tue,  6 Jan 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MTmd0Lhv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0403376A1
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695166; cv=none; b=miZ/9bw0dm5ZsVNrkY5/7yQ/O9cKiHpG95eMMqoymLJVn8wDasJcB0LNac6K8GpzJYwqx+YnVxFRrOwdKn6mmNCrng1w+veyGzLrjP1xzeEjk+m8HBAp+7Tu8nNyHibsW9enjEazrOtQLXJs1FSuDFlmGVk9UDpt1j0f2Tl+Bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695166; c=relaxed/simple;
	bh=AaFPGrqWLPKAMN+xtCBNy3vJEkpmfJZ2G74GxmBelnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByQfDfIwkP2nLBmkfDtKW8jQ0D8frczlmBb4v3mPY34l0gkaOe1GmgpUM1mxwKhEr1iSZdn3jDUt341nGBfTZ3PJv0SoC60qsg4SXUxxsb52nWrUOimOcw8a1ShK1sOZNpxR6b7MraZhvIXaqacKpCSe1B/OaVHHE19BhQ+4XKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MTmd0Lhv; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso5815335e9.1
        for <cgroups@vger.kernel.org>; Tue, 06 Jan 2026 02:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767695161; x=1768299961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrYlgSs3aSLf4OO6JdIXAa9ZB/yG8lk++eER1aaE778=;
        b=MTmd0LhviehGKCFFyXPkRG9TmpIJwnCk6+yGlBVips1JPni3VRBCsXobrqjv9f/qDr
         ThBWM0T24jNgg+pUlsmzJJkF9wfGd/v56ggLehL6aNSgNKulh9MGmBfRBoVNmb+QpU82
         d/cV+3jso8Peylu+LT1B8rNedQWnohrhrlSWegYigGNLi/QcX9L8Jv9GdYG9wswDO5fL
         9/MGETerdl854N85tsvkQQaS1ivRFqIF5A6D5MZOqdGoidXHY0M9RNSepDdI2ZqfewX7
         NHAgeEblopxhus4BNu9z46kbXWng0to/PJsDjlal3vpLXBXXQ4diB6Mdx0fSRi4nnSlM
         PAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767695161; x=1768299961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrYlgSs3aSLf4OO6JdIXAa9ZB/yG8lk++eER1aaE778=;
        b=RO8ooQd3CiXC11bc0g8acdF9phWebpUfE8/Xb1k/U88MtLLBSRW5XfZYMmtSrgpId6
         XF5Pld392T4xAZzXiwLkvrhCyHLDoJtkfa0wCvY37dHb4xH27tHxdPWyN4ON7W58z1s5
         YS6UEE6+jirfofxo7x0iz475+EP6S3oyPz8eOhJPhpkKiuyzscpWsUk70AYWeSg3u7QI
         25m8df0hQAsIEDhjTo6Y0+GoSAeByuTjJt8Q85UCWdQYUrWCVwZ6uwr2P0UU3N+5Agn8
         7xpm0RMH8Cm5j5Wp72BTFwLRtEocUX17UUqtoDouCeqJy2ktFqUMGv68S08Id1WpAqLs
         N5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHcanXnaxRJGcKpmQoUbUIj4ZPldyKVUjyy8Ejqz+gPvatXo/7vYhAoWBBsceqHZDIbcwgt69A@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXPFmZB7n9WcM5SfkXGVW3aEmnxNu7O7e5va+1T3eLuJjsQ96
	AdYtQdZMXSfaQNNGlcXVz+ch6/htxfh4l5lDZE6Tq5SQqk8XboPaPpT+raCHban598w=
X-Gm-Gg: AY/fxX5uzpvoOtwlacCf0owwHHSCx8vgzLOIC7RZcYE7cwvtMPY0HjYjMGGrBw85WEB
	ewwA8I33eiNnmJ6LU7SFXNowjKPUVx7cpgYGCCpDEYPmfhYLKKiRP9zech4WNNjYGjP1ByvwBvc
	PHO9UANoCSfj65k0XeGdXAJmMxmCCitMjBM1Jz+6PF85kJgqyZuX4ymc2LjhWRL4NhgM8nmAhnE
	jp7W1MGlhBtuIC8xGN5et+rYSufCEpRtT0QxsD8tqJ3YCTpjgF6bsk48JM3rgqPerpKX/pcITYl
	opWeplJXQ2hsAu50vXVJ9dZqAJy/yWDKxPwqa3pFvgpUk2RXwZw/AugFg+4h4CoJEOnqItTnwIV
	n5B1EuH7hX6EOq+KATkVAn6PRIegjSIA3nnOJvi8KsDN4EU9Bmaho34S5A6TLi8Co8oz5X16ISb
	Z6NjKRYPYY2P0m/WKsrsiyECeWaDPo/wwfrpI=
X-Google-Smtp-Source: AGHT+IFb++SFH+rzxjUyOLzVtbAwCNpIM3DiqRn405rjEU6hdyHt22A9JWXC6Ev1mua/rT+52Ubpuw==
X-Received: by 2002:a05:600c:3484:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-47d7f06dc14mr27492355e9.8.1767695161240;
        Tue, 06 Jan 2026 02:26:01 -0800 (PST)
Received: from localhost (109-81-90-116.rct.o2.cz. [109.81.90.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm3571930f8f.21.2026.01.06.02.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:26:00 -0800 (PST)
Date: Tue, 6 Jan 2026 11:25:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] memcg: separate private and public ID namespaces
Message-ID: <aVzjN5z3w114fNB4@tiehlicka>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>

On Thu 25-12-25 15:21:08, Shakeel Butt wrote:
> The memory cgroup subsystem maintains a private ID infrastructure that
> is decoupled from the cgroup IDs. This private ID system exists because
> some kernel objects (like swap entries and shadow entries in the
> workingset code) can outlive the cgroup they were associated with.
> The motivation is best described in commit 73f576c04b941 ("mm:
> memcontrol: fix cgroup creation failure after many small jobs").
> 
> Unfortunately, some in-kernel users (DAMON, LRU gen debugfs interface,
> shrinker debugfs) started exposing these private IDs to userspace.
> This is problematic because:
> 
> 1. The private IDs are internal implementation details that could change
> 2. Userspace already has access to cgroup IDs through the cgroup
>    filesystem
> 3. Using different ID namespaces in different interfaces is confusing
> 
> This series cleans up the memcg ID infrastructure by:
> 
> 1. Explicitly marking the private ID APIs with "private" in their names
>    to make it clear they are for internal use only (swap/workingset)
> 
> 2. Making the public cgroup ID APIs (mem_cgroup_id/mem_cgroup_get_from_id)
>    unconditionally available
> 
> 3. Converting DAMON, LRU gen, and shrinker debugfs interfaces to use
>    the public cgroup IDs instead of the private IDs
> 
> 4. Removing the now-unused wrapper functions and renaming the public
>    APIs for clarity
> 
> After this series:
> - mem_cgroup_private_id() / mem_cgroup_from_private_id() are used for
>   internal kernel objects that outlive their cgroup (swap, workingset)
> - mem_cgroup_id() / mem_cgroup_get_from_id() return the public cgroup ID
>   (from cgroup_id()) for use in userspace-facing interfaces
> 
> Note: please apply this series after the patch at
> https://lore.kernel.org/20251225002904.139543-1-shakeel.butt@linux.dev/

Makes sense to me. Originally I was not supper happy about the private
interface as this should be really private to memcg proper but then I
have noticed the lru code needs this outside and dealing with that would
be quite messy so an explicit name is probably better in the end.

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> 
> Shakeel Butt (8):
>   memcg: introduce private id API for in-kernel users
>   memcg: expose mem_cgroup_ino() and mem_cgroup_get_from_ino()
>     unconditionally
>   memcg: mem_cgroup_get_from_ino() returns NULL on error
>   memcg: use cgroup_id() instead of cgroup_ino() for memcg ID
>   mm/damon: use cgroup ID instead of private memcg ID
>   mm/vmscan: use cgroup ID instead of private memcg ID in lru_gen
>     interface
>   memcg: remove unused mem_cgroup_id() and mem_cgroup_from_id()
>   memcg: rename mem_cgroup_ino() to mem_cgroup_id()
> 
>  include/linux/damon.h      |  4 +--
>  include/linux/memcontrol.h | 26 +++++++----------
>  mm/damon/core.c            |  7 ++---
>  mm/damon/sysfs-schemes.c   |  6 ++--
>  mm/list_lru.c              |  2 +-
>  mm/memcontrol-v1.c         |  6 ++--
>  mm/memcontrol-v1.h         |  4 +--
>  mm/memcontrol.c            | 60 ++++++++++++++++++--------------------
>  mm/shrinker_debug.c        | 13 +++++----
>  mm/vmscan.c                | 17 ++++-------
>  mm/workingset.c            |  8 ++---
>  11 files changed, 68 insertions(+), 85 deletions(-)
> 
> --
> 2.47.3

-- 
Michal Hocko
SUSE Labs

