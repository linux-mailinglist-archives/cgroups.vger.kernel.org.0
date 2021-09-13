Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034AD40873D
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 10:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhIMIo3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 04:44:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbhIMIoP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 04:44:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3F5CC1FFAC;
        Mon, 13 Sep 2021 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631522577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kanT9LvCczrJLW86//mm44q0kFal7DLHz1meuR6IX0=;
        b=auSFP3cSbtLDH8/xVJew4IJ/MN1dguOz5Le3URoMTqsmLf9D172qnDKyHsvueFiQpQni+V
        iqYmA0o/CA185fT9Fu5DYTdrKJ9FsKsopivFohrGz4IA4xpbdx8zaR0+EF8n/DbRV2DeGq
        KjLTsEbgxqHjGwGRRe1FlKKen1sn0b8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09F27A3B8E;
        Mon, 13 Sep 2021 08:42:56 +0000 (UTC)
Date:   Mon, 13 Sep 2021 10:42:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
Message-ID: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <099aa0db-045a-e5b8-6df7-b7c3fc4d3caa@i-love.sakura.ne.jp>
 <4a407474-ff7a-9e4f-d314-ab85f0eeaadf@virtuozzo.com>
 <YTtx3toUOMLXk4GZ@dhcp22.suse.cz>
 <9556c2ae-2dc8-9d0a-55de-002d674680bf@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9556c2ae-2dc8-9d0a-55de-002d674680bf@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 11:29:37, Vasily Averin wrote:
> On 9/10/21 5:55 PM, Michal Hocko wrote:
> > On Fri 10-09-21 16:20:58, Vasily Averin wrote:
> >> On 9/10/21 4:04 PM, Tetsuo Handa wrote:
> >>> Can't we add fatal_signal_pending(current) test to vmalloc() loop?
> > 
> > We can and we should.
> > 
> >> 1) this has been done in the past but has been reverted later.
> > 
> > The reason for that should be addressed IIRC.
> 
> I don't know the details of this, and I need some time to investigate it.

b8c8a338f75e ("Revert "vmalloc: back off when the current task is killed"")
should give a good insight and references.

> >> 2) any vmalloc changes will affect non-memcg allocations too.
> >>  If we're doing memcg-related checks it's better to do it in one place.
> > 
> > I think those two things are just orthogonal. Bailing out from vmalloc
> > early sounds reasonable to me on its own. Allocating a large thing that
> > is likely to go away with the allocating context is just a waste of
> > resources and potential reason to disruptions to others.
> 
> I doubt that fatal signal should block any vmalloc allocations.
> I assume there are situations where rollback of some cancelled operation uses vmalloc.
> Or coredump saving on some remote storage can uses vmalloc.

If there really are any such requirements then this should be really
documented. 

> However for me it's abnormal that even OOM-killer cannot cancel huge vmalloc allocation.
> So I think tsk_is_oom_victim(current) check should be added to vm_area_alloc_pages() 
> to break vmalloc cycle.

Why should oom killed task behave any different than any other task
killed without a way to handle the signal?

-- 
Michal Hocko
SUSE Labs
