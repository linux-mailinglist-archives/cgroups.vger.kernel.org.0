Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720F16F06F5
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbjD0OGz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0OGy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 10:06:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF8AF;
        Thu, 27 Apr 2023 07:06:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61FA91FE22;
        Thu, 27 Apr 2023 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682604411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSSPWlR+fmRaVisUOZECUtbamoubJx2aUQz5oMIT4bY=;
        b=hKsbcFXhcnHul4v4HNQG3MzF3hq7i1IWsZlGNpji0BcJbTTrTel8B1It9NdUZ03HwIfZuy
        0abcxObKmsKVLCZiUHzjViteSgmqRQ50fjmCojQynd3A1ABQ4xVmJ+CiM4H2lEhizMKgfp
        IU2sZ/WkV5Q9E3dTGvzCyHzglVpEcck=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 457D6138F9;
        Thu, 27 Apr 2023 14:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iBiuDnuBSmRyDgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Apr 2023 14:06:51 +0000
Date:   Thu, 27 Apr 2023 16:06:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
Message-ID: <ZEqBesAJFfLZI65/@dhcp22.suse.cz>
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com>
 <ZElC127xlU2NtlqF@dhcp22.suse.cz>
 <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 27-04-23 02:21:30, Yosry Ahmed wrote:
> On Wed, Apr 26, 2023 at 8:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 26-04-23 13:39:19, Yosry Ahmed wrote:
> > > Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> > > OOM") made sure we dump all the stats in memory.stat during a cgroup
> > > OOM, but it also introduced a slight behavioral change. The code used to
> > > print the non-hierarchical v1 cgroup stats for the entire cgroup
> > > subtree, not it only prints the v2 cgroup stats for the cgroup under
> > > OOM.
> > >
> > > Although v2 stats are a superset of v1 stats, some of them have
> > > different naming. We also lost the non-hierarchical stats for the cgroup
> > > under OOM in v1.
> >
> > Why is that a problem worth solving? It would be also nice to add an
> > example of the oom report before and after the patch.
> > --
> > Michal Hocko
> > SUSE Labs
> 
> Thanks for taking a look!
> 
> The problem is that when upgrading to a kernel that contains
> c8713d0b2312 on cgroup v1, the OOM logs suddenly change. The stats
> names become different, a couple of stats are gone, and the
> non-hierarchical stats disappear.
> 
> The non-hierarchical stats are important to identify if a memcg OOM'd
> because of the memory consumption of its own processes or its
> descendants. In the example below, I created a parent memcg "a", and a
> child memcg "b". A process in "a" itself ("tail" in this case) is
> hogging memory and causing an OOM, not the processes in the child "b"
> (the "sleep" processes). With non-hierarchical stats, it's clear that
> this is the case.

Is this difference really important from the OOM POV. There is no group
oom semantic in v1 and so it always boils down to a specific process
that gets selected. Which memcg it is sitting in shouldn't matter all
that much. Or does it really matter?

> Also, it is generally nice to keep things consistent as much as
> possible. The sudden change of the OOM log with the kernel upgrade is
> confusing, especially that the memcg stats in the OOM logs in cgroup
> v1 now look different from the stats in memory.stat.

Generally speaking oom report is not carved into stone. While we
shouldn't make changes just nilly willy it might change for
implementation specific reasons.

In this particular case I would agree that the new output is more
confusing than helpful. Just look at 
> [   88.339505] pgscan 0
> [   88.339505] pgsteal 0
> [   88.339506] pgscan_kswapd 0
> [   88.339506] pgscan_direct 0
> [   88.339507] pgscan_khugepaged 0
> [   88.339507] pgsteal_kswapd 0
> [   88.339508] pgsteal_direct 0
> [   88.339508] pgsteal_khugepaged 0

These stats are actively misleading because it would suggest there was
no memory reclaim done before oom was hit and that would imply a
potentially premature OOM killer invocation (thus a bug). There are
likely other stats which are not tracked in v1 yet they are reported
that might add to the confusion. I believe this would be a sound
justification to get back to the original reporting.
-- 
Michal Hocko
SUSE Labs
