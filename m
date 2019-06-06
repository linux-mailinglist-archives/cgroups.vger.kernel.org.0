Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FBD37291
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfFFLOy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 07:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfFFLOy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 6 Jun 2019 07:14:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F722AE78;
        Thu,  6 Jun 2019 11:14:52 +0000 (UTC)
Date:   Thu, 6 Jun 2019 13:14:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: dump memory.stat during cgroup OOM
Message-ID: <20190606111446.GA15779@dhcp22.suse.cz>
References: <20190604210509.9744-1-hannes@cmpxchg.org>
 <20190605120837.GE15685@dhcp22.suse.cz>
 <20190605161133.GA12453@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605161133.GA12453@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 05-06-19 12:11:33, Johannes Weiner wrote:
> On Wed, Jun 05, 2019 at 02:08:37PM +0200, Michal Hocko wrote:
[...]
> > I am not entirely happy with that many lines in the oom report though. I
> > do see that you are trying to reduce code duplication which is fine but
> > would it be possible to squeeze all of these counters on a single line?
> > The same way we do for the global OOM report?
> 
> TBH I really hate those in the global reports because I always
> struggle to find what I'm looking for. And smoking guns don't stand
> out visually either. I'd rather have newlines there as well.

This is obviously a matter of taste. I do not remember anybody
complaining about the data density for the global oom reports.
The amount of data is essentially the same so so there is no real
technical argument one way or another.

That being said, I still do not like the per line stats but I do not
think this is a strong enough matter to argue about. The missing
counters are interesting for oom reports analysis so the patch is
an improvement. If you really do see it important then I will not stand
in the way. One way or another feel free to add

Acked-by: Michal Hocko <mhocko@suse.com>
 
> > > +	seq_buf_init(&s, kvmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> > 
> > What is the reason to use kvmalloc here? It doesn't make much sense to
> > me to use it for the page size allocation TBH.
> 
> Oh, good spot. I first did something similar to seq_file.c with an
> auto-resizing buffer in case we print too much data. Then decided
> that's silly since everything that will print into the buffer is right
> there, and it's obvious that it'll fit, so I did the fixed allocation
> and the WARN_ON instead.

I've had a suspicion something like that happened. In any case using
kvmalloc wouldn't be a bug. It would just be weird because we do not
even fall back to vmalloc for this size IIRC.
> 
> How about a simple kmalloc?. I know it's a page sized buffer, but the
> gfp interface seems a bit too low-level and has weird kinks that
> kmalloc nicely abstracts into a sane memory allocation interface, with
> kmemleak support and so forth...

Yeah, using kmalloc is fine.

> Thanks for your review.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0907a96ceddf..b0e0e840705d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1371,7 +1371,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	struct seq_buf s;
>  	int i;
>  
> -	seq_buf_init(&s, kvmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> +	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
>  	if (!s.buffer)
>  		return NULL;
>  
> @@ -1533,7 +1533,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  	if (!buf)
>  		return;
>  	pr_info("%s", buf);
> -	kvfree(buf);
> +	kfree(buf);
>  }
>  
>  /*
> @@ -5775,7 +5775,7 @@ static int memory_stat_show(struct seq_file *m, void *v)
>  	if (!buf)
>  		return -ENOMEM;
>  	seq_puts(m, buf);
> -	kvfree(buf);
> +	kfree(buf);
>  	return 0;
>  }
>  

-- 
Michal Hocko
SUSE Labs
