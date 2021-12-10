Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920A246FE65
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 11:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhLJKJt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 05:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbhLJKJs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 05:09:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD2C061746
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 02:06:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so27520167edb.8
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lC142Yo8coIpvvVUqN6aAJckxOOmW7Kkcqr32G1U5wQ=;
        b=YirHdbJ/8fHvaGzvPOOudtZaOKZcTRdBFtDjdO1hmXL9O4K9D87KqrQ1Ap9pd9QlFP
         H3sUgfmdP2N4yKurHlVRbhkt5gZOg0lM+e19Y3svTo/dvTfX6H36xgUyHme2dxly4Gvk
         w9bgVjEmNv8Mue0+0e7ZiZ+SKI2vPfHq5MEvSsb5A40po863heD6Duoq/Kqg6IfY0dHf
         2cp8hDtCRBl3YghjzvvpvYcnS7RNI1WHooBWkC2uBCFd13WNSyUdCmraD0T24rJ8kFZu
         5EphrR/MLO6IE/aRHdF4mGAWtPr68E27D/1JFsdrU40aCsr1fUkN1JQAvI/qkCNE97Ll
         PECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lC142Yo8coIpvvVUqN6aAJckxOOmW7Kkcqr32G1U5wQ=;
        b=Fr+VQj1LUR+iKDrcpp69WD6oAvY+LI9UDJwUx604PxeojTRKZRh1PB4yhwT5D8lHBS
         pllvNKeF7pwh1fln7HkpyZwXY6gboAx/Fd9y3b2f6CIZgpxYU066thrnqC5DjclhRqCW
         LkB1zpVbTO+G0pMbL11xqAwXBxaSKXfYHq25lR7MSs3TgwMvgowdK5eRN11wwpOv431B
         Nsi/ykb/uzOo7iF2CVZbTBHVmayIhj1eAsQ5iYn+/s130sc5ut01ZXcS1UAFnWjcAoCN
         pP9qOoWU0MiK1MZbxLW4Vo54dszJCSt7Ld62fhXLJ/GnMru+DrJbUSeTTvvvUFoDz5li
         JRig==
X-Gm-Message-State: AOAM531vxhx1+wBLTiO54jqnsvjvTZH38sXYpfnveuI2/5K2t0EDW4tA
        dcoQbs5CztPow2nZ0NxnZBeOfiC2z2TXzA==
X-Google-Smtp-Source: ABdhPJzogiO1NzTpvwYLW1ZNFCxCS9CKr9ffg97FkXtE+uP8BYAkzNgef5FE3TFs5mdlwrLo4x6g7w==
X-Received: by 2002:a17:906:3647:: with SMTP id r7mr23404107ejb.124.1639130772299;
        Fri, 10 Dec 2021 02:06:12 -0800 (PST)
Received: from [192.168.1.8] (net-93-70-85-65.cust.vodafonedsl.it. [93.70.85.65])
        by smtp.gmail.com with ESMTPSA id ht7sm1251619ejc.27.2021.12.10.02.06.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:06:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 3/9] block, bfq: handle the case when
 for_each_entity() access root group
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211127101132.486806-4-yukuai3@huawei.com>
Date:   Fri, 10 Dec 2021 11:06:10 +0100
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C1444A3-8268-4F4E-99D0-76704E69C43E@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <20211127101132.486806-4-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Prevent null-ptr-deref after counting root group into
> 'num_groups_with_pending_reqs'.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c |  2 +-
> block/bfq-wf2q.c    | 17 +++++++++++++----
> 2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 3262d062e21f..47722f931ee3 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -864,7 +864,7 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 	for_each_entity(entity) {
> 		struct bfq_sched_data *sd =3D entity->my_sched_data;
>=20
> -		if (sd->next_in_service || sd->in_service_entity) {
> +		if (sd && (sd->next_in_service || =
sd->in_service_entity)) {

Explain with some comment this additional check.

Paolo

> 			/*
> 			 * entity is still active, because either
> 			 * next_in_service or in_service_entity is not
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 67e32481e455..6693765ff3a0 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -965,6 +965,13 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 	bool backshifted =3D false;
> 	unsigned long long min_vstart;
>=20
> +	if (is_root_entity(entity))
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +		goto update;
> +#else
> +		return;
> +#endif
> +
> 	/* See comments on bfq_fqq_update_budg_for_activation */
> 	if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
> 		backshifted =3D true;
> @@ -999,7 +1006,10 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 		entity->on_st_or_in_serv =3D true;
> 	}
>=20
> +	bfq_update_fin_time_enqueue(entity, st, backshifted);
> +
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> +update:
> 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> 		struct bfq_group *bfqg =3D
> 			container_of(entity, struct bfq_group, entity);
> @@ -1011,8 +1021,6 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 		}
> 	}
> #endif
> -
> -	bfq_update_fin_time_enqueue(entity, st, backshifted);
> }
>=20
> /**
> @@ -1102,7 +1110,8 @@ static void __bfq_activate_requeue_entity(struct =
bfq_entity *entity,
> {
> 	struct bfq_service_tree *st =3D bfq_entity_service_tree(entity);
>=20
> -	if (sd->in_service_entity =3D=3D entity || entity->tree =3D=3D =
&st->active)
> +	if (sd && (sd->in_service_entity =3D=3D entity ||
> +		   entity->tree =3D=3D &st->active))
> 		 /*
> 		  * in service or already queued on the active tree,
> 		  * requeue or reposition
> @@ -1140,7 +1149,7 @@ static void bfq_activate_requeue_entity(struct =
bfq_entity *entity,
> 		sd =3D entity->sched_data;
> 		__bfq_activate_requeue_entity(entity, sd, =
non_blocking_wait_rq);
>=20
> -		if (!bfq_update_next_in_service(sd, entity, expiration) =
&&
> +		if (sd && !bfq_update_next_in_service(sd, entity, =
expiration) &&
> 		    !requeue)
> 			break;
> 	}
> --=20
> 2.31.1
>=20

