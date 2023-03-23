Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9A6C6C6B
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjCWPko (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCWPkn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 11:40:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FECE2057C
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 08:40:42 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so25351088ybu.8
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679586041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXqZ3IJA77cnf/fukJT6xyyWj+RxTe/4tMZOB+1mbkQ=;
        b=pZto6I+vvxaphKg4Ca9NDWCYEUNhj7BJYmHfaAG8M51g5rBMERT2pTxw32czJVRwqf
         EXpqwyXIM77qAJ204++TM8DrNrSWXsJyryfpkiZaymGsJv+mhNCo+v4QMcuWklOwQ1zb
         14XunBWOhtBzzFTiU3Gj8RFDbfEQ4MSASypSDfsLzNrh14XAxfBwpnKQD7EnPJaTeklc
         QpjEu0BIrsjS593Tol8303VAwfsZeO1qSu7wHKzhAJW4G9NFMuqTCi3YV8xqFEcXgHrN
         7FMdZFQg1MqDPNCzODUn974BlGYh8gXmdMD2HE3tXqWplxkq95RhThaIWYkoMKBBBJ0Y
         EGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXqZ3IJA77cnf/fukJT6xyyWj+RxTe/4tMZOB+1mbkQ=;
        b=q4eIHyHEiyVrIf7enJ1qOWdtbkirYOGVY+HFMxP/5BWbX0vh3WK3obqlUnAY2bW89i
         5vBaC7rI/FSt8DU6lN8CGQHDfex/ob0pqnL5OEFLntWASQzvoY2725lB9bC8wjIhWba1
         N9+5dCjBtgzgQz/QM82rXxSbLcjiNlGNNU6Y6cSk60WMIxPi6hfHOcvPSrbItHXfR2R5
         bbLVK9jM5XO/431h70Qe9f8aKZBLaQ1KzE5eVI/4Cb793atm4LJ3EINsGC0Nhn3DHqOg
         odZk9rKyYYxM8gV1nwhdPUkZH8bOBylj+kslBx3K9hcETLLtNm1fUBJDoVqUlbUIyQrm
         3OtQ==
X-Gm-Message-State: AAQBX9fxRwGdvgn4wKCIpwaUUIQCPmG3g0uaUz0ScfyxhhoMnWDRdyEb
        4pgWkoW8VKEFmUgGCEQ15NpS9aqTjO425q3fyfi3eA==
X-Google-Smtp-Source: AKy350a50T0eMMPyL8hbiqxSf8FqZlw1dWta2IKhAFk++fAM4XiuwKP9tfvhLOJ/p8i1fAwcvy/Zde16et8l9oC4gKw=
X-Received: by 2002:a05:6902:1083:b0:b67:d295:d614 with SMTP id
 v3-20020a056902108300b00b67d295d614mr2101971ybu.12.1679586041114; Thu, 23 Mar
 2023 08:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com> <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
In-Reply-To: <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Mar 2023 08:40:29 -0700
Message-ID: <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> > >
> > > > 2. Are we really calling rstat flush in irq context?
> > >
> > > I think it is possible through the charge/uncharge path:
> > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
> > > added the protection against flushing in an interrupt context for
> > > future callers as well, as it may cause a deadlock if we don't disabl=
e
> > > interrupts when acquiring cgroup_rstat_lock.
> > >
> > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
> > > > done for root memcg. Why is mem_cgroup_threshold() interested in ro=
ot
> > > > memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?
> > >
> > > I am not sure, but the code looks like event notifications may be set
> > > up on root memcg, which is why we need to check thresholds.
> >
> > This is something we should deprecate as root memcg's usage is ill defi=
ned.
>
> Right, but I think this would be orthogonal to this patch series.
>

I don't think we can make cgroup_rstat_lock a non-irq-disabling lock
without either breaking a link between mem_cgroup_threshold and
cgroup_rstat_lock or make mem_cgroup_threshold work without disabling
irqs.

So, this patch can not be applied before either of those two tasks are
done (and we may find more such scenarios).
