Return-Path: <cgroups+bounces-8282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C118ABE9ED
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 04:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27609179F12
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2A22D7AA;
	Wed, 21 May 2025 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmFt9ScK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C822D781
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747794253; cv=none; b=auJj1g3frOXecqINok6iOBWUlO3fIGEIHxVhUtXN3tb1LXTB6PRlxWjmsrq7q3q2FFRAj9H75/+TZrkTtWjdExuGvUxg6y5719AVnHK9qfAyYUt13id4mPQ+0hEHeLSUbq7gls9oowwEKwBxlu3NwJmXczKId436ypi4KGEZorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747794253; c=relaxed/simple;
	bh=Zep8jUyVWRqWdl1ySZ1IMmitiQ9Bx2l2/3z+6CoOAyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3LUvxUUzK8ldQzTDdWQx7EGDLoU5OdYK/AcbRWknUnN6Xk7Qlb/z6DSgH9YS0CkSfcnZSfS+oaNC5MjxKrvzbV+1l8xwTsDHakcQb8EuT/ByU9EOZ6Vfk/+GXgrwCNI5AGFg6DaQxY/yZMJTkySDup3PJDvZ62E8QdBOif2NPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmFt9ScK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad54e5389cdso559148066b.1
        for <cgroups@vger.kernel.org>; Tue, 20 May 2025 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747794250; x=1748399050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zep8jUyVWRqWdl1ySZ1IMmitiQ9Bx2l2/3z+6CoOAyQ=;
        b=lmFt9ScKg2mDAObDBPeC/K3B5rnuDZUrbDRfLSdN2E2sO9laS009dj/s/zTM90VO5e
         5UFtemsByj0Q0vqqrYWt5dqMGC+1mU25DTYdxbczUPzfrxvPI2nWZw8zjioJptSSBwPG
         TNvJEZzIAZkvZAwA8S2AuY99ZxKGk66KoEsxGKmsgGSAJjw3y2bFk/Xh08rhlHRF1kh8
         GdbXCx0j1Tnp1tWY1SghtiiROGEyPxdSe1+AuaTVuVw1elxE3E7joXkpM+kXNiITOTGe
         oB33KvZ6w0u4jwX8E2pHFSoRe3M5xPnyz9RXSi/Amq10kZY4LDZbmswabKVD5Qff1dBF
         ikOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747794250; x=1748399050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zep8jUyVWRqWdl1ySZ1IMmitiQ9Bx2l2/3z+6CoOAyQ=;
        b=HvS94dhMKnyPvubQP5qRoiQhPr7/DuXdXAV2lCLnwQJI+suJV7aa/uWuH2G9NaTji+
         oAtniB5ujRqg52bjzYe18LgkzreEhnWCQ5EaRaNSHAKbbwP25WefKm/lqQSui2A4TO/a
         cJitUHRKg/KOVdpq8gkmv7JKIM7M+XgVAopMbunMy4BY2MQjbzZBQJwBx06L+F5oylch
         KA/kaKH6NHfeczBNvtDmv1syJpuFD5v/g7PG5DWGA+zzLs9Q3vPkYWSXehZJ78vm67qz
         wnbgDPJzyxbIsRoFjzGqT14MWwZtTX00VJxovnSw5kbh83OBq7u66hgP8WBLWekcWIp7
         9eKA==
X-Forwarded-Encrypted: i=1; AJvYcCUbitSMCAlNBU2OAn7ofGqPOq1lOjRZp596tmlaA+6JgeyyXqMff60Vp6ZsRVB/rh8uiRbr0eyw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xNZK+8+2+VWZKz9uWWRM/F0J037A1oypoBjvh/RFwJfHK2qA
	dgMR7e2eQtcz0del+JNBUuXb6LINDGjOiwKS+x4Np09foqElLTcMVlttiFqUo0YhQcdUYGQpQu+
	9myA1TyCrHeGbIxZ6Zw3AOWltj4tWKEI=
X-Gm-Gg: ASbGncu+zCbquu/z75aGZ51S+9ys6c5HPRtCnjeRHrxEIG2wtj6E1udLF9W/O07s3rJ
	4pYaxwFZY30Srba2DPnZwB/YrFqT7uYRw4mf7290CVbxWiC/hRfL40Hjlp+X4AvOvW8+1dxeVJj
	l3MDxAjX8eV6UaIP0Xw4s2iPhvuJB34/Y=
X-Google-Smtp-Source: AGHT+IEqmUUUARaTWdPbScfW/UOOWhQFAMlTlqruo8FR5l5jgD1WE6rjs2FuMs+sRKIX0Z3QLcywUcEUaMDJj70Wk7Y=
X-Received: by 2002:a17:907:2da1:b0:ad5:7bc4:84b5 with SMTP id
 a640c23a62f3a-ad57bc48ff6mr861511966b.57.1747794249742; Tue, 20 May 2025
 19:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502034046.1625896-1-airlied@gmail.com> <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com> <20250513075446.GA623911@cmpxchg.org>
In-Reply-To: <20250513075446.GA623911@cmpxchg.org>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 21 May 2025 12:23:58 +1000
X-Gm-Features: AX0GCFt2XDDsnmfi-Qx3KaucN19nBAb-rbHv-O-eZqS1qgLB8WI-6u1buY6AC_Y
Message-ID: <CAPM=9tw+DE5-q2o6Di2POEPcXq2kgE4DXbn_uoN+LAXYKMp06g@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

>
> So in the GPU case, you'd charge on allocation, free objects into a
> cgroup-specific pool, and shrink using a cgroup-specific LRU
> list. Freed objects can be reused by this cgroup, but nobody else.
> They're reclaimed through memory pressure inside the cgroup, not due
> to the action of others. And all allocated memory is accounted for.
>
> I have to admit I'm pretty clueless about the gpu driver internals and
> can't really judge how feasible this is. But from a cgroup POV, if you
> want proper memory isolation between groups, it seems to me that's the
> direction you'd have to take this in.

I've been digging into this a bit today, to try and work out what
various paths forward might look like and run into a few impedance
mismatches.

1. TTM doesn't pool objects, it pools pages. TTM objects are varied in
size, we don't need to keep any sort of special allocator that we
would need if we cached sized objects (size buckets etc). list_lru
doesn't work on pages, if we were pooling the ttm objects I can see
being able to enable list_lru. But I'm seeing increased complexity for
no major return, but I might dig a bit more into whether caching
objects might help.

2. list_lru isn't suitable for pages, AFAICS we have to stick the page
into another object to store it in the list_lru, which would mean we'd
be allocating yet another wrapper object. Currently TTM uses the page
LRU pointer to add it to the shrinker_list, which is simple and low
overhead.

If we wanted to stick with keeping pages in the pool, I do feel moving
the pool code closer to the mm core and having some sort of more
tightly integrated reclaim to avoid the overheads. Now in an ideal
world we'd get a page flag like PG_uncached, and we can keep an
uncached inactive list per memcg/node and migrate pages off it, but I
don't think anyone is willing to give us a page flag for this, so I
think we do need to find a compromise that isn't ideal but works for
us now. I've also played a bit with the idea of MEMCG_LOWOVERHEAD
which adds a shrinker to start of shrinker list instead of end and
registering TTM pool shrinker as one of those.

Have I missed anything here that might make this easier?

Dave.

