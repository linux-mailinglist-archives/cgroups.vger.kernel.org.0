Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A8F5E7513
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 09:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIWHpN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 03:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIWHpM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 03:45:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4D7AC16;
        Fri, 23 Sep 2022 00:45:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFBD5218FA;
        Fri, 23 Sep 2022 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663919106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6f+HZS/DDCke26XP72uI0aj2polwGJmTgO/VcYRdyN4=;
        b=c11PTcBSOgXLHWwqQ+O14Z0b4UPZhBejONfGft2EFpfzFF/ME9Z8NK05ejOJBgvTDYj5qh
        unyh7cdLOmGV+gzZQb6orIAz8gj4mabsZIz7V5gsPMeEwc1+RCM407mt48ooiasXkayqko
        T6RRBjDTZ5L8s6G+OuJkFE3jsFYMhrw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F79A13A00;
        Fri, 23 Sep 2022 07:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /rgmJgJkLWP6dQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 23 Sep 2022 07:45:06 +0000
Date:   Fri, 23 Sep 2022 09:45:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v1] mm: oom: introduce cpuset oom
Message-ID: <Yy1kAnvowZh4ViP4@dhcp22.suse.cz>
References: <20220921064710.89663-1-ligang.bdlg@bytedance.com>
 <18621b07-256b-7da1-885a-c96dfc8244b6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18621b07-256b-7da1-885a-c96dfc8244b6@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 22-09-22 12:18:04, David Rientjes wrote:
> On Wed, 21 Sep 2022, Gang Li wrote:
> 
> > cpuset confine processes to processor and memory node subsets.
> > When a process in cpuset triggers oom, it may kill a completely
> > irrelevant process on another numa node, which will not release any
> > memory for this cpuset.
> > 
> > It seems that `CONSTRAINT_CPUSET` is not really doing much these
> > days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
> > killing by selecting victim from the cpuset which triggers oom.
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> 
> Hmm, is this the right approach?
> 
> If a cpuset results in a oom condition, is there a reason why we'd need to 
> find a process from within that cpuset to kill?  I think the idea is to 
> free memory on the oom set of nodes (cpuset.mems) and that can happen by 
> killing a process that is not a member of this cpuset.

I would argue that the current cpuset should be considered first because
chances are that it will already have the biggest memory consumption
from the constrained NUMA nodes. At least that would be the case when
cpusets are used to partition the system into exclusive NUMA domains.

Situation gets more complex with overlapping nodemasks in different
cpusets but I believe our existing semantic sucks already for those
usecases already because we just shoot a random process with an unknown
amount of memory allocated from the constrained nodemask.

This new semantic is not much worse. We could find a real oom victim
under a different cpuset but the current semantic could as well kill a
large memory consumer with a tiny footprint on the target node. With the
cpuset view the potential damage is more targeted in many cases.

> I understand the challenges of creating a NUMA aware oom killer to target 
> memory that is actually resident on an oom node, but this approach doesn't 
> seem right and could actually lead to pathological cases where a small 
> process trying to fork in an otherwise empty cpuset is repeatedly oom 
> killing when we'd actually prefer to kill a single large process.

Yeah, that is possible and something to consider. One way to go about
that is to make the selection from all cpusets with an overlap with the
requested nodemask (probably with a preference to more constrained
ones). In any case let's keep in mind that this is a mere heuristic. We
just need to kill some process, it is not really feasible to aim for the
best selection. We should just try to reduce the harm. Our exisiting
cpuset based OOM is effectivelly random without any clear relation to
cpusets so I would be open to experimenting in this area.
-- 
Michal Hocko
SUSE Labs
