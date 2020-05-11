Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345921CD425
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEKIjJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 04:39:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43099 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgEKIjI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 04:39:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id i15so9768459wrx.10;
        Mon, 11 May 2020 01:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FvpNgO4al8rrIK8WSxp3SMkvIJuIwqja3bw4ZHXrWYo=;
        b=DZ7y9GD/uWfDBMGXE54tn34B/hWDIVuipJNK9NJre0yPYXM4VxCWvsTCq7KoJX3a8d
         JXwnmVvxwT7/STOua+9BGbIa6qOr8nHUzNrClpwYsCEaV6Cm1w5wT02DA1jiAAh0+i/i
         6G3Eex7M2wO5vQID7DmSpdT9tGXY47D+ypFubOXywwYRqr7w5vwjWwEQetmuN7gObqmH
         xI4vqL/30HeyL8VdMAPIt8fp7Wap4ItXdN1Uqcz9CtSguAS9ms8uGTdI0LbVxwbc3SzI
         EZBbBa0NkX4DU8RuxB+jBL9AB0fscUkZzVvdruG22K9x8iT87oRCM+TXXn3BruxTon/X
         b9Ug==
X-Gm-Message-State: AGi0PuZqQDIhZphRrtxWArbKYYjTGCuS0idd1GTqCh0e0SmuGMCEQfyj
        E20qeP326qpP7Xfp+q/1fvciDj9+
X-Google-Smtp-Source: APiQypIQpwTFkabbZL1uF+YtruIWqkdDkGAaVl3JWB4S4P9pWHgVyfF5FMY7zlh26GTwUoVsZH0JPQ==
X-Received: by 2002:a5d:61c3:: with SMTP id q3mr15869696wrv.405.1589186346279;
        Mon, 11 May 2020 01:39:06 -0700 (PDT)
Received: from localhost (ip-37-188-228-19.eurotel.cz. [37.188.228.19])
        by smtp.gmail.com with ESMTPSA id n7sm7415677wro.94.2020.05.11.01.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 01:39:05 -0700 (PDT)
Date:   Mon, 11 May 2020 10:39:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] doc: cgroup: update note about conditions when oom
 killer is invoked
Message-ID: <20200511083904.GB29153@dhcp22.suse.cz>
References: <158894738928.208854.5244393925922074518.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158894738928.208854.5244393925922074518.stgit@buzz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 08-05-20 17:16:29, Konstantin Khlebnikov wrote:
> Starting from v4.19 commit 29ef680ae7c2 ("memcg, oom: move out_of_memory
> back to the charge path") cgroup oom killer is no longer invoked only from
> page faults. Now it implements the same semantics as global OOM killer:
> allocation context invokes OOM killer and keeps retrying until success.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/cgroup-v2.rst |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index bcc80269bb6a..1bb9a8f6ebe1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1172,6 +1172,13 @@ PAGE_SIZE multiple when read back.
>  	Under certain circumstances, the usage may go over the limit
>  	temporarily.
>  
> +	In default configuration regular 0-order allocation always
> +	succeed unless OOM killer choose current task as a victim.
> +
> +	Some kinds of allocations don't invoke the OOM killer.
> +	Caller could retry them differently, return into userspace
> +	as -ENOMEM or silently ignore in cases like disk readahead.

I would probably add -EFAULT but the less error codes we document the
better.

> +
>  	This is the ultimate protection mechanism.  As long as the
>  	high limit is used and monitored properly, this limit's
>  	utility is limited to providing the final safety net.
> @@ -1228,17 +1235,9 @@ PAGE_SIZE multiple when read back.
>  		The number of time the cgroup's memory usage was
>  		reached the limit and allocation was about to fail.
>  
> -		Depending on context result could be invocation of OOM
> -		killer and retrying allocation or failing allocation.
> -
> -		Failed allocation in its turn could be returned into
> -		userspace as -ENOMEM or silently ignored in cases like
> -		disk readahead.  For now OOM in memory cgroup kills
> -		tasks iff shortage has happened inside page fault.
> -
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order
> -		allocations.
> +		allocations or if caller asked to not retry attempts.
>  
>  	  oom_kill
>  		The number of processes belonging to this cgroup

-- 
Michal Hocko
SUSE Labs
