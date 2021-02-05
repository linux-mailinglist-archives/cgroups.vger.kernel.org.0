Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3D311550
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhBEW2N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhBEOV5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 09:21:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F1DC061356
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 07:59:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d3so10517081lfg.10
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHFnyH790m7nlnJSVskIB0W5pLoFkbMx9bIb16KHmNs=;
        b=Y1n3cckxp8Sv26Yg2Kxgb2craA8eH4oamlcKNyGu6Cq1ETKGeIjpz1wSLG34yCwBx9
         8jCz4hYbdEzrAX0HgzdJIOZAxBXC75We1qql4WXxrna9TC7NdTBJ4AQonUGKLBiKsjI4
         K7eE3O2fHwXc9MFhnrN0WYaNbqDRD0jwhifUYAb0N4UDEKiIlSTtsc4gAJogahjk9yU4
         H2yVdG7mMrcZ+vdTepWBHEqEjQs47HZ21dfvcgETV8ovaJ59vY1rQbi4dzKp+swccwCE
         yoKNg1vQ7f8haUoV7EPCiMm4JXjqOzywrdWE8hRgawdHbFgXUy6MoznmNBJSqTLnnPlU
         qETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHFnyH790m7nlnJSVskIB0W5pLoFkbMx9bIb16KHmNs=;
        b=MG8RdQ7IJr/PaNZqtz8KUxtMFatDJNufGwi5NVnuiXrwXoMSaFk9zbzF/8HE57nM8c
         yRO8ygPEaVrrwVRD6CwuUND1mL3kQ3gcgXMzD8XMezrIL1hwOhXLmWLjLWHc1u6oBjS4
         Zmp2QdvcSXuBDhTtB0cOR4ARvIwakuzFg2uwQuRkrwQHKfXxRVqwyYhbDNDuVPasMkQY
         PU+xd+SYZSivW63fB5S/7oYse3hcczNWhI44dwjW1FOCgzHva5MXHH4On3+vXmfEN10/
         GGZ8EgEYcdM27D1yJwNnLzLyOVZLiQthwvanU4E63+EqjRUlj9FS0qFzaRQb/YFzY/3j
         oLEA==
X-Gm-Message-State: AOAM532Md2pJnXOenZOHrvLhR6tJeVGgnJKPreIwFX6L08yhwKHNBOps
        o/t6wFAl8W+mxndp338QXeGqKUBtm57JCUv6xMYxzQ==
X-Google-Smtp-Source: ABdhPJynHravulos9kvEdqamWTrNiSmYhNidO9oViyVVCdPE2tLwU/SEvGYCabUTT73f1QcoYRDQDCmbc0htVFMoh9Y=
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr2870906lfn.117.1612540757833;
 Fri, 05 Feb 2021 07:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz> <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
 <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
In-Reply-To: <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Feb 2021 07:59:06 -0800
Message-ID: <CALvZod65SY3yVXSwxO02VCZeEg9KsBqq9_Ph3pq2gfQ0eH=kFw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
To:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Cc Roman

On Fri, Feb 5, 2021 at 2:49 AM Michal Hocko <mhocko@suse.com> wrote:
>
[snip]
> > > > Also, css_get is enough because page
> > > > has a reference to the memcg.
> > >
> > > tryget used to be there to guard against offlined memcg but we have
> > > concluded this is impossible in this path. tryget stayed there to catch
> > > some unexpected cases IIRC.
> >
> > Yeah, it can catch some unexpected cases. But why is this path
> > special so that we need a tryget?
>
> I do not remember details and the changelog of that change is not
> explicit but I suspect it was just because this one could trigger as
> there are external callers to memcg. Is this protection needed? I am not
> sure, this is for you to justify if you want to remove it.
>

It used to be css_tryget_online() which was changed to css_tryget()
and from the discussion at [1], it seemed css_get() would be enough
but we took a safer route.

Anyways, I think we can either take the page_memcg_rcu() route or put
explicit restrictions with page lock or lock_page_memcg() to guarantee
page and memcg binding. I don't have a strong opinion either way but I
think removing restrictions in future for new use-cases will be much
harder, so, page_memcg_rcu() approach seems more appropriate at least
for now.

[1] https://lore.kernel.org/linux-mm/CALvZod5pAv=u8L2Tgk0hDY7XAiiF2dvjC1omQ5BSfzFu_2zSXA@mail.gmail.com/
