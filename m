Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9237438421
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2019 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfFGGH7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jun 2019 02:07:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfFGGH7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jun 2019 02:07:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so658420wma.4
        for <cgroups@vger.kernel.org>; Thu, 06 Jun 2019 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=xVidoYCiJ/CFoJbsWMNFTizqNcED6zNp3oVvmMJGP+4=;
        b=ZMpoExT7esx1VSWs9KcWwl2+oi5hL38crPWpYDXd48zsQUWvn107nExN7BaU+Pdi6R
         8QBDprK4yG/2DJ6+q/LACwl/WUm93w3vvCvOQEWda7wrI91bX4B8Q2IMffsnn9HOwb6w
         +Bm/iL5Fc8heKPikZOfrKUQUqPT3yW4yL6ct4NCdUHpKCv32ane5+nJ68uNR5YlX2mIx
         cNeVdjXNImqMKqnnDwJTtS2YEyPfgiHCeqyHRJ1JHDt6BsTSX0GB5RC6vO2NZ23c3siR
         LxmKMVK0ZEdOHGnA0J/dp+FXjRXYUNpIwjaCNIwUUnqM8zohj/Tu02SldWa3wiFmLjVx
         128g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=xVidoYCiJ/CFoJbsWMNFTizqNcED6zNp3oVvmMJGP+4=;
        b=ullUtXF9Av7O8OTjMi8uAjwJ49uluRHRp6+X67FFr11q0XbMk4xd8caadfp82FYlRN
         Rbp0zvR9CxqZ/3yVR0hI1t7h/e2Zbwa8pB1gcxRMOILrR48tuf/Mw66/BsywEa2hTOWS
         gZieq27ay757RjO4U2boEw+2rM0WKwKyklmWRm57u/mZzuTn6ZD+Po5MMPwE1pFM1675
         Jnla/twfJPyr46yHgA7frj+TJIgSZY3+WY8uPy/Z1eRctNCnxgjZPVTD3d75HyZ/I5vd
         IJ0bMdDKUeOzvahrttBcsRnN5ZyRKZGiEUSvHGyvkUOkQnF/6NJkYUAkofZ/GUggOwra
         sHbw==
X-Gm-Message-State: APjAAAWPl8zodMID+xURDyz9nAXwJiLiuskuFQ8RrMiD6GB1rWFHnKNn
        WyzHrk62CWskmMFGijtQmog2EEy1zlw=
X-Google-Smtp-Source: APXvYqzm6wGbH+WD0PndLhSiTq366eJJO/uZWILUOcQ+lHJnC+QmKt+ZD87Y9Q54eaXwlpMlqjBIXA==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr447005wmj.140.1559887676262;
        Thu, 06 Jun 2019 23:07:56 -0700 (PDT)
Received: from [192.168.0.102] (88-147-34-172.dyn.eolo.it. [88.147.34.172])
        by smtp.gmail.com with ESMTPSA id n7sm787465wrw.64.2019.06.06.23.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 23:07:55 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <517836F7-FF5C-4AAD-A8AC-59BBC2EFBEE4@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E0EEFE40-49EC-4EEE-87DB-0FA82AA30057";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 6/6] block: rename CONFIG_DEBUG_BLK_CGROUP to
 CONFIG_BFQ_CGROUP_DEBUG
