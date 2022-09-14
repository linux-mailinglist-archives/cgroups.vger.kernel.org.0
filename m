Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBF5B823A
	for <lists+cgroups@lfdr.de>; Wed, 14 Sep 2022 09:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiINHut (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Sep 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiINHur (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Sep 2022 03:50:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977162A415
        for <cgroups@vger.kernel.org>; Wed, 14 Sep 2022 00:50:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so17351585wrf.3
        for <cgroups@vger.kernel.org>; Wed, 14 Sep 2022 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=1biDXl6cgm2n8SGycMHAv9SCU/JP3uWb+Ul5VmFRIVw=;
        b=I5Zadj9OJnTGYrv4u5A/xNiT8/POEYkxUf2yovO5ju1wBpFFBfFmBayvrXwPIFBkDZ
         //gq6LKqJBWglHZv9SoeF7AouP+JsdscjhfUhTxSqCmcPrOwJ8pT8WymbZp2JWhg2Y5n
         2meptMdqXBOxCaJ799mUlD4aQKXmyh4e/+9N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1biDXl6cgm2n8SGycMHAv9SCU/JP3uWb+Ul5VmFRIVw=;
        b=nmCRefAJ6/CoIkCRZOKyhQkBDk5XxGGDOPcuHHI+1XocczW3qVXSHQy/vIeIPhD017
         4FR7ydhdMS7iBWXYGuDjg+/AUr1OT88G9JFbjEOmT6BSGyYyob+qFDJhK4efJcQli0P8
         9d+20NxnLiJb9wm4yl7cL9gRfw9fQ9eLGtSCnlxlx21NzZNozCwDwhD+ZtcpidVxhAB7
         6yngpc1tIF252RG7fzVGroJrSim+XcB/GHYrGEUbi8jeuI/von4Nkvq1ijVNbfzUvmzA
         1qLtV3R3wJbFQ+DCWM+DYr3m4vnQ0HrTqqk9euPQhPqb+/+HD50Q/kcrkyzfslnWEa6G
         x/hw==
X-Gm-Message-State: ACgBeo3HMzVxoHQUjt239SNuXm9YrCsE91X0L3SSJ5AixuaRLxh8LFI8
        8r2C+qQb9RhZ0KL+aD0eatUR
X-Google-Smtp-Source: AA6agR6AfpLz24owT0MsoLvCgM5WlQtOrckpUWwp/g4kBGzNOA9UJ3aX5HD2fxo6FN95+GpWPXq0Vw==
X-Received: by 2002:a5d:62cb:0:b0:228:6a13:24d9 with SMTP id o11-20020a5d62cb000000b002286a1324d9mr21349678wrv.497.1663141843044;
        Wed, 14 Sep 2022 00:50:43 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id bk12-20020a0560001d8c00b0022762b0e2a2sm13119612wrb.6.2022.09.14.00.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 00:50:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <f89eb61b-7912-5916-1a12-039e32bebe70@huaweicloud.com>
Date:   Wed, 14 Sep 2022 09:50:41 +0200
Cc:     Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF3909EA-4659-48CB-917A-639DC3318916@unimore.it>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
 <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
 <abdbb5db-e280-62f8-0670-536fcb8ec4d9@huaweicloud.com>
 <C2CF100A-9A7C-4300-9A70-1295BC939C66@unimore.it>
 <9b2d667f-6636-9347-08a1-8bd0aa2346f2@huaweicloud.com>
 <2f94f241-445f-1beb-c4a8-73f6efce5af2@huaweicloud.com>
 <55A07102-BE55-4606-9E32-64E884064FB9@unimore.it>
 <5cb0e5bc-feec-86d6-6f60-3c28ee625efd@huaweicloud.com>
 <D89DCF20-27D8-4F8F-B8B0-FD193FC4F18D@unimore.it>
 <e6b53794-f93f-92b2-1f45-35ae81a28a5c@huaweicloud.com>
 <F758A356-EE6B-4B7B-95E2-6414616C77E4@unimore.it>
 <5e0b44b4-46cc-b3c6-1d93-00a0a683eda8@huaweicloud.com>
 <f89eb61b-7912-5916-1a12-039e32bebe70@huaweicloud.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
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



> Il giorno 14 set 2022, alle ore 03:55, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
>=20
>=20
> =E5=9C=A8 2022/09/07 9:16, Yu Kuai =E5=86=99=E9=81=93:
>> Hi, Paolo!
>> =E5=9C=A8 2022/09/06 17:37, Paolo Valente =E5=86=99=E9=81=93:
>>>=20
>>>=20
>>>> Il giorno 26 ago 2022, alle ore 04:34, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>>>>=20
>>>> Hi, Paolo!
>>>>=20
>>>> =E5=9C=A8 2022/08/25 22:59, Paolo Valente =E5=86=99=E9=81=93:
>>>>>> Il giorno 11 ago 2022, alle ore 03:19, Yu Kuai =
<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>>>>=20
>>>>>> Hi, Paolo
>>>>>>=20
>>>>>> =E5=9C=A8 2022/08/10 18:49, Paolo Valente =E5=86=99=E9=81=93:
>>>>>>>> Il giorno 27 lug 2022, alle ore 14:11, Yu Kuai =
<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>>>>>>=20
>>>>>>>> Hi, Paolo
>>>>>>>>=20
>>>>>>> hi
>>>>>>>> Are you still interested in this patchset?
>>>>>>>>=20
>>>>>>> Yes. Sorry for replying very late again.
>>>>>>> Probably the last fix that you suggest is enough, but I'm a =
little bit
>>>>>>> concerned that it may be a little hasty.  In fact, before this =
fix, we
>>>>>>> exchanged several messages, and I didn't seem to be very good at
>>>>>>> convincing you about the need to keep into account also =
in-service
>>>>>>> I/O.  So, my question is: are you sure that now you have a
>>>>>>=20
>>>>>> I'm confused here, I'm pretty aware that in-service I/O(as said =
pending
>>>>>> requests is the patchset) should be counted, as you suggested in =
v7, are
>>>>>> you still thinking that the way in this patchset is problematic?
>>>>>>=20
>>>>>> I'll try to explain again that how to track is bfqq has pending =
pending
>>>>>> requests, please let me know if you still think there are some =
problems:
>>>>>>=20
>>>>>> patch 1 support to track if bfqq has pending requests, it's
>>>>>> done by setting the flag 'entity->in_groups_with_pending_reqs' =
when the
>>>>>> first request is inserted to bfqq, and it's cleared when the last
>>>>>> request is completed. specifically the flag is set in
>>>>>> bfq_add_bfqq_busy() when 'bfqq->dispatched' if false, and it's =
cleared
>>>>>> both in bfq_completed_request() and bfq_del_bfqq_busy() when
>>>>>> 'bfqq->diapatched' is false.
>>>>>>=20
>>>>> This general description seems correct to me. Have you already =
sent a new version of your patchset?
>>>>=20
>>>> It's glad that we finially on the same page here.
>>>>=20
>>>=20
>>> Yep. Sorry for my chronicle delay.
>> Better late than never =F0=9F=98=81
>>>=20
>>>> Please take a look at patch 1, which already impelement the above
>>>> descriptions, it seems to me there is no need to send a new version
>>>> for now. If you think there are still some other problems, please =
let
>>>> me know.
>>>>=20
>>>=20
>>> Patch 1 seems ok to me. I seem to have only one pending comment on =
this patch (3/4) instead. Let me paste previous stuff here for your =
convenience:
>> That sounds good.
>>>=20
>>>>>=20
>>>>> -    /*
>>>>> -     * Next function is invoked last, because it causes bfqq to =
be
>>>>> -     * freed if the following holds: bfqq is not in service and
>>>>> -     * has no dispatched request. DO NOT use bfqq after the next
>>>>> -     * function invocation.
>>>>> -     */
>>>> I would really love it if you leave this comment.  I added it after
>>>> suffering a lot for a nasty UAF.  Of course the first sentence may
>>>> need to be adjusted if the code that precedes it is to be removed.
>>>> Same as above, if this patch is applied, this function will be =
gone.
>=20
> Hi, I'm curious while I'm trying to add the comment, before this
> patchset, can bfqq be freed when bfq_weights_tree_remove is called?
>=20
> bfq_completed_request
> bfqq->dispatched--
> if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq))
>  bfq_weights_tree_remove(bfqd, bfqq);
>=20
> // continue to use bfqq
>=20
> It seems to me this is problematic if so, because bfqq is used after
> bfq_weights_tree_remove() is called.
>=20

It is.  Yet, IIRC, I verified that bfqq was not used after that free,
and I added that comment as a heads-up.  What is a scenario (before
your pending modifications) where this use-after-free happens?

Thanks,
Paolo

> Thanks,
> Kuai

