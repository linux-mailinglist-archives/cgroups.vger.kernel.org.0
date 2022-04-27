Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E3512196
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiD0Svx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiD0Sva (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 14:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79061C42F4;
        Wed, 27 Apr 2022 11:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011D861EE6;
        Wed, 27 Apr 2022 18:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7A4C385A9;
        Wed, 27 Apr 2022 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651084615;
        bh=OMICTGO/WYqPH3eg8uS6ToJj8mhJ9pJAhueCepETYGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mL5WuWxE1oAHwTgDVWF/ZSPjveU0MDpd5Uvw46vXoBCYn2+/LaKGjCRkzm4GlsAIM
         7b/mKi2m9pR5S0iab7gFXcUa6WjTZ82mYZgSVkrTfOxFluiScSimCscnu58NstAxiI
         U9cw/bYMDrCdB3fqlz02HDDXeqW1WRZ9YtXIArtE=
Date:   Wed, 27 Apr 2022 11:36:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-Id: <20220427113654.ef8f543d7ba279952deff6f7@linux-foundation.org>
In-Reply-To: <20220427160016.144237-5-hannes@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
        <20220427160016.144237-5-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Apr 2022 12:00:15 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Currently it requires poking at debugfs to figure out the size and
> population of the zswap cache on a host. There are no counters for
> reads and writes against the cache. As a result, it's difficult to
> understand zswap behavior on production systems.
> 
> Print zswap memory consumption and how many pages are zswapped out in
> /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.

/proc/meminfo is rather prime real estate.  Is this important enough to
be placed in there, or should it instead be in the more lowly
/proc/vmstat?

/proc/meminfo is documented in Documentation/filesystems/proc.rst ;)

That file appears to need a bit of updating for other things.
