Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DB5AE45E
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIFJh3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiIFJh2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 05:37:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB06581D
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 02:37:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id cu2so21957300ejb.0
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=8ab4/KXC/VCJGrAM6wTzpCaYMhm/3tELW6Q/pF3d2yg=;
        b=L3k2+HgNwBNOQ+ow8ojCGK5dmzXXckSbJ+ltZKHL+uHxZCqB3njwCzg4VdkEf9pYyo
         EHv2NqYduPH+u4g9bR0foiCS+VYuNHJVpX8cgX5XNnWyA4eA9MNFy81mtKNNXVKGyXYu
         sMK0dhdUQPuxSHK/l42tDAlBU7HRuTmuzbk2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8ab4/KXC/VCJGrAM6wTzpCaYMhm/3tELW6Q/pF3d2yg=;
        b=mzZitDuOF7ZOap8r2HNxUEY2mYc4RlQLhe2G7bWGriyjzIKV+7WTl3PJ1o6xSFQPRH
         9shyLwWwnndU+1DE8Txfqb/G6OOfvnW/YRBEzr9fWC50P41jCo8E2E3IjvGWo2aFtOw/
         FYsjmIytkbgnp6mwIYlwyfjqLxsW3BPm4HpE7niojJJFE4YVkVwIIYsi96IPe6CvQeYw
         jDD4jjXeo9I2SPX2z8QiHsMHrqXueHuK1qlKtYSxlLPimxUh4fTEk9qWU2lzNq8tKzPk
         YDCsvHZD0BjHpxL80TdU5pSU0BXKOMZDaAqvNW00HDbV1M74+xgUv2m01ZGXGr/LBqVN
         Yd3A==
X-Gm-Message-State: ACgBeo0OEVMGD58zWbzGqdFTb4dI/aUZZ6xTOAAzM3Pwp01DNa+deR3d
        jr+Q63HYhR6Il8wcSqO2/hzu
X-Google-Smtp-Source: AA6agR5oMrn7st5T+/R0moL8sWUBXk+gefDuxpdDuSrvcue7dAZwiiodmMrEtXkB8slie9xV103N4Q==
X-Received: by 2002:a17:906:7954:b0:742:7a6:b179 with SMTP id l20-20020a170906795400b0074207a6b179mr24629684ejo.679.1662457044644;
        Tue, 06 Sep 2022 02:37:24 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906538f00b0076f927ed0f1sm265565ejo.127.2022.09.06.02.37.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 02:37:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <e6b53794-f93f-92b2-1f45-35ae81a28a5c@huaweicloud.com>
Date:   Tue, 6 Sep 2022 11:37:22 +0200
Cc:     Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F758A356-EE6B-4B7B-95E2-6414616C77E4@unimore.it>
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
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 26 ago 2022, alle ore 04:34, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> Hi, Paolo!
>=20
> =E5=9C=A8 2022/08/25 22:59, Paolo Valente =E5=86=99=E9=81=93:
>>> Il giorno 11 ago 2022, alle ore 03:19, Yu Kuai =
<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>=20
>>> Hi, Paolo
>>>=20
>>> =E5=9C=A8 2022/08/10 18:49, Paolo Valente =E5=86=99=E9=81=93:
>>>>> Il giorno 27 lug 2022, alle ore 14:11, Yu Kuai =
<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>>>=20
>>>>> Hi, Paolo
>>>>>=20
>>>> hi
>>>>> Are you still interested in this patchset?
>>>>>=20
>>>> Yes. Sorry for replying very late again.
>>>> Probably the last fix that you suggest is enough, but I'm a little =
bit
>>>> concerned that it may be a little hasty.  In fact, before this fix, =
we
>>>> exchanged several messages, and I didn't seem to be very good at
>>>> convincing you about the need to keep into account also in-service
>>>> I/O.  So, my question is: are you sure that now you have a
>>>=20
>>> I'm confused here, I'm pretty aware that in-service I/O(as said =
pending
>>> requests is the patchset) should be counted, as you suggested in v7, =
are
>>> you still thinking that the way in this patchset is problematic?
>>>=20
>>> I'll try to explain again that how to track is bfqq has pending =
pending
>>> requests, please let me know if you still think there are some =
problems:
>>>=20
>>> patch 1 support to track if bfqq has pending requests, it's
>>> done by setting the flag 'entity->in_groups_with_pending_reqs' when =
the
>>> first request is inserted to bfqq, and it's cleared when the last
>>> request is completed. specifically the flag is set in
>>> bfq_add_bfqq_busy() when 'bfqq->dispatched' if false, and it's =
cleared
>>> both in bfq_completed_request() and bfq_del_bfqq_busy() when
>>> 'bfqq->diapatched' is false.
>>>=20
>> This general description seems correct to me. Have you already sent a =
new version of your patchset?
>=20
> It's glad that we finially on the same page here.
>=20

Yep. Sorry for my chronicle delay.

