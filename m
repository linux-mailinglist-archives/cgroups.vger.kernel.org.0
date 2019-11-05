Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46492EF567
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 07:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfKEGKC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Nov 2019 01:10:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:39870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387454AbfKEGKC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 5 Nov 2019 01:10:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75FB4B160;
        Tue,  5 Nov 2019 06:10:00 +0000 (UTC)
Date:   Tue, 5 Nov 2019 07:09:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
Message-ID: <20191105060959.GA22672@dhcp22.suse.cz>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 02-11-19 18:16:33, Konstantin Khlebnikov wrote:
> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
> charge path") memcg invokes oom killer not only for user page-faults.
> This means 0-order allocation will either succeed or task get killed.
> 
> Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")

Is this really appropriate? 8e675f7af507 was correct at the time. It was
29ef680ae7c2 that hasn't updated the documentation. I would just drop
the Fixes tag.

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5361ebec3361..eb47815e137b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
>  
>  		Failed allocation in its turn could be returned into
>  		userspace as -ENOMEM or silently ignored in cases like
> -		disk readahead.  For now OOM in memory cgroup kills
> -		tasks iff shortage has happened inside page fault.
> +		disk readahead.
> +
> +		Before 4.19 OOM in memory cgroup killed tasks iff

I would go with Kernels between 3.12 and 4.19 invoked the oom killer
only if shortage has happened inside page fault.

> +		shortage has happened inside page fault, random
> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
> +		failed memory cgroup allocation invokes oom killer and
> +		keeps retrying until it succeeds.
>  
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order

-- 
Michal Hocko
SUSE Labs
