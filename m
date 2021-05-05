Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92243746D0
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 19:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhEER21 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 13:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbhEERI7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 13:08:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB7C0612AF
        for <cgroups@vger.kernel.org>; Wed,  5 May 2021 09:42:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j10so3449252lfb.12
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZSxOum7tgcfufyRQ0ud4aq7JR1hA71f4tT5tJF5bAk=;
        b=Y2ETgANl3oMRKwl6lTT7wNph2JFAn/CkXrVJyf9nplhyQV+ERSGAfGrbICtcc3Pk79
         p2lfZZY816/lXdrvktWAGAerrc2sqMixaIzcCbHqZlhG2vnfMHN3hxvQaQxYdrwN1Koh
         Bw3HP2t+fmXF+uwtKQBJbzcf7Ptu6pFNTKjXuglYMC6Z/Eay9e/08lohNc8Z2CqoMzJw
         zcfBlcg828zoW052cHxSeu4wfWtk+WqxjJJ3d723hYhGLmSiQR0+rk207FC34o3W512D
         ToH8DVmgr3e/xYORr361TMepy4sigreWXlGhxRR58UffKENoodP/rjeBmd7L4spy/DC3
         Mr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZSxOum7tgcfufyRQ0ud4aq7JR1hA71f4tT5tJF5bAk=;
        b=lVeTbPHZm97P0qU8WMS0PchLEMJIDy4t8iFNkqsjzcVA1U+2kekY5mm+dVfhFMN1nz
         MsEzTrrgzkTJUD40TL7FrOX/saV2GWTPkQArqANyhPalqLmFsO6EAGwZ7S/9OKlynbhh
         unGwMMZrMXn45zjR8Af5NfcD/lVer4WRBVDo/smhKHZeZurSTivZ9UQjhyfs8SvuLVdP
         CdVxemRQLUd9/Rpn8L/cPEe+RuGgd1mcMBsOKcvgUhcAmq6XEN/dsjRaU1D/ZGeh6uII
         Q2W4jOQrisXd5TlAPBZ5y7ZgERS7XBR9HkwUZYjC84lwQ13by0nnGImn5OsRW/4dTTpz
         3IuA==
X-Gm-Message-State: AOAM531VcWdpfUUGYZej5gbtDtC+Sc/rYEtdLM5oN3LR9Rv1SCdZzIOQ
        zLWhxHZYlir6MT/KzedufZZGrpd7Psy3BSy/T5WZIw==
X-Google-Smtp-Source: ABdhPJxbzHN0Rtp018rkdGVcvDz8gBPLtH2b/ifzGoeUYRWEhbAmbH0ymXkaFDceBvhiyhHwZ/BluJrulOoyqWmLlCI=
X-Received: by 2002:a05:6512:2344:: with SMTP id p4mr6061761lfu.299.1620232939951;
 Wed, 05 May 2021 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210503143922.3093755-1-brauner@kernel.org> <20210503143922.3093755-3-brauner@kernel.org>
In-Reply-To: <20210503143922.3093755-3-brauner@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 09:42:08 -0700
Message-ID: <CALvZod6nTDc4Jx4UG3HKaugA1F_2N-rG+xqACAKVkKJjqxWOXg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tests/cgroup: use cgroup.kill in cg_killall()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 3, 2021 at 7:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> If cgroup.kill file is supported make use of it.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
> /* v2 */
> - Roman Gushchin <guro@fb.com>:
>   - Fix whitespace.
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 027014662fb2..f60f7d764690 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -252,6 +252,10 @@ int cg_killall(const char *cgroup)
>         char buf[PAGE_SIZE];
>         char *ptr = buf;
>
> +       /* If cgroup.kill exists use it. */
> +       if (!cg_write(cgroup, "cgroup.kill", "1"))
> +               return 0;

Now cg_killall will kill all the processes in the tree rooted at
cgroup which I think is fine.

> +
>         if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
>                 return -1;
>
> --
> 2.27.0
>
