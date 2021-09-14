Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972CD40A72E
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 09:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhINHPI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 03:15:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39128 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbhINHPH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 03:15:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A0D972206C;
        Tue, 14 Sep 2021 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631603629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txwaKhwa12PBU46ZsNcF+1gome0TjZ9CBmHtWzH6uzc=;
        b=bGiWRdKv8qBHAYo6uY7okxzuUuqOtIaJnnsPyY0NBnjbC/UBbnRIdZrjuEinQDIEeh7Lua
        pyjg4ZJEJ3A8n65b9stkqC69eFv+zGRtYwaxhXW+yZRELmgGs5oe6WCjHomxHDgTCqmVFR
        C7erp512iGlIQLgVSZOetkBudr+b8pY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5D439A3B9D;
        Tue, 14 Sep 2021 07:13:49 +0000 (UTC)
Date:   Tue, 14 Sep 2021 09:13:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in
 do_semtimedop()
Message-ID: <YUBLrJOL6DGxmira@dhcp22.suse.cz>
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
 <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
 <CALvZod7Y4pC4XvqVp+tJ==CnS5Ay8YPqrxeUzA8tMLu+0U3hjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7Y4pC4XvqVp+tJ==CnS5Ay8YPqrxeUzA8tMLu+0U3hjQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 21:32:25, Shakeel Butt wrote:
> On Mon, Sep 13, 2021 at 1:37 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > > However Shakeel Butt pointed that there are much more popular objects
> > > with the same life time and similar memory consumption, the accounting
> > > of which was decided to be rejected for performance reasons.
> >
> > Is there any measurable performance impact in this particular case?
> >
> 
> I don't think there was any regression report or any performance
> evaluation. Linus raised the concern on the potential performance
> impact. I suggested to backoff for this allocation for now and revisit
> again once we have improved the memcg accounting for kernel memory.

I am fine with the change, I am just not satisfied with the
justification. It is not really clear what the intention is except that
Linus wanted it. I have already asked Vasily to provide more
explanation. E.g. this part really begs for clarification
"
This object can consume up to 2 pages, syscall is sleeping one,
size and duration can be controlled by user, and this allocation
can be repeated by many thread at the same time.
"

It sounds like a problem, except it is not because? A worst case
scenario evaluation would be beneficial for example

Thanks!

-- 
Michal Hocko
SUSE Labs
