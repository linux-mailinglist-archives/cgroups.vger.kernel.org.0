Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A533557EA9
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiFWPdH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiFWPdF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 11:33:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D955F75
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 08:33:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o8so28512575wro.3
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T+jpYYOmmAX0tTKDun9RBpmd7SAR9bivQfLucksvyjg=;
        b=qpbQec73keboHodaP5ziYd1RpAKQqcvoAXsEGV85lzoEhwbJVc+8syz7um4I/eSFwj
         +NKnV+I/yjQxjihPuFbbBVB6I4VQNahSOkTUqxSzfBCsHDq6LcpWV0AmkMQ39mR2o6G9
         6oVsbtMZVy8rzLpPCyRUvYjzZkkjU1dzqyGvnsb+E9q1fBegaF4ii3uJMHQLYPpd+zjc
         3EU024R4KYr2VByEKn+oD14NdJYLSHOEwR7/YVwAkLqMyf+sLzKZjanEI2ID2UbMD76T
         xnI7ygGgW+dZClKFdVBeecCzS/CLoyqGi9XsSsy+CwFTfIRwrCgFVZcJRuWWsO13Xo1W
         D/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T+jpYYOmmAX0tTKDun9RBpmd7SAR9bivQfLucksvyjg=;
        b=jrDDuzzNeazr1bacG07HccEHcB+oBUGHcoH84OLLW+j1dohbKUUaHM41uilZ4AnWMe
         sxRc/suXHSLZRAcHw0KFPz0PYRYeT6OYycSmr2ZHUtxCD2wKhWflnoQrkTKgJ99Q8p0l
         cDjIiHIyAZunwoNRXBdDFUlxhsrPf7Lws5RY98rLzWeRmpgh7GShXclr1mowlL/1ihZS
         fq2NKHVr0iljuZ+pMZzipj4DbDl73M9HX7DNEiN/0fBSBcoSRabF9CmS7RnVULyhX5ZF
         o7bZ9+tDVZ+rE/cHxbsHGehYRhsgYnbAaQuiO9sCCrI2jHF2NClUvp7hjsp28smzOSJb
         D8Lw==
X-Gm-Message-State: AJIora/CI9j+OSrLA5JaCL4lz4oIuddlK8QIZ+sIz4OmZHUvC6Lbk2qG
        tD3DeadpPds2dn17Z4AJRBeSDA==
X-Google-Smtp-Source: AGRyM1uJz8mHw8Y25qWrS5jl8b23C+Su6yMsHBR1wYZcqVe31bpUMmp/XYStN6A1o8HxoZxYfsnDJw==
X-Received: by 2002:a05:6000:1789:b0:219:2aa8:7159 with SMTP id e9-20020a056000178900b002192aa87159mr8504373wrg.474.1655998382265;
        Thu, 23 Jun 2022 08:33:02 -0700 (PDT)
Received: from oppo-a74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id bw8-20020a0560001f8800b0021b9cfca781sm6885583wrb.45.2022.06.23.08.33.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:33:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220610021701.2347602-4-yukuai3@huawei.com>
Date:   Thu, 23 Jun 2022 17:32:59 +0200
Cc:     Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry for the delay.

> Il giorno 10 giu 2022, alle ore 04:17, Yu Kuai <yukuai3@huawei.com> ha =
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
> 2) Count if bfqg have pending requests.
> 3) Don't count if bfqg complete all the requests.
>=20
> With this change, the occasion that only one group is activated can be
> detected, and next patch will support concurrent sync io in the
> occasion.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 42 ------------------------------------------
> block/bfq-iosched.h | 18 +++++++++---------
> block/bfq-wf2q.c    | 19 ++++---------------
> 3 files changed, 13 insertions(+), 66 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0ec21018daba..03b04892440c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
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

With this part removed, I'm missing how you handle the following
sequence of events:
1.  a queue Q becomes non busy but still has dispatched requests, so
it must not be removed from the counter of queues with pending reqs
yet
2.  the last request of Q is completed with Q being still idle (non
busy).  At this point Q must be removed from the counter.  It seems to
me that this case is not handled any longer

Additional comment: if your changes do not cpus the problem above,
then this function only invokes __bfq_weights_tree_remove.  So what's
the point in keeping this function)

