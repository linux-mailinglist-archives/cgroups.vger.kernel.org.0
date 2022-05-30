Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C576953757D
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiE3Hgy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiE3HfB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 03:35:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AAB71DBE
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:34:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rs12so18999920ejb.13
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i2FIUxMX07dIItmCTvQjDvu7n64mA3I16Cf2RtZUc9E=;
        b=DLaTskUkWjAQizg06WRK4OQ5IjBDjAR1xNLKk6o5mJOCZgMi3CKiKiSgzNBJVktQOr
         FJw6QDr48a4i+waCCeI2SgKfgtvDUkMC6OleUzscAXa2/SUKfk7G0jbv8OlPIeef5Lx4
         G4uxf2YfIfNi7bdZJKJ5u+Dfe7MXdiUW3gDuWiO4zk8eRfYE9/++jJEd0m2x1a6+Vwmw
         A85OWPBHmk/+4r/z9k70SjrjLLFZxd7gX45N3onexytP1A0RLt/8WTO6S6uWsMkCv/ji
         jz0pRQE5tS9wJQfIrlFEmvUI36KgT8ggw+guxi8dCOiZwHazQYMb7FbPcEBrmInQzSxQ
         O2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i2FIUxMX07dIItmCTvQjDvu7n64mA3I16Cf2RtZUc9E=;
        b=XjJlpY6NPIUCyO7sltFxzZIAWozrVuJEXQ//cIavml+/PAGw/87SYrtXLOND2QBppZ
         8vDZhiaQMsdqz4fZVpE+f/B8yS8gle4VqD0ErnjLSq6E+0x7/xQSDedUgE0mxa4NvpDz
         XpzjgDQ7UNS3maPxIPewzStI6Go6ORydxNuWhhg3yisCoZ9ZUqwjz0dnQLH9WU1XdcXf
         ObuTgKiiOKVBZ+5DX0PtALzI4K/98peD7oiy/4TcL5K4eAWWAxyK2CSepzHQHz+z4fC4
         uSnWXt6AiHoboEH6ndI7yWBjB6XLUJH+yDoYZYPfby2x8ufp/PNunKoJTXwUmYaMTw50
         z24Q==
X-Gm-Message-State: AOAM533EJmtiVksV42mCdUzQHU3b52NOqXmu8kEkX3twZNZjVrCofh4C
        o4WbEbZe/0gf9vchGzLo6R+dpg==
X-Google-Smtp-Source: ABdhPJyOWCr+ry/+jm/PsYI8+iO7oAWa66QadSkDdE5Rnbhx/yj6CcTLuaoTqNzbRqVr9zN9/Cg1+A==
X-Received: by 2002:a17:907:628c:b0:6ee:70cf:d59 with SMTP id nd12-20020a170907628c00b006ee70cf0d59mr48302537ejc.402.1653896088557;
        Mon, 30 May 2022 00:34:48 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.dsl.teletu.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id kv25-20020a17090778d900b006fea0532462sm3723498ejc.167.2022.05.30.00.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 00:34:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v3 0/6] multiple cleanup patches for bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220528095958.270455-1-yukuai3@huawei.com>
Date:   Mon, 30 May 2022 09:34:46 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BC943C7-3AA4-4CED-9B11-15DA969DA852@linaro.org>
References: <20220528095958.270455-1-yukuai3@huawei.com>
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



> Il giorno 28 mag 2022, alle ore 11:59, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Resend just in case v2 end up in spam (for Paolo).
>=20
> Changes in v2:
> - add missing blank line in patch 1.
> - remove patch 7,8, since they are wrong.
> - add reviewed-by tag
>=20
> There are no functional changes in this patchset, just some places
> that I think can be improved during code review.
>=20

Thank you for this cleanup!

Acked-by: Paolo Valente <paolo.valente@unimore.it>

> Previous version:
> v1: =
https://lore.kernel.org/all/20220514090522.1669270-1-yukuai3@huawei.com/
>=20
> Yu Kuai (6):
>  block, bfq: cleanup bfq_weights_tree add/remove apis
>  block, bfq: cleanup __bfq_weights_tree_remove()
>  block, bfq: factor out code to update 'active_entities'
>  block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
>  block, bfq: cleanup bfq_activate_requeue_entity()
>  block, bfq: remove dead code for updating 'rq_in_driver'
>=20
> block/bfq-cgroup.c  |  2 +-
> block/bfq-iosched.c | 38 +++----------------
> block/bfq-iosched.h | 11 ++----
> block/bfq-wf2q.c    | 91 ++++++++++++++++++++-------------------------
> 4 files changed, 51 insertions(+), 91 deletions(-)
>=20
> --=20
> 2.31.1
>=20

