Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FEA2256CB
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgGTEsI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 00:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTEsI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 00:48:08 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551DC0619D2
        for <cgroups@vger.kernel.org>; Sun, 19 Jul 2020 21:48:08 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e90so11205993ote.1
        for <cgroups@vger.kernel.org>; Sun, 19 Jul 2020 21:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6Nps254wO3Vku/AMs/COcTPJnAHzxFnu9/tet83Jczo=;
        b=Orx+a9RBBcSgVIEOHFVB374CoAHh0H+dcciHwze7bjd/evrRLoNHoEeHX6AUUXAWPE
         rlEZJuyYrLtfrbxBEr1f6tOk1hUCeuxitWVtbHQSm1gD5eBMeQnnQmiecOui/n+Wy+CH
         lVR+yKJxXOVRAwcOkkKdPQDX9l0WSRYT55r6M1O9qVGNeakNm5eWCBq/poyfEr+Mh+xO
         fvXDBer896r9lWpDPRKLzlOfw7HMuYx8YhXqqDQ9X/jiqcowwnnertv+u6tOMyTf4L6x
         VhxLTL6Tuzj5Wcb/bIoRfQ7SJeG3OQOLcWf9uL2ccqf9yxAULz7Zp0JITwEJl9p0MruI
         UiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6Nps254wO3Vku/AMs/COcTPJnAHzxFnu9/tet83Jczo=;
        b=a6IzdAJEEMd2qFHZco7zxiPeO90wE5yL8YfTvUlNDouFyJ6b2qEdCnBeVHnbG9vRvc
         zdLhRcL3edWWo/vcnJwRr6sZ1+3O3XZWajCjEXVWHu7rsGNCQmQOm7G6Cjol3gFer5/h
         47eCR9v+KtcMMUIJfgS6ukk9+hNixC45/XQ6HthnmZw21Lo+0C62whbWZ/KxNebND3Ih
         2fUdxyAn/iuxRNrZIZl3ttp34AWI78LbCPlC09LyoiSjusvK+7yMYpvxXIPUWj27dFO3
         y9eVK059DLjmt3DxoPBl9acyrc/BiAVOEUa9haCsVwtoYAo3RUOw5U8a+zUm/wZ8E+Qf
         I/WQ==
X-Gm-Message-State: AOAM531cMmLSGNvrC6ynMI7BjkCKdXlzv6DKl19WBiKYJ3+cRT1Neksf
        bo3nbT0x8CMDxzp+k88P38nVCQ==
X-Google-Smtp-Source: ABdhPJyxUSbYws6hgiXi/FXNrgA6DQiqHyVhJ/vCcW5ZcJVVBJfAngGkSI4Kx13zzYcqaz/Mipp0kQ==
X-Received: by 2002:a9d:480d:: with SMTP id c13mr18932515otf.224.1595220487215;
        Sun, 19 Jul 2020 21:48:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w17sm3914020oia.16.2020.07.19.21.48.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2020 21:48:06 -0700 (PDT)
Date:   Sun, 19 Jul 2020 21:47:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
In-Reply-To: <5f2401d3-dd4f-cbc6-8cb4-4e92fc64998c@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2007192144150.1478@eggly.anvils>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <CAKgT0UcKVyTXQ=tGv_uMV+fSvoH_-cuG9zA_zhE+S8Ou11gt=w@mail.gmail.com> <57c619e7-da7e-198e-3de8-530bf19b9450@linux.alibaba.com> <alpine.LSU.2.11.2007190801490.3521@eggly.anvils>
 <5f2401d3-dd4f-cbc6-8cb4-4e92fc64998c@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1916823428-1595220486=:1478"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1916823428-1595220486=:1478
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 20 Jul 2020, Alex Shi wrote:
> =E5=9C=A8 2020/7/19 =E4=B8=8B=E5=8D=8811:23, Hugh Dickins =E5=86=99=E9=81=
=93:
> > I noticed that 5.8-rc5, with lrulock v16 applied, took significantly
> > longer to run loads than without it applied, when there should have bee=
n
> > only slight differences in system time. Comparing /proc/vmstat, somethi=
ng
> > that stood out was "pgrotated 0" for the patched kernels, which led her=
e:
> >=20
> > If pagevec_lru_move_fn() is now to TestClearPageLRU (I have still not
> > decided whether that's good or not, but assume here that it is good),
> > then functions called though it must be changed not to expect PageLRU!
> >=20
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>=20
> Good catch!
>=20
> Thanks a lot, Hugh!=20
> except 6 changes should apply, looks we add one more in swap.c file to st=
op
> !PageRLU further actions!

Agreed, that's a minor optimization that wasn't done before,
that can be added (but it's not a fix like the rest of them).

>=20
> Many Thanks!
> Alex
>=20
> @@ -649,7 +647,7 @@ void deactivate_file_page(struct page *page)
>          * In a workload with many unevictable page such as mprotect,
>          * unevictable page deactivation for accelerating reclaim is poin=
tless.
>          */
> -       if (PageUnevictable(page))
> +       if (PageUnevictable(page) || !PageLRU(page))
>                 return;
>=20
>         if (likely(get_page_unless_zero(page))) {
--0-1916823428-1595220486=:1478--
