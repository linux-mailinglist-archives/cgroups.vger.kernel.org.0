Return-Path: <cgroups+bounces-8232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9AAB9EFC
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D3FA23701
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17954192598;
	Fri, 16 May 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uNCl62Co"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF015747D
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407206; cv=none; b=g4dUlBublQxJNvOVZefsXmDli2CPd+L/qacVvK+dHaXOZxJK1IRZDnr+GEeHy67tmOswVSLIiXvTEnTZ9b39X/DDsZMudFHjAI6uc25w0bDl5odrq6WzAN6GxoC/IQzqc/g7hI3xVNoYmqkP9GQ0c7iUsVyWvleSJGTgDCvj3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407206; c=relaxed/simple;
	bh=4CqNQ/jxVOM4QCH8raEcQOueeBldQirrU5mHGYUGsqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmG+/lRWGXcQDIN2FK7lkL/ygiPopufJwWX1HF6PdO7kSBPYyl3B2oql1SuNYzHhiLJXZfQwNElUBXiBEr1nJ/e+ujDfuvKebeeti/liIeBQL0qvkd8Dx036bdJ3lKbwZ1KEkXGn2oLgcobGwGQzDfVrr49hqbRFv+r3XW60H50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uNCl62Co; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-477296dce8dso25631331cf.3
        for <cgroups@vger.kernel.org>; Fri, 16 May 2025 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747407203; x=1748012003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3liem+b8cA6/TclhL8mCksvmZ3Emi9zqV78pGY0077E=;
        b=uNCl62Co4H2mEKaf9yiAYc9iffwds9ynCOeks6v7ev6iXPUrA+ZSU8YI55tgNyH+uj
         GuPDUuA9dXE6FRnBJHOBkBf5lmw+825RjYTqvL8sIT23g2fRbpnSaLsobrrSHXbJS7Sq
         svHjHqR90OrV051z87AOMAxulBPHPxmkTCg1wLpoDhfr+t+hdzizQ7YDG2xGgmfZ8+xZ
         82q4pFRfKTleeICPAfh4QRgI6OFSos3TLqfp6pqcFtQ/PetcrLs9Y4kZwwUf0VMpKQHX
         2cZaHPz2+WwM/EcRPgaYbtuj89aAt9+tr7O2tDUuH2xcwCqJCzJ0R0EJlogYn0BQEfmg
         LQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407203; x=1748012003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3liem+b8cA6/TclhL8mCksvmZ3Emi9zqV78pGY0077E=;
        b=IFY2HzR/fyjDDV2qoA9kaPPsQKG1Smvm6YaixeQ83+U3a1rdsG1FM3gbjZqsYC4woB
         mfJzN9K6ReX60VMFGponD+6qt0aCfuqo+8N72/wOyz02t6UajOORLScK0MyPOmZem8sf
         ew9fYxRAHEeaW2QFB1C8/fR9Tnj9rjHF4j0eGb3xcjeminOlvnsf8SkAStMQ4fDhXoyL
         R0qRdQTBOp5/fC5aefLDOwaDcS80TpBrcY18sDghnX1IUVzHdQS+R353Cu5HY4HVg+A8
         YiBouwqo+UkHADG/hSQCNBAk6N/Qx2Im8X+X1hcV1T8HbC0olf7ef9H6bG9H7Wwbx/wR
         +9vA==
X-Forwarded-Encrypted: i=1; AJvYcCVPlhA08LvSprh4sKmZenZFOmY7q0kdAGtL+ebmslSqXG+2JenZR66AYPAwll5FsD7u7fkZaky/@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcYjmbZ8FxqO4Zh+qV1eexDCVdKkHsfFzbBxg4OuuV5yHH4Ju
	/gxdGHd5igCCFE47VD3QvfnkvnGLlRzSpwEvfydBplwwCfLYo+p4prF0w2XbLDRGCKg=
X-Gm-Gg: ASbGncs10SViHIQxNDMbER3HUJrEhxW9pA8BguOAGuKH31IQOOPJ9BPLXpVf+dL08qz
	KmRZxJ8lvNqQw+eomM3LbvvXH4iAVG5ZyrO3QA746nmAtGj90HvrEG0NNw/eSfTS31TLLJzwb+G
	qvXA5SSlWUufStiu6+bw/0KsG9c6eZZpCHCq8uL3xy4xR7ouTez70nHoIPYUmItB2IMqiO9Q+gV
	qzbY9eVU4RXabfCwswed3lj/u43VeV3HdOA4hGs7RT+FS+GbVCubd3gLIM28Vd2qeTYQdYicAac
	Yhmvr4XM1luvQa65LE6uT7cxjw0gE2JhRmgOZ6bfaT/N21xwkQ==
X-Google-Smtp-Source: AGHT+IE+hsSXV2yOA3E29yMTb4jXX1JHyTjCK/nx4iWIkVhTsLBzrdfnwNkfb3Re37+s7+VAS7UBUg==
X-Received: by 2002:a05:622a:4d05:b0:494:9908:d74d with SMTP id d75a77b69052e-494ae42d2aamr71668301cf.37.1747407203025;
        Fri, 16 May 2025 07:53:23 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494b8fa2cebsm3107461cf.34.2025.05.16.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:53:22 -0700 (PDT)
Date: Fri, 16 May 2025 10:53:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250516145318.GB720744@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
 <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>

On Fri, May 16, 2025 at 08:53:07AM +0200, Christian König wrote:
> On 5/15/25 18:08, Johannes Weiner wrote:
> >> Stop for a second.
> >>
> >> As far as I can see the shrinker for the TTM pool should *not* be
> >> memcg aware. Background is that pages who enter the pool are
> >> considered freed by the application.
> > 
> > They're not free from a system POV until they're back in the page
> > allocator.
> > 
> >> The only reason we have the pool is to speed up allocation of
> >> uncached and write combined pages as well as work around for
> >> performance problems of the coherent DMA API.
> >>
> >> The shrinker makes sure that the pages can be given back to the core
> >> memory management at any given time.
> > 
> > That's work. And it's a direct result of some cgroup having allocated
> > this memory. Why should somebody else have to clean it up?
> 
> Because the cgroup who has allocated the memory is long gone. As
> soon as the pages enter the pool they must be considered freed by
> this cgroup.

Nope, not at all.

> The cgroup who originally allocated it has no reference to the
> memory any more and also no way of giving it back to the core
> system.

Of course it does, the shrinker LRU.

Listen, none of this is even remotely new. This isn't the first cache
we're tracking, and it's not the first consumer that can outlive the
controlling cgroup.

> > The shrinker also doesn't run in isolation. It's invoked in the
> > broader context of there being a memory shortage, along with all the
> > other shrinkers in the system, along with file reclaim, and
> > potentially even swapping.
> > 
> > Why should all of this be externalized to other containers?
> 
> That's the whole purpose of the pool.
> 
> The pool only exists because the core memory management can't track
> the difference between unchached, write combined and cached
> memory. It's similar to moveable or DMA/DMA32.

And because of that, in the real world, you are operating a
shrinker-managed cache for those setup costs, yes? And I explained to
you the implications and consequences of that.

> > For proper memory isolation, the cleanup cost needs to be carried by
> > the cgroup that is responsible for it in the first place - not some
> > other container that's just trying to read() a file or malloc().
> 
> That makes no sense at all.

How about we stay in our respective lanes of expertise and find a more
productive way to get alignment on this, shall we?

