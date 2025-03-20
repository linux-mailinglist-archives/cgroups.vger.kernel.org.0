Return-Path: <cgroups+bounces-7193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B548A6A192
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 09:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F9888540
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC220FA90;
	Thu, 20 Mar 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXbUlq+b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B671E503D;
	Thu, 20 Mar 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460029; cv=none; b=hWJm3QT8TpgLzh9C0jcxv85iqjHlHXl1kesDX8flnTgkkuQnX/regr8s/xEGSE+04A0Z0lVVUsPjeXOupy/VCA7OeldlfX5XCW5y5msKSM+J8A/70P3zk7dhaZVpKfhhz7FKNA8K55x5uKpI7/8+jIcjBWckuLnpKb2M00fSWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460029; c=relaxed/simple;
	bh=vpp98wUQSHNs/QKai9FKUYpZCK2bmHQh0DZXd3+SGyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iwf2Yc26WQb6/F+wpMPqliNkBx+tBWRyrKS8BGUMJkGj5q8777CRpF2IrXEGIu6Cws5pYvEErJaXS3Jv5+vRIFDV/EGFdXzPAQzI6jYfRWgHSFc+dwBqlDeFOKXvPdf1SryiU2dXpugtUiIxtWNVgP8unSxkCZQqFyE9Ha96eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXbUlq+b; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so663124a91.1;
        Thu, 20 Mar 2025 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742460027; x=1743064827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dVd/ZBXvrG6lnjcdZIt7lLZlK0ue2XgKgxaXwwHZOX8=;
        b=gXbUlq+b8WGZZdbFwP7d5H1o4Q66KH5WaFOFtCIIzmBRjc6SjNehzkibwimexk43qM
         adLsmJn9ZcLXuaT4PnFSAheh1J71RSLCNTTGGECNueub7FMEPTG0JMwKH+97mJ6PKVX/
         71SYpBTdXDtsFY8YmHAeQ/Zn/xLekWVvGRZYfRswkfRwT22fKiAMgYM+a7OZuAy5e3bv
         kLU7IqtsoZoU4gKiW48wgUcQ6osegtRNcFKbMN+cpcCZeS5GrqtiFevkUTWqCr8xW2+K
         hWtFquhMW6ypMqNlitxO+NiyWc/Up234iXWduvUn19Ba1QmWMHU7SJ0zGLK+XO33WYlr
         /eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460027; x=1743064827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVd/ZBXvrG6lnjcdZIt7lLZlK0ue2XgKgxaXwwHZOX8=;
        b=N2l/+6rOrwLuQPMRexMYqsT+IK9zoG8dSFSrlF+D0phV2ZeX5mJhfk+6d0DM1dr9E1
         TQwV/W0OyPCTb4UC96b+IDenEqalkCq3hTQe5sZ7TxRRFLo2HN5zA4WK4/zaQQ0o8y3e
         ymN7lH/CDuPu0mk479v6fslFlH6p6t5u4/Onh0CrvdMy9g4YDsHTleKxccdlK2+r3328
         gMC2ONTmNeYNyZWsP9HVSYOTsiBDz/6FMAYAxjW1kEgIEBoWB2xg9p+1QPv+b+pZGXwX
         V0nqkInavJNFZ3WgFwrSdotOS/iRv0NEXXquBzMwsEhPj5Dxe1JDDqa/73sZ8w8VCRbr
         +1sw==
X-Forwarded-Encrypted: i=1; AJvYcCVdxiNqY4NO2hV/ecJBc2plUy3lrR+TpoO7MU4ZVHoUslrSw0ClnzHTKKv9jBA/ges4SENEUV4p@vger.kernel.org, AJvYcCWWZzf8L4FZ8D0TOUW2hYc60bm9AVBXBk7lo7Vk8AwwRd6PpyX9xxQh0U4FQZg+PgByPFi8TmkXVx52Yz7U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mVUfPuuznv0fNdVo14UwcxH0eRqtwZZJXX446ojAhm0tNsYl
	G+J6ZoRhD2D43gg9ucuYEhTi7A4pcccSP9IRmmGPdMsnCpU9F2ueJ0C0pBTQMib8KAjUBlTowYq
	Y8845jDJAQpLP2ad3oW9Ve1TjPhM=
X-Gm-Gg: ASbGncsdTXInonTYclAaXD1sqUXwxgne3PUOPMEzbL6WV+aYpxWe0OvgBF3GbKL1QEK
	czTdk2w2+wdGmP3CArkzkzhNr6Uba5nbIDtS+jRBRiq8qJzPwW09/wkITq2qfQQ8rAifIDdDv6k
	MC9k4u+9P4yngRnB0QlaO1OyEV07xIqSDCq6ki
X-Google-Smtp-Source: AGHT+IFnbz5qpFjRctSSuumMXr+KaUxXcHLgw2e5AyzG2DYxcLVSBzkyHZbKqDi1snIiVqAsLymg1Mn94/xMonoJpDM=
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id
 98e67ed59e1d1-301be206e87mr6955304a91.34.1742460026630; Thu, 20 Mar 2025
 01:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-4-jingxiangzeng.cas@gmail.com> <nlnwcpezzfmq4rh7oeckrl5nmc4sszd534bo3cx34rpkadhsph@mqphvl3zyanl>
In-Reply-To: <nlnwcpezzfmq4rh7oeckrl5nmc4sszd534bo3cx34rpkadhsph@mqphvl3zyanl>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 20 Mar 2025 16:40:15 +0800
X-Gm-Features: AQ5f1Joe6olwPvvRJlL2ei-eL43OXN8oSn3ipfQx4xJ7f7Wo8JpKOMpsLQNudSM
Message-ID: <CAJqJ8ihCoeHegvKtyq1oJ45+Y4XmxbjnMyxivGViYSTY1cD2iw@mail.gmail.com>
Subject: Re: [RFC 3/5] mm/memcontrol: do not scan anon pages if memsw limit is hit
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	kasong@tencent.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 03:36, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> On Wed, Mar 19, 2025 at 02:41:46PM +0800, Jingxiang Zeng wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > When memory recycling is triggered by the hard watermark of
>
> What is hard watermark?

memory.memsw.limit_in_bytes.
>
> > memsw, anonymous pages do not want to be recycled any further.
> > This is consistent with the processing method of cgroup v2.
> >
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
>
> Is this patch orthogonal to the series or is it needed for v1 as well?

Yes, it is needed for cgroupv1 as well
>
> > ---
> >  mm/memcontrol.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c1171fb2bfd6..623ebf610946 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5072,14 +5072,21 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> >
> >  long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
> >  {
> > +     struct page_counter *pg_counter;
> >       long nr_swap_pages = get_nr_swap_pages();
> >
> > -     if (mem_cgroup_disabled() || do_memsw_account())
> > +     if (mem_cgroup_disabled())
> >               return nr_swap_pages;
> > -     for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
> > +     for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> > +             if (do_memsw_account())
> > +                     pg_counter = &memcg->memsw;
> > +             else
> > +                     pg_counter = &memcg->swap;
> > +
> >               nr_swap_pages = min_t(long, nr_swap_pages,
> > -                                   READ_ONCE(memcg->swap.max) -
> > -                                   page_counter_read(&memcg->swap));
> > +                                   READ_ONCE(pg_counter->max) -
> > +                                   page_counter_read(pg_counter));
> > +     }
> >       return nr_swap_pages;
> >  }
> >
> > --
> > 2.41.1
> >
>

