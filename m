Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6386A52E64A
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiETH3u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiETH3s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 03:29:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3F14B67B;
        Fri, 20 May 2022 00:29:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BBC6921C7D;
        Fri, 20 May 2022 07:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653031785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FXv1dgsYTKaim0NgoOrpNGccWSrMRNDM5AkhS49DWs=;
        b=ICaJn67v2gF2PbSdCTsQnIvjMmEX8BOujrOgBrm1IrKejCLRT2BWNVjYuxOqMjlOka2Nqz
        7wtGCPO6Sxp1pEmkwsIMETuaaY6rFSzNG87SEhJVlW39uk3W3fStPgzu7TcgzJ3GUInpR/
        zvEq7wTmasM4aS/PdC3GaIQxnkBiT+4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3079C2C141;
        Fri, 20 May 2022 07:29:45 +0000 (UTC)
Date:   Fri, 20 May 2022 09:29:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
Message-ID: <YodDaFVeU33bu7yQ@dhcp22.suse.cz>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <YoYj4sLJfGke5IGT@dhcp22.suse.cz>
 <87zgjcg4xs.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgjcg4xs.fsf@vajain21.in.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 20-05-22 10:45:43, Vaibhav Jain wrote:
> 
> Thanks for looking into this patch Michal,
> 
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 19-05-22 04:08:15, Vaibhav Jain wrote:
> >> [1] Provides a way for user-space to trigger proactive reclaim by introducing
> >> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
> >> of pages scanned and reclaimed is still not directly available to the
> >> user-space.
> >> 
> >> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
> >> readable which returns the number of pages scanned / reclaimed during the
> >> reclaim process from 'struct vmpressure' associated with each memcg. This should
> >> let user-space asses how successful proactive reclaim triggered from memcg
> >> 'memory.reclaim' was ?
> >> 
> >> With the patch following command flow is expected:
> >> 
> >>  # echo "1M" > memory.reclaim
> >> 
> >>  # cat memory.reclaim
> >>    scanned 76
> >>    reclaimed 32
> >
> > Why cannot you use memory.stat? Sure it would require to iterate over
> > the reclaimed hierarchy but the information about scanned and reclaimed
> > pages as well as other potentially useful stats is there.
> 
> Agree that "memory.stat" is more suitable for scanned/reclaimed stats as
> it already is exposing bunch of other stats.
> 
> The discussion on this patch however seems to have split into two parts:
> 
> 1. Is it a good idea to expose nr_scanned/nr_reclaimed to users-space
> and if yes how ?
> 
> IMHO, I think it will be better to expose this info via 'memory.stat' as it
> can be useful insight into the reclaim efficiency  and vmpressure.

We already do that with some more metrics
pgrefill 9801926
pgscan 27329762
pgsteal 22715987
pgactivate 250691267
pgdeactivate 9521843
pglazyfree 0
pglazyfreed 0
 
> 2. Will it be useful to provide feedback to userspace when it writes to
> 'memory.reclaim' on how much memory has been reclaimed ?
> 
> IMHO, this will be a useful feeback to userspace to better adjust future
> proactive reclaim requests via 'memory.reclaim'

How precise this information should be? A very simplistic approach would
be
cp memory.stat stats.before
echo $WHATEVER > memory.reclaim
cp memory.stat stats.after

This will obviously contain also activity outside of the explicitly
triggered reclaim (racing background/direct reclaim) but isn't that what
actually matters? Are there any cases where the only metric you care
about is the triggered reclaim in isolation?

-- 
Michal Hocko
SUSE Labs
