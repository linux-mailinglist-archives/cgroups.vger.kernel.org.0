Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4994F2315
	for <lists+cgroups@lfdr.de>; Tue,  5 Apr 2022 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiDEG3B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 02:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDEG27 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 02:28:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FC74BFC3
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 23:27:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 77CCD210DE;
        Tue,  5 Apr 2022 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649140020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yh3Ex3Th+gF9Cqk/K++VhrpMY2seww3cQSgR3bJT/Hg=;
        b=Oi2QIer3acnB2qh/3gKgxeQvPSaRTPBE8h7WnJQCGkxdTcMy+Db8yjuRi5DAxorBEcAfCL
        hKdfWigOSnr9C7qSjjWpf9thxyS/fKtFkzS/LcxhoxwawIFl/VD3vOsV/1tqEkFfvUSjBQ
        BQNyPpSpioYZBU9cYrbtoMLG1w+zYrE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 43B1BA3B89;
        Tue,  5 Apr 2022 06:27:00 +0000 (UTC)
Date:   Tue, 5 Apr 2022 08:26:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcg: non-hierarchical mode is deprecated
Message-ID: <YkvhMx2EVVisfjRG@dhcp22.suse.cz>
References: <20220403020833.26164-1-richard.weiyang@gmail.com>
 <Ykq6Gbt5MX9GCiKM@dhcp22.suse.cz>
 <20220405022218.53idmvm2ha2tzmy2@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405022218.53idmvm2ha2tzmy2@master>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 05-04-22 02:22:18, Wei Yang wrote:
> On Mon, Apr 04, 2022 at 11:27:53AM +0200, Michal Hocko wrote:
> >On Sun 03-04-22 02:08:33, Wei Yang wrote:
> >> After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
> >> mode"), we won't have a NULL parent except root_mem_cgroup. And this
> >> case is handled when (memcg == root).
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> CC: Roman Gushchin <roman.gushchin@linux.dev>
> >> CC: Johannes Weiner <hannes@cmpxchg.org>
> >
> >Acked-by: Michal Hocko <mhocko@suse.com>
> >Thanks!
> >
> 
> Thanks for the ack. When reading the code, I found one redundant check in
> shrink_node_memcgs().
> 
>   shrink_node_memcgs
>     mem_cgroup_below_min
>       mem_cgroup_supports_protection
>     mem_cgroup_below_low
>       mem_cgroup_supports_protection
> 
> I am not sure it worthwhile to take it out.
> 
>   shrink_node_memcgs
>     mem_cgroup_supports_protection
>       mem_cgroup_below_min
>       mem_cgroup_below_low
> 
> Look forward your opinion.

I guess you refer to mem_cgroup_is_root check in mem_cgroup_supports_protection,
right?

You are right that the check is not really required because e{min,low}
should always stay at 0 for the root memcg AFAICS. On the other hand the
check is not in any hot path and it really adds clarity here because
protection is not really supported on the root memcg. So I am not this
is an overall win.
-- 
Michal Hocko
SUSE Labs
