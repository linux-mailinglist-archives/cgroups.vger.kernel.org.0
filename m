Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB57507B
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 16:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbfGYOBT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 10:01:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387876AbfGYOBT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Jul 2019 10:01:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0CE7AFF9;
        Thu, 25 Jul 2019 14:01:17 +0000 (UTC)
Date:   Thu, 25 Jul 2019 16:01:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     cgroups@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
Subject: Re: No memory reclaim while reaching MemoryHigh
Message-ID: <20190725140117.GC3582@dhcp22.suse.cz>
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-07-19 15:17:17, Stefan Priebe - Profihost AG wrote:
> Hello all,
> 
> i hope i added the right list and people - if i missed someone i would
> be happy to know.
> 
> While using kernel 4.19.55 and cgroupv2 i set a MemoryHigh value for a
> varnish service.
> 
> It happens that the varnish.service cgroup reaches it's MemoryHigh value
> and stops working due to throttling.

What do you mean by "stops working"? Does it mean that the process is
stuck in the kernel doing the reclaim? /proc/<pid>/stack would tell you
what the kernel executing for the process.
 
> But i don't understand is that the process itself only consumes 40% of
> it's cgroup usage.
> 
> So the other 60% is dirty dentries and inode cache. If i issue an
> echo 3 > /proc/sys/vm/drop_caches
> 
> the varnish cgroup memory usage drops to the 50% of the pure process.
> 
> I thought that the kernel would trigger automatic memory reclaim if a
> cgroup reaches is memory high value to drop caches.

Yes, that is indeed the case and the kernel memory (e.g. inodes/dentries
and others) should be reclaim on the way. Maybe it is harder for the
reclaim to get rid of those than drop_caches. We need more data.
-- 
Michal Hocko
SUSE Labs
