Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462178F1BD
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbjHaRT0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbjHaRT0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 13:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E905CDD
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693502317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBklFU3iiv7RvzlkD14uYmQsEA+NjOWwBhgNqF5FB9A=;
        b=HSjWTSUOBzATvb9nWzfCqbF+UkTq+aUksicXnhQ3/cEUhsiEaPHmzVUJOOLsk0U1MWG/HT
        TWkG4JP1Y54Sas9WZ8BFfRhZhqNQ5F6TtKDu0Oq2Oi7IeyeNULs44CR/YDxk/RBXX5XjDW
        pan0noP6b+9mhnt1KV41Gk3M5iR3Q1E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-Fouv2VfFPIOGfNHhFeDIRQ-1; Thu, 31 Aug 2023 13:18:32 -0400
X-MC-Unique: Fouv2VfFPIOGfNHhFeDIRQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E9D3C11A18;
        Thu, 31 Aug 2023 17:18:30 +0000 (UTC)
Received: from [10.22.17.50] (unknown [10.22.17.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 302C74021C8;
        Thu, 31 Aug 2023 17:18:29 +0000 (UTC)
Message-ID: <b43508ea-c222-5e38-2486-a4a7e7263d61@redhat.com>
Date:   Thu, 31 Aug 2023 13:18:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/4] memcg: non-unified flushing for userspace stats
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230831165611.2610118-1-yosryahmed@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230831165611.2610118-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/31/23 12:56, Yosry Ahmed wrote:
> Most memcg flushing contexts using "unified" flushing, where only one
> flusher is allowed at a time (others skip), and all flushers need to
> flush the entire tree. This works well with high concurrency, which
> mostly comes from in-kernel flushers (e.g. reclaim, refault, ..).
>
> For userspace reads, unified flushing leads to non-deterministic stats
> staleness and reading cost. This series clarifies and documents the
> differences between unified and non-unified flushing (patches 1 & 2),
> then opts userspace reads out of unified flushing (patch 3).
>
> This patch series is a follow up on the discussion in [1]. That was a
> patch that proposed that userspace reads wait for ongoing unified
> flushers to complete before returning. There were concerns about the
> latency that this introduces to userspace reads, especially with ongoing
> reports of expensive stat reads even with unified flushing. Hence, this
> series follows a different approach, by opting userspace reads out of
> unified flushing completely. The cost of userspace reads are now
> determinstic, and depend on the size of the subtree being read. This
> should fix both the *sometimes* expensive reads (due to flushing the
> entire tree) and occasional staless (due to skipping flushing).
>
> I attempted to remove unified flushing completely, but noticed that
> in-kernel flushers with high concurrency (e.g. hundreds of concurrent
> reclaimers). This sort of concurrency is not expected from userspace
> reads. More details about testing and some numbers in the last patch's
> changelog.
>
> v4 -> v5:
> - Fixed build error in the last patch with W=1 because of a missed
>    'static'.
>
> v4: https://lore.kernel.org/lkml/20230830175335.1536008-1-yosryahmed@google.com/
>
> Yosry Ahmed (4):
>    mm: memcg: properly name and document unified stats flushing
>    mm: memcg: add a helper for non-unified stats flushing
>    mm: memcg: let non-unified root stats flushes help unified flushes
>    mm: memcg: use non-unified stats flushing for userspace reads
>
>   include/linux/memcontrol.h |   8 +--
>   mm/memcontrol.c            | 106 +++++++++++++++++++++++++++----------
>   mm/vmscan.c                |   2 +-
>   mm/workingset.c            |   4 +-
>   4 files changed, 85 insertions(+), 35 deletions(-)
>
LGTM

Acked-by: Waiman Long <longman@redhat.com>

