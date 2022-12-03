Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F02641210
	for <lists+cgroups@lfdr.de>; Sat,  3 Dec 2022 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiLCAfd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 19:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLCAfc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 19:35:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5652F4EA3;
        Fri,  2 Dec 2022 16:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 816E4B82313;
        Sat,  3 Dec 2022 00:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AADC433C1;
        Sat,  3 Dec 2022 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670027729;
        bh=Yaq0k4zhQofrvgBxN7RFAqXF4aXsNAdfyTsZyQ8We4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ALPbCVF9uULHb7x26GBSJf9oTw+hKWJIcFI1K4iQKJ9gSsVxhfI7Xr5WJGbqVOgSo
         SDKWCNFONERZIXj1KlFgErerzNWA+6svhWqs7DbxZjvxzzQOmD+fLm5N6nYfibvVOH
         BdFO4gdkwQAcgMGJxEfBxDXMZf92yog0ZxU6KFr0=
Date:   Fri, 2 Dec 2022 16:35:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] mm: memcg: fix stale protection of reclaim
 target memcg
Message-Id: <20221202163527.a72646c9d42f3678b20dac7b@linux-foundation.org>
In-Reply-To: <CAJD7tkZouk+r=Qk554AOk1-3eYy-gTC8KC+OJQY13ZkNZ9Qe+Q@mail.gmail.com>
References: <20221202031512.1365483-1-yosryahmed@google.com>
        <20221202031512.1365483-2-yosryahmed@google.com>
        <CAJD7tkZouk+r=Qk554AOk1-3eYy-gTC8KC+OJQY13ZkNZ9Qe+Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2 Dec 2022 16:26:05 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:

> Andrew, does this need to be picked up by stable branches?

Does it?  The changelog doesn't have a clear description of the
user-visible effects of the flaw, which is the guiding light for a
backport?


