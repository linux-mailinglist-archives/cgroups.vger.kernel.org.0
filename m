Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111EF2635E1
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIISYd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIISYa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 14:24:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D1C061755
        for <cgroups@vger.kernel.org>; Wed,  9 Sep 2020 11:24:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z18so2033248qvp.6
        for <cgroups@vger.kernel.org>; Wed, 09 Sep 2020 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ruhhup1GiVMzdtnhUGJBHZmdP0+i41QleFToFouJcG0=;
        b=XDE4XX5WI/xPzfW/NMmUCQ3gVCnjbXrHt8OZ8zTa8NBevb7IHbrl/CNJzNEBbJAWSt
         mb2pkZ6iQFCSt/q5DVeqGb+Nus0hYvK68luUixqriqlyeKJdl+oqygph3LDTrnWc6T9h
         fWv/uvdnEzXrsILGx8SzqA65K21CKUQDVaAl0JFq2hcncH1UebzvxYpWJbFh7zVFBpBu
         gingaYs6WXb1VQj6dXz40KyyJXkaaFLrzQ4rRC1CX61vyJvkxHuszDndK7jT5Lrbkojv
         DJeqyHfkPPnmTJGrQIIwUhTtQ+MRbeYsaCG00Wkar1qmHCnOEQgsdMgsei9v2ccL99kT
         XkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ruhhup1GiVMzdtnhUGJBHZmdP0+i41QleFToFouJcG0=;
        b=D5lNGwTA8JDbVnrpgoBiNcStqK/MielZ5Gdhwm7zsrzAmLCBbqqK1PrXXdZXw6DZCY
         yiBAkzX99VqaEnPrIfswmJ0Rm/1TZNrRBiXv/dwjC0A6IGb8eG6h7V+Dy+5URsrlTZYN
         KprGfe7MPRyGREFdMGM4wPWzYrtFJ+miid7K1ssotVG9t4mV6wv+jWq7gL1wKg8NTcWj
         BKohfbpapG9X6k/fEgimYgtyNC8wSiaHl+Q9JfCmANczQOLcr8M9UII52DNOOgR0Hv+o
         JtiGvLbYIqMSKunxqxvPUYJ/64697+2bT1lZ/Gpy2tTlrNhXRbLEp3xtnrFLvrgc/UHB
         tY9Q==
X-Gm-Message-State: AOAM533sMZqVgKkYrrkKy3WaljNKIDXrC6k/kquI+r4pNcf5RpLU5LXL
        VhwiDEkN69GY4DK14pMofeRB5w==
X-Google-Smtp-Source: ABdhPJwLHtK06MB86ozbrs1dqxtlh9p5l/69lx5+FCQ89PVrR+dpBTlHWMb5oT5whELFYBtY0OnqTQ==
X-Received: by 2002:a0c:ff4b:: with SMTP id y11mr5502578qvt.3.1599675869492;
        Wed, 09 Sep 2020 11:24:29 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c13sm3841553qtq.5.2020.09.09.11.24.26
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2020 11:24:28 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:24:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alexander Duyck <alexander.duyck@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
In-Reply-To: <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2009091100280.9020@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com> <20200909010118.GB6583@casper.infradead.org> <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 9 Sep 2020, Alexander Duyck wrote:
> On Tue, Sep 8, 2020 at 6:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Aug 24, 2020 at 08:55:04PM +0800, Alex Shi wrote:
> > > +++ b/mm/vmscan.c
> > > @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
> > >
> > >                       if (!TestClearPageLRU(page)) {
> > >                               /*
> > > -                              * This page may in other isolation path,
> > > -                              * but we still hold lru_lock.
> > > +                              * This page is being isolated in another
> > > +                              * thread, but we still hold lru_lock. The
> > > +                              * other thread must be holding a reference
> > > +                              * to the page so this should never hit a
> > > +                              * reference count of 0.
> > >                                */
> > > -                             put_page(page);
> > > +                             WARN_ON(put_page_testzero(page));
> > >                               goto busy;
> >
> > I read Hugh's review and that led me to take a look at this.  We don't
> > do it like this.  Use the same pattern as elsewhere in mm:
> >
> >         page_ref_sub(page, nr);
> >         VM_BUG_ON_PAGE(page_count(page) <= 0, page);
> >
> >
> 
> Actually for this case page_ref_dec(page) would make more sense
> wouldn't it? Otherwise I agree that would be a better change if that
> is the way it has been handled before. I just wasn't familiar with
> those other spots.

After overnight reflection, my own preference would be simply to
drop this patch.  I think we are making altogether too much of a
fuss here over what was simply correct as plain put_page()
(and further from correct if we change it to leak the page in an
unforeseen circumstance).

And if Alex's comment was not quite grammatically correct, never mind,
it said as much as was worth saying.  I got more worried by his
placement of the "busy:" label, but that does appear to work correctly.

There's probably a thousand places where put_page() is used, where
it would be troublesome if it were the final put_page(): this one
bothered you because you'd been looking at isolate_migratepages_block(),
and its necessary avoidance of lru_lock recursion on put_page();
but let's just just leave this put_page() as is.

Hugh
