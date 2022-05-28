Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBB536B9A
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiE1ISM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 04:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiE1ISL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 04:18:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CAEDAB
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:18:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id rs12so12395220ejb.13
        for <cgroups@vger.kernel.org>; Sat, 28 May 2022 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CT1M4q9x/F1LvMuC7ejZ75BshMSN5GVHe0OC5UIK3I=;
        b=IqkEfDGcjR6ZSjvTXzpfjz9jvMRNgTDZTCwKII1/mNVN+pHuwaUKb7HOs3ttYIZ5Oq
         IkI81WvAgM5OSkNCQK1HsOpC4BbqRksGW6/3KOrN56OzxW0igQM41STGSZintMntb238
         ZTKLHecIdPgDAR4JjqyHESC6A/8c3yx4DypzZIwRpvjiz/OfmU4JrRzuJ2Illq8Lwuln
         ve+mlvLfGGU4qp1/cZMTppci1++lbF9IQfzMwVyB1Mph0k+RTA3FAb74FHM0QycneFcL
         x30PVXifOXuM259SLbBuQeH+sTz8uwOrk5koVuclcSLYNWyZ0AL4CMt45Mr6T0neIw4L
         /eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CT1M4q9x/F1LvMuC7ejZ75BshMSN5GVHe0OC5UIK3I=;
        b=5YnNjlqYtXuHVVOb8mCUpwAhCgfEl3t6G4pva0X1/mDwuCEU08YMoOFbhuHE4vi6gO
         592aQsT41gWLTKlB5azjyIAjKjWIN/hNGMBWWbbZlCfRZ6pjn3La8abnEaT5EuOD7Frk
         2yLxhkJwno/V8iQHFvbjKOFTXG81UXhe9eaT4FF/4eZaM49I55ksGgrnxU/OXAJuRrKg
         9/Lq/9h7iA51VrYKScGSCNbH5AmTgu2JKrVNrk/xuEbHnHmJVBu+wKLAeSh6CAwuiWKp
         DPOn9ujT5ERle2eKKY2CFv9vqSeE/gI4AMyw/lb0dT2A89FGKbiq1ih0CFeQSxpuZYk/
         3B9A==
X-Gm-Message-State: AOAM532Hj1VIiy94I2EuTCDiql788rRgXAITZ21h0t3mbY7oH50mNB9P
        kmqB2OTryw46H2/FHs1CIjjBB00B3FRvGQ==
X-Google-Smtp-Source: ABdhPJzjmDtnRPCXsFm7fSlHGomICMQNqQhsD569ZC1mBguJl/wzEnkiniwN9KLsoCeVr9EHpoLWcA==
X-Received: by 2002:a17:907:3f12:b0:6fe:f8c6:257 with SMTP id hq18-20020a1709073f1200b006fef8c60257mr22661053ejc.544.1653725887367;
        Sat, 28 May 2022 01:18:07 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906955400b006feec47dae9sm2126208ejy.157.2022.05.28.01.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2022 01:18:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v6 0/3] support concurrent sync io for bfq on a
 specail occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220523131818.2798712-1-yukuai3@huawei.com>
Date:   Sat, 28 May 2022 10:18:05 +0200
Cc:     Jan Kara <jack@suse.cz>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <09387792-EBE6-41CC-89F8-A857ECDE4634@linaro.org>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
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
> Resend these patches just in case v5 end up in spam (for Paolo).

Thank you for resending, I do think I lost some email before.

Paolo

> Changes in v6:
> - add reviewed-by tag for patch 1
>=20
> Changes in v5:
> - rename bfq_add_busy_queues() to bfq_inc_busy_queues() in patch 1
> - fix wrong definition in patch 1
> - fix spelling mistake in patch 2: leaset -> least
> - update comments in patch 3
> - add reviewed-by tag in patch 2,3
>=20
> Changes in v4:
> - split bfq_update_busy_queues() to bfq_add/dec_busy_queues(),
>   suggested by Jan Kara.
> - remove unused 'in_groups_with_pending_reqs',
>=20
> Changes in v3:
> - remove the cleanup patch that is irrelevant now(I'll post it
>   separately).
> - instead of hacking wr queues and using weights tree =
insertion/removal,
>   using bfq_add/del_bfqq_busy() to count the number of groups
>   (suggested by Jan Kara).
>=20
> Changes in v2:
> - Use a different approch to count root group, which is much simple.
>=20
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
>=20
> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>=20
> Before this patchset:
> 1) root group will never be counted.
> 2) Count if bfqg or it's child bfqgs have pending requests.
> 3) Don't count if bfqg and it's child bfqgs complete all the requests.
>=20
> After this patchset:
> 1) root group is counted.
> 2) Count if bfqg have at least one bfqq that is marked busy.
> 3) Don't count if bfqg doesn't have any busy bfqqs.
>=20
> The main reason to use busy state of bfqq instead of 'pending =
requests'
> is that bfqq can stay busy after dispatching the last request if =
idling
> is needed for service guarantees.
>=20
> With the above changes, concurrent sync io can be supported if only
> one group is activated.
>=20
> fio test script(startdelay is used to avoid queue merging):
> [global]
> filename=3D/dev/nvme0n1
> allow_mounted_write=3D0
> ioengine=3Dpsync
> direct=3D1
> ioscheduler=3Dbfq
> offset_increment=3D10g
> group_reporting
> rw=3Drandwrite
> bs=3D4k
>=20
> [test1]
> numjobs=3D1
>=20
> [test2]
> startdelay=3D1
> numjobs=3D1
>=20
> [test3]
> startdelay=3D2
> numjobs=3D1
>=20
> [test4]
> startdelay=3D3
> numjobs=3D1
>=20
> [test5]
> startdelay=3D4
> numjobs=3D1
>=20
> [test6]
> startdelay=3D5
> numjobs=3D1
>=20
> [test7]
> startdelay=3D6
> numjobs=3D1
>=20
> [test8]
> startdelay=3D7
> numjobs=3D1
>=20
> test result:
> running fio on root cgroup
> v5.18-rc1:	   550 Mib/s
> v5.18-rc1-patched: 550 Mib/s
>=20
> running fio on non-root cgroup
> v5.18-rc1:	   349 Mib/s
> v5.18-rc1-patched: 550 Mib/s
>=20
> Note that I also test null_blk with "irqmode=3D2
> completion_nsec=3D100000000(100ms) hw_queue_depth=3D1", and tests show
> that service guarantees are still preserved.
>=20
> Follow-up cleanup:
> =
https://lore.kernel.org/all/20220521073523.3118246-1-yukuai3@huawei.com/
>=20
> Previous versions:
> RFC: =
https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/
> v1: =
https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/
> v2: =
https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/
> v3: =
https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
> v4: =
https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/
> v5: =
https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/
>=20
> Yu Kuai (3):
>  block, bfq: record how many queues are busy in bfq_group
>  block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
>  block, bfq: do not idle if only one group is activated
>=20
> block/bfq-cgroup.c  |  1 +
> block/bfq-iosched.c | 48 +++-----------------------------------
> block/bfq-iosched.h | 57 +++++++--------------------------------------
> block/bfq-wf2q.c    | 35 +++++++++++++++++-----------
> 4 files changed, 35 insertions(+), 106 deletions(-)
>=20
> --=20
> 2.31.1
>=20

