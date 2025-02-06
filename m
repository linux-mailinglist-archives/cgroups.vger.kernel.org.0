Return-Path: <cgroups+bounces-6444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2DAA29FD2
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 05:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8EB7A192B
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4991A2643;
	Thu,  6 Feb 2025 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlgEm6MK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54991A2564;
	Thu,  6 Feb 2025 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738817784; cv=none; b=XGg5OtnZXwT59sylT6I79me0HHQ8x3ugbll0afTgN13sQS2knkQTeqvUflWwlfkF+Z/T6/QPhzNUU7F+3xfydPUlAasxG8XfJ8yWBcOUzvxaxfCm4ugHuoOo0RYNGyUMP1aumbIubWfHlgfJUhMwbbam1xuXdi3ZlNyxeQh4kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738817784; c=relaxed/simple;
	bh=553hF+T7BWF2LLgAhHz451B5EJreka9CG49KJHF3jzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmt8/paNMX8Z565sblI+rXrzvhSLWCIbvVCbmpdJHje0RoAN2E/4s1qGsKcRruHvfLjHb63YE0C74zGbRdxfh+rAKSBR9ykpTr/EtcZN7FzFbfnFBSDM7y2JFHMmYYzGL+ax7hH9h/6V3v+AhKINmrxPN7L9I+unQWMBcdsKZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlgEm6MK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fa7so4629631fa.2;
        Wed, 05 Feb 2025 20:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738817781; x=1739422581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=553hF+T7BWF2LLgAhHz451B5EJreka9CG49KJHF3jzI=;
        b=mlgEm6MKhabGIgmMxfaoNAwbkwi9SWfpClqcvzFNCIDLk7npQbBHNtDktNeKm+X5jF
         c8Dk6SX1dvLN5vIxXWE+/tBNFry7XroF87KxuVP67vSKBbI3CwTnskN4+3xOdPUnePuG
         LGAVqYLOVBvB5QMic6y8WefmOq48CtSpQV7ueXp3iHuFiHJ08KrFvGn+3urGBT69nTqW
         zAAnBimUBNNRqVUhorqipzZOt3NnXte6JjR0J2d6dPU4kDqmY+RyP18m8PX1VydcOkcI
         vQ9FGxeADgBD1pOF/bXRXR7gydfLUQrl70Z7Pg0esuLxJgLGC88kxQsoF6Li5O6UZtVH
         5zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738817781; x=1739422581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=553hF+T7BWF2LLgAhHz451B5EJreka9CG49KJHF3jzI=;
        b=RVn8U9OuPVMk6YW1kARGledhnYWFmGQbSrjvfXKmYPDTU0xISZw+vVqQ9LZXGBLNJC
         K4cLXMXFMNy080PRKNhfKPYWvMEhvm7H5S19KYi2uz5CtB79XQ6g6oqeATlO/6mSes52
         4zEVSYX17rAcvpIhaMkym9RhDTeosBqmpTJRz231VGlaoWQNkwNBrZX3Nb0N071DXwX7
         /kb/yfQH9dqnMewgn3iVPnOLEMU4hnLMXKAfZmp+VboNLAFJNZZ4d6FCYWqNLJ+1wmMO
         73RXRQ1+Koxc9gz9wmy59ObaX8GhgZqM59pk6BVGELuFLmDX1WeQXqwPQH0BIG7Hy3df
         ggHA==
X-Forwarded-Encrypted: i=1; AJvYcCUwNBwXrQs64CG5x3fCtO2rZ9aaX9QJquKCcr4KY8jPYWj/6ViylV4+gHZ3gPuaMLuL0lMVpOZ+iIi8w1TC@vger.kernel.org, AJvYcCXbaa5qoJ5Ate+B2R4H8xssICOpH0W7PiPcsxeXObIqv3uophbMrAeBFvFRPeRUzws4UeGieTPh@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWvJLonHbcBqoiHes6f9r7r1HbfcXItI8MeE8jwToLzWIjgqD
	jM4pOoLZX4EU7MVEJDf048hid5a3Te4xtWUVQz5GaPgkYu1INwoT1fHkDudLRmReJaX5gQoP/CT
	qh5SMFDcOgC2nFRfZuXq0r6YSSYU=
X-Gm-Gg: ASbGncs1Bs9vE7cZD2D6aSivGn5mo6XFGE4c6D8/OzaBQq/i92i/8QIec4WZINpM6UL
	M27LHpQEppiLCnZczRtg0MKSmf6l4Jdv+Dy7nD7lSwuVOdEZea90mzR4ObeQm+dpq1jz13IU=
X-Google-Smtp-Source: AGHT+IFonN6lOudu0OFZFWXDq7UQ7mw0D1dsFuCqkLDlH0Ywbx7YEuGZX14bATC+gLWbyC0JYnl24IokY0f+9SOIW34=
X-Received: by 2002:a05:651c:220b:b0:302:40ee:4c2e with SMTP id
 38308e7fff4ca-307cf301980mr21525041fa.2.1738817780478; Wed, 05 Feb 2025
 20:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6OkXXYDorPrBvEQ@hm-sls2> <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
 <20250205180842.GC1183495@cmpxchg.org> <Z6Oq47ruBzfQh0do@google.com>
In-Reply-To: <Z6Oq47ruBzfQh0do@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 6 Feb 2025 12:56:03 +0800
X-Gm-Features: AWEUYZkWAfEEjK0QEPwBPRIyhrI2ANWH_0Fhnn48KPULDYSPjpkjIWKEHfuhVA4
Message-ID: <CAMgjq7BjBoCWeB-MwUGYA=jLvigZ6tC3pLxz6SHAj3eVcsCgnA@mail.gmail.com>
Subject: Re: A path forward to cleaning up dying cgroups?
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Michal Hocko <mhocko@kernel.org>, "Zach O'Keefe" <zokeefe@google.com>, Kinsey Ho <kinseyho@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:16=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> On Wed, Feb 05, 2025 at 01:08:42PM -0500, Johannes Weiner wrote:
> > On Wed, Feb 05, 2025 at 12:50:19PM -0500, Hamza Mahfooz wrote:
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > >
> > > On 2/5/25 12:48, Hamza Mahfooz wrote:
> > > > I was just curious as to what the status of the issue described in =
[1]
> > > > is. It appears that the last time someone took a stab at it was in =
[2].
> >
> > If memory serves, the sticking point was whether pages should indeed
> > be reparented on cgroup death, or whether they could be moved
> > arbitrarily to other cgroups that are still using them.
> >
> > It's a bit unfortunate, because the reparenting patches were tested
> > and reviewed, and the arbitrary recharging was just an idea that
> > ttbomk nobody seriously followed up on afterwards.
>
> There was an RFC series [1] for the recharging, but all memcg
> maintainers hated it :P
>
> https://lore.kernel.org/lkml/20230720070825.992023-1-yosryahmed@google.co=
m/

We have been suffering from dying cgroup issues for years too, and I
just saw this series. Will it be a good idea to combine this with
reparenting instead (if we will go with the reparenting approach)?
Using objcg API to charge the folios does help speed up the
reparenting, but also adds some overhead and complexity. Just walking
and reparenting the folios seems a more direct approach.

And another idea is, per our observation, dying cgroups have few pages
that are mapped, as the process has all exited. Most folios are just
cache. Shared mapped pages are minor especially for containers. So a
deferred recharge on access seems good enough? Mapped folios may also
be finally unmap someday and get recharged. And at least this makes
accounting more accurate.

