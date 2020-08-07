Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA723EF70
	for <lists+cgroups@lfdr.de>; Fri,  7 Aug 2020 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGOvZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Aug 2020 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgHGOvY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Aug 2020 10:51:24 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446AC061756;
        Fri,  7 Aug 2020 07:51:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w12so2156580iom.4;
        Fri, 07 Aug 2020 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j7YOCwyn015CH01DvuqygeICt/lkosNS0VPJxx8lTNk=;
        b=DZl9SjSAU9r2ocCJ25zl96LApqZMSw7v9QRevy/vcPN769EjunTsd/mxoDROifcfLh
         x1cV0CIGT6g0Xi8y8o6WulDNVEU3MgOjy374LzN50bwKA8qj5tfqhfRG9Q0nekJQju22
         GCXzILsDGgSQKEM3LcX5k/g1Xw3f41snt8i8oCINtSQ6N5YA/eiSfFTAreko0JF3PNtH
         J9p4yKgszZfUSwY6ChDo83EAwG/Mcts7/mmesRa55fDcCkl3YPCe0tulykRKtrpaxq9l
         jtyCfQeWNNNxCOjCAqiccXa6SPaZBiUkyk+VyHgZacF4AyPUX6DZFp/FbQH052q+PY5Y
         i1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j7YOCwyn015CH01DvuqygeICt/lkosNS0VPJxx8lTNk=;
        b=b5L43GWyy4epKx2q02IZFAIHl3RU1x8n9M0dDep43cyLwU0x7MSytuKQ2iYXptx71K
         niEYleUlWVPz92UwCL7BaTX6DZY+dkKiLHSrjRLYK8TcAhRodl9jy5lwrk/b06mKGGWZ
         PKtkEzYSqDdnhROjeKoe8RgxaxuDxCEZztKwq/Bx9VMffxriILJH31XIkKp07gvOUPxu
         8/7kFy7jeXEsT0QJWBNZ2YWlXJ7Nryef/iiuB6jl0QLeS4f2gMRJZUEIrh9f1V7hLH8+
         hB06sAlHMaTJM/Uv3cRyEpihzAE5zyIRTWsYBpPXXMY0j4NaMHU738KyhQygxGx74wme
         Do8A==
X-Gm-Message-State: AOAM531fYGoMIdn/w4u9JZ7+U7iZhN6DHudr9/oFiXGEhDNQueZDjtiv
        cRpGyX3Ll5fiq/JguTG/CxpqratXpiTCljZeSMg=
X-Google-Smtp-Source: ABdhPJxeOx00W3je8vxOviLsrpuWMtz8cLUXTLbWzgM8MrwxscvD0ivTRszWuF80qgyakY297NlCJywTb4dj8OBja+A=
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr4976673iow.38.1596811882640;
 Fri, 07 Aug 2020 07:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com> <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com>
In-Reply-To: <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 7 Aug 2020 07:51:11 -0700
Message-ID: <CAKgT0UdSrarC8j+G=LYRSadcaG6yNCoCfeVpFjEiHRJb4A77-g@mail.gmail.com>
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in compaction
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
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 6, 2020 at 8:25 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2020/8/7 =E4=B8=8A=E5=8D=882:38, Alexander Duyck =E5=86=99=E9=
=81=93:
> >> +
> >>  isolate_abort:
> >>         if (locked)
> >>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> >> +       if (page) {
> >> +               SetPageLRU(page);
> >> +               put_page(page);
> >> +       }
> >>
> >>         /*
> >>          * Updated the cached scanner pfn once the pageblock has been =
scanned
> > We should probably be calling SetPageLRU before we release the lru
> > lock instead of before. It might make sense to just call it before we
> > get here, similar to how you did in the isolate_fail_put case a few
> > lines later. Otherwise this seems to violate the rules you had set up
> > earlier where we were only going to be setting the LRU bit while
> > holding the LRU lock.
>
> Hi Alex,
>
> Set out of lock here should be fine. I never said we must set the bit in =
locking.
> And this page is get by get_page_unless_zero(), no warry on release.
>
> Thanks
> Alex

I wonder if this entire section shouldn't be restructured. This is the
only spot I can see where we are resetting the LRU flag instead of
pulling the page from the LRU list with the lock held. Looking over
the code it seems like something like that should be possible. I am
not sure the LRU lock is really protecting us in either the
PageCompound check nor the skip bits. It seems like holding a
reference on the page should prevent it from switching between
compound or not, and the skip bits are per pageblock with the LRU bits
being per node/memcg which I would think implies that we could have
multiple LRU locks that could apply to a single skip bit.
