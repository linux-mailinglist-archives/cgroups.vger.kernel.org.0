Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8A536BB4
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiE1Il1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiE1Il0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 04:41:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A138B9
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:41:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi33so12585928ejc.3
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JsowD/FKw18hVQ5jVTmKUZbc7LMslR1YU3BPL59H5LY=;
        b=Q8HxUOVdhSYnJUhe2dh0QTVD1RRwebd7LiivW9wmKnR0C4lfTpvl8fCWCS9FASbW4X
         O3mz71tYR+a8+z8CMxKrjM4ES0ONM0q9k9lSuI5w9s0AYAdcoEFK4ha3Qg1DuodiqyIr
         +RFUY/cU3Zo6+c/Dv9BjljGT8GWmdoeo56zLXGV0a3R7vEYgsec+rZmV80UFtrCAixMD
         xHVhuU7WWLaU4ibUYIsng8SwfoSCn3wINhqqwLZ1Vd4UgRS54h4zHd48cXYrWl7EqnFU
         MbkbMVfGw5USRlO219wF/CFNNVTsOz2PbZqCQ1AbBg2u3z7+/UQAwLCUkfyOKiItwgmw
         LUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JsowD/FKw18hVQ5jVTmKUZbc7LMslR1YU3BPL59H5LY=;
        b=45Evg0eXDNZaZgzzF4Vh78z++bqXuGXS02o/cZa811Awj2MzvgjbB6xSq5ko/1mp93
         CkFNft8JhRrZKTpLLUQaXq6Ymuu+PIaSGts8nQ1ckMr9D0pbRFXC7YOiYsCC3S1bB+/V
         /JbTtrbXAfAMowvwyJ/7a+mEfEcdUTMX99q7rFzIPrXhqDf3yOhjoOFC1g5lclpSMM5O
         aI98j+bgSl886sBszuX233znJyPHTbbByUhxWunHjeEDL90bbUK3hy3Jolt2vLBee52K
         e+RY3GICep1XQou/bIi2nNhu0yYIsBLIfW4MPyg4PQw9SLW5P76M8avwe5bDxVu+rRUa
         IFFQ==
X-Gm-Message-State: AOAM533ftH+z4VB4JLjt6SSUQ7T1ZYajOQp7MV7RER6ZnxGYf067aqRb
        TclYel56KF8d3qHs5LByZ86c+0Ou3ZfYoQ==
X-Google-Smtp-Source: ABdhPJxSc4BBRaRBvGKP89AL+7eCE3p4rNh9VAn6MuilJ3TYaVxUtYd4UjsGbnTekcNDMV2pssBMZw==
X-Received: by 2002:a17:907:2d8b:b0:6fe:aa75:6609 with SMTP id gt11-20020a1709072d8b00b006feaa756609mr35428883ejc.468.1653727281618;
        Sat, 28 May 2022 01:41:21 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id e25-20020a17090681d900b006f3ef214e77sm2162479ejx.221.2022.05.28.01.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2022 01:41:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v6 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <159f8c28-db93-6289-3df2-f88e8fbb3d32@huawei.com>
Date:   Sat, 28 May 2022 10:41:20 +0200
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A64AAAC-6795-4188-919A-EE6352E32C7C@linaro.org>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
 <20220523131818.2798712-3-yukuai3@huawei.com>
 <CB855885-1E3B-486A-875F-D25F9C1DD0D0@linaro.org>
 <159f8c28-db93-6289-3df2-f88e8fbb3d32@huawei.com>
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



