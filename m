Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1946A1D739A
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgERJNn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 05:13:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47090 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgERJNm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 05:13:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id w7so10843801wre.13
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 02:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jz6eHl43qDHTOeA1JCzvsRV/C+FflAiTtYEC302zho=;
        b=hlPFRHe52QRreYItgmmLCrO1dmjgvvLVr6PbCobDMd8tJ53EuPtT8onv7cB1JxiWxq
         eRa8TKMj3WgfKVH/SSs0s4UBMQHs5UN+vopWgKu8nmvzoJ+C1GajiHqf6erFCo04OWfi
         YMLd7VmuLx4bO/JDYFrxyaAdRhQRgJcVKB2C1qauPx/wSqvd6Kq55A/4DbGU0m4spXiZ
         OgGkebNBQqVQGjXEr66GkT5HotQq/GFqKg3IgakpoIWTI5Dn+AOfQ6ZcgALoIKY3ke4o
         fu+Cd8fwFAj1zXJEXfOCdhUaCOmLFgd0V7r7oNckq11MoL8CTbR5zaRPflj8bDHTzEtD
         3lPg==
X-Gm-Message-State: AOAM533nbyzjm8LsUGcZQfSl6vB/X3dy+wta2DDeK4SCmJY2jTuHjQLN
        do5Rl1OzJxgbwHULrTen+Ds=
X-Google-Smtp-Source: ABdhPJwfSfxfP1lzmy3Ft9wV578jV9aJ4N8b9j3zAuaeDWzaZqZo9LZ73YuFZ/td2317ZqW04jG9fA==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr19121698wrt.415.1589793221015;
        Mon, 18 May 2020 02:13:41 -0700 (PDT)
Received: from localhost (ip-37-188-176-234.eurotel.cz. [37.188.176.234])
        by smtp.gmail.com with ESMTPSA id o24sm3517098wmm.33.2020.05.18.02.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 02:13:40 -0700 (PDT)
Date:   Mon, 18 May 2020 11:13:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Zefan Li <lizefan@huawei.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200518091338.GA32497@dhcp22.suse.cz>
References: <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
 <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
 <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
 <20200515065645.GD29153@dhcp22.suse.cz>
 <bad0e16b-7141-94c0-45f6-6ed03926b5f8@huawei.com>
 <20200515083458.GK29153@dhcp22.suse.cz>
 <CALvZod64-Yc0firp9C8MNhEaF6FTiKmSx2B3HOrvi8GkyOD-7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod64-Yc0firp9C8MNhEaF6FTiKmSx2B3HOrvi8GkyOD-7g@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 15-05-20 09:22:25, Shakeel Butt wrote:
> On Fri, May 15, 2020 at 1:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 15-05-20 16:20:04, Li Zefan wrote:
> > > On 2020/5/15 14:56, Michal Hocko wrote:
> > > > On Thu 14-05-20 15:52:59, Roman Gushchin wrote:
> > [...]
> > > >>> I thought the user should ensure not do this, but now I think it makes sense to just bypass
> > > >>> the interrupt case.
> > > >>
> > > >> I think now it's mostly a legacy of the opt-out kernel memory accounting.
> > > >> Actually we can relax this requirement by forcibly overcommit the memory cgroup
> > > >> if the allocation is happening from the irq context, and punish it afterwards.
> > > >> Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
> > > >> objects from an irq.
> > > >
> > > > I do not think we want to pretend that remote charging from the IRQ
> > > > context is supported. Why don't we simply WARN_ON(in_interrupt()) there?
> > > >
> > >
> > > How about:
> > >
> > > static inline bool memcg_kmem_bypass(void)
> > > {
> > >         if (in_interrupt()) {
> > >                 WARN_ON(current->active_memcg);
> > >                 return true;
> > >         }
> >
> > Why not simply
> >
> >         if (WARN_ON_ONCE(in_interrupt())
> >                 return true;
> >
> > the idea is that we want to catch any __GFP_ACCOUNT user from IRQ
> > context because this just doesn't work and we do not plan to support it
> > for now and foreseeable future. If this is reduced only to active_memcg
> > then we are only getting a partial picture.
> >
> 
> There are SLAB_ACCOUNT kmem caches which do allocations in IRQ context
> (see sk_prot_alloc()), so, either we make charging work in IRQ or no
> warnings at all.

OK, I see. I wasn't aware that those caches are used from IRQ context.

-- 
Michal Hocko
SUSE Labs
