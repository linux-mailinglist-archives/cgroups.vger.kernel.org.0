Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E376B000
	for <lists+cgroups@lfdr.de>; Tue,  1 Aug 2023 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjHAJyv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Aug 2023 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHAJyu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Aug 2023 05:54:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C4BE;
        Tue,  1 Aug 2023 02:54:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C24E81F38D;
        Tue,  1 Aug 2023 09:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690883687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wO63J1EyZpemnTVHqFZ8CyKvSylFpCyQaYjDytJ5JcI=;
        b=Xm1y6TPV+ft2mgHUEs0a4S+VBf8IeVMT2AHrnpwxVYWrl3VVPM27WCA62GEGULwRhG07+U
        n0QYWPeJiNSw5BddFNX4NloFWNI0P/eu+VT8/XaOjKnQpON2VvvYJD09cUF5gpKij+y1c4
        5kP2fChggBnUHXhaJts/jfCsA5DAVGc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0B8813919;
        Tue,  1 Aug 2023 09:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z5loKmfWyGRWUgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 01 Aug 2023 09:54:47 +0000
Date:   Tue, 1 Aug 2023 11:54:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <ZMjWZwYkhxSNLU+q@dhcp22.suse.cz>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720153515.GA1003248@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Sorry for being late to this discussion]

On Thu 20-07-23 11:35:15, Johannes Weiner wrote:
[...]
> I'm super skeptical of this proposal.

Agreed.
 
> Recharging *might* be the most desirable semantics from a user pov,
> but only if it applies consistently to the whole memory footprint.
> There is no mention of slab allocations such as inodes, dentries,
> network buffers etc. which can be a significant part of a cgroup's
> footprint. These are currently reparented. I don't think doing one
> thing with half of the memory, and a totally different thing with the
> other half upon cgroup deletion is going to be acceptable semantics.
> 
> It appears this also brings back the reliability issue that caused us
> to deprecate charge moving. The recharge path has trylocks, LRU
> isolation attempts, GFP_ATOMIC allocations. These introduce a variable
> error rate into the relocation process, which causes pages that should
> belong to the same domain to be scattered around all over the place.
> It also means that zombie pinning still exists, but it's now even more
> influenced by timing and race conditions, and so less predictable.
> 
> There are two issues being conflated here:
> 
> a) the problem of zombie cgroups, and
> 
> b) who controls resources that outlive the control domain.
> 
> For a), reparenting is still the most reasonable proposal. It's
> reliable for one, but it also fixes the problem fully within the
> established, user-facing semantics: resources that belong to a cgroup
> also hierarchically belong to all ancestral groups; if those resources
> outlive the last-level control domain, they continue to belong to the
> parents. This is how it works today, and this is how it continues to
> work with reparenting. The only difference is that those resources no
> longer pin a dead cgroup anymore, but instead are physically linked to
> the next online ancestor. Since dead cgroups have no effective control
> parameters anymore, this is semantically equivalent - it's just a more
> memory efficient implementation of the same exact thing.
> 
> b) is a discussion totally separate from this. We can argue what we
> want this behavior to be, but I'd argue strongly that whatever we do
> here should apply to all resources managed by the controller equally.
> 
> It could also be argued that if you don't want to lose control over a
> set of resources, then maybe don't delete their control domain while
> they are still alive and in use. For example, when restarting a
> workload, and the new instance is expected to have largely the same
> workingset, consider reusing the cgroup instead of making a new one.
> 
> For the zombie problem, I think we should merge Muchun's patches
> ASAP. They've been proposed several times, they have Roman's reviews
> and acks, and they do not change user-facing semantics. There is no
> good reason not to merge them.

Yes, fully agreed on both points. The problem with zombies is real but
reparenting should address it for a large part. Ownership is a different
problem. We have discussed that at LSFMM this year and in the past as
well I believe. What we probably need is a concept of taking an
ownership of the memory (something like madvise(MADV_OWN, range) or
fadvise for fd based resources). This would allow the caller to take
ownership of the said resource (like memcg charge of it).

I understand that would require some changes to existing workloads.
Whatever the interface will be, it has to be explicit otherwise we
are hitting problems with unaccounted resources that are sitting without
any actual ownership and an undeterministic and time dependeing hopping
over owners. In other words, nobody should be able to drop
responsibility of any object while it is still consuming resources.

-- 
Michal Hocko
SUSE Labs
