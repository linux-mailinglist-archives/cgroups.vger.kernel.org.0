Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A885930F4CD
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhBDOUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 09:20:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236639AbhBDOUI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Feb 2021 09:20:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612448358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNjcnDnZXUPYHHuK46oDIL84tyY2kS2LkC6T9yyAPCU=;
        b=FpVLR3O5yTTiyeAwG18zs+GsUc9KTxfWONmuisoWJ5R5Qc+/oEzDmE8bSbH18CXTe6sjcR
        iIb3W1B+PoapI11EyyaUQ6YIBmeGMGWmyFSi1EW3GHcp6M4GA6Qx4SolDI790FtL20ziY2
        ZigN/iwMkJ+cKFNvY3YBp5715do75N0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A88CEB176;
        Thu,  4 Feb 2021 14:19:18 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:19:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YBwCZYWsQOFAGUar@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-7-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 02-02-21 13:47:45, Johannes Weiner wrote:
> Replace the memory controller's custom hierarchical stats code with
> the generic rstat infrastructure provided by the cgroup core.
> 
> The current implementation does batched upward propagation from the
> write side (i.e. as stats change). The per-cpu batches introduce an
> error, which is multiplied by the number of subgroups in a tree. In
> systems with many CPUs and sizable cgroup trees, the error can be
> large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> subgroups results in an error of up to 128M per stat item). This can
> entirely swallow allocation bursts inside a workload that the user is
> expecting to see reflected in the statistics.
> 
> In the past, we've done read-side aggregation, where a memory.stat
> read would have to walk the entire subtree and add up per-cpu
> counts. This became problematic with lazily-freed cgroups: we could
> have large subtrees where most cgroups were entirely idle. Hence the
> switch to change-driven upward propagation. Unfortunately, it needed
> to trade accuracy for speed due to the write side being so hot.
> 
> Rstat combines the best of both worlds: from the write side, it
> cheaply maintains a queue of cgroups that have pending changes, so
> that the read side can do selective tree aggregation. This way the
> reported stats will always be precise and recent as can be, while the
> aggregation can skip over potentially large numbers of idle cgroups.
> 
> This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> aggregation. It removes 3 words from the per-cpu data. It eliminates
> memcg_exact_page_state(), since memcg_page_state() is now exact.

I am still digesting details and need to look deeper into how rstat
works but removing our own stats is definitely a good plan. Especially
when there are existing limitations and problems that would need fixing.

Just to check that my high level understanding is correct. The
transition is effectivelly removing a need to manually sync counters up
the hierarchy and partially outsources that decision to rstat core. The
controller is responsible just to tell the core how that syncing is done
(e.g. which specific counters etc). Excplicit flushes are needed when
you want an exact value (e.g. when values are presented to the
userspace). I do not see any flushes to be done by the core pro-actively
except for clean up on a release.

Is the above correct understanding?
-- 
Michal Hocko
SUSE Labs
