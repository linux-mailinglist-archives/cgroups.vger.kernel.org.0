Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19D8311443
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhBEWCj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhBEO4V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 09:56:21 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927FC061225
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 08:34:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e15so5375334qte.9
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 08:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RW0ONyxKXYjlsRuX7eO/UdLt7OqwnBfWk+dSDdSDYyw=;
        b=fDCx8PML3wpb7Gv9Qhxf/Lmgt8t9paY9PlqQPeev9GAzZIOy9HRlwnhk8Gj2bTe2yf
         0uSHjMJJYfZDMDMboGVMVL98lxLZYKECaPT1YM59+/uoVp+j2yeayauMqi3OZM4d1tEn
         YN/ecY3LDoZFlB6rqTT5ynUD98p8d4ARLnea2R77u3ZWZqfLt+1HcCkt9MhNrCijWhUz
         f4DiXHO0gL1TK9dgWhCoDy3l5Q2bJk2OkxHSBoWy+wJ4rScOFcDJlLvSG/M9tYuP2TdN
         mWVZjPe8sqxDRGKXq+ydF2Mdvz57XMe1jNoelLFF+OdOSt6KcspYQ/F2PQw35OvoRNYe
         +pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RW0ONyxKXYjlsRuX7eO/UdLt7OqwnBfWk+dSDdSDYyw=;
        b=oVDcYr9zwB49fShpz5KDkzgTXneThICCm40YBX7ZB9gDvD08N1inu50nIu0nLSFazU
         5BXi+5kuV2ePl0KUDYhNKfqE94fqRG1N7sVhiBUX7zIynqORsqy5gtKod2FArtAnidfI
         NuAQtmnl04d2SkELTO0FrBAlLptSilpEfouctY/MG1p8MLo9+lDjiaSB+6afHDv+Ff7Q
         O4qXPm6+na5RpSaiAClK17d1W1FKsxb17nkCRpgkH0gEvYmj/Dv4BXJnlTdR/Fqjhoan
         yup5vGY7Tm0cIjJtF6JmOOn8OXEtp6xkrs/UuXJOxaXkJx4QnDRKpvBfKSJpsvS85iEO
         W82A==
X-Gm-Message-State: AOAM530hpVIR27gZ2rn30NLygrTYxxrNHmCH5q9g1FiwJeDQxbDyBu8B
        RDIY1A1Q9o/GkIFz3TTIFNpNEA==
X-Google-Smtp-Source: ABdhPJwnNJM/q0Eo2MlbfQjZiTMmgkK3+RzNgscQCLRFoS1nQRPHzBz9vh5zkKqKWZB2ML9LPR2nMQ==
X-Received: by 2002:aed:20a8:: with SMTP id 37mr5172292qtb.362.1612542861989;
        Fri, 05 Feb 2021 08:34:21 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z5sm9626394qkc.61.2021.02.05.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:34:20 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:34:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YB1zi/bZdeL2j59I@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <YB1esMKg3QhBDFG2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB1esMKg3QhBDFG2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 05, 2021 at 04:05:20PM +0100, Michal Hocko wrote:
> On Tue 02-02-21 13:47:45, Johannes Weiner wrote:
> > Replace the memory controller's custom hierarchical stats code with
> > the generic rstat infrastructure provided by the cgroup core.
> > 
> > The current implementation does batched upward propagation from the
> > write side (i.e. as stats change). The per-cpu batches introduce an
> > error, which is multiplied by the number of subgroups in a tree. In
> > systems with many CPUs and sizable cgroup trees, the error can be
> > large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> > subgroups results in an error of up to 128M per stat item). This can
> > entirely swallow allocation bursts inside a workload that the user is
> > expecting to see reflected in the statistics.
> > 
> > In the past, we've done read-side aggregation, where a memory.stat
> > read would have to walk the entire subtree and add up per-cpu
> > counts. This became problematic with lazily-freed cgroups: we could
> > have large subtrees where most cgroups were entirely idle. Hence the
> > switch to change-driven upward propagation. Unfortunately, it needed
> > to trade accuracy for speed due to the write side being so hot.
> > 
> > Rstat combines the best of both worlds: from the write side, it
> > cheaply maintains a queue of cgroups that have pending changes, so
> > that the read side can do selective tree aggregation. This way the
> > reported stats will always be precise and recent as can be, while the
> > aggregation can skip over potentially large numbers of idle cgroups.
> > 
> > This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> > NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> > aggregation. It removes 3 words from the per-cpu data. It eliminates
> > memcg_exact_page_state(), since memcg_page_state() is now exact.
> 
> The above confused me a bit. I can see the pcp data size increased by
> adding _prev.  The resulting memory footprint should be increased by
> sizeof(long) * (MEMCG_NR_STAT + NR_VM_EVENT_ITEMS) * (CPUS + 1)
> which is roughly 1kB per CPU per memcg unless I have made any
> mistake. This is a quite a lot and it should be mentioned in the
> changelog.

Not quite, you missed a hunk further below in the patch.

Yes, the _prev arrays are added to the percpu struct. HOWEVER, we used
to have TWO percpu structs in a memcg: one for local data, one for
hierarchical data. In the rstat format, one is enough to capture both:

-       /* Legacy local VM stats and events */
-       struct memcg_vmstats_percpu __percpu *vmstats_local;
-
-       /* Subtree VM stats and events (batched updates) */
        struct memcg_vmstats_percpu __percpu *vmstats_percpu;

This eliminates dead duplicates of the nr_page_events and
targets[MEM_CGROUP_NTARGETS(2)] we used to carry, which means we have
a net reduction of 3 longs in the percpu data with this series.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Although the memory overhead is quite large and it scales both with
> memcg count and CPUs so it can grow quite a bit I do not think this is
> prohibitive. Although it would be really nice if this could be optimized
> in the future.
> 
> All that being said, the code looks more manageable now.
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks
