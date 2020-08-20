Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8624C057
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHTONn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgHTONm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 10:13:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B829C061385;
        Thu, 20 Aug 2020 07:13:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so2344610iod.1;
        Thu, 20 Aug 2020 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7KUqD0NVyRg3Zo03GZrFVQegwrcexF2aJREuag4UjIs=;
        b=TCJZNgYlFkolAtKYDIaSQN1FZqYOp0XkIPkHM5WH42LWR6/yUHnPUjst8eHDeJmbVI
         j5LsQXv6294iLVbd3J87FiCydVMOuBJ0fa9oex0OUM92w/tFyJmNbRU8b1a1MM1c5uyN
         785YJ3lAM9LVM2OjK3bnrI51rakDkVrQRnhg68McF4HsFIfOb7naUtnS8WgGlVCen2uL
         DQ6HuaO1AY/+oE+9Y09w9SJnDdZjAfNT0twocg+yXtnzrQxMVmNyS9CdKBKqTpezXNHM
         gAvy5RnVll4PadjCJ/Vi3pdvgimSd0fUCj+odJhmONiUJCgifJsi+1UkihKXhBJ/4T/1
         IKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KUqD0NVyRg3Zo03GZrFVQegwrcexF2aJREuag4UjIs=;
        b=tju0bxxQIFZ2qSGJsi9HTczWEyn7DuGoOig/LOyA3L11AkCBijYdNWjmXGx4jTbIhf
         8YlFwYomKWRRb8qKXQ2HXzBNJYmGuPJqARFDlKxMXKUY7ba3DohrqCmfd3bHDq2mfQH8
         VVOVrbAxvErADNQm3Uze4kE4Hk+tlNo+uVIV1hRMOfpsjpEwMJNxr1GwnD2EHfztcSe6
         x6QbR+JfRUxKEEaEtkrqFplt/6Rxqa3MB+C5FWf8ox5kmJR0uWajvUFXLVAajhK/am1X
         xShvbUMECwI/tcrFzkXyIoSUdrwPhQliyZ+TY7TKJ9+Qz+rotcHRXE4Lz2cMUc0UA16S
         /r9w==
X-Gm-Message-State: AOAM532mqBSZSak9mHdIwSUZejoZui2DtZnqQ6ADPABZQcfFMx3ag/yI
        fIe1iAfM5nRcLGPs9BB8E6xcbVYCNQ8TTWUeuLY=
X-Google-Smtp-Source: ABdhPJwbWC38Bz5MDaAGOI9NDW7tN+sr5sluyUNIxyH9tFJgxZZ0l6sSTtfBdLeGoYx1fATjeKxgHnjjjN1eF7MNVBw=
X-Received: by 2002:a05:6638:1508:: with SMTP id b8mr3408874jat.96.1597932821221;
 Thu, 20 Aug 2020 07:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042730.23414.41309.stgit@localhost.localdomain> <15edf807-ce03-83f7-407d-5929341b2b4e@linux.alibaba.com>
 <CAKgT0UepdfjXn=j8e4xEBFmsNJdzJyN57em8dscr-Er4OBZCOg@mail.gmail.com> <a88eef1b-242d-78c6-fecb-35ea00cd739b@linux.alibaba.com>
In-Reply-To: <a88eef1b-242d-78c6-fecb-35ea00cd739b@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 20 Aug 2020 07:13:30 -0700
Message-ID: <CAKgT0UdmKpn3x_=F4E-u+mCf75hu4Bu0O0dyds4mHq93G6wJVA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] mm: Split release_pages work into 3 passes
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 2:51 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/19 =E4=B8=8B=E5=8D=8810:57, Alexander Duyck =E5=86=99=E9=
=81=93:
> >>>       lruvec =3D relock_page_lruvec_irqsave(page, lruvec, &flags);
> >> the lock bounce is better with the patch, would you like to do further
> >> like using add_lruvecs to reduce bounce more?
> >>
> >> Thanks
> >> Alex
> > I'm not sure how much doing something like that would add. In my case
> > I had a very specific issue that this is addressing which is the fact
> > that every compound page was taking the LRU lock and zone lock
> > separately. With this patch that is reduced to one LRU lock per 15
> > pages and then the zone lock per page. By adding or sorting pages by
> > lruvec I am not sure there will be much benefit as I am not certain
> > how often we will end up with pages being interleaved between multiple
> > lruvecs. In addition as I am limiting the quantity to a pagevec which
> > limits the pages to 15 I am not sure there will be much benefit to be
> > seen for sorting the pages beforehand.
> >
>
> the relock will unlock and get another lock again, the cost in that, the =
2nd
> lock need to wait for fairness for concurrency lruvec locking.
> If we can do sort before, we should remove the fairness waiting here. Of =
course,
> perf result depends on scenarios.

Agreed. The question is in how many scenarios are you going to have
pages interleaved between more than one lruvec? I suspect in most
cases you should only have one lruvec for all the pages being
processed in a single pagevec.
