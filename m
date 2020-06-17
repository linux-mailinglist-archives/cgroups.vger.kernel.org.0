Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF451FD5CD
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 22:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgFQUOJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgFQUOJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 16:14:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9416BC0613ED
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 13:14:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so4473094ljc.8
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/gPu7TMycBU2OMmKICnzUSp+xjDAAHE5ZCXBHSedrA=;
        b=Hgg/nMoOfC6xMGf+J0M+j/XoZSAzvWUNAJO5oRrnxxQZz6Jmm0bdH9VjaHmTQ4XPAi
         n/s9J0wSZAWbIYX//BzBFy8dbEnTocLEWX0efF+Wc/Hi97+M0oDVNjosY09MY8AutLO8
         qpGLDMUievYu4q8rJPW79V9RO2lnQiRDoKZYOwvNwTOtAoz3Y1Yf4CYHpoxy71/O111x
         XyKu9yBw7Y6GEAQ6DbuX1G6elk8UAN33ZXvp/hMJY42Wbp16m3kGTmL6w9UxFO2mTphj
         NMM0Gh4+agGODtkiA7pegz8sjaNYzBN5MFM1gmXwuuNuXozNRhBVA/6Ak0mguCvAdC5y
         uIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/gPu7TMycBU2OMmKICnzUSp+xjDAAHE5ZCXBHSedrA=;
        b=XasQe1es1Bgjn4guYzBvpTIIlMhdzR5k+Itc9+zklkUCPirtoQ5t7ypZaT2Uk8GKfU
         cvbFgptcfW62K+C0MWsMV7Rqsqu9fj2w00pKC7EQkas52p3SNritanD160leggArnVoW
         uA7xwpkt2BkKe9sY2liwURvLzfb+2EuLRlL/nAiqqLPSmBbf5mCmvgrDi4qxfjqVyupo
         CwzoPlJo4vTGox2/b3KwoCK+XRg2jHtprhPB9tqT6YW08hR8UhaHAMmqOC3BiCPMurWG
         8vxTZF+8ebZOa3trEquB/fr6Th/zQNaPRLJ3YwDLnlAeyrzCbtLuN6rZBxFsh+uKLT04
         gqmw==
X-Gm-Message-State: AOAM530afkxx/kpBpzFwiODgih8UaGEiVUAXoCL6nYc97O2qJoupXwOa
        uVN9CBZE2FH+Rx5+VU0MOzHYnm/ghpqK3OYXRq2UCw==
X-Google-Smtp-Source: ABdhPJxu/rE2rptP5d+WfyaHgfX2ttcXAh33IxS8fL6XLG7WEVYacg0tdg5G22BFQHF/I4DoFwlWnsCjNWKyglTnJas=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr480197ljj.102.1592424845650;
 Wed, 17 Jun 2020 13:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz> <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name> <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com> <20200617160624.GS9499@dhcp22.suse.cz>
In-Reply-To: <20200617160624.GS9499@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 Jun 2020 01:43:53 +0530
Message-ID: <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>, Chris Down <chris@chrisdown.name>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
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

On Wed, 17 Jun 2020 at 21:36, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 17-06-20 21:23:05, Naresh Kamboju wrote:
> > On Wed, 17 Jun 2020 at 19:41, Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > [Our emails have crossed]
> > >
> > > On Wed 17-06-20 14:57:58, Chris Down wrote:
> > > > Naresh Kamboju writes:
> > > > > mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
> > > > > mke2fs 1.43.8 (1-Jan-2018)
> > > > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > > > Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
> > > > > Superblock backups stored on blocks:
> > > > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > > > 102400000, 214990848
> > > > > Allocating group tables:    0/7453 done
> > > > > Writing inode tables:    0/7453 done
> > > > > Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
> > > > > [   51.845304] under min:0 emin:0
> > > > > [   51.848738] under min:0 emin:0
> > > > > [   51.858147] under min:0 emin:0
> > > > > [   51.861333] under min:0 emin:0
> > > > > [   51.862034] under min:0 emin:0
> > > > > [   51.862442] under min:0 emin:0
> > > > > [   51.862763] under min:0 emin:0
> > > >
> > > > Thanks, this helps a lot. Somehow we're entering mem_cgroup_below_min even
> > > > when min/emin is 0 (which should indeed be the case if you haven't set them
> > > > in the hierarchy).
> > > >
> > > > My guess is that page_counter_read(&memcg->memory) is 0, which means
> > > > mem_cgroup_below_min will return 1.
> > >
> > > Yes this is the case because this is likely the root memcg which skips
> > > all charges.
> > >
> > > > However, I don't know for sure why that should then result in the OOM killer
> > > > coming along. My guess is that since this memcg has 0 pages to scan anyway,
> > > > we enter premature OOM under some conditions. I don't know why we wouldn't
> > > > have hit that with the old version of mem_cgroup_protected that returned
> > > > MEMCG_PROT_* members, though.
> > >
> > > Not really. There is likely no other memcg to reclaim from and assuming
> > > min limit protection will result in no reclaimable memory and thus the
> > > OOM killer.
> > >
> > > > Can you please try the patch with the `>=` checks in mem_cgroup_below_min
> > > > and mem_cgroup_below_low changed to `>`? If that fixes it, then that gives a
> > > > strong hint about what's going on here.
> > >
> > > This would work but I believe an explicit check for the root memcg would
> > > be easier to spot the reasoning.
> >
> > May I request you to send debugging or proposed fix patches here.
> > I am happy to do more testing.
>
> Sure, here is the diff to test.
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c74a8f2323f1..6b5a31672fbe 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -392,6 +392,13 @@ static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
>         if (mem_cgroup_disabled())
>                 return false;
>
> +       /*
> +        * Root memcg doesn't account charges and doesn't support
> +        * protection
> +        */
> +       if (mem_cgroup_is_root(memcg))
> +               return false;
> +
>         return READ_ONCE(memcg->memory.elow) >=
>                 page_counter_read(&memcg->memory);
>  }
> @@ -401,6 +408,13 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>         if (mem_cgroup_disabled())
>                 return false;
>
> +       /*
> +        * Root memcg doesn't account charges and doesn't support
> +        * protection
> +        */
> +       if (mem_cgroup_is_root(memcg))
> +               return false;
> +
>         return READ_ONCE(memcg->memory.emin) >=
>                 page_counter_read(&memcg->memory);
>  }


After this patch applied the reported issue got fixed.

test log link,
https://lkft.validation.linaro.org/scheduler/job/1505417#L1429

- Naresh
