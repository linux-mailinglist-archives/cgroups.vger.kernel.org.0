Return-Path: <cgroups+bounces-1291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0384487F
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 21:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673832869B3
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35F3F8ED;
	Wed, 31 Jan 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="C1Obk+7q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34539FD4
	for <cgroups@vger.kernel.org>; Wed, 31 Jan 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731984; cv=none; b=EyR4zxL/CwlzI2zEr6I2efgfEwOVv3ecCoboyJn/ecMPu3AAt6nlT6p18bzkc3lyiZWgymaYg3PxxZepm22dOq2XMxU240G7cq3cjt9cU+YnhdWSnjj0iDFySKfQHwJBAnDwax+XXbzOLXdjyn6gcRFswfaEa3QUaDihi/MxHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731984; c=relaxed/simple;
	bh=lGi5QcvUcQnWGCazs79pnrj0VMWYM0mPtvKyIRAR1ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcyx1tLEyU8tihfJ0LvIgOjUUvrx1HAQkKlHvxEnzAmkMnlbddICm9mTQ4z9LyrFyW7b/XXB6CVMuXeBvD485S+crrKDGyR5vaD+vo7PmRT0vCdrEtKwFciZGJUimPm5CmZBR2BXZukyMxwSvypBAku6GygIjZsMElaJP0ZEJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=C1Obk+7q; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21432e87455so65397fac.1
        for <cgroups@vger.kernel.org>; Wed, 31 Jan 2024 12:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706731981; x=1707336781; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DpN7tAlSPEJaxHsz1Fwia1gS3Vdtxd9q2yNC5JJCopI=;
        b=C1Obk+7q3hc/cOSsP4FSUewClzA9gotobEEGqR7qg74R/cdfBFO0gqvQtnUGFoblUT
         b/+qVdmh2GuNjmcf7b6dEyfKFsAMybrvo16rONcsi7MaPTKbIdp4k9VWjsNoOjIK7ncK
         0NgOzX9/bQyv0L7jeEdUsg5jirKw+WLvLzILBgqzw2/B9KaheNdXEuTIB+aSgvJMHaYx
         1ODPcArAi+XaxaiLECAlS3qar8sEuN8W+cWQU8pO+/3Lt4Zy1h3BdWy5jLasHvebZ4OA
         erAENOTFc88ngeoyU0diBl02veYuOxZXzG1vulr54hWktf60vFlRFfl3QYoVD9vvNBaK
         FuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731981; x=1707336781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpN7tAlSPEJaxHsz1Fwia1gS3Vdtxd9q2yNC5JJCopI=;
        b=K+w+HVZaMuG19EEe71EE0ex32sWnzlZDSgQkkZoqwXBn3A5EIluOtAn4+hbbQribbY
         fyCRffX0PB/1cV8GTdA3Km6+LuN0EOR5u7D5kaJ44pRC2rfbg8enrNWrPRTDAy65l4it
         b3NGw00F/P/MW+MXX4y7nInO2tEg5yWk9/VdblbB3jV4nlj54fngAAu/YgMmdAuek5jv
         1wzrFiYYypaNH7+91Fxm/2/iiaPlLSnkMDU9317hD4Oa9I3aki1cROSC8KvAUmuAaKqN
         vVs/OePgPKaBOUHy9Ik2wm+pvIyQqNKdoqpCl5Cu/TSEtoswyegyFstqwkr8mZgx5tmh
         b73Q==
X-Gm-Message-State: AOJu0YxJH2KwxbqXTx7LKaITNMaY5rGPppzSPVoz6loqh6KQQyFdDvfj
	uMV+s2RvsqGZML1C7JX+awvyVY6YuuiFLQlx+sgdTZqgvI9yc6Nk90MWjfXhHp0=
