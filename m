Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8444555C1ED
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiF0Mbi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 08:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiF0Mba (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 08:31:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79922DED1;
        Mon, 27 Jun 2022 05:31:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 23B0F21CE4;
        Mon, 27 Jun 2022 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656333088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2x18KoFRy5eal2D3ylc2+U1rybp7813ga/wOUoNe6s=;
        b=MN+FbeFBztRg1vQn/aZS6WgzpJcvWE6GlhrAy1Bn2uYz6Fgk3nG1G2IBxSamszzE041LHN
        FYiV/4Oov7dyHxK7Ap2HTWMY4KowzOrjMf2zZGO5NgGZfnmfaD9ie3tBC7hiO/8eBkBjto
        EEejyW10KiaUFmPLEkSEZ9i8fEwxLpw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 87FAA2C141;
        Mon, 27 Jun 2022 12:31:27 +0000 (UTC)
Date:   Mon, 27 Jun 2022 14:31:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
Message-ID: <YrmjH2FZF7iNn8da@dhcp22.suse.cz>
References: <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
 <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz>
 <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz>
 <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz>
 <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
 <Yrl2T632Vfv8QGPn@dhcp22.suse.cz>
 <CAJD7tkZzwzHq7Q7KKUdVSdO4LWTPkrGprp0Q-ze_SWhUd_mTMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZzwzHq7Q7KKUdVSdO4LWTPkrGprp0Q-ze_SWhUd_mTMw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 27-06-22 02:39:49, Yosry Ahmed wrote:
[...]
> (a) Do not count vmpressure for mem_cgroup_resize_max() and
> mem_cgroup_force_empty() in v1.

yes, unless you have a very good reason to change that. E.g. this has
been buggy and we have finally understood that. But I do not see any
indications so far.

> (b) Do not count vmpressure (consequently,
> mem_cgroup_under_socket_pressure()) in v2 where psi is not counted
> (writing to memory.max, memory.high, and memory.reclaim).

I can see clear arguments for memory.reclaim opt out for vmpressure
because we have established that this is not a measure to express a
memory pressure on the cgroup.

Max/High are less clear to me, TBH. I do understand reasoning for PSI
exclusion because considering the calling process to be stalled and
non-productive is misleading. It just does its work so in a way it is
a productive time in the end. For the vmpressure, which measures how
hard/easy it is to reclaim memory why this should special for this
particular reclaim?

Again, an explanation of the effect on the socket pressure could give a
better picture. Say that I somebody reduces the limit (hard/high) and it
takes quite some effort to shrink the consumption down. Should the
networking layer react to that in any way or should it wait for the
active allocation during that process to find that out?
-- 
Michal Hocko
SUSE Labs
