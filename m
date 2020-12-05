Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A462CFD57
	for <lists+cgroups@lfdr.de>; Sat,  5 Dec 2020 19:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgLESb5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Dec 2020 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgLES3e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Dec 2020 13:29:34 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F9C08E862
        for <cgroups@vger.kernel.org>; Sat,  5 Dec 2020 07:30:02 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id p21so5135297pjv.0
        for <cgroups@vger.kernel.org>; Sat, 05 Dec 2020 07:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3OEJmdZ1/qP5ONZzc9GH1i60y0LaLFR+aOV9VrM68E=;
        b=RFv6oCVnKXhcQR6IicNUWbPC4/Z5AsfOqXI3YNlh0pvXL5969ZbwsIOX94yL0AoG5N
         4H10HQ069aT2lPyegmLL9y5xGugUcMz06aS1WZ3pdq89Imi81tAKFJpyZMgUK9SVBJCa
         A634SvsUCe2U04cVJ+T8KfpvS62xfjKViRM/4Ex9qGjkVQlmHy6yE9R+xdzcuFSxO7nB
         nryctbZ+1QmIx2ZL86cf9GfD5A29hVns8f5lrEAC8Jfaer82Zra6uPWc36qK5KpPh9/6
         /jaQaMuS5xxE4bgF0K1DkKYHgRSYmK92cWC3rUAmSittguNyEDioQaexShy1L+BVY1Zv
         1emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3OEJmdZ1/qP5ONZzc9GH1i60y0LaLFR+aOV9VrM68E=;
        b=ZTEpS4Sh/41ILaISfneoGw595mx+h42uKDjJokb3xiXZpbjsRb1JDkxKC74SxzV5SV
         pzt1EDaDv6/pU4TrDmjFJyL38V+MC49doIQ5424+OFcPYN4osIO/leCyDqJijdb/ypW8
         meU2xtji4Ot3mvZZWtNFrztllp5PpDEEJcdbzRt28wrzdOheZ6GTcrSQFIVaIMRalfN4
         KY0PZIgWJG42g8OYMLEfTzedXzbDW6gzaJ225CWGPYyKqfg/8pL/VbTMnkgEsudt39Qq
         FIp8lM8RpMcglHhnT5LAz+wapSeOFwJ/ifaUriA0mbzQMxPfVDe6k/zkE/mQgl8o0vpp
         B2Hw==
X-Gm-Message-State: AOAM530wrqWATUtJrpd3g5BIJPt9UwrlgfEXRmoXBrA6oPW2Z1SNmkvr
        Ii77eUG2087xGSHPW8UWrISbE97vfuf3al8rkYwTrA==
X-Google-Smtp-Source: ABdhPJzCfYIR8zNekwULgYedfmRzJ6EdPamFbkDT+7O9rY/XKHDu8JVu3tJC5a/COi5onrzsJ8EhaKY+0w0A1Nu98rU=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr8959793pjr.229.1607182202264;
 Sat, 05 Dec 2020 07:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-6-songmuchun@bytedance.com> <X8uU6ODzteuBY9pf@kroah.com>
In-Reply-To: <X8uU6ODzteuBY9pf@kroah.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Dec 2020 23:29:26 +0800
Message-ID: <CAMZfGtWjumNV4hu-Qv8Z+WoS-EmyhvQd1qsaoS1quvQCyczT=g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/9] mm: memcontrol: convert NR_FILE_THPS
 account to pages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 5, 2020 at 10:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 05, 2020 at 09:02:20PM +0800, Muchun Song wrote:
> > Converrt NR_FILE_THPS account to pages.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  drivers/base/node.c | 3 +--
> >  fs/proc/meminfo.c   | 2 +-
> >  mm/filemap.c        | 2 +-
> >  mm/huge_memory.c    | 3 ++-
> >  mm/khugepaged.c     | 2 +-
> >  mm/memcontrol.c     | 5 ++---
> >  6 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 05c369e93e16..f6a9521bbcf8 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> >                                   HPAGE_PMD_NR),
> >                            nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> >                                   HPAGE_PMD_NR),
> > -                          nid, K(node_page_state(pgdat, NR_FILE_THPS) *
> > -                                 HPAGE_PMD_NR),
> > +                          nid, K(node_page_state(pgdat, NR_FILE_THPS)),
>
> Again, is this changing a user-visable value?
>

Of course not.

In the previous, the NR_FILE_THPS account is like below:

    __mod_lruvec_page_state(page, NR_FILE_THPS, 1);

With this patch, it is:

    __mod_lruvec_page_state(page, NR_FILE_THPS, HPAGE_PMD_NR);

So the result is not changed from the view of user space.

Thanks.

--
Yours,
Muchun
