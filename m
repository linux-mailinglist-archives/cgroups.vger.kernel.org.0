Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0621782BB4
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjHUO0J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjHUO0J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:26:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154EFE3;
        Mon, 21 Aug 2023 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VBLWbhiJ5Y+LfXHbB2wVDfY3nQIzq6btaVbaMioHfUU=; b=Ob3wf54jrst6pqEm8LXcrMnm9m
        zF7UTAPg+4G/Z5X/gaXsOzPf8/oPTBEWz7UZaZpozdHcPyh6WMpbkSp/NnhWspC2e246EiVEkjRLu
        d3r7s09NuEB8Dzoy+YQ6SoiraRD8K64+WiEeWNAcaI+BDL6Zjqsfy32mpPbM7Ey+s3JKw4YnuH0rI
        yxCGVA86DMQPQD/4plE7ar23F5o6tS5xMrhF41ovILa9yv/Ro1TbOpb/vfms/cgwecRF2N8Mt/v0B
        +JDa9sUH+GMEPdmmz6EU1+XUSOYsC4qneL7wNd5mx3dBA0dplXzyTpv9rJoKsObtBWZB73hH/XH+m
        LoJI12zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY5qs-00AgPo-1d; Mon, 21 Aug 2023 14:25:54 +0000
Date:   Mon, 21 Aug 2023 15:25:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm: memcomtrol: add warning in case of rtpn = NULL
Message-ID: <ZONz8Zqwg4cuCGCe@casper.infradead.org>
References: <20230821142051.31889-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821142051.31889-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 21, 2023 at 05:20:51PM +0300, Anastasia Belova wrote:
> kzalloc_node may return NULL. So rtpn should be
> checked before dereference in mem_cgroup_init.

What good will this do?

>  
>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
> +		WARN_ON(!rtpn);
>  
>  		rtpn->rb_root = RB_ROOT;

so you'll get a warning right before you get a crash, which will provide
exactly the same information.  And you'd already have a warning that
the memory allocation had failed (because __GFP_NOWARN wasn't set).
So you've increased the amount of data from 2 dumps to 3 without providing
any neww information.

If you _did_ something to avoid the crash, there might be a point to
this, but the fact is that small GFP_KERNEL allocations _don't_ fail.
You need to teach your tool that, or you'll be overwhelmed with
false positives.

