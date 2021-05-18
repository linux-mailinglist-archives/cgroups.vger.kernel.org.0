Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6341387F41
	for <lists+cgroups@lfdr.de>; Tue, 18 May 2021 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbhERSJj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 May 2021 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbhERSJi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 May 2021 14:09:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1EC061760
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 11:08:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e2so6313145ljk.4
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E7Z7TDc06/eMEz9G837ZKMVJn1ufiTnEi/jaPd1NvY=;
        b=wOsUI1tgO5GyceYANUg7bhK+kgPr8bEKnGXv/CrfjPyGFSLphMKWdlZbBEhK7JawBf
         VD4c2QD/2KMR0E1qrzCd8QMtksaO27A+uv8JW3OhfX3sgIO7YNQSvG7SBMKQu5+L4oyT
         e+jYaEtihbIO72lE8SQhtw1Kqu81Hhb60lIgHixmIpFlXHvyFghJ4FSyT2qOSKhkPN2B
         Ru9nHknSVzUt8GKlVm1bXVCs9/yj6iUBDkUShcRkSXiSUKjjyG1Ji+9RF32Qqd0FkesP
         mxQH2WbtbiAguRwQ3nYFu4iEy7nxrOU7RLTANf7M9dgJbX9r+B2cdYFpSwE9QrIPOOje
         EuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E7Z7TDc06/eMEz9G837ZKMVJn1ufiTnEi/jaPd1NvY=;
        b=T40bCXrToWgx1biH3SnHIuhqBQ9jpyUR9vGDNsakXggCRj5E8tqWnYcUCkjD2ymNvs
         /W5ukxTbZNe0yUQsZj2BwWf+TzZqZYrPl6UNfEC+y7NmMurAHFZAxCaJd1/dfZV6m9x2
         RVJgOoJ6GS0e5MH231cXbowCGYRbvIhZtq4JnNYHlq2hHe7xq3Ot50TSNZVhQS8HuCnu
         lKliwAQlToFNqpPmEUXOHtgy6t9v+Q3Rsw3fwMACDZ5uxuluc0OPKk1JO9h3dWMoyTmT
         0G3sCTdeFYx344x8E0Kn4kH9LeEhV79xlfD684WOUA0nSpK12a4ZHTLfNDPxcC7Dw2dT
         WOTQ==
X-Gm-Message-State: AOAM531ku+8SOd64tnREkILJkzihvDOB4aOso2lXID2nT+CtPoWbpa2/
        dVL2Rw709qUG2Gs3n3aN+hTy6eNUJNGjRZNFr8WG+A==
X-Google-Smtp-Source: ABdhPJyLLwcAeGX5sDd57fzmMT0ecsaNhxJsRNedKf9DMhNB1jsVArj8Os8vAkYsZdR+La9q6npu0K2+JNJ4YUxhMWY=
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr5225520ljr.0.1621361298314;
 Tue, 18 May 2021 11:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210518020200.1790058-1-surenb@google.com>
In-Reply-To: <20210518020200.1790058-1-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 18 May 2021 11:08:06 -0700
Message-ID: <CALvZod7VBQMyftOffc8maCKtDwybLWGQNkk+R0M2SJPy2BuEjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bristot@redhat.com,
        paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        viresh.kumar@linaro.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 17, 2021 at 7:02 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> PSI accounts stalls for each cgroup separately and aggregates it at each
> level of the hierarchy. This causes additional overhead with psi_avgs_work
> being called for each cgroup in the hierarchy. psi_avgs_work has been
> highly optimized, however on systems with large number of cgroups the
> overhead becomes noticeable.
> Systems which use PSI only at the system level could avoid this overhead
> if PSI can be configured to skip per-cgroup stall accounting.
> Add "cgroup_disable=pressure" kernel command-line option to allow
> requesting system-wide only pressure stall accounting. When set, it
> keeps system-wide accounting under /proc/pressure/ but skips accounting
> for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I am assuming that this is for Android and at the moment Android is
only interested in system level pressure. I am wondering if there is
any plan for Android to have cgroup hierarchies with explicit limits
in future?

If yes, then I think we should follow up (this patch is fine
independently) with making this feature more general by explicitly
enabling psi for each cgroup level similar to how we enable
controllers through cgroup.subtree_control.

Something like:

$ echo "+psi" > cgroup.subtree_control

This definitely would be helpful for server use cases where jobs do
sub-containers but might not be interested in psi but the admin is
interested in the top level job's psi.
