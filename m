Return-Path: <cgroups+bounces-9795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14B1B49F16
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727707A7F71
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CBA23BD1B;
	Tue,  9 Sep 2025 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBjA/9Fe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A909219A86
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384353; cv=none; b=Eq/GYTmnmfmgE605PU3Orkb+Mlo7YYyYhaAWp1pd034FdtDcIPQNijVaqnneFNknT0+1jNH0GYI90ldyAQcO0gpfBA+OlWyT1l6y0QjE9qhg9RKyQd5jroZHL/p31NGg1fMtYFYlUQz3IEpd7BnGxX08Fq6DZLVNCf6CuA2rCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384353; c=relaxed/simple;
	bh=MsrE6nlcLsu6rE7UEvRi+H5Bk3kjBIHF5hr3fsf6aB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2WtWq60lbjif+zAqVwzD0YClBZJMbO0lo2uayE1ru35i7UFwNwtMSaEcyJOrnpo0QVsqKwZ7APzR3COHqwJfocqFU/552D5CUK2mmKNPs6V+FLkIF7v/WJVu0hBCxSjM3RAxDhlaEAIPn3hhBYWB3/Csr8rG0wgyOS4KAvrHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBjA/9Fe; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0418f6fc27so840851766b.3
        for <cgroups@vger.kernel.org>; Mon, 08 Sep 2025 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757384350; x=1757989150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvRPKCJK+kNCgeqO86d67tqhHi9R/WWb/GxxGuL8x0w=;
        b=QBjA/9FenS9acC6YTxJwyr1iBk95Ts+GbVVuYUxHCu1w5FY63PbjeyB7OY4mWpOYQS
         SgaY4l8s9c1yJ92T57/osym8vx2LV8BQsBF1YeTa3rQIUUKR+ixgxfRV7MUjeYK5COIG
         ibfOOiOEpLySRTnz/rhZ4AC/RNwuSmvRNeGgFnbDTpTG7kfmU03jrYhQjR4J/reNeOTn
         yANRve+6K0UlyciVFWIYCZ67UluM7qg/4Bq9/kd2R2/v+jTocOds2LGON+cZTNz18u69
         r1HABgCAzxYjwhUUET7czVaGkYcFiH4C7J5/ZHNvFItTotBbJPu9V/lFEG8Gt3SgpMwm
         PE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757384350; x=1757989150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvRPKCJK+kNCgeqO86d67tqhHi9R/WWb/GxxGuL8x0w=;
        b=BxrSFnlebdRrLWgD8yFagfNZet+p5VwPYe9rn2tO51ETFSb8aTdni+IZ/XTGhs/Hta
         ozgNa7wKFgKvDBXQJfuGgmG6iCnuRfhu63ETn9ySUc/s2nmAzFiUBec3uGFfMvPMSMta
         xHIF9GZ87RfeMLZcYE+iaXceQ20AgbGaJ2YKxLgoZ1F5PZjrS2KpUCFMWj2LuNDG3fx2
         l5HO6vXJ/uOBLSF7WcpOV0O3rGjjvxq77wb6OAigd+qAu2KoOeZvfeO7aBvVnTyzAVE1
         QuRvCLwct3XVFRxKCC8PXmIdTIGbgNZMSeggoog40PGriHA/0uUtmHNrqOjUqvqJRWM7
         KJSg==
X-Forwarded-Encrypted: i=1; AJvYcCX0mML39trkDz3TvBqTS/h6vk52+Ak+JtH76HuN4Zc6H4qpUMmXqjpk7zQqrLzEOV/hmiPLHdZw@vger.kernel.org
X-Gm-Message-State: AOJu0YwItMSaZQ6ie4IkIJsieqPQ+5yy2SkbHqlWKo3pqVquBbR8UtHx
	R46Ocl6cbPYj6xWDdSOLN2FFsBqwHGIXHKLGb6HQvrTL61klM/XvB21SO+j58D31YFFSXtNZ+uH
	bp5XUQua8xIAaK+XwSDt4+DHuCinuhYs=
X-Gm-Gg: ASbGnct4y8V8vMiCKU1yv3WABpvA9YzKXiq5PVZ2u6DVarlZRZHlbPLgJ8IL3DOqp3D
	wxqNAUNncK8Bhwe7lmhcewyRMMsJnEMJKNvTHX/tmad7sA0GcHhrAKeWndKI5q1l4/Mxq2ab1vZ
	FaHV3eVxt5q62tXaFCr7xGA9FNXXN0sdCZeCeyITC/rNA9z+xgP+Ub9rZm+wP4HyIr0/5i/0lNS
	JHyYQ==
