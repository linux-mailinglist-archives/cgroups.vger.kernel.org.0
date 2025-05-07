Return-Path: <cgroups+bounces-8057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F7AAD83A
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF823A31AF
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926621A952;
	Wed,  7 May 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+IAQNv1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C791DE3A7
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603021; cv=none; b=dPPjjnixHtgKJzycq5ed6CkF3a91J9I/oZMkofj0IpHvlkwtHSwKaUp15352NnNKDiifILuuGoDcwOkHlfeuU4ybg0Lo78Nr4BPS+1s1CMYiD7w+e3dWhIMHfiH6NejR6HcLAS5rU79743uGa9IrDQWuL0Yw2Me+o30WtSNcWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603021; c=relaxed/simple;
	bh=mxOCt6r8dMXXF8BI8yGOpQKEl8akEH/Tk/ST6h75VNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IChy9cteVdNAhUacRBMNeoefR8v1cRjqLIdeXP/R4az2WYYqhLo1m+WdTTjsXkeTQnduRnGT9vVJXVx9Ru/zYGWKRwwbWgD5nvYty/zJAxogZiE696dt89ENTC7Gcl2XjiKW1QFKNt1GyzA7gTrPlNc4G5yBKOMVbK8mlkYjjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+IAQNv1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac289147833so1194221066b.2
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746603016; x=1747207816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FUcSqGima0N93ktxJzZwEEa+6e2a/wBilAPnrzIPDEg=;
        b=P+IAQNv1w9zC5RgPKSyKEAshrNq4Qj26AAyG8xFzZfbOHbCuoHQqtkXYhnvF/5k46t
         i9i2alUD/kHkaQkEMaAkodxX5iqaOGpEwlAL3tW3WolPskhhx2k+r9PtNmYRTrlYm4PW
         3vuRp4RVSMR9q3X9J1QxV8QclNlQDxLSw3Ral4p8HvvDCVCuZOcUxRErk4zPLvpnn2Xi
         7XjnoiKUJku0aNkZ8vOOD1SQ8ltNOgNhva8NN9RVTua0/Et7zSIW2Xtp1mXFC4VjEj7V
         OAss83Y3ivMBQcz9YGXPEcFzymkM+IOeq7tsYi9SV1s/iX3F+z9VyRUrJIMuxUx6LW12
         CrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746603016; x=1747207816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUcSqGima0N93ktxJzZwEEa+6e2a/wBilAPnrzIPDEg=;
        b=S9Y0WPyT6c8ZTeb7mdCtH/jDOoqHH04L7r1rqtpI8zz5NWdmOfOTtj6L6XYyw67LVW
         8FNAtfQ2WpqWd/jibYIZK2X5EZ4og+5cd7giYYI5YPEIVSDrFKi+SXQZDLJtQzH55V2s
         id8OEi7vOirLLdHpXb1yIxOPDWUOsDz1tANUW9Wm/u2gZuZRJVy50yyc77k/rC4YLIXj
         7syafFwXOBA3n+PqgWXfmtauCgV/wGCwg6WaYhyLlYcK2gwXN3rNYLBhCd3cChiWFPsW
         7pP2Cre1oOtWo1PKrUpNvEXTvPSEPEtgq0LK3DTxNDUQdjmCzY3Fm8KYkmVzs/vlQ1qG
         tn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZCHjvvAYsQ4OOBtz8VBzfGWfjVnow7qkxXX501eXp3RUQo9T2y+O+IOrwH9LnGG7s+EumjqAe@vger.kernel.org
X-Gm-Message-State: AOJu0YytEN/PizW/egwhdDskmoW1G4N5lJgTiS+26uHo6LR3kicQC2cJ
	gpkmvAf8OEACVA8BWhFDFkM1Tqx1YD3zhzB8wuHoVIGXbpTIMYmmd2hEC/J1dUc=
X-Gm-Gg: ASbGncu82WxbXeuluqvN8SAkxV7QU8qjBss2gwasiLoCK991YjIQ/0LcFqtaDW4QEEw
	CBLw7TAmAnf/MamxYdHYh0Cc1INhBhlSpwP4v+yDiES4FqSNjJ/adhLZv8fSsiUynGa6r/dkzd2
	uvUlaSvlOkMQYLtqEu/rFGstzGUNUeighnu884QCeEvBUaQUBxRQ6FWyQRGPmZr8VHT7nYUAlcY
	vK3NFkzuaiB4+1/FrW5dVWiJN6iYHBuQhklqiGn0xyaBMPKIKA3gDCq/Q8lX6/zSv5hh3opMNNj
	Ho+lI6O2SZkz0O4lOGKPU4jDCwsM0z4=
