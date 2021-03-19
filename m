Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6581342372
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCSRgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCSRgT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 13:36:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDA3C06174A
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 10:36:19 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l13so7330268qtu.9
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tfsvGpLK+CuDrVdmeV4WHbj8Vk5nJ4Roy68oEY4gfyA=;
        b=WTDYAcQY8XXEtUVTWUYj1UZ9W4ojknZfX8LZVQvAAN+HkIuawO0/AttbRhKWjPhcCC
         GJSpxDkjmrAIKSM3t+ZMvrAIiU8XS5eUyfJMf3pjpDY4fNEw9o1/6DipQNLjxUjLYkr/
         Y/x0nBvtvz8+0b3N/n1DzXM3jPy+2DXKL7zO/jDkb8uFzpMo32zJc4twjzrEt8VdXu0Y
         qHwMWr+03PLl/retLPKsVjOxWpAhEEQGQWd7LiZGnEU6QWGDez8ZSzCRTW+ovn46V8Sp
         QDv/j+Ip75kO9C8B63mcq6JqS/ZvfLW0X1H8uvyZXvCAb3EYJImlDVMkEgQfvGgt5m3r
         YxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tfsvGpLK+CuDrVdmeV4WHbj8Vk5nJ4Roy68oEY4gfyA=;
        b=Ij5DLBgF3rj/QH24rklVN0Y9q2i+YJz4ezRKnAnOHFxVy6bjhQr9oJfrjEsx1R9uXL
         xo9BZEd28ktreampflFKjJzuwDbf5GwrllPog/mDQ/lQsmphP7Z7VFPTNDVUoW0XEtyO
         QtdoYZZnh8jzdDbwawH4GAuf3/abokN+p2ihsb4VB0MMvuRqOr2a8q5LQsuUEGD2w0ZD
         v7wiBTBTs6aVlIgjTR7c0n5il9Z2t/FKHVWWHDP5lGi0jOC4BmzDC3aw0eShe1blxwqs
         nGtVast5++2cc9Z4Awx87InWJ2l2Aam4k9H06PBnnOVWmEjNjCpKYJtSwwoGoDq+++tN
         BrbQ==
X-Gm-Message-State: AOAM530juRcTy3//syc17+qfyFdb1vLTAPob/lU8glcIvx1H5YGjLf6w
        wwoMTLFwvGY5SlL8F7P93yee1Q==
X-Google-Smtp-Source: ABdhPJztEQ6+2EmkeqiPV4c/LJI6bVpVMS3Y2j1tG0aYG7IDJ7uN/f76YXpplQssD8vVmn+tsRisJA==
X-Received: by 2002:ac8:1009:: with SMTP id z9mr9201531qti.128.1616175378314;
        Fri, 19 Mar 2021 10:36:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:18e3])
        by smtp.gmail.com with ESMTPSA id h12sm5128779qko.29.2021.03.19.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:36:17 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:36:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcontrol: deprecate swapaccounting=0 mode
Message-ID: <YFThD2qnSCx5MJEh@cmpxchg.org>
References: <20210319054944.50048-1-hannes@cmpxchg.org>
 <20210319054944.50048-2-hannes@cmpxchg.org>
 <CALvZod6HYfoSnBoq7JGW1ifLmLMmwSAyCqjh+bJ6L9evAPVGLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6HYfoSnBoq7JGW1ifLmLMmwSAyCqjh+bJ6L9evAPVGLQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 06:49:55AM -0700, Shakeel Butt wrote:
> On Thu, Mar 18, 2021 at 10:49 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > The swapaccounting= commandline option already does very little
> > today. To close a trivial containment failure case, the swap ownership
> > tracking part of the swap controller has recently become mandatory
> > (see commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> > integral part of memory control") for details), which makes up the
> > majority of the work during swapout, swapin, and the swap slot map.
> >
> > The only thing left under this flag is the page_counter operations and
> > the visibility of the swap control files in the first place, which are
> > rather meager savings. There also aren't many scenarios, if any, where
> > controlling the memory of a cgroup while allowing it unlimited access
> > to a global swap space is a workable resource isolation stragegy.
> 
> *strategy

Will fix :)

> > On the other hand, there have been several bugs and confusion around
> > the many possible swap controller states (cgroup1 vs cgroup2 behavior,
> > memory accounting without swap accounting, memcg runtime disabled).
> >
> > This puts the maintenance overhead of retaining the toggle above its
> > practical benefits. Deprecate it.
> >
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> [...]
> >
> >  static int __init setup_swap_account(char *s)
> >  {
> > -       if (!strcmp(s, "1"))
> > -               cgroup_memory_noswap = false;
> > -       else if (!strcmp(s, "0"))
> > -               cgroup_memory_noswap = true;
> > -       return 1;
> > +       pr_warn_once("The swapaccount= commandline option is deprecated. "
> > +                    "Please report your usecase to linux-mm@kvack.org if you "
> > +                    "depend on this functionality.\n");
> > +       return 0;
> 
> What's the difference between returning 0 or 1 here?

It signals whether the parameter is "recognized" by the kernel as a
valid thing to pass, or whether it's unknown. If it's unknown, it'll
be passed on to the init system (which ignores it), so this resembles
the behavior we'll have when we remove the __setup in the future.

If somebody can make an argument why we should go with one over the
other, I'll happily go with that.

> >  __setup("swapaccount=", setup_swap_account);
> >
> > @@ -7291,27 +7287,13 @@ static struct cftype memsw_files[] = {
> >         { },    /* terminate */
> >  };
> >
> > -/*
> > - * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
> > - * instead of a core_initcall(), this could mean cgroup_memory_noswap still
> > - * remains set to false even when memcg is disabled via "cgroup_disable=memory"
> > - * boot parameter. This may result in premature OOPS inside
> > - * mem_cgroup_get_nr_swap_pages() function in corner cases.
> > - */
> >  static int __init mem_cgroup_swap_init(void)
> >  {
> > -       /* No memory control -> no swap control */
> > -       if (mem_cgroup_disabled())
> > -               cgroup_memory_noswap = true;
> > -
> > -       if (cgroup_memory_noswap)
> > -               return 0;
> > -
> 
> Do we need a mem_cgroup_disabled() check here?

cgroup_add_cftypes() implies this check from the cgroup side and will
just do nothing and return success. So we don't need it now.

But it is something we'd have to remember to add if we do add more
code to this function later on.

Either way works for me. I can add it if people think it's better.

> 
> >         WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
> >         WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
> >
> >         return 0;
> >  }
> > -core_initcall(mem_cgroup_swap_init);
> > +subsys_initcall(mem_cgroup_swap_init);
> >
> >  #endif /* CONFIG_MEMCG_SWAP */
> > --
> > 2.30.1
> >
