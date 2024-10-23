Return-Path: <cgroups+bounces-5211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B80B9AD6CF
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 23:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD2F2814C5
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951F1D9A5D;
	Wed, 23 Oct 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3Ayc8S/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A2481B1
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719483; cv=none; b=oDmhwPmSKN69EaRdZYuxe/ocEjSMk9CuLLLXY1xKN9i4ZuxixlwTfjHLxfortGcM1uSnhOTfvJVsSJVekH/bgjz5SkOlIDfH+fVa6yeuvWVg+/DmQiRPME11+FCrJQrQelEAZjdSwOMEh962FV8wkHb7BdJ9rxhIZNrSg7Gsnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719483; c=relaxed/simple;
	bh=d/eoIxPCR8+8nWLwNDYe4p15afS+aWnk32ucktIWNys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+TAsSW65AgLme2E8GRqVr3YXhcVDJTuN/rrBLP519gBSnELU5rGBx9HxMp6F++OqQkftfQSPbahdjRiYlkyOqmGtvdXfu4TWYkkFcqE2vLdiEg1OQWMIUmZUXNUtd8V2IcpVQiqZyb7hyli8399egQ3HsxhlisH2oq4dih/d2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3Ayc8S/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso22091566b.2
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729719480; x=1730324280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7W0tu6mfaHUoou8fq3H8oaPBI6nhuNRuYpGlTyNA/w=;
        b=R3Ayc8S/LrJzF2mr5EoHvalTn1ptJ6sjfNHRvo6W51U4DRLZGVa+vWHoapus5M+LG7
         BFbAouaY37VXtDCGUzKQn7+pDNN9LpUEQPjIfbzU2hQXa7N1HAAotBVzTiU0wWV/ooKc
         qDGoQ5saAjZVcK0VjyGLFEmSeVykKfByTaQh2da3IxP74+vM3s/v4275itf8zYoHWrMQ
         sTYQUZ7y8T2iVqjmItSCG71EmQe08mOxkB6z4/bEMCs3smDm9kQNT+ASnnn/7Ytp/6/o
         FZuQmlyctYY9SeZg/Ve0nAq6Z6mSeGZxeNWRF2tgfNOfdcgadqedYuZvj0RKX6MkSi8X
         AOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719480; x=1730324280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7W0tu6mfaHUoou8fq3H8oaPBI6nhuNRuYpGlTyNA/w=;
        b=sVeBaWgOWiTvfV6G09wHnByAUYAHkxWc9qJOCIdMgxysukJLTGGdgRGYRQfe+87j53
         WPGXlBSMvb579J1ONV8smTQZ98zhO43RPu2It22TrKds2HJkUAMtDGX2wpvL5uatEQh4
         COJrumz2B9Osob4NVTrmQM6kYpTPIWvbVpCZW6fOk9W2LttcbLtDzA6YoanGcmADuFbl
         XOisic+m59ufR+/qfkQDm0scI796llMT5qvOs9AsprbyagknElFrNz7MjBB7etK8yRvp
         bP7WO6HlQZD487OZlnB3A+i7klc6+lAGRgmAUB5FVWwVr5URQACld4CGF+8ueIy9V5zl
         mXSA==
X-Forwarded-Encrypted: i=1; AJvYcCVa09RzQ4PXGzHdds0CgwNUfk+lFSghBAhm9QQKf4NZJb7P6/ZS4xORKQc+HfoNtXByOiHJbAQR@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsSMJLyBRHWNV2ewKKHygPl/GbZ1t136lvnRvdr904EzOwmHM
	RdJ0JCO9Cy8hq+3mct6p11ckAcP9Ol6mulHUBMC9taaXVFzn8wenbCXM9YngeRU2AHOAj/AID/1
	zNTX7HtTdSQTZzqak7HYOC6tjwQmScrfaWtTT
X-Google-Smtp-Source: AGHT+IEkEsqYuEyoOEPEtrFPG8xRsxQ5sOvL9rvaBgxs2alYdsADn5R9r8cwT2t3P//Fjj3xTrRXB/KjbzzO6U9mYRg=
X-Received: by 2002:a17:907:9455:b0:a99:f4fd:31c8 with SMTP id
 a640c23a62f3a-a9abf8778bcmr458459166b.22.1729719479816; Wed, 23 Oct 2024
 14:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
 <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com> <CAN+CAwMWVr=ojkn5upUPW9KXRDLjGMMFduF9JsKq5ud9YBMj_w@mail.gmail.com>
In-Reply-To: <CAN+CAwMWVr=ojkn5upUPW9KXRDLjGMMFduF9JsKq5ud9YBMj_w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 23 Oct 2024 14:37:23 -0700
Message-ID: <CAJD7tkaZF35aFLohijqJTEeY7mwOV15zVYENuCXBPjasvv7dwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, lnyng@meta.com, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:32=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> Hi Yosry, thank you for taking the time to review my patch. It seems
> like I made a
> lot of silly spelling / grammar / style mistakes in this patch, I'll
> be more mindful of
> these in the future.
>
> On Wed, Oct 23, 2024 at 5:15=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > Hi Joshua,
> > [...]
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 17506e4a2835..d3ba49a974b2 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -215,6 +215,9 @@ enum node_stat_item {
> > >  #ifdef CONFIG_NUMA_BALANCING
> > >         PGPROMOTE_SUCCESS,      /* promote successfully */
> > >         PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> > > +#endif
> > > +#ifdef CONFIG_HUGETLB_PAGE
> > > +       HUGETLB_B,
> >
> > Why '_B'?
>
> I added _B because I am measuring the statistics in bytes (not pages).
> IIRC some stat items use _B at the end to denote that the unit is in byte=
s,
> so I put it at the end in the spirit of maintaining consistency. However,=
 if
> is not the case, I will remove it in the next version.

I think ~all the memcg stats are exported in bytes, the ones that have
_B are also counted in bytes. I think in this case we are counting the
stats in pages.

See memcg_page_state_output_unit() and memcg_page_state_unit() for more det=
ails.

>
> > [...]
> > >  #endif
> > >         /* PGDEMOTE_*: pages demoted */
> > >         PGDEMOTE_KSWAPD,
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 190fa05635f4..055bc91858e4 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
> > >                                      pages_per_huge_page(h), folio);
> > >         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> > >                                           pages_per_huge_page(h), fol=
io);
> > > +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING=
)
> >
> > I think we already have a couple of these checks and this patch adds a
> > few more, perhaps we should add a helper at this point to improve
> > readability? Maybe something like memcg_accounts_hugetlb()?
> > [...]
>
> As far as I can tell, these checks only come up in mem_cgroup_hugetlb_try=
_charge
> and cgroup_show_options. Shakeel already requested a cleanup of the try c=
harge
> function in the v1 thread, so I think the best course of action is to
> add the helper
> function in this patch (series) and use that helper function in
> another patch series to
> clean up the remaining functions.

Introducing the helper in this patch/series and using it in further
cleanups makes sense to me.

>
> I'll be sure to add the other grammar / style changes that you
> mentioned above in
> v3 as well. Thank you again for your feedback!
>
> Joshua

