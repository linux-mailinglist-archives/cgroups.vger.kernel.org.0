Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC34D9609
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbiCOIUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Mar 2022 04:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiCOIUp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 04:20:45 -0400
Received: from weald.air.saab.se (weald.air.saab.se [136.163.212.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324B47044
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 01:19:31 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald.air.saab.se (8.14.7/8.14.7) with ESMTP id 22F8JTxJ094642
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Mar 2022 09:19:29 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald.air.saab.se 22F8JTxJ094642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald; t=1647332369;
        bh=Ta1UU1ZM9feM3kIV3ZbiDmewkZry9QpuDsZ21Fr45XE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ueKodJhjDRiv6sqU6EZeL46LXdLsT6Lh6JZZhBpARnls7pXmYufWpJDTTuq7iyU6M
         c87HScapL+X6ZK+aYGHY2pBoi0CKk65vkk9aHNF9/8f3+i0sDhgHeMjSAbYaHuuDpw
         LBu7LYoBARcT1OceKkD0lUD8InRl0OGry1xWojM8=
Received: from corpappl17772.corp.saab.se (corpappl17772.corp.saab.se [10.12.196.79])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 22F8JE8m2211042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 09:19:14 +0100
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17772.corp.saab.se (10.12.196.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 09:19:26 +0100
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.015; Tue, 15 Mar 2022 09:19:26 +0100
From:   Olsson John <john.olsson@saabgroup.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Topic: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Index: Adg3spIZ/DvaypfiTgy8SrH+fLuE4AAB7CaAACHeIVA=
Date:   Tue, 15 Mar 2022 08:19:26 +0000
Message-ID: <bf2ea0888a9e45d3aafe412f0094cf86@saabgroup.com>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <20220314164332.GA20424@blackbody.suse.cz>
In-Reply-To: <20220314164332.GA20424@blackbody.suse.cz>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.122]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26772.005
x-tm-as-result: No-10--6.670000-5.000000
x-tmase-matchedrid: u7Yf2n7Ca/3K19rKCr/Ovgrcxrzwsv5uXPK9y3z82GsNIbt2ZiH1ut+O
        fqJ/ZuS6BNyCmIook0d0oU8EHuLaxibqjkKVIn0C/e+uN180e5fYHmD3SW1IVt9zZd3pUn7Ky/B
        1zk8gQ/w+yPmqNL50IVYKVfdjpYn3H90yz2QfdHjhhAk2yII2+bAUgNbbmVUmAPNS/ChAKGie1T
        cu/lFv/Z6DNU85JAtYEgykP1mc9Scg+HFFDyjmd2zBijri5+RVwdP+8YXeAckrfoFYrvlA5GBAo
        GIwBSP2Pf3y27SAoxF7uFc79DJwjaO2pjL/vy8KngIgpj8eDcByZ8zcONpAscRB0bsfrpPIqxB3
        2o9eGcn/ita+mP1RyJEqHOTQHvDUmo8mufY9O6cUPETml+vcQL9aRJz904otBx5pogNbTcjAvpL
        E+mvX8g==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--6.670000-5.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26772.005
x-tm-snts-smtp: 44AB30F7120C3496E9776DA4D7681CFD6253DBFEB5AAD460C6872449F6FD40DD2002:B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thank you for your pointers Michal! :)


> Are you missing CONFIG_RT_GROUP_SCHED and v1 cpu controller's
> cpu.rt_{runtime,period}_us? (Just asking, you didn't mention this
> explicitly in your e-mail but it sounds so and it's a thing that's
> indeed missing in v2.)

I'm not sure. I have to double check. If I'm indeed missing
CONFIG_RT_GROUP_SCHED I'll let you know. ;)


> sched_setscheduler(2) applies to threads regardless of cgroup
> membership, there's no change between v1 and v2.

If I'm understanding you correctly this effectively means that it is
possible to spread a process and its threads across multiple cgroups
that in turn may have different schedulers (and CPU affinity)
associated with them?


> (Without CONFIG_RT_GROUP_SCHED all RT threads are effectively in the
> root cgroup.)

Interesting! I have missed this little tidbit of information. This is
indeed very good to know!

A side effect of this is that in V2 you can't have an RT thread pinned
to a specific core that is evacuated, right? If you could do this it
would also be possible to remove the portion of the scheduling
interval that is left for non-RT threads in the cgroup config since
there would not be any other threads on this evacuated core. By doing
that you would eliminate jitter due to that otherwise the scheduler
would interrupt the RT thread and immediately re-schedule it
again. And thus you would theoretically get very good RT properties
(unless you make system calls).

Now one could argue that there is no point in having a pinned RT
thread on a single core that is evacuated, but that means that the
thread would be interrupted HZ times per second. If you instead used
FIFO scheduling (which handles RT threads only, right?) then you could
eliminate this noise. Or I am just showing off how little I understand
about scheduling in Linux. ;)


> You may need to enable threaded mode on v2 (see cgroup.type) to
> manipulate with individual threads across cgroups. (E.g. if you want
> to use cpuset controller to pin/restrict individual threads.)

I'll read up a bit more and try what you suggest. If we have
misunderstood each other I'll contact the mailing list again with more
details. :)

