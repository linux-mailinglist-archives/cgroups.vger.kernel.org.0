Return-Path: <cgroups+bounces-770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4111A8019BC
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 02:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A280D1F21103
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED417EF;
	Sat,  2 Dec 2023 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aICYvL5o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDC9D5;
	Fri,  1 Dec 2023 17:57:28 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d06d42a58aso3920935ad.0;
        Fri, 01 Dec 2023 17:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482248; x=1702087048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrB9T/B1plr1KLo1ojkYN0bScrkWBvXt8AxTXe/RINw=;
        b=aICYvL5oVmBaRC4U6e/yMlwE8irWvEkTaVEt5kyTbzOb2NequnLrArDvtUGw6o6o5I
         Ge9/IDb1Uz7CdRO+9zfpcSpqby+wm3MNyP4B6XxmyeSGv4gaKpW6wndkGQsjIc28VqeL
         Fa2OXvE92JGQP13vorb5H9atMDcpnkFzK20fdwjdizGz1e99eQR4Fsud4yB3BBDNxoRC
         +3xUtKTJ99m5TkNEo/KSiAc6HvMZAyMexB6NODa5qno/rJHJ5b1xiHZp/yMZKfcg2AAq
         KMBRmswM8AihLpSCGV76KUeSnSJ7WtCYFJKE7lULO/i3Tgxho5ll4uGPKNtYH1o69f+X
         iwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482248; x=1702087048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrB9T/B1plr1KLo1ojkYN0bScrkWBvXt8AxTXe/RINw=;
        b=Zr0sulMoDWGsTDqB80naBe6tRFhMLfLoitqY5rjYoNL7oydH37wwcSXjimFIlbDjOg
         GxNWIuAwFrdBmLm4jV6nw/uPuq1KvYlZlHeuzHRZ5T0VOw2fgTPRhiP9XDJeXKgt59eg
         pjMu5yrq8YVFpVfG27kSo77gcdM5ozjpGV7sFFfTBSUz0tJX6qvoqFGwUJXZlnqisQ4W
         8Md41ppv4av5ZpZJcJPEelTwbYTRakeLo5/JbnediaixHgm1KULbrwKBVdBZuAWmF1gL
         TKEAV2DLc3zmQgqN0Ze89c4BIQN0gFl6ioezN4e5AlpNBEfGaaseib/paHFJbHnlTRPc
         goCQ==
X-Gm-Message-State: AOJu0YxnEIdq7bF1hNSkzAh3GUu9OnDMy5EHkdo1ArdTRJZ4V2U3W5g2
	RhC41t7b7HzXEG4XxLwLs9c=
X-Google-Smtp-Source: AGHT+IEUg0dW+OF3gza2fK1oIx0lCbnofHvNwbjMv9gjLRLawu5IN0DUC+jUjFTWVHbV85RLDGqdkw==
X-Received: by 2002:a17:902:8e86:b0:1cf:ad5f:20ab with SMTP id bg6-20020a1709028e8600b001cfad5f20abmr539146plb.19.1701482247828;
        Fri, 01 Dec 2023 17:57:27 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3989813plf.48.2023.12.01.17.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 17:57:26 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 726A810082367; Sat,  2 Dec 2023 08:57:24 +0700 (WIB)
Date: Sat, 2 Dec 2023 08:57:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Attreyee M <tintinm2017@gmail.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux CGroups <cgroups@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Message-ID: <ZWqPBHCXz4nBIQFN@archie.me>
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nOlWIuGpHWt+jozi"
Content-Disposition: inline
In-Reply-To: <20231129032154.3710765-6-yosryahmed@google.com>


