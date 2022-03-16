Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE84DB6B2
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348702AbiCPQvE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbiCPQvD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 12:51:03 -0400
Received: from weald.air.saab.se (weald.air.saab.se [136.163.212.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23387443C9
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 09:49:47 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald.air.saab.se (8.14.7/8.14.7) with ESMTP id 22GGnVUb005751
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Mar 2022 17:49:31 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald.air.saab.se 22GGnVUb005751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald; t=1647449371;
        bh=5QHUREPdKS0RYEDaBp+97Eck0DLnpYJfMdi/oyeVGbU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=utkEsq3p/XJygC/rsIc9PMZ3MEF4Lo/f2mQLLC1YfAZcb4cNrdJ++SzeOFTU0W7+W
         l/7+RWoywfQLpyY89k46SDKHv/eDM27NPI/WkIptQ8dtqXdHlDWCCVpgf9B70ZF9rP
         xiLWtoSRbNZBRsbU3hCS5LqTsnytGaC1yYkvDNSQ=
Received: from corpappl17772.corp.saab.se (corpappl17772.corp.saab.se [10.12.196.79])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 22GGnRPw479708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 17:49:27 +0100
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17772.corp.saab.se (10.12.196.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Mar 2022 17:49:29 +0100
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.015; Wed, 16 Mar 2022 17:49:29 +0100
From:   Olsson John <john.olsson@saabgroup.com>
To:     Tejun Heo <tj@kernel.org>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Topic: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Index: Adg3spIZ/DvaypfiTgy8SrH+fLuE4ABmU+gAAAIfiuA=
Date:   Wed, 16 Mar 2022 16:49:29 +0000
Message-ID: <e9cac4aba6384c5c91125a9f7d61a4e8@saabgroup.com>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <YjIShE3mwRyNbO53@slm.duckdns.org>
In-Reply-To: <YjIShE3mwRyNbO53@slm.duckdns.org>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.124]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26776.000
x-tm-as-result: No-10--7.191500-5.000000
x-tmase-matchedrid: csPTYAMX1+HK19rKCr/Ovgrcxrzwsv5uXPK9y3z82GttfzoljzPXOwQ9
        5qKM84XK8GCkoSXZagnidWxlRVBYwc4Cn0fUiJuC3nHtGkYl/Vrao9CLy9z1sujt1glqt+yGGNt
        H9cKwddYCb8D7TYsad7MTUjboGcLokAoSYAlFT8/k9NqTmudp1Go8zUxTJUAjgb57WVqtsG2zxb
        tU2iY0wyo4RxY8NtHpX7bicKxRIU2No+PRbWqfROJGF26G8SWy8lP6F/raTZitbVuluC2/ALMgY
        g56KHJrELnI9QuVpuVgwj4RBUjnvFQ9dfenIsFZw2tMTSg0x74=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.191500-5.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26776.000
x-tm-snts-smtp: A30F34C42C9B7E4FEF0198A2A593FEC2B1A75B02BBCF7B3D14A509D1CC35D7B82002:B
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

> I have a basic question. cgroup provides new capabilities through
> its ability to hierarchically organize workloads on the system and
> distributes resources across the hierarchy. If all one wants to do
> is affining specific threads to specific CPUs or changing some other
> attributes of them, there's nothing extra that cgroup provides
> compared to using plain per-task interface. Is there some other
> eason why cgroup is the preferred way here?

Very good question! And yes, there actually are some reasons. :)

By using cgroup you can delegate the authority to configure a subset
of the hierarchy via rwx and user, group, others. By using the
per-task interface you have to be root, right?

Also, we want to separate the configuration of the threads from the
application as it need to be deployed in different hardware scenarios.

And we need to be able to easily replicate a configuration from one
machine to another machine.

We also need to configure other aspects that cgroup allows us to do
for the set of processes.

Since cgroup solves all of the above problems for us, why using
something else? :)

