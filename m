Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34572224EF
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGPOLZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGPOLY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 10:11:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64BC061755;
        Thu, 16 Jul 2020 07:11:24 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so6133419ioh.5;
        Thu, 16 Jul 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwX/mhlAD3zr833qIWvUPD76zWFR7r5RHDAo4CaqDJs=;
        b=mSUV7Ne41+i4WmO2Vm8ptf3P9RJODM2Y9Mg+O0LU/7IyBGkaVo1SQrKWvgj1Aqnoy8
         g08NJT8igdEaGYT6EwoRxBGeK4NsqhiRzrMZ+xgito13FEBBjxlN5v15bCpgv6DKnkkG
         I10aEZB/G9JJ5HXxoPIO1KVUCT5+ZC5u7WRj6wXuOBwVXYuO3XCXM0XI3GnwJ6bhUPqc
         TvUNrXNCEPqbBByGmnniW7ylJGm2aUQEArKr9pbDkCj/RCbqTXdx5deU0iC+/OFcvqIx
         MD+8n1h3b7ddIhzb3mMpul58aqCsG4fODqusChCjuq8/vBxZnkDCtxt4sbpsciw72B66
         EH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwX/mhlAD3zr833qIWvUPD76zWFR7r5RHDAo4CaqDJs=;
        b=e7teLsu68qnjXcXz3KiA25apIvAlgyX+qXE9lCsmsrW3mToBvA3VXegXM2jJUGXncD
         O6JTtDpvHt1lrIxvOG0XUBGPdx38K43Tkt+UWH3UHypc8dVcw4uPgmIKwQRnjmllDETR
         +SI+adpJ8srsyn/6fDjfCALc32Kp0aBiD+tZ7SNY3jK6LCKc2J2VZqHcUGLT3Cql5xl4
         iN8L25MhaZ60XHcBYB9LJQO8svLzEyxzsvdIlVoZ1tLOTcpfmireCz9uEtf5oFwEHk6J
         YQy4jrURWQ7GAit3hQ//zPNPEqtPz6aE330vjwXn1VlAamX44NdGste8Sk1xwr/wccd/
         e14g==
X-Gm-Message-State: AOAM5319DAVmgq9uTfSEPb86fWCK+rwAJCiI0ordTSe3ML50HWQGXDZm
        Z54MIISuKpH3SFJSeoihlWS8fTF4VcP9v+9rcdA=
X-Google-Smtp-Source: ABdhPJy91dfh0GT+dqKF3C2rWnAEox2zlavfLO3RPZaRa7Nk/LRvW3ITiol1O0WjbC5f8lyH21Ai23FETBwlxZ8cts0=
X-Received: by 2002:a02:c888:: with SMTP id m8mr5117977jao.114.1594908683752;
 Thu, 16 Jul 2020 07:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 16 Jul 2020 07:11:12 -0700
Message-ID: <CAKgT0UcKVyTXQ=tGv_uMV+fSvoH_-cuG9zA_zhE+S8Ou11gt=w@mail.gmail.com>
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> The new version which bases on v5.8-rc4. Add 2 more patchs:
> 'mm/thp: remove code path which never got into'
> 'mm/thp: add tail pages into lru anyway in split_huge_page()'
> and modified 'mm/mlock: reorder isolation sequence during munlock'
>
> Current lru_lock is one for each of node, pgdat->lru_lock, that guard for
> lru lists, but now we had moved the lru lists into memcg for long time. Still
> using per node lru_lock is clearly unscalable, pages on each of memcgs have
> to compete each others for a whole lru_lock. This patchset try to use per
> lruvec/memcg lru_lock to repleace per node lru lock to guard lru lists, make
> it scalable for memcgs and get performance gain.
>
> Currently lru_lock still guards both lru list and page's lru bit, that's ok.
> but if we want to use specific lruvec lock on the page, we need to pin down
> the page's lruvec/memcg during locking. Just taking lruvec lock first may be
> undermined by the page's memcg charge/migration. To fix this problem, we could
> take out the page's lru bit clear and use it as pin down action to block the
> memcg changes. That's the reason for new atomic func TestClearPageLRU.
> So now isolating a page need both actions: TestClearPageLRU and hold the
> lru_lock.
>
> The typical usage of this is isolate_migratepages_block() in compaction.c
> we have to take lru bit before lru lock, that serialized the page isolation
> in memcg page charge/migration which will change page's lruvec and new
> lru_lock in it.
>
> The above solution suggested by Johannes Weiner, and based on his new memcg
> charge path, then have this patchset. (Hugh Dickins tested and contributed much
> code from compaction fix to general code polish, thanks a lot!).
>
> The patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation.
> 2, use TestCleanPageLRU as page isolation's precondition
> 3, replace per node lru_lock with per memcg per node lru_lock
>
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.
>
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan,
> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
>
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!

Hi Alex,

I think I am seeing a regression with this patch set when I run the
will-it-scale/page_fault3 test. Specifically the processes result is
dropping from 56371083 to 43127382 when I apply these patches.

I haven't had a chance to bisect and figure out what is causing it,
and wanted to let you know in case you are aware of anything specific
that may be causing this.

Thanks.

- Alex