--nOlWIuGpHWt+jozi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> Stats flushing for memcg currently follows the following rules:
> - Always flush the entire memcg hierarchy (i.e. flush the root).
> - Only one flusher is allowed at a time. If someone else tries to flush
>   concurrently, they skip and return immediately.
> - A periodic flusher flushes all the stats every 2 seconds.
>=20
> The reason this approach is followed is because all flushes are
> serialized by a global rstat spinlock. On the memcg side, flushing is
> invoked from userspace reads as well as in-kernel flushers (e.g.
> reclaim, refault, etc). This approach aims to avoid serializing all
> flushers on the global lock, which can cause a significant performance
> hit under high concurrency.
>=20
> This approach has the following problems:
> - Occasionally a userspace read of the stats of a non-root cgroup will
>   be too expensive as it has to flush the entire hierarchy [1].
> - Sometimes the stats accuracy are compromised if there is an ongoing
>   flush, and we skip and return before the subtree of interest is
>   actually flushed, yielding stale stats (by up to 2s due to periodic
>   flushing). This is more visible when reading stats from userspace,
>   but can also affect in-kernel flushers.
>=20
> The latter problem is particulary a concern when userspace reads stats
> after an event occurs, but gets stats from before the event. Examples:
> - When memory usage / pressure spikes, a userspace OOM handler may look
>   at the stats of different memcgs to select a victim based on various
>   heuristics (e.g. how much private memory will be freed by killing
>   this). Reading stale stats from before the usage spike in this case
>   may cause a wrongful OOM kill.
> - A proactive reclaimer may read the stats after writing to
>   memory.reclaim to measure the success of the reclaim operation. Stale
>   stats from before reclaim may give a false negative.
> - Reading the stats of a parent and a child memcg may be inconsistent
>   (child larger than parent), if the flush doesn't happen when the
>   parent is read, but happens when the child is read.
>=20
> As for in-kernel flushers, they will occasionally get stale stats. No
> regressions are currently known from this, but if there are regressions,
> they would be very difficult to debug and link to the source of the
> problem.
>=20
> This patch aims to fix these problems by restoring subtree flushing,
> and removing the unified/coalesced flushing logic that skips flushing if
> there is an ongoing flush. This change would introduce a significant
> regression with global stats flushing thresholds. With per-memcg stats
> flushing thresholds, this seems to perform really well. The thresholds
> protect the underlying lock from unnecessary contention.
>=20
> Add a mutex to protect the underlying rstat lock from excessive memcg
> flushing. The thresholds are re-checked after the mutex is grabbed to
> make sure that a concurrent flush did not already get the subtree we are
> trying to flush. A call to cgroup_rstat_flush() is not cheap, even if
> there are no pending updates.
>=20
> This patch was tested in two ways to ensure the latency of flushing is
> up to bar, on a machine with 384 cpus:
> - A synthetic test with 5000 concurrent workers in 500 cgroups doing
>   allocations and reclaim, as well as 1000 readers for memory.stat
>   (variation of [2]). No regressions were noticed in the total runtime.
>   Note that significant regressions in this test are observed with
>   global stats thresholds, but not with per-memcg thresholds.
>=20
> - A synthetic stress test for concurrently reading memcg stats while
>   memory allocation/freeing workers are running in the background,
>   provided by Wei Xu [3]. With 250k threads reading the stats every
>   100ms in 50k cgroups, 99.9% of reads take <=3D 50us. Less than 0.01%
>   of reads take more than 1ms, and no reads take more than 100ms.
>=20
> [1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO=
9ME4-dsgfoQ@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZ=
cz6POYTV-4g@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CAAPL-u9D2b=3DiF5Lf_cRnKxUfkiEe0AMDTu6yh=
rUAzX0b6a6rDg@mail.gmail.com/
>=20
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  include/linux/memcontrol.h |  8 ++--
>  mm/memcontrol.c            | 75 +++++++++++++++++++++++---------------
>  mm/vmscan.c                |  2 +-
>  mm/workingset.c            | 10 +++--
>  4 files changed, 58 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a568f70a26774..8673140683e6e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1050,8 +1050,8 @@ static inline unsigned long lruvec_page_state_local=
(struct lruvec *lruvec,
>  	return x;
>  }
> =20
> -void mem_cgroup_flush_stats(void);
> -void mem_cgroup_flush_stats_ratelimited(void);
> +void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
> +void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
> =20
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item=
 idx,
>  			      int val);
> @@ -1566,11 +1566,11 @@ static inline unsigned long lruvec_page_state_loc=
al(struct lruvec *lruvec,
>  	return node_page_state(lruvec_pgdat(lruvec), idx);
>  }
> =20
> -static inline void mem_cgroup_flush_stats(void)
> +static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  {
>  }
> =20
> -static inline void mem_cgroup_flush_stats_ratelimited(void)
> +static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup =
*memcg)
>  {
>  }
> =20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 93b483b379aa1..5d300318bf18a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -670,7 +670,6 @@ struct memcg_vmstats {
>   */
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwor=
k);
> -static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
>  static u64 flush_last_time;
> =20
>  #define FLUSH_TIME (2UL*HZ)
> @@ -731,35 +730,47 @@ static inline void memcg_rstat_updated(struct mem_c=
group *memcg, int val)
>  	}
>  }
> =20
> -static void do_flush_stats(void)
> +static void do_flush_stats(struct mem_cgroup *memcg)
>  {
> -	/*
> -	 * We always flush the entire tree, so concurrent flushers can just
> -	 * skip. This avoids a thundering herd problem on the rstat global lock
> -	 * from memcg flushers (e.g. reclaim, refault, etc).
> -	 */
> -	if (atomic_read(&stats_flush_ongoing) ||
> -	    atomic_xchg(&stats_flush_ongoing, 1))
> -		return;
> -
> -	WRITE_ONCE(flush_last_time, jiffies_64);
> -
> -	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> +	if (mem_cgroup_is_root(memcg))
> +		WRITE_ONCE(flush_last_time, jiffies_64);
> =20
> -	atomic_set(&stats_flush_ongoing, 0);
> +	cgroup_rstat_flush(memcg->css.cgroup);
>  }
> =20
> -void mem_cgroup_flush_stats(void)
> +/*
> + * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
> + * @memcg: root of the subtree to flush
> + *
> + * Flushing is serialized by the underlying global rstat lock. There is =
also a
> + * minimum amount of work to be done even if there are no stat updates t=
o flush.
> + * Hence, we only flush the stats if the updates delta exceeds a thresho=
ld. This
> + * avoids unnecessary work and contention on the underlying lock.
> + */

