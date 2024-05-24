Return-Path: <cgroups+bounces-2997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598A8CE93C
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669F61C209A2
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756192033E;
	Fri, 24 May 2024 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxWdXENZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64651BF3F
	for <cgroups@vger.kernel.org>; Fri, 24 May 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572220; cv=none; b=ozbW2CxgbJTT4zaXvUJRJb+UnzTrQLcl6muBIxHEzl/tKMdCpq+tk1BU+rhHX9o03Ky1hUXIaaLYAZI26GVTuK6lZOH15riV5X7Qm4RrT0bhL43rz2qelsGsFEKOKEDc5CMjB2JLDzfIkWeD0ZSHI1dpWM6/kXV9mTEvY8sWSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572220; c=relaxed/simple;
	bh=ibcYNZiSaxk9EBTq4JLd0V3zMQ/xYLqk8gCrm4L9wgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smDrZE1SvsLGq4tr43vvho98Q29RSy3qYD1JxvhZuMfTuN8haBzLtrQzK+qrAmiKfMTOUQQTJS4BkLrLMa9dHUSOqYV0IzSZ3X+cFcJczGs/4YaHnmjQI7GgEpHcTeI+mDnWbeoGg2z0NHdNXTYI+uSi+QBEygGiBpmuALXEcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxWdXENZ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4e503983fso3386154276.2
        for <cgroups@vger.kernel.org>; Fri, 24 May 2024 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716572218; x=1717177018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUyEyvPVhRUH4S+rRRLUtExiOqqOJDk147Gd3ruQKmU=;
        b=yxWdXENZBQUAb7eCw7tEuGoiUNWDM/XpTgAl0uOxI42E9faLZFDuRUD18AXmyi4SJQ
         Dnbroej4fqJ+78HTSJSkhPKvyFL5B7hmpv6I9Mf7XgXrOCrTiuLUp3P+HGavYmA7mZD/
         jA/pEjmJauBnCDEsaUjA3EG30ZVWwVzvvTEYsIs5oC0fOR09bRRpJBNJcAOcjK4+7j4X
         QU34xYIv1laWqn0tFslRR0tE5GNC0Hy8Ied3Lfj7tmL7dRpkbAUAF7aN0FyQTMMi2pMG
         FGDfUIneELF0tv1pMaxLROl3tVSuLupCjfz+SrGMcm2zulAqckK+jQVoDTs0xoHeh0Da
         3+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716572218; x=1717177018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUyEyvPVhRUH4S+rRRLUtExiOqqOJDk147Gd3ruQKmU=;
        b=OsJkjrNHCGZpsLoKMWZg5edb//JkNR1FvI3O4jCchS3zKnlDtj11r95SjXBb1lB4YH
         eEUPvNqXTZGCxsCfK7dngxRKj3+g+YGwXdGE+XXFeZ6k2AZLd0hbS7b4e5g2+YTAiLrz
         w3EMXRNOHGq/C2gphCJe4xRgXy6kb+2vPHVBa/rsPpkHmmoLmJ39DgQI8vbQ62DkSyH9
         9rAdh/FuLobQFA/JinezlSOSrRMdV2wKd0NnVV5EjNidEy8r7/GhwXz4PtM+rdbdfA+U
         8ew2KTpr1rl3EUQ2G/DMQy3nAk2h/CfWn2VchM44/5l4mTx038CjgAAkfeG5qCmTns8O
         2nwg==
X-Forwarded-Encrypted: i=1; AJvYcCUrtWc1bcuuAGFlR4PpTa0crDPV32980+9yHAo/G7zrckHJhia7A4N6xh2SChYjbbXdyRpTVy7Mhi2PchK8L0Ln7FehvZlQVA==
X-Gm-Message-State: AOJu0Yy+CBDwThR9BzUi8drUCLf6W9ltG7vZrrM+O38JWHo+e9kEceGm
	KDcHylBoWyBuYVRS/0DB16xVi+3jJGKC6gR66+VlJwikBJ198xwppWADOd0UTF3K783U+7ybAek
	xzfT4nkZN9Mm7fd9uCODpEgUj8/H/HjBz8z0g
X-Google-Smtp-Source: AGHT+IFatYprpN2Za2quSkeGQqvvQgPAgx65FQ0QEqjzcX9e6NullPqgV+zJ3Og0iSrW+IzIAN6KhKXpiE3QPe4WRxA=
X-Received: by 2002:a25:b845:0:b0:de6:1057:c85f with SMTP id
 3f1490d57ef6-df7721890b4mr2711368276.22.1716572217394; Fri, 24 May 2024
 10:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519174650.559538-1-tjmercier@google.com> <h5xdtfh7dc4rjh74b4cwkpjszro73hfbxzdobwtivyx4hl4hyn@p5lp5h5gzjuj>
In-Reply-To: <h5xdtfh7dc4rjh74b4cwkpjszro73hfbxzdobwtivyx4hl4hyn@p5lp5h5gzjuj>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 24 May 2024 10:36:45 -0700
Message-ID: <CABdmKX149mbOkjo6fwZdx1LKX+xXH1TicUx+92Ud99RS9hSy7A@mail.gmail.com>
Subject: Re: [RFC] cgroup: Fix /proc/cgroups count for v2
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 7:23=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
Hi Michal, thanks for taking a look.

> On Sun, May 19, 2024 at 05:46:48PM GMT, "T.J. Mercier" <tjmercier@google.=
com> wrote:
> > The number of cgroups using a controller is an important metric since
> > kernel memory is used for each cgroup, and some kernel operations scale
> > with the number of cgroups for some controllers (memory, io). So users
> > have an interest in minimizing/tracking the number of them.
>
> I agree this is good for debugging or quick checks of unified hierarchy
> enablement status.
>
> > To deal with num_cgroups being reported as 1 for those utility
> > controllers regardless of the number of cgroups that exist and support
> > their use,
>
> But '1' is correct number no? Those utility controllers are v1-only and
> their single group only exists on (default) root.

Sometimes? Take freezer as an example. If you don't mount it on v1
then /proc/cgroups currently advertises the total number of v2
cgroups. I thought that was reasonable since there exists a
cgroup.freeze in every cgroup, but does freezer really count as a
controller in this case? There's no freezer css for each cgroup so I
guess the better answer is just to report 1 like you suggest.

>
> > @@ -675,11 +699,19 @@ int proc_cgroupstats_show(struct seq_file *m, voi=
d *v)
> >        * cgroup_mutex contention.
> >        */
> >
> > -     for_each_subsys(ss, i)
> > +     for_each_subsys(ss, i) {
> > +             int count;
> > +
> > +             if (!cgroup_on_dfl(&ss->root->cgrp) || is_v2_utility_cont=
roller(i))
> > +                     count =3D atomic_read(&ss->root->nr_cgrps);
>
> I think is_v2_utility_controller(ssid) implies
> !cgroup_on_dfl(&ss->root->cgrp). I'd only decide based on the
> cgroup_on_dfl() predicate.
>
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -2047,6 +2047,8 @@ void init_cgroup_root(struct cgroup_fs_context *c=
tx)
> >
> >       INIT_LIST_HEAD_RCU(&root->root_list);
> >       atomic_set(&root->nr_cgrps, 1);
> > +     for (int i =3D 0; i < CGROUP_SUBSYS_COUNT; ++i)
> > +             atomic_set(&root->nr_css[i], 0);
>
> Strictly not needed, non-dfl roots are kzalloc'd and dfl root is global
> variable (zeroed).
>
> HTH,
> Michal

Thanks, removed. I'll resend this with these changes as a PATCH with my SoB=
.

Best,
T.J.

