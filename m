Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C371EAD4D8
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfIII1f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 04:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:39134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfIII1e (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Sep 2019 04:27:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30C9AB04C;
        Mon,  9 Sep 2019 08:27:33 +0000 (UTC)
Date:   Mon, 9 Sep 2019 10:27:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190909082732.GC27159@dhcp22.suse.cz>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 06-09-19 12:08:31, Stefan Priebe - Profihost AG wrote:
> These are the biggest differences in meminfo before and after cached
> starts to drop. I didn't expect cached end up in MemFree.
> 
> Before:
> MemTotal:       16423116 kB
> MemFree:          374572 kB
> MemAvailable:    5633816 kB
> Cached:          5550972 kB
> Inactive:        4696580 kB
> Inactive(file):  3624776 kB
> 
> 
> After:
> MemTotal:       16423116 kB
> MemFree:         3477168 kB
> MemAvailable:    6066916 kB
> Cached:          2724504 kB
> Inactive:        1854740 kB
> Inactive(file):   950680 kB
> 
> Any explanation?

Do you have more snapshots of /proc/vmstat as suggested by Vlastimil and
me earlier in this thread? Seeing the overall progress would tell us
much more than before and after. Or have I missed this data?

-- 
Michal Hocko
SUSE Labs
