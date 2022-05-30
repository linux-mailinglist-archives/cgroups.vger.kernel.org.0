Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C041537651
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiE3IKH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiE3IKF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 04:10:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183075231
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 01:10:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b8so4495315edf.11
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kd0CCk3LCRGaJbR7VB5KtX1TXqRTWxU6Qhf/vwEDl04=;
        b=j24uc8Ag4iPMN4ajktr6aP+Xgax39Yfqn51EeuP6JqPfb6E4YD4zRnVqqV1ds9Doxk
         orgi1Z0vPVnXzZJFiJmQ+WBnnFnji/hsZ8UB7eESAJ98oebxIS5ik0IF2HswOjKHyg9c
         BmpT6qp2p7ypBk0Xy4dMP5uV1IAfdypF29IrTTixHvoVZrM7z5f+WYJNCV7E+cfiEQFB
         VGy+X1zZ5owWzkm9coIbbXObazgKO3sBj5cpbnNhNLzFar5p87rbBlG7qvuLA6+8i1KP
         F7l0zT8RO2PiUx7EYcU99QMt+tP9kUuqZnPaXpBP2kNhPjfo4m9gomLVg31aIxpDPhg3
         viPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kd0CCk3LCRGaJbR7VB5KtX1TXqRTWxU6Qhf/vwEDl04=;
        b=XxaxHmBu73mmvJP/MosuiOTYUWVR0z90p75NnaqeeX4y75woEI135ubSaBRZP+10aS
         u9E+OwGmDfiFFGJAT1JDWakuetW6Q4vAuwd9/RlsznInTHSwVE6VINssRYyJqGD4XXAz
         Z1r03FyPvahAqK+2hNZAJD1szYvV6+gx31x8h5LB/P7OlmuzFnNAkIZcxoLvU+a1xeOM
         8drtpb+CNh0gLPQ3k0xwFsA7nehx4WnpIm1SFbCDWdEdQlMLyvz+4SkqiA6pP9y3W6Rv
         DXvxWfDVOZKFbxMLi+U2wBRwMOtM+/ioQPodmaS8ump+Bf/VHBLeytnpcOcAlNrEgdss
         P1EA==
X-Gm-Message-State: AOAM5337fWVDvX2l31oRok6IRUmGbkD5XfSCAdAf5ZoaH3mhVUQ3CjEK
        w8UDp3oJ4GINT1MSPPdfRcTMCIJzi5XMTA==
X-Google-Smtp-Source: ABdhPJyR0Ap0vvV9MQC6yDeV6wFNnk2l2gN0Cfm3bTfmzWeXwuYnGuUl4/kq+OJlfmhn74q1Y76s9w==
X-Received: by 2002:a05:6402:4316:b0:42b:4d3d:c064 with SMTP id m22-20020a056402431600b0042b4d3dc064mr42706814edc.194.1653898202222;
        Mon, 30 May 2022 01:10:02 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.dsl.teletu.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id v4-20020a50a444000000b0042ab87ea713sm4973920edb.22.2022.05.30.01.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 01:10:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v7 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220528095020.186970-3-yukuai3@huawei.com>
Date:   Mon, 30 May 2022 10:10:00 +0200
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D9355CE-F85B-4B1A-AEC3-F63DFC4B3A54@linaro.org>
References: <20220528095020.186970-1-yukuai3@huawei.com>
 <20220528095020.186970-3-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 28 mag 2022, alle ore 11:50, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
>=20
> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>=20
> Before this patch:
> 1) root group will never be counted.
> 2) Count if bfqg or it's child bfqgs have pending requests.
> 3) Don't count if bfqg and it's child bfqgs complete all the requests.
>=20
> After this patch:
> 1) root group is counted.
> 2) Count if bfqg have at least one bfqq that is marked busy.
> 3) Don't count if bfqg doesn't have any busy bfqqs.

Unfortunately, I see a last problem here. I see a double change:
(1) a bfqg is now counted only as a function of the state of its child
    queues, and not of also its child bfqgs
(2) the state considered for counting a bfqg moves from having pending
    requests to having busy queues

I'm ok with with (1), which is a good catch (you are lady explained
the idea to me some time ago IIRC).

