Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F037B04AB
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjI0MuP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjI0MuO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 08:50:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2CE6;
        Wed, 27 Sep 2023 05:50:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9FBB21F88F;
        Wed, 27 Sep 2023 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695819011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sxBrZrM5hfLMtTNxf05EQ6NAFimmP4KyNoHJGo1kqN0=;
        b=ha5j+hIPJJ6lzadvIMzHzoUW9ZmC8K3jQOxjwaKXmEkAfeXbnpPmsbHta9tiU7K/w0b8Oh
        PnKfqQ+t4CgjfFCOS6eG4gPP4VDLeeGDugFGPJTHutWqYgqXmqmjXqkKfOpCLJ2cdIHLC8
        lnH9MOkZuIPUnbf7nXqL0+AxscBsCY8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C12D13479;
        Wed, 27 Sep 2023 12:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tPV9GwMlFGXVCwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 27 Sep 2023 12:50:11 +0000
Date:   Wed, 27 Sep 2023 14:50:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Frank van der Linden <fvdl@google.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <ZRQlAgDs5W/Lct4k@dhcp22.suse.cz>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
 <20230926221414.GD348484@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926221414.GD348484@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 26-09-23 18:14:14, Johannes Weiner wrote:
[...]
> The fact that memory consumed by hugetlb is currently not considered
> inside memcg (host memory accounting and control) is inconsistent. It
> has been quite confusing to our service owners and complicating things
> for our containers team.

I do understand how that is confusing and inconsistent as well. Hugetlb
is bringing throughout its existence I am afraid.

As noted in other reply though I am not sure hugeltb pool can be
reasonably incorporated with a sane semantic. Neither of the regular
allocation nor the hugetlb reservation/actual use can fallback to the
pool of the other. This makes them 2 different things each hitting their
own failure cases that require a dedicated handling.

Just from top of my head these are cases I do not see easy way out from:
	- hugetlb charge failure has two failure modes - pool empty
	  or memcg limit reached. The former is not recoverable and
	  should fail without any further intervention the latter might
	  benefit from reclaiming.
	- !hugetlb memory charge failure cannot consider any hugetlb
	  pages - they are implicit memory.min protection so it is
          impossible to manage reclaim protection without having a
          knowledge of the hugetlb use.
	- there is no way to control the hugetlb pool distribution by
	  memcg limits. How do we distinguish reservations from actual
	  use?
	- pre-allocated pool is consuming memory without any actual
	  owner until it is actually used and even that has two stages
	  (reserved and really used). This makes it really hard to
	  manage memory as whole when there is a considerable amount of
	  hugetlb memore preallocated.
I am pretty sure there are many more interesting cases. 
-- 
Michal Hocko
SUSE Labs
