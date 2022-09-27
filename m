Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7E5EC993
	for <lists+cgroups@lfdr.de>; Tue, 27 Sep 2022 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiI0Qdz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Sep 2022 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0Qdy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Sep 2022 12:33:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76D1D6D26
        for <cgroups@vger.kernel.org>; Tue, 27 Sep 2022 09:33:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a26so21901193ejc.4
        for <cgroups@vger.kernel.org>; Tue, 27 Sep 2022 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=NWib1BZP+0BB7z4L8r7ENuhYmK12OU/ifEJLPtod0pM=;
        b=Lp7cNiswBAVjx7sydDucguZBRf0PrssrUMOtaZeI8ib/1qgWy8iWPtVZHKmOn1aTG+
         PjdCVnotDv/LHd6tCYIZvh91PTBofanYhH0wwTG+pHp/dMgMoCpXSeN6fAVWlbcuwajc
         HNX6+ytAOHDunbIEk6FHC/ZLs7T+CYCU1I0Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NWib1BZP+0BB7z4L8r7ENuhYmK12OU/ifEJLPtod0pM=;
        b=X2BdeAdzdnnkoJV5L2Vv0QdxC99XvvH0dSNJY3ktAIUo3LpsMi5MYWeDJxBOvCv2mH
         V07CxP/FyQPv7FjhnpMUynCAZGlOi0xIqTKLX8usq8K++Sr1JwY58qvzjR5KO5rqvTAk
         wPiLhnvimVXM9Yu+IYvUsVR7enG0Udh1TPfFlcg0x8d7jGhRiLeFkFKoEYEi7xq6ZyH4
         lzIAz5W6AEj3Up3HZX9bgK6V7I8p8yFwnPaTlLngqoKJ5bi3OYFx5MU9bk9BWOOsxrlL
         w/j1trbJca4+mpJQmsOkHKxTK1tncVsj9Wca6zXzjadXtOAiKKLP5WQnAxLoTky9Q0fK
         /FTw==
X-Gm-Message-State: ACrzQf2AXxk+ewakHrQd7mDlSiRpoVch8mUm7EH7dF3KwIg+72mxh3Nd
        bNEIsBRjwtPI8af7B3GdEVYF
X-Google-Smtp-Source: AMsMyM6IDexLb7umbRFxKkkNVzZo6d/MZRCyIohiVXE9WTdiYRtYBhopjkNVYs8OTNX7IuCl1w1/xQ==
X-Received: by 2002:a17:906:844a:b0:77c:1d87:b81e with SMTP id e10-20020a170906844a00b0077c1d87b81emr23674827ejy.675.1664296430785;
        Tue, 27 Sep 2022 09:33:50 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7c3c2000000b00447e5983478sm1535580edr.76.2022.09.27.09.33.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:33:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [patch v11 3/6] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <11AC4611-79BC-478F-821E-7AF70BE69A04@linaro.org>
Date:   Tue, 27 Sep 2022 18:33:48 +0200
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7780B07-FE62-4E8B-ABE9-43A4295D6A0A@unimore.it>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <20220916071942.214222-4-yukuai1@huaweicloud.com>
 <11AC4611-79BC-478F-821E-7AF70BE69A04@linaro.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 27 set 2022, alle ore 18:32, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 16 set 2022, alle ore 09:19, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>>=20
