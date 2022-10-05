Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760215F4D51
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJEBSu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 21:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJEBSb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 21:18:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99426E2F2
        for <cgroups@vger.kernel.org>; Tue,  4 Oct 2022 18:18:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f11so21107947wrm.6
        for <cgroups@vger.kernel.org>; Tue, 04 Oct 2022 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=wKEtZiXDz87n8b96HSwoP0cLh0C7jyCCww9QlL2G0QQ=;
        b=dQCLd9ZJb+EU+6pDOHcUcK51l9MyM2MRIxnvcivW7rzZ5K/tAQ2zNSu642hI3JM2tm
         oFje2cbkO1YyMErawMODJhBrkUVw6tG/bK8qdxXgZ7SmhzKzvLiVErxtfAuW1Jc4lWgf
         lY+3hMTG7uq1GJagqorBTId8QPuvQzyIo1781rgDMoGMklyq/NJLZ5N8tjHwF09fR+iv
         XVx8J/+8UXCN68Av4/LqigIqaeo5xgrXWfDeXXkJ30BY0j2R2EU9m+ZF0h2hrMxw0BDk
         hYnxwiZcA3Ff5WWqFl+hhLdf3IBJBIDEWjf6iE2nPNHgPKboiGl5uwL7mOm6nqkjZbRa
         lRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wKEtZiXDz87n8b96HSwoP0cLh0C7jyCCww9QlL2G0QQ=;
        b=ybwKSPoHI/198Kd7t9tyhkpPj22lXlC6NfAr0fHpiNfaJ6VBzssRdSY3lhwa2kyE+U
         5slBiJrsP8o5qULI+FxhFttIeBLmSe2HNifAdx3Fr9BlwV4Lf8Nc83nTgNi6uO9fmUbC
         TRyT4m+RrL65K1uNOnqZ73CSmU52K5GN2J1DBFWoTDpRxtZT2yGMDr23LZ34H4sB9x+g
         CD20R7ckS+MNJWVOr7IciwKOEHFMBkSS+e74GJ8f9lM2IpJ+4uhjO1DfBZWSkYzk8esq
         Qza6eIsVe+eABAzS9IupHm2LfUebk/qX1d1TmP9rSP37VHeHcbGB60Z2/AwGGBBn8xGf
         YbFw==
X-Gm-Message-State: ACrzQf21OJHbJFbQ+r7WxZYruP53WrT9xMivzoApOyKktddIyK/sZJlS
        YriQ9Dpn25vgW/z61GznsGqIURyHWJ1CSxCIkxyK9w==
X-Google-Smtp-Source: AMsMyM6OGP/s1SpALxv2OkDHEUxe9vopUQOnSoETGSJG4EwxZQ9suMXs+u4+HeaI9Wv2KX/5JpyDQRnOwvoXv5Iy6ck=
X-Received: by 2002:a5d:6741:0:b0:22e:2c5c:d611 with SMTP id
 l1-20020a5d6741000000b0022e2c5cd611mr11869611wrw.210.1664932696423; Tue, 04
 Oct 2022 18:18:16 -0700 (PDT)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Oct 2022 18:17:40 -0700
Message-ID: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
Subject: [RFC] memcg rstat flushing optimization
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey everyone,

Sorry for the long email :)

We have recently ran into a hard lockup on a machine with hundreds of
CPUs and thousands of memcgs during an rstat flush. There have also
been some discussions during LPC between myself, Michal Koutn=C3=BD, and
Shakeel about memcg rstat flushing optimization. This email is a
follow up on that, discussing possible ideas to optimize memcg rstat
flushing.

Currently, mem_cgroup_flush_stats() is the main interface to flush
memcg stats. It has some internal optimizations that can skip a flush
if there hasn't been significant updates in general. It always flushes
the entire memcg hierarchy, and always invokes flushing using
cgroup_rstat_flush_irqsafe(), which has interrupts disabled and does
not sleep. As you can imagine, with a sufficiently large number of
memcgs and cpus, a call to mem_cgroup_flush_stats() might be slow, or
in an extreme case like the one we ran into, cause a hard lockup
(despite periodically flushing every 4 seconds).

(a) A first step might be to introduce a non _irqsafe version of
mem_cgroup_flush_stats(), and only call the _irqsafe version in places
where we can't sleep. This will exclude some contexts from possibly
introducing a lockup, like the stats reading context and the periodic
flushing context.

(b) We can also stop flushing the entire memcg hierarchy in hopes that
flushing might happen incrementally over subtrees, but this was
introduced to reduce lock contention when there are multiple contexts
trying to flush memcgs stats concurrently, where only one of them will
flush and all the others return immediately (although there is some
inaccuracy here as we didn't actually wait for the flush to complete).
This will re-introduce the lock contention. Maybe we can mitigate this
in rstat code by having hierarchical locks instead of a global lock,
although I can imagine this can quickly get too complicated.

(c) One other thing we can do (similar to the recent blkcg patch
series [1]) is keep track of which stats have been updated. We
currently flush MEMCG_NR_STATS + MEMCG_NR_EVENTS (thanks to Shakeel) +
nodes * NR_VM_NODE_STAT_ITEMS. I didn't make the exact calculation but
I suspect this easily goes over a 100. Keeping track of updated stats
might be in the form of a percpu bitmask. It will introduce some
overhead to the update side and flush sides, but it can help us skip a
lot of up-to-date stats and cache misses. In a few sample machines I
have found that every (memcg, cpu) pair had less than 5 stats on
average that are actually updated.

(d) Instead of optimizing rstat flushing in general, we can just
mitigate the cases that can actually cause a lockup. After we do (a)
and separate call sites that actually need to disable interrupts, we
can introduce a new selective flush callback (e.g.
cgroup_rstat_flush_opts()). This callback can flush only the stats we
care about (bitmask?) and leave the rstat tree untouched (only
traverse the tree, don't pop the nodes). It might be less than optimal
in cases where the stats we choose to flush are the only ones that are
updated, and the cgroup just remains on the rstat tree for no reason.
However, it effectively addresses the cases that can cause a lockup by
only flushing a small subset of the stats.

(e) If we do both (c) and (d), we can go one step further. We can make
cgroup_rstat_flush_opts() return a boolean to indicate whether this
cgroup is completely flushed (what we asked to flush is all what was
updated). If true, we can remove the cgroup from the rstat tree.
However, to do this we will need to have separate rstat trees for each
subsystem or to keep track of which subsystems have updates for a
cgroup (so that if cgroup_rstat_flush_opts() returns true we know if
we can remove the cgroup from the tree or not).

Of course nothing is free. Most of the solutions above will either
introduce overhead somewhere, complexity, or both. We also don't have
a de facto benchmark that will tell us for sure if a change made
things generally better or not, as it will vastly differ depending on
the setup, the workloads, etc. Nothing will make everything better for
all use cases. This is just me kicking off a discussion to see what we
can/should do :)

[1] https://lore.kernel.org/lkml/20221004151748.293388-1-longman@redhat.com=
/
