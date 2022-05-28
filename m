Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CBA536BA8
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiE1Ial (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiE1Iak (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 04:30:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8FB19024
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:30:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rs12so12426067ejb.13
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T+Hu8XQTes5+zOjXdhH2PIcfNeRm97dI8R0g/lN+Yd8=;
        b=cMsKLp9xx6caXX4fhNUQ1GIDgeMWcvOHB+BQYZV7KhH/sIQHowtAJJduwzZeMn/ayn
         NEyO4PCwKkMmopMy3OFYPJNGueAYgpi2TmgwoPuj7gr2ImFZupuKBykH5Y0wahgVwpwC
         UmEXmyzWlGNdEHsP7SHKUDULFII5IHCW2u3onGKGbELBlPMnDfEMv2O4iKAFVh66XNyC
         6qUWZxzmeOFsQ2R1foQjeTlNZPR7YXsFJ3WfkLJ7m9blxV0nng9m8EykO4xde1SnExTZ
         juWKXm2I6HADHKXH0h/Fy0Rt5PA6d7CYbUtH2rOgnt0gFj3U+hJiV1J5T9NCzPzWPn9W
         kK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T+Hu8XQTes5+zOjXdhH2PIcfNeRm97dI8R0g/lN+Yd8=;
        b=ngD6KSoDK/w6jf0Gpce3kghqXKbZC0OyuVvBBMnQaU+/Qo38tJo/Xm9hfL6gcD9bVr
         oVm7KCKZOIzr+kESWUZWQU13DeU2CBnSG5hgXrvfIangZno3ok2K3ymZTjscSNXEX1sD
         6L0YsFaeNpYe9Ode4zsjma/sbgi1+BXByJWM7Qr1htjDe/evpQcWipo08g/w+9nEQiXf
         vvnU/w1nHEQZoSbuYB0MZVCbfiwpuu3p+EYGUMgeNgRMICuMZICOJEj2T5m05QKG91gE
         difnDyYY5rvJ0ENOx+BIXSvFcQ5g0O7SAsrQ6NBFK7/rk5aE2vi3bEts5YiGH71mQ1Rg
         ICTg==
X-Gm-Message-State: AOAM531faABpPjEIRVdlNdjSVoTOJwRE6JBAGfIv1TgxttijkuDg2qDb
        XHrmhw4XCjKQGXdAnBT3IJwVQg==
X-Google-Smtp-Source: ABdhPJxu4fCXtVWFNHsG9akf0/etbFVKWELdZtJARO0pBh6QDBb5a13+1ZM3FK1wENfvxz8aymxzpQ==
X-Received: by 2002:a17:907:7b9d:b0:6f4:df04:affb with SMTP id ne29-20020a1709077b9d00b006f4df04affbmr41383084ejc.473.1653726635386;
        Sat, 28 May 2022 01:30:35 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id rv3-20020a1709068d0300b006fec69a3978sm2054540ejc.207.2022.05.28.01.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2022 01:30:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v6 3/3] block, bfq: do not idle if only one group is
 activated
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220523131818.2798712-4-yukuai3@huawei.com>
Date:   Sat, 28 May 2022 10:30:34 +0200
Cc:     Jan Kara <jack@suse.cz>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <27B0AE8B-C134-4BA1-B84F-39C659CB2B10@linaro.org>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
 <20220523131818.2798712-4-yukuai3@huawei.com>
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



> Il giorno 23 mag 2022, alle ore 15:18, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Now that root group is counted into 'num_groups_with_busy_queues',
> 'num_groups_with_busy_queues > 0' is always true in
> bfq_asymmetric_scenario(). Thus change the condition to '> 1'.
>=20
> On the other hand, this change can enable concurrent sync io if only
> one group is activated.

This is ok.  Yet, if the mistakes I found in the other two patches are
actual errors, I wonder how these changes made it to pass your tests.

Thanks,
Paolo

>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 609b4e894684..142e1ca4600f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -812,7 +812,7 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
>  * much easier to maintain the needed state:
>  * 1) all active queues have the same weight,
>  * 2) all active queues belong to the same I/O-priority class,
> - * 3) there are no active groups.
> + * 3) there are one active group at most.
>  * In particular, the last condition is always true if hierarchical
>  * support or the cgroups interface are not enabled, thus no state
>  * needs to be maintained in this case.
> @@ -844,7 +844,7 @@ static bool bfq_asymmetric_scenario(struct =
bfq_data *bfqd,
>=20
> 	return varied_queue_weights || multiple_classes_busy
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	       || bfqd->num_groups_with_busy_queues > 0
> +	       || bfqd->num_groups_with_busy_queues > 1
> #endif
> 		;
> }
> --=20
> 2.31.1
>=20

