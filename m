Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE9538D91
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiEaJTX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiEaJTX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 05:19:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E810262A12
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 02:19:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e25so7166392wra.11
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z28jpdTmHxjV8ax9hyrwR2GnHy5t21qrhC5BIev/QD4=;
        b=gWX/C7SZ5pkAEgdZVPyWOQRd80HLkperu2WPySC+MFUBohcpCWfcQJhtrVx2cKD3Ac
         JRPrAgFIitnn2lwg4slAq0slLqBjXPHRniO179F9GrIr3S03rdsEgFt3ap46Wj/vVEi4
         eEpfb/+ljdaC4s7oBibdVp+sUfEhSKrV/tBC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z28jpdTmHxjV8ax9hyrwR2GnHy5t21qrhC5BIev/QD4=;
        b=y9ay3kB2KWzIwkp7NmuUmgR0SS2/yXErTLlEMpZ86HIILXlDn/hthgbKM7Gskc/pU7
         vAfJ5ttwqu3dcxllZtr1WQwNmCCeTViA699D+Xd+e279MGIs62WpzuiZZEeV8X8U3Acd
         DjOSvkfKEoAcdgXuF3Y7rP7Q3z2vvtuIt0bn0gtHXqRR141G8zgsUph+Ij/+FZVx1NNr
         +taRqWloeiNhUAVDFlLKcdXm2gkrhYuujvDFRMeYXgAAqu6+jc/WInRQRqES39lyOjER
         s1kOtftw3Z8hsQWlIB+gdMB7ZuRrYHrjpudAwXeXIgLD3OdXMMjO7dnE31Y4K5RY+BiV
         GL3Q==
X-Gm-Message-State: AOAM530OUCPlyVOz7xwas46Mi0lbhJTFoc2PZtSUOKt8Lzg8dhPkkhsR
        Rh5KUtfSUgnBjJSDGtaRrNMSmVijo05d
X-Google-Smtp-Source: ABdhPJyf+Jl8eEykVrUxJYOL8Y/SCADMLo00CH+/x2YvCQXrFNJ7xKn2D2EbeDgEsLItIgGysSc6mQ==
X-Received: by 2002:a05:6000:1acd:b0:20f:dae8:569d with SMTP id i13-20020a0560001acd00b0020fdae8569dmr35229996wry.491.1653988759475;
        Tue, 31 May 2022 02:19:19 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id u1-20020adfae41000000b0020c5253d926sm11108335wrd.114.2022.05.31.02.19.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 May 2022 02:19:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v7 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <a0d8452c-e421-45d3-b012-5355207fc0e1@huawei.com>
Date:   Tue, 31 May 2022 11:19:15 +0200
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <81214347-3806-4F54-B60F-3E5A1A5EC84D@unimore.it>
References: <20220528095020.186970-1-yukuai3@huawei.com>
 <20220528095020.186970-3-yukuai3@huawei.com>
 <0D9355CE-F85B-4B1A-AEC3-F63DFC4B3A54@linaro.org>
 <b9a4ea60-28e5-b7aa-0154-ad7481eafbd3@huawei.com>
 <efe01dd1-0f99-dadf-956d-b0e80e1e602c@huawei.com>
 <1803FD7E-9FB1-4A1E-BD6D-D6657006589A@unimore.it>
 <a0d8452c-e421-45d3-b012-5355207fc0e1@huawei.com>
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



