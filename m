Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9741E7237
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 03:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbgE2BvO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 21:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgE2BvK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 21:51:10 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4EC08C5C6;
        Thu, 28 May 2020 18:51:10 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t8so438183ilm.7;
        Thu, 28 May 2020 18:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3h/KKWXDUeQOc5C3bt+8FTDd7C+ZKV4cv02x2eGUM0=;
        b=hv3Ro80UVyre+PN/oxyCxv5Wj3U9Miq4RcYmwn7Wer3m5lna+secRy/iNZy1XU5vs6
         DwjrNtSLHZt3BxA7cIhF92ENeQKAwPhXRCSqVVVGdfZEG1vXKe2rTqhNQ5Hvrpi2UFjd
         LXRB+yKNrnG7mdAT8gMmN500gmHD5X41hEKBe0ZSg81bWVcCF0wDSjdIsr/DX4GRWgtn
         jcsGk9dGIRwLlEPEmqwg9TjN0k2usiunSA7X//YLVJEyZx8FK26kMVPXHvJZ+cbDD4ho
         dfy41JIPsQje/uQaXQhSJnK2rs1lAoB5dKeFYnuDrG4bDMDOculzn8iblXX+9y2QjMdX
         sHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3h/KKWXDUeQOc5C3bt+8FTDd7C+ZKV4cv02x2eGUM0=;
        b=Z6rdMIlkKUQtcxDveLz7QSTlLJyE0dU1drQHpQ36JTqjQbP/xlGw3JvBCwp6aJ38YO
         yrRvb9CBHSEP5YKAz8fUcwF1qzJdkDHx95lmyZHtWQyZIJackPpaponrSDUJiQ7KSNGW
         f1gFJxFNccq7aEDd9H8UMvY0SJZlVW0Oe2FfTyVrjFMvKsgS5Jz0Z8dB8I5nFXIMhqvI
         z50D1RxnzwX5qFtNfaaX8IBcsmRtA0aytgdgNX9cJ8P2fUF4EL0x1qk5GgGyI9fnp7TH
         0wzN37b8O2QNVQ7JmXmuLlxGyf1nnYmmQBSgPkNwJiz3FHOieejAvWHI7KExkj1Sh/ZE
         Vfdg==
X-Gm-Message-State: AOAM530GXaFmL595/YXvCsRAxesB0uuiT5qrqaTMbGlopesjoJ2Gzjd1
        0QwQztxL3wl4mys1AGnxkq4tv2TkZ4eOpBIbUuk=
X-Google-Smtp-Source: ABdhPJwOdvRBv/VOCAVzd3CfESY0S+IdHP0T8BAuYkYNjREwWIKEF46vM4w9mjj36My18HtWSo+lPWWNSsKWEHxCsAY=
X-Received: by 2002:a92:770c:: with SMTP id s12mr79501ilc.203.1590717069612;
 Thu, 28 May 2020 18:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz> <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz> <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
In-Reply-To: <20200528164121.GA839178@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 29 May 2020 09:50:33 +0800
Message-ID: <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Chris Down <chris@chrisdown.name>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 29, 2020 at 12:41 AM Chris Down <chris@chrisdown.name> wrote:
>
> Naresh Kamboju writes:
> >On Thu, 28 May 2020 at 20:33, Michal Hocko <mhocko@kernel.org> wrote:
> >>
> >> On Fri 22-05-20 02:23:09, Naresh Kamboju wrote:
> >> > My apology !
> >> > As per the test results history this problem started happening from
> >> > Bad : next-20200430 (still reproducible on next-20200519)
> >> > Good : next-20200429
> >> >
> >> > The git tree / tag used for testing is from linux next-20200430 tag and reverted
> >> > following three patches and oom-killer problem fixed.
> >> >
> >> > Revert "mm, memcg: avoid stale protection values when cgroup is above
> >> > protection"
> >> > Revert "mm, memcg: decouple e{low,min} state mutations from protectinn checks"
> >> > Revert "mm-memcg-decouple-elowmin-state-mutations-from-protection-checks-fix"
> >>
> >> The discussion has fragmented and I got lost TBH.
> >> In http://lkml.kernel.org/r/CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com
> >> you have said that none of the added tracing output has triggered. Does
> >> this still hold? Because I still have a hard time to understand how
> >> those three patches could have the observed effects.
> >
> >On the other email thread [1] this issue is concluded.
> >
> >Yafang wrote on May 22 2020,
> >
> >Regarding the root cause, my guess is it makes a similar mistake that
> >I tried to fix in the previous patch that the direct reclaimer read a
> >stale protection value.  But I don't think it is worth to add another
> >fix. The best way is to revert this commit.
>
> This isn't a conclusion, just a guess (and one I think is unlikely). For this
> to reliably happen, it implies that the same race happens the same way each
> time.


Hi Chris,

Look at this patch[1] carefully you will find that it introduces the
same issue that I tried to fix in another patch [2]. Even more sad is
these two patches are in the same patchset. Although this issue isn't
related with the issue found by Naresh, we have to ask ourselves why
we always make the same mistake ?
One possible answer is that we always forget the lifecyle of
memory.emin before we read it. memory.emin doesn't have the same
lifecycle with the memcg, while it really has the same lifecyle with
the reclaimer. IOW, once a reclaimer begins the protetion value should
be set to 0, and after we traversal the memcg tree we calculate a
protection value for this reclaimer, finnaly it disapears after the
reclaimer stops. That is why I highly suggest to add an new protection
member in scan_control before.

[1]. https://lore.kernel.org/linux-mm/20200505084127.12923-3-laoar.shao@gmail.com/
[2]. https://lore.kernel.org/linux-mm/20200505084127.12923-2-laoar.shao@gmail.com/

-- 
Thanks
Yafang
