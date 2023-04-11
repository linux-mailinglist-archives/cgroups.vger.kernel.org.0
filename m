Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824AC6DDE13
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDKOgc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDKOgb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 10:36:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923811FF3;
        Tue, 11 Apr 2023 07:36:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 473641FD88;
        Tue, 11 Apr 2023 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681223787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U29cCnOHbPWuYYBzDboY6Km3Yy5eqaduHl0Wu231j74=;
        b=edjpGMrZ7N5YaS+Bhq84eaTAsFUJQfQ5qUZDGHxznT+HT1UWjhwdo+L4abwkywXdptySD5
        5qp7+MeH72opCbELqEE75FiRgE2ZoDDMZrxDENYrm6SyMRarDUSbtF48i7Jo82DPD+J4MW
        CncLnF+JzdMoTJt+laveADpsUJQZfok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2928A13638;
        Tue, 11 Apr 2023 14:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ltGoB2twNWSeXgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Apr 2023 14:36:27 +0000
Date:   Tue, 11 Apr 2023 16:36:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: oom: introduce cpuset oom
Message-ID: <ZDVwaqzOBNTpuR1w@dhcp22.suse.cz>
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-04-23 14:58:15, Gang Li wrote:
> Cpusets constrain the CPU and Memory placement of tasks.
> `CONSTRAINT_CPUSET` type in oom  has existed for a long time, but
> has never been utilized.
> 
> When a process in cpuset which constrain memory placement triggers
> oom, it may kill a completely irrelevant process on other numa nodes,
> which will not release any memory for this cpuset.
> 
> We can easily achieve node aware oom by using `CONSTRAINT_CPUSET` and
> selecting victim from cpusets with the same mems_allowed as the
> current one.

I believe it still wouldn't hurt to be more specific here.
CONSTRAINT_CPUSET is rather obscure. Looking at this just makes my head
spin.
        /* Check this allocation failure is caused by cpuset's wall function */
        for_each_zone_zonelist_nodemask(zone, z, oc->zonelist, 
                        highest_zoneidx, oc->nodemask)
                if (!cpuset_zone_allowed(zone, oc->gfp_mask))
                        cpuset_limited = true;

Does this even work properly and why? prepare_alloc_pages sets
oc->nodemask to current->mems_allowed but the above gives us
cpuset_limited only if there is at least one zone/node that is not
oc->nodemask compatible. So it seems like this wouldn't ever get set
unless oc->nodemask got reset somewhere. This is a maze indeed. Is there
any reason why we cannot rely on __GFP_HARWALL here? Or should we
instead rely on the fact the nodemask should be same as
current->mems_allowed?

I do realize that this is not directly related to your patch but
considering this has been mostly doing nothing maybe we want to document
it better or even rework it at this occasion.

> Example:
> 
> Create two processes named mem_on_node0 and mem_on_node1 constrained
> by cpusets respectively. These two processes alloc memory on their
> own node. Now node0 has run out of memory, OOM will be invokled by
> mem_on_node0.

Don't you have an actual real life example with a properly partitioned
system which clearly misbehaves and this patch addresses that?
-- 
Michal Hocko
SUSE Labs
