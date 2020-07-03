Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB0213BBE
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGCOXb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCOX2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 10:23:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8FC08C5DD
        for <cgroups@vger.kernel.org>; Fri,  3 Jul 2020 07:23:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s9so37142751ljm.11
        for <cgroups@vger.kernel.org>; Fri, 03 Jul 2020 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAsbhYpysmstHPq0Op9MjqJaZ7YDRLDrp7Rg8i0eT+Q=;
        b=KacU4DChX8owr3WxGngcQJG0ITHWxa2x5YJZMRcO1Oq8g8suqMxqCIKz2KIVn+GX0G
         NlL4sAx7SWLe7wOoKqalqC8WPtCsOVDiIJl2ugaBNTqIy8m+xXXNOoboIPQNY0hU4eh5
         Cv+CRClsFvZBzHLaY4R8w4zl6/ZmyudVjt3Ym/CNTRtKSCKgM5mCowbGng/unHeM1X6G
         rX9V5/vB5ZifMJFjN2LTDNr4RYI0VvFlBsKbHhDWHWGHEv13TdNi3C8BfxPrrTetX9vs
         vMD4jQOdARdwlqk8ECDSA4gMLt9sQnF8RfswofOxXeklF/ny6lafGO5LMCzz1KNSzmw1
         ZJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAsbhYpysmstHPq0Op9MjqJaZ7YDRLDrp7Rg8i0eT+Q=;
        b=HtWovDFBl47GxMKfSdlZwrPd6Ze3B708YF+GUvB4kp67cfKkSMq8Sz1jJMnK2l6Gpk
         QxWMQo4NBxoPafO9MZ2bJNo9l92jDpw4s06sMj/AfLU5YWehLi3MQIi4EBRSwYkH1c1O
         +3MKWwuEgZpxXfsLEGGizRu8mw2wi/r3IW5VPsiFPiTFYhPrn5E66AZQkOw60sRZDz0y
         fLw5U4ycXf1RI2nMRAE/MPKlMkS6sbSop1lyLi9wGrXxZT4hIUc/BRmfseramnJSnGQy
         GfZ26JOdJCz3mW3UkNb58bilJWYUBOg/u+SxZurC/rT9bz80mOiK/Ad17CM2FttgSjuw
         yjkw==
X-Gm-Message-State: AOAM531VEzky4PMlmKkud4tGXW5Su493SfgcMBt46ZdbMQGkigeJ9fH5
        XtNBxTKSXI659pa24d+oxHwqe46+7hkhrItp2EFmtw==
X-Google-Smtp-Source: ABdhPJypEhgBGtdvE+CIOFMTHTIs6098Z3PwdIVQlW6tkGvx5BOconTGtFOIQ4CnrlAXgXA8D+jLajNgHO9BeuTBN1U=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr20890425ljg.332.1593786205575;
 Fri, 03 Jul 2020 07:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
In-Reply-To: <20200703063548.GM18446@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Jul 2020 07:23:14 -0700
Message-ID: <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> [...]
> > Interface options:
> > ------------------
> >
> > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> >
> > + simple
> > + can be extended to target specific type of memory (anon, file, kmem).
> > - most probably restricted to cgroup v2.
> >
> > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> >
> > + more general and applicable to other FSes (actually we are using
> > something similar for tmpfs).
> > + can be extended in future to just age the LRUs instead of reclaim or
> > some new use cases.
>
> Could you explain why memory.high as an interface to trigger pro-active
> memory reclaim is not sufficient. Also memory.low limit to protect
> latency sensitve workloads?

Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
but note that it can also introduce stalls in the application running
in that memcg. Let's suppose the memory.current of a memcg is 100MiB
and we want to reclaim 20MiB from it, we can set the memory.high to
80MiB but any allocation attempt from the application running in that
memcg can get stalled/throttled. I want the functionality of the
reclaim without potential stalls.

The memory.min is for protection against the global reclaim and is
unrelated to this discussion.
