Return-Path: <cgroups+bounces-5818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88569ED3B0
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01688188C105
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65442203719;
	Wed, 11 Dec 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnwT/Dg5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37B1FF5FF
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938264; cv=none; b=Dkcz9Qp0v0UCbTq1X45Jg90j0qL701p2d9ESBWBVtBecYtdaQjBruq1vN+CpShEiFurQSZr7oM8Po/9VjP4DjTE6afYCKS2i/0bkxZWi+mZ2lqUf5rTSyEwApfA9jFey+ODEJo9d6rNj4RJHUZZUftunMmNzwzUo/eVKLGa7wU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938264; c=relaxed/simple;
	bh=rt3s76W+9Zi5yA6yHqiCj+o8MvMdLv3N86q+d4MzgJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk+x7L50/bJziabkUgZGgn6PA6PugT/JsuYqTx43JFJj74MFBd/weTPXSThBTEnCupI/xcet/ybdQMRzTiJ2YuOU00CPmxxSI+gGIG+L4zUXdHxx9Xf2jkgCSXWlhn5oNNhIU8po1F6/X8lyUUvqZC8NK98QMJLgHl1LNvgIqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnwT/Dg5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467918c360aso5974851cf.0
        for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733938261; x=1734543061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvlksTTe4afr3/kaJfTO3PgOYby42yPcNt+SJURg6mQ=;
        b=cnwT/Dg5AycTc+Jhc+bjQgTRYW5YcBLTvTzMMtZGm27NIi4lfJBKWm8F5SCmjKqpfJ
         MJ9K+SWrIZvox1EW+QA4nVxsOZtfL2YzAx5c1/HqdeJOfLWv+YxhbMgfTFczA6q5nkaP
         pIpgrWKi1TfbCxbOh1/RwDw14zZYYi7YJsN4vsVlU6mULl8QbNFwR8bMyAmhD9GskG9z
         hksFC/ccDjNy1MHXFtpmEKyISj/7Z5MsXXFMEG3hclP9ZvXFubhpWUYyzjm22Vi0c4pA
         dhbHJDkx6tXoQO+YCksHcPIaxkTH0seGsjqhKO8PAvGvpXUIdOQLLEmRWE6korbXGmLq
         TjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733938261; x=1734543061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvlksTTe4afr3/kaJfTO3PgOYby42yPcNt+SJURg6mQ=;
        b=WSGhAs84nLvTZ6hmHPwU0vtoSLR+os8whHnUtQ1ezCVf1h1GlIlzlmWTxazMFTWiCb
         4PrvOBo2Le+1tPPmbNDVGFz88t6wi6n67mZ7Dbp8lxmf0Ia2kmMQDQJ134FKLmUKwoTN
         zuXL7nw1PU5kFlUxC/EtdiOh/wBiXgYQv6sokLHW93Gt0DbwO0JmCeP+n9Mw4iLlzV5x
         eKIKq6NsAp7hL4W44ZBE1v7bhUjboOluGsxXU9ue8LNb0z1TfSokS+e8dp0uWC7cNcsc
         08k4G+4eSRVN6keaNgNrPP0lIQoIOA2Oy3++P+Lx4zFdMFMYfQB86C4ls1HbFo/BVnyA
         zLKw==
X-Forwarded-Encrypted: i=1; AJvYcCXG4YHUad36RJutVorO8abplywUpCSx0iVTCw6uIdZ29TmJp7REXgDt8uY74r70286m+k3dXnrx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5tIebnWQUR/z6sdS6a9v7A9KYX7yXtSlUN/jS8BIdv/pfQ0g
	saDTofCYcBdMFZIrFUn0etuxICJeAQ8VbvTE2v7PDO/TMqc6CaPEP7HyPIBXw7lXh4ooaRrKJl5
	J7qAC05GA4yZ1PiZjAH9+LkgPqsaNj2E28h8Z
X-Gm-Gg: ASbGncvEH/tUiGjx0uCURvzGFY9FuvNhhxMMO7HS6h+72gVwpPqdqnTPbEdOVD+2fgB
	q5dIPkQ95mEY8dItKsjZuv6IxeV9DPBPj
