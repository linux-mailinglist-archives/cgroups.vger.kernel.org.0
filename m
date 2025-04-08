Return-Path: <cgroups+bounces-7435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A99A81324
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E637AE88D
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E801B422A;
	Tue,  8 Apr 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Qi4AO1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51DB676;
	Tue,  8 Apr 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131585; cv=none; b=BiBVj9vkwSCYWo84biEwY4Z8QKxMjG6iBpjki+Ntz+TyzqphTS1WxJ9UjYLqG/+S9t3IG2L/VWO90hkj5tKI95acAlCILtn5Iujeig4rOLP33D8yH9jSRQEpqBPkzz+3fyrr8WGcWHeX4Ts9V7+MaqQwOMV9+PAHnm3C2qzWpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131585; c=relaxed/simple;
	bh=DftV1a27ak/l5309d19IF5/drsGm5W5ni5972SsniR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/cUsK7vVmyNvEUOsol6hDH7BKqwAbdDGgYKCACNCjMyqToBfzx3lHk17Nq8P+R0iW0Qru/4PM6AvfEnB79sDUnNi3NoCbLGiQ7nEI/S6zxga7F/Gz9LyT19idPrxpbmoDKVRv8yUqlEJR1l+oJC1c1kRs7VJksulZBa20+hW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0Qi4AO1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso56390071fa.0;
        Tue, 08 Apr 2025 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744131582; x=1744736382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DftV1a27ak/l5309d19IF5/drsGm5W5ni5972SsniR4=;
        b=R0Qi4AO1QrhORrmi1CQShYnzjvgQG1nLyCrH9F3AKHt9UrVBM7M7bOXmsoTVyHAIuG
         DnJMMw8i2LClUBVBhgiv2o3zMlBMnCdmux9VIuf+VwKM3A+XToM3Hu9OZ9UWjXtYUFwY
         ooWLwvCoX8/YKZeXPIEuiNcDwZiu/ylMKhdMKgDaC7iRq8gy182wYkGkTdFzCGzeVlyC
         xOYoEwCvx65opZG2QJ4repGPhdNfnqGES0V9Mqy+6wWW7bZFw8MZSMe2VEAkL6kOM05y
         XGXWcWF3DNwfXETedhLJi4FghYt16f+gXaCqFypVM/zLZcV56txRePiLNkp6LvLJXjqY
         PXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131582; x=1744736382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DftV1a27ak/l5309d19IF5/drsGm5W5ni5972SsniR4=;
        b=Sk8jkHkbmt4qU+l8YqnFgM57SVii+5cHt7dBri98ofaW/n7iOsPYBNOlCZ86V2uSk8
         mQATI2QIcsH6HPYz+FbIcLxU7hyrTQHKf1grVNpRebNr/desJz9Hz087oN2n2I1NcHFC
         dSrrzhPVOC7YHjHinvzoPo/Vhgh3JIpQxAwRHQjmkG5tdegqWNO4zgvUsBBniNGHxVtK
         gyqmSt64LR7DtpA3kbMVlW+QE9GWq6vHH2Eaz0uXBh+xHKp80SKWGXwPfd36FNon8e6U
         8go1sUy+zWoJL77xVheA6BP1+SQFrEPIIZ3YMdsvyCrnOVBgtfHVSRVceXv04ZwloQsp
         Gs2w==
X-Forwarded-Encrypted: i=1; AJvYcCV2/L6meTTICwo98VvM66iRKLlqjwj8P9fDt8f+k9uE7qz60WgxYdYcFSl/Vd55Z2Kd5fefvY6uTmM=@vger.kernel.org, AJvYcCX18KUWqfxL/jGrPpmHCYmsbyf7yZaVlUtGyvCqlcvs6CuXJul0lhWRGtWQZNLHSVPGuc+KNGame99q9snT@vger.kernel.org, AJvYcCXeUdRTLlGdTx0JyB33UDMpV8U/II33yLQx2BvqxDMPE87iY3yrgN4nYT2yLgrg2/TEVS39Q4vL@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIt9ikiDVyxFOgleYo2lz8RwXjlaUcFCoij8K473ku6O2/6KF
	EYiDJZgCcwOH5TLLgXdDrkMS4VCEyBW3S3Ue3XAcCJ3Cvkc64LmScR4qTr+3RMv9CCLLez2YLu/
	F/Nw66CGY43Ha0gZyYsNTPLtegcs=
