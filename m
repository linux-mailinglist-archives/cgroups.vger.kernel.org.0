Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1672963D5F9
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiK3Mun (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3Mum (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 07:50:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9B3D90E;
        Wed, 30 Nov 2022 04:50:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 515121F8D4;
        Wed, 30 Nov 2022 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669812640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ZGYbHjMMJD2KtxpoYl71o8+mthDszQIMORViCtN+H4=;
        b=TEYdT2ejsqxumwVeGAtrs/wb5t8Z7WykQ86E9LmitKLafwNZ3z4nIFifyvnAoyM2lSntZk
        4ETEFoMHzkEz3lOxQ/oZ49G7lqHhgEx9C8HKAAVubxMqpZ9B4BG6KeTAM+reO31e5xywk0
        aevyUeC9LoRpjosj/FGvwSFKdixPZHk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 346E21331F;
        Wed, 30 Nov 2022 12:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHV9CqBRh2O3SgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 30 Nov 2022 12:50:40 +0000
Date:   Wed, 30 Nov 2022 13:50:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
Message-ID: <Y4dRnxrVkdqLRi1v@dhcp22.suse.cz>
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
 <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org>
 <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 29-11-22 14:08:34, Johannes Weiner wrote:
[...]
> Short of further restricting the pages that can be moved, I don't see
> how we can get rid of the cgroup locks in rmap after all. :(

:(

> We can try limiting move candidates to present ptes. But maybe it's
> indeed time to deprecate the legacy charge moving altogether, and get
> rid of the entire complication.
> 
> Hugh, Shakeel, Michal, what do you think?

I do agree with Hugh that going part way will likely not solve the
general maintenance burden. I am OK with dropping the functionality but
we should at least add a big fat warning if anybody wants to enable
memory.move_charge_at_immigrate. If there are any workload which
absolutely depend on the feature (which would make them impossible to
migrate to v2 btw) then we want to hear about that and address in some
way.

An incremental deprecation by limiting to present ptes sounds like this
semantic change might get overlooked for an extended time.

-- 
Michal Hocko
SUSE Labs