What is global rstat lock?

> +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  {
> -	if (memcg_should_flush_stats(root_mem_cgroup))
> -		do_flush_stats();
> +	static DEFINE_MUTEX(memcg_stats_flush_mutex);
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	if (!memcg)
> +		memcg =3D root_mem_cgroup;
> +
> +	if (memcg_should_flush_stats(memcg)) {
> +		mutex_lock(&memcg_stats_flush_mutex);
> +		/* Check again after locking, another flush may have occurred */
> +		if (memcg_should_flush_stats(memcg))
> +			do_flush_stats(memcg);
> +		mutex_unlock(&memcg_stats_flush_mutex);
> +	}
>  }
> =20
> -void mem_cgroup_flush_stats_ratelimited(void)
> +void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
>  {
>  	/* Only flush if the periodic flusher is one full cycle late */
>  	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_flush_stats(memcg);
>  }
> =20
>  static void flush_memcg_stats_dwork(struct work_struct *w)
> @@ -768,7 +779,7 @@ static void flush_memcg_stats_dwork(struct work_struc=
t *w)
>  	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
>  	 * in latency-sensitive paths is as cheap as possible.
>  	 */
> -	do_flush_stats();
> +	do_flush_stats(root_mem_cgroup);
>  	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
>  }
> =20
> @@ -1664,7 +1675,7 @@ static void memcg_stat_format(struct mem_cgroup *me=
mcg, struct seq_buf *s)
>  	 *
>  	 * Current memory state:
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats(memcg);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		u64 size;
> @@ -4214,7 +4225,7 @@ static int memcg_numa_stat_show(struct seq_file *m,=
 void *v)
