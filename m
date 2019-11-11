Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA6EF771C
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKKOx4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 09:53:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:54996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKKOx4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 Nov 2019 09:53:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2ACDB11B;
        Mon, 11 Nov 2019 14:53:54 +0000 (UTC)
Date:   Mon, 11 Nov 2019 15:53:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] docs: cgroup: mm: Document why inactive_X + active_X may
 not equal X
Message-ID: <20191111145354.GN1396@dhcp22.suse.cz>
References: <20191111144958.GA11914@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111144958.GA11914@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-11-19 14:49:58, Chris Down wrote:
> This has confused a significant number of people using cgroups inside
> Facebook, and some of those outside as well judging by posts like
> this[0] (although it's not a problem unique to cgroup v2). If shmem
> handling in particular becomes more coherent at some point in the future
> -- although that seems unlikely now -- we can change the wording here.
> 
> [0]: https://unix.stackexchange.com/q/525092/10762
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/cgroup-v2.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 0704552ed94f..0636bcb60b5a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1289,7 +1289,12 @@ PAGE_SIZE multiple when read back.
>  	  inactive_anon, active_anon, inactive_file, active_file, unevictable
>  		Amount of memory, swap-backed and filesystem-backed,
>  		on the internal memory management lists used by the
> -		page reclaim algorithm
> +		page reclaim algorithm.
> +
> +		As these represent internal list state (eg. shmem pages are on anon
> +		memory management lists), inactive_foo + active_foo may not be equal to

and anon will move to file list after MADV_FREE.

> +		the value for the foo counter, since the foo counter is type-based, not
> +		list-based.
>  
>  	  slab_reclaimable
>  		Part of "slab" that might be reclaimed, such as
> -- 
> 2.24.0

-- 
Michal Hocko
SUSE Labs
