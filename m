Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A27536B9D
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353398AbiE1ISQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiE1ISP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 04:18:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A8B1E7
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:18:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id q15so7837991edb.11
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zKQyiSCqOmFTXYg1oyMhrbRM1Y8cO4uyy6QdrPFWc8E=;
        b=Frk0CGa66mdgvvN98mA9x6NKT/Z+nOGLGMG5bYj54sZE8Lhp9JhuJvuNY8yJL6EsZI
         J3KIhCqyxlqhcg12/bSe/job0NO779KynECC8rcca8uR6CiSMYGeq+csLaG62ntXqacJ
         dES90AYO7hHJd/EBXB70EazwxzZAxQ/XqUC68IfGd/viKP5tX3k5dd7+J3dFugplJ0ZL
         HCtaNmUK65p5QGjx9s99ZizndE/FKgUz8a6LdwkrXWbXo8MBz6hq33pm7UTq4M7V0Qgp
         HStjHM0DBPi2iLS3eYgBuKVtopPlt2JeDZsqhPmHs5vRh2cFRTyoyDGf+vcfRFuYNDFQ
         jvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zKQyiSCqOmFTXYg1oyMhrbRM1Y8cO4uyy6QdrPFWc8E=;
        b=n+vIjWsPSV0r+V8EMRqVkRCuwTykjg8EYHcjvVThsBXIAdtSsF5+67O/5UX9i67eG3
         QWsMVMgpmamHAHMNnMiKrtMQc9cV18P4yFoR95LS0Tpg6fvx+rhPpzSNmiPPr79oKUNb
         tCPZEASmIF3qgEbz5H9tbLG+mYgCfveezGtWiC9tgV+M77w9hugpynCKD+VnXU+dM8pR
         re5fkR5CR9iwVp3SVFixfliycogasY1W4e/hSwJWJg541+LkI6bSeYDc0mvzDn43ifHW
         h+HelAyul3wkFuzdh6pSz0A7d/Mdviz1HXNrSduC3ZT10VWWDd9HTUWfeuAKnVLamUyG
         1VuQ==
X-Gm-Message-State: AOAM533ouN+VYVk1LaKDg4iSMJAcuX0pafnnOJsxnzBIaGXhqpbY7NST
        BvIcyXS8spfvX7/uSjOoqsUIGA==
X-Google-Smtp-Source: ABdhPJzkCFu6x05fcv5zy5p9pRsXjO3tHc/29aE81RFzfZb8y9BAPOboblWZf2SnMwvN6zlvY9fC0w==
X-Received: by 2002:a05:6402:1d50:b0:42b:6da9:ed34 with SMTP id dz16-20020a0564021d5000b0042b6da9ed34mr29184832edb.333.1653725892829;
        Sat, 28 May 2022 01:18:12 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906955400b006feec47dae9sm2126208ejy.157.2022.05.28.01.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2022 01:18:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v6 1/3] block, bfq: record how many queues are busy
 in bfq_group
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220523131818.2798712-2-yukuai3@huawei.com>
Date:   Sat, 28 May 2022 10:18:11 +0200
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D29A46A-4B8A-4F05-BCE3-D9D0F0D2DD5A@linaro.org>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
 <20220523131818.2798712-2-yukuai3@huawei.com>
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



> Il giorno 23 mag 2022, alle ore 15:18, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
>=20
> Add a counter 'busy_queues' in bfq_group, and update it in
> bfq_add/del_bfqq_busy().
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-cgroup.c  |  1 +
> block/bfq-iosched.h |  2 ++
> block/bfq-wf2q.c    | 20 ++++++++++++++++++++
> 3 files changed, 23 insertions(+)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 09574af83566..4d516879d9fa 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data =
*pd)
> 				   */
> 	bfqg->bfqd =3D bfqd;
> 	bfqg->active_entities =3D 0;
> +	bfqg->busy_queues =3D 0;
> 	bfqg->online =3D true;
> 	bfqg->rq_pos_tree =3D RB_ROOT;
> }
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 978ef5d6fe6a..3847f4ab77ac 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -906,6 +906,7 @@ struct bfq_group_data {
>  *                   are groups with more than one active @bfq_entity
>  *                   (see the comments to the function
>  *                   bfq_bfqq_may_idle()).
> + * @busy_queues: number of busy bfqqs.
>  * @rq_pos_tree: rbtree sorted by next_request position, used when
>  *               determining if two or more queues have interleaving
>  *               requests (see bfq_find_close_cooperator()).
> @@ -942,6 +943,7 @@ struct bfq_group {
> 	struct bfq_entity *my_entity;
>=20
> 	int active_entities;
> +	int busy_queues;
>=20
> 	struct rb_root rq_pos_tree;
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..d9ff33e0be38 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -218,6 +218,16 @@ static bool bfq_no_longer_next_in_service(struct =
bfq_entity *entity)
> 	return false;
> }
>=20
> +static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues++;
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues--;
> +}
> +
> #else /* CONFIG_BFQ_GROUP_IOSCHED */
>=20
> static bool bfq_update_parent_budget(struct bfq_entity =
*next_in_service)
> @@ -230,6 +240,14 @@ static bool bfq_no_longer_next_in_service(struct =
bfq_entity *entity)
> 	return true;
> }
>=20
> +static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
> #endif /* CONFIG_BFQ_GROUP_IOSCHED */
>=20
> /*
> @@ -1660,6 +1678,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
> 	bfq_clear_bfqq_busy(bfqq);
>=20
> 	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
> +	bfq_inc_busy_queues(bfqq);
>=20

Why do you increment the number of busy queues for the group on a
del_bfqq_busy, instead of an add_bfqq_busy?

Besides, the name of the function bfq_inc_busy_queues does not mention
the target of the update, namely the group.  This creates a little
confusion at a first sight, as one sees this function invoked right
after the update of a field with the same name: bfqd->busy_queues.

> 	if (bfqq->wr_coeff > 1)
> 		bfqd->wr_busy_queues--;
> @@ -1683,6 +1702,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
>=20
> 	bfq_mark_bfqq_busy(bfqq);
> 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
> +	bfq_dec_busy_queues(bfqq);

Same pair of comments as above.

Thanks,
Paolo

>=20
> 	if (!bfqq->dispatched)
> 		if (bfqq->wr_coeff =3D=3D 1)
> --=20
> 2.31.1
>=20

