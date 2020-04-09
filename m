Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06921A36FF
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgDIPZp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 11:25:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34735 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgDIPZp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 11:25:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so12422939wrl.1
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 08:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PHqFG+zPr67l6WAhAnHtOaS5fGVxsmLJYOWvTgqFL40=;
        b=lh+h2cJ+pqYYh9yWmySshwnU7JrnIRFG8wZznQJ86qYloKh+mQWcnyk0acRowhYyKA
         D9l1xrskbq+JrwEvpusHOCO6XSS6RYXoCzo+u5bqw7aXXnj/j8O/RiCQg3crYB9ZrhS2
         KqXikqCIluijLqP6z4HawyswHGqznM12w1ZFi/0iiYkFTasC7abbEAK5RQXGD9+7sOIK
         9/WH8qdd4DqTfrSrl2IeqCKTyr7Gp3EM1zaJVOsM4XODHqOJioBpSnkc2itmH3VUIJqm
         E6LijZH0bega4lqVaAWCza0lYQNVx5xseBA5u63WyVgkdvslTPnDDiuB5KjDrV1YGpcG
         nvWA==
X-Gm-Message-State: AGi0PuahXO87QTPudrhlY7uthV8c9t46VeSbFTYi+CBVi73lU5/dK19F
        EioG/5MLvKHkEO029h5kr00=
X-Google-Smtp-Source: APiQypIThHSyLxh1zmyzhXTWWzDpswLnWYjvkGJ6UomuRlmNgq5mctaCVeu0hIMRJaXSWe4EY9QMtA==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr5820087wrm.45.1586445942075;
        Thu, 09 Apr 2020 08:25:42 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id m13sm10706079wrx.40.2020.04.09.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:25:41 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:25:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409152540.GP18386@dhcp22.suse.cz>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
 <20200409094615.GE18386@dhcp22.suse.cz>
 <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
 <20200409103400.GF18386@dhcp22.suse.cz>
 <20200409170926.182354c3@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409170926.182354c3@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-04-20 17:09:26, Bruno Prémont wrote:
> On Thu, 9 Apr 2020 12:34:00 +0200Michal Hocko wrote:
> 
> > On Thu 09-04-20 12:17:33, Bruno Prémont wrote:
> > > On Thu, 9 Apr 2020 11:46:15 Michal Hocko wrote:  
> > > > [Cc Chris]
> > > > 
> > > > On Thu 09-04-20 11:25:05, Bruno Prémont wrote:  
> > > > > Hi,
> > > > > 
> > > > > Upgrading from 5.1 kernel to 5.6 kernel on a production system using
> > > > > cgroups (v2) and having backup process in a memory.high=2G cgroup
> > > > > sees backup being highly throttled (there are about 1.5T to be
> > > > > backuped).    
> > > > 
> > > > What does /proc/sys/vm/dirty_* say?  
> > > 
> > > /proc/sys/vm/dirty_background_bytes:0
> > > /proc/sys/vm/dirty_background_ratio:10
> > > /proc/sys/vm/dirty_bytes:0
> > > /proc/sys/vm/dirty_expire_centisecs:3000
> > > /proc/sys/vm/dirty_ratio:20
> > > /proc/sys/vm/dirty_writeback_centisecs:500  
> > 
> > Sorry, but I forgot ask for the total amount of memory. But it seems
> > this is 64GB and 10% dirty ration might mean a lot of dirty memory.
> > Does the same happen if you reduce those knobs to something smaller than
> > 2G? _bytes alternatives should be useful for that purpose.
> 
> Well, tuning it to /proc/sys/vm/dirty_background_bytes:268435456
> /proc/sys/vm/dirty_background_ratio:0
> /proc/sys/vm/dirty_bytes:536870912
> /proc/sys/vm/dirty_expire_centisecs:3000
> /proc/sys/vm/dirty_ratio:0
> /proc/sys/vm/dirty_writeback_centisecs:500
> does not make any difference.

OK, it was a wild guess because cgroup v2 should be able to throttle
heavy writers and be memcg aware AFAIR. But good to have it confirmed.

[...]

> > > > Is it possible that the reclaim is not making progress on too many
> > > > dirty pages and that triggers the back off mechanism that has been
> > > > implemented recently in  5.4 (have a look at 0e4b01df8659 ("mm,
> > > > memcg: throttle allocators when failing reclaim over memory.high")
> > > > and e26733e0d0ec ("mm, memcg: throttle allocators based on
> > > > ancestral memory.high").  
> > > 
> > > Could be though in that case it's throttling the wrong task/cgroup
> > > as far as I can see (at least from cgroup's memory stats) or being
> > > blocked by state external to the cgroup.
> > > Will have a look at those patches so get a better idea at what they
> > > change.  
> > 
> > Could you check where is the task of your interest throttled?
> > /proc/<pid>/stack should give you a clue.
> 
> As guessed by Chris, it's
> [<0>] mem_cgroup_handle_over_high+0x121/0x170
> [<0>] exit_to_usermode_loop+0x67/0xa0
> [<0>] do_syscall_64+0x149/0x170
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> And I know no way to tell kernel "drop all caches" for a specific cgroup
> nor how to list the inactive files assigned to a given cgroup (knowing
> which ones they are and their idle state could help understanding why
> they aren't being reclaimed).
> 
> 
> 
> Could it be that cache is being prevented from being reclaimed by a task
> in another cgroup?
> 
> e.g.
>   cgroup/system/backup
>     first reads $files (reads each once)
>   cgroup/workload/bla
>     second&more reads $files
> 
> Would $files remain associated to cgroup/system/backup and not
> reclaimed there instead of being reassigned to cgroup/workload/bla?

No, page cache is first-touch-gets-charged. But there is certainly a
interference possible if the memory is somehow pinned - e.g. mlock - by
a task from another cgroup or internally by FS.

Your earlier stat snapshot doesn't indicate a big problem with the
reclaim though:

memory.stat:pgscan 47519855
memory.stat:pgsteal 44933838

This tells the overall reclaim effectiveness was 94%. Could you try to
gather snapshots with a 1s granularity starting before your run your
backup to see how those numbers evolve? Ideally with timestamps to
compare with the actual stall information.

Another option would be to enable vmscan tracepoints but let's try with
stats first.
-- 
Michal Hocko
SUSE Labs
