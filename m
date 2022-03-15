Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7117C4D9F1F
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiCOPvL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 15 Mar 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbiCOPvK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 11:51:10 -0400
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395303CA65
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 08:49:56 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 22FFnrgM022178
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Mar 2022 16:49:53 +0100
Received: from corpappl17777.corp.saab.se (corpappl17777.corp.saab.se [10.12.196.84])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 22FFnbDO2475804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:49:37 +0100
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17777.corp.saab.se (10.12.196.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 16:49:52 +0100
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.015; Tue, 15 Mar 2022 16:49:52 +0100
From:   Olsson John <john.olsson@saabgroup.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Topic: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Index: Adg3spIZ/DvaypfiTgy8SrH+fLuE4AAB7CaAACHeIVAAA5VIgAACLZbg
Date:   Tue, 15 Mar 2022 15:49:52 +0000
Message-ID: <84e5b8652edd47d29597d499f29753d6@saabgroup.com>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <20220314164332.GA20424@blackbody.suse.cz>
 <bf2ea0888a9e45d3aafe412f0094cf86@saabgroup.com>
 <20220315103553.GA3780@blackbody.suse.cz>
In-Reply-To: <20220315103553.GA3780@blackbody.suse.cz>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.122]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26772.007
x-tm-as-result: No-10--16.774500-5.000000
x-tmase-matchedrid: dL10VBB8yofK19rKCr/Ovgrcxrzwsv5uXPK9y3z82GvFLPA+3aq1trWO
        DdZ1PDmEbxfaEPweeMix2JNhrMY3W2C5k6NopKxYbb4JyMK+kzD5UnqVnIHSz4BTB33z0iydsga
        5U55zNFN8LHorWJhE/ZWkRzherKxNFerRtFceXJiTeuX4xo2DEMCY5/Mqi1OimG9h0TAHW4sRmT
        KZ05+uWZFdnU03kEMvVOKdUBTzw79ORhEYAb+gklVeGWZmxN2Mo1j/BIy9wP1y8pTPKbY8Oshvb
        Sbu8/QdzkgzzcA6iXggAj7ZBG/Ph/698U+GKCAUrMZ+BqQt2NoZskwWqoib3A7oa0fEtdqUbgWU
        zd5K/4YhQz4Qjt84Y1qiwVJPzWtLujmXJ97QXJmaVoAi2I40/V/d6ediod7YYeNZeQ9+cGIEYwu
        gO/Klxdax+EYNADk9dARgauwPvtYhT56GTxfKB5Ak4Vz6rKorT5ysQDj6eFnyXa/7gO3s/ZIT1/
        aWHd4kIx/OqCk5J13cDQG7Xu33PbWmEBjwFcVenVTWWiNp+v+vOXyw2JYKUpsoi2XrUn/Jsuf7R
        WbvUtyrusVRy4an8d934/rDAK3zGjFMngtLLWicA6dTiL9848H1PttlO2ecBo4g2CeK6oEs/ZPP
        OENGbg6NYB1Qr1u02+HkU2X4rVw=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.774500-5.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26772.007
x-tm-snts-smtp: 84D2573E8ECBC66A8E2BB48B68DDEFC1A45D965E8650C08E5CB33C1F960189582002:B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> (Actually when I take a step back and read your motivational example
> of a legacy game in VM, I don't think FIFO (or another RT policy) is
> suited for this case. Plain SCHED_OTHER and cpu controller's
> bandwidth limitation could do just fine -- you can apply to a
> (threaded) cgroup with chosen threads only.)

As you might have already surmised it was a placeholder example to
give the general idea. I think it is time to add some more details. :)

Assume that you have an embedded system running some kind of software
with real time like properties. You want to develop and debug your
software locally on your high-end machine since it is much more
convenient. Alas the software runs way too fast due to the difference
in performance so you can't detect overruns etc.

Assume also that you have a special scheduler that behaves in a very
strange way compared to ordinary schedulers. Each scheduling tick it
waits a configurable time before it lets the scheduled task execute
its tick. This effectively means that the task is throttled and thus
executes slower than it normally would. By tuning the waiting time you
can tune the execution speed so comes close enough to what it is on
the target system.

Assume also that you have enough cores in your system so you can
dedicate one core for the VMM and one core for the virtual core thread
the Guest uses to execute the software. One way of implementing this
kind of scheduler would be to create a fork of the FIFO scheduler that
have this behavior.

This crazy(?) technique can of course be used for other things such as
running old DOS games or running an RTOS intended for embedded systems
as the Guest in the VM and so on. ;)


/John

-----Original Message-----
From: Michal Koutný <mkoutny@suse.com> 
Sent: den 15 mars 2022 11:36
To: Olsson John <john.olsson@saabgroup.com>
Cc: cgroups@vger.kernel.org
Subject: Re: [EXTERNAL] Re: Split process across multiple schedulers?

On Tue, Mar 15, 2022 at 08:19:26AM +0000, Olsson John <john.olsson@saabgroup.com> wrote:
> If I'm understanding you correctly this effectively means that it is 
> possible to spread a process and its threads across multiple cgroups 
> that in turn may have different schedulers (and CPU affinity) 
> associated with them?

Yes, the docs is here
https://www.kernel.org/doc/html/v5.17-rc8/admin-guide/cgroup-v2.html#threads

> > (Without CONFIG_RT_GROUP_SCHED all RT threads are effectively in the 
> > root cgroup.)
> 
> Interesting! I have missed this little tidbit of information. This is 
> indeed very good to know!

Maybe I should have added this applies from the POV of the cpu controller in particular...

> A side effect of this is that in V2 you can't have an RT thread pinned 
> to a specific core that is evacuated, right?

...it has no effect for grouping of cpuset controller (assuming both cpu and cpuset are enabled in given subtree).

> If you could do this it would also be possible to remove the portion 
> of the scheduling interval that is left for non-RT threads in the 
> cgroup config since there would not be any other threads on this 
> evacuated core.
> By doing that you would eliminate jitter due to that otherwise the 
> scheduler would interrupt the RT thread and immediately re-schedule it 
> again. And thus you would theoretically get very good RT properties 
> (unless you make system calls).

Well, there are more jobs that can interfere with RT workload on a cpu (see isolcpus= [1]) and there's some ongoing work to make these more convenient via cpuset controller [2]. The currently working approach would be to use isolcpus= cmdline to isolate the CPUs and use either
sched_setaffinity() or cpuset controller to place tasks on the reserved CPUs (the cpuset approach is more strict as it may prevent unprivileged threads to switch to another CPU). 

> If you instead used FIFO scheduling (which handles RT threads only,
> right?) then you could eliminate this noise. Or I am just showing off 
> how little I understand about scheduling in Linux. ;)

(Actually when I take a step back and read your motivational example of a legacy game in VM, I don't think FIFO (or another RT policy) is suited for this case. Plain SCHED_OTHER and cpu controller's bandwidth limitation could do just fine -- you can apply to a (threaded) cgroup with chosen threads only.)

HTH,
Michal


[1] https://www.kernel.org/doc/html/v5.17-rc8/admin-guide/kernel-parameters.html?highlight=isolcpus
[2] https://lore.kernel.org/all/20211205183220.818872-1-longman@redhat.com/
