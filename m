Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B46F0E35
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjD0WN1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjD0WN0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 18:13:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D735BD
        for <cgroups@vger.kernel.org>; Thu, 27 Apr 2023 15:13:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so13502001a12.0
        for <cgroups@vger.kernel.org>; Thu, 27 Apr 2023 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682633603; x=1685225603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgWZRPwaHBehs1AT1+EN1sm+gG/yK/cc9a/rK9nqc80=;
        b=TImfCv3uzAlaFIlONsUxs6zUYHviKGih0Ap26skG6pLvncBEDe1jEd+HM2+EYAuzzx
         ck6w3374QXKX1EOzf80afrzhU7Lg0y7s1+gPIGWI5YYLuVPHjnVTsDgKdTMXDtCoUwbn
         j5rB1ExQCHG3JTfgRXwq4XU+3J5LGv985H4gdDzQ5Ykk29usV26mnKtjFpQ3hmpN+jFo
         mdWnhRGw5r0FmXmRCPy484L017Uqf6QMqxBuuyYEEeUlrMeoePnV9CQBBaIh7j/cB3iP
         SmieYUpfNc1oxcCg97YzwuZrXWaTpe1Pma3RHiMaOq7xo2Le6jRZbFpC1EQybkCONi+Z
         kuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633603; x=1685225603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgWZRPwaHBehs1AT1+EN1sm+gG/yK/cc9a/rK9nqc80=;
        b=I5jmuOUbQkiFhsMnMRvN2iIOJghjuRnK2neRqTNSR5pakLs5vvkLa00W1oQzXC3UtK
         9S4mmlVI7rKkl0r8VN9NshrYqRF8LvaYTqC3N+sVm92vFu5WRmbIdsUVHuonuF8nroeR
         EB7xXuzcdlcrRleuagRyCtERXUTzT7PvGKaywv4G3ib3RfcarpekIDe4UybtuHCrpGeb
         ZGkRmnE1NnHZHFnzy6nSLOnnakL80Fo3IzcABBlJPEFVp0b7Xyv27miUl2iX8RSl/os8
         2kIvFM6ithqxhPoCAKK0AUuwW4d0JRBMyWgMYCFNx9+Yevl7CbhOHr4yg8N0bcRXw4fb
         K/2g==
X-Gm-Message-State: AC+VfDzrJaYUu6zq9AL745x9zIsZN95xFlxHOrS+m2ztRiI8/mqfTjAo
        n84m5HUUVAye3M8sno9jaBhn+XHvEffouCUcb4vx/A==
X-Google-Smtp-Source: ACHHUZ7irVRDWFdMcQ/JcCU0247Ju25WLRwjeb9kK7C67SvSDE8FmXgL1nKLu+fAA/sG21FJ6Pz48GaPXLfoZAeHuNQ=
X-Received: by 2002:a05:6402:4c1:b0:501:d6c2:7439 with SMTP id
 n1-20020a05640204c100b00501d6c27439mr2988689edw.37.1682633603348; Thu, 27 Apr
 2023 15:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com> <ZElC127xlU2NtlqF@dhcp22.suse.cz>
 <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com> <ZEqBesAJFfLZI65/@dhcp22.suse.cz>