X-Gm-Gg: ASbGncsUZMlak2TkMXxlWOr7BvC7QkwcHC+aTGVaCeS2uGQEG4wHz2E2qHgrKBPJdmu
	1JJ7AbkRmKlxQCBgSjIsr1vVk9lLOdgXqw8EiBHX3yugy6kbAX/JwFuzyxFqEIQk/dVLUdKPu2X
	NS4g00zaP14II29rKAN8XvEKb5pg==
X-Google-Smtp-Source: AGHT+IH9R7h7ieFhvrQGM67HDK4QXM6Z/1TM33bKp4N8o3XFtaF4quedno31N3Wfa38ljpf82w+2jKVzk5o6XxRjqZI=
X-Received: by 2002:a2e:bd81:0:b0:30b:f775:bb25 with SMTP id
 38308e7fff4ca-30f0a190a9emr57862711fa.36.1744131581435; Tue, 08 Apr 2025
 09:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <CAMgjq7CdARdTEZB3ik4X9cAzNUFa6GRqjT61brygihGUYFBAeQ@mail.gmail.com>
 <CAKEwX=M5y4yoW62U5GkHTxaDaD7UOJu_sgkkwNXJ5Hn4Gvot9g@mail.gmail.com>
In-Reply-To: <CAKEwX=M5y4yoW62U5GkHTxaDaD7UOJu_sgkkwNXJ5Hn4Gvot9g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 9 Apr 2025 00:59:24 +0800
X-Gm-Features: ATxdqUHGkDm_i6GEKMJkd2mD4BjrHrGRZ9eR_uwYqr_cY42CF_aL_IYSEBAo7bQ
Message-ID: <CAMgjq7D9Z=u2J18DExmzeU8fRbvqNwyC3tem2aykAsm79=QGEA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 12:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Apr 8, 2025 at 9:23=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> >
> > Thanks for sharing the code, my initial idea after the discussion at
> > LSFMM is that there is a simple way to combine this with the "swap
> > table" [1] design of mine to solve the performance issue of this
> > series: just store the pointer of this struct in the swap table. It's
> > a bruteforce and glue like solution but the contention issue will be
> > gone.
>
> Was waiting for your submission, but I figured I should send what I
> had out first for immediate feedback :)
>
> Johannes actually proposed something similar to your physical swap
> allocator for the virtual swap slots allocation logic, to solve our
> lock contention problem. My apologies - I should have name-dropped you
> in the RFC cover as well (the cover was a bit outdated, and I haven't
> updated the newest developments that came from the LSFMMBPF
> conversation in the cover letter).
>
> >
> > Of course it's not a good approach, ideally the data structure can be
> > simplified to an entry type in the swap table. The swap table series
> > handles locking and synchronizations using either cluster lock
> > (reusing swap allocator and existing swap logics) or folio lock (kind
> > of like page cache). So many parts can be much simplified, I think it
> > will be at most ~32 bytes per page with a virtual device (including
> > the intermediate pointers).Will require quite some work though.
> >
> > The good side with that approach is we will have a much lower memory
> > overhead and even better performance. And the virtual space part will
> > be optional, for non virtual setup the memory consumption will be only
> > 8 bytes per page and also dynamically allocated, as discussed at
> > LSFMM.
>
> I think one problem with your design, which I alluded to at the
> conference, is that it doesn't quite work for our requirements -
> namely the separation of zswap from its underlying backend.
>
> All the metadata HAVE to live at the virtual layer. For once, we are
> duplicating the logic if we push this to the backend.
>
> But more than that, there are lifetime operations that HAVE to be
> backend-agnostic. For instance, on the swap out path, when we unmap
> the page from the page table, we do swap_duplicate() (i.,e increasing
> the swap count/reference count of the swap entries). At that point, we
> have not (and cannot) make a decision regarding the backend storage
> yet, and thus does not have any backend-specific places to hold this
> piece of information. If we couple all the backends then yeah sure we
> can store it at the physical swapfile level, but that defeats the
> purpose of swap virtualization :)

Ah, now I get why you have to store the data in the virtual layer.

I was thinking that doing it in the physical layer will make it easier
to reuse what swap already has. But if you need to be completely
backend-agnostic, then just keep it in the virtual layer. Seems not a
foundunmentail issue, it could be worked out in some way I think. eg.
using another table type. I'll check if that would work after I've
done the initial parts.

>
> >
> > So sorry that I still have a few parts undone, looking forward to
> > posting in about one week, eg. After this weekend it goes well. I'll
> > also try to check your series first to see how these can be
> > collaborated better.
>
> Of course, I'm not against collaboration :) As I mentioned earlier, we
> need more work on the allocation part, which your physical swapfile
> allocator should either work, or serve as the inspiration for.
>
> Cheers,
> Nhat

