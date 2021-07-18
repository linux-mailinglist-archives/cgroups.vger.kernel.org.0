Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3E3CCAF9
	for <lists+cgroups@lfdr.de>; Sun, 18 Jul 2021 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhGRVfN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Jul 2021 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGRVfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Jul 2021 17:35:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7EC061764
        for <cgroups@vger.kernel.org>; Sun, 18 Jul 2021 14:32:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x192so24538425ybe.6
        for <cgroups@vger.kernel.org>; Sun, 18 Jul 2021 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+/+LhyG5jvyV2FwgkrvUngRXo+GiZNFji+6rwemUzs=;
        b=vedZyKz3lL38LRdICKgLFxrEXvjXGc5BgkO2T78tkSNG8sI2Hlk33sbY4W5Y63syJE
         mURxKSpo24wSQ9o/ud5y4QDgt6SvMpf9VVsh6F507XJUpmQHNL0dW9oxTms5nlK0xUSc
         PuHLZCQNZUwHfduWT20rlRZOCXMBJrXKRIYo8Mb7fDiylsOGnIrE0HgtfxVul6uQd/rV
         1LG0LAQ4sJ9oJ6jQ9RuzMIK2dpGVBQhO5zFqDDnpLK9olnfgkR0dUTgG7hbqRmoeiac5
         zKoaJ6wS4qh1aAk9zJR/Tn2YTD8GhmJhjazXSfsyDxBgXeizJ4jqLkfMgQDSenGJ6lCg
         SJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+/+LhyG5jvyV2FwgkrvUngRXo+GiZNFji+6rwemUzs=;
        b=LxIhrV+dQVoncrprZXrr893K1fXTbIp7pOcG5s1AcvLKFfOb5s+k0u1PWnBgqPLB+X
         tNHL73Iti/NNlwe91jiBmHq0eh6Y/vCXjLVsAcCnAz5/1I8NKfkjsAZAfG66rxNQGJNl
         qWJUsU2nZmJFFBBxRhnLeXiu40SVSL5D3i9438qkx/Molf8jrtjls1hBheRqJkiCtg3t
         qqcsJIo41mnln3VbMORyiDZxIVaU6EmgaLus2Jq8Vgh3wzckJAwhhgF5YWIPZlY5OUws
         uXTAxET0dAZe8LmbfenRFZGlur8ODbi37/VOCWtpBszMor44ghcqESZj8kZ6tV4H+Ddq
         yxHQ==
X-Gm-Message-State: AOAM533OjjUnBEUCZcZ7wS1B4rwdUvoxoLNTZY36ODzX7sNHuoJRvtX8
        C2wAFz6iPgzcNvM2Mpsy0h68aPg7hNSLUbnMkh8aWw==
X-Google-Smtp-Source: ABdhPJwcutQSQe7gkLcIvJWxIAQckzSBIZ4Ug/aclHp9CEPkdqSJ9KU5lsiYI1BnbeWezs1no9qujWoToRyP4xUylQw=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr26883038ybc.397.1626643933133;
 Sun, 18 Jul 2021 14:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-2-surenb@google.com>
 <YPRdH56+dOFs/Ypu@casper.infradead.org> <CAJuCfpFNXmH3gQ51c-+3U_0HPG401dE9Mp9_hwMP67Tyg-zWGg@mail.gmail.com>
 <YPSdONIP8r9S31wM@casper.infradead.org>
In-Reply-To: <YPSdONIP8r9S31wM@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 18 Jul 2021 14:32:02 -0700
Message-ID: <CAJuCfpH-E9wJZysL7g8wvD1t62tkSoxjRzr0-aCYn-5XK8KUzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 18, 2021 at 2:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 18, 2021 at 02:25:50PM -0700, Suren Baghdasaryan wrote:
> > On Sun, Jul 18, 2021 at 9:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 09, 2021 at 05:36:25PM -0700, Suren Baghdasaryan wrote:
> > > > @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > > >  }
> > > >
> > > >  /**
> > > > - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > > > + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
> > > >   * @page: page to charge
> > > >   * @mm: mm context of the victim
> > > >   * @gfp_mask: reclaim mode
> > >
> > > This patch conflicts with the folio work, so I'm just rebasing the
> > > folio patches on top of this, and I think this part of the patch is a
> > > mistake.  We don't want to document the __mem_cgroup_charge() function.
> > > That's an implementation detail.  This patch should instead have moved the
> > > kernel-doc to memcontrol.h and continued to document mem_cgroup_charge().
> >
> > Ack.
> > There was a v4 version of this patch:
> > https://lore.kernel.org/patchwork/patch/1458907 which was picked up by
> > Andrew already. If others agree that documentation should be moved
> > into the header file then I'll gladly post another version. Or I can
> > post a separate patch moving the documentation only. Whatever works
> > best. Andrew, Michal, Johannes, WDYT?
>
> At this point, I've moved the documentation as part of the folio patch.
> I'd rather not redo that patch again ...

Ok. If you need me to redo anything please let me know.
