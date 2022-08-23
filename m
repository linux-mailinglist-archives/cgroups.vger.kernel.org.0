Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338AA59CE9E
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 04:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiHWCc3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 22:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbiHWCc2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 22:32:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF85C343;
        Mon, 22 Aug 2022 19:32:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s1so15045536lfp.6;
        Mon, 22 Aug 2022 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=azDpKc6FmKTWyiu0fmvIHIHwLpZTiSK1Vlo7KGhRPTI=;
        b=mOKeqhKYQhMwTLb/MJ8y4BKHtrVT0tL2CLpCqVd982RWh8CKypL1YXMQXH9RXkOYQr
         svAS8E3tjh/3TZXskHT6eiLzVii7BtFjyyzENE09sgcCl7PJOTZQWNQD8oFDmCLcPXxa
         R/SMm/X+qEvkdwTnfYLBoFOyLKxMa7H4tewBNQKxpr2iMRa4oHMf6GfZsxsD05kpWw6K
         L/savuxwWhzpBfzVfVKYEpe6LpvurZbJQkwKDJE7yHE72w3Ud+yG4pGeBHqQHKtM7eGC
         4y4R1fkzSDJznz1sFG8M7pcRZw1BIJ/Zv3f9VGj0uvD2h7jmIDOaTWdLm9GEI9Yyev0m
         4fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=azDpKc6FmKTWyiu0fmvIHIHwLpZTiSK1Vlo7KGhRPTI=;
        b=JAYRxH3ruUM+Tzk7cEfLyjp/wWYpr0T87q4PZbpZ0lxEZkW4tpJvY4+Ms8rX5M6kYQ
         cfnyNNIcZEkxyr+hyVbazcxuwS41J4Nbzc7+KFb/udjlKmZ6JaksGawMIlkN0wuxNT8m
         sUEJGc2EvuqnFViRdaxV2XBifJCC2Z/jbBW0fkdMh5OvpIiU8Rq6fJoVisFuLMGHUZ2a
         5eox/0MwjB79SngpsyZPdP2SvT1KVioq/nwGKjL4uD+m/UdUxDdT9iNKxyWJ6ZgGOrYv
         48q0iGtOn+yLUcp3UgD4sgrmQ3dLNbNeFAzSaPyum93aom/d5j2Je47c53hmPmIuwUOk
         myiA==
X-Gm-Message-State: ACgBeo2rcfcuaLz99kWyjrIe5FqkuvTZTdCN+BCveDLUFU1Ze9iCZ8Iz
        Sc35KH1BS7ZUBXRgqngt7cUV9wS4F24WFMRlkqU=
X-Google-Smtp-Source: AA6agR7n7DYHM3nnCy3WsU33BTmDevHz36ukTKY/dIEFVwM+0Xllyb5Tl//2wtM9CLs3Zive755sFqin5YU2aVXNPCY=
X-Received: by 2002:a05:6512:1527:b0:48b:99:f3ff with SMTP id
 bq39-20020a056512152700b0048b0099f3ffmr7843690lfb.81.1661221945792; Mon, 22
 Aug 2022 19:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yv+6YjaGAv52yvq9@slm.duckdns.org> <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org> <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
In-Reply-To: <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 23 Aug 2022 10:31:57 +0800
Message-ID: <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
To:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 22, 2022 at 7:31 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 19-08-22 07:10:26, Tejun Heo wrote:
> > On Fri, Aug 19, 2022 at 10:08:59AM -0700, Shakeel Butt wrote:
> > > On Fri, Aug 19, 2022 at 9:29 AM Tejun Heo <tj@kernel.org> wrote:
> > > >
> > > > On Fri, Aug 19, 2022 at 07:29:22PM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > It is observed in android system where per-app cgroup is demanded by freezer
> > > > > subsys and part of groups require memory control. The hierarchy could be simplized
> > > > > as bellowing where memory charged on group B abserved while we only want have
> > > > > group E's memory be controlled and B's descendants compete freely for memory.
> > > > > This should be the consequences of unified hierarchy.
> > > > > Under this scenario, less efficient memory reclaim is observed when comparing
> > > > > with no memory control. It is believed that multi LRU scanning introduces some
> > > > > of the overhead. Furthermore, page thrashing is also heavier than global LRU
> > > > > which could be the consequences of partial failure of WORKINGSET mechanism as
> > > > > LRU is too short to protect the active pages.
> > > > >
> > > > > A(subtree_control = memory) - B(subtree_control = NULL) - C()
> > > > >                                                       \ D()
> > > > >                           - E(subtree_control = memory) - F()
> > > > >                                                         \ G()
> > > > >
> > > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Just in case it wasn't clear.
> > > >
> > > > Nacked-by: Tejun Heo <tj@kernel.org>
> > > >
> > > > Thanks.
> > > >
> > >
> > > Was there a previous discussion on this? The commit message is unreadable.
> >
> > http://lkml.kernel.org/r/1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com
>
> Even that discussion doesn't really explain the real underlying problem.
> There are statements about inefficiency and trashing without any further
> details or clarifications.
I would like to quote the comments from google side for more details
which can also be observed from different vendors.
"Also be advised that when you enable memcg v2 you will be using
per-app memcg configuration which implies noticeable overhead because
every app will have its own group. For example pagefault path will
regress by about 15%. And obviously there will be some memory overhead
as well. That's the reason we don't enable them in Android by
default."
>
> My very vague understanding is that the Android system would like to
> freeze specific applications and for that it requires each application
> to live in its own cgroup. This clashes with a requirement to age and
> reclaim memory on a different granularity (aka no per process reclaim).
> So in fact something that cgroup v1 would achieve by having 2
> hierarchies, one for the freezer which would have a dedicated cgroup for
> each application and the other for the memory controller where tasks are
> grouped by a different criteria. This would rule out that a global (or
> any external memory pressure) reclaim would age LRUs that contain a mix
> bag of application pages rather than iterate over per-application LRUs.
> Is that understanding correct?
Correct, this is just our confusion. Besides, we believe that charge
the pages to implicit memory enabled parent control group doesn't make
sense as the memory cannot be managed at all.
> --
> Michal Hocko
> SUSE Labs
