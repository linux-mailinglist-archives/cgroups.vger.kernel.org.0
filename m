Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459DB53912B
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiEaM5f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 08:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiEaM5f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 08:57:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A213D4E
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 05:57:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so10493462wrb.0
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ym2vxiiSkZboWqTFrRQZchxrLmktCPU70VmDq1pV1v4=;
        b=GweWDN2paf8rGlIMYmyTJ3RStJiXhyeaMgOIxn5bmRswJTGDQcps/CLw/KbzXFomiA
         4KhohHfJlwcwbGnRKUJXzEpF1m1IbAd3P0qb+H1V6M5jTDnC0Qu0/CoTdCxdU188whOB
         e9wEy6RdvNimUcyK0rnGDM2Fzx/sytVRTrb1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ym2vxiiSkZboWqTFrRQZchxrLmktCPU70VmDq1pV1v4=;
        b=UtphBkpqkCvFSPJzv7buYLz6gQhFycPUbMVUiS18Ctsw4rdZshwXXbinMVzwCV9PBp
         2TLr8Kd/2xLkxyVT+E13aa/nDKWt+ILZtcz1CSRRx7pPshV1TAKEF9l7oCwnIFHnqjrG
         6/ina3Qi3rqI0/FId6ougUtVzbFgvv4g6E88c0dfEO7B9MuwczUZ8IioJaTEg1puGdDw
         MPjynlSC4JzWIkh4OGN4OFA82pbOscSOGbUTC4wY26MIQp0CAmnKttQOSMte1fozq75H
         dk3Cp8vCCx+RWVqbh71c6Mikkwww9LFGD9qanlMZNTje4GdtqHP0z9OE+KyzwyQGmue1
         bl9w==
X-Gm-Message-State: AOAM530iqqoA1vBwDU8bMz9oUTT77Oir8c2WX5qM3VTDhCegDc+hf5sI
        ac6SQIDDWNTa6djaRWy5r8qR
X-Google-Smtp-Source: ABdhPJxpnU5J/GyE7eu8WLhTw2SZt/rpWQYrTZUhMwcox8MqVAuEIRihh3QYdVns41cYWR72/jffWg==
X-Received: by 2002:adf:ce0f:0:b0:210:2f54:9ce9 with SMTP id p15-20020adfce0f000000b002102f549ce9mr10036041wrn.649.1654001851862;
        Tue, 31 May 2022 05:57:31 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id b16-20020a056000055000b0020d03b5c33dsm8798551wrf.46.2022.05.31.05.57.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 May 2022 05:57:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v7 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20220531100101.pdnrpkxbapur5gsk@quack3.lan>
Date:   Tue, 31 May 2022 14:57:29 +0200
Cc:     Yu Kuai <yukuai3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB1A8F13-76DB-4469-A5CA-D0AD17975E38@unimore.it>
References: <20220528095020.186970-1-yukuai3@huawei.com>
 <20220528095020.186970-3-yukuai3@huawei.com>
 <0D9355CE-F85B-4B1A-AEC3-F63DFC4B3A54@linaro.org>
 <b9a4ea60-28e5-b7aa-0154-ad7481eafbd3@huawei.com>
 <efe01dd1-0f99-dadf-956d-b0e80e1e602c@huawei.com>
 <1803FD7E-9FB1-4A1E-BD6D-D6657006589A@unimore.it>
 <a0d8452c-e421-45d3-b012-5355207fc0e1@huawei.com>
 <81214347-3806-4F54-B60F-3E5A1A5EC84D@unimore.it>
 <756631ee-6a85-303c-aca1-d60aaf477d0d@huawei.com>
 <20220531100101.pdnrpkxbapur5gsk@quack3.lan>
To:     Jan Kara <jack@suse.cz>
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



