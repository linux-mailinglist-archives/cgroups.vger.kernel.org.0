Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD833CA39
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 01:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhCOX7f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 19:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhCOX7D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 19:59:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00FC06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 16:59:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z8so18362154ljm.12
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiWLaJ6JfRY7D2fjAEheSS/CI6En0Tfjr7NfpaLRaUg=;
        b=el1U4yM7KpXL5g8A1suug3kzC4jqMxihYzAe6idzQvWFnWS91NbuSI/u+c6mo6cRnV
         SPei+MME4J69H5g9v4345POnj6DndSypgXQdfUHFQYb7eJNzCDNSvw/2JxkV/MfzWtOC
         kf4IBHDbVcqItf9trvNPu1tywIQIXWuoKwXmyEvHMidR1r5dkG0r+DYt+noifqymr/al
         NOpBuSOhXUfkxXzujUrmtj6SfPf704YxzLSaRzU5iJInw3d/wh8k5iOLjeOO/M+5KmEi
         LJh2OEaMvZRv9JdvA6or3g3XBQ1bnr8Uu6YnH5VpChJ/5QuJgx7O/g/j1G2ONUuw4djx
         N5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiWLaJ6JfRY7D2fjAEheSS/CI6En0Tfjr7NfpaLRaUg=;
        b=U2/SOnrt/Do12b/5SkpIU95tzX/rfjiHktAPJ1n3IFct0CsFa8fEWIFMTDywv4mAhG
         8pJ6yJLHooRw2iE6JOc8QEibsniNem8BWHFpExPXx7RvwE9U67O74ph6ZHzX+NbDehae
         o18nKSCKLtwLkTkLwpe0yRhfiK5/mh8g/HtVUfmhL4jCyHHW/srGJtEcADvaI66nd+U5
         qXI2yHEgWrB7WLFet3ANA5wWkLPNes/khuT5oFi4I3loh3K3lUoW5NGigjCgJM1aTgMm
         9ezdUy4SARgFi4eR8wpNnI+YajtOgz7hSqlSw+JKNfQUPBs869CynoSOt3ixQc58dFAS
         +8RA==
X-Gm-Message-State: AOAM532vlu6ipu/L77xY/P4Zx4EKvyGjoM0vorTbdsee26tMWADZpLkC
        pOripfswYWQqUSmvPL/c38Tix/7nSwpQRmWFv5snnA==
X-Google-Smtp-Source: ABdhPJzCFWkbAbfU5FZc7r0w/lfxsElxEMPSYg1g37oXUD304ZYfPSKaUF3yhqQGKYWlRE3P3zrkIX0Ht1rL3aPfSaI=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr922776ljc.0.1615852741307;
 Mon, 15 Mar 2021 16:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210315234100.64307-1-hannes@cmpxchg.org>
In-Reply-To: <20210315234100.64307-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Mar 2021 16:58:49 -0700
Message-ID: <CALvZod7VzxYc4Kz0WPHWt74YMopi9XrCu4CKtEGTRKxXPSP=8w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: switch to rstat fix
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 4:41 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Fix a sleep in atomic section problem: wb_writeback() takes a spinlock
> and calls wb_over_bg_thresh() -> mem_cgroup_wb_stats, but the regular
> rstat flushing function called from in there does lockbreaking and may
> sleep. Switch to the atomic variant, cgroup_rstat_irqsafe().
>
> To be consistent with other memcg flush calls, but without adding
> another memcg wrapper, inline and drop memcg_flush_vmstats() instead.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
