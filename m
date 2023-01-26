Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D59D67D451
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 19:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjAZSiH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 13:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjAZSiE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 13:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF7B4CE7C
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674758236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCnG7e8Wg2ZPkYk2BgwcAsCpETyBPYzxTKI98DQimBw=;
        b=Tnf3GW5Jr5TKIVNpqR7pLUqJR2QU3+mWOdP8zMn8JVLwh5j1+8nagmGcXaFHszxFk/YNO0
        /EGg2ihonBMO13c00rsppXyWAlM69X4d6xpZGbsw/qmCTQktg1+JauWQoyo25lnzUeJnOm
        7zflCS/uXloL0KIZnF2oNrxKaQu5DjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-DfgxT9p-Or6OJ0aCbIzH7w-1; Thu, 26 Jan 2023 13:37:13 -0500
X-MC-Unique: DfgxT9p-Or6OJ0aCbIzH7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7980185D062;
        Thu, 26 Jan 2023 18:37:12 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D89340C2064;
        Thu, 26 Jan 2023 18:37:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0FC7140975B20; Thu, 26 Jan 2023 15:19:45 -0300 (-03)
Date:   Thu, 26 Jan 2023 15:19:45 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9LEQfX5dkEyBOkT@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 25, 2023 at 03:14:48PM -0800, Roman Gushchin wrote:
> On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > Disclaimer:
> > > > > a - The cover letter got bigger than expected, so I had to split it in
> > > > >     sections to better organize myself. I am not very confortable with it.
> > > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > > >     from memcg_stock_pcp), which could further improve performance for
> > > > >     drain_all_stock(), but I could only notice the optimization at the
> > > > >     last minute.
> > > > > 
> > > > > 
> > > > > 0 - Motivation:
> > > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > > descendant of a given root_memcg.
> 
> Do you know what caused those drain_all_stock() calls? I wonder if we should look
> into why we have many of them and whether we really need them?
> 
> It's either some user's actions (e.g. reducing memory.max), either some memcg
> is entering pre-oom conditions. In the latter case a lot of drain calls can be
> scheduled without a good reason (assuming the cgroup contain multiple tasks running
> on multiple cpus). Essentially each cpu will try to grab the remains of the memory quota
> and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
> on per-cgroup basis.
> 
> Generally speaking, draining of pcpu stocks is useful only if an idle cpu is holding some
> charges/memcg references (it might be not completely idle, but running some very special
> workload which is not doing any kernel allocations or a process belonging to the root memcg).
> In all other cases pcpu stock will be either drained naturally by an allocation from another
> memcg or an allocation from the same memcg will "restore" it, making draining useless.
> 
> We also can into drain_all_pages() opportunistically, without waiting for the result.
> On a busy system it's most likely useless, we might oom before scheduled works will be executed.
> 
> I admit I planned to do some work around and even started, but then never had enough time to
> finish it.
> 
> Overall I'm somewhat resistant to an idea of making generic allocation & free paths slower
> for an improvement of stock draining. It's not a strong objection, but IMO we should avoid
> doing this without a really strong reason.

The expectation would be that cache locking should not cause slowdown of
the allocation and free paths:

https://manualsbrain.com/en/manuals/1246877/?page=313

For the P6 and more recent processor families, if the area of memory being locked 
during a LOCK operation is cached in the processor that is performing the LOCK oper-
ation as write-back memory and is completely contained in a cache line, the 
processor may not assert the LOCK# signal on the bus. Instead, it will modify the 
memory location internally and allow it’s cache coherency mechanism to insure that 
the operation is carried out atomically. This operation is called “cache locking.” The 
cache coherency mechanism automatically prevents two or more processors that ...