Yet I fear that (2) is not ok.  A bfqq can become non busy even if it
still has in-flight I/O, i.e.  I/O being served in the drive.  The
weight of such a bfqq must still be considered in the weights_tree,
and the group containing such a queue must still be counted when
checking whether the scenario is asymmetric.  Otherwise service
guarantees are broken.  The reason is that, if a scenario is deemed as
symmetric because in-flight I/O is not taken into account, then idling
will not be performed to protect some bfqq, and in-flight I/O may
steal bandwidth to that bfqq in an uncontrolled way.

I verified this also experimentally a few years ago, when I added this
weights_tree stuff.  That's the rationale behind the part of
bfq_weights_tree_remove that this patch eliminates.  IOW,
for a bfqq and its parent bfqg to be out of the count for symmetry,
all bfqq's requests must also be completed.

Thanks,
Paolo

>=20
> The main reason to use busy state of bfqq instead of 'pending =
requests'
> is that bfqq can stay busy after dispatching the last request if =
idling
> is needed for service guarantees.
>=20
> With this change, the occasion that only one group is activated can be
> detected, and next patch will support concurrent sync io in the
> occasion.
>=20
> This patch also rename 'num_groups_with_pending_reqs' to
> 'num_groups_with_busy_queues'.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 46 ++-----------------------------------
> block/bfq-iosched.h | 55 ++++++---------------------------------------
> block/bfq-wf2q.c    | 19 ++++------------
> 3 files changed, 13 insertions(+), 107 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0d46cb728bbf..eb1da1bd5eb4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -852,7 +852,7 @@ static bool bfq_asymmetric_scenario(struct =
bfq_data *bfqd,
>=20
> 	return varied_queue_weights || multiple_classes_busy
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	       || bfqd->num_groups_with_pending_reqs > 0
> +	       || bfqd->num_groups_with_busy_queues > 0
> #endif
> 		;
> }
> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> void bfq_weights_tree_remove(struct bfq_data *bfqd,
> 			     struct bfq_queue *bfqq)
> {
> -	struct bfq_entity *entity =3D bfqq->entity.parent;
> -
> -	for_each_entity(entity) {
> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
> -
> -		if (sd->next_in_service || sd->in_service_entity) {
> -			/*
> -			 * entity is still active, because either
> -			 * next_in_service or in_service_entity is not
> -			 * NULL (see the comments on the definition of
> -			 * next_in_service for details on why
> -			 * in_service_entity must be checked too).
> -			 *
> -			 * As a consequence, its parent entities are
> -			 * active as well, and thus this loop must
> -			 * stop here.
> -			 */
> -			break;
> -		}
> -
> -		/*
> -		 * The decrement of num_groups_with_pending_reqs is
> -		 * not performed immediately upon the deactivation of
> -		 * entity, but it is delayed to when it also happens
> -		 * that the first leaf descendant bfqq of entity gets
> -		 * all its pending requests completed. The following
> -		 * instructions perform this delayed decrement, if
> -		 * needed. See the comments on
> -		 * num_groups_with_pending_reqs for details.
> -		 */
> -		if (entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D false;
> -			bfqd->num_groups_with_pending_reqs--;
> -		}
> -	}
> -
> -	/*
> -	 * Next function is invoked last, because it causes bfqq to be
> -	 * freed if the following holds: bfqq is not in service and
> -	 * has no dispatched request. DO NOT use bfqq after the next
> -	 * function invocation.
> -	 */
> 	__bfq_weights_tree_remove(bfqd, bfqq,
> 				  &bfqd->queue_weights_tree);
> }
> @@ -7118,7 +7076,7 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
> 	bfqd->idle_slice_timer.function =3D bfq_idle_slice_timer;
>=20
> 	bfqd->queue_weights_tree =3D RB_ROOT_CACHED;
> -	bfqd->num_groups_with_pending_reqs =3D 0;
> +	bfqd->num_groups_with_busy_queues =3D 0;
>=20
> 	INIT_LIST_HEAD(&bfqd->active_list);
> 	INIT_LIST_HEAD(&bfqd->idle_list);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index d92adbdd70ee..6c6cd984d769 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -197,9 +197,6 @@ struct bfq_entity {
> 	/* flag, set to request a weight, ioprio or ioprio_class change  =
*/
> 	int prio_changed;
>=20
> -	/* flag, set if the entity is counted in =
groups_with_pending_reqs */
> -	bool in_groups_with_pending_reqs;
> -
> 	/* last child queue of entity created (for non-leaf entities) */
> 	struct bfq_queue *last_bfqq_created;
> };
> @@ -496,52 +493,14 @@ struct bfq_data {
> 	struct rb_root_cached queue_weights_tree;
>=20
> 	/*
> -	 * Number of groups with at least one descendant process that
> -	 * has at least one request waiting for completion. Note that
> -	 * this accounts for also requests already dispatched, but not
> -	 * yet completed. Therefore this number of groups may differ
> -	 * (be larger) than the number of active groups, as a group is
> -	 * considered active only if its corresponding entity has
> -	 * descendant queues with at least one request queued. This
> -	 * number is used to decide whether a scenario is symmetric.
> -	 * For a detailed explanation see comments on the computation
> -	 * of the variable asymmetric_scenario in the function
> -	 * bfq_better_to_idle().
> -	 *
> -	 * However, it is hard to compute this number exactly, for
> -	 * groups with multiple descendant processes. Consider a group
> -	 * that is inactive, i.e., that has no descendant process with
> -	 * pending I/O inside BFQ queues. Then suppose that
> -	 * num_groups_with_pending_reqs is still accounting for this
> -	 * group, because the group has descendant processes with some
> -	 * I/O request still in flight. num_groups_with_pending_reqs
> -	 * should be decremented when the in-flight request of the
> -	 * last descendant process is finally completed (assuming that
> -	 * nothing else has changed for the group in the meantime, in
> -	 * terms of composition of the group and active/inactive state =
of child
> -	 * groups and processes). To accomplish this, an additional
> -	 * pending-request counter must be added to entities, and must
> -	 * be updated correctly. To avoid this additional field and =
operations,
> -	 * we resort to the following tradeoff between simplicity and
> -	 * accuracy: for an inactive group that is still counted in
> -	 * num_groups_with_pending_reqs, we decrement
> -	 * num_groups_with_pending_reqs when the first descendant
> -	 * process of the group remains with no request waiting for
> -	 * completion.
> -	 *
> -	 * Even this simpler decrement strategy requires a little
> -	 * carefulness: to avoid multiple decrements, we flag a group,
> -	 * more precisely an entity representing a group, as still
> -	 * counted in num_groups_with_pending_reqs when it becomes
> -	 * inactive. Then, when the first descendant queue of the
> -	 * entity remains with no request waiting for completion,
> -	 * num_groups_with_pending_reqs is decremented, and this flag
> -	 * is reset. After this flag is reset for the entity,
> -	 * num_groups_with_pending_reqs won't be decremented any
> -	 * longer in case a new descendant queue of the entity remains
> -	 * with no request waiting for completion.
> +	 * Number of groups with at least one bfqq that is marked busy,
> +	 * and this number is used to decide whether a scenario is =
symmetric.
> +	 * Note that bfqq is busy doesn't mean that the bfqq contains =
requests.
> +	 * If idling is needed for service guarantees, bfqq will stay =
busy
> +	 * after dispatching the last request, see details in
> +	 * __bfq_bfqq_expire().
> 	 */
> -	unsigned int num_groups_with_pending_reqs;
> +	unsigned int num_groups_with_busy_queues;
>=20
> 	/*
> 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index b97e33688335..48ca7922035c 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -221,13 +221,15 @@ static bool bfq_no_longer_next_in_service(struct =
bfq_entity *entity)
> static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> {
> 	bfqq->bfqd->busy_queues[bfqq->ioprio_class - 1]++;
> -	bfqq_group(bfqq)->busy_queues++;
> +	if (!(bfqq_group(bfqq)->busy_queues++))
> +		bfqq->bfqd->num_groups_with_busy_queues++;
> }
>=20
> static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> {
> 	bfqq->bfqd->busy_queues[bfqq->ioprio_class - 1]--;
> -	bfqq_group(bfqq)->busy_queues--;
> +	if (!(--bfqq_group(bfqq)->busy_queues))
> +		bfqq->bfqd->num_groups_with_busy_queues--;
> }
>=20
> #else /* CONFIG_BFQ_GROUP_IOSCHED */
> @@ -1006,19 +1008,6 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 		entity->on_st_or_in_serv =3D true;
> 	}
>=20
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> -		struct bfq_group *bfqg =3D
> -			container_of(entity, struct bfq_group, entity);
> -		struct bfq_data *bfqd =3D bfqg->bfqd;
> -
> -		if (!entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D true;
> -			bfqd->num_groups_with_pending_reqs++;
> -		}
> -	}
> -#endif
> -
> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
> }
>=20
> --=20
> 2.31.1
>=20

