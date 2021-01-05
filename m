Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD82EB396
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbhAETnM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 14:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbhAETnL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 14:43:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F520C061793
        for <cgroups@vger.kernel.org>; Tue,  5 Jan 2021 11:42:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o19so1261194lfo.1
        for <cgroups@vger.kernel.org>; Tue, 05 Jan 2021 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYoTEEasTGTbeUe5rO0NOqcMl/OsWURt/XrVYO9iiBE=;
        b=rVAYvv/W3AwJm3e7hsUlb8tsPHpuRmS/tGCKqISerYJWmOpDfpfLStFg/yt9KJ3NzY
         frYYOWAAhLCirAwpOFpfKhI0lQFcrlM09zdnx3qQB7hHP9q4UbS7puMB9aspXQEy0e8d
         zz9wv4iUHWToHSIzzBGMePeHDDgU1rE2Ht6ZPfI11hgEOVmAXNsOGOe1Aqve1moPjF+t
         NkZs2cwjbhTFbvDuPaL3B+nRfnWpxyL3AdhvzqUPYFzRTRuFezyJ+/QwgrMJ9ouaOaKV
         xvMywi3uY/4gUz8dAvH36AgEtNQR+U302+0NYCbx0xmZb61kb9M1pKqdn+AshRwIZMj+
         a2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYoTEEasTGTbeUe5rO0NOqcMl/OsWURt/XrVYO9iiBE=;
        b=p1vUA67COfdMd2w43oIuEa2Fsd31wfCpE3yqhRSMTezu+cB1Y0eYxqv877Yy/mgLxT
         hk89WgPzj0YVe2bBzSpMCkcY5rBVjYp02ldiS1Jsmr1eJOhG5+Y/jWWyLZuFIGU6dR+o
         du8W16PoYU371nNSbxWpbV5JBf63ogTE4pKTvTb1F2V7mhbRil2hVJIDv55wRFVBuI42
         AV1q2B6Msl1oXA8DBLdKOUq0/+I2YmQpIFvRr68f3oT76LwI98zO7sdvplu8Q/OlTGMs
         o0NhffeHiTL5Z3lVm+MewvHlVhHNQKRDlZwjyEDt02tsmATll8Dp2cHvGX48Y6pd1hZk
         7DhA==
X-Gm-Message-State: AOAM532LCn5Na0jP8iKLXAlXWcUF75oZdog55NzOvto5mkBuI0sXFXz4
        +XWWxKKNqC1LlUW4xvNQcQh5Jy07kFnpA3KDfa/F5w==
X-Google-Smtp-Source: ABdhPJx/+k688ShdldqheuNW9q3B3igGtUsLNim+goYWXcvTrFNPoh8S6h0MdE29Sjhy0iwjyhdyppnpI1tlclKVhuA=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr343986lfp.117.1609875748867;
 Tue, 05 Jan 2021 11:42:28 -0800 (PST)
MIME-Version: 1.0
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
In-Reply-To: <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 Jan 2021 11:42:18 -0800
Message-ID: <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
To:     Qian Cai <qcai@redhat.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 5, 2021 at 11:30 AM Qian Cai <qcai@redhat.com> wrote:
>
> On Thu, 2020-11-05 at 16:55 +0800, Alex Shi wrote:
> > This version rebase on next/master 20201104, with much of Johannes's
> > Acks and some changes according to Johannes comments. And add a new patch
> > v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> > v21-0007.
> >
> > This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> > added to -mm tree yesterday.
> >
> > Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> > Johannes Weiner.
>
> Given the troublesome history of this patchset, and had been put into linux-next
> recently, as well as it touched both THP and mlock. Is it a good idea to suspect
> this patchset introducing some races and a spontaneous crash with some mlock
> memory presume?

This has already been merged into the linus tree. Were you able to get
a similar crash on the latest upstream kernel as well?
