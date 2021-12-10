Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894D846FEA4
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhLJKZC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 05:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbhLJKZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 05:25:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA107C061746
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 02:21:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so27641608edb.8
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 02:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9sCOFfVXKOb72pzCs42FTZ/cd5XaBleh+IQy0MaKkyI=;
        b=RZvN1zdXgjnJPYh2pBxHDRdgCKI0D7oHr0yrYysET1rY8G/67b/coHgj3VZndRUJTm
         c8xYdIaYYrgAszVsTSJ/RkVS5thuseN83YYdINUG04wOsTrjyN3nG3rI8BBhrbAKqMdL
         /fZILYMCwFN4Cf1m7eOWOO48m50vYsGaMHmb2uVTCowLNgRkfBr3k76bZvzNoi5MwH3B
         YkyLpSqBFONu3YRZRsCYAOz0u/lFQzw7ciAQlkuAVD5RqKZIceM5Wy88DJDP2WNW1R1h
         7af3OmbHmDrCt/Wg9nwmq59t0CfBZllRzeYVWDMBcgFftpsS+OHU9ci4ypVjqciWundh
         QuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9sCOFfVXKOb72pzCs42FTZ/cd5XaBleh+IQy0MaKkyI=;
        b=kyY4CWB6rdE07I6cPH0uFdCFhysan0/rUS999AehoRDa2X5rlHj+gX6rTAiOoqGSTQ
         /sw+Td2ePjEtpQ47bAV1M9XcnhH4ReZpNN3HgtfQ9njxqWivRBzIapSlGezDjfpr7Fm7
         N6+vfUB+MjmvUG+yBBimv1AC4K3RvWEzsBqu8xVRyHrBQ2yV75J1kr5gZIC5VOyItQqI
         19eC923l0Celo8JigrkpbYEwTRcdsJLPBXmPtqSDTJ218IIDVt26y1AgoDKUE4WBaFXn
         +rMbJDSYSy4U021rgh36//h5UE71oTgzd+2H8r3UW/T/e/9J5FdOCOJnuRzzDJQl9pxk
         djxg==
X-Gm-Message-State: AOAM532w8raMGLADPnNZepz5WykMfjZgubniJPxffGI9kGy7eowqzvYa
        qvAzxvbJMu2t5w12+Zel/fWQrw==
X-Google-Smtp-Source: ABdhPJz7sF43UpQzErjsFVZmXgfYQhT00lzuEPfqx7WCfBKoaQ3MLyw2l+Gq//5YVzmcx6RRAZ3h+Q==
X-Received: by 2002:a17:907:72d4:: with SMTP id du20mr23995269ejc.419.1639131685429;
        Fri, 10 Dec 2021 02:21:25 -0800 (PST)
Received: from [192.168.1.8] (net-93-70-85-65.cust.vodafonedsl.it. [93.70.85.65])
        by smtp.gmail.com with ESMTPSA id o8sm1256011edc.25.2021.12.10.02.21.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:21:24 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 9/9] block, bfq: decrease
 'num_groups_with_pending_reqs' earlier
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211127101132.486806-10-yukuai3@huawei.com>
Date:   Fri, 10 Dec 2021 11:21:23 +0100
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA66019E-FD14-4821-B53D-0C56EEC38828@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <20211127101132.486806-10-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Currently 'num_groups_with_pending_reqs' won't be decreased when
> the group doesn't have any pending requests, while any child group
> have any pending requests. The decrement is delayed to when all the
> child groups doesn't have any pending requests.
>=20
> For example:
> 1) t1 issue sync io on root group, t2 and t3 issue sync io on the same
> child group. num_groups_with_pending_reqs is 2 now.
> 2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 and
> t3 still can't be handled concurrently.
>=20
> Fix the problem by decreasing 'num_groups_with_pending_reqs'
> immediately upon the deactivation of last entity of the group.
>=20

I don't understand this patch clearly.

I understand your proposal not to count a group as with pending =
requests, in case no child process of the group has IO, but only its =
child groups have pending requests.

