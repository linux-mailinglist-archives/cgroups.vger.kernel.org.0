Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0552EC15E
	for <lists+cgroups@lfdr.de>; Wed,  6 Jan 2021 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAFQnc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Jan 2021 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbhAFQnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Jan 2021 11:43:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C813C06134D
        for <cgroups@vger.kernel.org>; Wed,  6 Jan 2021 08:42:52 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h205so7953620lfd.5
        for <cgroups@vger.kernel.org>; Wed, 06 Jan 2021 08:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utozISaxL63drmUZAC6aSc+ai12dhlJYUKebxiFAYAo=;
        b=NJgC/VUIvpf5fbTrQst8wZDFHYVt/5v9vItzWgOp62erRY5JkQGsNMvKLDONIPp/BD
         zfZi6fl4PjIAf6Zmb7/vqYHlqhAebazjLTxpe49ORp+LFKCsUl04l9F1aU1l3EZZwSL7
         3C2r0OzvfFvuvUAJEVE08+OI3ztkKPl0RHcNxLSH43zDth8rS2q9Ka97JE1HGgk34A9Y
         urfd7r+YFlHUazX1lwYuWsVOio3w20BEArpVhHgsEz5f91diI5p1QamKhRnX9eKPmEId
         K04++Bd9AxG5mDliD9J8T6GMEBG1NZe2MXWAd43BvvvkRi9lRGkmf108ZUt8111O7wJJ
         DPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utozISaxL63drmUZAC6aSc+ai12dhlJYUKebxiFAYAo=;
        b=cxYf7HlHfVNtD5gCk5jcfWFIOABjQQ/yRtu+1U2l8rTaxZapW1lKRiQhH8tARfQu/z
         feSbV0XQhWka/jzML6t8ZTakHV342vQG/7pCIeZRVOznI98aRgRIHp5pRI7xfgs9XZtb
         ivM/ezUOUGs9IoLJArm96Yq+RkztY2J1FGtBKSfRbb1Iixw1xh++iTddqSF1OYUocPLU
         nNbkxGo3p/NUzN217/pIJqhGXIeL5KkgJ28RHZJZhhZUhL7OA5TsJ7IcxUeO/xfdzBAt
         9ttQaqOtvOPgmrZYRNnjlL7jzGBp9j0JkPcXKt80x9r5M0bupAto0WIA7HuglSsM/F2K
         7nZg==
X-Gm-Message-State: AOAM531h0nBy3ViU+Olyv7pKNE1lBCkc1BcBcE/Gh6cE5lZALDxmzych
        nwntaidNLcHwB2WAtI0Nx+kyWlt4iUOhpxu4Mg25kA==
X-Google-Smtp-Source: ABdhPJz6sko5HMPEfkQrN85i00eLQUoW4zoZJ8FAgB1q4AMuFrWhAoVoO4+B6xGWkCe5D/2dMCk6WPBdue2cAblgRgc=
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr2217118lji.160.1609951370229;
 Wed, 06 Jan 2021 08:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20210101023955.250965-1-shakeelb@google.com> <20210106145349.GN13207@dhcp22.suse.cz>
In-Reply-To: <20210106145349.GN13207@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Jan 2021 08:42:39 -0800
Message-ID: <CALvZod6Lv3gWmWRPP7jAaw4YCQPyPXcxqXTO3Vp6YVZ6AcEH4w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: add swapcache stat for memcg v2
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 6, 2021 at 6:53 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 31-12-20 18:39:55, Shakeel Butt wrote:
> > This patch adds swapcache stat for the cgroup v2. The swapcache
> > represents the memory that is accounted against both the memory and the
> > swap limit of the cgroup. The main motivation behind exposing the
> > swapcache stat is for enabling users to gracefully migrate from cgroup
> > v1's memsw counter to cgroup v2's memory and swap counters.
> >
> > Cgroup v1's memsw limit allows users to limit the memory+swap usage of a
> > workload but without control on the exact proportion of memory and swap.
> > Cgroup v2 provides separate limits for memory and swap which enables
> > more control on the exact usage of memory and swap individually for the
> > workload.
> >
> > With some little subtleties, the v1's memsw limit can be switched with
> > the sum of the v2's memory and swap limits. However the alternative for
> > memsw usage is not yet available in cgroup v2. Exposing per-cgroup
> > swapcache stat enables that alternative. Adding the memory usage and
> > swap usage and subtracting the swapcache will approximate the memsw
> > usage. This will help in the transparent migration of the workloads
> > depending on memsw usage and limit to v2' memory and swap counters.
>
> Could you expand a bit more on why memsw usage is important even in
> cgroup v2 land? How are you going to use the approximated value?
>

Two main benefits. First, it hides the underlying system's swap setup
from the applications. Applications with multiple instances running in
a datacenter with heterogeneous systems (some have swap and some
don't) will keep seeing a consistent view of their usage.

Second, most of the applications (at least in our prod) are not really
interested in two separate memory and swap usage metrics. A single
usage metric is more simple to use and reason about for these
applications.
