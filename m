Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01F4F1122
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiDDIqE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 04:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiDDIqC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 04:46:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1FFE67;
        Mon,  4 Apr 2022 01:44:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 503DC1F380;
        Mon,  4 Apr 2022 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649061845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X0N2SxV6GjMVBOdoERBEDYeu88UwXc3gO4jWk0FL4TE=;
        b=G27ShgYo1cdjBzpUTqcaG4sKAhfdAMb+RpuR95Gu71a11RnyRiUj34mel/G84IricAzl1X
        kyXI1UO5gR94PqCsnRxPa/AuFaQunXNCiDC9YAXhbTvnBHFk6MjUBQwrQPN3/Paj6Ur3bl
        eW8JqnJcBgsgVlF6rexeyRdjGKsJWyE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3109A3B94;
        Mon,  4 Apr 2022 08:44:04 +0000 (UTC)
Date:   Mon, 4 Apr 2022 10:44:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <Ykqv1CvGwgmF2jlT@dhcp22.suse.cz>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
 <YkcC3z5ReeQ5vdg9@dhcp22.suse.cz>
 <YkcvU2hosJV3cL8F@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkcvU2hosJV3cL8F@carbon.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 01-04-22 09:58:59, Roman Gushchin wrote:
> On Fri, Apr 01, 2022 at 03:49:19PM +0200, Michal Hocko wrote:
> > On Thu 31-03-22 10:25:23, Roman Gushchin wrote:
> > > On Thu, Mar 31, 2022 at 08:41:51AM +0000, Yosry Ahmed wrote:
> > [...]
> > > > - A similar per-node interface can also be added to support proactive
> > > >   reclaim and reclaim-based demotion in systems without memcg.
> > > 
> > > Maybe an option to specify a timeout? That might simplify the userspace part.
> > 
> > What do you mean by timeout here? Isn't
> > timeout $N echo $RECLAIM > ....
> > 
> > enough?
> 
> It's nice and simple when it's a bash script, but when it's a complex
> application trying to do the same, it quickly becomes less simple and
> likely will require a dedicated thread to avoid blocking the main app
> for too long and a mechanism to unblock it by timer/when the need arises.
> 
> In my experience using correctly such semi-blocking interfaces (semi- because
> it's not clearly defined how much time the syscall can take and whether it
> makes sense to wait longer) is tricky.

We have the same approach to setting other limits which need to perform
the reclaim. Have we ever hit that as a limitation that would make
userspace unnecessarily too complex?
-- 
Michal Hocko
SUSE Labs