In-Reply-To: <ZEqBesAJFfLZI65/@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 27 Apr 2023 15:12:46 -0700
Message-ID: <CAJD7tkac7VKV6Ob8qQWzhm8Ayyk3xB0YCY6edL-TxpXV3aCzXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 27, 2023 at 7:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 27-04-23 02:21:30, Yosry Ahmed wrote:
> > On Wed, Apr 26, 2023 at 8:27=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Wed 26-04-23 13:39:19, Yosry Ahmed wrote:
> > > > Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgrou=
p
> > > > OOM") made sure we dump all the stats in memory.stat during a cgrou=
p
> > > > OOM, but it also introduced a slight behavioral change. The code us=
ed to
> > > > print the non-hierarchical v1 cgroup stats for the entire cgroup
> > > > subtree, not it only prints the v2 cgroup stats for the cgroup unde=
r
> > > > OOM.
> > > >
> > > > Although v2 stats are a superset of v1 stats, some of them have
> > > > different naming. We also lost the non-hierarchical stats for the c=
group
> > > > under OOM in v1.
> > >
> > > Why is that a problem worth solving? It would be also nice to add an
> > > example of the oom report before and after the patch.
> > > --
> > > Michal Hocko
> > > SUSE Labs
> >
> > Thanks for taking a look!
> >
> > The problem is that when upgrading to a kernel that contains
> > c8713d0b2312 on cgroup v1, the OOM logs suddenly change. The stats
> > names become different, a couple of stats are gone, and the
> > non-hierarchical stats disappear.
> >
> > The non-hierarchical stats are important to identify if a memcg OOM'd
> > because of the memory consumption of its own processes or its
> > descendants. In the example below, I created a parent memcg "a", and a
> > child memcg "b". A process in "a" itself ("tail" in this case) is
> > hogging memory and causing an OOM, not the processes in the child "b"
> > (the "sleep" processes). With non-hierarchical stats, it's clear that
> > this is the case.
>
> Is this difference really important from the OOM POV. There is no group
> oom semantic in v1 and so it always boils down to a specific process
> that gets selected. Which memcg it is sitting in shouldn't matter all
> that much. Or does it really matter?

It is useful information that we already have and used to dump. It's
not really about which memcg the victim lived in, but which memcg is
not behaving as expected causing an OOM. If you have processes running
in the OOMing memcg itself as well as its descendants, then it's nice
to get an idea of which memcg's usage is not as expected.

>
> > Also, it is generally nice to keep things consistent as much as
> > possible. The sudden change of the OOM log with the kernel upgrade is
> > confusing, especially that the memcg stats in the OOM logs in cgroup
> > v1 now look different from the stats in memory.stat.
>
> Generally speaking oom report is not carved into stone. While we
> shouldn't make changes just nilly willy it might change for
> implementation specific reasons.

Agreed, but for this case there is really no reason to change the
behavior, and imo making restoring the behavior makes the code cleaner
/ more consistent.

>
> In this particular case I would agree that the new output is more
> confusing than helpful. Just look at
> > [   88.339505] pgscan 0
> > [   88.339505] pgsteal 0
> > [   88.339506] pgscan_kswapd 0
> > [   88.339506] pgscan_direct 0
> > [   88.339507] pgscan_khugepaged 0
> > [   88.339507] pgsteal_kswapd 0
> > [   88.339508] pgsteal_direct 0
> > [   88.339508] pgsteal_khugepaged 0
>
> These stats are actively misleading because it would suggest there was
> no memory reclaim done before oom was hit and that would imply a
> potentially premature OOM killer invocation (thus a bug). There are
> likely other stats which are not tracked in v1 yet they are reported
> that might add to the confusion. I believe this would be a sound
> justification to get back to the original reporting.

I don't think the collection of these stats is v2-specific, I was just
testing in a VM without swap, and the process had 100% anonymous
memory. Testing with swap gives sane stats:
[   68.851724] pgscan 248801
[   68.851725] pgsteal 123081
[   68.851725] pgscan_kswapd 0
[   68.851726] pgscan_direct 248801
[   68.851727] pgscan_khugepaged 0
[   68.851727] pgsteal_kswapd 0
[   68.851728] pgsteal_direct 123081
[   68.851728] pgsteal_khugepaged 0

However, I still think this change is valuable. Like you mentioned,
the OOM log is not set in stone, but we shouldn't just change it for
no reason. In this case, for cgroup v1 users, the OOM log changed for
no reason beyond a side effect of another patch. Upon upgrading our
kernel we noticed the behavior change. This patch restores the old
behavior without any cost really, and it makes the code a tiny bit
more consistent.

> --
> Michal Hocko
> SUSE Labs
