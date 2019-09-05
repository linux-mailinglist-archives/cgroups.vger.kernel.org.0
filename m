Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816C4AA1AD
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbfIELkY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 07:40:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:52510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730753AbfIELkY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 5 Sep 2019 07:40:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 329E9AF05;
        Thu,  5 Sep 2019 11:40:23 +0000 (UTC)
Date:   Thu, 5 Sep 2019 13:40:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190905114022.GH3838@dhcp22.suse.cz>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 05-09-19 13:27:10, Stefan Priebe - Profihost AG wrote:
> Hello all,
> 
> i hope you can help me again to understand the current MemAvailable
> value in the linux kernel. I'm running a 4.19.52 kernel + psi patches in
> this case.
> 
> I'm seeing the following behaviour i don't understand and ask for help.
> 
> While MemAvailable shows 5G the kernel starts to drop cache from 4G down
> to 1G while the apache spawns some PHP processes. After that the PSI
> mem.some value rises and the kernel tries to reclaim memory but
> MemAvailable stays at 5G.
> 
> Any ideas?

Can you collect /proc/vmstat (every second or so) and post it while this
is the case please?
-- 
Michal Hocko
SUSE Labs
