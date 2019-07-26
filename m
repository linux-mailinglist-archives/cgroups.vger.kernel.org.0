Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1125B7600B
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2019 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGZHp7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Jul 2019 03:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfGZHp7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 26 Jul 2019 03:45:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD504AD18;
        Fri, 26 Jul 2019 07:45:57 +0000 (UTC)
Date:   Fri, 26 Jul 2019 09:45:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     cgroups@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
Subject: Re: No memory reclaim while reaching MemoryHigh
Message-ID: <20190726074557.GF6142@dhcp22.suse.cz>
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
 <20190725140117.GC3582@dhcp22.suse.cz>
 <028ff462-b547-b9a5-bdb0-e0de3a884afd@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028ff462-b547-b9a5-bdb0-e0de3a884afd@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-07-19 23:37:14, Stefan Priebe - Profihost AG wrote:
> Hi Michal,
> 
> Am 25.07.19 um 16:01 schrieb Michal Hocko:
> > On Thu 25-07-19 15:17:17, Stefan Priebe - Profihost AG wrote:
> >> Hello all,
> >>
> >> i hope i added the right list and people - if i missed someone i would
> >> be happy to know.
> >>
> >> While using kernel 4.19.55 and cgroupv2 i set a MemoryHigh value for a
> >> varnish service.
> >>
> >> It happens that the varnish.service cgroup reaches it's MemoryHigh value
> >> and stops working due to throttling.
> > 
> > What do you mean by "stops working"? Does it mean that the process is
> > stuck in the kernel doing the reclaim? /proc/<pid>/stack would tell you
> > what the kernel executing for the process.
> 
> The service no longer responses to HTTP requests.
> 
> stack switches in this case between:
> [<0>] io_schedule+0x12/0x40
> [<0>] __lock_page_or_retry+0x1e7/0x4e0
> [<0>] filemap_fault+0x42f/0x830
> [<0>] __xfs_filemap_fault.constprop.11+0x49/0x120
> [<0>] __do_fault+0x57/0x108
> [<0>] __handle_mm_fault+0x949/0xef0
> [<0>] handle_mm_fault+0xfc/0x1f0
> [<0>] __do_page_fault+0x24a/0x450
> [<0>] do_page_fault+0x32/0x110
> [<0>] async_page_fault+0x1e/0x30
> [<0>] 0xffffffffffffffff
> 
> and
> 
> [<0>] poll_schedule_timeout.constprop.13+0x42/0x70
> [<0>] do_sys_poll+0x51e/0x5f0
> [<0>] __x64_sys_poll+0xe7/0x130
> [<0>] do_syscall_64+0x5b/0x170
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [<0>] 0xffffffffffffffff

Neither of the two seem to be memcg related. Have you tried to get
several snapshots and see if the backtrace is stable? strace would also
tell you whether your application is stuck in a single syscall or they
are just progressing very slowly (-ttt parameter should give you timing)
-- 
Michal Hocko
SUSE Labs
