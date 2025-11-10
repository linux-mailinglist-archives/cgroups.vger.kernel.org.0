Return-Path: <cgroups+bounces-11723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74511C46443
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DF418944E3
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CB3093D8;
	Mon, 10 Nov 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RQZyaX4Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8222538F
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774116; cv=none; b=B5mxTQNHMGHQUFIrM9zOB3CfYBSo9TLCawCYVMyJpmzUGwhROnIUgn4BX0PJLtPPAtcXeSibMElx3GIwVt7mJp7IbFrncgklmbRdCSi5pIAVk4oK2jBzjp785rWFEdLB43rAChz6tOk5Yp1AqoyVP/RJPiq7WIdLgZS25yBCP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774116; c=relaxed/simple;
	bh=MZT+DALqR0VA23k2/UQYcdkIsnV3TTgNY/WYhrIbVOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWiD3N9JGN9V1Zoyq9pCnF5jgyPdPGs7TeH3LSJkgc5Pu5+MprbT+Szo7oxEMrekZZIWEUvgAg9xNeoyudyiSKF3o/DYRxXyjgjLUqMklvkvWwpcE8ItctB75oY19PgOmkrNJLenB0fugEm1elFIMliS8TtDermDR5EVfAOTZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RQZyaX4Q; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72bf7e703fso518524866b.2
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762774112; x=1763378912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csQWI5jqus0ZWRL/iU5hav/pk5IdN2xcgvPAVhT7DnE=;
        b=RQZyaX4QlE2hXmuzHMRXifbESQOdGfFFirPzDVqzkS8fGt7pzBkMDs9RE3Xr7vcN0l
         BfnTX4wVJoZkqWiIkOT9qiYEb2OOqY8pYlmbgpaBJkBhqHkmAsfxDnO7jHJd/7xtw9Cx
         Ip65EWIEfq8qN+Qa4nPDs1r5+2Ty0Rv1RaybTLqHd3k9Ena0dGXwbDpG93GPiQ14H0sW
         TGxKPCnAR7l6exJDslGL/siobykIMqY5OxT7rdDPcwwCSvXvS7l8Cz1Y9HCmV3IJFqxR
         EkLdT3z3C7/WsZimlPbYQ7Gj0F49vX4WO2MQzyoPPHHVa2CdO5QkK9jpNVtLUGnkJqqj
         TP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774112; x=1763378912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csQWI5jqus0ZWRL/iU5hav/pk5IdN2xcgvPAVhT7DnE=;
        b=Zrv4vpdHrf2s3IlWhSn4tEKSuRtKAcjRgjS0XajBTDe/xS4gihFhhOYJpyjGjXR/hE
         PRadpvdpNB27Nikk/Nks9uN0JlT5qz5e+OGliD1UJf0uKQQ68hQIFRCLiF3aIKrI1iR0
         XE74XMSXZNNGcTblKEJElSzfSqIE4qu8W5ImNWy7rX3rrHkrFT3zm0DpzmM516YgtKdM
         M7ZO6dW2t6lsnx/pOwO8KdAey4yzvHSsraukMhOr3RK7Ck9jlBRZAB4ww0K+4m690WJv
         axt0C3igEsP6AKejeI3yoPy76xMgpA22kMV5GsqC8c7B6ly7RFEI1wZnNGuB7OnSL4qU
         FXiA==
X-Forwarded-Encrypted: i=1; AJvYcCWqyHoFCzPnE6SGEP1tUHOpZAh5q1rKZenBW5MD76JRUmDU6ynYP7otJ+0NxGp0N+OeHW38xO1c@vger.kernel.org
X-Gm-Message-State: AOJu0YxVswhAKmGf641YcDIBR4KmNigd/gr7ObDAgAoQ25l/nLjgV+VY
	VWpEesBzYLmieC3iMynyzOXZGHDx1K2rufJge3t8rxA3DXckSvOrNnsXjm7g53Iadvs=
