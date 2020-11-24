Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA82C2830
	for <lists+cgroups@lfdr.de>; Tue, 24 Nov 2020 14:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbgKXNgr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Nov 2020 08:36:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388416AbgKXNgr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 24 Nov 2020 08:36:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606225005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2c/SYhOtoyvJtV/p2zTmvjzRC4P9vVyA8jCHuZPunMs=;
        b=IvMw/JSbQDq0vmancWDg21W2VAQ1wUzQCSeLYFvoGwcDnzw+FvEofTkT6j2f32KusClcTm
        gpnaMYVBCblguuMiAqxjEaBCLaP7YBVf4QHm3cElJX5I5QLWvcitJFCxWkF4u1eUwEB36w
        5KqfFbSF2b7WAaZUUtX3L1+eO6UjXAA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A24BADE1;
        Tue, 24 Nov 2020 13:36:45 +0000 (UTC)
Date:   Tue, 24 Nov 2020 14:36:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
Message-ID: <20201124133644.GA31550@dhcp22.suse.cz>
References: <20201124105836.713371-1-atomlin@redhat.com>
 <20201124112612.GV27488@dhcp22.suse.cz>
 <CANfR36hyrqXjk2tL03GzCk6rn6sCD7Sd811soBsZC3dHY0h9fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANfR36hyrqXjk2tL03GzCk6rn6sCD7Sd811soBsZC3dHY0h9fQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 24-11-20 13:27:32, Aaron Tomlin wrote:
> On Tue, 24 Nov 2020 at 11:26, Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Tue 24-11-20 10:58:36, Aaron Tomlin wrote:
> > > Each memory-controlled cgroup is assigned a unique ID and the total
> > > number of memory cgroups is limited to MEM_CGROUP_ID_MAX.
> > >
> > > This patch provides the ability to determine the number of
> > > memory cgroups from the root memory cgroup, only.
> > > A value of 1 (i.e. self count) is returned if there are no children.
> > > For example, the number of memory cgroups can be established by
> > > reading the /sys/fs/cgroup/memory/memory.total_cnt file.
> >
> 
> Hi Michal,
> 
> 
> > Could you add some explanation why is this information useful for
> > userspace? Who is going to use it and why a simple scripting on top of
> > cgroupfs is insufficient.
> >
> 
> Thank you for your feedback.
> 
> Indeed, one can use a command/script to manually calculate this.
> Having said that, one that creates a significant number of
> memory-controlled cgroups may prefer a quick, simple and reliable method
> to generate the aforementioned data, for management purposes only.
> As such, I thought this patch might be particularly useful.

This like any other user visible interface would be a much easier sell
if there was a clear usecase to justify it. I do not see anything
controversial about exporting such a value but my general take is that
we are only adding new interface when existing ones are insufficient. A
performance might be a very good reason but that would really require to
come with some real life numbers.

Thanks!
-- 
Michal Hocko
SUSE Labs
