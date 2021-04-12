Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD835C9AC
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhDLPWg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbhDLPWb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 11:22:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE6C061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 08:22:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z15so2114832qtj.7
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ERqCI38M3BY/3SOC3pgh5AxFU4XWzgptnCfUipXNgug=;
        b=gYe5Up3OaU/+pnMLbIoo4fGw8EW/wVqIDfiJjiTGlAuevEjxM8fhcVcYjWLc0Hd4xP
         hA6vETqs5aigURkzuBOUUcrJ4MqW2iIZ5cg0KuyXY8cdfwDMzNf5JJD/gqlIeb9tz69t
         H243bX0LV289m2WtQZ/bQCHN7SztQEZBGdUaTI2tC9mBQleVY4txXKniVPtyH+OFYHXm
         ughPAw0w12CqzIGqmA21Axu1+8CSR2LvwYHJL81CVAbjVQY8aljszWj/80+/lOdtGUav
         b4tmg4wfnrQrNMktySbmYn6clgC6g+45rMuz+OqwSCpdRoCxHtc+G1Tu9EvbNDyffDjk
         241Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ERqCI38M3BY/3SOC3pgh5AxFU4XWzgptnCfUipXNgug=;
        b=ML2KHzgJe0lerfKnIJr34VKgEcpfKcae7KddnLNBJtE19qYlosLWMdLmp3UDHTu+7d
         A+IACU1dtPyZDhcZSznwwUZgD/KcPGF8NnF/OAvETA8NmlAij6Riiv5kZvOYX2WypeXS
         O2GUrrrJ8Of5fIasq9YDpL7TYLsl+mT8ZLDgd2M40tHIfWV1ki6YBbAoyuegD7I7G9os
         acexEwuQYgVYZep3lYLlQHGJtdWj6rcRMG4iRG1+NrCbZ+y39hPHiBaD7iCZzPfajBKu
         1eE9imI4/wh5+t4tyqRATzoXno8K/Gnfa5vhuFpDG+uKK8eMAtISMZQVubJZmiTNcJZ3
         M55g==
X-Gm-Message-State: AOAM5323fYbkmAQiVsy0DyCb4oe2gMyJERKPIC1It04LddcPSwCXh6/B
        /sX9ro2GQAc3k33Zd11hHhHOghbn9w==
X-Google-Smtp-Source: ABdhPJymbpZZrzMCeOaHb6/natGXfsZNfOau++lTB9IrDdCmP1dtFXSCCOxYCzhxwTeeGtbH9vvDwQ==
X-Received: by 2002:ac8:7fd0:: with SMTP id b16mr26146035qtk.91.1618240932927;
        Mon, 12 Apr 2021 08:22:12 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id 62sm2469286qtg.70.2021.04.12.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:22:12 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:22:10 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: memcg: performance degradation since v5.9
Message-ID: <20210412152210.y5bizdfbn62sgeqg@gabell>
References: <20210408193948.vfktg3azh2wrt56t@gabell>
 <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
 <CALvZod58NBQLvk2m7Mb=_0oGCApcNeisxVuE1b+qh1OKDSy0Ag@mail.gmail.com>
 <20210409163539.5374pde3u6gkbg4a@gabell>
 <CALvZod4uRU==p7Z0eP_xO49iA3ShFDHKzyWZbd7RdMso5PHsfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4uRU==p7Z0eP_xO49iA3ShFDHKzyWZbd7RdMso5PHsfA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 09:50:45AM -0700, Shakeel Butt wrote:
> On Fri, Apr 9, 2021 at 9:35 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >
> [...]
> > > Can you please explain how to read these numbers? Or at least put a %
> > > regression.
> >
> > Let me summarize them here.
> > The total duration ('total' column above) of each system call is as follows
> > if v5.8 is assumed as 100%:
> >
> > - sendto:
> >   - v5.8         100%
> >   - v5.9         128%
> >   - v5.12-rc6    116%
> >
> > - revfrom:
> >   - v5.8         100%
> >   - v5.9         114%
> >   - v5.12-rc6    108%
> >
> 
> Thanks, that is helpful. Most probably the improvement of 5.12 from
> 5.9 is due to 3de7d4f25a7438f ("mm: memcg/slab: optimize objcg stock
> draining").
> 
> [...]
> > >
> > > One idea would be to increase MEMCG_CHARGE_BATCH.
> >
> > Thank you for the idea! It's hard-corded as 32 now, so I'm wondering it may be
> > a good idea to make MEMCG_CHARGE_BATCH tunable from a kernel parameter or something.
> >
> 
Hi!

Thank you for your comments!

> Can you rerun the benchmark with MEMCG_CHARGE_BATCH equal 64UL?

Yes, I reran the benchmark with MEMCG_CHARGE_BATCH == 64UL, but it seems that
it doesn't reduce the duration of system calls...

- v5.12-rc6 vanilla

   syscall      total  
               (msec) 
   --------- --------
   sendto    3049.221
   recvfrom  2421.601

- v5.12-rc6 with MEMCG_CHARGE_BATCH==64

   syscall      total  
               (msec) 
   --------- --------
   sendto    3071.607
   recvfrom  2436.488

> I think with memcg stats moving to rstat, the stat accuracy is not an
> issue if we increase MEMCG_CHARGE_BATCH to 64UL. Not sure if we want
> this to be tuneable but most probably we do want this to be sync'ed
> with SWAP_CLUSTER_MAX.

Thanks. I understand that. 
Waiman posted some patches to reduce the overhead [1]. I'll try the patch.

[1]: https://lore.kernel.org/linux-mm/51ea6b09-b7ee-36e9-a500-b7141bd3a42b@redhat.com/T/#me75806a3555e7a42e793f099b98c42e687962d10

Thanks!
Masa
