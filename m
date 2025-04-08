Return-Path: <cgroups+bounces-7434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE9AA812CF
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CD03A4D57
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014D22F38C;
	Tue,  8 Apr 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGWu1gZp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63C142E7C;
	Tue,  8 Apr 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130888; cv=none; b=pAs6f+D36zfSGgHU9umqZ+lNKDYO5ARBCSK58yk6PzLLA8E8WQsFfuxGhA6I/PXbLmEom9xWr6fds0Bk1ntqMtLM7lMnMNAU0KbJI+qA3mT1x0zGCedYZAB4MVmKKQMguevbceQi/VB/0FdIulcsra51e7M6NEvTiLPaIS9Si3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130888; c=relaxed/simple;
	bh=cwqlzrGgGsz8S5IWqYTRqJ0gqIz3+lT8r7KQevS9BJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQZHO+H2Myw0qsXwJ06E0MTY58s8PR69I/Ad7WQO24Mg45TB5DSqakSAFZln/O5CP2F+S6QnNsL/LfwV7E7eHnwY9NdD/5x0AaFJL5msCpqqRnPItwgGBbnCYXkrkQRasswJWpr/67zxH+S/Iwfgb2gyjgKuuXkRpFZknphsGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGWu1gZp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c559b3eb0bso322260685a.1;
        Tue, 08 Apr 2025 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744130886; x=1744735686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwqlzrGgGsz8S5IWqYTRqJ0gqIz3+lT8r7KQevS9BJE=;
        b=EGWu1gZpS9EeeeFgwILae+czkZBKoWJiUSlqRTR1vC6SRTQKG7/Udh/TAgUKvg5wpm
         IRzTDaZHEXuLjZIYVqwgjVpb8AW+myVNnu11/XFEyUQVYuedJoC1vMk8kMZ9VlvnhROY
         daosGsDT3mS04YTkcYHl55Fn8zd5ardsS58BvwuAlUmSOBmOCFPu9pqwAM2smRb2pf8K
         Y+NogFMRSlvrlzJukHkaDabo97bYLzCm9pZL5FJytsS8YJvkeR0C7xK1fisRXXJRdzPd
         2D0W9o5z7JhhC13lJoYAutk9WOxqxP9EG5Tzwg43JXirxplWH3CCU8tCYlXu55MLfNl8
         VWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744130886; x=1744735686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwqlzrGgGsz8S5IWqYTRqJ0gqIz3+lT8r7KQevS9BJE=;
        b=PeaeWsEwlhzrQBiJcU/DebSaAEmcXaDjJrWRZ38dTgojYO8f2IWFCqlE3Xh8RGuntE
         uCrTrFTyK0NQFI7gCZmU5XFkcwb8kVDPHMS30CjWHsIZDf4/goZZPu/argmbSRyY95J4
         /fEPORzNN23V2/UaFGzHQ/5X5VeT2GU9rSZ9cEcvOqU5rtM7YME1T563PezSwIJxfgio
         G/ixd7nVuno6bAjIl23r+ZoBVX9vGqPbaCdwOohdVg57OkUJc1SMHzDpdM0sZ4XGdvG4
         1zFBwvVi9bBX403wUt8JvGNycwCr3bdkPgFxMupqM4ETlCKfVsdLg9RuARFO3LUmUH9O
         R+cw==
X-Forwarded-Encrypted: i=1; AJvYcCU+mbIf9MQWu6amC77NuL2w4yn7EppQzyUAtmxz4tRSOQFGrVKs+DclIlvXMR2RTj9BSV6tfs61@vger.kernel.org, AJvYcCUELO3pNOzBnc/9BIeBS8gQ17ElqK0B++8tw1uLtHpawnFhbdgux1X/tcHdwR6RB272DfI5It4M/9A=@vger.kernel.org, AJvYcCVlW/OKIpobDYFA5AM0iBjdtCkYWd875Iv96XSZK4APRicjVtTXo7ZbGv4TOPCzXL8aElRNiuti7S4vpqq5@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6wWWMIqAGe1aGFSOLOyW1zYvMBFMSK6sIYkQmsEn/FUzvyUe
	iH45+KKe8Pf+LKEIxYT86tMuVuxi82EeDr2KXl/d/JNZwSEtYe4eRqRbuQquwPQcpYQy/J2SJHF
	eFsNSeGLj2GNO80fmhzkiKkD6Do0=