> Il giorno 31 mag 2022, alle ore 12:01, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Tue 31-05-22 17:33:25, Yu Kuai wrote:
>> =E5=9C=A8 2022/05/31 17:19, Paolo Valente =E5=86=99=E9=81=93:
>>>> Il giorno 31 mag 2022, alle ore 11:06, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>>=20
>>>> =E5=9C=A8 2022/05/31 16:36, Paolo VALENTE =E5=86=99=E9=81=93:
>>>>>> Il giorno 30 mag 2022, alle ore 10:40, Yu Kuai =
<yukuai3@huawei.com> ha scritto:
>>>>>>=20
>>>>>> =E5=9C=A8 2022/05/30 16:34, Yu Kuai =E5=86=99=E9=81=93:
>>>>>>> =E5=9C=A8 2022/05/30 16:10, Paolo Valente =E5=86=99=E9=81=93:
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> Il giorno 28 mag 2022, alle ore 11:50, Yu Kuai =
<yukuai3@huawei.com> ha scritto:
>>>>>>>>>=20
>>>>>>>>> Currently, bfq can't handle sync io concurrently as long as =
they
>>>>>>>>> are not issued from root group. This is because
>>>>>>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>>>>>>> bfq_asymmetric_scenario().
>>>>>>>>>=20
>>>>>>>>> The way that bfqg is counted into =
'num_groups_with_pending_reqs':
>>>>>>>>>=20
>>>>>>>>> Before this patch:
>>>>>>>>> 1) root group will never be counted.
>>>>>>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>>>>>>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>>>>>>>>=20
>>>>>>>>> After this patch:
>>>>>>>>> 1) root group is counted.
>>>>>>>>> 2) Count if bfqg have at least one bfqq that is marked busy.
>>>>>>>>> 3) Don't count if bfqg doesn't have any busy bfqqs.
>>>>>>>>=20
>>>>>>>> Unfortunately, I see a last problem here. I see a double =
change:
>>>>>>>> (1) a bfqg is now counted only as a function of the state of =
its child
>>>>>>>>      queues, and not of also its child bfqgs
>>>>>>>> (2) the state considered for counting a bfqg moves from having =
pending
>>>>>>>>      requests to having busy queues
>>>>>>>>=20
>>>>>>>> I'm ok with with (1), which is a good catch (you are lady =
explained
>>>>>>>> the idea to me some time ago IIRC).
>>>>>>>>=20
>>>>>>>> Yet I fear that (2) is not ok.  A bfqq can become non busy even =
if it
>>>>>>>> still has in-flight I/O, i.e.  I/O being served in the drive.  =
The
>>>>>>>> weight of such a bfqq must still be considered in the =
weights_tree,
>>>>>>>> and the group containing such a queue must still be counted =
when
>>>>>>>> checking whether the scenario is asymmetric.  Otherwise service
>>>>>>>> guarantees are broken.  The reason is that, if a scenario is =
deemed as
>>>>>>>> symmetric because in-flight I/O is not taken into account, then =
idling
>>>>>>>> will not be performed to protect some bfqq, and in-flight I/O =
may
>>>>>>>> steal bandwidth to that bfqq in an uncontrolled way.
>>>>>>> Hi, Paolo
>>>>>>> Thanks for your explanation.
>>>>>>> My orginal thoughts was using weights_tree insertion/removal, =
however,
>>>>>>> Jan convinced me that using bfq_add/del_bfqq_busy() is ok.
>>>>>>> =46rom what I see, when bfqq dispatch the last request,
>>>>>>> bfq_del_bfqq_busy() will not be called from __bfq_bfqq_expire() =
if
>>>>>>> idling is needed, and it will delayed to when such bfqq get =
scheduled as
>>>>>>> in-service queue again. Which means the weight of such bfqq =
should still
>>>>>>> be considered in the weights_tree.
>>>>>>> I also run some tests on null_blk with "irqmode=3D2
>>>>>>> completion_nsec=3D100000000(100ms) hw_queue_depth=3D1", and =
tests show
>>>>>>> that service guarantees are still preserved on slow device.
>>>>>>> Do you this is strong enough to cover your concern?
>>>>> Unfortunately it is not.  Your very argument is what made be =
believe
>>>>> that considering busy queues was enough, in the first place.  But, =
as
>>>>> I found out, the problem is caused by the queues that do not enjoy
>>>>> idling.  With your patch (as well as in my initial version) they =
are
>>>>> not counted when they remain without requests queued.  And this =
makes
>>>>> asymmetric scenarios be considered erroneously as symmetric.  The
>>>>> consequence is that idling gets switched off when it had to be =
kept
>>>>> on, and control on bandwidth is lost for the victim in-service =
queues.
>>>>=20
>>>> Hi=EF=BC=8CPaolo
>>>>=20
>>>> Thanks for your explanation, are you thinking that if bfqq doesn't =
enjoy
>>>> idling, then such bfqq will clear busy after dispatching the last
>>>> request?
>>>>=20
>>>> Please kindly correct me if I'm wrong in the following process:
>>>>=20
>>>> If there are more than one bfqg that is activatied, then bfqqs that =
are
>>>> not enjoying idle are still left busy after dispatching the last
>>>> request.
>>>>=20
>>>> details in __bfq_bfqq_expire:
>>>>=20
>>>>        if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
>>>>        =E2=94=8A   !(reason =3D=3D BFQQE_PREEMPTED &&
>>>>        =E2=94=8A     idling_needed_for_service_guarantees(bfqd, =
bfqq))) {
>>>> -> idling_needed_for_service_guarantees will always return true,
>>>=20
>>> It returns true only is the scenario is symmetric.  Not counting =
bfqqs
>>> with in-flight requests makes an asymmetric scenario be considered
>>> wrongly symmetric.  See function bfq_asymmetric_scenario().
>>=20
>> Hi, Paolo
>>=20
>> Do you mean this gap?
>>=20
>> 1. io1 is issued from bfqq1(from bfqg1)
>> 2. bfqq1 dispatched this io, it's busy is cleared
>> 3. *before io1 is completed*, io2 is issued from bfqq2(bfqg2)
>=20
> Yes. So as far as I understand Paolo is concerned about this scenario.
>=20
>> 4. with this patchset, while dispatching io2 from bfqq2, the scenario
>> should be symmetric while it's considered wrongly asymmetric.
>=20
> But with this patchset, we will consider this scenario symmetric =
because at
> any point in time there is only one busy bfqq. Before, we considered =
this
> scenario asymmetric because two different bfq groups have bfqq in =
their
> weights_tree. So before this patchset
> idling_needed_for_service_guarantees() returned true, after this =
patchset
> the function returns false so we won't idle anymore and Paolo argues =
that
> bfqq1 does not get adequate protection from bfqq2 as a result.
>=20
> I agree with Paolo this seems possible. The fix is relatively simple =
though
> - instead of changing how weights_tree is used for weight raised =
queues as
> you did originally, I'd move the accounting of groups with pending =
requests
> to bfq_add/del_bfqq_busy() and bfq_completed_request().
>=20

Why don't we use simply the existing logic? I mean, as for the changes =
made by this patch, we could simply turn the loop:

void bfq_weights_tree_remove(struct bfq_data *bfqd,
			     struct bfq_queue *bfqq)
{
	...
	for_each_entity(entity) {
		struct bfq_sched_data *sd =3D entity->my_sched_data;

		...
		if (entity->in_groups_with_pending_reqs) {
			entity->in_groups_with_pending_reqs =3D false;
			bfqd->num_groups_with_pending_reqs--;
		}
	}
	...
}

into a single:

	bfqd->num_groups_with_pending_reqs--;

so that only the parent group is concerned.

Thanks,
Paolo



> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

