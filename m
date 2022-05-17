Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA37529953
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 08:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiEQGLo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiEQGLm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 02:11:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4C427D2;
        Mon, 16 May 2022 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x5NJr3XZ+BJ2T8T7+JQpl5n0Xp+Zx4jXbGyEy7Vm2Js=; b=R/bR1d7meoEYsDHfNS8gKqtjaS
        7SRHE25W7Cox+EV5i6LZpeAbP0tUpdtyCcxc5VMviabaVCdmSHH0WW+CC/lhQ8Lj0nGbjNlhO0AyU
        J1tXiqtowAoPQi2kHUe8VxNlZ6nDIylRaWUekAbVJSZGL6G0f3O4m9vBnw+8L9acKeffb2BDDCbSV
        Dw/VJ68g5u1au7PiNj49rfTTOtrRryU8MTzQaW6rdk0kLKRHqixbJ0MehVJSJlogu4tiydnGRe33O
        /3iaccDr6ZdwzUEJgVc+RDoY4YpnGqNcSLe41yLnooo2+Fy51F6Az5wUPvYGtd038SzpVbtwZzSvB
        1Ou4+GrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqqQl-00BmG7-A2; Tue, 17 May 2022 06:11:39 +0000
Date:   Mon, 16 May 2022 23:11:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PATCH v3] blk-cgroup: always terminate io.stat lines
Message-ID: <YoM8mzAPD6xeOVwD@infradead.org>
References: <20220111083159.42340-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111083159.42340-1-w.bumiller@proxmox.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ping?  Seems like this never made it in.