> -
> -	/*
> -	 * Next function is invoked last, because it causes bfqq to be
> -	 * freed if the following holds: bfqq is not in service and
> -	 * has no dispatched request. DO NOT use bfqq after the next
> -	 * function invocation.
> -	 */

I would really love it if you leave this comment.  I added it after
suffering a lot for a nasty UAF.  Of course the first sentence may
need to be adjusted if the code that precedes it is to be removed.

Thanks,
Paolo


> 	__bfq_weights_tree_remove(bfqd, bfqq,
> 				  &bfqd->queue_weights_tree);
> }
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index de2446a9b7ab..f0fce94583e4 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -496,27 +496,27 @@ struct bfq_data {
> 	struct rb_root_cached queue_weights_tree;
>=20
> 	/*
> -	 * Number of groups with at least one descendant process that
> +	 * Number of groups with at least one process that
> 	 * has at least one request waiting for completion. Note that
> 	 * this accounts for also requests already dispatched, but not
> 	 * yet completed. Therefore this number of groups may differ
> 	 * (be larger) than the number of active groups, as a group is
> 	 * considered active only if its corresponding entity has
> -	 * descendant queues with at least one request queued. This
> +	 * queues with at least one request queued. This
> 	 * number is used to decide whether a scenario is symmetric.
> 	 * For a detailed explanation see comments on the computation
> 	 * of the variable asymmetric_scenario in the function
> 	 * bfq_better_to_idle().
> 	 *
> 	 * However, it is hard to compute this number exactly, for
> -	 * groups with multiple descendant processes. Consider a group
> -	 * that is inactive, i.e., that has no descendant process with
> +	 * groups with multiple processes. Consider a group
> +	 * that is inactive, i.e., that has no process with
> 	 * pending I/O inside BFQ queues. Then suppose that
> 	 * num_groups_with_pending_reqs is still accounting for this
> -	 * group, because the group has descendant processes with some
> +	 * group, because the group has processes with some
> 	 * I/O request still in flight. num_groups_with_pending_reqs
> 	 * should be decremented when the in-flight request of the
> -	 * last descendant process is finally completed (assuming that
> +	 * last process is finally completed (assuming that
> 	 * nothing else has changed for the group in the meantime, in
> 	 * terms of composition of the group and active/inactive state =
of child
> 	 * groups and processes). To accomplish this, an additional
> @@ -525,7 +525,7 @@ struct bfq_data {
> 	 * we resort to the following tradeoff between simplicity and
> 	 * accuracy: for an inactive group that is still counted in
> 	 * num_groups_with_pending_reqs, we decrement
> -	 * num_groups_with_pending_reqs when the first descendant
> +	 * num_groups_with_pending_reqs when the first
> 	 * process of the group remains with no request waiting for
> 	 * completion.
> 	 *
> @@ -533,12 +533,12 @@ struct bfq_data {
> 	 * carefulness: to avoid multiple decrements, we flag a group,
> 	 * more precisely an entity representing a group, as still
> 	 * counted in num_groups_with_pending_reqs when it becomes
> -	 * inactive. Then, when the first descendant queue of the
> +	 * inactive. Then, when the first queue of the
> 	 * entity remains with no request waiting for completion,
> 	 * num_groups_with_pending_reqs is decremented, and this flag
> 	 * is reset. After this flag is reset for the entity,
> 	 * num_groups_with_pending_reqs won't be decremented any
> -	 * longer in case a new descendant queue of the entity remains
> +	 * longer in case a new queue of the entity remains
> 	 * with no request waiting for completion.
> 	 */
> 	unsigned int num_groups_with_pending_reqs;
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 6f36f3fe5cc8..9c2842bedf97 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -984,19 +984,6 @@ static void __bfq_activate_entity(struct =
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
> @@ -1654,7 +1641,8 @@ void =
bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> 	if (!entity->in_groups_with_pending_reqs) {
> 		entity->in_groups_with_pending_reqs =3D true;
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
> +		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
> +			bfqq->bfqd->num_groups_with_pending_reqs++;
> #endif
> 	}
> }
> @@ -1666,7 +1654,8 @@ void =
bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> 	if (entity->in_groups_with_pending_reqs) {
> 		entity->in_groups_with_pending_reqs =3D false;
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
> +		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
> +			bfqq->bfqd->num_groups_with_pending_reqs--;
> #endif
> 	}
> }
> --=20
> 2.31.1
>=20

