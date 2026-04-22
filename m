Return-Path: <cgroups+bounces-15454-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CIdOqKO6GmpMQIAu9opvQ
	(envelope-from <cgroups+bounces-15454-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 11:02:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46701443B90
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB891302A6BC
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0E3C0630;
	Wed, 22 Apr 2026 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="evKnj1hN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B743B27EC
	for <cgroups@vger.kernel.org>; Wed, 22 Apr 2026 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848418; cv=none; b=XH4SlzINqu6RuvAQBTUzVElF3KjJARpHHnT4DWw6w9kEBM9mDNgh2vj/3G3MPGTkVNdWuhVNbL1ujAJs77l7g+XIVBQqrNVUgFFN5fYSmfAF64ek9UGEfu2dWNS4Snu2Cdt5FxAnp8nJsnGAkgn4jPevPxOpyvBPh3A/cMQHMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848418; c=relaxed/simple;
	bh=xSVx0Ax4mEHQifNm1XH5uXvw17q+ccHYHWnCW3tKJOc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=KKnbFgsYRb3ngaqVu3JxB1PDR6HdBh7iTOxyWSgIm4cJXlgSUSIEsREq18ydHzADIZ+1aXmfetCvkOXyhGmmxnB9yxYRYINc+oY61Lxyjfmmd7DjbGjsk+tt/OcrqbA8ONHTtBiousINTtJXLMSkqfhgWoCGGDjR81amqDfiF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=evKnj1hN; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776848403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Onr23ZhU90nAAF2Ds/wbFjmbNXeYzOB39lTbfI481a4=;
	b=evKnj1hNq3/eWjRUGArqwyeb+kwlwPvRvryfqgWTpN2FoeTWQCb1oGTbxam8ULRpY2wlwA
	lUOzQASbHOn/FgbVKoSQbxDHW/vr99gDyA/YV3jZILoQa8k3W5TXdJ7wzqePDBAJwOlKSj
	iGZ6EsH2/zkguHEQaQz6DJKSl+Djejg=
Date: Wed, 22 Apr 2026 09:00:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "teawater" <hui.zhu@linux.dev>
Message-ID: <9871d2cd927f7410e95ddc77ece8b9d00ed5b787@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mm-stable v3] mm/memcontrol: batch memcg charging in
 __memcg_slab_post_alloc_hook
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko"
 <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>
In-Reply-To: <acv5QCe0qMUUW2xP@hyeyoo>
References: <20260331091707.226786-1-hui.zhu@linux.dev>
 <acvnjCr26zpQUW0h@linux.dev> <acv5QCe0qMUUW2xP@hyeyoo>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15454-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 46701443B90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