X-Gm-Gg: ASbGnct0ml3RxiO8vY9AYzraxGbkx+U3xP58rMsUb1i2Xfy/hCXqZMPdn5DP7HTNamC
	1ze4HRce7a8+ROaZayBKwViC+5SdfKjAWxPbhGbhzDImuEBki2UBtnonVoUnlO9gseNgc9VY9Ta
	uckfsgJr3D5Z6QXg8TlQmynC/R9TSOhoQAu+ilpoV4Hbk+hj5sapf7QSRgKFYLlRlDIsSZCC1Z9
	ZqchQIhsCZ2GZjxSoXV5vja2EC5IM44GHxVhrsb7ZNISF/TGjaVP0dQ9ePFRyPiYDMp45W09V8Q
	HnsPMO3YXnqveYLdh0Nvrl52xcqD3NG8jFxjKfQ+tfC7hqXKR9u7/qnXC9xpFl+7fPyq/thirbi
	ss4n/2BK+IvEdhlv1DJuFGOcrDL8JCM+ECMYGEpcPiy6ejiG/gWXMesmpUKJvR7w0/I6cbP3k64
	IE57eEXft1hG7zHGXCVyUAUbV9
X-Google-Smtp-Source: AGHT+IGAJqQ0Kq7UeRNfTo+kG/hya+4ozhhHWlZnaOOqZGzl+HnP2llew3IXX1GgpwGtU4vmKHgoXw==
X-Received: by 2002:a17:907:2d8d:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b72e055e508mr784475766b.47.1762774111807;
        Mon, 10 Nov 2025 03:28:31 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf40768fsm1062473966b.23.2025.11.10.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:28:31 -0800 (PST)
Date: Mon, 10 Nov 2025 12:28:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
	lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aRHMWewcW41Vdzed@tiehlicka>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110101948.19277-1-leon.huangfu@shopee.com>

