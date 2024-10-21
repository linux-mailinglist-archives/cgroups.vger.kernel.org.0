Return-Path: <cgroups+bounces-5171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68CE9A6CEA
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A74FB258FE
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D01F940C;
	Mon, 21 Oct 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPZfC6/l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564831F7092;
	Mon, 21 Oct 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522319; cv=none; b=Opo6egG7auBF8CHPgNnIPGv0UvSaM5IQIrJ52mB2MSe0HIwc75xFKcFPMPuwdMx/R+vMJWtKuZK+COG47w7uCrTD8E6mO8cL17kBr2d3QfJ4hJ40G5hhpDrjeiWMdJTpvbtlQFfavB++Oso9oQ/gL4e5isWZAT2nvHNzuagvr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522319; c=relaxed/simple;
	bh=n/DqeEp3zB2caMk9GO1G5MCRJfgu3rzzsfIKp5PiEUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8ZH7Ke3OGvQHBEpePy91tMwrriCx31WV/cGQm9pVMyd4CSdfsBtVFA5uq6PPzai0RfovBIHvwRftmwlKdJoOaAkQqLxzyJJYCyAoDEAJLwDVCvhw5Bb9bbXehMxs4L7GMBMJU8XAq8u7c7UDWROlfMC+lBthSRoW5NW6eLEcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPZfC6/l; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb443746b8so47019251fa.0;
        Mon, 21 Oct 2024 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729522315; x=1730127115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eABMIx9lnMto4OhJZ3h1jo2zuiX/EYRQgb1Gk/pqN0=;
        b=YPZfC6/lNtldf8GCVuCicYeAUG7ZqWFPri8yNWxZZBwQkin2g2sSLbYEQr8u1X0tt9
         xwzCJy6zUQQaoEaQXKk8Eb63SS8PRledSeCJHN5o9r2WuqvYG5Yf2z8AHdtl1S7Ywh1a
         J/XmRzE1OJDXD5guFTitdRQMHBzp+t3ue6mXx47vQHxtysqBHoRW9ZAV/6KuuMexGuK7
         TR268AmjT0U9CFwLAnonL6DWnwhV/w2CU/qrY6igpgeanM3S2xI+XCfO454Z4B6Gw1Ku
         hTut6AgJJy3L1Pr1H5cWHbYzjRtJMYgCU8VBH/OgCJS2EbBndziQid+Ka4Kqw6AjShrC
         WAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522315; x=1730127115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eABMIx9lnMto4OhJZ3h1jo2zuiX/EYRQgb1Gk/pqN0=;
        b=jLYYdzJFZmy2KjKnaMWtfHs0qc66QmWkMnVyFUxqkUXGYOToXvMJIivuEK8lkxMOMV
         cbBnynKPMowAA+RZvebqI3xT+b5Mf83Ukwy+MpE/eKhty4hhPW4Y8Lxrpsl/ne7QJnPM
         rq/jXrwSWcqvP85OglOHGC7zOh9LbcO/nTZj7SBBSPobHszivM00Z0a4s8ba86UJnHP1
         XZlpB8Stpt+Th8vwqZCBh72P6QbTjguWE1UnY7+MY4WgtUppD778DYkalN027QxJIAEc
         kYZgGkSXYnI5bBf2knflLVO+8AVdTW7IcRomzPzdEmK+QgefUSj95RdrCmzWxKlZO77+
         6qug==
X-Forwarded-Encrypted: i=1; AJvYcCWxFIPTJ/Uimd6HVwFUIxvXNTqkdA/F+ZPRyoWu1JKa0PGUMVVEXnwOfCs/5/2OH5tYzCcuf3mLHw8PwnUx@vger.kernel.org, AJvYcCXjqtxNW3GRfYpgFLnNvSPnEuQjG+7FOTSrnuKhXvEwHyv3DnfNffvWG4E8yiuODWDnPZed1App@vger.kernel.org
X-Gm-Message-State: AOJu0YwXO9d/kno6ZEfDwtsBEREusTPRFCshPql9efcvopHMLX3PcbxB
	nMS/cEcqZ0pJUjFv/xe3ksBi3B4LxxwPW/aLckz+OPxst9R6BkLJpjyD11lB7qe5utgnc3yspLK
	KrEmtiBwoB6soCSKyMH4PoAqr90A=
