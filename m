Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BE654501
	for <lists+cgroups@lfdr.de>; Thu, 22 Dec 2022 17:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLVQV6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Dec 2022 11:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVQV5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Dec 2022 11:21:57 -0500
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF9220C9
        for <cgroups@vger.kernel.org>; Thu, 22 Dec 2022 08:21:56 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:21:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671726113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLJiu3habqMTelcjX0HdZ33w0IhCdBt7SxTNtmucJmQ=;
        b=DCwHM/PPgmNAHXq4GSR+kKVMPMlEFQKeQZ2UBipV7ptTv5n7G9a07wMDkYdSJfnw8UUcwQ
        lwe/N/lE9daABQOcAYbpYfhQaOoMrpX/vpDqQ4Xzkcyxt6mE88ioCpcBZpX5dmnwY1RIO4
        V+lg6ecxOFTKibD2yj3ZCeENRIwuXLo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 2/2] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <Y6SEHTkHSNYQmv5k@P9FQF9L96D>
References: <20221220182745.1903540-1-roman.gushchin@linux.dev>
 <20221220182745.1903540-3-roman.gushchin@linux.dev>
 <20221222135044.GB20830@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221222135044.GB20830@blackbody.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 22, 2022 at 02:50:44PM +0100, Michal Koutný wrote:
> On Tue, Dec 20, 2022 at 10:27:45AM -0800, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > To charge a freshly allocated kernel object to a memory cgroup, the
> > kernel needs to obtain an objcg pointer. Currently it does it
> > indirectly by obtaining the memcg pointer first and then calling to
> > __get_obj_cgroup_from_memcg().
> 
> Jinx [1].
> 
> You report additional 7% improvement with this patch (focused on
> allocations only). I didn't see impressive numbers (different benchmark
> in [1]), so it looked as a microoptimization without big benefit to me.

Hi Michal!

Thank you for taking a look.
Do you have any numbers to share?

In general, I agree that it's a micro-optimization, but:
1) some people periodically complain that accounted allocations are slow
   in comparison to non-accounted and slower than they were with page-based
   accounting,
2) I don't see any particular hot point or obviously non-optimal place on the
   allocation path.

so if we want to make it faster, we have to micro-optimize it here and there,
no other way. It's basically the question how many cache lines we touch.

Btw, I'm working on a patch 3 for this series, which in early tests brings
additional ~25% improvement in my benchmark, hopefully will post it soon as
a part of v1.

Thanks!
