Return-Path: <cgroups+bounces-5210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D526E9AD6C8
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 23:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809871F23BD2
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA211D2B11;
	Wed, 23 Oct 2024 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRSUPcNq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43C481B1
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719152; cv=none; b=io3+00K8/UBLLmosiAG01Dj7ldcjpsazGm4sxCp9C30DnIQhINo5Y+d585+Mbg7hDRNnMfpOqwvkYiEYfwv/Rla6OcCI9lOKvCOtE4W3bo7OrJKsKNALbh5B4YJIexMV2l0tfXp2Ybyjyp3lHVYOlEhirqsF91571GnPZoZWL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719152; c=relaxed/simple;
	bh=tnaiLUaZeg3FiWHeMGyfgKIWHXMKIiP28PYPIEAelIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaCt4JbFKYBSE9HvmNCVP91umbBYhm4+4fEiXBr7tg68LLI0uNp22+wQtnteE8xWZyTJvRG3NOM4fRFFQSPnHWzhCZDJSEVjJJP+FK6LClC2jTGuZEIvd26IZi9p3thJBDHfsig5CnoqRydQipUfUXHjUP6oBZQqW2xdBn2vgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRSUPcNq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso21592566b.2
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729719149; x=1730323949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2GWUx17QhpZ+cdNug6BZd3FCXaL7OB+/tedmhJAjMs=;
        b=ZRSUPcNqLg4KimAmVZ6RAfMkLT6lNjbFfx8Nee9zpEY4v5ZM9dvWUt7+xDwiOwSvrQ
         tJpt+pahgfQZRNExVx+RbPA/2VG3bjGA+e2LaY0eFR1QCM4100G1wTPcv3G3qCBmx1tV
         pl4KviGlbwJVn32OmJCJf2IF2c3fMXom2DA7ogBLDIsnfixi5ZVZ9DLE6O4mNqUWWCS8
         iyNz2815LBcNTNIEoZGi5BW5zMluci3RtgCEZylMsIWKBIpW/bw5T0z1uC2WlsZyAap5
         qBqRGtC79RaGYfWTav97nNANI95pnuIUADlkCnZ+BE9s22JtGt0fyG5kSVOM+03L3xWH
         bQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719149; x=1730323949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2GWUx17QhpZ+cdNug6BZd3FCXaL7OB+/tedmhJAjMs=;
        b=I8lj4gg0utL05yjHiFDPx2PiFYnGG0QtkYRrvO2bF6QuQfqQvMeS9GG123MRr+xttE
         ACWbmHxhtcLeLw/VD4MOS8tEoYJEr8cdaV2BSRn+586BHITHUnqFfyhvQnUhDrhB2DgF
         N+4rQ8cJRs1GmFFrY0JtTQKbAP9+ACx/6ZgpXn3eoCae1eiDKSJGpYiAqU+5g3phHP0/
         EDQbAzf0eee6L61HCyX8LddV1o9uiMsGfb7AJ+9EOMDc3VeVjpgubUc90lsO+jqzR2hD
         OExSLl419jmPm+cdl8CuvVIdLtqmFeIUqFEb7TE4Q1Y70M18PBHquvA06i2LTTDj3GbC
         fv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi1LxXeiLb09su8JYeMUNJVdA9sS7dI2ArdZoVoUIm7er2rwbodcDhrc3Jx9ccmsVIweaimfRW@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEr49Th1FgxuNzBHVLJFg7Elq8DltWOkjrADMOW15TedOy38o
	rCItnEQt7CO7lJqP6Uu3s2FlvlhSjxsb0+d83KhspG6tdz+RAet5qpDYFFhe+6dlUEgp9XtXFSE
	uBHMGHAg/MV/9Mde8hWvJQjg3kNM=
X-Google-Smtp-Source: AGHT+IFc3rZx+vMO/8izclg3IenoHRbcpgipb3fisd1Rd+0IuNBnxSlh2htQNQu4uDHVb6Iz4PrPXb46dslbSKwg4YQ=
X-Received: by 2002:a17:907:9455:b0:a99:f4fd:31c8 with SMTP id
 a640c23a62f3a-a9abf8778bcmr457464166b.22.1729719148396; Wed, 23 Oct 2024
 14:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com> <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com>
In-Reply-To: <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Wed, 23 Oct 2024 17:32:17 -0400
Message-ID: <CAN+CAwMWVr=ojkn5upUPW9KXRDLjGMMFduF9JsKq5ud9YBMj_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Yosry Ahmed <yosryahmed@google.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushcin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	lnyng@meta.com, akpm@linux-foundation.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry, thank you for taking the time to review my patch. It seems
like I made a
lot of silly spelling / grammar / style mistakes in this patch, I'll
be more mindful of
these in the future.

On Wed, Oct 23, 2024 at 5:15=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Hi Joshua,
> [...]
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 17506e4a2835..d3ba49a974b2 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -215,6 +215,9 @@ enum node_stat_item {
> >  #ifdef CONFIG_NUMA_BALANCING
> >         PGPROMOTE_SUCCESS,      /* promote successfully */
> >         PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> > +#endif
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +       HUGETLB_B,
>
> Why '_B'?

I added _B because I am measuring the statistics in bytes (not pages).
IIRC some stat items use _B at the end to denote that the unit is in bytes,
so I put it at the end in the spirit of maintaining consistency. However, i=
f
is not the case, I will remove it in the next version.

> [...]
> >  #endif
> >         /* PGDEMOTE_*: pages demoted */
> >         PGDEMOTE_KSWAPD,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 190fa05635f4..055bc91858e4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
> >                                      pages_per_huge_page(h), folio);
> >         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> >                                           pages_per_huge_page(h), folio=
);
> > +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
>
> I think we already have a couple of these checks and this patch adds a
> few more, perhaps we should add a helper at this point to improve
> readability? Maybe something like memcg_accounts_hugetlb()?
> [...]

As far as I can tell, these checks only come up in mem_cgroup_hugetlb_try_c=
harge
and cgroup_show_options. Shakeel already requested a cleanup of the try cha=
rge
function in the v1 thread, so I think the best course of action is to
add the helper
function in this patch (series) and use that helper function in
another patch series to
clean up the remaining functions.

I'll be sure to add the other grammar / style changes that you
mentioned above in
v3 as well. Thank you again for your feedback!

Joshua

