Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445454D88BE
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 17:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiCNQEo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbiCNQEn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 12:04:43 -0400
X-Greylist: delayed 2611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 09:03:31 PDT
Received: from weald.air.saab.se (weald.air.saab.se [136.163.212.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC22D1DB
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 09:03:30 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald.air.saab.se (8.14.7/8.14.7) with ESMTP id 22EFJvQC027332
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:19:57 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald.air.saab.se 22EFJvQC027332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald; t=1647271197;
        bh=NMfKos0nNiB4Oz0OvKT1xPjH3pw3nC156jsh/mE4gqA=;
        h=From:To:Subject:Date:From;
        b=KhboJGrOoKjVSprJ1Ht/lodOSl1Qq7upDHE+RDdylmnRszT66GbthShl941htHTzx
         C9iikMaFooKa6oodzHo4wwnSrH5zb4fb+7XAGVa/8SKK4NpolKoq2s9Gu8E+bXGsOR
         sTo3igf9yXe690SmXcPATsG4l9H9CB0ejoOrK5As=
Received: from corpappl17773.corp.saab.se (corpappl17773.corp.saab.se [10.12.196.80])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 22EFJiIt1954772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:19:44 +0100
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17773.corp.saab.se (10.12.196.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 16:19:56 +0100
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.015; Mon, 14 Mar 2022 16:19:56 +0100
From:   Olsson John <john.olsson@saabgroup.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Split process across multiple schedulers?
Thread-Topic: Split process across multiple schedulers?
Thread-Index: Adg3spIZ/DvaypfiTgy8SrH+fLuE4A==
Date:   Mon, 14 Mar 2022 15:19:56 +0000
Message-ID: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.121]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26772.000
x-tm-as-result: No-10--1.615500-5.000000
x-tmase-matchedrid: SBQPLWj9YN14GcCqxQcAiNZfgYyzPJbKZR+OFNkbtdotferJ/d7Ab7eW
        peyiLDjpVs85UhK71rhFRAWsG2/33LKcEIYSkNih5jpYq8oRllNNLPQl0QAltArkj7klVufuq3r
        StgHuRBlpxMdmxgx3TPCUj9LZyScX7lF2b+LegzHAtiT41LFzmjVEnbrqmBw70mU2/P/r9E1ZEI
        hf8tdBvlozlKLxCSzoXbv0ZG49e0le2wadKADqqh1kSRHxj+Z5E84OITRIYTOZj6vI4Rf7hHWXP
        dzCdiWnri99y3ZFr5kkkjRJh165zQ8WIhDVn71jC8FMH3T6F75kq1sTXnjlh5soi2XrUn/JmTDw
        p0zM3zoqtq5d3cxkNau4Ajf8I6WLVvcVN8iebuft6SMuCathsjZ9PXWDedH2Uogi3K6TmmtKugd
        182uJ3pgwcrL5W/Skz9um+kT1I4xxXgX+mJOM5Ac/aPgWuKf3jxd+UmKvHKoDEsYAQfVhCM8ksj
        sTeCaRGRDIJ9tZEDhDDKa3G4nrLQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--1.615500-5.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26772.000
x-tm-snts-smtp: 3E665B50384CE7D905D2EBD5D689BAB4C17B9ED6419DAB5417F5D56F7DC2A1E62002:B
Content-Type: text/plain; charset="us-ascii"
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

Hi!

I have tried reading the documentation for CGroups V1 and V2 and it seems t=
hat there is one usecase that we are interested in that *is* supported by C=
Groups V1 but not by CGroups V2. I really hope that I have overlooked somet=
hing and you can tell med to RTFM. ;)

Assume that you want to have a virtual machine running on at least one core=
. Connected to the VM you need to also have a VMM (Virtual Machine Monitor)=
 that acts as some sort of glue between KVM and the Guest in the VM. For in=
stance Virtual Box on Linux uses QEmu as its VMM. Within the VM each virtua=
l core is connected to a thread in the Host computer, and usually you want =
to have a 1:1 mapping between virtual core threads and physical cores.

Preferably for optimal performance you want to isolate the cores where the =
virtual core threads are running so nothing else interferes with them (besi=
des kernel threads connected to IRQs that can't be moved from the isolated =
cores). The VMM is then running on another core that is not running a virtu=
al core thread. CGroups is the preferred way of accomplishing this. :)

The virtual core threads need to have some parent process and the VMM proce=
ss is the natural home of for these threads. My understanding of CGroups V1=
 is that it is possible to have one scheduler associated  there are use cas=
es where you might want to have one kind of scheduler for the VMM process (=
for instance CFS) and another scheduler for the virtual core threads (for i=
nstance FIFO).

My conclusion after reading the documentation for CGroups V2 is that the ab=
ove scenario is no longer possible to do. Or have I misunderstood something=
 here?


A bit more detailed background after the general idea behind my question. A=
ssume that the software running within the VM is an old Windows 98 game you=
 have the license key for (for instance SimCity 3000). The developers of Si=
mCity 3000 didn't anticipate that you would want to run the game on a compu=
ter that was several times faster than what existed at its release. Music p=
lays fine, but when you try to scroll around when zoomed in using the curso=
r keys on the keyboard (or the mouse by placing the mouse pointer on the ed=
ge of the screen) the scrolling speed is inhumanly fast. Basically the game=
 is no longer enjoyable to play. It runs too fast.

Trying to slow it down using a tool like cpulimit is way too coarse; the mu=
sic is no longer possible to listen to as it is played in bursts. However i=
f you instead have a specially designed scheduler that tries to execute a p=
rogram with a configured "slow-down"-factor (each scheduling tick you ensur=
e that it is executed only a fraction of that tick) then you could get it t=
o run with a just about right speed. However you do not want to slow down V=
MM with the same scheduler and thus you want to be able to set different sc=
hedulers for different threads within a single process (assuming that they =
are running on different cores).

And yes, there are other applications for this besides running old games. ;=
)
=20
