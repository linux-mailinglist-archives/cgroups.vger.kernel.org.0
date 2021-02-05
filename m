Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E353109D4
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 12:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBELHq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 06:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhBELFi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 06:05:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC987C06178A
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 03:04:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e9so3389977plh.3
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G84XgAXTIB9kxrWKppVfB7bhTavqUSYTbC5KVvLAP6g=;
        b=Gy+FulpQZ1ltev+PwnM5KcE1+7GoQk9sA8tu5+DNBMHtUciX/ITccny0i5NJW0w7eN
         lGEzSPoFo9+wKYG2McWRVBm1Kmpq6kfFh5PhvWeihcnbhdOKklU4ILERzeHkx8EzNmk9
         i2SQGg/4Ym7WsDWEKQLWRn9qEI/hHlU4td7Qd3EXvUsobrhBYid/LeaWZ8/UwedTf6ma
         cuUScuIGTGY4silbfwJ4wVkSA05+vDlJGfoGiUQxtRa8IE3fYnmbwWcJe/el4NjtD/TZ
         KJRYPc5ncLHX3SwjBYlcNGi3Yu6fkNMxVNmGirHAS1yqLnmZH4X5TSdL5U/T6iQGFG+N
         ToyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G84XgAXTIB9kxrWKppVfB7bhTavqUSYTbC5KVvLAP6g=;
        b=TZBCIm9eYA44YoMZecUxEgHmae/ASOCXovyJElGxSYN2MdkPHFKp0ltSlPmVv27Ax0
         ClZ1omnnV8rDW07YLDRye2Z/ovanQVLZtYia9Elracu17C9qC794GXFEBq6ddzv2WfHM
         N0nW2oH0PrgiMHho61bHZWAgPv7yxHyMlj2yBKkORJSUub4ozHpsTWH6nJDVIPGnZPCh
         elTm0DiidMGtsCSclMJqPq5F4IiPPd/4hkWPnF9Y8hdShV98gpBAOciQXPVg8owJX6WZ
         hQLDgI74pNgKQlpW0D6V3VRpIUR1cWAFkNcYubbP1oXWZEYJyLwedJG9gbtnTnH13ZJD
         /LQQ==
X-Gm-Message-State: AOAM531phGDznOtrMeS8Fr75gWPywEFxZyaXdFD17wBb/02g+Nedx23c
        24gzH/3+c0hzvzVD+j8/yXeCtpiuddiLLNxmOJAjRA==
X-Google-Smtp-Source: ABdhPJww7F5WzQ1oqkJJpHPK2EsEFNrSMkvwZXanGafRo0NCNhE/HrOFxiP/gxTYPP/GIrJisIFxzklQWvXyhht6lNo=
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr3534837pjb.229.1612523097393;
 Fri, 05 Feb 2021 03:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20210205062310.74268-1-songmuchun@bytedance.com>
 <YB0Ay+epP/hnFmDS@dhcp22.suse.cz> <CAMZfGtWKNNhc1Jy1jzp2uZU_PM6GNWup7d=yUVk9AehKFo_CRw@mail.gmail.com>
 <YB0cO7R1WtJgAxI2@dhcp22.suse.cz>
In-Reply-To: <YB0cO7R1WtJgAxI2@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 19:04:19 +0800
Message-ID: <CAMZfGtXXjXKoxbOSB9h6JvgZKEGBh2sCf34usJXcBXxGjU6k0w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix missing wakeup oom task
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 6:21 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 05-02-21 17:55:10, Muchun Song wrote:
> > On Fri, Feb 5, 2021 at 4:24 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 05-02-21 14:23:10, Muchun Song wrote:
> > > > We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
> > > > when page uncharged, but for the slab pages, we do not do this when page
> > > > uncharged.
> > >
> > > How does the patch deal with this?
> >
> > When we uncharge a slab page via __memcg_kmem_uncharge,
> > actually, this path forgets to do this for us compared to
> > uncharge_batch(). Right?
>
> Yes this was more more or less clear (still would have been nicer to be
> explicit). But you still haven't replied to my question I believe. I
> assume you rely on refill_stock doing draining but how does this address
> the problem? Is it sufficient to do wakeups in the batched way?

Sorry, the subject title may not be suitable. IIUC, memcg_oom_recover
aims to wake up the OOM task when we uncharge the page.
I see uncharge_batch always do this. I am confused why
__memcg_kmem_uncharge does not. Both paths do the same
thing (uncharge pages). So actually, this patch want to keep
the two paths consistent. Thanks.

>
> > > > When we drain per cpu stock, we also should do this.
> > >
> > > Can we have anything the per-cpu stock while entering the OOM path. IIRC
> > > we do drain all cpus before entering oom path.
> >
> > You are right. I did not notice this. Thank you.
> >
> > >
> > > > The memcg_oom_recover() is small, so make it inline.
> > >
> > > Does this lead to any code generation improvements? I would expect
> > > compiler to be clever enough to inline static functions if that pays
> > > off. If yes make this a patch on its own.
> >
> > I have disassembled the code, I see memcg_oom_recover is not
> > inline. Maybe because memcg_oom_recover has a lot of callers.
> > Just guess.
> >
> > (gdb) disassemble uncharge_batch
> >  [...]
> >  0xffffffff81341c73 <+227>: callq  0xffffffff8133c420 <page_counter_uncharge>
> >  0xffffffff81341c78 <+232>: jmpq   0xffffffff81341bc0 <uncharge_batch+48>
> >  0xffffffff81341c7d <+237>: callq  0xffffffff8133e2c0 <memcg_oom_recover>
>
> So does it really help to do the inlining?

I just think memcg_oom_recover is very small, inline maybe
a good choice. Maybe I am wrong.

> --
> Michal Hocko
> SUSE Labs
