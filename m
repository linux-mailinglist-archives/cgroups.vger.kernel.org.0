Return-Path: <cgroups+bounces-5350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02629B7619
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 09:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722DE1F2315A
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A286154449;
	Thu, 31 Oct 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YkTGwZd6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181101514CE
	for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362372; cv=none; b=gAn1mlg5O5BcJ+Gzn2Prq1v6/OxcR1ipSkR1OuJGkWwur1XGRv3iIwBHZ0PXh5Xg3wpq1nw6OIZcye2PYAGVU25VyenetgKzhlNgvZe6NvFpqLlWQUGimzsFKEdmyfTMYaRbZO8a9Bre0AFarTQ8qnyt+WTMjU+ZGNemtnsGv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362372; c=relaxed/simple;
	bh=dklUTvxcoZQ19Ejb/he4j0SPUhxKOWxWCHjH3frzbvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlXTDyiZB8i+j/d7rQwpw/fY3OVFjgLrRi9sksW4TIbLdqdXDjZ7N0Jpj+/C8mrGjCj5oV7xLaqK8y9VmD8r+oT/+ZYL8MtENHmYs9k94oN1iIcsGIzqB+cw6+eRFAPbID8BFI8+A6TVwRDwAlcyWZTlA+gaPKnNByVkOr7pEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YkTGwZd6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so99763566b.3
        for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730362367; x=1730967167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1NsFGdhFHt7vNHkeF4Op7bN0bdu6mqlOlf3mw5K16Yo=;
        b=YkTGwZd6OwFKvJ90DPsrAQ9v2fHOG4UyzuZuqAhFFkdF3RCSV9y5fefzSDGAkLN4Ow
         UAdSohUG+O+iCPUwUJGnTRbdHad9ACB6BvVQoGl6MlISBrvKZKM9Lp2XhUWbKJJJYY/o
         uuzLNOTxUj3s1flyPn383Sehy6EJli/6V7GdT8w1QRKlvQE+GIpAaM2hd6FoTfHYJ1kT
         iLouf9O8ByTMMkaEUucHcsLlrxVIIwjCMBuy/Po95A7v4j4rTcr6bT/J/rTlP1ApwO+g
         B2S1/2PZbPrRZmU+Iy2+q4jv9KuzjvbNzrxXcqzlqeF4X+fg5pVtz7B4FQYYK5DzojgQ
         flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362367; x=1730967167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NsFGdhFHt7vNHkeF4Op7bN0bdu6mqlOlf3mw5K16Yo=;
        b=G9nXXfgeppO8DnbJaD/DqKJKh5kvMKXCxEFCbNBFW+Prl7HCyuBzbZhLlHeptYQPTA
         F3wuEFsF1rbigB1wE1WJ9Xw86v6wJLeHmCNWfNjz6GYDeiBRbIC5//dYHQsRJrwv6ETX
         2qjGAXDB1j+OlOJMPFCOTluWMDtKzLZCXiBFmO665Q0lqhqKJKiMK6IyWLwksJIsinTH
         eYX2PGjSmI3diI5dV3UP1DonMvyNrN4XndtbiMR9ox3JPkjkeACKIVKpY8TOyLvScwDx
         Or2jMVGJHzuaqH522yWLGbYcxirFQr+6If1Bfr220N/rdGsq8eHPkLmB9aK16Pq7tohf
         FFkg==
X-Forwarded-Encrypted: i=1; AJvYcCWeG9Z9yUx42918ixuxMhtzF9pFqnUTxHjPFPkuKR+qBdwAS+WwJgPEM3Rspqx9j+uxnV9pHl0x@vger.kernel.org
X-Gm-Message-State: AOJu0Yz415M43d3PXKO9cKvqdzjeIO27LYY9aRNzZG9dvFJWl6FeR02e
	w9yGt0ZYkZt4/dr3l1wwb33h0DRYpcijNU4jHu0Tx4aSLqeJDuqkqsRW271ofng=
X-Google-Smtp-Source: AGHT+IErqAcDPZr221CAovWq14T0+yAWNPysXadW1rVCxC28+QsDk01at4oQ+oc4iW1WxHhAWm19ug==
X-Received: by 2002:a17:907:94c1:b0:a99:4ca4:4ff4 with SMTP id a640c23a62f3a-a9de5d98002mr1492014866b.23.1730362367461;
        Thu, 31 Oct 2024 01:12:47 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c55ffsm39587566b.59.2024.10.31.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:12:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:12:46 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <ZyM7_i1HFnFfUmIR@tiehlicka>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka>
 <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka>
 <20241030183044.GA706387@cmpxchg.org>
 <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>

On Wed 30-10-24 16:43:42, Joshua Hahn wrote:
> On Wed, Oct 30, 2024 at 2:30 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Joshua, can you please include something like this at the end:
> >
> > lruvec_stat_mod_folio() keys off of folio->memcg linkage, which is
> > only set up if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is switched
> > on. This ensures that memory.stat::hugetlb is in sync with the hugetlb
> > share of memory.current.
> 
> Hello Andrew,
> 
> I saw that it was merged into mm-unstable earlier yesterday. Would it
> be possible
> to add this block of text to the patch description right before the footnotes?
> 
> 3. Implementation Details:
> In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
> regardless of whether memcg accounts hugetlb. lruvec_stat_mod_folio
> keys off of folio->memcg which is only set up if the
> CGRP_ROOT_MEMORY_HUGETLB_ACCOUTING cgroup mount option is used, so
> it will not try to accumulate hugetlb unless the flag is set.

Thanks for the update and sorry for being pitbull here but this is
is a bit confusing. Let me try to reformulate as per my understanding

In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
regardless of whether memcg accounts hugetlb.  mem_cgroup_commit_charge
called from alloc_hugetlb_folio will set memcg for folio only if
CGRP_ROOT_MEMORY_HUGETLB_ACCOUTING is enabled so lruvec_stat_mod_folio
accounts per memcg hugetlb counter only if the feature is enabled.
Regardless of the memcg accounting, though, the newly added global
counter is updated and shown in /proc/vmstat.

I would also add the following

The global counter is added because vmstats is the preferred framework
for cgroup stats. It makes stat items consistent between global and
cgroup. It provides a per-node breakdown as well which is useful. It
avoids proliferating cgroup-specific hooks in generic MM code.

I will leave up to you whether to add above paragraphs but I believe
they clarify the intention and the implementation.

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
-- 
Michal Hocko
SUSE Labs

