Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C979CF1D
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjILLD1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Sep 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjILLDH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Sep 2023 07:03:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC710E5;
        Tue, 12 Sep 2023 04:03:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33DFD212AE;
        Tue, 12 Sep 2023 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694516581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ueVFGBowAWqGipfNQqUaUPs7n50soYsOXj5+ijJC44=;
        b=QtRF3jYdgfuACICva/StORZig/bbcCipPnzhVC2F+GBibpItfwEZroTW4ipaKaDUcEYrci
        CIdZ6hWQ6nZI17dJMYDjydq7tl5/V9H1nOPckllPAQlAkuUNPxXzDulaN8ZBxrsOXiLp91
        A+MUbTATQKvgsJiK3kpJGdkLyxR3GwQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24CF313A39;
        Tue, 12 Sep 2023 11:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UHFZCGVFAGX9ZwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 12 Sep 2023 11:03:01 +0000
Date:   Tue, 12 Sep 2023 13:03:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Wei Xu <weixugc@google.com>, Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZQBFZMRL8WmqRgrM@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com>
 <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz>
 <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
 <ZP9rtiRwRv2bQvde@dhcp22.suse.cz>
 <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
 <ZP92xP5rdKdeps7Z@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP92xP5rdKdeps7Z@mtj.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-09-23 10:21:24, Tejun Heo wrote:
> Hello,
> 
> On Mon, Sep 11, 2023 at 01:01:25PM -0700, Wei Xu wrote:
> > Yes, it is the same test (10K contending readers). The kernel change
> > is to remove stats_user_flush_mutex from mem_cgroup_user_flush_stats()
> > so that the concurrent mem_cgroup_user_flush_stats() requests directly
> > contend on cgroup_rstat_lock in cgroup_rstat_flush().
> 
> I don't think it'd be a good idea to twist rstat and other kernel internal
> code to accommodate 10k parallel readers.

I didn't mean to suggest optimizing for this specific scenario. I was
mostly curious whether the pathological case of unbound high latency due
to lock dropping is easy to trigger by huge number of readers. It seems
it is not and the mutex might not be really needed as a prevention.

> If we want to support that, let's
> explicitly support that by implementing better batching in the read path.

Well, we need to be able to handle those situations because stat files
are generally readable and we do not want unrelated workloads to
influence each other heavily through this path.

[...]

> When you have that many concurrent readers, most of them won't need to
> actually flush.

Agreed! 
-- 
Michal Hocko
SUSE Labs