>=20On Tue, Mar 31, 2026 at 08:32:30AM -0700, Shakeel Butt wrote:
>=20
>=20>=20
>=20> On Tue, Mar 31, 2026 at 05:17:07PM +0800, Hui Zhu wrote:
> >  From: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  When kmem_cache_alloc_bulk() allocates multiple objects, the post-=
alloc
> >  hook __memcg_slab_post_alloc_hook() previously charged memcg one obj=
ect
> >  at a time, even though consecutive objects may reside on slabs backe=
d by
> >  the same pgdat node.
> >=20=20
>=20>  Batch the memcg charging by scanning ahead from the current positi=
on to
> >  find a contiguous run of objects whose slabs share the same pgdat, t=
hen
> >  issue a single __obj_cgroup_charge() / __consume_obj_stock() call fo=
r
> >  the entire run. The per-object obj_ext assignment loop is preserved =
as-is
> >  since it cannot be further collapsed.
> >=20=20
>=20>  This implements the TODO comment left in commit bc730030f956 ("mem=
cg:
> >  combine slab obj stock charging and accounting").
> >=20=20
>=20>  The existing error-recovery contract is unchanged: if size =3D=3D =
1 then
> >  memcg_alloc_abort_single() will free the sole object, and for larger
> >  bulk allocations kmem_cache_free_bulk() will uncharge any objects th=
at
> >  were already charged before the failure.
> >=20=20
>=20>  Benchmark using kmem_cache_alloc_bulk() with SLAB_ACCOUNT
> >  (iters=3D100000):
> >=20=20
>=20>  bulk=3D32 before: 215 ns/object after: 174 ns/object (-19%)
> >  bulk=3D1 before: 344 ns/object after: 335 ns/object ( ~)
> >=20=20
>=20>  No measurable regression for bulk=3D1, as expected.
> >=20=20
>=20>  Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  Do we have an actual user of kmem_cache_alloc_bulk(GFP_ACCOUNT) in=
 kernel?
> >=20
>=20Apparently we have a SLAB_ACCOUNT user in io_uring.c.
> (perhaps it's the only user?)
>=20
>=20>=20
>=20> If yes, can you please benchmark that usage? Otherwise can we pleas=
e wait for
> >  an actual user before adding more complexity? Or you can look for op=
portunities
> >  for kmem_cache_alloc_bulk(GFP_ACCOUNT) users and add the optimizatio=
n along with
> >  the user.
> >=20
>=20Good point. I was also wondering what are use cases benefiting
> from this beyond the microbenchmark.
>=20
>=20>=20
>=20> Have you looked at the bulk free side? I think we already have rcu =
freeing in
> >  bulk as a user. Did you find any opportunities in optimizing the
> >  __memcg_slab_free_hook() from bulk free?
> >=20
>=20Probably a bit out of scope but one thing to note on slab side:
> kfree_bulk() (called by kfree_rcu batching) doesn't specify slab cache,
> and it builds a detached freelist which contains objects from the same =
slab.
>=20
>=20On the other hand kmem_cache_free_bulk() with non-NULL slab cache
> simply calls free_to_pcs_bulk() and it passes objects one by one to
> __memcg_slab_free_hook() since objects may not come from the same slab.
>=20
>=20Now that we have sheaves enabled for (almost) all slab caches, it mig=
ht
> be worth revisiting - e.g. sort objects by slab cache and
> pass them to free_to_pcs_bulk() instead of building a detached freelist=
.
>=20
>=20And let __memcg_slab_free_hook() handle objects from the same cache b=
ut
> from different slabs.
>=20
>=20--=20
>=20Cheers,
> Harry / Hyeonggon
>


Hi Shakeel and Harry,

I ran a couple of benchmarks against the patch and wanted to share
the results.

The first test exercises the __io_alloc_req_refill bulk-refill path
directly. It submits POLL_ADD requests against a pipe fd that never
becomes readable, so requests accumulate in the poll wait queue and
force repeated refills at high throughput. With the patch applied,
elapsed time dropped by 8.7% =E2=80=94 a clear win for that code path.

However, the second test focuses on single-object allocation speed
under the same ring setup. There, the patch actually regressed
performance by 5.7%.

I also tried two targeted mitigations to recover that regression:

  1. Replacing `likely` with `unlikely` in the relevant branch.
  2. Replacing `check_mul_overflow` with a simpler bounds check:
       size <=3D (size_t)(INT_MAX - PAGE_SIZE) /
              (KMALLOC_MAX_SIZE + sizeof(struct obj_cgroup *))

Neither approach recovered the single-allocation loss in a
meaningful way.

Given that only the __io_alloc_req_refill call path benefits from
this patch while the common single-allocation path takes a step
back, the trade-off doesn't seem worthwhile at this point. I'd
suggest we hold off on merging until we find an approach that
improves =E2=80=94 or at least doesn't hurt =E2=80=94 the general case.

Happy to discuss further or run additional benchmarks if that
would help. The two test programs I used are included at the
bottom of this email.

Best,
Hui

#define _GNU_SOURCE
#include <liburing.h>
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <time.h>
#include <unistd.h>

#define QD		4096	/* SQ depth per ring */
#define BURST		2048	/* SQEs submitted per round; refills =E2=89=88 BURST/=
8 */
#define RING_RECYCLE	32	/* rounds before recycling the ring */

/*
 * Default total number of submissions.  Can be overridden via argv[1].
 * The loop exits as soon as the cumulative submitted count reaches this =
value.
 */
#define DEFAULT_TOTAL	(1UL << 24)

int main(int argc, char **argv)
{
	unsigned long target =3D argc > 1 ? strtoul(argv[1], NULL, 0) : DEFAULT_=
TOTAL;
	unsigned long submitted =3D 0;

	/* Raise nofile/memlock limits; poll requests are heavy on fd table and =
slab */
	struct rlimit rl =3D { .rlim_cur =3D 1 << 20, .rlim_max =3D 1 << 20 };
	setrlimit(RLIMIT_NOFILE, &rl);
	setrlimit(RLIMIT_MEMLOCK, &rl);

	printf("target=3D%lu QD=3D%d burst=3D%d ring_recycle=3D%d\n",
	       target, QD, BURST, RING_RECYCLE);

	/*
	 * A pipe whose read end will never become readable.
	 * POLL_ADD(POLLIN) requests submitted against pfd[0] will hang
	 * indefinitely in the poll wait queue without producing a CQE,
	 * which is exactly what exercises the refill path at high rate.
	 */
	int pfd[2];
	if (pipe(pfd) < 0) {
		perror("pipe");
		return 1;
	}

	struct timespec t0, t1;
	clock_gettime(CLOCK_MONOTONIC, &t0);

	while (submitted < target) {
		struct io_uring ring;
		struct io_uring_params pr =3D { 0 };

		/*
		 * No SQPOLL: submissions go through io_submit_sqes(), which is
		 * the code path where refill is invoked.
		 */
		if (io_uring_queue_init_params(QD, &ring, &pr) < 0) {
			perror("io_uring_queue_init_params");
			break;
		}

		for (int round =3D 0; round < RING_RECYCLE && submitted < target; round=
++) {
			int prepared =3D 0;

			for (int i =3D 0; i < BURST; i++) {
				struct io_uring_sqe *sqe =3D io_uring_get_sqe(&ring);

				if (!sqe)
					break;

				/*
				 * POLL_ADD on an fd that never fires: the request
				 * is parked on the poll wait queue and does not
				 * return to the free list until ring exit.
				 */
				io_uring_prep_poll_add(sqe, pfd[0], POLL_IN);
				sqe->user_data =3D i;
				prepared++;
			}

			if (!prepared)
				break;

			int r =3D io_uring_submit(&ring);

			if (r < 0)
				break;

			submitted +=3D r;
		}

		/*
		 * Destroy the ring periodically so that the io_kiocb objects
		 * accumulated in nr_req_allocated are returned to req_cachep.
		 * ring_exit() drains all pending poll requests; once the
		 * percpu_ref reaches zero the slab objects are released in
		 * bulk, preventing unbounded memory growth.
		 */
		io_uring_queue_exit(&ring);
	}

	clock_gettime(CLOCK_MONOTONIC, &t1);

	close(pfd[0]);
	close(pfd[1]);

	double dt =3D (t1.tv_sec - t0.tv_sec) +
		    (t1.tv_nsec - t0.tv_nsec) / 1e9;

	printf("submitted=3D%lu  refills=3D%lu  elapsed=3D%.3fs  (%.2f Mrefill/s=
)\n",
	       submitted, submitted / 8,
	       dt, (submitted / 8.0) / dt / 1e6);

	return 0;
}


#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/ktime.h>
#include <linux/mm.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Hui Zhu");
MODULE_DESCRIPTION("Benchmark for kmem_cache_alloc_bulk with memcg accoun=
ting");

/* Default number of iterations */
static int iters =3D 100000;
module_param(iters, int, 0444);
MODULE_PARM_DESC(iters, "Number of iterations");=0D

/*
 * Default bulk size. Set to 32 or 64 to evaluate
 * the effect of bulk allocation optimizations.
 */
static int bulk_size =3D 32;
module_param(bulk_size, int, 0444);
MODULE_PARM_DESC(bulk_size, "Number of objects per bulk allocation");

#define OBJ_SIZE 256

static int __init bench_init(void)
{
	struct kmem_cache *cache;
	void **objs;
	int i;
	u64 start, end, delta;
	int ret =3D 0;

	pr_info("Benchmarking kmem_cache_alloc_bulk with SLAB_ACCOUNT...\n");

	/*
	 * Create the cache with SLAB_ACCOUNT so that every allocation
	 * from it triggers the memcg accounting hooks, specifically
	 * __memcg_slab_post_alloc_hook.
	 */
	cache =3D kmem_cache_create("bench_memcg_cache", OBJ_SIZE, 0,
				  SLAB_ACCOUNT, NULL);
	if (!cache) {
		pr_err("Failed to create cache\n");
		return -ENOMEM;
	}

	/* Allocate the pointer array to hold bulk-allocated objects */
	objs =3D kmalloc_array(bulk_size, sizeof(void *), GFP_KERNEL);
	if (!objs) {
		pr_err("Failed to allocate pointer array\n");
		kmem_cache_destroy(cache);
		return -ENOMEM;
	}

	/* Warm up once to avoid cold-start overhead on the first run */
	ret =3D kmem_cache_alloc_bulk(cache, GFP_KERNEL, bulk_size, objs);
	if (ret)
		kmem_cache_free_bulk(cache, ret, objs);

	/* Start timing */
	start =3D ktime_get_ns();

	for (i =3D 0; i < iters; i++) {
		/* Core measurement: bulk allocation */
		ret =3D kmem_cache_alloc_bulk(cache, GFP_KERNEL, bulk_size, objs);
		if (unlikely(!ret)) {
			pr_err("Allocation failed at iteration %d\n", i);
			break;
		}
		/*
		 * Free immediately; we only care about the performance
		 * of the allocation-path hooks.
		 */
		kmem_cache_free_bulk(cache, ret, objs);
	}

	end =3D ktime_get_ns();

	delta =3D end - start;
	pr_info("Benchmark Result (iters=3D%d, bulk=3D%d):\n", iters, bulk_size)=
;
	pr_info("  Total Time:              %llu ns\n", delta);
	pr_info("  Avg Time per Iteration:  %llu ns\n", delta / iters);
	pr_info("  Avg Time per Object:     %llu ns\n",
		delta / (iters * bulk_size));

	/* Release resources */
	kfree(objs);
	kmem_cache_destroy(cache);

	/*
	 * Return -EAGAIN to prevent the module from being fully loaded.
	 * insmod will report an error and exit, but the benchmark results
	 * are already recorded in dmesg, so no manual rmmod is needed.
	 */
	return -EAGAIN;
}

static void __exit bench_exit(void)
{
}

module_init(bench_init);
module_exit(bench_exit);

