Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5688450
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2019 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfHIU5y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Aug 2019 16:57:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33135 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIU5x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Aug 2019 16:57:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so137586480otl.0
        for <cgroups@vger.kernel.org>; Fri, 09 Aug 2019 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oOFZs7lWd/cRN6ArflLZND+4GUEsB210O2v04GTqqFo=;
        b=oaMUzgnkhQr8vDqzN541ro79UdzcKWW6RPUgaYRCoEUrv2bw3hFwhciMuc/FZdo5rD
         vxMv49GFSKxSdt8Guqkl3Ym6D8NQAmj6ZogWqxgFOIOGN12mqRCCvqwrbBbrIFOD37y6
         M8RFhPFm8h2kqEcagvwI1ThRn2pW3BdZ4bWVhjR2aCUZMabFWTTkHEC+DlulLPsBkURQ
         J0N4hEZBmjU0BxVSkNq5NHcKLgXOHBc/TjM+c2Dd9gJEOJcM2D3+BJTM+E7rwtry6ONZ
         dZKKJ/RYUEo65s59sGogF3VXgWK0crDgh1g5Ht0zprHVMqVwqRhhHk2rQfVwWDNTQrMI
         6Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oOFZs7lWd/cRN6ArflLZND+4GUEsB210O2v04GTqqFo=;
        b=P4muf5Jz3WIpdnA9E2lJVQR9Fw4rmD/Y+7tOA8a/b+IGEzQKamILP31qtU78lgL4C8
         x2v6KtAyuA7q6LoEOWXPiZqQh8gubWZlAcz85OBikrTOf1qsNpc3+TuVJ7xVZYDbWniM
         HLR26gojFPe+TyWUmImbleo62du+aUVNcw/DPs/SSQukf/F3VTD3K9VBR08jqqNYah87
         PBE9rGn8VdgHqFTXvjsWhiF4BUvo+FgetjxAsHi5UGRRGs6P17sw33AbGKru+wtnCr1F
         y40qxvxnM8LN8sCoL+H5xCRkbZoZziI4T1UO3PHmUBDGE2PdplJkxL/WDxn/8L5sQQOS
         Ng1A==
X-Gm-Message-State: APjAAAXaG1oeG+BUYY41MHwK49UdLKuPmrJK57nn0I1sj6viFDkRhnf1
        3YKW7Ds1y2+zZxGam9q1KcJ4TchFC2I0w27haVAP4Q==
X-Google-Smtp-Source: APXvYqzJcsa9ICi+fQi0Gyqrx84T4EuV0wmUdDvyiJ6cpsg1nCPtkM6vHL+J8zfsreYU1640rrFmz2rWtDYW2f3D/OU=
X-Received: by 2002:a9d:6216:: with SMTP id g22mr18398597otj.349.1565384272566;
 Fri, 09 Aug 2019 13:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190808194002.226688-1-almasrymina@google.com>
 <20190809112738.GB13061@blackbody.suse.cz> <CAHS8izNM3jYFWHY5UJ7cmJ402f-RKXzQ=JFHpD7EkvpAdC2_SA@mail.gmail.com>
 <fc420531-f0fe-8df5-57fe-71a686bf2a71@oracle.com>
In-Reply-To: <fc420531-f0fe-8df5-57fe-71a686bf2a71@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 9 Aug 2019 13:57:41 -0700
Message-ID: <CAHS8izN9BFASse_pjLEhQzWwofjRv+JQ5Z=ZiR6Wywn2USLELA@mail.gmail.com>
Subject: Re: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 9, 2019 at 1:39 PM Mike Kravetz <mike.kravetz@oracle.com> wrote=
:
>
> On 8/9/19 11:05 AM, Mina Almasry wrote:
> > On Fri, Aug 9, 2019 at 4:27 AM Michal Koutn=C3=BD <mkoutny@suse.com> wr=
ote:
> >>> Alternatives considered:
> >>> [...]
> >> (I did not try that but) have you considered:
> >> 3) MAP_POPULATE while you're making the reservation,
> >
> > I have tried this, and the behaviour is not great. Basically if
> > userspace mmaps more memory than its cgroup limit allows with
> > MAP_POPULATE, the kernel will reserve the total amount requested by
> > the userspace, it will fault in up to the cgroup limit, and then it
> > will SIGBUS the task when it tries to access the rest of its
> > 'reserved' memory.
> >
> > So for example:
> > - if /proc/sys/vm/nr_hugepages =3D=3D 10, and
> > - your cgroup limit is 5 pages, and
> > - you mmap(MAP_POPULATE) 7 pages.
> >
> > Then the kernel will reserve 7 pages, and will fault in 5 of those 7
> > pages, and will SIGBUS you when you try to access the remaining 2
> > pages. So the problem persists. Folks would still like to know they
> > are crossing the limits on mmap time.
>
> If you got the failure at mmap time in the MAP_POPULATE case would this
> be useful?
>
> Just thinking that would be a relatively simple change.

Not quite, unfortunately. A subset of the folks that want to use
hugetlb memory, don't want to use MAP_POPULATE (IIRC, something about
mmaping a huge amount of hugetlb memory at their jobs' startup, and
doing that with MAP_POPULATE adds so much to their startup time that
it is prohibitively expensive - but that's just what I vaguely recall
offhand. I can get you the details if you're interested).

> --
> Mike Kravetz