>  	int nid;
>  	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> =20
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats(memcg);
> =20
>  	for (stat =3D stats; stat < stats + ARRAY_SIZE(stats); stat++) {
>  		seq_printf(m, "%s=3D%lu", stat->name,
> @@ -4295,7 +4306,7 @@ static void memcg1_stat_format(struct mem_cgroup *m=
emcg, struct seq_buf *s)
> =20
>  	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) !=3D ARRAY_SIZE(memcg1_stats=
));
> =20
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats(memcg);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>  		unsigned long nr;
> @@ -4791,7 +4802,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, =
unsigned long *pfilepages,
>  	struct mem_cgroup *memcg =3D mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
> =20
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats(memcg);
> =20
>  	*pdirty =3D memcg_page_state(memcg, NR_FILE_DIRTY);
>  	*pwriteback =3D memcg_page_state(memcg, NR_WRITEBACK);
> @@ -6886,7 +6897,7 @@ static int memory_numa_stat_show(struct seq_file *m=
, void *v)
>  	int i;
>  	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> =20
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats(memcg);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		int nid;
> @@ -8125,7 +8136,11 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  			break;
>  		}
> =20
> -		cgroup_rstat_flush(memcg->css.cgroup);
> +		/*
> +		 * mem_cgroup_flush_stats() ignores small changes. Use
> +		 * do_flush_stats() directly to get accurate stats for charging.
> +		 */
> +		do_flush_stats(memcg);
>  		pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
>  		if (pages < max)
>  			continue;
> @@ -8190,8 +8205,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *=
objcg, size_t size)
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
>  			      struct cftype *cft)
>  {
> -	cgroup_rstat_flush(css->cgroup);
> -	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
> +	struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
> +
> +	mem_cgroup_flush_stats(memcg);
> +	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
>  }
> =20
>  static int zswap_max_show(struct seq_file *m, void *v)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d8c3338fee0fb..0b8a0107d58d8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2250,7 +2250,7 @@ static void prepare_scan_control(pg_data_t *pgdat, =
struct scan_control *sc)
>  	 * Flush the memory cgroup stats, so that we read accurate per-memcg
>  	 * lruvec stats for heuristics.
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats(sc->target_mem_cgroup);
> =20
>  	/*
>  	 * Determine the scan balance between anon and file LRUs.
> diff --git a/mm/workingset.c b/mm/workingset.c
> index dce41577a49d2..7d3dacab8451a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -464,8 +464,12 @@ bool workingset_test_recent(void *shadow, bool file,=
 bool *workingset)
> =20
>  	rcu_read_unlock();
> =20
> -	/* Flush stats (and potentially sleep) outside the RCU read section */
> -	mem_cgroup_flush_stats_ratelimited();
> +	/*
> +	 * Flush stats (and potentially sleep) outside the RCU read section.
> +	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
> +	 * still needed here?
> +	 */
> +	mem_cgroup_flush_stats_ratelimited(eviction_memcg);

What if flushing is not rate-limited (e.g. above line is commented)?

> =20
>  	eviction_lruvec =3D mem_cgroup_lruvec(eviction_memcg, pgdat);
>  	refault =3D atomic_long_read(&eviction_lruvec->nonresident_age);
> @@ -676,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrink=
er *shrinker,
>  		struct lruvec *lruvec;
>  		int i;
> =20
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_flush_stats(sc->memcg);
>  		lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
>  		for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
>  			pages +=3D lruvec_page_state_local(lruvec,

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--nOlWIuGpHWt+jozi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWqPAAAKCRD2uYlJVVFO
o679AQCaiziz0f+tw3jC9nOLLQDBlaTl8wi71FJT4Q7x3iXRXwD+JDR9uzJPnLAw
yBzdxmHDgkPi3OrCa7Gr1JO8CXG6RQY=
=B70i
-----END PGP SIGNATURE-----

--nOlWIuGpHWt+jozi--