X-Google-Smtp-Source: AGHT+IHqKJq02AuZsFAg2B/0m60918EK+9L4EdzuO2FhU+iMmip8U73qvmZiflX/x/5tz03zWRyg4g==
X-Received: by 2002:a17:907:8d85:b0:aca:cac8:1cf9 with SMTP id a640c23a62f3a-ad1e8ce4638mr216327466b.33.1746603016054;
        Wed, 07 May 2025 00:30:16 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad1891a2515sm862828966b.39.2025.05.07.00.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:30:15 -0700 (PDT)
Date: Wed, 7 May 2025 09:30:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Greg Thelen <gthelen@google.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] memcg: introduce non-blocking limit setting option
Message-ID: <aBsMB3oes6Kn0TEl@tiehlicka>
References: <20250506232833.3109790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506232833.3109790-1-shakeel.butt@linux.dev>

On Tue 06-05-25 16:28:33, Shakeel Butt wrote:
> Setting the max and high limits can trigger synchronous reclaim and/or
> oom-kill if the usage is higher than the given limit.  This behavior is
> fine for newly created cgroups but it can cause issues for the node
> controller while setting limits for existing cgroups.
> 
> In our production multi-tenant and overcommitted environment, we are
> seeing priority inversion when the node controller dynamically adjusts the
> limits of running jobs of different priorities.  Based on the system
> situation, the node controller may reduce the limits of lower priority
> jobs and increase the limits of higher priority jobs.  However we are
> seeing node controller getting stuck for long period of time while
> reclaiming from lower priority jobs while setting their limits and also
> spends a lot of its own CPU.
> 
> One of the workaround we are trying is to fork a new process which sets
> the limit of the lower priority job along with setting an alarm to get
> itself killed if it get stuck in the reclaim for lower priority job.
> However we are finding it very unreliable and costly.  Either we need a
> good enough time buffer for the alarm to be delivered after setting limit
> and potentialy spend a lot of CPU in the reclaim or be unreliable in
> setting the limit for much shorter but cheaper (less reclaim) alarms.
> 
> Let's introduce new limit setting option which does not trigger reclaim
> and/or oom-kill and let the processes in the target cgroup to trigger
> reclaim and/or throttling and/or oom-kill in their next charge request.
> This will make the node controller on multi-tenant overcommitted
> environment much more reliable.

I would say this is a bit creative way to go about kernel interfaces. I
am not aware of any other precedence like that but I recognize this is
likely better than a new set of non-blocking interface.

It is a bit unfortunate that we haven't explicitly excluded O_NONBLOCK
previously so we cannot really add this functionality correctly without
risking breaking any existing users. Sure it hasn't made sense to write
to these files with O_NONBLOCK until now but there is the hope.

> Explanation from Johannes on side-effects of O_NONBLOCK limit change:
>   It's usually the allocating tasks inside the group bearing the cost of
>   limit enforcement and reclaim. This allows a (privileged) updater from
>   outside the group to keep that cost in there - instead of having to
>   help, from a context that doesn't necessarily make sense.
> 
>   I suppose the tradeoff with that - and the reason why this was doing
>   sync reclaim in the first place - is that, if the group is idle and
>   not trying to allocate more, it can take indefinitely for the new
>   limit to actually be met.
> 
>   It should be okay in most scenarios in practice. As the capacity is
>   reallocated from group A to B, B will exert pressure on A once it
>   tries to claim it and thereby shrink it down. If A is idle, that
>   shouldn't be hard. If A is running, it's likely to fault/allocate
>   soon-ish and then join the effort.
> 
>   It does leave a (malicious) corner case where A is just busy-hitting
>   its memory to interfere with the clawback. This is comparable to
>   reclaiming memory.low overage from the outside, though, which is an
>   acceptable risk. Users of O_NONBLOCK just need to be aware.

Good and useful clarification. Thx!

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs

