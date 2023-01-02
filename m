Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58765B834
	for <lists+cgroups@lfdr.de>; Tue,  3 Jan 2023 00:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjABXfW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Jan 2023 18:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABXfW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Jan 2023 18:35:22 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351CBCB6;
        Mon,  2 Jan 2023 15:35:21 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E4C0C6D6;
        Mon,  2 Jan 2023 23:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E4C0C6D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672702521; bh=8Urwkhnl8X2pfaw1kHAwUmTLLQL4RD3KeQARX6NwZkU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=b3dpElX9lrF8bY2SqAacBRKrkzHM/rKdJm2qvbaZ+Hq0pJel6SdXe+SVKo2vkg2ds
         FjDMKwPXOpB3z4WVlZwhla8yaU+9gbuymFblf/2XWo3Syos1WdOjC31p3sg+hXVpZl
         33hFPhk3NLwKAU0hmi6X2N2HqCfOSnGCnC2VvGnoKwMXC1HMKeucfgxnUJT/uDnQ9p
         C9wg1Wfdc8Y531+MydMRDCBCsMxrnn9SRzLAMjbmm9Br9vrlqhaNQxoWw06emOMgzh
         iQLz6aa13KRJyP2ZKmV3DmjQjPHhsn7pUOyowBykiaGdmwhHByNMM9oEFwBeUVM4G+
         3dzHBtJRU6qVQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 00/10] docs: cgroup-v1: formatting improv for "Memory
 Resource Controller" doc
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
Date:   Mon, 02 Jan 2023 16:35:20 -0700
Message-ID: <87a630h5mv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> "Memory Resource Controller" CGroup v1 documentation has been in reST
> since 99c8b231ae6c6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst"). The current doc look is kinda ugly, so improve the formatting (only
> htmldocs is tested).
>
> The first patch is a fix for recently reported htmldocs warning, which can
> be pickup separately from rest of the series.
>
> Bagas Sanjaya (10):
>   docs: cgroup-v1: extend underline of section 8
>   docs: cgroup-v1: replace custom note constructs with appropriate
>     admonition blocks
>   docs: cgroup-v1: wrap remaining admonitions in admonition blocks
>   docs: cgroup-v1: use code block for locking order schema
>   docs: cgroup-v1: fix footnotes
>   docs: cgroup-v1: move hierarchy of accounting caption
>   docs: cgroup-v1: use bullet lists for list of stat file tables
>   docs: cgroup-v1: use make swap extension subsections subsections
>   docs: cgroup-v1: add internal cross-references
>   docs: cgroup-v1: use numbered lists for user interface setup
>
>  .../admin-guide/cgroup-v1/cgroups.rst         |   2 +
>  .../admin-guide/cgroup-v1/memory.rst          | 290 ++++++++++--------
>  2 files changed, 158 insertions(+), 134 deletions(-)

Tejun, do you have an opinion on these?  I'm not really sure we need to
be tweaking the v1 docs at this point, but I don't see anything in here
that seems harmful either...

Thanks,

jon
