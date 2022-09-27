Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6C5EC9B2
	for <lists+cgroups@lfdr.de>; Tue, 27 Sep 2022 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiI0Qi4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Sep 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiI0Qix (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Sep 2022 12:38:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448A1D92B9
        for <cgroups@vger.kernel.org>; Tue, 27 Sep 2022 09:38:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dv25so21831359ejb.12
        for <cgroups@vger.kernel.org>; Tue, 27 Sep 2022 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=F2goyNpyd3IXhayCEGATlVULW4jrbgSh4ZPgZuwoLUY=;
        b=VufMgnwF8XYZxQrCy+h78oyt/89LDSA/P6+xgdHgQp1Jb1Wn+VwztMpPMIP+EK7F22
         s4v39KDbH5rzEXL0glxq9/BuT9m75v0rHl9dCqBy1alkRvgh4wfDE3AaQ1Ygw6IvtWB3
         476zV6duj7KCxwM3Nj2ABXwvPaitFT+jH81XWw/ZVH5JzYgv8nwJesdqsWYhNK5YliG4
         8BwhvRCtAAwPf5djmV6BSTu3/+qORqY0uB9d/qGU429lJk/8XRkUAInHp7DE50h+lymT
         Q5WnKLOMZVHwiMfS5IWtQ5g/R9yAMp8MXt5AI+1yiOlck0dY7NXhVTYub2iTFGgRwrxs
         nt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F2goyNpyd3IXhayCEGATlVULW4jrbgSh4ZPgZuwoLUY=;
        b=qL/XRFLjtekpxWsbIJE/cWXhJZsSHrpfEYXi+0MF1SxAksKmrfQ7gGdbSzWTnWQCBZ
         YzFVM2z8WtigoT5rvy8zXZnJX6XvHb0qOdDWHxSbL5/o/JlxxUAitvtjuM1GkKcx8rFe
         /0YRZDU6v7/MTf9jOK32yr002S02X7/U2vJBh7+8x60snUUegNJ0gfw/XGAMcddAzV7D
         gLhanyDNZBe/KQxnUfYGUblUCkzzJG83AJeg27chrKrmC5dVCscZxdnsnoICV2k10AWg
         fNNEOE/wWG3Y6oNch8wa94/tHltFSQibSuhBHOQprQ5v6KnGlC9q2E9IMm8awfhTn5Vo
         krBQ==
X-Gm-Message-State: ACrzQf1jGB/cchMmr89hK7fYWmQGQ2+AfBOSKBjJSOfKk+eMK6LOjvbW
        b/I4ezIRn3oaYGWzmfqVmDt0Ag==
X-Google-Smtp-Source: AMsMyM73RkuKKJlYmIndQtNTIOY78PnlqUDLGnitn23kmuwbfrhZJ4PHpaokmWMklMutu6huS6ADgQ==
X-Received: by 2002:a17:907:3dab:b0:783:4b01:1ffe with SMTP id he43-20020a1709073dab00b007834b011ffemr11507259ejc.107.1664296700560;
        Tue, 27 Sep 2022 09:38:20 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7cf95000000b004575c9db638sm1569057edx.54.2022.09.27.09.38.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:38:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail
 occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220916071942.214222-1-yukuai1@huaweicloud.com>
Date:   Tue, 27 Sep 2022 18:38:18 +0200
Cc:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <29348B39-94AE-4D76-BD2E-B759056264B6@linaro.org>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
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



> Il giorno 16 set 2022, alle ore 09:19, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Changes in v11:
> - keep the comments in bfq_weights_tree_remove() and move it to the
> caller where bfqq can be freed.
> - add two followed up cleanup patches.
>=20
> Changes in v10:
> - Add reviewed-tag for patch 2
>=20
> Changes in v9:
> - also update how many bfqqs have pending_reqs bfq_bfqq_move().
> - fix one language in patch 4
> - Add reviewed-tag for patch 1,3,4
>=20
> Changes in v8:
> - Instead of using whether bfqq is busy, using whether bfqq has =
pending
> requests. As Paolo pointed out the former way is problematic.
>=20
> Changes in v7:
> - fix mismatch bfq_inc/del_busy_queues() and bfqq_add/del_bfqq_busy(),
> also retest this patchset on v5.18 to make sure functionality is
> correct.
> - move the updating of 'bfqd->busy_queues' into new apis
>=20
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
> 2) Count if bfqg has pending requests.
> 3) Don't count if bfqg complete all the requests.
>=20
> With the above changes, concurrent sync io can be supported if only
> one group is activated.
>=20
> fio test script(startdelay is used to avoid queue merging):
> [global]
> filename=3D/dev/sda
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
> v5.18:	   112 Mib/s
> v5.18-patched: 112 Mib/s
>=20
> running fio on non-root cgroup
> v5.18:	   51.2 Mib/s
> v5.18-patched: 112 Mib/s
>=20
> Note that I also test null_blk with "irqmode=3D2
> completion_nsec=3D100000000(100ms) hw_queue_depth=3D1", and tests show
> that service guarantees are still preserved.
>=20

Your patches seem ok to me now (thanks for you contribution and, above =
all, for your patience). I have only a high-level concern: what do you =
mean when you say that service guarantees are still preserved? What test =
did you run exactly? This point is very important to me. I'd like to see =
some convincing test with differentiated weights. In case you don't have =
other tools for executing such tests quickly, you may want to use the =
bandwidth-latency test in my simple S benchmark suite (for which I'm =
willing to help).

Thanks,
Paolo

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
> v6: =
https://lore.kernel.org/all/20220523131818.2798712-1-yukuai3@huawei.com/
> v7: =
https://lore.kernel.org/all/20220528095020.186970-1-yukuai3@huawei.com/
>=20
>=20
> Yu Kuai (6):
>  block, bfq: support to track if bfqq has pending requests
>  block, bfq: record how many queues have pending requests
>  block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
>  block, bfq: do not idle if only one group is activated
>  block, bfq: cleanup bfq_weights_tree add/remove apis
>  block, bfq: cleanup __bfq_weights_tree_remove()
>=20
> block/bfq-cgroup.c  | 10 +++++++
> block/bfq-iosched.c | 71 +++++++--------------------------------------
> block/bfq-iosched.h | 30 +++++++++----------
> block/bfq-wf2q.c    | 69 ++++++++++++++++++++++++++-----------------
> 4 files changed, 76 insertions(+), 104 deletions(-)
>=20
> --=20
> 2.31.1
>=20

