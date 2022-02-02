Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3B4A6D5B
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 09:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiBBI5X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 03:57:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54608 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiBBI5V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 03:57:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FDE81F387;
        Wed,  2 Feb 2022 08:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643792240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOGbA/DaSksq8t2y0SLaZx5K3xyXpnf22hXltgoj2Fw=;
        b=LhIA8sT2rPTk+xUTfSOMbKqiw1YaHgL8WEvnQwQaE8RIgfTuF/oXaok7rVxYr0eUm76gBP
        tKyng2cUPZgMaUOiqK8zidjTdW8C7kUiKGcNLcL90ROT7Ii18MOlOGjx+CAeJelgXdv8+e
        cjOjfdIQM3+Ukl0p0BaZAyyeolcVVso=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D40DFA3B8C;
        Wed,  2 Feb 2022 08:57:19 +0000 (UTC)
Date:   Wed, 2 Feb 2022 09:57:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
 <12686956-612d-d89b-5641-470d5e913090@redhat.com>
 <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
 <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-02-22 11:41:19, Waiman Long wrote:
> 
> On 2/1/22 05:49, Michal Hocko wrote:
[...]
> > Could you be more specific? Offlined memcgs are still part of the
> > hierarchy IIRC. So it shouldn't be much more than iterating the whole
> > cgroup tree and collect interesting data about dead cgroups.
> 
> What I mean is that without piggybacking on top of page_owner, we will to
> add a lot more code to collect and display those information which may have
> some overhead of its own.

Yes, there is nothing like a free lunch. Page owner is certainly a tool
that can be used. My main concern is that this tool doesn't really
scale on large machines with a lots of memory. It will provide a very
detailed information but I am not sure this is particularly helpful to
most admins (why should people process tons of allocation backtraces in
the first place). Wouldn't it be sufficient to have per dead memcg stats
to see where the memory sits?

Accumulated offline memcgs is something that bothers more people and I
am really wondering whether we can do more for those people to evaluate
the current state.
-- 
Michal Hocko
SUSE Labs