> Il giorno 31 mag 2022, alle ore 11:06, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> =E5=9C=A8 2022/05/31 16:36, Paolo VALENTE =E5=86=99=E9=81=93:
>>> Il giorno 30 mag 2022, alle ore 10:40, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>=20
>>> =E5=9C=A8 2022/05/30 16:34, Yu Kuai =E5=86=99=E9=81=93:
>>>> =E5=9C=A8 2022/05/30 16:10, Paolo Valente =E5=86=99=E9=81=93:
>>>>>=20
>>>>>=20
>>>>>> Il giorno 28 mag 2022, alle ore 11:50, Yu Kuai =
<yukuai3@huawei.com> ha scritto:
>>>>>>=20
>>>>>> Currently, bfq can't handle sync io concurrently as long as they
>>>>>> are not issued from root group. This is because
>>>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>>>> bfq_asymmetric_scenario().
>>>>>>=20
>>>>>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>>>>>=20
>>>>>> Before this patch:
>>>>>> 1) root group will never be counted.
>>>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>>>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>>>>>=20
>>>>>> After this patch:
>>>>>> 1) root group is counted.
>>>>>> 2) Count if bfqg have at least one bfqq that is marked busy.
>>>>>> 3) Don't count if bfqg doesn't have any busy bfqqs.
>>>>>=20
>>>>> Unfortunately, I see a last problem here. I see a double change:
>>>>> (1) a bfqg is now counted only as a function of the state of its =
child
>>>>>      queues, and not of also its child bfqgs
>>>>> (2) the state considered for counting a bfqg moves from having =
pending
>>>>>      requests to having busy queues
>>>>>=20
>>>>> I'm ok with with (1), which is a good catch (you are lady =
explained
>>>>> the idea to me some time ago IIRC).
>>>>>=20
>>>>> Yet I fear that (2) is not ok.  A bfqq can become non busy even if =
it
>>>>> still has in-flight I/O, i.e.  I/O being served in the drive.  The
>>>>> weight of such a bfqq must still be considered in the =
weights_tree,
>>>>> and the group containing such a queue must still be counted when
>>>>> checking whether the scenario is asymmetric.  Otherwise service
>>>>> guarantees are broken.  The reason is that, if a scenario is =
deemed as
>>>>> symmetric because in-flight I/O is not taken into account, then =
idling
>>>>> will not be performed to protect some bfqq, and in-flight I/O may
>>>>> steal bandwidth to that bfqq in an uncontrolled way.
>>>> Hi, Paolo
>>>> Thanks for your explanation.
>>>> My orginal thoughts was using weights_tree insertion/removal, =
however,
>>>> Jan convinced me that using bfq_add/del_bfqq_busy() is ok.
>>>> =46rom what I see, when bfqq dispatch the last request,
>>>> bfq_del_bfqq_busy() will not be called from __bfq_bfqq_expire() if
>>>> idling is needed, and it will delayed to when such bfqq get =
scheduled as
>>>> in-service queue again. Which means the weight of such bfqq should =
still
>>>> be considered in the weights_tree.
>>>> I also run some tests on null_blk with "irqmode=3D2
>>>> completion_nsec=3D100000000(100ms) hw_queue_depth=3D1", and tests =
show
>>>> that service guarantees are still preserved on slow device.
>>>> Do you this is strong enough to cover your concern?
>> Unfortunately it is not.  Your very argument is what made be believe
>> that considering busy queues was enough, in the first place.  But, as
>> I found out, the problem is caused by the queues that do not enjoy
>> idling.  With your patch (as well as in my initial version) they are
>> not counted when they remain without requests queued.  And this makes
>> asymmetric scenarios be considered erroneously as symmetric.  The
>> consequence is that idling gets switched off when it had to be kept
>> on, and control on bandwidth is lost for the victim in-service =
queues.
>=20
> Hi=EF=BC=8CPaolo
>=20
> Thanks for your explanation, are you thinking that if bfqq doesn't =
enjoy
> idling, then such bfqq will clear busy after dispatching the last
> request?
>=20
> Please kindly correct me if I'm wrong in the following process:
>=20
> If there are more than one bfqg that is activatied, then bfqqs that =
are
> not enjoying idle are still left busy after dispatching the last
> request.
>=20
> details in __bfq_bfqq_expire:
>=20
>        if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
>        =E2=94=8A   !(reason =3D=3D BFQQE_PREEMPTED &&
>        =E2=94=8A     idling_needed_for_service_guarantees(bfqd, =
bfqq))) {
> -> idling_needed_for_service_guarantees will always return true,

It returns true only is the scenario is symmetric.  Not counting bfqqs
with in-flight requests makes an asymmetric scenario be considered
wrongly symmetric.  See function bfq_asymmetric_scenario().

Paolo

> bfqq(whether or not enjoy idling) will stay busy.
>                if (bfqq->dispatched =3D=3D 0)
>                        /*
>                        =E2=94=8A* Overloading budget_timeout field to =
store
>                        =E2=94=8A* the time at which the queue remains =
with no
>                        =E2=94=8A* backlog and no outstanding request; =
used by
>                        =E2=94=8A* the weight-raising mechanism.
>                        =E2=94=8A*/
>                        bfqq->budget_timeout =3D jiffies;
>=20
>                bfq_del_bfqq_busy(bfqd, bfqq, true);
>=20
> Thanks,
> Kuai

