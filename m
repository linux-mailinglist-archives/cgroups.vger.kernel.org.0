Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A429274829
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVSb2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 14:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVSb2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 22 Sep 2020 14:31:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600799486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6V2DffdTKL8UOfFVJCLTmEpEQRVobEw0bM3wzRvskX0=;
        b=aAJ+/aBcg20EvZdS+X29DSgXibh2SuIV4rOW6CMaDZ+Pit8vIFgMiebbhfGFBvuHU1MhE9
        XQSfFShMcnDvylbwIJQzl7c27qOoZ/XLFVHf0Jxk6XBU8RUccqPBukgHgD+OWuaC4DQNZQ
        5eYSTdekQh3y/lAM57xb6g9ELjrWCoM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52FCAAE64;
        Tue, 22 Sep 2020 18:32:03 +0000 (UTC)
Date:   Tue, 22 Sep 2020 20:31:25 +0200
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
Message-ID: <20200922183125.GG12990@dhcp22.suse.cz>
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
> > So far I have learned that you are primarily working around an
> > implementation detail in the zswap which is doing the swapout path
> > directly in the pageout path.
> 
> Wait how did you reach this conclusion? I have explicitly said that we
> are not using uswapd like functionality in production. We are using
> this interface for proactive reclaim and proactive reclaim is not a
> workaround for implementation detail in the zswap.

Hmm, I must have missed the distinction between the two you have
mentioned. Correct me if I am wrong but "latency sensitive" workload is
the one that cannot use the high limit, right. For some reason I thought
that your pro-active reclaim usecase is also not compatible with the
throttling imposed by the high limit. Hence my conclusion above.
-- 
Michal Hocko
SUSE Labs
