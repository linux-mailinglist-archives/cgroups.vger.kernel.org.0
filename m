Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2246528731
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiEPOfE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiEPOfC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 10:35:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17909D5F;
        Mon, 16 May 2022 07:35:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C56F71FB2E;
        Mon, 16 May 2022 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652711700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7ceyTjxid5l9ZGGTqZ+wt/EPfbFdKSX+/F4lyNdDKg=;
        b=g3iVVHUtSyQWBN3Y59HjcBDj1p/IZFTO1o2s8CWmnszg6wBpymi4LOQIZAcNlK/seWQfW5
        OTdSKo9VL5YnbQyO5U7Jfrl+JZ6OG/lh8V2pkehTwaRN9l9VeiSd8KtqESYl+sNjIGZ0wr
        /r1jDJWacCJhVoSdrQMTgwD1CqqpyIo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 883E513AAB;
        Mon, 16 May 2022 14:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KL9RIBRhgmL0GwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 16 May 2022 14:35:00 +0000
Date:   Mon, 16 May 2022 16:34:59 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <20220516143459.GA17557@blackbody.suse.cz>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <20220511173218.GB31592@blackbody.suse.cz>
 <YnwJUL90fuoHs3YW@cmpxchg.org>
 <20220513151426.GC16096@blackbody.suse.cz>
 <Yn6QfdouzkcrygTR@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn6QfdouzkcrygTR@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 01:08:13PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Right, it's accounted as a subset rather than fully disjointed. But it
> is a limitable counter of its own, so I exported it as such, with a
> current and a max knob. This is comparable to the kmem counter in v1.

That counter and limit didn't turn out well. I liked the analogy to
writeback (and dirty limit) better.

> From an API POV it would be quite strange to have max for a counter
> that has no current. Likewise it would be strange for a major memory
> consumer to be missing from memory.stat.

My understanding would be to have all memory.stat entries as you
propose, no extra .current counter and the .max knob for zswap
configuration.

> It needs to be configured to the workload's access frequency curve,
> which can be done with trial-and-error (reasonable balance between
> zswpins and pswpins) or in a more targeted manner using tools such as
> page_idle, damon etc.
> [...]
> Because for load tuning, bytes make much more sense. That's how you
> measure the workingset, so a percentage is an awkward indirection. At
> the cgroup level, it makes even less sense: all memcg tunables are in
> bytes, it would be quite weird to introduce a "max" that is 0-100. Add
> the confusion of how percentages would propagate down the hierarchy...

Thanks for the explanation. I guess there's no simple tranformation of
in-kernel available information that'd allow a more semantic
configuration of this value. The rather crude absolute value requires
(but also simply allows) some calibration or responsive tuning.

> I don't traverse all ancestors, I bail on disabled groups and skip
> unlimited ones.

I admit I missed that.

> Flushing unnecessary groups with a ratelimit doesn't sound like an
> improvement to me.

Then I'm only concerned about a situation when there's a single deep
memcg that undergoes both workingset_refault() and zswap querying.
The latter (bare call to cgroup_rstat_flush()) won't reset
stats_flush_threshold, so the former (or the async flush more likely)
would attempt a flush too. The flush work (on the leaf memcg) would be
done twice even though it may be within the tolerance of cumulated
error the second time.

This is a thing that might require attention in the future (depending on
some data how it actually performs). I see how the current approach is
justified.


Regards,
Michal
