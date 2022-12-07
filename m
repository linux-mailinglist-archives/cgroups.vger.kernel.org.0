Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D975D645C0A
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 15:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLGOHu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 09:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLGOHV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 09:07:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F22162F5;
        Wed,  7 Dec 2022 06:07:20 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDAC921D6F;
        Wed,  7 Dec 2022 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670422038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tosjZfZODydjUbuqrfEIBGsRjeHYQJ8iIC4GtSX4HdI=;
        b=Dzp6vahbk3af6y9m0wtHT4j/LM+TyWTrbJIuLUyzPAbc24XF/CBB1eIm3UDK4IGhqwI+mj
        YIpJgQTcYIhAkzTYqDboGt/kD5Qs0wi5JejZgTgYXEQGBipL0FKzPZWbIw15KxDOL4Pufn
        QLs/PPjzoH1pMZyBiKRFSJZzF1m3LC4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AAAC6136B4;
        Wed,  7 Dec 2022 14:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id D00+JxaekGOvBwAAGKfGzw
        (envelope-from <mhocko@suse.com>); Wed, 07 Dec 2022 14:07:18 +0000
Date:   Wed, 7 Dec 2022 15:07:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm: push down lock_page_memcg()
Message-ID: <Y5CeFqlMrUyzZL2s@dhcp22.suse.cz>
References: <20221206171340.139790-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206171340.139790-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 06-12-22 18:13:38, Johannes Weiner wrote:
> New series based on the discussion in the previous thread around
> getting lock_page_memcg() out of rmap.
> 
> I beat on this with concurrent high-frequency moving of tasks that
> partially share a swapped out shmem file. I didn't spot anything
> problematic. That said, it is quite subtle, and Hugh, I'd feel better
> if you could also subject it to your torture suite ;)

For the whole series
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
> 
> Thanks!
> 
> Against yesterday's mm-unstable.
> 
>  Documentation/admin-guide/cgroup-v1/memory.rst | 11 ++++-
>  mm/memcontrol.c                                | 56 ++++++++++++++++++------
>  mm/rmap.c                                      | 26 ++++-------
>  3 files changed, 60 insertions(+), 33 deletions(-)
> 

-- 
Michal Hocko
SUSE Labs
