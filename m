Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142CE1D8CEF
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 03:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgESBKs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 21:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgESBKs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 21:10:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04512C061A0C
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 18:10:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c21so9743467lfb.3
        for <cgroups@vger.kernel.org>; Mon, 18 May 2020 18:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2h6KEery4DV64pghw/Hx8NR4tW7hYF1jzYkIKgyqtY=;
        b=dGNrtd1l1ltG3c1HYSawMUrarOg9vPFevkjYgf5ZqEOz/RFCHgmLOPi0xuzrahF4CD
         obwX++9C4JOfIDaITvGasXg0MgbGrlbBO4SEtpt/Ud5eQZoGxcJJ0CeGE8NAHftQ3zg5
         6PjTx8qXm3+Oyp8253JLyQxJoLUIW4EFUyuOK0P2z0KzLtFMhM5WWm9W1e8TeAXp/FoS
         dqu7Xx7sFMpzWnCWVGDDqB+hrBxXUb1BuHJB/YVrFyl61gB6v2wxiRoxsi0EuQv92FFu
         BSgc5f0uOl771PWB2t38NXIhaNwIekiNG7WOqDMNMxXdhXa9XE8XUcVPnMg2Gs1DbiEQ
         aPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2h6KEery4DV64pghw/Hx8NR4tW7hYF1jzYkIKgyqtY=;
        b=qcXj3VCu8pc6LWSPokQXbAMl+6HCGIrN10MdBnY0neoBvryizcB4nTr+ih6SdnCfbs
         i75sWfRITnrWg29zW65WiqrvBwyslZ/29hKQT9YJLVFxJQ2ZKQBceawRb9kvryRAfUyL
         GUisEASVBw5tpNJ0KKKioPR9NQOAJ2CbT1bu92bf3J02nY+eCTc5WPDsxwnDkl1sjydr
         SUAS6mMJU/P7Yeg/jgqU9VF9kXBIwD68JU8VrufDbsrGUNyZX9di9xuS/HZ/rB36EoAq
         WTyFPqLO+QIs56UasxhJ4CNkasSSt/aMdgVMBEWi43f+/Nv72nwtItUtpGRQp0z81Qx0
         VMdg==
X-Gm-Message-State: AOAM532FDp8lTnYnNrnsb3KEyr6zXTgcyVuJgaNC13pIz6yq7WFYYhzW
        TYkwcbi18/gNCDze7RDkT+afFzoC13IvO/mm3okM0g==
X-Google-Smtp-Source: ABdhPJz8o98IPX34EDpeYcQ39qN3IWmJGDnhGJJX9GxFzTWgxc1FM1OUqpEv0+O5+KUo01rNe8hsvB8GNC0kZZ/gRG0=
X-Received: by 2002:a19:d52:: with SMTP id 79mr12597235lfn.125.1589850645077;
 Mon, 18 May 2020 18:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200515202027.3217470-1-kuba@kernel.org> <20200515202027.3217470-4-kuba@kernel.org>
 <CALvZod5Dcee8CaNfkhQQbvC1OuOTO7qE9bJw9NAa8nd2Cru6hA@mail.gmail.com> <20200518174249.745e66d1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200518174249.745e66d1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 May 2020 18:10:33 -0700
Message-ID: <CALvZod5G=ZG2DeGGxPD8vhqmeLz4_cxS5GUaTdOiGKLkgk9s6g@mail.gmail.com>
Subject: Re: [PATCH mm v3 3/3] mm: automatically penalize tasks with high swap use
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 18, 2020 at 5:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun, 17 May 2020 06:44:52 -0700 Shakeel Butt wrote:
> > > @@ -2583,12 +2606,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >          * reclaim, the cost of mismatch is negligible.
> > >          */
> > >         do {
> > > -               if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
> > > -                       /* Don't bother a random interrupted task */
> > > -                       if (in_interrupt()) {
> > > +               bool mem_high, swap_high;
> > > +
> > > +               mem_high = page_counter_read(&memcg->memory) >
> > > +                       READ_ONCE(memcg->high);
> > > +               swap_high = page_counter_read(&memcg->swap) >
> > > +                       READ_ONCE(memcg->swap_high);
> > > +
> > > +               /* Don't bother a random interrupted task */
> > > +               if (in_interrupt()) {
> > > +                       if (mem_high) {
> > >                                 schedule_work(&memcg->high_work);
> > >                                 break;
> > >                         }
> > > +                       continue;
> >
> > break?
>
> On a closer look I think continue is correct. In irq we only care
> about mem_high, because there's nothing we can do in a work context
> to penalize swap. So the loop is shortened.
>

Yes, you are right.
