Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6567D452
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 19:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjAZSiP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 13:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjAZSiK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 13:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A284C6E9
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674758236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGHM4HTnlAbJdDikf/52fslq7b3KLZl+rEC55qRtjz8=;
        b=JSjITrknLTtsu+ihWn04jkGS+x8UN7nKj6sQVv7+Kn3eN/e4jRX+dBh9npwzFAUXmomLzv
        VdXYLORfXQUNoAsZc4luvsXEBkwjFThJrBwQQohJr3ZX4D2j9omdWVlJz4ZJz4Vfbpoa6W
        AgHGZeD+aWwsiOOEnoOA+3SA4n8RL5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-eUNj429XPXSI6cDdVbl3kA-1; Thu, 26 Jan 2023 13:37:13 -0500
X-MC-Unique: eUNj429XPXSI6cDdVbl3kA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90999101A521;
        Thu, 26 Jan 2023 18:37:12 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AAE21121330;
        Thu, 26 Jan 2023 18:37:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 68E82403D52A8; Thu, 26 Jan 2023 15:14:25 -0300 (-03)
Date:   Thu, 26 Jan 2023 15:14:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9LDAZmApLeffrT8@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 26, 2023 at 08:45:36AM +0100, Michal Hocko wrote:
> On Wed 25-01-23 15:22:00, Marcelo Tosatti wrote:
> [...]
> > Remote draining reduces interruptions whether CPU 
> > is marked as isolated or not:
> > 
> > - Allows isolated CPUs from benefiting of pcp caching.
> > - Removes the interruption to non isolated CPUs. See for example 
> > 
> > https://lkml.org/lkml/2022/6/13/2769
> 
> This is talking about page allocato per cpu caches, right? In this patch
> we are talking about memcg pcp caches. Are you sure the same applies
> here?

Both can stall the users of the drain operation.

"Minchan Kim tested this independently and reported;

	My workload is not NOHZ CPUs but run apps under heavy memory
	pressure so they goes to direct reclaim and be stuck on
	drain_all_pages until work on workqueue run."

Therefore using a workqueue to drain memcg pcps also depends on the 
remote CPU executing that work item in time (which can stall
the following). No?

===

   7   3141  mm/memory.c <<wp_page_copy>>
             if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
   8   4118  mm/memory.c <<do_anonymous_page>>
             if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
   9   4577  mm/memory.c <<do_cow_fault>>
             if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
  10    621  mm/migrate_device.c <<migrate_vma_insert_page>>
             if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
  11    710  mm/shmem.c <<shmem_add_to_page_cache>>
             error = mem_cgroup_charge(folio, charge_mm, gfp);