Date:   Fri, 7 Jun 2019 08:07:54 +0200
In-Reply-To: <20190606102624.3847-7-hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Christoph Hellwig <hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
 <20190606102624.3847-7-hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Apple-Mail=_E0EEFE40-49EC-4EEE-87DB-0FA82AA30057
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 6 giu 2019, alle ore 12:26, Christoph Hellwig <hch@lst.de> =
ha scritto:
>=20
> This option is entirely bfq specific, give it an appropinquate name.
>=20
> Also make it depend on CONFIG_BFQ_GROUP_IOSCHED in Kconfig, as all
> the functionality already does so anyway.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> Documentation/block/bfq-iosched.txt          | 12 ++++-----
> Documentation/cgroup-v1/blkio-controller.txt | 12 ++++-----
> block/Kconfig.iosched                        |  7 +++++
> block/bfq-cgroup.c                           | 27 ++++++++++----------
> block/bfq-iosched.c                          |  8 +++---
> block/bfq-iosched.h                          |  4 +--
> init/Kconfig                                 |  8 ------
> 7 files changed, 38 insertions(+), 40 deletions(-)
>=20
> diff --git a/Documentation/block/bfq-iosched.txt =
b/Documentation/block/bfq-iosched.txt
> index 1a0f2ac02eb6..f02163fabf80 100644
> --- a/Documentation/block/bfq-iosched.txt
> +++ b/Documentation/block/bfq-iosched.txt
> @@ -38,13 +38,13 @@ stack). To give an idea of the limits with BFQ, on =
slow or average
> CPUs, here are, first, the limits of BFQ for three different CPUs, on,
> respectively, an average laptop, an old desktop, and a cheap embedded
> system, in case full hierarchical support is enabled (i.e.,
> -CONFIG_BFQ_GROUP_IOSCHED is set), but CONFIG_DEBUG_BLK_CGROUP is not
> +CONFIG_BFQ_GROUP_IOSCHED is set), but CONFIG_BFQ_CGROUP_DEBUG is not
> set (Section 4-2):
> - Intel i7-4850HQ: 400 KIOPS
> - AMD A8-3850: 250 KIOPS
> - ARM CortexTM-A53 Octa-core: 80 KIOPS
>=20
> -If CONFIG_DEBUG_BLK_CGROUP is set (and of course full hierarchical
> +If CONFIG_BFQ_CGROUP_DEBUG is set (and of course full hierarchical
> support is enabled), then the sustainable throughput with BFQ
> decreases, because all blkio.bfq* statistics are created and updated
> (Section 4-2). For BFQ, this leads to the following maximum
> @@ -537,19 +537,19 @@ or io.bfq.weight.
>=20
> As for cgroups-v1 (blkio controller), the exact set of stat files
> created, and kept up-to-date by bfq, depends on whether
> -CONFIG_DEBUG_BLK_CGROUP is set. If it is set, then bfq creates all
> +CONFIG_BFQ_CGROUP_DEBUG is set. If it is set, then bfq creates all
> the stat files documented in
> Documentation/cgroup-v1/blkio-controller.txt. If, instead,
> -CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files
> +CONFIG_BFQ_CGROUP_DEBUG is not set, then bfq creates only the files
> blkio.bfq.io_service_bytes
> blkio.bfq.io_service_bytes_recursive
> blkio.bfq.io_serviced
> blkio.bfq.io_serviced_recursive
>=20
> -The value of CONFIG_DEBUG_BLK_CGROUP greatly influences the maximum
> +The value of CONFIG_BFQ_CGROUP_DEBUG greatly influences the maximum
> throughput sustainable with bfq, because updating the blkio.bfq.*
> stats is rather costly, especially for some of the stats enabled by
> -CONFIG_DEBUG_BLK_CGROUP.
> +CONFIG_BFQ_CGROUP_DEBUG.
>=20
> Parameters to set
> -----------------
> diff --git a/Documentation/cgroup-v1/blkio-controller.txt =
b/Documentation/cgroup-v1/blkio-controller.txt
> index 673dc34d3f78..47cf84102f88 100644
> --- a/Documentation/cgroup-v1/blkio-controller.txt
> +++ b/Documentation/cgroup-v1/blkio-controller.txt
> @@ -126,7 +126,7 @@ Various user visible config options
> CONFIG_BLK_CGROUP
> 	- Block IO controller.
>=20
> -CONFIG_DEBUG_BLK_CGROUP
> +CONFIG_BFQ_CGROUP_DEBUG
> 	- Debug help. Right now some additional stats file show up in =
cgroup
> 	  if this option is enabled.
>=20
> @@ -246,13 +246,13 @@ Proportional weight policy files
> 	  write, sync or async.
>=20
> - blkio.avg_queue_size
> -	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=3Dy.
> +	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=3Dy.
> 	  The average queue size for this cgroup over the entire time of =
this
> 	  cgroup's existence. Queue size samples are taken each time one =
of the
> 	  queues of this cgroup gets a timeslice.
>=20
> - blkio.group_wait_time
> -	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=3Dy.
> +	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=3Dy.
> 	  This is the amount of time the cgroup had to wait since it =
became busy
> 	  (i.e., went from 0 to 1 request queued) to get a timeslice for =
one of
> 	  its queues. This is different from the io_wait_time which is =
the
> @@ -263,7 +263,7 @@ Proportional weight policy files
> 	  got a timeslice and will not include the current delta.
>=20
> - blkio.empty_time
> -	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=3Dy.
> +	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=3Dy.
> 	  This is the amount of time a cgroup spends without any pending
> 	  requests when not being served, i.e., it does not include any =
time
> 	  spent idling for one of the queues of the cgroup. This is in
> @@ -272,7 +272,7 @@ Proportional weight policy files
> 	  time it had a pending request and will not include the current =
delta.
>=20
> - blkio.idle_time
> -	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=3Dy.
> +	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=3Dy.
> 	  This is the amount of time spent by the IO scheduler idling =
for a
> 	  given cgroup in anticipation of a better request than the =
existing ones
> 	  from other queues/cgroups. This is in nanoseconds. If this is =
read
> @@ -281,7 +281,7 @@ Proportional weight policy files
> 	  the current delta.
>=20
> - blkio.dequeue
> -	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=3Dy. =
This
> +	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=3Dy. =
This
> 	  gives the statistics about how many a times a group was =
dequeued
> 	  from service tree of the device. First two fields specify the =
major
> 	  and minor number of the device and third field specifies the =
number
> diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
> index 4626b88b2d5a..7a6b2f29a582 100644
> --- a/block/Kconfig.iosched
> +++ b/block/Kconfig.iosched
> @@ -36,6 +36,13 @@ config BFQ_GROUP_IOSCHED
>        Enable hierarchical scheduling in BFQ, using the blkio
>        (cgroups-v1) or io (cgroups-v2) controller.
>=20
> +config BFQ_CGROUP_DEBUG
> +	bool "BFQ IO controller debugging"
> +	depends on BFQ_GROUP_IOSCHED
> +	---help---
> +	Enable some debugging help. Currently it exports additional stat
> +	files in a cgroup which can be useful for debugging.
> +
> endmenu
>=20
> endif
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index d84302445e30..0f6cd688924f 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -15,8 +15,7 @@
>=20
> #include "bfq-iosched.h"
>=20
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) &&  =
defined(CONFIG_DEBUG_BLK_CGROUP)
> -
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> static int bfq_stat_init(struct bfq_stat *stat, gfp_t gfp)
> {
> 	int ret;
> @@ -253,7 +252,7 @@ void bfqg_stats_update_completion(struct bfq_group =
*bfqg, u64 start_time_ns,
> 				io_start_time_ns - start_time_ns);
> }
>=20
> -#else /* CONFIG_BFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
> +#else /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue =
*bfqq,
> 			      unsigned int op) { }
> @@ -267,7 +266,7 @@ void bfqg_stats_update_idle_time(struct bfq_group =
*bfqg) { }
> void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
> void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
>=20
> -#endif /* CONFIG_BFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
> +#endif /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>=20
> @@ -351,7 +350,7 @@ void bfqg_and_blkg_put(struct bfq_group *bfqg)
> /* @stats =3D 0 */
> static void bfqg_stats_reset(struct bfqg_stats *stats)
> {
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	/* queued stats shouldn't be cleared */
> 	blkg_rwstat_reset(&stats->merged);
> 	blkg_rwstat_reset(&stats->service_time);
> @@ -372,7 +371,7 @@ static void bfqg_stats_add_aux(struct bfqg_stats =
*to, struct bfqg_stats *from)
> 	if (!to || !from)
> 		return;
>=20
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	/* queued stats shouldn't be cleared */
> 	blkg_rwstat_add_aux(&to->merged, &from->merged);
> 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
> @@ -432,7 +431,7 @@ void bfq_init_entity(struct bfq_entity *entity, =
struct bfq_group *bfqg)
>=20
> static void bfqg_stats_exit(struct bfqg_stats *stats)
> {
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	blkg_rwstat_exit(&stats->merged);
> 	blkg_rwstat_exit(&stats->service_time);
> 	blkg_rwstat_exit(&stats->wait_time);
> @@ -449,7 +448,7 @@ static void bfqg_stats_exit(struct bfqg_stats =
*stats)
>=20
> static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
> {
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	if (blkg_rwstat_init(&stats->merged, gfp) ||
> 	    blkg_rwstat_init(&stats->service_time, gfp) ||
> 	    blkg_rwstat_init(&stats->wait_time, gfp) ||
> @@ -986,7 +985,7 @@ static ssize_t bfq_io_set_weight(struct =
kernfs_open_file *of,
> 	return ret ?: nbytes;
> }
>=20
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> static int bfqg_print_stat(struct seq_file *sf, void *v)
> {
> 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), =
blkg_prfill_stat,
> @@ -1109,7 +1108,7 @@ static int bfqg_print_avg_queue_size(struct =
seq_file *sf, void *v)
> 			  0, false);
> 	return 0;
> }
> -#endif /* CONFIG_DEBUG_BLK_CGROUP */
> +#endif /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, =
int node)
> {
> @@ -1157,7 +1156,7 @@ struct cftype bfq_blkcg_legacy_files[] =3D {
> 		.private =3D (unsigned long)&blkcg_policy_bfq,
> 		.seq_show =3D blkg_print_stat_ios,
> 	},
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	{
> 		.name =3D "bfq.time",
> 		.private =3D offsetof(struct bfq_group, stats.time),
> @@ -1187,7 +1186,7 @@ struct cftype bfq_blkcg_legacy_files[] =3D {
> 		.private =3D offsetof(struct bfq_group, stats.queued),
> 		.seq_show =3D bfqg_print_rwstat,
> 	},
> -#endif /* CONFIG_DEBUG_BLK_CGROUP */
> +#endif /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> 	/* the same statistics which cover the bfqg and its descendants =
*/
> 	{
> @@ -1200,7 +1199,7 @@ struct cftype bfq_blkcg_legacy_files[] =3D {
> 		.private =3D (unsigned long)&blkcg_policy_bfq,
> 		.seq_show =3D blkg_print_stat_ios_recursive,
> 	},
> -#ifdef CONFIG_DEBUG_BLK_CGROUP
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	{
> 		.name =3D "bfq.time_recursive",
> 		.private =3D offsetof(struct bfq_group, stats.time),
> @@ -1254,7 +1253,7 @@ struct cftype bfq_blkcg_legacy_files[] =3D {
> 		.private =3D offsetof(struct bfq_group, stats.dequeue),
> 		.seq_show =3D bfqg_print_stat,
> 	},
> -#endif	/* CONFIG_DEBUG_BLK_CGROUP */
> +#endif	/* CONFIG_BFQ_CGROUP_DEBUG */
> 	{ }	/* terminate */
> };
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index f8d430f88d25..e9a587707d67 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4403,7 +4403,7 @@ static struct request =
*__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> 	return rq;
> }
>=20
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> static void bfq_update_dispatch_stats(struct request_queue *q,
> 				      struct request *rq,
> 				      struct bfq_queue *in_serv_queue,
> @@ -4453,7 +4453,7 @@ static inline void =
bfq_update_dispatch_stats(struct request_queue *q,
> 					     struct request *rq,
> 					     struct bfq_queue =
*in_serv_queue,
> 					     bool idle_timer_disabled) =
{}
> -#endif
> +#endif /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
> {
> @@ -5007,7 +5007,7 @@ static bool __bfq_insert_request(struct bfq_data =
*bfqd, struct request *rq)
> 	return idle_timer_disabled;
> }
>=20
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> static void bfq_update_insert_stats(struct request_queue *q,
> 				    struct bfq_queue *bfqq,
> 				    bool idle_timer_disabled,
> @@ -5037,7 +5037,7 @@ static inline void =
bfq_update_insert_stats(struct request_queue *q,
> 					   struct bfq_queue *bfqq,
> 					   bool idle_timer_disabled,
> 					   unsigned int cmd_flags) {}
> -#endif
> +#endif /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct =
request *rq,
> 			       bool at_head)
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index aef4fa0046b8..584d3c9ed8ba 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -783,7 +783,7 @@ struct bfq_stat {
> };
>=20
> struct bfqg_stats {
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> 	/* number of ios merged */
> 	struct blkg_rwstat		merged;
> 	/* total time spent on device in ns, may not be accurate w/ =
queueing */
> @@ -811,7 +811,7 @@ struct bfqg_stats {
> 	u64				start_idle_time;
> 	u64				start_empty_time;
> 	uint16_t			flags;
> -#endif	/* CONFIG_BFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP =
*/
> +#endif /* CONFIG_BFQ_CGROUP_DEBUG */
> };
>=20
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> diff --git a/init/Kconfig b/init/Kconfig
> index 36894c9fb420..df9d36ba80e3 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -800,14 +800,6 @@ config BLK_CGROUP
>=20
> 	See Documentation/cgroup-v1/blkio-controller.txt for more =
information.
>=20
> -config DEBUG_BLK_CGROUP
> -	bool "IO controller debugging"
> -	depends on BLK_CGROUP
> -	default n
> -	---help---
> -	Enable some debugging help. Currently it exports additional stat
> -	files in a cgroup which can be useful for debugging.
> -
> config CGROUP_WRITEBACK
> 	bool
> 	depends on MEMCG && BLK_CGROUP
> --
> 2.20.1
>=20


--Apple-Mail=_E0EEFE40-49EC-4EEE-87DB-0FA82AA30057
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlz5/zoACgkQOAkCLQGo
9oPTgg//VqkMBah2cH/M9wKhbApkngh/tGZb+XrB8wLbbjXc2Y/pF6jEhz4smub9
1LFsJbUuP/ZvDMD4SwshVxmAeeIr7Qp8jPmE4Zkt3TdORnOZSQdNmT2QQPkQ3y9w
01uS7qllm6fS/HaQMGGQ4av8rn+bsfC2uXNRfoEwDvgodb0uPtSb34z8z6frUr7W
guc2upMyPSu6oUpF7M49M094K50WfGPhHmTKno9ibPnDMmGmoaobSIpptSrIpgo1
YrSr3gmjwE1Gi5dKjKKhdyfg9pyHJ6pfXUq3dUJCtFPos7QNVvmlJ6SEHr9E/i/6
YMgFObKPlnaRDDfXsQDU09sqZ/ZvP+1b/Q/HoXCB/GVq5VEnQ+4bAMT3lO+DhuTG
JUkT+nrHdfoix+Rboyxd8ZDt20tRTArlwMQftgf8/q3cyKiv+ISJi24CV1FNjh2J
yqmb3BxVAyWiBofr+K3fGL3rLcJm7+wMTCauATfabuMTGiKAmZLfN9Shf2UAg19o
1f9RDrXYJXC/1V+h7eyyfS3WCJwIAln5ur7BDuztHTZACaiuAMuHoH5omRjbheQL
iBAUIybb/bPWMiesX4ioku1fyboFFifIRaCUPh54iuBfhputMHZAW7Cp8tSxoY0w
4VAslbL7GWmElKZ1feFOnHacsC99/mTlNkdwasCqbnzCN5XA7u0=
=Y59C
-----END PGP SIGNATURE-----

--Apple-Mail=_E0EEFE40-49EC-4EEE-87DB-0FA82AA30057--
