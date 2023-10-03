Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734B27B62EC
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjJCH5k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjJCH5j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 03:57:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55691AD;
        Tue,  3 Oct 2023 00:57:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17CC82188D;
        Tue,  3 Oct 2023 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696319852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdysReyIWmxUi/MpxLbc00AbinD4LgR44ecsW2vhheI=;
        b=ZqyVrJzLPze82CZvHHwdzKLGjc50sO8JCrpbUOdF/5YPZHbjAyfzWYzXngp3k6OteWvo0+
        QrBlVH2T18Ppri+8I/yx9EoGc0RQo0dHloev1Zy44/Ygv277jl3BSYZDuVt5egTzJOYXmH
        Efu78ONvEJ+6He4wcRl9BwnmKdY6Qqg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC48E132D4;
        Tue,  3 Oct 2023 07:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JDUSOWvJG2UQJAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Oct 2023 07:57:31 +0000
Date:   Tue, 3 Oct 2023 09:57:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm: memcg: fix tracking of pending stats updates
 values
Message-ID: <ZRvJa1Hza1RS28+G@dhcp22.suse.cz>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <ZRGQIhWF02SRzN4D@dhcp22.suse.cz>
 <CAJD7tkbWz7mx6mUrvFQHP10ncqL-iVwD4ymHTm=oXW5qGgrZtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbWz7mx6mUrvFQHP10ncqL-iVwD4ymHTm=oXW5qGgrZtA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 25-09-23 10:11:05, Yosry Ahmed wrote:
> On Mon, Sep 25, 2023 at 6:50 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 22-09-23 17:57:38, Yosry Ahmed wrote:
> > > While working on adjacent code [1], I realized that the values passed
> > > into memcg_rstat_updated() to keep track of the magnitude of pending
> > > updates is consistent. It is mostly in pages, but sometimes it can be in
> > > bytes or KBs. Fix that.
> >
> > What kind of practical difference does this change make? Is it worth
> > additional code?
> 
> As explained in patch 2's commit message, the value passed into
> memcg_rstat_updated() is used for the "flush only if not worth it"
> heuristic. As we have discussed in different threads in the past few
> weeks, unnecessary flushes can cause increased global lock contention
> and/or latency.
> 
> Byte-sized paths (percpu, slab, zswap, ..) feed bytes into the
> heuristic, but those are interpreted as pages, which means we will
> flush earlier than we should. This was noticed by code inspection. How
> much does this matter in practice? I would say it depends on the
> workload: how many percpu/slab allocations are being made vs. how many
> flushes are requested.
> 
> On a system with 100 cpus, 25M of stat updates are needed for a flush
> usually, but ~6K of slab/percpu updates will also (mistakenly) cause a
> flush.

This surely depends on workload and that is understandable. But it would
be really nice to provide some numbers for typical workloads which
exercise slab heavily. 
-- 
Michal Hocko
SUSE Labs
