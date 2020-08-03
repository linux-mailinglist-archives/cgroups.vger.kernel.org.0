Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2423B069
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 00:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHCWqC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Aug 2020 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHCWqB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Aug 2020 18:46:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6343C06174A;
        Mon,  3 Aug 2020 15:46:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z6so40303449iow.6;
        Mon, 03 Aug 2020 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbJLXIAhRA3ILjxJ/kOnaqM4fWJ/LpEX+iUTeUndPqc=;
        b=iXpmTJ6iTNHX5/0yQVDFwLIAFlMfeqBTpmWkw/+gdIlRTM53IBjEPiTdOr2WqHCjf1
         /ngIOpPdDMnmF2xOP6HHwk+9yO6JRwHBhmEVmtCeryvi401SbANXAXdxqxr/kDqXwT7a
         aVsVubcmq1syeWSWgj5QeG6iBGgl3zE15WTocvZ9qmYIvLIJDw/kaAeSJRCaFFSLh3s6
         +tfjoW3jE7RnVGlBtZ1M1r5sGFLFxuDy4hEJq3VAfoN9EqPy+dV135AaJDrqRsY6Vtes
         OFWRY8PISjNVEERbRNnZQpHElFL71u2bADXCdsR1RpkNR/8z/Lta+ZJiVHfTGqxE0qeE
         /eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbJLXIAhRA3ILjxJ/kOnaqM4fWJ/LpEX+iUTeUndPqc=;
        b=URbVtEy7udVdl6DxbcoW21kUjtdTBPITo9P6XpNfXIPTj1pdLE5LwVjqezn8RXlDuD
         tt4lrxmSoUSeqh7GTANOlEI27hWpK/skiW2RgwGOlHszppiFT2uXf9LIGVKpo+bPTHhI
         X6SwUc22neL0MuVeQMzGnDeHsJ4EJxMvhHXWUoQazWe+yjUAUxWWef1J9yj0AwoD2U73
         5W/PZvJBgLRA5KFeZxyCwX5r2k22qhRx+nOy19wyP0Ij+ed2QRmuwxKW55Oxf4M5gFBB
         qYy/mSIipl3udTzs34ZXXbdOLDKgJJoNJyG5PaBoZjzCC4YLLcexbrP37K8momOpqFkm
         N/IQ==
X-Gm-Message-State: AOAM531L9ti2+hA6AiIBTJ/uU5a4xl/V4HO3YCM0NdSz2Pt9SVNrTD3e
        dM5N+dQv60xOkm5dfKK6BjPA4me7/O4+hsZa2lg=
X-Google-Smtp-Source: ABdhPJwIYpCvFGkCiGSEc1aDXcpoKK7cGb6N+8I2MMc5J1M4owpv0ARR2wasZVYDndA4tWugeNL7PFHnSM1tY1vY8CQ=
X-Received: by 2002:a5d:8d04:: with SMTP id p4mr2150494ioj.187.1596494761071;
 Mon, 03 Aug 2020 15:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-21-git-send-email-alex.shi@linux.alibaba.com> <CAKgT0UfZg5Wf2qNJ_=VPO1Cj8YuifZN8rG_X4Btq86ADmsVZFw@mail.gmail.com>
In-Reply-To: <CAKgT0UfZg5Wf2qNJ_=VPO1Cj8YuifZN8rG_X4Btq86ADmsVZFw@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 3 Aug 2020 15:45:50 -0700
Message-ID: <CAKgT0UciRJCPs_zrxri1pEJmJVKkHpEq=AFiVpJE99JJQe=Xrg@mail.gmail.com>
Subject: Re: [PATCH v17 20/21] mm/pgdat: remove pgdat lru_lock
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Just to correct a typo, I meant patch 17, not 18. in the comment below.


On Mon, Aug 3, 2020 at 3:42 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> >
> > Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.
> >
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: cgroups@vger.kernel.org
>
> I really think this would be better just squashed into patch 18
> instead of as a standalone patch since you were moving all of the
> locking anyway so it would be more likely to trigger build errors if
> somebody didn't move a lock somewhere that was referencing this.
>
> That said this change is harmless at this point.
>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
