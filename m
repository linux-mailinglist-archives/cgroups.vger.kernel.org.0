Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF452AED9
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiEQXwW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 19:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiEQXwV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 19:52:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814D252E48;
        Tue, 17 May 2022 16:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F218B81D16;
        Tue, 17 May 2022 23:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B0C34117;
        Tue, 17 May 2022 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652831537;
        bh=pEz6dre40UCCubkWjCpmYmIXIWT0QJP+YHG6iJ3oqAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tsprR4zmK/oALRYBT6vfLxQ1klcvHAWxPcTURMr4US/hz7Uw0voe1Rd7mrChl8sdH
         2miTXW+EY7qU+TEI2unOpAlcbme0xr2QXB48zpwSoZaqLZ+c/nu+dY2yTH5iNx0vo8
         yhD8XhZUkOY2U6dkpIa/o/EV1/RwxLY79S8QzLW0=
Date:   Tue, 17 May 2022 16:52:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-Id: <20220517165216.7acd8434f8b25606836e21e6@linux-foundation.org>
In-Reply-To: <YoKtgaxOAMBVKiCf@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
        <20220510152847.230957-7-hannes@cmpxchg.org>
        <20220511173218.GB31592@blackbody.suse.cz>
        <YnwJUL90fuoHs3YW@cmpxchg.org>
        <20220513151426.GC16096@blackbody.suse.cz>
        <Yn6QfdouzkcrygTR@cmpxchg.org>
        <20220516143459.GA17557@blackbody.suse.cz>
        <YoKtgaxOAMBVKiCf@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 16 May 2022 16:01:05 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > > Flushing unnecessary groups with a ratelimit doesn't sound like an
> > > improvement to me.
> > 
> > Then I'm only concerned about a situation when there's a single deep
> > memcg that undergoes both workingset_refault() and zswap querying.
> > The latter (bare call to cgroup_rstat_flush()) won't reset
> > stats_flush_threshold, so the former (or the async flush more likely)
> > would attempt a flush too. The flush work (on the leaf memcg) would be
> > done twice even though it may be within the tolerance of cumulated
> > error the second time.
> > 
> > This is a thing that might require attention in the future (depending on
> > some data how it actually performs). I see how the current approach is
> > justified.
> 
> Yes, we can optimize it should the need arise. So far it's been fine.
> 
> Thanks for your thoughts, Michal.

Me too.

I think everything is settled here so I plan to import this series into
mm-stable in a couple of days.

at
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/

 documentation-filesystems-proc-update-meminfo-section.patch
 documentation-filesystems-proc-update-meminfo-section-fix.patch
 documentation-filesystems-proc-update-meminfo-section-fix-2.patch
 mm-kconfig-move-swap-and-slab-config-options-to-the-mm-section.patch
 mm-kconfig-group-swap-slab-hotplug-and-thp-options-into-submenus.patch
 mm-kconfig-group-swap-slab-hotplug-and-thp-options-into-submenus-fix.patch
 mm-kconfig-group-swap-slab-hotplug-and-thp-options-into-submenus-fix-fix.patch
 mm-kconfig-simplify-zswap-configuration.patch
 mm-zswap-add-basic-meminfo-and-vmstat-coverage.patch
 zswap-memcg-accounting.patch
 zswap-memcg-accounting-fix.patch
 zswap-memcg-accounting-fix-2.patch