>> From: Yu Kuai <yukuai3@huawei.com>
>>=20
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>>=20
>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>=20
>> Before this patch:
>> 1) root group will never be counted.
>> 2) Count if bfqg or it's child bfqgs have pending requests.
>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>=20
>> After this patch:
>> 1) root group is counted.
>> 2) Count if bfqg have pending requests.
>> 3) Don't count if bfqg complete all the requests.
>>=20
>> With this change, the occasion that only one group is activated can =
be
>> detected, and next patch will support concurrent sync io in the
>> occasion.
>>=20
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>> block/bfq-iosched.c | 42 ------------------------------------------
>> block/bfq-iosched.h | 18 +++++++++---------
>> block/bfq-wf2q.c    | 23 ++++++++---------------
>> 3 files changed, 17 insertions(+), 66 deletions(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 0dcae2f52896..970b302a7a3e 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> 			     struct bfq_queue *bfqq)
>> {
>> -	struct bfq_entity *entity =3D bfqq->entity.parent;
>> -
>> -	for_each_entity(entity) {
>> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
>> -
>> -		if (sd->next_in_service || sd->in_service_entity) {
>> -			/*
>> -			 * entity is still active, because either
>> -			 * next_in_service or in_service_entity is not
>> -			 * NULL (see the comments on the definition of
>> -			 * next_in_service for details on why
>> -			 * in_service_entity must be checked too).
>> -			 *
>> -			 * As a consequence, its parent entities are
>> -			 * active as well, and thus this loop must
>> -			 * stop here.
>> -			 */
>> -			break;
>> -		}
>> -
>> -		/*
>> -		 * The decrement of num_groups_with_pending_reqs is
>> -		 * not performed immediately upon the deactivation of
>> -		 * entity, but it is delayed to when it also happens
>> -		 * that the first leaf descendant bfqq of entity gets
>> -		 * all its pending requests completed. The following
>> -		 * instructions perform this delayed decrement, if
>> -		 * needed. See the comments on
>> -		 * num_groups_with_pending_reqs for details.
>> -		 */
>> -		if (entity->in_groups_with_pending_reqs) {
>> -			entity->in_groups_with_pending_reqs =3D false;
>> -			bfqd->num_groups_with_pending_reqs--;
>> -		}
>> -	}
>> -
>> -	/*
>> -	 * Next function is invoked last, because it causes bfqq to be
>> -	 * freed if the following holds: bfqq is not in service and
>> -	 * has no dispatched request. DO NOT use bfqq after the next
>> -	 * function invocation.
>> -	 */
>> 	__bfq_weights_tree_remove(bfqd, bfqq,
>> 				  &bfqd->queue_weights_tree);
>=20
> Why are you keeping the wrapper function bfq_weights_tree_remove() if =
it contains only the invocation of __bfq_weights_tree_remove()?
>=20

I had not seen patch 6/6, sorry.

Paolo

>> }
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 338ff5418ea8..257acb54c6dc 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -496,27 +496,27 @@ struct bfq_data {
>> 	struct rb_root_cached queue_weights_tree;
>>=20
>> 	/*
>> -	 * Number of groups with at least one descendant process that
>> +	 * Number of groups with at least one process that
>> 	 * has at least one request waiting for completion. Note that
>> 	 * this accounts for also requests already dispatched, but not
>> 	 * yet completed. Therefore this number of groups may differ
>> 	 * (be larger) than the number of active groups, as a group is
>> 	 * considered active only if its corresponding entity has
>> -	 * descendant queues with at least one request queued. This
>> +	 * queues with at least one request queued. This
>> 	 * number is used to decide whether a scenario is symmetric.
>> 	 * For a detailed explanation see comments on the computation
>> 	 * of the variable asymmetric_scenario in the function
>> 	 * bfq_better_to_idle().
>> 	 *
>> 	 * However, it is hard to compute this number exactly, for
>> -	 * groups with multiple descendant processes. Consider a group
>> -	 * that is inactive, i.e., that has no descendant process with
>> +	 * groups with multiple processes. Consider a group
>> +	 * that is inactive, i.e., that has no process with
>> 	 * pending I/O inside BFQ queues. Then suppose that
>> 	 * num_groups_with_pending_reqs is still accounting for this
>> -	 * group, because the group has descendant processes with some
>> +	 * group, because the group has processes with some
>> 	 * I/O request still in flight. num_groups_with_pending_reqs
>> 	 * should be decremented when the in-flight request of the
>> -	 * last descendant process is finally completed (assuming that
>> +	 * last process is finally completed (assuming that
>> 	 * nothing else has changed for the group in the meantime, in
>> 	 * terms of composition of the group and active/inactive state =
of child
>> 	 * groups and processes). To accomplish this, an additional
>> @@ -525,7 +525,7 @@ struct bfq_data {
>> 	 * we resort to the following tradeoff between simplicity and
>> 	 * accuracy: for an inactive group that is still counted in
>> 	 * num_groups_with_pending_reqs, we decrement
>> -	 * num_groups_with_pending_reqs when the first descendant
>> +	 * num_groups_with_pending_reqs when the first
>> 	 * process of the group remains with no request waiting for
>> 	 * completion.
>> 	 *
>> @@ -533,12 +533,12 @@ struct bfq_data {
>> 	 * carefulness: to avoid multiple decrements, we flag a group,
>> 	 * more precisely an entity representing a group, as still
>> 	 * counted in num_groups_with_pending_reqs when it becomes
>> -	 * inactive. Then, when the first descendant queue of the
>> +	 * inactive. Then, when the first queue of the
>> 	 * entity remains with no request waiting for completion,
>> 	 * num_groups_with_pending_reqs is decremented, and this flag
>> 	 * is reset. After this flag is reset for the entity,
>> 	 * num_groups_with_pending_reqs won't be decremented any
>> -	 * longer in case a new descendant queue of the entity remains
>> +	 * longer in case a new queue of the entity remains
>> 	 * with no request waiting for completion.
>> 	 */
>> 	unsigned int num_groups_with_pending_reqs;
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 5549ccf09cd2..5e8224c96921 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -984,19 +984,6 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
>> 		entity->on_st_or_in_serv =3D true;
>> 	}
>>=20
>> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>> -		struct bfq_group *bfqg =3D
>> -			container_of(entity, struct bfq_group, entity);
>> -		struct bfq_data *bfqd =3D bfqg->bfqd;
>> -
>> -		if (!entity->in_groups_with_pending_reqs) {
>> -			entity->in_groups_with_pending_reqs =3D true;
>> -			bfqd->num_groups_with_pending_reqs++;
>> -		}
>> -	}
>> -#endif
>> -
>> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
>> }
>>=20
>> @@ -1653,7 +1640,8 @@ void =
bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>> 	if (!entity->in_groups_with_pending_reqs) {
>> 		entity->in_groups_with_pending_reqs =3D true;
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
>> +		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
>> +			bfqq->bfqd->num_groups_with_pending_reqs++;
>> #endif
>> 	}
>> }
>> @@ -1665,7 +1653,8 @@ void =
bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>> 	if (entity->in_groups_with_pending_reqs) {
>> 		entity->in_groups_with_pending_reqs =3D false;
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
>> +		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
>> +			bfqq->bfqd->num_groups_with_pending_reqs--;
>> #endif
>> 	}
>> }
>> @@ -1694,6 +1683,10 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, =
bool expiration)
>>=20
>> 	if (!bfqq->dispatched) {
>> 		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>> +		/*
>> +		 * Next function is invoked last, because it causes bfqq =
to be
>> +		 * freed. DO NOT use bfqq after the next function =
invocation.
>> +		 */
>=20
> Great, you moved this comment to the best place.
>=20
> Thanks,
> Paolo
>=20
>> 		bfq_weights_tree_remove(bfqd, bfqq);
>> 	}
>> }
>> --=20
>> 2.31.1

