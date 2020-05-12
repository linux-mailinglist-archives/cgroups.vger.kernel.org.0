Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058091CFCAD
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgELRzj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 13:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgELRzj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 May 2020 13:55:39 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33762206B9;
        Tue, 12 May 2020 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306138;
        bh=xdOV4sVw/QH3W5l5kTFnjtP5Xn7D0F1rZuTijRqPjeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=whE0WE770+VHaMbfnYuPaiR3YTLVRI2bm6dCBiAjZO8iCWSULQm9XueRSDg27tl/e
         xqTLM3PvalH3TpK8APtJHmd69y0BT7kubpKq9WhkBe8iFqy9B20swAuxAdcwEnf6Rz
         lFtQWXAqkZCrbJ7H4+d3wLM5A+dn32IvGgCQWhOw=
Date:   Tue, 12 May 2020 10:55:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200512072634.GP29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
        <20200511225516.2431921-4-kuba@kernel.org>
        <20200512072634.GP29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 12 May 2020 09:26:34 +0200 Michal Hocko wrote:
> On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:
> > Use swap.high when deciding if swap is full.  
> 
> Please be more specific why.

How about:

    Use swap.high when deciding if swap is full to influence ongoing
    swap reclaim in a best effort manner.

> > Perform reclaim and count memory over high events.  
> 
> Please expand on this and explain how this is working and why the
> semantic is subtly different from MEMCG_HIGH. I suspect the reason
> is that there is no reclaim for the swap so you are only emitting an
> event on the memcg which is actually throttled. This is in line with
> memory.high but the difference is that we do reclaim each memcg subtree
> in the high limit excess. That means that the counter tells us how many
> times the specific memcg was in excess which would be impossible with
> your implementation.

Right, with memory all cgroups over high get penalized with the extra
reclaim work. For swap we just have the delay, so the event is
associated with the worst offender, anything lower didn't really matter.

But it's easy enough to change if you prefer. Otherwise I'll just add
this to the commit message:

  Count swap over high events. Note that unlike memory over high events
  we only count them for the worst offender. This is because the
  delay penalties for both swap and memory over high are not cumulative,
  i.e. we use the max delay.

> I would also suggest to explain or ideally even separate the swap
> penalty scaling logic to a seprate patch. What kind of data it is based
> on?

It's a hard thing to get production data for since, as we mentioned we
don't expect the limit to be hit. It was more of a process of
experimentation and finding a gradual slope that "felt right"...

Is there a more scientific process we can follow here? We want the
delay to be small at first for a first few pages and then grow to make
sure we stop the task from going too much over high. The square
function works pretty well IMHO.
