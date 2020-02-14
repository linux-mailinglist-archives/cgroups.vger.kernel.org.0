Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA815F9CE
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 23:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBNWiW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 17:38:22 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45943 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgBNWiW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 17:38:22 -0500
Received: by mail-yb1-f196.google.com with SMTP id j78so2133814ybg.12
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhXhwNSRwdSyi+H9zMRuLq0WFPtWCQTooj0QtYbRLG8=;
        b=LYB/2WoTc0NUWQ7WAgvwRxpic7dTAP9/iI+IjkZnQRJx+5k39FyA4S4N3pmh8wcWqz
         AvLEKE2SjemIzT9ZtDMYJ5uqfQfwIBVHdbyFYDdMnzm8nm8qRGQ7OcBlUWfrU4zHwvZb
         PhUuwhIPS3pSexguM+13PMLeT8PeHqXx37bpMydKP8fZVFkdxVBVbBNTMz/IMIkXGKFs
         oE2s8v7rPEwjU9xEMptc3TmOHtHV/g5owFopfH0Fm7rh7Hr8J5cZw9cTWP5dmeyCnXNn
         rq3L8OW1us+mcfcgMy3ATrfW0PSGDZglwVRh7HmIoFZvLw78Vnokrdl77eiZ6m4SVJW0
         eoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhXhwNSRwdSyi+H9zMRuLq0WFPtWCQTooj0QtYbRLG8=;
        b=Ip0hnJR/fowhl3hoBlphJxZOaXswR+bD+boZeR+2qHAfxuI5/gFs+ldHtfFGxwh1kS
         FvQ4lKZacIDCUsMiaAm0TX1jBtQebENzbzarRgMvnvP04MBMaMXt0cDFwGxNKijWk7b5
         SqGfKXySgeySrzffIL706o+H2rxBEbT0j3EwOmqBNvDzlfUjX0bI7SX6YmidF/WqYkYP
         72TPM5iromjzM6RaRuXu8kinpu/FKlmaShwvfJMigKRN1ZcCtkSRqyJ5qI+u31Afm41w
         wwb064WMaw6opz8ZdUjXq/vopCsKaxP3HL13seDSAe3IRFrwpJ9y5uhUmB6swbcBob/N
         enRg==
X-Gm-Message-State: APjAAAVRyqK6Y4dy+w8c+2titZo/pJHrSyS5/21pNP6J8No5q2Pz0Bjc
        aWiNtEABYQVdFwLdaQ7OMkL6I1oRuWPy/5sW7az5Rg==
X-Google-Smtp-Source: APXvYqz+ZZXlYqlAQb5giYd0uucVgxWoIM7WTe+nBKxOuFOoTQpgJCgcsNG7WFknrZTkO08/9TW493jWkTycKh+Cw5c=
X-Received: by 2002:a25:80c5:: with SMTP id c5mr4632219ybm.364.1581719899696;
 Fri, 14 Feb 2020 14:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com>
In-Reply-To: <20200214222415.181467-1-shakeelb@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Feb 2020 14:38:08 -0800
Message-ID: <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 2:24 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> We are testing network memory accounting in our setup and noticed
> inconsistent network memory usage and often unrelated cgroups network
> usage correlates with testing workload. On further inspection, it
> seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
> irq context specially for cgroup v1.
>
> mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in irq context
> and kind of assumes that this can only happen from sk_clone_lock()
> and the source sock object has already associated cgroup. However in
> cgroup v1, where network memory accounting is opt-in, the source sock
> can be unassociated with any cgroup and the new cloned sock can get
> associated with unrelated interrupted cgroup.
>
> Cgroup v2 can also suffer if the source sock object was created by
> process in the root cgroup or if sk_alloc() is called in irq context.
> The fix is to just do nothing in interrupt.

So, when will the association be done ?
At accept() time ?
Is it done already ?

Thanks


>
> Fixes: 2d7580738345 ("mm: memcontrol: consolidate cgroup socket tracking")
> Fixes: d979a39d7242 ("cgroup: duplicate cgroup reference when cloning sockets")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>
> Changes since v1:
> - Fix cgroup_sk_alloc() too.
>
>  kernel/cgroup/cgroup.c | 4 ++++
>  mm/memcontrol.c        | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9a8a5ded3c48..46e5f5518fba 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6449,6 +6449,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
>                 return;
>         }
>
> +       /* Do not associate the sock with unrelated interrupted task's memcg. */
> +       if (in_interrupt())
> +               return;
> +
>         rcu_read_lock();
>
>         while (true) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 63bb6a2aab81..f500da82bfe8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6697,6 +6697,10 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>                 return;
>         }
>
> +       /* Do not associate the sock with unrelated interrupted task's memcg. */
> +       if (in_interrupt())
> +               return;
> +
>         rcu_read_lock();
>         memcg = mem_cgroup_from_task(current);
>         if (memcg == root_mem_cgroup)
> --
> 2.25.0.265.gbab2e86ba0-goog
>
