Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3774DAC4E
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 09:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiCPIS1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbiCPIS0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 04:18:26 -0400
Received: from weald.air.saab.se (weald.air.saab.se [136.163.212.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A36350D
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 01:17:10 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald.air.saab.se (8.14.7/8.14.7) with ESMTP id 22G8H7g0007954
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Mar 2022 09:17:07 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald.air.saab.se 22G8H7g0007954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald; t=1647418627;
        bh=nS2kp8sjDDEi2HeJUbR6OjAh6tLLzGTSTiLmbumiWbM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=js5nsw9AEIXY6vsi4cYtXY6dvrKF8Aa0qdixEbfhtEHSd3E1EDv7wzFi6lGGfZ4LP
         Aod4UpRRBFrG2qkQ03UUHGYlhNNIx0fHngXoNayK4pJ6eHWSr6FTUya81XCRtl5Dfl
         O4fBP0he8zmwjY/2jUbeB8UhHgDoUyEDN9HzURwg=
Received: from corpappl17779.corp.saab.se (corpappl17779.corp.saab.se [10.12.196.86])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 22G8H5h4199303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:17:05 +0100
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17779.corp.saab.se (10.12.196.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Mar 2022 09:17:04 +0100
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.015; Wed, 16 Mar 2022 09:17:04 +0100
From:   Olsson John <john.olsson@saabgroup.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Topic: [EXTERNAL] Re: Split process across multiple schedulers?
Thread-Index: Adg3spIZ/DvaypfiTgy8SrH+fLuE4AAB7CaAACHeIVAAA5VIgAACLZbgAAxoWIAAINFAwA==
Date:   Wed, 16 Mar 2022 08:17:04 +0000
Message-ID: <77e72fcbbff94977a5179446265c18d2@saabgroup.com>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <20220314164332.GA20424@blackbody.suse.cz>
 <bf2ea0888a9e45d3aafe412f0094cf86@saabgroup.com>
 <20220315103553.GA3780@blackbody.suse.cz>
 <84e5b8652edd47d29597d499f29753d6@saabgroup.com>
 <20220315173329.GB3780@blackbody.suse.cz>
In-Reply-To: <20220315173329.GB3780@blackbody.suse.cz>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.124]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26774.006
x-tm-as-result: No-10--4.305100-5.000000
x-tmase-matchedrid: QW5G6BKkLTrK19rKCr/Ovgrcxrzwsv5uXPK9y3z82GuGD9O3ui1h2Aim
        Mt6TSXWl/YUtGtrcVxCx2JNhrMY3WwpXEPPKcnuoiSe9g7mQdJxN4G4fyNl+7Au/nRcFmzjlXyC
        R2a++D/ZHfjcvalOwvL0+/nv6ad1FzlhhP4M79IhFl9A34VWpsBeK/B+WKxKsHOUhijZNQhvIcj
        2m+H71b5ZgcXdoX+ywalxkhLRQMRYLEx+quc3j9wKDWtq/hHcNUTBIPA569SGBvntZWq2wbZsrA
        E6IjfoaindW/ryBvSRftuJwrFEhTY2j49Ftap9E4kYXbobxJbKYLcIscfQKLI+aVpfnsLvvQiQ8
        Pq0nGtk4hFzpBcXt1YS7H2DKTfpOS/6UMzlQU/ebV6IY++CN5aXilTwF4ZbT/pxh4lGzWZPTnJf
        7vYnDHsbrUtbfFqtBiKJ25zR4BMDP6mFmH0Exp0kDj7phiJLtug58UuBS7ec=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--4.305100-5.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26774.006
x-tm-snts-smtp: 3CF7CA0F635D217A839562298402514CA0320CFB9E24EB334299F8A2D7FE7A852002:B
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

> I think you've complete info now how threads are handled with cgroups.

Thank you for your excellent support! :D


> Good luck with the fork :-)

It's basically already done as part of a Master Thesis. Now we'll
experiment with it and see how theory clashes with the real world. :)


/John

-----Original Message-----
From: Michal Koutn=FD <mkoutny@suse.com>=20
Sent: den 15 mars 2022 18:34
To: Olsson John <john.olsson@saabgroup.com>
Cc: cgroups@vger.kernel.org
Subject: Re: [EXTERNAL] Re: Split process across multiple schedulers?

On Tue, Mar 15, 2022 at 03:49:52PM +0000, Olsson John <john.olsson@saabgrou=
p.com> wrote:
> As you might have already surmised it was a placeholder example to=20
> give the general idea. I think it is time to add some more details. :)

Thanks for sharing the additional description.

> Assume that you have an embedded system running some kind of software=20
> with real time like properties. You want to develop and debug your=20
> software locally on your high-end machine since it is much more=20
> convenient. Alas the software runs way too fast due to the difference=20
> in performance so you can't detect overruns etc.

There are certainly more knowledgeable people than me to help with debuggin=
g such environments.

> One way of implementing this kind of scheduler would be to create a=20
> fork of the FIFO scheduler that have this behavior.

I think you've complete info now how threads are handled with cgroups.

Good luck with the fork :-)


Michal
