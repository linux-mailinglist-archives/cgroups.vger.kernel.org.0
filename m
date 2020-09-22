Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C52748CC
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIVTJD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 15:09:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:35184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVTJC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 22 Sep 2020 15:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600801740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CW9QWqJ7q2Kodf4xbjqeZQdYjMsmJi312d4fCh2gG6g=;
        b=am3UrXxd1MkIUqFBP8aN0slqcWO/Bw63BGSak3pgn1ZPDR8+wNqHKX9srRcZzat4AJ+akz
        SCCnb2Z4J5dh68Go3WrUZxK/OxrQkwsnTsPrRVAYgMYIFcV2MEkhUwEVgvF23+89DXxAHS
        Q9tXE/PSUecByYAItejjA5fw1Q82EHg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B568AADB3;
        Tue, 22 Sep 2020 19:09:37 +0000 (UTC)
Date:   Tue, 22 Sep 2020 21:08:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20200922190859.GH12990@dhcp22.suse.cz>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200921163055.GQ12990@dhcp22.suse.cz>
 <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com>
 <20200922114908.GZ12990@dhcp22.suse.cz>
 <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
 <20200922165527.GD12990@dhcp22.suse.cz>
 <CALvZod7K9g9mi599c5+ayLeC4__kckv155QQGVMVy2rXXOY1Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7K9g9mi599c5+ayLeC4__kckv155QQGVMVy2rXXOY1Rw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-09-20 11:10:17, Shakeel Butt wrote:
> On Tue, Sep 22, 2020 at 9:55 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Last but not least the memcg
> > background reclaim is something that should be possible without a new
> > interface.
> 
> So, it comes down to adding more functionality/semantics to
> memory.high or introducing a new simple interface. I am fine with
> either of one but IMO convoluted memory.high might have a higher
> maintenance cost.

One idea would be to schedule a background worker (which work on behalf
on the memcg) to do the high limit reclaim with high limit target as
soon as the high limit is reached. There would be one work item for each
memcg. Userspace would recheck the high limit on return to the userspace
and do the reclaim if the excess is larger than a threshold, and sleep
as the fallback.

Excessive consumers would get throttled if the background work cannot
keep up with the charge pace and most of them would return without doing
any reclaim because there is somebody working on their behalf - and is
accounted for that.

The semantic of high limit would be preserved IMHO because high limit is
actively throttled. Where that work is done shouldn't matter as long as
it is accounted properly and memcg cannot outsource all the work to the
rest of the system.

Would something like that (with many details to be sorted out of course)
be feasible?

If we do not want to change the existing semantic of high and want a new
api then I think having another limit for the background reclaim then
that would make more sense to me. It would resemble the global reclaim
and kswapd model and something that would be easier to reason about.
Comparing to echo $N > reclaim which might mean to reclaim any number
pages around N.
-- 
Michal Hocko
SUSE Labs
