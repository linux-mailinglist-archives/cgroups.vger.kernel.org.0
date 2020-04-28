Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0C41BB6FF
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgD1Gtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgD1Gtz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 02:49:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1FC03C1A9;
        Mon, 27 Apr 2020 23:49:53 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb4so9888257qvb.7;
        Mon, 27 Apr 2020 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LDAfY6IMuAEGrWvee7RhilnIfuGLqiwe5VYND28O0Zw=;
        b=NXZIXjwpYXLULNObRahj5gByNuIc0r19/uWT7O/oda8walfipdmJpBY1rPc1D8E4XV
         Mcp5AxJAEhso0Yggwa9MT5aH7XfYpfIGWcpEN73Q5c8eVUJkXLKNkOzv8kS+d6p2/+bi
         MSqgWc2wMs+ad4oOVM/k6Bb3hzv8ZjKuqoWeMfOjn79WRW7GuQhUQKpJkY8MnrC4ADZ7
         XHVb+d9PA9QiMKEayiG9jqLeZr2bvDrNDlMsleqnn0mOFmuTZQFSTCQ+oVp0+Xd2Cs48
         lCHRe4JRhamssskAVpjbzRGiOlB88EYJQcZMmijyfAHcHsHVxYsBwL9LzXPXPeA9aVE1
         euxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LDAfY6IMuAEGrWvee7RhilnIfuGLqiwe5VYND28O0Zw=;
        b=A/MyzoqTsUyFDIIWVnhYk7bf5/2qI4sulM7nDXq5xk2SJAuqOeI3vTd/tN58WlRRnj
         WEIPeSWFvY+DwwPwrcr1gk87zbmTuc4ZMs2oBWWtkuaDrQfyKFER74ayXnBdCCrRRdRL
         f2ubHnh/UHIitvf0uGDpnjO96RqaEhK7Pfsf3V9O2KHWsCLakiTyXmE3DummykWDbqAg
         JRSVotz99yJgAMxM7/ZCYTOImAZogBGKgrmfyhxCZejUU9B28XUOfOzwjzW5kE2QUzwv
         ttjUKJIpajssBnOQ0g/BAkMIL40mtRNVdgKq+wBQyBSLcl5UD7HFMlswTroXTWhsTUGC
         Ck7A==
X-Gm-Message-State: AGi0Puaeui7P8/ycYJZ+NuflK6mH+E7DyqbHpghpB7PshXnsNWmmnIVG
        wjGHPaHHA9CmqlxKekwBXaEWkYMSwu0X+9zwrmc=
X-Google-Smtp-Source: APiQypImVaEzsNMUlWQJDm0dBB+htx0aMNuXLzgzzwXjbioyFBt5+O7nAMOdkcmCqRMHEFU2omiDgliGDxdZnfqx9HA=
X-Received: by 2002:ad4:45ac:: with SMTP id y12mr26016776qvu.227.1588056592811;
 Mon, 27 Apr 2020 23:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-17-hannes@cmpxchg.org>
 <20200424004441.GF13929@js1304-desktop> <20200424025135.GB464082@cmpxchg.org>
In-Reply-To: <20200424025135.GB464082@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 28 Apr 2020 15:49:41 +0900
Message-ID: <CAAmzW4PQ=Bs=GcCWkORx6YDF-35TaeCYULprVqnVpCBSP9S0Kg@mail.gmail.com>
Subject: Re: [PATCH 16/18] mm: memcontrol: charge swapin pages on instantiation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:51, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Apr 24, 2020 at 09:44:42AM +0900, Joonsoo Kim wrote:
> > On Mon, Apr 20, 2020 at 06:11:24PM -0400, Johannes Weiner wrote:
> > > @@ -412,31 +407,43 @@ struct page *__read_swap_cache_async(swp_entry_=
t entry, gfp_t gfp_mask,
> > >                      */
> > >                     cond_resched();
> > >                     continue;
> > > -           } else if (err)         /* swp entry is obsolete ? */
> > > -                   break;
> > > -
> > > -           /* May fail (-ENOMEM) if XArray node allocation failed. *=
/
> > > -           __SetPageLocked(new_page);
> > > -           __SetPageSwapBacked(new_page);
> > > -           err =3D add_to_swap_cache(new_page, entry, gfp_mask & GFP=
_KERNEL);
> > > -           if (likely(!err)) {
> > > -                   /* Initiate read into locked page */
> > > -                   SetPageWorkingset(new_page);
> > > -                   lru_cache_add_anon(new_page);
> > > -                   *new_page_allocated =3D true;
> > > -                   return new_page;
> > >             }
> > > -           __ClearPageLocked(new_page);
> > > -           /*
> > > -            * add_to_swap_cache() doesn't return -EEXIST, so we can =
safely
> > > -            * clear SWAP_HAS_CACHE flag.
> > > -            */
> > > -           put_swap_page(new_page, entry);
> > > -   } while (err !=3D -ENOMEM);
> > > +           if (err)                /* swp entry is obsolete ? */
> > > +                   return NULL;
> >
> > "if (err)" is not needed since "!err" is already exiting the loop.
>
> But we don't want to leave the loop, we want to leave the
> function. For example, if swapcache_prepare() says the entry is gone
> (-ENOENT), we don't want to exit the loop and allocate a page for it.

Yes, so I said "if (err)" is not needed.
Just "return NULL;" would be enough.

> > > +
> > > +   /*
> > > +    * The swap entry is ours to swap in. Prepare a new page.
> > > +    */
> > > +
> > > +   page =3D alloc_page_vma(gfp_mask, vma, addr);
> > > +   if (!page)
> > > +           goto fail_free;
> > > +
> > > +   __SetPageLocked(page);
> > > +   __SetPageSwapBacked(page);
> > > +
> > > +   /* May fail (-ENOMEM) if XArray node allocation failed. */
> > > +   if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
> > > +           goto fail_unlock;
> > > +
> > > +   if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL, false))
> > > +           goto fail_delete;
> > > +
> >
> > I think that following order of operations is better than yours.
> >
> > 1. page alloc
> > 2. memcg charge
> > 3. swapcache_prepare
> > 4. add_to_swap_cache
> >
> > Reason is that page allocation and memcg charging could take for a
> > long time due to reclaim and other tasks waiting this swapcache page
> > could be blocked inbetween swapcache_prepare() and add_to_swap_cache().
>
> I see how that would be preferable, but memcg charging actually needs
> the swap(cache) information to figure out the cgroup that owned it at
> swapout, then uncharge the swapcache and drop the swap cgroup record.
>
> Maybe it could be done, but I'm not sure that level of surgery would
> be worth the benefits? Whoever else would be trying to swap the page
> in at the same time is likely in the same memory situation, and would
> not necessarily be able to allocate pages any faster.

Hmm, at least, some modifications are needed since waiting task would do
busy waiting in the loop and it wastes overall system cpu time.

I still think that changing operation order is better since it's possible t=
hat
later task allocates a page faster though it's not usual case. However, I
also agree your reasoning so will not insist more.

Thanks.
