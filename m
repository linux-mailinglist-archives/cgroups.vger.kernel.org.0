Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C177743007B
	for <lists+cgroups@lfdr.de>; Sat, 16 Oct 2021 08:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhJPGGm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Oct 2021 02:06:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:60208 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233998AbhJPGGm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 16 Oct 2021 02:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=xI7kQGX5KyJoY+1LjCTdHRnFhsACsaLASZrxq3vB3gA=; b=xKcMUdmxkPpA+p6rh
        y0D0ZcC/9R6ITj2oAfdNBB1Ds822WSFnZaFiCfyqVwUYngECrTruzlLlgI2pGWTgLd5XfYJ4s5k0B
        Iqdr/wHa7dhaA72qYTc0GAVDXaCmbT6HC4eh6JqXmW7Na6pFF5y/sQJnUPvKhJkfsAG21VQopb12g
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mbco1-006BWm-9a; Sat, 16 Oct 2021 09:04:29 +0300
Subject: Re: [PATCH mm v5] memcg: enable memory accounting in
 __alloc_pages_bulk
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <65c1afaf-7947-ce28-55b7-06bde7aeb278@virtuozzo.com>
 <20211015143405.b7d54e4afa4ca7b2d57b6140@linux-foundation.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <12d991ba-1702-c648-c4c7-5f9bd507582d@virtuozzo.com>
Date:   Sat, 16 Oct 2021 09:04:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015143405.b7d54e4afa4ca7b2d57b6140@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 16.10.2021 00:34, Andrew Morton wrote:
> On Thu, 14 Oct 2021 11:02:57 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:
> 
>> Bulk page allocator is used in vmalloc where it can be called
>> with __GFP_ACCOUNT and must charge allocated pages into memory cgroup.
> 
> Is this problem serious enough to justify -stable backporting?  Some
> words which explaining reasoning for the backport would be helpful.
> 
> This patch makes Shakeel's "memcg: page_alloc: skip bulk allocator for
> __GFP_ACCOUNT" unnecessary.  Which should we use?

Please use Shakeel's patch.

My patch at least requires review, so at present it should be delayed.
I've submitted it because it may be useful later.
Moreover  Currently it have minor issue, function in !MEMCG_KMEM branch
in of memcontrol.h should be declare as static inline.

Thank you,
	Vasily Averin
