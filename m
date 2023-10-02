Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF037B5670
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbjJBPIl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjJBPIk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 11:08:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361BB7;
        Mon,  2 Oct 2023 08:08:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5D711F37C;
        Mon,  2 Oct 2023 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696259315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7RkAWT8P/BhIWfEv3U2TDwSRWzSpgBkJQFDvWrSmgw=;
        b=JJVJWppzCEiSTgO8xYZqOIry+2FEtIwD/wtmru7N7p86BngBpEM4UNLSd2XD8uja/GoAQo
        yr5rxXJHdI1IhcPf7hgaiOJZ/w0TaIUZPWZr70+mbioFU9knq8ry97Pto0rc9TzlnA9Ygg
        xKoTWsicQ5lfu5yVRf2EqvUypKPbOQ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B191A13434;
        Mon,  2 Oct 2023 15:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n7E1KPPcGmXGeQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 02 Oct 2023 15:08:35 +0000
Date:   Mon, 2 Oct 2023 17:08:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <ZRrc8hv4t740MZar@dhcp22.suse.cz>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
 <20231002145026.GB4414@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002145026.GB4414@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-10-23 10:50:26, Johannes Weiner wrote:
> On Mon, Oct 02, 2023 at 03:43:19PM +0200, Michal Hocko wrote:
> > On Wed 27-09-23 17:57:22, Nhat Pham wrote:
[...]
> > - memcg limit reclaim doesn't assist hugetlb pages allocation when
> >   hugetlb overcommit is configured (i.e. pages are not consumed from the
> >   pool) which means that the page allocation might disrupt workloads
> >   from other memcgs.
> > - failure to charge a hugetlb page results in SIGBUS rather
> >   than memcg oom killer. That could be the case even if the
> >   hugetlb pool still has pages available and there is
> >   reclaimable memory in the memcg.
> 
> Are these actually true? AFAICS, regardless of whether the page comes
> from the pool or the buddy allocator, the memcg code will go through
> the regular charge path, attempt reclaim, and OOM if that fails.

OK, I should have been more explicit. Let me expand. Charges are
accounted only _after_ the actual allocation is done. So the actual
allocation is not constrained by the memcg context. It might reclaim
from the memcg at that time but the disruption could have already
happened. Not really any different from regular memory allocation
attempt but much more visible with GB pages and one could reasonably
expect that memcg should stop such a GB allocation if the local reclaim
would be hopeless to free up enough from its own consumption.

Makes more sense?

With the later point I meant to say that the memcg OOM killer will not
communicate the hugetlb request failure so the usual SIGBUS will be
returned to the userspace. I can imagine a SIGBUS handler could check
hugetlb availability to retry or something similar.
-- 
Michal Hocko
SUSE Labs
