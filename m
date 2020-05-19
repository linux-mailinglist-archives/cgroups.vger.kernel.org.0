Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C41D8C7D
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 02:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgESAmw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 20:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgESAmw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 May 2020 20:42:52 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597772072C;
        Tue, 19 May 2020 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589848971;
        bh=qxboCEg4hi3CXOBVgmrK9TNH02/9r/BNCIXuD89A5Sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zZ1dJXEoHkeudQYpl+ZCYadBNd3ECVvJt9fa5tm7bHJKpYFJ0cEHRzCZ6ZTWW4R82
         IpjwI5a97klaxsC+8kgRLXKVuyQtAlQxOwqWoSXAXdio7I7RWBOh+JLEycI1cJDC6i
         FZWr8BmJDeTO3aSzoAedmHKYKgllbObVJYvUxMt0=
Date:   Mon, 18 May 2020 17:42:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH mm v3 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200518174249.745e66d1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CALvZod5Dcee8CaNfkhQQbvC1OuOTO7qE9bJw9NAa8nd2Cru6hA@mail.gmail.com>
References: <20200515202027.3217470-1-kuba@kernel.org>
        <20200515202027.3217470-4-kuba@kernel.org>
        <CALvZod5Dcee8CaNfkhQQbvC1OuOTO7qE9bJw9NAa8nd2Cru6hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 17 May 2020 06:44:52 -0700 Shakeel Butt wrote:
> > @@ -2583,12 +2606,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >          * reclaim, the cost of mismatch is negligible.
> >          */
> >         do {
> > -               if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
> > -                       /* Don't bother a random interrupted task */
> > -                       if (in_interrupt()) {
> > +               bool mem_high, swap_high;
> > +
> > +               mem_high = page_counter_read(&memcg->memory) >
> > +                       READ_ONCE(memcg->high);
> > +               swap_high = page_counter_read(&memcg->swap) >
> > +                       READ_ONCE(memcg->swap_high);
> > +
> > +               /* Don't bother a random interrupted task */
> > +               if (in_interrupt()) {
> > +                       if (mem_high) {
> >                                 schedule_work(&memcg->high_work);
> >                                 break;
> >                         }
> > +                       continue;  
> 
> break?

On a closer look I think continue is correct. In irq we only care 
about mem_high, because there's nothing we can do in a work context 
to penalize swap. So the loop is shortened.

> > +               }
> > +
> > +               if (mem_high || swap_high) {
> >                         current->memcg_nr_pages_over_high += batch;
> >                         set_notify_resume(current);
> >                         break;