> Please take a look at patch 1, which already impelement the above
> descriptions, it seems to me there is no need to send a new version
> for now. If you think there are still some other problems, please let
> me know.
>=20

Patch 1 seems ok to me. I seem to have only one pending comment on this =
patch (3/4) instead. Let me paste previous stuff here for your =
convenience:

>>=20
>> -	/*
>> -	 * Next function is invoked last, because it causes bfqq to be
>> -	 * freed if the following holds: bfqq is not in service and
>> -	 * has no dispatched request. DO NOT use bfqq after the next
>> -	 * function invocation.
>> -	 */
> I would really love it if you leave this comment.  I added it after
> suffering a lot for a nasty UAF.  Of course the first sentence may
> need to be adjusted if the code that precedes it is to be removed.
> Same as above, if this patch is applied, this function will be gone.

yes, but this comment now must be moved forward.

Looking forward for a new complete version, for a new review.  I'll do
my best to reply quicker.

Thanks,
Paolo





> Thanks,
> Kuai
>> Thanks,
>> Paolo
>>> Thanks,
>>> Kuai
>>>> clear/complete understanding of this non-trivial matter?
>>>> Consequently, are we sure that this last fix is most certainly all =
we
>>>> need?  Of course, I will check on my own, but if you reassure me on
>>>> this point, I will feel more confident.
>>>> Thanks,
>>>> Paolo
>>>>> =E5=9C=A8 2022/07/20 19:38, Yu Kuai =E5=86=99=E9=81=93:
>>>>>> Hi
>>>>>>=20
>>>>>> =E5=9C=A8 2022/07/20 19:24, Paolo VALENTE =E5=86=99=E9=81=93:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> Il giorno 12 lug 2022, alle ore 15:30, Yu Kuai =
<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com> =
<mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>>>>>>=20
>>>>>>>> Hi!
>>>>>>>>=20
>>>>>>>> I'm copying my reply with new mail address, because Paolo seems
>>>>>>>> didn't receive my reply.
>>>>>>>>=20
>>>>>>>> =E5=9C=A8 2022/06/23 23:32, Paolo Valente =E5=86=99=E9=81=93:
>>>>>>>>> Sorry for the delay.
>>>>>>>>>> Il giorno 10 giu 2022, alle ore 04:17, Yu Kuai =
<yukuai3@huawei.com <mailto:yukuai3@huawei.com> =
<mailto:yukuai3@huawei.com>> ha scritto:
>>>>>>>>>>=20
>>>>>>>>>> Currently, bfq can't handle sync io concurrently as long as =
they
>>>>>>>>>> are not issued from root group. This is because
>>>>>>>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>>>>>>>> bfq_asymmetric_scenario().
>>>>>>>>>>=20
>>>>>>>>>> The way that bfqg is counted into =
'num_groups_with_pending_reqs':
>>>>>>>>>>=20
>>>>>>>>>> Before this patch:
>>>>>>>>>> 1) root group will never be counted.
>>>>>>>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>>>>>>>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>>>>>>>>>=20
>>>>>>>>>> After this patch:
>>>>>>>>>> 1) root group is counted.
>>>>>>>>>> 2) Count if bfqg have pending requests.
>>>>>>>>>> 3) Don't count if bfqg complete all the requests.
>>>>>>>>>>=20
>>>>>>>>>> With this change, the occasion that only one group is =
activated can be
>>>>>>>>>> detected, and next patch will support concurrent sync io in =
the
>>>>>>>>>> occasion.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com =
<mailto:yukuai3@huawei.com> <mailto:yukuai3@huawei.com>>
>>>>>>>>>> Reviewed-by: Jan Kara <jack@suse.cz <mailto:jack@suse.cz> =
<mailto:jack@suse.cz>>
>>>>>>>>>> ---
>>>>>>>>>> block/bfq-iosched.c | 42 =
------------------------------------------
>>>>>>>>>> block/bfq-iosched.h | 18 +++++++++---------
>>>>>>>>>> block/bfq-wf2q.c    | 19 ++++---------------
>>>>>>>>>> 3 files changed, 13 insertions(+), 66 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>>>>>> index 0ec21018daba..03b04892440c 100644
>>>>>>>>>> --- a/block/bfq-iosched.c
>>>>>>>>>> +++ b/block/bfq-iosched.c
>>>>>>>>>> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct =
bfq_data *bfqd,
>>>>>>>>>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>>>>>>>>     struct bfq_queue *bfqq)
>>>>>>>>>> {
>>>>>>>>>> -struct bfq_entity *entity =3D bfqq->entity.parent;
>>>>>>>>>> -
>>>>>>>>>> -for_each_entity(entity) {
>>>>>>>>>> -struct bfq_sched_data *sd =3D entity->my_sched_data;
>>>>>>>>>> -
>>>>>>>>>> -if (sd->next_in_service || sd->in_service_entity) {
>>>>>>>>>> -/*
>>>>>>>>>> -* entity is still active, because either
>>>>>>>>>> -* next_in_service or in_service_entity is not
>>>>>>>>>> -* NULL (see the comments on the definition of
>>>>>>>>>> -* next_in_service for details on why
>>>>>>>>>> -* in_service_entity must be checked too).
>>>>>>>>>> -*
>>>>>>>>>> -* As a consequence, its parent entities are
>>>>>>>>>> -* active as well, and thus this loop must
>>>>>>>>>> -* stop here.
>>>>>>>>>> -*/
>>>>>>>>>> -break;
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>> -/*
>>>>>>>>>> -* The decrement of num_groups_with_pending_reqs is
>>>>>>>>>> -* not performed immediately upon the deactivation of
>>>>>>>>>> -* entity, but it is delayed to when it also happens
>>>>>>>>>> -* that the first leaf descendant bfqq of entity gets
>>>>>>>>>> -* all its pending requests completed. The following
>>>>>>>>>> -* instructions perform this delayed decrement, if
>>>>>>>>>> -* needed. See the comments on
>>>>>>>>>> -* num_groups_with_pending_reqs for details.
>>>>>>>>>> -*/
>>>>>>>>>> -if (entity->in_groups_with_pending_reqs) {
>>>>>>>>>> -entity->in_groups_with_pending_reqs =3D false;
>>>>>>>>>> -bfqd->num_groups_with_pending_reqs--;
>>>>>>>>>> -}
>>>>>>>>>> -}
>>>>>>>>> With this part removed, I'm missing how you handle the =
following
>>>>>>>>> sequence of events:
>>>>>>>>> 1.  a queue Q becomes non busy but still has dispatched =
requests, so
>>>>>>>>> it must not be removed from the counter of queues with pending =
reqs
>>>>>>>>> yet
>>>>>>>>> 2.  the last request of Q is completed with Q being still idle =
(non
>>>>>>>>> busy).  At this point Q must be removed from the counter.  It =
seems to
>>>>>>>>> me that this case is not handled any longer
>>>>>>>> Hi, Paolo
>>>>>>>>=20
>>>>>>>> 1) At first, patch 1 support to track if bfqq has pending =
requests, it's
>>>>>>>> done by setting the flag 'entity->in_groups_with_pending_reqs' =
when the
>>>>>>>> first request is inserted to bfqq, and it's cleared when the =
last
>>>>>>>> request is completed(based on weights_tree insertion and =
removal).
>>>>>>>>=20
>>>>>>>=20
>>>>>>> In patch 1 I don't see the flag cleared for the =
request-completion event :(
>>>>>>>=20
>>>>>>> The piece of code involved is this:
>>>>>>>=20
>>>>>>> static void bfq_completed_request(struct bfq_queue *bfqq, struct =
bfq_data *bfqd)
>>>>>>> {
>>>>>>> u64 now_ns;
>>>>>>> u32 delta_us;
>>>>>>>=20
>>>>>>> bfq_update_hw_tag(bfqd);
>>>>>>>=20
>>>>>>> bfqd->rq_in_driver[bfqq->actuator_idx]--;
>>>>>>> bfqd->tot_rq_in_driver--;
>>>>>>> bfqq->dispatched--;
>>>>>>>=20
>>>>>>> if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
>>>>>>> /*
>>>>>>> * Set budget_timeout (which we overload to store the
>>>>>>> * time at which the queue remains with no backlog and
>>>>>>> * no outstanding request; used by the weight-raising
>>>>>>> * mechanism).
>>>>>>> */
>>>>>>> bfqq->budget_timeout =3D jiffies;
>>>>>>>=20
>>>>>>> bfq_weights_tree_remove(bfqd, bfqq);
>>>>>>> }
>>>>>>> ...
>>>>>>>=20
>>>>>>> Am I missing something?
>>>>>>=20
>>>>>> I add a new api bfq_del_bfqq_in_groups_with_pending_reqs() in =
patch 1
>>>>>> to clear the flag, and it's called both from bfq_del_bfqq_busy() =
and
>>>>>> bfq_completed_request(). I think you may miss the later:
>>>>>>=20
>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>> index 0d46cb728bbf..0ec21018daba 100644
>>>>>> --- a/block/bfq-iosched.c
>>>>>> +++ b/block/bfq-iosched.c
>>>>>> @@ -6263,6 +6263,7 @@ static void bfq_completed_request(struct =
bfq_queue *bfqq, struct bfq_data *bfqd)
>>>>>>           */
>>>>>>          bfqq->budget_timeout =3D jiffies;
>>>>>>=20
>>>>>> +        bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>>>>>>          bfq_weights_tree_remove(bfqd, bfqq);
>>>>>>      }
>>>>>>=20
>>>>>> Thanks,
>>>>>> Kuai
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>> Paolo
>>>>>=20
>>>> .
>=20

