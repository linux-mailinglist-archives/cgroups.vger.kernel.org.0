Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899D7B69A5
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjJCM7E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJCM7D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 08:59:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433C93;
        Tue,  3 Oct 2023 05:59:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3766721892;
        Tue,  3 Oct 2023 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696337939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYg5ibJBXkGWVzVR22ngBY7niQUGDtz5Ol63vTS001g=;
        b=fy0ZykLJX2w2QY0lOH5c4Q8/XyQN7db0uLKnnd1wdWWbz+3/0xJXFEPpzAd5GK+nFTPqFC
        pAR5aEAkOEobNFSgo7D66JNwPHP+vG1Dir3iiSe433DMWGdYuDn/2NGfoIuKh2V4VL5rnj
        fuCnJ/PaeS6nHDtq8LLxdMuFJp+sNhs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 252B5132D4;
        Tue,  3 Oct 2023 12:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0okxCBMQHGXKKgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Oct 2023 12:58:59 +0000
Date:   Tue, 3 Oct 2023 14:58:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <ZRwQEv62Ex4+H2CZ@dhcp22.suse.cz>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003001828.2554080-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-10-23 17:18:27, Nhat Pham wrote:
> Currently, hugetlb memory usage is not acounted for in the memory
> controller, which could lead to memory overprotection for cgroups with
> hugetlb-backed memory. This has been observed in our production system.
> 
> For instance, here is one of our usecases: suppose there are two 32G
> containers. The machine is booted with hugetlb_cma=6G, and each
> container may or may not use up to 3 gigantic page, depending on the
> workload within it. The rest is anon, cache, slab, etc. We can set the
> hugetlb cgroup limit of each cgroup to 3G to enforce hugetlb fairness.
> But it is very difficult to configure memory.max to keep overall
> consumption, including anon, cache, slab etc. fair.
> 
> What we have had to resort to is to constantly poll hugetlb usage and
> readjust memory.max. Similar procedure is done to other memory limits
> (memory.low for e.g). However, this is rather cumbersome and buggy.

Could you expand some more on how this _helps_ memory.low? The
hugetlb memory is not reclaimable so whatever portion of its memcg
consumption will be "protected from the reclaim". Consider this
	      parent
	/		\
       A		 B
       low=50%		 low=0
       current=40%	 current=60%

We have an external memory pressure and the reclaim should prefer B as A
is under its low limit, correct? But now consider that the predominant
consumption of B is hugetlb which would mean the memory reclaim cannot
do much for B and so the A's protection might be breached.

As an admin (or a tool) you need to know about hugetlb as a potential
contributor to this behavior (sure mlocked memory would behave the same
but mlock rarely consumes huge amount of memory in my experience).
Without the accounting there might not be any external pressure in the
first place. 

All that being said, I do not see how adding hugetlb into accounting
makes low, min limits management any easier.

-- 
Michal Hocko
SUSE Labs
