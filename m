Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD24244B31
	for <lists+cgroups@lfdr.de>; Fri, 14 Aug 2020 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHNOYw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Aug 2020 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHNOYw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Aug 2020 10:24:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA93C061384;
        Fri, 14 Aug 2020 07:24:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e11so598282ils.10;
        Fri, 14 Aug 2020 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggMXgX7RUq22IK8MLaR6J65bRRwoutct0090dW6uEgw=;
        b=IKlqOFJnaBfJOoWsHY8UwOXQ4vWIVHOQ9cHFWJ/Yj4+Q5myA06cA4pxzNHWNeVCEuj
         K1C032wALPmBsr7wXqR/sGzkjo5MIplBaBt2+o6hjwJ0YMNuF8k4L0vg0kgsop05Wq3t
         1VPqZHYz7U8Z2wT0h9HCgJkMoErzCNAPVxywOh5UNZ9D9tFVpSwIRLutCICVJ1At1Mx2
         DnKIzOxQ23bC10EPBpdpg91/wXpp3J9vh4lJWRJwnkNB15+DpCOAKHNafy3tRm7gQN3F
         FFRvxr8Sx/x1/7TrM1jkphLoqhfetY5yu8AE0VRah+1AJ0g/+jsjiTLSaIShPAV3qBVr
         8/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggMXgX7RUq22IK8MLaR6J65bRRwoutct0090dW6uEgw=;
        b=nv9tyzgnLvOfZZNHl3tBW63smTKZBhppHtwjlFUBbuxuF1DHbFmEEw+nXweWPUWVu/
         RZ8te5UdGfOV9hWSKrSDMfBpij3SmVdcdBbOV7Qb2NFOXOD86UTBrY3dW1m6Q+PiZHhy
         T0takF1y3jfvsNjreEj5diSQFJqqo7CiBIlT6pElt/jGwHT7Jgqh/tTTwaXRnNgXj3A+
         Wcqh2SvzQ9QVipPORh9ozKXkjQpc4GvPtXDu8uM9HhM3hkAT7lFdDk/eNzakOAsdOjdX
         2PsT/8KUin7OP9D8wnJzsbDRHEen8ujZJDFM5oZnis8xgaYQebacZbY8+dITrHGLiR3g
         Z9WA==
X-Gm-Message-State: AOAM5301PBgfEhVoXEioQf0y9WLJ7jALLUP/EL4Ta/uG2PXC5I+QDsPG
        mp6N22gVXTWJ4K4zdx7eFHRa0kXpGIt4LpJ8fs4=
X-Google-Smtp-Source: ABdhPJwiVqDpFE9EY+SU+lxLzSIFEiSNcLq5aeOYf0OBc+yqsDmi0262ufou83smjiKGswFbd1La404xNmJyHd+7seM=
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr2472545ilr.97.1597415091428;
 Fri, 14 Aug 2020 07:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040232.13054.82417.stgit@localhost.localdomain> <6c072332-ff16-757d-99dd-b8fbae131a0c@linux.alibaba.com>
In-Reply-To: <6c072332-ff16-757d-99dd-b8fbae131a0c@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 14 Aug 2020 07:24:40 -0700
Message-ID: <CAKgT0Uf0TbRBVsuGZ1bgh5rdFp+vARkP=+GgD4-DP3Gy6cj+pA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] mm: Drop use of test_and_set_skip in favor of
 just setting skip
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

On Fri, Aug 14, 2020 at 12:19 AM Alex Shi <alex.shi@linux.alibaba.com> wrot=
e:
>
>
>
> =E5=9C=A8 2020/8/13 =E4=B8=8B=E5=8D=8812:02, Alexander Duyck =E5=86=99=E9=
=81=93:
> >
> > Since we have dropped the late abort case we can drop the code that was
> > clearing the LRU flag and calling page_put since the abort case will no=
w
> > not be holding a reference to a page.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> seems the case-lru-file-mmap-read case drop about 3% on this patch in a r=
ough testing.
> on my 80 core machine.

I'm not sure how it could have that much impact on the performance
since the total effect would just be dropping what should be a
redundant test since we tested the skip bit before we took the LRU
bit, so we shouldn't need to test it again after.

I finally got my test setup working last night. I'll have to do some
testing in my environment and I can start trying to see what is going
on.

Thanks.

- Alex
