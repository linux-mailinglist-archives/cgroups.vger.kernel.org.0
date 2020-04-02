Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3619B9D3
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2020 03:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbgDBBXI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Apr 2020 21:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732462AbgDBBXI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 Apr 2020 21:23:08 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA5A20675;
        Thu,  2 Apr 2020 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585790587;
        bh=/XWfr8B2+Gdq9aBiaTze7oFSffBCOQXALgeP7OSUoQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M+kfbZ9UrQu3G+ELPmQ1UpQH6jzItlc6P2SWjstji9UaUSHoI42uhLz0GCrHwnyx/
         ZwI8RIGgcPMexnOXuBDWj4+S+SxyZPVlNjjQ0mkCAeQ4t7v7YUjvLhrUdv5sSQOl4I
         vy4yB6xaC3seVhG8xKwbIV0+jkhCZBTUuL4EW8tc=
Date:   Wed, 1 Apr 2020 18:23:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm, memcg: Bypass high reclaim iteration for cgroup
 hierarchy root
Message-Id: <20200401182306.724698b74692b5d31f66ad10@linux-foundation.org>
In-Reply-To: <20200312164137.GA1753625@chrisdown.name>
References: <20200312164137.GA1753625@chrisdown.name>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 12 Mar 2020 16:41:37 +0000 Chris Down <chris@chrisdown.name> wrote:

> The root of the hierarchy cannot have high set, so we will never reclaim
> based on it. This makes that clearer and avoids another entry.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2232,7 +2232,8 @@ static void reclaim_high(struct mem_cgroup *memcg,
>  			continue;
>  		memcg_memory_event(memcg, MEMCG_HIGH);
>  		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
> -	} while ((memcg = parent_mem_cgroup(memcg)));
> +	} while ((memcg = parent_mem_cgroup(memcg)) &&
> +		 !mem_cgroup_is_root(memcg));
>  }
>  
>  static void high_work_func(struct work_struct *work)

Does someone have time to review this one?

Thanks.
