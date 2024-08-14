Return-Path: <cgroups+bounces-4283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17894952611
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 01:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4188D1C21434
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 23:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DFB148305;
	Wed, 14 Aug 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq9uIHw7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BB13C820;
	Wed, 14 Aug 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676608; cv=none; b=KcMDwVohasaZ7k+Z/KbXD6IZPPBP8qCwOw76bfcG/p39LURV0Y7hP5EjD/9dUH7R9WldUrcNg9jG4Z6K1M+win9d/rE3FVyErD4VAdAhimA8lL1mjulhE6woufmKi3KSsJoOX27mm+FPCsfRZAg5S9aeTa+hA9yI0Ifd+16L5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676608; c=relaxed/simple;
	bh=CSdwfR1oJWa/9mmNmOt/w0AcbH/8rOyV+raQPm8sLYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r032TcWjpXUZs2VyE8kwQk2OIfnHNjWW6suOMgA17pL5tSxmWIY3ry+Q/6ZcB4/uWdq382O92cjXkYu2d+R+pqMsOgo0VrnVHtyETmIR+P8g3wUlV861SFlzK98xhX1mlJv0zn0CnSFQxth5GW4uTWfoh3TypO3eYqgAxsuhW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq9uIHw7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db23a60850so232129b6e.0;
        Wed, 14 Aug 2024 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723676605; x=1724281405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBlJcNHTXrvCXg2KqHerDo3Dz+CUwdwlIOy68HBZaZQ=;
        b=nq9uIHw7lNWMTSbK6RFXnx7ExdTKQ2KSXQWdC4U54BKYNkSe/4eRGWEqlCt1b/BzZX
         +mvqmxpZw8xeP9xu2FsblzjSIxi1KV2Ok4A9vApaJNMYXOFFEYuAyLSWDfoSbkDN1Utg
         nviE2dVoCpwxFHUlrW5zt+RQip0v3TyF1CtriTIXAYId4vZpl5lyU+zH125YF0KlSaHV
         80jAhkDFK+auaUqxDUSOsz0801b6JfBdRzUc6942Fnwg55yyiHdgousvcOul0xcu9U+t
         5wsFDCog/cyq82SC70YJOIPB1KxvUAxVyNo0ovXZvyvVsRM4d9Sy3zmIpf4UXoNaMcaZ
         +B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676605; x=1724281405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBlJcNHTXrvCXg2KqHerDo3Dz+CUwdwlIOy68HBZaZQ=;
        b=Vu4NI0uJ63XP7UUOGUmHkCHP7eqqHtYlEF5nSxX1i1ZBmxdx72dCbGmuzd95FrVgTN
         5NK/koVt40P/YAnG4CrA/cx0e32eE4UJEHA5S1lMzH/vI429/WTIZnnfueUWalU6tvzI
         gLY+f5wYsADEJJqS5UUlQA182+bLqjKFqeu4WJAqe6sgzSXOhXjFW8BYBsL9Vs8xXscV
         ZJB+tuAdOFdfusPuo0Jk6AYw78wpes5FqHaeWdEZqXDR8A+TeFSc6kmxJ0fZGKX1tZyH
         3nkoHlNR6YongeiKREDnpqU+j4K/J8QK5O4Dy3xsFKQO6jwlySjl8vMgfoCiG7lfPdyq
         zG9w==
X-Forwarded-Encrypted: i=1; AJvYcCXBd2wTawiMIO1IR/apFINpXB4hyYpSJFSEbsFAHVfaAnjWxBl7gwGXo3PERxPmksAD5vkCnMv8WUMJAcflBvuZErGomtu7nXGeTtVeCwTfo3IAdzQOFKrT1g5YBHz1YWAXbHgyEA==
X-Gm-Message-State: AOJu0YwEXCtHA8rhIRdhejycrg5P3MtCjbqD3+EPe3zkOVHfqC1kDELg
	UgpPb+TtZmxiRPXA9zvzzBzvObkcPCe7FDHOa4iatpRutURGtIsCOCgp6JYB/n3eGHix1Dmw4OQ
	Kelq8EGrDPnubfzA+/3OpH+RWa3w=
X-Google-Smtp-Source: AGHT+IEKmQOIO99Cy2PnIM81KCFOVa4ilM/m0cRNuICz2NTtbhgzxazeUf63/NlAzJ6BqYTxuNKaRq+f3SJXFIotd7Q=
X-Received: by 2002:a05:6358:528d:b0:1b1:a7f4:fee4 with SMTP id
 e5c5f4694b2df-1b1aab8453dmr519220855d.14.1723676604637; Wed, 14 Aug 2024
 16:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
 <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
 <edf4f619-8735-48a3-9607-d24c33c8e450@kernel.org> <vyi7d5fw4d3h5osolpu4reyhcqylgnfi6uz32z67dpektbc2dz@jpu4ob34a2ug>
In-Reply-To: <vyi7d5fw4d3h5osolpu4reyhcqylgnfi6uz32z67dpektbc2dz@jpu4ob34a2ug>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 14 Aug 2024 16:03:13 -0700
Message-ID: <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 9:32=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
>
> Ccing Nhat
>
> On Wed, Aug 14, 2024 at 02:57:38PM GMT, Jesper Dangaard Brouer wrote:
> > I suspect the next whac-a-mole will be the rstat flush for the slab cod=
e
> > that kswapd also activates via shrink_slab, that via
> > shrinker->count_objects() invoke count_shadow_nodes().
> >
>
> Actually count_shadow_nodes() is already using ratelimited version.
> However zswap_shrinker_count() is still using the sync version. Nhat is
> modifying this code at the moment and we can ask if we really need most
> accurate values for MEMCG_ZSWAP_B and MEMCG_ZSWAPPED for the zswap
> writeback heuristic.

You are referring to this, correct:

mem_cgroup_flush_stats(memcg);
nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);

It's already a bit less-than-accurate - as you pointed out in another
discussion, it takes into account the objects and sizes of the entire
subtree, rather than just the ones charged to the current (memcg,
node) combo. Feel free to optimize this away!

In fact, I should probably replace this with another (atomic?) counter
in zswap_lruvec_state struct, which tracks the post-compression size.
That way, we'll have a better estimate of the compression factor -
total post-compression size /  (length of LRU * page size), and
perhaps avoid the whole stat flushing path altogether...

>
> > --Jesper

