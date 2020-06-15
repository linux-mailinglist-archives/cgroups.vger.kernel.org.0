Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B51F9B46
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2020 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgFOPBf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Jun 2020 11:01:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32962 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbgFOPBe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Jun 2020 11:01:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id j198so217256wmj.0;
        Mon, 15 Jun 2020 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5qvOg57UADgLzf+akmZ9rdaUG21I31nx25QubBlwmU=;
        b=GJQh/VJKFKAKo32UkCmm1AsUJKDfzKS8R5gkpAT7LGjZc+m+uLoNQdh38qtMOJBwhB
         ltEUy99rwEB4nx1OBW1nLvh6f0yW9BfCM9hX28erFG3OwHcO0pC16kiazKWGo6lZfELd
         OzvO/i1hG39hpjlvhoot6fNuW7gjSauZn8m0xRTGYbWw7/DX9k0/fZjCVVleF3p8qOeL
         AHsMwCiasQRcLuSGCQ8Rg+6rHmjQjewi4rKgQli9/O8rO7Y1Rhzn/+VKrCOn7c7mdQuu
         ImiJm0SYrc549bqgDGdGGULrNrUFXuV+Ek1jDKaWAwgn9R66KNa0vWaP8Cr9OVj1iTyz
         FM4A==
X-Gm-Message-State: AOAM530+E6W168TcMFq2xxdh9bkLNmuLzKEPpDqHXvc64slTkaJWNH1a
        i3XVEGZ7DiVvCELzsZLgQKk=
X-Google-Smtp-Source: ABdhPJy9VSpz3kEOLPJzTJYggxYQ0jplJOLKluJZv/AfUmoOv+0rtrfCSC4WAqGA4V1CHa6ojpRzKQ==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr12771377wmm.108.1592233291158;
        Mon, 15 Jun 2020 08:01:31 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id d9sm24638967wre.28.2020.06.15.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:01:29 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:01:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: handle div0 crash race condition in
 memory.low
Message-ID: <20200615150128.GL25296@dhcp22.suse.cz>
References: <20200615140658.601684-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615140658.601684-1-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 15-06-20 10:06:58, Johannes Weiner wrote:
> Tejun reports seeing rare div0 crashes in memory.low stress testing:
> 
> [37228.504582] RIP: 0010:mem_cgroup_calculate_protection+0xed/0x150
> [37228.505059] Code: 0f 46 d1 4c 39 d8 72 57 f6 05 16 d6 42 01 40 74 1f 4c 39 d8 76 1a 4c 39 d1 76 15 4c 29 d1 4c 29 d8 4d 29 d9 31 d2 48 0f af c1 <49> f7 f1 49 01 c2 4c 89 96 38 01 00 00 5d c3 48 0f af c7 31 d2 49
> [37228.506254] RSP: 0018:ffffa14e01d6fcd0 EFLAGS: 00010246
> [37228.506769] RAX: 000000000243e384 RBX: 0000000000000000 RCX: 0000000000008f4b
> [37228.507319] RDX: 0000000000000000 RSI: ffff8b89bee84000 RDI: 0000000000000000
> [37228.507869] RBP: ffffa14e01d6fcd0 R08: ffff8b89ca7d40f8 R09: 0000000000000000
> [37228.508376] R10: 0000000000000000 R11: 00000000006422f7 R12: 0000000000000000
> [37228.508881] R13: ffff8b89d9617000 R14: ffff8b89bee84000 R15: ffffa14e01d6fdb8
> [37228.509397] FS:  0000000000000000(0000) GS:ffff8b8a1f1c0000(0000) knlGS:0000000000000000
> [37228.509917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [37228.510442] CR2: 00007f93b1fc175b CR3: 000000016100a000 CR4: 0000000000340ea0
> [37228.511076] Call Trace:
> [37228.511561]  shrink_node+0x1e5/0x6c0
> [37228.512044]  balance_pgdat+0x32d/0x5f0
> [37228.512521]  kswapd+0x1d7/0x3d0
> [37228.513346]  ? wait_woken+0x80/0x80
> [37228.514170]  kthread+0x11c/0x160
> [37228.514983]  ? balance_pgdat+0x5f0/0x5f0
> [37228.515797]  ? kthread_park+0x90/0x90
> [37228.516593]  ret_from_fork+0x1f/0x30
> 
> This happens when parent_usage == siblings_protected. We check that
> usage is bigger than protected, which should imply parent_usage being
> bigger than siblings_protected. However, we don't read (or even
> update) these values atomically, and they can be out of sync as the
> memory state changes under us. A bit of fluctuation around the target
> protection isn't a big deal, but we need to handle the div0 case.
> 
> Check the parent state explicitly to make sure we have a reasonable
> positive value for the divisor.
> 
> Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
> Reported-by: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b38b6ad547d..5de0a9035b5f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6360,11 +6360,16 @@ static unsigned long effective_protection(unsigned long usage,
>  	 * We're using unprotected memory for the weight so that if
>  	 * some cgroups DO claim explicit protection, we don't protect
>  	 * the same bytes twice.
> +	 *
> +	 * Check both usage and parent_usage against the respective
> +	 * protected values. One should imply the other, but they
> +	 * aren't read atomically - make sure the division is sane.
>  	 */
>  	if (!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT))
>  		return ep;
> -
> -	if (parent_effective > siblings_protected && usage > protected) {
> +	if (parent_effective > siblings_protected &&
> +	    parent_usage > siblings_protected &&
> +	    usage > protected) {
>  		unsigned long unclaimed;
>  
>  		unclaimed = parent_effective - siblings_protected;
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
