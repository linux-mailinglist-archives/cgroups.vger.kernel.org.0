Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672067B935
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 19:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjAYSXP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 13:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAYSXO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 13:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA459B46
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 10:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674670944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TAHgioL+cbo0qEgcEaZEdMYDgI4uLoD69uULXZCMWk=;
        b=GiIH3wCAjUSKVpIdNPg9Vm0hAhs5WpCkx/XQVx4mx+QuTHj2ZGz/e5zCPZNffNQu34Hyqp
        fNl/kSvYjqPLVWZwdwNpw56+nFOykdmmIWb9RpMhwjgcHVf8r/YaYz4RTKeq97LInytD2x
        iD2cWdRXCzHcvXyOKR7moZ9K0xREjzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-deB-As1LMKysAVKBxmpPAg-1; Wed, 25 Jan 2023 13:22:21 -0500
X-MC-Unique: deB-As1LMKysAVKBxmpPAg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BADC885C073;
        Wed, 25 Jan 2023 18:22:20 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EFB5492B01;
        Wed, 25 Jan 2023 18:22:20 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 94285403C674B; Wed, 25 Jan 2023 15:22:00 -0300 (-03)
Date:   Wed, 25 Jan 2023 15:22:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9FzSBw10MGXm2TK@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > Disclaimer:
> > > a - The cover letter got bigger than expected, so I had to split it in
> > >     sections to better organize myself. I am not very confortable with it.
> > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > >     from memcg_stock_pcp), which could further improve performance for
> > >     drain_all_stock(), but I could only notice the optimization at the
> > >     last minute.
> > > 
> > > 
> > > 0 - Motivation:
> > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > descendant of a given root_memcg.
> > > 
> > > This happens even on 'isolated cpus', a feature commonly used on workloads that
> > > are sensitive to interruption and context switching such as vRAN and Industrial
> > > Control Systems.
> > > 
> > > Since this scheduling behavior is a problem to those workloads, the proposal is
> > > to replace the current local_lock + schedule_work_on() solution with a per-cpu
> > > spinlock.
> > 
> > If IIRC we have also discussed that isolated CPUs can simply opt out
> > from the pcp caching and therefore the problem would be avoided
> > altogether without changes to the locking scheme. I do not see anything
> > regarding that in this submission. Could you elaborate why you have
> > abandoned this option?
> 
> Hello Michal,
> 
> I understand pcp caching is a nice to have.
> So while I kept the idea of disabling pcp caching in mind as an option, I first
> tried to understand what kind of impacts we would be seeing when trying to
> change the locking scheme.

Remote draining reduces interruptions whether CPU 
is marked as isolated or not:

- Allows isolated CPUs from benefiting of pcp caching.
- Removes the interruption to non isolated CPUs. See for example 

https://lkml.org/lkml/2022/6/13/2769

"Minchan Kim tested this independently and reported;

       My workload is not NOHZ CPUs but run apps under heavy memory
       pressure so they goes to direct reclaim and be stuck on
       drain_all_pages until work on workqueue run.

       unit: nanosecond
       max(dur)        avg(dur)                count(dur)
       166713013       487511.77786438033      1283

       From traces, system encountered the drain_all_pages 1283 times and
       worst case was 166ms and avg was 487us.

       The other problem was alloc_contig_range in CMA. The PCP draining
       takes several hundred millisecond sometimes though there is no
       memory pressure or a few of pages to be migrated out but CPU were
       fully booked.

       Your patch perfectly removed those wasted time."


> After I raised the data in the cover letter, I found that the performance impact
> appears not be that big. So in order to try keeping the pcp cache on isolated
> cpus active, I decided to focus effort on the locking scheme change.
> 
> I mean, my rationale is: if is there a non-expensive way of keeping the feature,
> why should we abandon it?
> 
> Best regards,
> Leo
> 
> 
> 
> 
> 
> 
> 
> 

