Return-Path: <cgroups+bounces-5276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CEC9B154E
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 08:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B77028303F
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E815B130;
	Sat, 26 Oct 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wOcYS5Ae"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE0217F43
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729923663; cv=none; b=qbiF7rhkeW9VaA5s4ZpYyR/U1GWrx5r+jhiqqcOGBdMw8e5gZOOF+6FJojlfd6eLolkNYIBP3O1gqW9NvkS86vd4uramtFH3BDW8lpx4rVzdImHPeWIh0A4Iz1gjI6HEF6H+s10Hkdiqo1h6fN0211J8ojrxrTYTdC2/FdB9MQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729923663; c=relaxed/simple;
	bh=T3cLOvLmpXT3DfruKbIZuU0dFk1rc6dmtKxGiVIILCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwX80WRNfaM/5cO46HwqP6Z9dEcF2r3514hkX4BYAJx70TXDcdrwGh6CCyNnZiR9u2/ViQLDrCZ4KzQ4Hywf+0j4udUqInKGYGja2nOISPwSyyzvPHQzTgaKAXInaOpN+yDCQ1BjDH4F2vaI3p5T2LmyHjwh2PXVAEWDlxQG3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wOcYS5Ae; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 23:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729923659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHAwo+JHtR0FwFONME6zc+Rb8ODXdGUmI/r0NvGK1AQ=;
	b=wOcYS5AeAxHZybTQ4tG6y7dgLM71ARuhUQ+7lbNhmGKgYAagc61eRREX3dcRLz0ZjuwE09
	ORrfNh6zQFFvU3+6cG+kuaiv+YlAV7GIoM8s5Z/1wrIxKy8H0YAJujRv+O8AbKNX0+U614
	shsB3NWF094pDlWoLg+ChAXA2Oo5ec0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <zyg74lpsxu7gvnsjjrcrbejfophvas6ibfi6cpqsj6hewgongo@x6hlpemfz6ej>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
 <CAOUHufYCPkUH0ysujoXZaw3PSrPvaw356-Pb97=LPGVRu_7FNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYCPkUH0ysujoXZaw3PSrPvaw356-Pb97=LPGVRu_7FNQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 09:55:38PM GMT, Yu Zhao wrote:
> On Thu, Oct 24, 2024 at 7:23 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > While updating the generation of the folios, MGLRU requires that the
> > folio's memcg association remains stable. With the charge migration
> > deprecated, there is no need for MGLRU to acquire locks to keep the
> > folio and memcg association stable.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/vmscan.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 29c098790b01..fd7171658b63 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3662,10 +3662,6 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> >                 if (walk->seq != max_seq)
> >                         break;
> 
> Please remove the lingering `struct mem_cgroup *memcg` as well as
> folio_memcg_rcu(). Otherwise it causes both build and lockdep
> warnings.
> 

Thanks for catching this. The unused warning is already fixed by Andrew,
I will fix the folio_memcg_rcu() usage.

