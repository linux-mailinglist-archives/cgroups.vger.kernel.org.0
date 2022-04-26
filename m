Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E2510000
	for <lists+cgroups@lfdr.de>; Tue, 26 Apr 2022 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbiDZOH4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Apr 2022 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbiDZOHx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Apr 2022 10:07:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF3198C43
        for <cgroups@vger.kernel.org>; Tue, 26 Apr 2022 07:04:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so15569393ejj.10
        for <cgroups@vger.kernel.org>; Tue, 26 Apr 2022 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KtEIWr2kc5GEVWgugzC6y2i1UxqHjSA/KzvAMY+u73s=;
        b=SHrdp9T5rVKvqeGI18n+FNWzsD6B04fSIfbGdjDqzpy2tRqZBRGE8aOx7G7p3qQT/F
         EYUB7aY5ddMpvv6FRvek/n6ATVNM5YNIM3GW9JMOxEji3PX2BfmIvzoeApJhegaDsTq+
         ZflfYtdG8IKua69IEJDqXfbM7xW3ghoGKgp758YfEZ5UIm1vhM80KVFtrDn/oC7qXN0u
         lwhSjguvJRK9KAbktBVMsfVdH2GAjA/w3UUJ0zp8eawUuMIFKXLTo49WZughcfH4daxx
         aAWNyPOwZJsVxvONPHS2gSawPqD7DfI02xRkVpmQJwaavdGCZCC9471nDkBD755RKe3S
         4lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KtEIWr2kc5GEVWgugzC6y2i1UxqHjSA/KzvAMY+u73s=;
        b=TTZ3tC//+RctMsOsQWCOoyDyPoNQe6XCCuzMDWwrqq6/g/y8Q8yHAqjfknJF6V+N8F
         TZID78yLmdn3xiVCIuH1JmrCBp0XMBbMkt48I/LG7FSWMfi6DJIDRrK40DgMQQ+iGIKi
         QNIiEAGfZoexMmK9EjlX8JF05LRpwKDL+5NjYqb1L3CVkXeCsaecJScLKm/7mCuxTpXz
         aPUKxzwMt1hzEaBk68or67PJpUWuqSWaabIuZKpKhCW9CKreHA5RRQuXzRvy9a8aQdqq
         UW7A2/h6GmkNgbCUMO7dEQqrR/XlYRDdyDTjUzP4Nmvc+zX5mJYiwWMpDS1ODeuxd+Zj
         fMcA==
X-Gm-Message-State: AOAM531BIlqoWJyBKbMjTNsv6Upd5mzwYYQp8AK0GnBLvHAoXxoLjTd7
        XFP7MSkJZsmVc32Qa15nGFSXWw==
X-Google-Smtp-Source: ABdhPJwDU5trBFEPTcjdhG4LeCkBncp8DcariF123JXTjaUzrqvovNIIeT/vCfhhoBjdW23PClUkiw==
X-Received: by 2002:a17:907:6d0d:b0:6f3:61e1:e33b with SMTP id sa13-20020a1709076d0d00b006f361e1e33bmr19353124ejc.320.1650981882816;
        Tue, 26 Apr 2022 07:04:42 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm6512881edz.35.2022.04.26.07.04.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2022 07:04:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for
 weight-raised queue
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220426091556.qzryd552gzo6dikf@quack3.lan>
Date:   Tue, 26 Apr 2022 16:04:37 +0200
Cc:     "yukuai (C)" <yukuai3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C73DAAB4-7919-4449-86E2-449BD068E57A@linaro.org>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-3-yukuai3@huawei.com>
 <20220425094856.qgkhba2klguduxot@quack3.lan>
 <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
 <20220425161650.xzyijgkb5yzviea3@quack3.lan>
 <4591d02d-1f14-c928-1c50-6e434dfbb7b2@huawei.com>
 <20220426074023.5y4gwvjsjzem3vgp@quack3.lan>
 <77b4c06c-f813-bcac-ea26-107e52f46d0a@huawei.com>
 <20220426091556.qzryd552gzo6dikf@quack3.lan>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 26 apr 2022, alle ore 11:15, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Tue 26-04-22 16:27:46, yukuai (C) wrote:
