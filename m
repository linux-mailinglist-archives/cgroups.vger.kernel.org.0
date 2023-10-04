Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B277B8D21
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbjJDTH2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbjJDTHU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:07:20 -0400
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D430DE
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 12:02:44 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:02:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696446162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkCd19CwQrPmu8oeXBKgORvhKgKP0KURMRX76XbJ8X4=;
        b=GPvMdCBdjfSQr376dX+S6ZkziYW6v58FjLd6pXRyRfIAjZwWPfOYUCigqgOEVLXM4Iq1CR
        /E4fW+l2mj2UbQ0fEPjsPSl7MjKRgF4s5GrszkP2p0Pzb8/v8PFxTRuCLTw5MQVIJXbbtH
        d/pR3EHSoW9yJY/LV7jLBB3swXFa09I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 0/5] mm: improve performance of accounted kernel
 memory allocations
Message-ID: <ZR22wUtVq_vz3NJZ@P9FQF9L96D.corp.robot.car>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
 <n3x64d2wk7qr42tvcmqisbbrntppcwe6omv6li67ui6rz6umyk@wativjrwvh5g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n3x64d2wk7qr42tvcmqisbbrntppcwe6omv6li67ui6rz6umyk@wativjrwvh5g>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 04, 2023 at 08:32:39PM +0200, Michal Koutný wrote:
> On Fri, Sep 29, 2023 at 11:00:50AM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > This patchset improves the performance of accounted kernel memory allocations
> > by ~30% as measured by a micro-benchmark [1]. The benchmark is very
> > straightforward: 1M of 64 bytes-large kmalloc() allocations.
> 
> Nice.

Thanks!

> Have you tried how these +34% compose with -34% reported way back [1]
> when file lock accounting was added (because your benchmark and lock1
> sound quite similar)?

No, I haven't. I'm kindly waiting for an automatic report here :)
But if someone can run these tests manually, I'll appreciate it a lot.

> (BTW Is that your motivation (too)?)

Not really, it was on my todo list for a long time and I just got some spare
cycles to figure out missing parts (mostly around targeted/remote charging).

Also plan to try similar approach to speed up generic memcg charging.

Thanks!
