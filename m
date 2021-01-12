Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14A2F3CE9
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 01:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436708AbhALVhV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436921AbhALU25 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 15:28:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C80C061786
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 12:28:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o10so5276960lfl.13
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5960geX9HCG16DZ39o4+2JHIAqK0nJMhnDxc5cpnSNU=;
        b=GkTjCKATdgwwzl5zWFKM/GZkJ8Ru5mD2K4+0F8dAgffuBUOVU+23PX0EQ32Blth15w
         JG7AF7Z66SHX+yZKqO4phDlR31DIpX/ncUdaDbhFLbNBCt8yLxNJ4dZS7u1rUVE6tpaH
         +HDiGZhynjjrtmmziGnzXsAsJ5iYJkxSXkDi1q7gwxJs9+p6ZKTagbX6o3TGF7DkFF+N
         68trtXJdFXS/9iK8vcTYWckfat2CPb6DnRQ/pT2cX6VG/5Dh7iaiF44HAEPKNkdL90xT
         BXsKesBCDYzHOyFbbyEKIKnz4Jtp8aNIG2C6b3rUzc3TjWPq7dE55a+n0ogYYoHtyDj3
         5p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5960geX9HCG16DZ39o4+2JHIAqK0nJMhnDxc5cpnSNU=;
        b=qcpDlLw2FziTI039VNXkxkf7uiV5OU5jfMj7mOdayAAqY/VVxV4P7acbi/Rk3PiEPZ
         nR16NoTYTopaQSUHeGacKKjYd9eg0MXrpiFntqPfr2wfGj5BvkcarBr64dloE2cBhFpB
         m4p7oo5FwH9N7LyQnRxchZiIPk0EBemRgWnoNGLlZDwzHGXD+Bgr8m59fDqux5J5H+Co
         Xa430bKV0dIhYWdSm1I6taGEIC8vZtsCdGqppogfr5hhdq+7pV3hRNAhtUqisI9Np9K7
         /Lf+KjhjRg5Hk7Z3nWq/fvoM098hOWnxL2lKNK4ewp35DW/X/a7YgtPJj709ozsa0Azt
         PIrw==
X-Gm-Message-State: AOAM530zEO+CelWokM9TiH8f4KEzUXjZKHs2EfsBuEiqVJJoXlRqCAQo
        tvm8SCwq+2PMjQhxBu0iQz39vOiTy/bFrf9xlNralw==
X-Google-Smtp-Source: ABdhPJwCQ+KHw0YYH7t/aGGO4JPatl+HtEdaW2X4PZ4+wyKoFsnmqV8R9BIFSXKRLdy8xpSwOj4zzANfZ6KkElnR2Oc=
X-Received: by 2002:a05:6512:20c1:: with SMTP id u1mr258609lfr.549.1610483295372;
 Tue, 12 Jan 2021 12:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20210112163011.127833-1-hannes@cmpxchg.org> <CALvZod4VFA52dsdkW79-gUbiCf2ONfFJj6LkRU+3-fQpvYXL+A@mail.gmail.com>
 <X/3+IgDVb+Jn4XfQ@cmpxchg.org>
In-Reply-To: <X/3+IgDVb+Jn4XfQ@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jan 2021 12:28:04 -0800
Message-ID: <CALvZod4qKrwvT7MAKrhemjrBfAAsk=fKa9g8QRij42j0CaF4nw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing memory.high
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 11:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Jan 12, 2021 at 10:59:58AM -0800, Shakeel Butt wrote:
> > On Tue, Jan 12, 2021 at 9:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > When a value is written to a cgroup's memory.high control file, the
> > > write() context first tries to reclaim the cgroup to size before
> > > putting the limit in place for the workload. Concurrent charges from
> > > the workload can keep such a write() looping in reclaim indefinitely.
> > >
> >
> > Is this observed on real workload?
>
> Yes.
>
> On several production hosts running a particularly aggressive
> workload, we've observed writers to memory.high getting stuck for
> minutes while consuming significant amount of CPU.
>

Good to add this in the commit message or at least mentioning that it
happened in production.

> > Any particular reason to remove !reclaimed?
>
> It's purpose so far was to allow successful reclaim to continue
> indefinitely, while restricting no-progress loops to 'nr_retries'.
>
> Without the first part, it doesn't really matter whether reclaim is
> making progress or not: we do a maximum of 'nr_retries' loops until
> the cgroup size meets the new limit, then exit one way or another.

Does it make sense to add this in the commit message as well? I am
fine with either way.

For the patch:
Reviewed-by: Shakeel Butt <shakeelb@google.com>
