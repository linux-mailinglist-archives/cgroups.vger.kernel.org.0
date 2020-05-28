Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36A81E6741
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404876AbgE1QRS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404878AbgE1QRO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 12:17:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD2C08C5C8
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 09:17:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so16916582lfb.3
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuyHwLJRnB6jxTc1IB7c0ys/rrbHpiCHBZYkZOd5+aA=;
        b=dnY861HISlW7Skc3gzpG3vW0s3QiWx9O4snM0Q63YTXMKM+DTDIREHzF4vRDxhIvbZ
         dYi7yQdeWR7/U7kdlDUHwOi9DdY7WbtDafHbadPk2OPyvMhIIkEiiUHeUss1TwcHy759
         AkF2Q3ZVo/VG5Bdc4OEnX9FsUtb9Iw0ZFZ7YKTkSRlM9J0Gonu/ZDOEK5W9Y3RZ86gJk
         S1HLfVmE5rjKgkr2zLBllzghwb3k4F7KnbS94qnb1iZAADxYXmu+D8Da7yx7DAEi6qD0
         X7sm5OjbS/W1CtcsJY4DpGOA0rwpitIt381IGnI44rO6i4hfyMb9laFfBPVIGGQELoEg
         Iv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuyHwLJRnB6jxTc1IB7c0ys/rrbHpiCHBZYkZOd5+aA=;
        b=D9btbe3YQ24hDFF3lEJndliEpAyWayCpF24NyN0gCVaLpxcuTVA3y8pA0KGv6VP7Ok
         9fa1e1Sj6QUD6mPQeXlZL7dG/JBPknbhYJePbQ8PYzIWzDpCziKCqD3ZqVG1qdvxo1zc
         Z1ZoQvqnC1CkcLQvDRhGoSmqMKronGAUqcuGeaDcdh6QnlidNtP2TJbAtdi0+0sZTzCV
         X9GN1BJggYz8jfePrg5wcfrjzNm8NvbiJ28Wm2VuWtS25twgMP8zyHjBBvNrsri1jY8w
         NsLsFEi6i1X2S0fEtwNe8Kd3tR3EbPsjbcu3uRbk35XW97sGwVhVRG7Srib/ES064VwC
         e8Gg==
X-Gm-Message-State: AOAM530I8X6lU3c4di6IP3L01RtVUBkKAzH7yQ3IiK4CpOXEPTjoDicA
        JM5Vuhz8tACpc8wVzV6+nAZPXWExKFBRKKVmzbGmsQ==
X-Google-Smtp-Source: ABdhPJzEYvmxkKtNlYwKn0L9QLyYj9aEx1L7dHIVoXaEJGqWJSEwrWbMRGZQUlzYp/hC+LakUnqJ3RfWneyXxhcdcOs=
X-Received: by 2002:a05:6512:533:: with SMTP id o19mr2029203lfc.6.1590682632866;
 Thu, 28 May 2020 09:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz> <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com> <20200528150310.GG27484@dhcp22.suse.cz>
In-Reply-To: <20200528150310.GG27484@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 May 2020 21:47:00 +0530
Message-ID: <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>,
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

On Thu, 28 May 2020 at 20:33, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 22-05-20 02:23:09, Naresh Kamboju wrote:
> > My apology !
> > As per the test results history this problem started happening from
> > Bad : next-20200430 (still reproducible on next-20200519)
> > Good : next-20200429
> >
> > The git tree / tag used for testing is from linux next-20200430 tag and reverted
> > following three patches and oom-killer problem fixed.
> >
> > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > protection"
> > Revert "mm, memcg: decouple e{low,min} state mutations from protectinn checks"
> > Revert "mm-memcg-decouple-elowmin-state-mutations-from-protection-checks-fix"
>
> The discussion has fragmented and I got lost TBH.
> In http://lkml.kernel.org/r/CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com
> you have said that none of the added tracing output has triggered. Does
> this still hold? Because I still have a hard time to understand how
> those three patches could have the observed effects.

On the other email thread [1] this issue is concluded.

Yafang wrote on May 22 2020,

Regarding the root cause, my guess is it makes a similar mistake that
I tried to fix in the previous patch that the direct reclaimer read a
stale protection value.  But I don't think it is worth to add another
fix. The best way is to revert this commit.


[1]  [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
from protection checks
https://lore.kernel.org/linux-mm/CALOAHbArZ3NsuR3mCnx_kbSF8ktpjhUF2kaaTa7Mb7ocJajsQg@mail.gmail.com/

- Naresh

> --
> Michal Hocko
> SUSE Labs