X-Gm-Gg: ASbGncvOeMq+6lbVueVANvVia7OITUJt1/DS/vUZ1qIqAhTylQDqnrRz5TdRjzwZ6Au
	0CR3LDZRJz/r5Zub1qZsyHpy/S6aRQzSag9m4Mx3ivQIuf0dsu2pSPHL+jsd22OY6ahEtOHVXdM
	aAg5ZDHUAQjzQyproceW9A8G9ocqQ3XRYzTEvS7+wuhrQ9stvW6HL2xMZK2EFSIan1ZVi6
X-Google-Smtp-Source: AGHT+IEKXR2lYgBPtREcKxoHmtOozffIzMowJ7ShZqwFuTIitL4UbxHUf/e9JHWN1y5Sr2RR4S+gMCbEdD1KW9VzvF0=
X-Received: by 2002:a05:6214:76d:b0:6e4:2d8e:5cce with SMTP id
 6a1803df08f44-6f064b40812mr317953766d6.36.1744130885672; Tue, 08 Apr 2025
 09:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <CAMgjq7CdARdTEZB3ik4X9cAzNUFa6GRqjT61brygihGUYFBAeQ@mail.gmail.com>
In-Reply-To: <CAMgjq7CdARdTEZB3ik4X9cAzNUFa6GRqjT61brygihGUYFBAeQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 09:47:54 -0700
X-Gm-Features: ATxdqUHuDv-cpHmhmZQ2jCWbUMdwvepxeI6ke8OGK8kOxGMVm3G-MVNQ1hqFiFQ
Message-ID: <CAKEwX=M5y4yoW62U5GkHTxaDaD7UOJu_sgkkwNXJ5Hn4Gvot9g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
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

On Tue, Apr 8, 2025 at 9:23=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
>
> Thanks for sharing the code, my initial idea after the discussion at
> LSFMM is that there is a simple way to combine this with the "swap
> table" [1] design of mine to solve the performance issue of this
> series: just store the pointer of this struct in the swap table. It's
> a bruteforce and glue like solution but the contention issue will be
> gone.

Was waiting for your submission, but I figured I should send what I
had out first for immediate feedback :)

Johannes actually proposed something similar to your physical swap
allocator for the virtual swap slots allocation logic, to solve our
lock contention problem. My apologies - I should have name-dropped you
in the RFC cover as well (the cover was a bit outdated, and I haven't
updated the newest developments that came from the LSFMMBPF
conversation in the cover letter).

>
> Of course it's not a good approach, ideally the data structure can be
> simplified to an entry type in the swap table. The swap table series
> handles locking and synchronizations using either cluster lock
> (reusing swap allocator and existing swap logics) or folio lock (kind
> of like page cache). So many parts can be much simplified, I think it
> will be at most ~32 bytes per page with a virtual device (including
> the intermediate pointers).Will require quite some work though.
>
> The good side with that approach is we will have a much lower memory
> overhead and even better performance. And the virtual space part will
> be optional, for non virtual setup the memory consumption will be only
> 8 bytes per page and also dynamically allocated, as discussed at
> LSFMM.

I think one problem with your design, which I alluded to at the
conference, is that it doesn't quite work for our requirements -
namely the separation of zswap from its underlying backend.

All the metadata HAVE to live at the virtual layer. For once, we are
duplicating the logic if we push this to the backend.

But more than that, there are lifetime operations that HAVE to be
backend-agnostic. For instance, on the swap out path, when we unmap
the page from the page table, we do swap_duplicate() (i.,e increasing
the swap count/reference count of the swap entries). At that point, we
have not (and cannot) make a decision regarding the backend storage
yet, and thus does not have any backend-specific places to hold this
piece of information. If we couple all the backends then yeah sure we
can store it at the physical swapfile level, but that defeats the
purpose of swap virtualization :)

>
> So sorry that I still have a few parts undone, looking forward to
> posting in about one week, eg. After this weekend it goes well. I'll
> also try to check your series first to see how these can be
> collaborated better.

Of course, I'm not against collaboration :) As I mentioned earlier, we
need more work on the allocation part, which your physical swapfile
allocator should either work, or serve as the inspiration for.

Cheers,
Nhat

