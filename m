Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF3869E311
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 16:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjBUPH0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 10:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBUPHZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 10:07:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D972118;
        Tue, 21 Feb 2023 07:07:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0CBF34BC2;
        Tue, 21 Feb 2023 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676992042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuoQfbt2KTtRM14/DGy4Xw84gjAGRL7EtHDJyvKijkc=;
        b=iEs5G9H0uW0SncqaXgoZdfWT5Nfcp7Jr/y+R0YLekUASyEbj+x2ZJWa0x7T3+cTqzqm68a
        vjZkll0GSyPg7eRu6K3kjKzzR7q1W6ekeDrWrhAAWXYJoYEhC4aBeSt271xqMNzCFxvUTS
        tTs1+DB01YF+v0vtUlJ/Xhl9CgrQXNc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B193713223;
        Tue, 21 Feb 2023 15:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 34+2KCre9GM7aAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 21 Feb 2023 15:07:22 +0000
Date:   Tue, 21 Feb 2023 16:07:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Chae <matthew.chae@axis.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@axis.com,
        christopher.wong@axis.com, Muchun Song <muchun.song@linux.dev>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Message-ID: <Y/TeKkhQtV7Bck8P@dhcp22.suse.cz>
References: <20230221143421.10385-1-matthew.chae@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221143421.10385-1-matthew.chae@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-02-23 15:34:20, Matthew Chae wrote:
> The kernel currently doesn't provide any method to show the overall
> system's peak memory usage recorded. Instead, only each slice's peak
> memory usage recorded except for cgroup root is shown through each
> memory.peak.
> 
> Each slice might consume their peak memory at different time. This is
> stored at memory.peak in each own slice. The sum of every memory.peak
> doesn't mean the total system's peak memory usage recorded. The sum at
> certain point without having a peak memory usage in their slice can have
> the largest value.
> 
>        time |  slice1  |  slice2  |   sum
>       =======================================
>         t1  |    50    |   200    |   250
>       ---------------------------------------
>         t2  |   150    |   150    |   300
>       ---------------------------------------
>         t3  |   180    |    20    |   200
>       ---------------------------------------
>         t4  |    80    |    20    |   100
> 
> memory.peak value of slice1 is 180 and memory.peak value of slice2 is 200.
> Only these information are provided through memory.peak value from each
> slice without providing the overall system's peak memory usage. The total
> sum of these two value is 380, but this doesn't represent the real peak
> memory usage of the overall system. The peak value what we want to get is
> shown in t2 as 300, which doesn't have any biggest number even in one
> slice. Therefore the proper way to show the system's overall peak memory
> usage recorded needs to be provided.

The problem I can see is that the root's peak value doesn't really
represent the system peak memory usage because it only reflects memcg
accounted memory. So there is plenty of memory consumption which is not
covered. On top of that a lot of memory contributed to the root memcg is
not accounted at all (see try_charge and its callers) so the cumulative
hierarchical value is incomplete and I believe misleading as well.
-- 
Michal Hocko
SUSE Labs