So, entities here are only queues for this patch?

If they are only queues, I think it is still incorrect to remove the =
group from the count of groups with pending IO when all its child queues =
are deactivated, because there may still be unfinished IO for those =
queues.

Am I missing something?

Thanks,
Paolo

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 58 ++++++++++++++++-----------------------------
> block/bfq-iosched.h | 16 ++++++-------
> 2 files changed, 29 insertions(+), 45 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 4239b3996e23..55925e1ee85d 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -873,6 +873,26 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 	bfq_put_queue(bfqq);
> }
>=20
> +static void decrease_groups_with_pending_reqs(struct bfq_data *bfqd,
> +					      struct bfq_queue *bfqq)
> +{
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	struct bfq_entity *entity =3D bfqq->entity.parent;
> +	struct bfq_group *bfqg =3D container_of(entity, struct =
bfq_group, entity);
> +
> +	/*
> +	 * The decrement of num_groups_with_pending_reqs is performed
> +	 * immediately upon the deactivation of last entity that have =
pending
> +	 * requests
> +	 */
> +	if (!bfqg->num_entities_with_pending_reqs &&
> +	    entity->in_groups_with_pending_reqs) {
> +		entity->in_groups_with_pending_reqs =3D false;
> +		bfqd->num_groups_with_pending_reqs--;
> +	}
> +#endif
> +}
> +
> /*
>  * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
>  * of active groups for each queue's inactive parent entity.
> @@ -880,46 +900,10 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> void bfq_weights_tree_remove(struct bfq_data *bfqd,
> 			     struct bfq_queue *bfqq)
> {
> -	struct bfq_entity *entity =3D bfqq->entity.parent;
> -
> 	bfqq->ref++;
> 	__bfq_weights_tree_remove(bfqd, bfqq,
> 				  &bfqd->queue_weights_tree);
> -
> -	for_each_entity(entity) {
> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
> -
> -		if (sd && (sd->next_in_service || =
sd->in_service_entity)) {
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
> +	decrease_groups_with_pending_reqs(bfqd, bfqq);
> 	bfq_put_queue(bfqq);
> }
>=20
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index df08bff89a70..7ae11f62900b 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -493,7 +493,7 @@ struct bfq_data {
> 	struct rb_root_cached queue_weights_tree;
>=20
> 	/*
> -	 * Number of groups with at least one descendant process that
> +	 * Number of groups with at least one process that
> 	 * has at least one request waiting for completion. Note that
> 	 * this accounts for also requests already dispatched, but not
> 	 * yet completed. Therefore this number of groups may differ
> @@ -506,14 +506,14 @@ struct bfq_data {
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
> @@ -522,7 +522,7 @@ struct bfq_data {
> 	 * we resort to the following tradeoff between simplicity and
> 	 * accuracy: for an inactive group that is still counted in
> 	 * num_groups_with_pending_reqs, we decrement
> -	 * num_groups_with_pending_reqs when the first descendant
> +	 * num_groups_with_pending_reqs when the last
> 	 * process of the group remains with no request waiting for
> 	 * completion.
> 	 *
> @@ -530,12 +530,12 @@ struct bfq_data {
> 	 * carefulness: to avoid multiple decrements, we flag a group,
> 	 * more precisely an entity representing a group, as still
> 	 * counted in num_groups_with_pending_reqs when it becomes
> -	 * inactive. Then, when the first descendant queue of the
> +	 * inactive. Then, when the last queue of the
> 	 * entity remains with no request waiting for completion,
> 	 * num_groups_with_pending_reqs is decremented, and this flag
> 	 * is reset. After this flag is reset for the entity,
> 	 * num_groups_with_pending_reqs won't be decremented any
> -	 * longer in case a new descendant queue of the entity remains
> +	 * longer in case a new queue of the entity remains
> 	 * with no request waiting for completion.
> 	 */
> 	unsigned int num_groups_with_pending_reqs;
> --=20
> 2.31.1
>=20

