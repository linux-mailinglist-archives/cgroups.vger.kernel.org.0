Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D84AE1ED
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiBHTLV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385846AbiBHTLU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 14:11:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEBDC0612C1;
        Tue,  8 Feb 2022 11:11:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7250A210E7;
        Tue,  8 Feb 2022 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644347478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yttcmkKs+bAIvSGjq/8ZnP5VxhwV7JekAzQGhUXqisI=;
        b=dy1JqXXlQZKUE8/PmDrCJFOZy2foFZ/0AkY+ce/Jfjk0EAJ4M/lil/28r3sujk4pPJXcXn
        LKKg/TAy1nG4NLYKEYKZ7u4qAeV9pJ4PEwZWlGdbQcLwNUB+UQzTgAlm2a5hTKs7NPnirl
        L7PkvJFco7fjr5MZF52Jd5A6UXJCwLc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29580A3B81;
        Tue,  8 Feb 2022 19:11:18 +0000 (UTC)
Date:   Tue, 8 Feb 2022 20:11:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v5 3/4] mm/page_owner: Print memcg information
Message-ID: <YgLAVdYRU6HPl6aF@dhcp22.suse.cz>
References: <20220208000532.1054311-1-longman@redhat.com>
 <20220208000532.1054311-4-longman@redhat.com>
 <YgJeWth50eP9L0PK@dhcp22.suse.cz>
 <e897adca-168e-13db-8001-4afbef3aa648@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e897adca-168e-13db-8001-4afbef3aa648@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-02-22 13:40:57, Waiman Long wrote:
> On 2/8/22 07:13, Michal Hocko wrote:
> > On Mon 07-02-22 19:05:31, Waiman Long wrote:
> > > It was found that a number of dying memcgs were not freed because
> > > they were pinned by some charged pages that were present. Even "echo 1 >
> > > /proc/sys/vm/drop_caches" wasn't able to free those pages. These dying
> > > but not freed memcgs tend to increase in number over time with the side
> > > effect that percpu memory consumption as shown in /proc/meminfo also
> > > increases over time.
> > I still believe that this is very suboptimal way to debug offline memcgs
> > but memcg information can be useful in other contexts and it doesn't
> > cost us anything except for an additional output so I am fine with this.
>
> I am planning to have a follow-up patch to add a new debugfs file for just
> printing page information associated with dying memcgs only. It will be
> based on the existing page_owner code, though. So I need to get this patch
> in first.

Sure. I would give a shot the drgn approach as this can be much more
versatile without any additional kernel code.

[...]

> > > +	dying = (memcg->css.flags & CSS_DYING);
> > Is there any specific reason why you haven't used mem_cgroup_online?
> Not really. However, I think checking for CSS_DYING makes more sense now
> that I using the term "dying".

I do not really care much but I though CSS_DYING is a cgroup internal
thing. We have a highlevel API so I thought it would be used
preferably.
-- 
Michal Hocko
SUSE Labs