> Il giorno 28 mag 2022, alle ore 10:39, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> =E5=9C=A8 2022/05/28 16:27, Paolo Valente =E5=86=99=E9=81=93:
>>> Il giorno 23 mag 2022, alle ore 15:18, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>=20
>>> Currently, bfq can't handle sync io concurrently as long as they
>>> are not issued from root group. This is because
>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>> bfq_asymmetric_scenario().
>>>=20
>>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>>=20
>>> Before this patch:
>>> 1) root group will never be counted.
>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>>=20
>>> After this patch:
>>> 1) root group is counted.
>>> 2) Count if bfqg have at least one bfqq that is marked busy.
>>> 3) Don't count if bfqg doesn't have any busy bfqqs.
>>>=20
>>> The main reason to use busy state of bfqq instead of 'pending =
requests'
>>> is that bfqq can stay busy after dispatching the last request if =
idling
>>> is needed for service guarantees.
>>>=20
>>> With this change, the occasion that only one group is activated can =
be
>>> detected, and next patch will support concurrent sync io in the
>>> occasion.
>>>=20
>>> This patch also rename 'num_groups_with_pending_reqs' to
>>> 'num_groups_with_busy_queues'.
>>>=20
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>> ---
>>> block/bfq-iosched.c | 46 ++-----------------------------------
>>> block/bfq-iosched.h | 55 =
++++++---------------------------------------
>>> block/bfq-wf2q.c    | 19 ++++------------
>>> 3 files changed, 13 insertions(+), 107 deletions(-)
>>>=20
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index e47c75f1fa0f..609b4e894684 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -844,7 +844,7 @@ static bool bfq_asymmetric_scenario(struct =
bfq_data *bfqd,
>>>=20
>>> 	return varied_queue_weights || multiple_classes_busy
>>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>>> -	       || bfqd->num_groups_with_pending_reqs > 0
>>> +	       || bfqd->num_groups_with_busy_queues > 0
>>> #endif
>>> 		;
>>> }
>>> @@ -962,48 +962,6 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
>>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>> 			     struct bfq_queue *bfqq)
>>> {
>>> -	struct bfq_entity *entity =3D bfqq->entity.parent;
>>> -
>>> -	for_each_entity(entity) {
>>> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
>>> -
>>> -		if (sd->next_in_service || sd->in_service_entity) {
>>> -			/*
>>> -			 * entity is still active, because either
>>> -			 * next_in_service or in_service_entity is not
>>> -			 * NULL (see the comments on the definition of
>>> -			 * next_in_service for details on why
>>> -			 * in_service_entity must be checked too).
>>> -			 *
>>> -			 * As a consequence, its parent entities are
>>> -			 * active as well, and thus this loop must
>>> -			 * stop here.
>>> -			 */
>>> -			break;
>>> -		}
>>> -
>>> -		/*
>>> -		 * The decrement of num_groups_with_pending_reqs is
>>> -		 * not performed immediately upon the deactivation of
>>> -		 * entity, but it is delayed to when it also happens
>>> -		 * that the first leaf descendant bfqq of entity gets
>>> -		 * all its pending requests completed. The following
>>> -		 * instructions perform this delayed decrement, if
>>> -		 * needed. See the comments on
>>> -		 * num_groups_with_pending_reqs for details.
>>> -		 */
>>> -		if (entity->in_groups_with_pending_reqs) {
>>> -			entity->in_groups_with_pending_reqs =3D false;
>>> -			bfqd->num_groups_with_pending_reqs--;
>>> -		}
>>> -	}
>>> -
>>> -	/*
>>> -	 * Next function is invoked last, because it causes bfqq to be
>>> -	 * freed if the following holds: bfqq is not in service and
>>> -	 * has no dispatched request. DO NOT use bfqq after the next
>>> -	 * function invocation.
>>> -	 */
>>> 	__bfq_weights_tree_remove(bfqd, bfqq,
>>> 				  &bfqd->queue_weights_tree);
>>> }
>>> @@ -7107,7 +7065,7 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
>>> 	bfqd->idle_slice_timer.function =3D bfq_idle_slice_timer;
>>>=20
>>> 	bfqd->queue_weights_tree =3D RB_ROOT_CACHED;
>>> -	bfqd->num_groups_with_pending_reqs =3D 0;
>>> +	bfqd->num_groups_with_busy_queues =3D 0;
>>>=20
>>> 	INIT_LIST_HEAD(&bfqd->active_list);
>>> 	INIT_LIST_HEAD(&bfqd->idle_list);
>>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>>> index 3847f4ab77ac..b71a088a7f1d 100644
>>> --- a/block/bfq-iosched.h
>>> +++ b/block/bfq-iosched.h
>>> @@ -197,9 +197,6 @@ struct bfq_entity {
>>> 	/* flag, set to request a weight, ioprio or ioprio_class change  =
*/
>>> 	int prio_changed;
>>>=20
>>> -	/* flag, set if the entity is counted in =
groups_with_pending_reqs */
>>> -	bool in_groups_with_pending_reqs;
>>> -
>>> 	/* last child queue of entity created (for non-leaf entities) */
>>> 	struct bfq_queue *last_bfqq_created;
>>> };
>>> @@ -495,52 +492,14 @@ struct bfq_data {
>>> 	struct rb_root_cached queue_weights_tree;
>>>=20
>>> 	/*
>>> -	 * Number of groups with at least one descendant process that
>>> -	 * has at least one request waiting for completion. Note that
>>> -	 * this accounts for also requests already dispatched, but not
>>> -	 * yet completed. Therefore this number of groups may differ
>>> -	 * (be larger) than the number of active groups, as a group is
>>> -	 * considered active only if its corresponding entity has
>>> -	 * descendant queues with at least one request queued. This
>>> -	 * number is used to decide whether a scenario is symmetric.
>>> -	 * For a detailed explanation see comments on the computation
>>> -	 * of the variable asymmetric_scenario in the function
>>> -	 * bfq_better_to_idle().
>>> -	 *
>>> -	 * However, it is hard to compute this number exactly, for
>>> -	 * groups with multiple descendant processes. Consider a group
>>> -	 * that is inactive, i.e., that has no descendant process with
>>> -	 * pending I/O inside BFQ queues. Then suppose that
>>> -	 * num_groups_with_pending_reqs is still accounting for this
>>> -	 * group, because the group has descendant processes with some
>>> -	 * I/O request still in flight. num_groups_with_pending_reqs
>>> -	 * should be decremented when the in-flight request of the
>>> -	 * last descendant process is finally completed (assuming that
>>> -	 * nothing else has changed for the group in the meantime, in
>>> -	 * terms of composition of the group and active/inactive state =
of child
>>> -	 * groups and processes). To accomplish this, an additional
>>> -	 * pending-request counter must be added to entities, and must
>>> -	 * be updated correctly. To avoid this additional field and =
operations,
>>> -	 * we resort to the following tradeoff between simplicity and
>>> -	 * accuracy: for an inactive group that is still counted in
>>> -	 * num_groups_with_pending_reqs, we decrement
>>> -	 * num_groups_with_pending_reqs when the first descendant
>>> -	 * process of the group remains with no request waiting for
>>> -	 * completion.
>>> -	 *
>>> -	 * Even this simpler decrement strategy requires a little
>>> -	 * carefulness: to avoid multiple decrements, we flag a group,
>>> -	 * more precisely an entity representing a group, as still
>>> -	 * counted in num_groups_with_pending_reqs when it becomes
>>> -	 * inactive. Then, when the first descendant queue of the
>>> -	 * entity remains with no request waiting for completion,
>>> -	 * num_groups_with_pending_reqs is decremented, and this flag
>>> -	 * is reset. After this flag is reset for the entity,
>>> -	 * num_groups_with_pending_reqs won't be decremented any
>>> -	 * longer in case a new descendant queue of the entity remains
>>> -	 * with no request waiting for completion.
>>> +	 * Number of groups with at least one bfqq that is marked busy,
>>> +	 * and this number is used to decide whether a scenario is =
symmetric.
>>> +	 * Note that bfqq is busy doesn't mean that the bfqq contains =
requests.
>>> +	 * If idling is needed for service guarantees, bfqq will stay =
busy
>>> +	 * after dispatching the last request, see details in
>>> +	 * __bfq_bfqq_expire().
>>> 	 */
>>> -	unsigned int num_groups_with_pending_reqs;
>>> +	unsigned int num_groups_with_busy_queues;
>>>=20
>>> 	/*
>>> 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>> index d9ff33e0be38..42464e6ff40c 100644
>>> --- a/block/bfq-wf2q.c
>>> +++ b/block/bfq-wf2q.c
>>> @@ -220,12 +220,14 @@ static bool =
bfq_no_longer_next_in_service(struct bfq_entity *entity)
>>>=20
>>> static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
>>> {
>>> -	bfqq_group(bfqq)->busy_queues++;
>>> +	if (!(bfqq_group(bfqq)->busy_queues++))
>>> +		bfqq->bfqd->num_groups_with_busy_queues++;
>>> }
>>>=20
>>> static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
>>> {
>>> -	bfqq_group(bfqq)->busy_queues--;
>>> +	if (!(--bfqq_group(bfqq)->busy_queues))
>> Are you sure this is correct?  You want to decrement
>> num_groups_with_busy_queues if busy_queues switches from 1 to 0.  But
>> if busy_queues =3D=3D 1, then !(busy_queues) is false.
>=20
> Hi, Paolo
>=20
> I'm sure this is correct.
>=20

Yeah, sorry, I didn't notice you switched to prefix increment here.

Paolo

> if busy_queues =3D=3D 1, then !(--busy_queues) is true; while
> !(busy_queues--) is false.
>=20
> Thanks,
> Kuai
>> Paolo
>>> +		bfqq->bfqd->num_groups_with_busy_queues--;
>>> }
>>>=20
>>> #else /* CONFIG_BFQ_GROUP_IOSCHED */
>>> @@ -1002,19 +1004,6 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
>>> 		entity->on_st_or_in_serv =3D true;
>>> 	}
>>>=20
>>> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>>> -		struct bfq_group *bfqg =3D
>>> -			container_of(entity, struct bfq_group, entity);
>>> -		struct bfq_data *bfqd =3D bfqg->bfqd;
>>> -
>>> -		if (!entity->in_groups_with_pending_reqs) {
>>> -			entity->in_groups_with_pending_reqs =3D true;
>>> -			bfqd->num_groups_with_pending_reqs++;
>>> -		}
>>> -	}
>>> -#endif
>>> -
>>> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
>>> }
>>>=20
>>> --=20
>>> 2.31.1
>>>=20
>> .