X-Google-Smtp-Source: AGHT+IF0ojGfLsVbNe2EXxxIANSe+zd3BuP0PWTFJD+VmQrDZcvpCqFTs1wan4o9XVQtoEf8UmOwBUP1Pb9fXf0w0AU=
X-Received: by 2002:a17:906:6d4:b0:b07:6538:4dc5 with SMTP id
 a640c23a62f3a-b076538667dmr149881366b.64.1757384349488; Mon, 08 Sep 2025
 19:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902041024.2040450-1-airlied@gmail.com> <20250902041024.2040450-12-airlied@gmail.com>
 <4e462912-64de-461c-8c4b-204e6f58dde8@amd.com> <CAPM=9txiApDK8riR3TH3gM2V0pVwGBD5WobbXv2_bfoH+wsgSw@mail.gmail.com>
 <f4d04144-d8e7-4d4e-81a9-65e1fcef26fd@amd.com>
In-Reply-To: <f4d04144-d8e7-4d4e-81a9-65e1fcef26fd@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 9 Sep 2025 12:18:57 +1000
X-Gm-Features: Ac12FXxS3xUS5G2sDvkGWbEQ-36qve91eBxiVAMCJmoW1HsflS2lot9U-Pu8uuI
Message-ID: <CAPM=9txzf8OfyQ79X29iC0s_QqaNVPfPsAFbRw056Zsjvb2iTg@mail.gmail.com>
Subject: Re: [PATCH 11/15] ttm/pool: enable memcg tracking and shrinker. (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Sept 2025 at 21:30, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 04.09.25 04:25, Dave Airlie wrote:
> > On Wed, 3 Sept 2025 at 00:23, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
> >>
> >> On 02.09.25 06:06, Dave Airlie wrote:
> >>> From: Dave Airlie <airlied@redhat.com>
> >>>
> >>> This enables all the backend code to use the list lru in memcg mode,
> >>> and set the shrinker to be memcg aware.
> >>>
> >>> It adds the loop case for when pooled pages end up being reparented
> >>> to a higher memcg group, that newer memcg can search for them there
> >>> and take them back.
> >>
> >> I can only repeat that as far as I can see that makes no sense at all.
> >>
> >> This just enables stealing pages from the page pool per cgroup and won=
't give them back if another cgroup runs into a low memery situation.
> >>
> >> Maybe Thomas and the XE guys have an use case for that, but as far as =
I can see that behavior is not something we would ever want.
> >
> > This is what I'd want for a desktop use case at least, if we have a
> > top level cgroup then logged in user cgroups, each user will own their
> > own uncached pages pool and not cause side effects to other users. If
> > they finish running their pool will get give to the parent.
> >
> > Any new pool will get pages from the parent, and manage them itself.
> >
> > This is also what cgroup developers have said makes the most sense for
> > containerisation here, one cgroup allocator should not be able to
> > cause shrink work for another cgroup unnecessarily.
>
> The key point is i915 is doing the exact same thing completely without a =
pool and with *MUCH* less overhead.
>
> Together with Thomas I've implemented that approach for TTM as WIP patch =
and on a Ryzen 7 page faulting becomes nearly ten times faster.
>
> The problem is that the PAT and other legacy handling is like two decades=
 old now and it seems like nobody can remember how it is actually supposed =
to work.
>
> See this patch here for example as well:
>
> commit 9542ada803198e6eba29d3289abb39ea82047b92
> Author: Suresh Siddha <suresh.b.siddha@intel.com>
> Date:   Wed Sep 24 08:53:33 2008 -0700
>
>     x86: track memtype for RAM in page struct
>
>     Track the memtype for RAM pages in page struct instead of using the
>     memtype list. This avoids the explosion in the number of entries in
>     memtype list (of the order of 20,000 with AGP) and makes the PAT
>     tracking simpler.
>
>     We are using PG_arch_1 bit in page->flags.
>
>     We still use the memtype list for non RAM pages.
>
>     Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
> So we absolutely *do* have a page flag to indicate the cached vs uncached=
 status, it's just that we can't allocate those pages in TTM for some reaso=
n. I'm still digging up what part is missing here.
>
> What I want to avoid is that we created UAPI or at least specific behavio=
r people then start to rely upon. That would make it much more problematic =
to remove the pool in the long term.

Okay, how about we land the first set of patches to move over to
list_lru at least,

The patches up ttm/pool: track allocated_pages per numa node. If I can
get r-b on those I think we should land those.

Then we try and figure out how to do this without pools, and just land
memcg with no uncached pools support. However we still have to handle
dma pages for certain scenarios and I think they may suffer from the
same problem, but just less one we care about.

Dave.

