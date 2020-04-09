Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46BC1A3754
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgDIPko convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 9 Apr 2020 11:40:44 -0400
Received: from smtprelay.restena.lu ([158.64.1.62]:44588 "EHLO
        smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgDIPko (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 11:40:44 -0400
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:12::4])
        by smtprelay.restena.lu (Postfix) with ESMTPS id AE53F40FB0;
        Thu,  9 Apr 2020 17:40:42 +0200 (CEST)
Date:   Thu, 9 Apr 2020 17:40:42 +0200
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409174042.2a3389ba@hemera.lan.sysophe.eu>
In-Reply-To: <20200409152417.GB1040020@chrisdown.name>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
        <20200409094615.GE18386@dhcp22.suse.cz>
        <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
        <20200409103400.GF18386@dhcp22.suse.cz>
        <20200409170926.182354c3@hemera.lan.sysophe.eu>
        <20200409152417.GB1040020@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 9 Apr 2020 16:24:17 +0100 wrote:

> Bruno Prémont writes:
> >Could it be that cache is being prevented from being reclaimed by a task
> >in another cgroup?
> >
> >e.g.
> >  cgroup/system/backup
> >    first reads $files (reads each once)
> >  cgroup/workload/bla
> >    second&more reads $files
> >
> >Would $files remain associated to cgroup/system/backup and not
> >reclaimed there instead of being reassigned to cgroup/workload/bla?  
> 
> Yes, that's entirely possible. The first cgroup to fault in the pages is 
> charged for the memory. Other cgroups may use them, but they are not accounted 
> for as part of that other cgroup. They may also still be "active" as a result 
> of use by another cgroup.

But the memory would then be 'active' in the original cgroup? which is
not the case here I feel.
If the remain inactive-unreclaimable in the first cgroup due to use in
another cgroup that would be at least surprising.

Doubling the high value helped (but for how long?), back with
memory.current around memory.high nut no throttling yet. But from
increase until now memory.pressure is small/zero.

Capturing 
  memory.stat:pgscan 47519855
  memory.stat:pgsteal 44933838
over time for Michal and will report back later this evening.

When seen stuck backup was reading a multi-GiB file with
  open(, O_NOATIME)
  while (read()) {
    transform and write to network
  }
  close()
thus plain sequential file read through file cache (and for this
backup run, only files not in use by anyone else, or some being
just appended to by others).

Bruno
