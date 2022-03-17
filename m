Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA514DC2B2
	for <lists+cgroups@lfdr.de>; Thu, 17 Mar 2022 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiCQJbj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Mar 2022 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiCQJbi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Mar 2022 05:31:38 -0400
Received: from weald.air.saab.se (weald.air.saab.se [136.163.212.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E131D4C18
        for <cgroups@vger.kernel.org>; Thu, 17 Mar 2022 02:30:20 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald.air.saab.se (8.14.7/8.14.7) with ESMTP id 22H9UAHZ073375
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Mar 2022 10:30:10 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald.air.saab.se 22H9UAHZ073375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald; t=1647509411;
        bh=b6FqKrBh6NuQz0yvGHKXPjeDUeXTkFJrPXcooHJHzV4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=o6fXvX9Q0tncD/kN53hCHF4dU0FVKcL60NwupF1CCQ4PHXHkgT9sAhd4yjrxBOMIS
         F2Krn57chEGI77kPFaanrLUtBHlHjMIcmVOzypWKOyV+xohsewJ+MjVN/bYp09w6eA
         YzsqGugrhrBus9ylMNG3Er4YAxBtCBUH5N8nYg+Y=
Received: from corpappl17780.corp.saab.se (corpappl17780.corp.saab.se [10.12.196.87])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 22H9U5tk738279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 10:30:05 +0100
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17780.corp.saab.se (10.12.196.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Mar 2022 10:30:09 +0100
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.015; Thu, 17 Mar 2022 10:30:09 +0100
From:   Olsson John <john.olsson@saabgroup.com>
To:     Tejun Heo <tj@kernel.org>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Topic: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Index: Adg3spIZ/DvaypfiTgy8SrH+fLuE4ABmU+gAAAIfiuD///4eAP/+/g1g
Date:   Thu, 17 Mar 2022 09:30:09 +0000
Message-ID: <943440a04e4c4731a3e9e6a7b1259251@saabgroup.com>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <YjIShE3mwRyNbO53@slm.duckdns.org>
 <e9cac4aba6384c5c91125a9f7d61a4e8@saabgroup.com>
 <YjIfMLG5W2a/E4vX@slm.duckdns.org>
In-Reply-To: <YjIfMLG5W2a/E4vX@slm.duckdns.org>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.124]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26776.006
x-tm-as-result: No-10--5.818500-5.000000
x-tmase-matchedrid: C/snMIRQLS3K19rKCr/Ovgrcxrzwsv5uXPK9y3z82GvRguFbDyQ6QWsV
        Mgb+0+QTgP2p92ehQtCGKomsRGtEOhPcKKDHsPAh9Ib/6w+1lWTm1vUHDy7uwnLylM8ptjw6nUL
        NgN42j5Naf/8Uw5sGwoACHEwi7FEl4LNHCv9qbsnuW/BrYJGl/Wo8zUxTJUAjbkvAJoOQ99mNpx
        yS486Sbkp8EzfxzhxRWrBuOGs7/XkR88BdwfqweMEocegS/lMoQR7lWMXPA1vW2YYHslT0Iybwn
        d9CSevUimyY0YAT/KkDcb80+9h4A7pl0W1gY0BsR+GtoiXVeDHdvovMm13clX5M9ijZ/f3P4xu5
        XN3Jhhp4bs5UaN05yiodkxNr5EpEP0DBdQeKlX1Fl9A34VWpsJOOVzRd/XVO76/5TqQm4wZT4Io
        3XrOy8qlzGYww69iWXWoRJ9YU/XC2WO4olsVFvcOC5QFrchIlsDya1Zprd+VBFlBT0/hxjaPFjJ
        EFr+olSXhbxZVQ5H+OhzOa6g8KrebFxDsuQ4gzb5wW11BYaZZoE3fxTWtLZL3CMPT7ZaQUKvMD1
        +6EpNxDDKa3G4nrLQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.818500-5.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26776.006
x-tm-snts-smtp: BB7525F51FD061C1B82152DE4CB7E9505311383CD785C1D6D52B103B250B065A2002:B
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

> Yeah, mostly curious from cgroup design POV. It'd be nice to support
> use cases like this well but we likely don't wanna twist anything
> for it.

Ok. I'll give you some more details. :)

The building block we are discussing here (running a VM where VMM and
virtual core threads are scheduled using different schedulers and thus
effectively on different cores) is a building block in a larger
context. The use cases I have provided so far are still valid and
needed.

What you run in the VM is the OS plus application of some embedded
multicore system where the target hardware is way less competent than
what you are running the VM on. It will most likely even be using a
different CPU architecture so you cross compile to for instance x86.

Now put this building block in a simulator where other parts of the
larger system are connected to this VM. This simulator is used to
train persons who operate the real system and it is important it's
behavior closely mimics the actual real system. For instance response
times from the embedded system may not be too fast nor to too slow.


> Yeah, deligation can be useful. However, given that the
> configuration would need some automation / scripting anyway, it
> shouldn't be too difficult to work around.

Think of it like this. IT department installs the OS of the Host and
sets up cgroup node where a user group controls access to a
subtree. Developers belonging to this group are then allowed to
configure cgroup using abstract names for the nodes in the tree. The
software running on the server uses these abstract names and does not
need to know how they are configured. This means that when the
software is deployed in a different setting where you want another
behavior you just need to reconfigure the cgroup without needing to
recompile the software. And by relying on cgroups you also get less
source code to maintain (and that you might get wrong).


> The thing is, to put different threads of a process into different
> cgroups, one has to know which threads are doing what, which is the
> same knowledge needed to configure per-thread attributes.

Well, you might also have generic rules like for VM named "foo" you
put the VMM thread in "foo-vmm" and virtual core threads in
"foo-vct01" through "foo-vctnn". The actual mapping of these cgroups
to physical cores might differ from server to server. And you might
also select different schedulers and so on depending on server
configuration and the intention with the software installation. For
instance CI-loops that run batches where real-time behavior (matching
elapsed wall clock time in the simulation to actual system) is not
that important and you can fast-forward the simulation as you are
interested in functional tests and so on. This mean that the actual
software does not need to worry about such things.


/John

