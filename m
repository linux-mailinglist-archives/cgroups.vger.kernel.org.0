Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471DB4AE20F
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377071AbiBHTRE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 14:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385912AbiBHTRE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 14:17:04 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76AC0613CB;
        Tue,  8 Feb 2022 11:17:02 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id z19so35140644lfq.13;
        Tue, 08 Feb 2022 11:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaoHziOwSYqy0wTWrxCWrGSPLMiaVVe/sOp7KuqGagE=;
        b=zsIr9cx19AHQ8dFaCgZ88p3rlVikFD7aeqSYIKMNSBzN9H6K3xUdW+7KlAVTetfomA
         k0kg4lGsiTWPN9FvTHbpkQeknXlQF41SezZaPOlgAuFRnxJOBn/pvS6LCT94FemSPDQo
         xQ2lhAqYWZ1ixbw31glOyXt86VTDBqYlaLiczwoU8soloc90oeE7gV8L+O1rfgeTmuzu
         GhY5ZaRXpOED04giIEvftsdNO4fXprx13FJky6zZq1jgBzghLXMd4oj7C6sqMcIKjSYq
         /QWU8l4f/0GfkyM7N/nnHSPreszpWF6Hv3UxwE51lGNHUev984Qj/+5yjLgaRywgemHp
         VvpA==
X-Gm-Message-State: AOAM531VHby/Mz0s/7Ka6Rgh90bBztz0MTxhr8GbkL77MSDWwrmax1ov
        czoefASXl291TeBxIZOGofh+Ew9xWfpw97Xt824=
X-Google-Smtp-Source: ABdhPJzTXJ6stf2QPxiYffdaSUv6Lqs25/4OYa4M2UmF8wSE+vpSmPNxe/r1A2PGislK43syDvGXv6LsFpoFWy6yOrI=
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr3843084lfo.99.1644347817769;
 Tue, 08 Feb 2022 11:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-3-namhyung@kernel.org>
 <YgK6k4TXnRbm02dh@slm.duckdns.org>
In-Reply-To: <YgK6k4TXnRbm02dh@slm.duckdns.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Feb 2022 11:16:46 -0800
Message-ID: <CAM9d7cgKLycpFuXq0VgC=ADtAipXtKdfRcDqvZwMrNBz7hXd7A@mail.gmail.com>
Subject: Re: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name readable
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Tue, Feb 8, 2022 at 10:46 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Feb 08, 2022 at 10:41:58AM -0800, Namhyung Kim wrote:
> > The raw_spin_lock_init() uses the argument to name its lockdep map.
> > But passing per_cpu_ptr() macro directly makes it a very very long
> > name as it expanded like below:
> >
> >   ({ do { const void *__vpp_verify = (typeof((&cgroup_rstat_cpu_lock) ...
> >
> > Let's fix it by passing a local variable instead.  With this change,
> > the name now looks like:
> >
> >   cgrp_rstat_cpu_lock
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Zefan Li <lizefan.x@bytedance.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: cgroups@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

>
> but maybe add a comment explaining what's going on?

Sure, I'll add the comment.
