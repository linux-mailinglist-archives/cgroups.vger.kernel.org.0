Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15EF268834
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgINJXR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 05:23:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgINJXP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Sep 2020 05:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68DCEB23C;
        Mon, 14 Sep 2020 09:23:29 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:23:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the buf returned by
 memory_stat_format
Message-ID: <20200914092313.GF16999@dhcp22.suse.cz>
References: <20200912155100.25578-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912155100.25578-1-songmuchun@bytedance.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 12-09-20 23:51:00, Muchun Song wrote:
> The memory_stat_format() returns a format string, but the return buf
> may not including the trailing '\0'. So the users may read the buf
> out of bounds.
> 
> Fixes: c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup OOM")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I would argue that Fixes tag is not appropriate. As already pointed in
other email. There doesn't seem to be any problem currently.

I agree that having the code more robust is reasonable but I am not sure
this patch is the proper answer for that. We do not want to cut the
output as that might confuse userspace consumers. The proper way to
handle this is to flush the content that fits in and process the rest
after that or have a larger buffer.

> ---
>  mm/memcontrol.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f2ef9a770eeb..20c8a1080074 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1492,12 +1492,13 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> -static char *memory_stat_format(struct mem_cgroup *memcg)
> +static const char *memory_stat_format(struct mem_cgroup *memcg)
>  {
>  	struct seq_buf s;
>  	int i;
>  
> -	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> +	/* Reserve a byte for the trailing null */
> +	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
>  	if (!s.buffer)
>  		return NULL;
>  
> @@ -1606,7 +1607,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  	/* The above should easily fit into one page */
> -	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
> +	if (WARN_ON_ONCE(seq_buf_putc(&s, '\0')))
> +		s.buffer[PAGE_SIZE - 1] = '\0';
>  
>  	return s.buffer;
>  }
> @@ -1644,7 +1646,7 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
>   */
>  void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
> -	char *buf;
> +	const char *buf;
>  
>  	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
>  		K((u64)page_counter_read(&memcg->memory)),
> @@ -6415,7 +6417,7 @@ static int memory_events_local_show(struct seq_file *m, void *v)
>  static int memory_stat_show(struct seq_file *m, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	char *buf;
> +	const char *buf;
>  
>  	buf = memory_stat_format(memcg);
>  	if (!buf)
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