X-Google-Smtp-Source: AGHT+IG597JmUsw0p9ugvB+ssXuN78/0ZfDYT2KT1oI/JaIHUBM0vXaUMn1SZIeIHb3DYXS6CLUxtw==
X-Received: by 2002:a05:6870:15c7:b0:218:889f:46fc with SMTP id k7-20020a05687015c700b00218889f46fcmr2667215oad.30.1706731980877;
        Wed, 31 Jan 2024 12:13:00 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id nf6-20020a0562143b8600b006869485d9eesm5789124qvb.82.2024.01.31.12.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:13:00 -0800 (PST)
Date: Wed, 31 Jan 2024 15:12:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Message-ID: <20240131201256.GD1227330@cmpxchg.org>
References: <20240131162442.3487473-1-tjmercier@google.com>
 <20240131175059.GC1227330@cmpxchg.org>
 <CABdmKX2WRQyBpDaV0CuL4E0OdR9FEff5NAZ0hFv8W8U7e82=UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2WRQyBpDaV0CuL4E0OdR9FEff5NAZ0hFv8W8U7e82=UA@mail.gmail.com>

On Wed, Jan 31, 2024 at 10:01:27AM -0800, T.J. Mercier wrote:
> On Wed, Jan 31, 2024 at 9:51 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Jan 31, 2024 at 04:24:41PM +0000, T.J. Mercier wrote:
> > > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> > > reclaim") we passed the number of pages for the reclaim request directly
> > > to try_to_free_mem_cgroup_pages, which could lead to significant
> > > overreclaim in order to achieve fairness. After 0388536ac291 the number
> > > of pages was limited to a maxmimum of 32 (SWAP_CLUSTER_MAX) to reduce
> > > the amount of overreclaim. However such a small chunk size caused a
> > > regression in reclaim performance due to many more reclaim start/stop
> > > cycles inside memory_reclaim.
> > >
> > > Instead of limiting reclaim chunk size to the SWAP_CLUSTER_MAX constant,
> > > adjust the chunk size proportionally with number of pages left to
> > > reclaim. This allows for higher reclaim efficiency with large chunk
> > > sizes during the beginning of memory_reclaim, and reduces the amount of
> > > potential overreclaim by using small chunk sizes as the total reclaim
> > > amount is approached. Using 1/4 of the amount left to reclaim as the
> > > chunk size gives a good compromise between reclaim performance and
> > > overreclaim:
> > >
> > > root - full reclaim       pages/sec   time (sec)
> > > pre-0388536ac291      :    68047        10.46
> > > post-0388536ac291     :    13742        inf
> > > (reclaim-reclaimed)/4 :    67352        10.51
> > >
> > > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> > > pre-0388536ac291      :    258822       1.12            107.8
> > > post-0388536ac291     :    105174       2.49            3.5
> > > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> > >
> > > /uid_0 - full reclaim     pages/sec   time (sec)
> > > pre-0388536ac291      :    72334        7.09
> > > post-0388536ac291     :    38105        14.45
> > > (reclaim-reclaimed)/4 :    72914        6.96
> > >
> > > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive reclaim")
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > ---
> > >  mm/memcontrol.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 46d8d02114cf..d68fb89eadd2 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6977,7 +6977,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > >                       lru_add_drain_all();
> > >
> > >               reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > -                                     min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > > +                                     max((nr_to_reclaim - nr_reclaimed) / 4,
> > > +                                         (nr_to_reclaim - nr_reclaimed) % 4),
> >
> > I don't see why the % 4 is needed. It only kicks in when the delta
> > drops below 4, but try_to_free_mem_cgroup_pages() already has
> >
> >                 .nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
> >
> > so it looks like dead code.
> 
> That right, it's only there for when the integer division reaches
> zero. I didn't want to assume anything about the implementation of
> try_to_free_mem_cgroup_pages, but I can just remove it entirely if
> you'd like.

What do others think?

We rely on the rounding up in a few other places and it's been doing
that for a decade. Maybe lampshade it for the benefit of the reader:

	/* Will converge on zero, but reclaim enforces a minimum */

but otherwise there is IMO no need to have defensive extra code.