On Tue, Jan 11, 2022 at 09:31:59AM +0100, Wolfgang Bumiller wrote:
> With the removal of seq_get_buf in blkcg_print_one_stat, we
> cannot make adding the newline conditional on there being
> relevant stats because the name was already written out
> unconditionally.
> Otherwise we may end up with multiple device names in one
> line which is confusing and doesn't follow the nested-keyed
> file format.
> 
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")
> ---
> Changes to v2:
> * Fix `iolatency_ssd_stat` return type bool -> void
>   I was building with CONFIG_BLK_CGROUP_IOLATENCY=n, thankfully the
>   kernel test robot noticed it.
> 
> Link to v2: https://lore.kernel.org/all/20220110153457.5894-1-w.bumiller@proxmox.com/
> Link to v1: https://lore.kernel.org/all/20220110103724.11743-1-w.bumiller@proxmox.com/
> 
> Changes in v2:
> * Address the warning about `has_stats` being unused now (sorry about
>   that, built it as part of a package and missed that looked too trivial...)
> * `pd_stat_fn` now returns `void`
> 
> Original v1 note:
> 
> I also switched to `seq_puts` as suggested by `checkpatch.pl`
> 
> This seemed like the simplest approach, so I thought I'd
> send a patch.
> 
> On my physical machine, creating a new thin lv and starting
> a container on it created lines such as
> 
>     253:10 253:5 rbytes=0 wbytes=0 rios=0 wios=1 dbytes=0 dios=0
>     ^~~~~~ ^~~~~
> 
> This *looks* like the devices might just happen to have the
> same stats, but that's not the case (and doesn't follow the
> documented format).
> 
> With this patch this becomes:
> 
>     253:10
>     253:5 rbytes=0 wbytes=0 rios=0 wios=1 dbytes=0 dios=0
> 
> Let me know if you prefer a different solution. I'm not sure
> a temporary buffer that can be discarded would be much
> better than the previous seq_get_buf() version. Otherwise
> we'd need to change the `pd_stat_fn` interface to collect
> the data separately and do the formatting afterwards I
> suppose?
> 
> 
>  block/blk-cgroup.c         | 9 ++-------
>  block/blk-iocost.c         | 5 ++---
>  block/blk-iolatency.c      | 8 +++-----
>  include/linux/blk-cgroup.h | 2 +-
>  4 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 663aabfeba18..48e98c31a3d6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -888,7 +888,6 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  {
>  	struct blkg_iostat_set *bis = &blkg->iostat;
>  	u64 rbytes, wbytes, rios, wios, dbytes, dios;
> -	bool has_stats = false;
>  	const char *dname;
>  	unsigned seq;
>  	int i;
> @@ -914,14 +913,12 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  	} while (u64_stats_fetch_retry(&bis->sync, seq));
>  
>  	if (rbytes || wbytes || rios || wios) {
> -		has_stats = true;
>  		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
>  			rbytes, wbytes, rios, wios,
>  			dbytes, dios);
>  	}
>  
>  	if (blkcg_debug_stats && atomic_read(&blkg->use_delay)) {
> -		has_stats = true;
>  		seq_printf(s, " use_delay=%d delay_nsec=%llu",
>  			atomic_read(&blkg->use_delay),
>  			atomic64_read(&blkg->delay_nsec));
> @@ -933,12 +930,10 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  		if (!blkg->pd[i] || !pol->pd_stat_fn)
>  			continue;
>  
> -		if (pol->pd_stat_fn(blkg->pd[i], s))
> -			has_stats = true;
> +		pol->pd_stat_fn(blkg->pd[i], s);
>  	}
>  
> -	if (has_stats)
> -		seq_printf(s, "\n");
> +	seq_puts(s, "\n");
>  }
>  
>  static int blkcg_print_stat(struct seq_file *sf, void *v)
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 769b64394298..b4f1b7c1a965 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2995,13 +2995,13 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
>  	kfree(iocg);
>  }
>  
> -static bool ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
> +static void ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  {
>  	struct ioc_gq *iocg = pd_to_iocg(pd);
>  	struct ioc *ioc = iocg->ioc;
>  
>  	if (!ioc->enabled)
> -		return false;
> +		return;
>  
>  	if (iocg->level == 0) {
>  		unsigned vp10k = DIV64_U64_ROUND_CLOSEST(
> @@ -3017,7 +3017,6 @@ static bool ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  			iocg->last_stat.wait_us,
>  			iocg->last_stat.indebt_us,
>  			iocg->last_stat.indelay_us);
> -	return true;
>  }
>  
>  static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 6593c7123b97..2a0e0f34a1e1 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -891,7 +891,7 @@ static int iolatency_print_limit(struct seq_file *sf, void *v)
>  	return 0;
>  }
>  
> -static bool iolatency_ssd_stat(struct iolatency_grp *iolat, struct seq_file *s)
> +static void iolatency_ssd_stat(struct iolatency_grp *iolat, struct seq_file *s)
>  {
>  	struct latency_stat stat;
>  	int cpu;
> @@ -914,17 +914,16 @@ static bool iolatency_ssd_stat(struct iolatency_grp *iolat, struct seq_file *s)
>  			(unsigned long long)stat.ps.missed,
>  			(unsigned long long)stat.ps.total,
>  			iolat->rq_depth.max_depth);
> -	return true;
>  }
>  
> -static bool iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
> +static void iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  {
>  	struct iolatency_grp *iolat = pd_to_lat(pd);
>  	unsigned long long avg_lat;
>  	unsigned long long cur_win;
>  
>  	if (!blkcg_debug_stats)
> -		return false;
> +		return;
>  
>  	if (iolat->ssd)
>  		return iolatency_ssd_stat(iolat, s);
> @@ -937,7 +936,6 @@ static bool iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  	else
>  		seq_printf(s, " depth=%u avg_lat=%llu win=%llu",
>  			iolat->rq_depth.max_depth, avg_lat, cur_win);
> -	return true;
>  }
>  
>  static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp,
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index b4de2010fba5..132e05ed6935 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -152,7 +152,7 @@ typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_free_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_reset_pd_stats_fn)(struct blkg_policy_data *pd);
> -typedef bool (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd,
> +typedef void (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd,
>  				struct seq_file *s);
>  
>  struct blkcg_policy {
> -- 
> 2.30.2
> 
> 
---end quoted text---