On Mon 10-11-25 18:19:48, Leon Huang Fu wrote:
> Memory cgroup statistics are updated asynchronously with periodic
> flushing to reduce overhead. The current implementation uses a flush
> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> determining when to aggregate per-CPU memory cgroup statistics. On
> systems with high core counts, this threshold can become very large
> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> statistics when userspace reads memory.stat files.
> 
> This is particularly problematic for monitoring and management tools
> that rely on reasonably fresh statistics, as they may observe data
> that is thousands of updates out of date.
> 
> Introduce a new write-only file, memory.stat_refresh, that allows
> userspace to explicitly trigger an immediate flush of memory statistics.
> Writing any value to this file forces a synchronous flush via
> __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> descendants, ensuring that subsequent reads of memory.stat and
> memory.numa_stat reflect current data.
> 
> This approach follows the pattern established by /proc/sys/vm/stat_refresh
> and memory.peak, where the written value is ignored, keeping the
> interface simple and consistent with existing kernel APIs.
> 
> Usage example:
>   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
>   cat /sys/fs/cgroup/mygroup/memory.stat
> 
> The feature is available in both cgroup v1 and v2 for consistency.
> 
> Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> v2 -> v3:
>   - Flush stats by memory.stat_refresh (per Michal)
>   - https://lore.kernel.org/linux-mm/20251105074917.94531-1-leon.huangfu@shopee.com/
> 
> v1 -> v2:
>   - Flush stats when write the file (per Michal).
>   - https://lore.kernel.org/linux-mm/20251104031908.77313-1-leon.huangfu@shopee.com/
> 
>  Documentation/admin-guide/cgroup-v2.rst | 21 +++++++++++++++++--
>  mm/memcontrol-v1.c                      |  4 ++++
>  mm/memcontrol-v1.h                      |  2 ++
>  mm/memcontrol.c                         | 27 ++++++++++++++++++-------
>  4 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3345961c30ac..ca079932f957 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1337,7 +1337,7 @@ PAGE_SIZE multiple when read back.
>  	cgroup is within its effective low boundary, the cgroup's
>  	memory won't be reclaimed unless there is no reclaimable
>  	memory available in unprotected cgroups.
> -	Above the effective low	boundary (or
> +	Above the effective low	boundary (or
>  	effective min boundary if it is higher), pages are reclaimed
>  	proportionally to the overage, reducing reclaim pressure for
>  	smaller overages.
> @@ -1785,6 +1785,23 @@ The following nested keys are defined.
>  		up if hugetlb usage is accounted for in memory.current (i.e.
>  		cgroup is mounted with the memory_hugetlb_accounting option).
> 
> +  memory.stat_refresh
> +	A write-only file which exists on non-root cgroups.
> +
> +	Writing any value to this file forces an immediate flush of
> +	memory statistics for this cgroup and its descendants. This
> +	ensures subsequent reads of memory.stat and memory.numa_stat
> +	reflect the most current data.
> +
> +	This is useful on high-core count systems where per-CPU caching
> +	can lead to stale statistics, or when precise memory usage
> +	information is needed for monitoring or debugging purposes.
> +
> +	Example::
> +
> +	  echo 1 > memory.stat_refresh
> +	  cat memory.stat
> +
>    memory.numa_stat
>  	A read-only nested-keyed file which exists on non-root cgroups.
> 
> @@ -2173,7 +2190,7 @@ of the two is enforced.
> 
>  cgroup writeback requires explicit support from the underlying
>  filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
> -btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
> +btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
>  attributed to the root cgroup.
> 
>  There are inherent differences in memory and writeback management
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6eed14bff742..c3eac9b1f1be 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2041,6 +2041,10 @@ struct cftype mem_cgroup_legacy_files[] = {
>  		.name = "stat",
>  		.seq_show = memory_stat_show,
>  	},
> +	{
> +		.name = "stat_refresh",
> +		.write = memory_stat_refresh_write,
> +	},
>  	{
>  		.name = "force_empty",
>  		.write = mem_cgroup_force_empty_write,
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6358464bb416..a14d4d74c9aa 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -29,6 +29,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg);
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
> +ssize_t memory_stat_refresh_write(struct kernfs_open_file *of, char *buf,
> +				  size_t nbytes, loff_t off);
> 
>  void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
>  struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bfc986da3289..19ef4b971d8d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -610,6 +610,15 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
>  	css_rstat_flush(&memcg->css);
>  }
> 
> +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
> +{
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	memcg = memcg ?: root_mem_cgroup;
> +	__mem_cgroup_flush_stats(memcg, force);
> +}
> +
>  /*
>   * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
>   * @memcg: root of the subtree to flush
> @@ -621,13 +630,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
>   */
>  void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  {
> -	if (mem_cgroup_disabled())
> -		return;
> -
> -	if (!memcg)
> -		memcg = root_mem_cgroup;
> -
> -	__mem_cgroup_flush_stats(memcg, false);
> +	memcg_flush_stats(memcg, false);
>  }
> 
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> @@ -4530,6 +4533,12 @@ int memory_stat_show(struct seq_file *m, void *v)
>  	return 0;
>  }
> 
> +ssize_t memory_stat_refresh_write(struct kernfs_open_file *of, char *buf, size_t nbytes, loff_t off)
> +{
> +	memcg_flush_stats(mem_cgroup_from_css(of_css(of)), true);
> +	return nbytes;
> +}
> +
>  #ifdef CONFIG_NUMA
>  static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
>  						     int item)
> @@ -4666,6 +4675,10 @@ static struct cftype memory_files[] = {
>  		.name = "stat",
>  		.seq_show = memory_stat_show,
>  	},
> +	{
> +		.name = "stat_refresh",
> +		.write = memory_stat_refresh_write,
> +	},
>  #ifdef CONFIG_NUMA
>  	{
>  		.name = "numa_stat",
> --
> 2.51.2

-- 
Michal Hocko
SUSE Labs