X-Google-Smtp-Source: AGHT+IFj9LClCMmZ69TqOKCIC0RBNocfDv/WTyS0fCziCGn3Frk9SIkyrO/1KPe0mOksZkvCPqdSz3OmFIWTxG2+hzA=
X-Received: by 2002:a05:6214:1306:b0:6d8:7ed4:3367 with SMTP id
 6a1803df08f44-6dae38f40e0mr2118816d6.19.1733938261283; Wed, 11 Dec 2024
 09:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105336.380cb545@fangorn> <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
 <768a404c6f951e09c4bfc93c84ee1553aa139068.camel@surriel.com>
 <CAJD7tkYpk4kZChj9f-2EMp0XET6OUNbHqfVBgdFTEMnN+iomww@mail.gmail.com> <6bc895883abca3522c9efc0c56189741194581e5.camel@surriel.com>
In-Reply-To: <6bc895883abca3522c9efc0c56189741194581e5.camel@surriel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 11 Dec 2024 09:30:24 -0800
X-Gm-Features: AbW1kvberlqxyKgnnbVtgJmwtiGAslvqeYrjbm8WURKxHBJnjAHFTNfqYnwCkHA
Message-ID: <CAJD7tkZ9gSxdPUCgz_NaHSDPTC+HEhxNRbinp619sNSshScJ0A@mail.gmail.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
To: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:20=E2=80=AFAM Rik van Riel <riel@surriel.com> wro=
te:
>
> On Wed, 2024-12-11 at 09:00 -0800, Yosry Ahmed wrote:
> > On Wed, Dec 11, 2024 at 8:34=E2=80=AFAM Rik van Riel <riel@surriel.com>
> > wrote:
> > >
> > > On Wed, 2024-12-11 at 08:26 -0800, Yosry Ahmed wrote:
> > > > On Wed, Dec 11, 2024 at 7:54=E2=80=AFAM Rik van Riel <riel@surriel.=
com>
> > > > wrote:
> > > > >
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -5371,6 +5371,15 @@ bool
> > > > > mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > > > >         if (!zswap_is_enabled())
> > > > >                 return true;
> > > > >
> > > > > +       /*
> > > > > +        * Always allow exiting tasks to push data to swap. A
> > > > > process in
> > > > > +        * the middle of exit cannot get OOM killed, but may
> > > > > need
> > > > > to push
> > > > > +        * uncompressible data to swap in order to get the
> > > > > cgroup
> > > > > memory
> > > > > +        * use below the limit, and make progress with the
> > > > > exit.
> > > > > +        */
> > > > > +       if ((current->flags & PF_EXITING) && memcg =3D=3D
> > > > > mem_cgroup_from_task(current))
> > > > > +               return true;
> > > > > +
> > > >
> > > > I have a few questions:
> > > > (a) If the task is being OOM killed it should be able to charge
> > > > memory
> > > > beyond memory.max, so why do we need to get the usage down below
> > > > the
> > > > limit?
> > > >
> > > If it is a kernel directed memcg OOM kill, that is
> > > true.
> > >
> > > However, if the exit comes from somewhere else,
> > > like a userspace oomd kill, we might not hit that
> > > code path.
> >
> > Why do we treat dying tasks differently based on the source of the
> > kill?
> >
> Are you saying we should fail allocations for
> every dying task, and add a check for PF_EXITING
> in here?

I am asking, not really suggesting anything :)

Does it matter from the kernel perspective if the task is dying due to
a kernel OOM kill or a userspace SIGKILL?

>
>
>         if (unlikely(task_in_memcg_oom(current)))
>                 goto nomem;
>
>
> > > However, we don't know until the attempted zswap write
> > > whether the memory is compressible, and whether doing
> > > a bunch of zswap writes will help us bring our memcg
> > > down below its memory.max limit.
> >
> > If we are at memory.max (or memory.zswap.max), we can't compress
> > pages
> > into zswap anyway, regardless of their compressibility.
> >
> Wait, this is news to me.
>
> This seems like something we should fix, rather
> than live with, since compressing the data to
> a smaller size could bring us below memory.max.
>
> Is this "cannot compress when at memory.max"
> behavior intentional, or just a side effect of
> how things happen to be?
>
> Won't the allocations made from zswap_store
> ignore the memory.max limit because PF_MEMALLOC
> is set?

My bad, obj_cgroup_may_zswap() only checks the zswap limit, not
memory.max. Please ignore this.

The scenario I described where we scan the LRUs needlessly is if the
*zswap limit* is hit, and writeback is disabled. I am guessing this is
not the case you're running into.

So yeah my only outstanding question is the one above about handling
userspace OOM kills differently.

Thanks for bearing with me.