>> =E5=9C=A8 2022/04/26 15:40, Jan Kara =E5=86=99=E9=81=93:
>>> On Tue 26-04-22 09:49:04, yukuai (C) wrote:
>>>> =E5=9C=A8 2022/04/26 0:16, Jan Kara =E5=86=99=E9=81=93:
>>>>> Hello!
>>>>>=20
>>>>> On Mon 25-04-22 21:34:16, yukuai (C) wrote:
>>>>>> =E5=9C=A8 2022/04/25 17:48, Jan Kara =E5=86=99=E9=81=93:
>>>>>>> On Sat 16-04-22 17:37:50, Yu Kuai wrote:
>>>>>>>> Weight-raised queue is not inserted to weights_tree, which =
makes it
>>>>>>>> impossible to track how many queues have pending requests =
through
>>>>>>>> weights_tree insertion and removel. This patch add fake =
weight_counter
>>>>>>>> for weight-raised queue to do that.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>>>>=20
>>>>>>> This is a bit hacky. I was looking into a better place where to =
hook to
>>>>>>> count entities in a bfq_group with requests and I think =
bfq_add_bfqq_busy()
>>>>>>> and bfq_del_bfqq_busy() are ideal for this. It also makes better =
sense
>>>>>>> conceptually than hooking into weights tree handling.
>>>>>>=20
>>>>>> bfq_del_bfqq_busy() will be called when all the reqs in the bfqq =
are
>>>>>> dispatched, however there might still some reqs are't completed =
yet.
>>>>>>=20
>>>>>> Here what we want to track is how many bfqqs have pending reqs,
>>>>>> specifically if the bfqq have reqs are't complted.
>>>>>>=20
>>>>>> Thus I think bfq_del_bfqq_busy() is not the right place to do =
that.
>>>>>=20
>>>>> Yes, I'm aware there will be a difference. But note that bfqq can =
stay busy
>>>>> with only dispatched requests because the logic in =
__bfq_bfqq_expire() will
>>>>> not call bfq_del_bfqq_busy() if idling is needed for service =
guarantees. So
>>>>> I think using bfq_add/del_bfqq_busy() would work OK.
>>>> Hi,
>>>>=20
>>>> I didn't think of that before. If bfqq stay busy after dispathing =
all
>>>> the requests, there are two other places that bfqq can clear busy:
>>>>=20
>>>> 1) bfq_remove_request(), bfqq has to insert a new req while it's =
not in
>>>> service.
>>>=20
>>> Yes and the request then would have to be dispatched or merged. =
Which
>>> generally means another bfqq from the same bfqg is currently active =
and
>>> thus this should have no impact on service guarantees we are =
interested in.
>>>=20
>>>> 2) bfq_release_process_ref(), user thread is gone / moved, or old =
bfqq
>>>> is gone due to merge / ioprio change.
>>>=20
>>> Yes, here there's no new IO for the bfqq so no point in maintaining =
any
>>> service guarantees to it.
>>>=20
>>>> I wonder, will bfq_del_bfqq_busy() be called immediately when =
requests
>>>> are completed? (It seems not to me...). For example, a user thread
>>>> issue a sync io just once, and it keep running without issuing new =
io,
>>>> then when does the bfqq clears the busy state?
>>>=20
>>> No, when bfqq is kept busy, it will get scheduled as in-service =
queue in
>>> the future. Then what happens depends on whether it will get more =
requests
>>> or not. But generally its busy state will get cleared once it is =
expired
>>> for other reason than preemption.
>>=20
>> Thanks for your explanation.
>>=20
>> I think in normal case using bfq_add/del_bfqq_busy() if fine.
>>=20
>> There is one last situation that I'm worried: If some disk are very
>> slow that the dispatched reqs are not completed when the bfqq is
>> rescheduled as in-service queue, and thus busy state can be cleared
>> while reqs are not completed.
>>=20
>> Using bfq_del_bfqq_busy() will change behaviour in this specail case,
>> do you think service guarantees will be broken?
>=20
> Well, I don't think so. Because slow disks don't tend to do a lot of
> internal scheduling (or have deep IO queues for that matter). Also =
note
> that generally bfq_select_queue() will not even expire a queue =
(despite it
> not having any requests to dispatch) when we should not dispatch other
> requests to maintain service guarantees. So I think service guarantees =
will
> be generally preserved. Obviously I could be wrong, we we will not =
know
> until we try it :).
>=20

I have nothing to add ... You guys are getting better than me about BFQ =
:)

Thanks,
Paolo

> 								Honza
>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