X-Google-Smtp-Source: AGHT+IFXPlzL373ISjpa3KTVBnHtlsi6xEMamxxcHC6fm0VA8xoQMx7OABNdmlt0t9yTrBxGrENWyIGVCihHQEte1SE=
X-Received: by 2002:a2e:b987:0:b0:2fb:3bc0:9c7c with SMTP id
 38308e7fff4ca-2fb82eb3506mr45509321fa.25.1729522315068; Mon, 21 Oct 2024
 07:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka> <20241018123122.GB71939@cmpxchg.org>
 <ZxJltegdzUYGiMfR@tiehlicka> <il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh>
 <CAN+CAwOHE_J3yO=uMjAGamNKHFc7WXETDutvU=uWzNv5d33zYg@mail.gmail.com> <ZxX_gvuo8hhPlzvb@tiehlicka>
In-Reply-To: <ZxX_gvuo8hhPlzvb@tiehlicka>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Mon, 21 Oct 2024 10:51:43 -0400
Message-ID: <CAN+CAwMCbX1BAmfBxFC6t75i5k6GVNKPR_QPCB5DDnYwHeCbnA@mail.gmail.com>
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory controller
To: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	lnyng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> > On Fri 18-10-24 14:38:48, Joshua Hahn wrote:
> > But even if we are okay with this, I think it might be overkill to
> > enable the hugeTLB controller for the convenience of being able to insp=
ect
> > the hugeTLB usage for cgroups. This is especially true in workloads whe=
re
> > we can predict what usage patterns will be like, and we do not need to =
enforce
> > specific limits on hugeTLB usage.
>
> I am sorry but I do not understand the overkill part of the argument.
> Is there any runtime or configuration cost that is visible?

I think an argument could be made that any amount of incremental overhead
is unnecessary. With that said however, I think a bigger reason why this is
overkill is that a user who wishes to use the hugeTLB counter (which this
patch achieves in ~10 lines) should not have to enable a ~1000 line feature=
,
as Johannes suggested.

A diligent user will have to spend time learning how the hugeTLB controller
works and figuring out the settings that will basically make the controller
do no enforcing (and basically, the same as if the feature was not enabled)=
.
A not-so-diligent user will not spend the time to make sure that the config=
s
make sense, and may run into unexpected & unwanted hugeTLB behavior [1].

> TL;DR
> 1) you need to make the stats accounting aligned with the existing
>    charge accounting.
> 2) make the stat visible only when feature is enabled
> 3) work more on the justification - i.e. changelog part and give us a
>    better insight why a) hugetlb cgroup is seen is a bad choice and b) wh=
y
>    the original limitation hasn't proven good since the feature was
>    introduced.
>
> Makes sense?
> --
> Michal Hocko
> SUSE Labs

Hi Michal,

Thank you for your input. Yes -- this makes sense to me. I apologize, as it
seems that I definitely left a lot to be assumed & inferred, based on my
original patch changelog.

In my next version of this patch, I am planning to add the changes that hav=
e
been suggested by Johannes, write code with the try_charge cleanup that
Shakeel suggested in mind, and change the behavior to make sense only when
hugeTLB accounting is enabled, as you suggested as well. I'll also update
the changelog & commit message and add any information that will hopefully
make future reviewers aware of the motivation for this patch.

Please let me know if you have any remaining concerns with the implementati=
on
or motivation, and I will be happy to incorporate your ideas into the next
version as well.

Joshua

[1] Of course, this argument isn't really generalizable to *all* features,
we can't make a separate config for every small feature that a user might
want to enable with the smallest granularity. However, given that the exist=
ing
solution of enabling the hugeTLB controller is an imperfect solution that
still leaves a discrepancy between memory.stat and memory.current when huge=
TLB
accounting is enabled, I think it is reasonable to isolate this feature.

