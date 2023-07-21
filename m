Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B875C0C4
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGUIGG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 21 Jul 2023 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGUIGG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 04:06:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634B2710
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 01:06:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-XvO-OBw_MAGyU5uoyZk6iw-1; Fri, 21 Jul 2023 09:06:01 +0100
X-MC-Unique: XvO-OBw_MAGyU5uoyZk6iw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 09:06:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 09:05:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tejun Heo' <tj@kernel.org>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd <amd@localhost.localdomain>
Subject: RE: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Thread-Topic: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Thread-Index: AQHZuN9gMxBfo8Y4UkeL32HKckyYqK/Ay+LQgAI9EACAANgLUA==
Date:   Fri, 21 Jul 2023 08:05:59 +0000
Message-ID: <fd89f72848da4569a19ec8a1ac9ec94e@AcuMS.aculab.com>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
 <2b4540aadc3c4449a192aeed6211f232@AcuMS.aculab.com>
 <ZLmT3mXuDlYY61w0@slm.duckdns.org>
In-Reply-To: <ZLmT3mXuDlYY61w0@slm.duckdns.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tejun Heo
> Sent: 20 July 2023 21:07
> 
> On Wed, Jul 19, 2023 at 08:57:32AM +0000, David Laight wrote:
> > From: Tejun Heo
> > > Sent: 17 July 2023 19:49
> > >
> > > On Mon, Jul 17, 2023 at 09:18:52AM -0500, Carlos Bilbao wrote:
> > > > From: amd <amd@localhost.localdomain>
> > > >
> > > > Fix two type mismatch errors encountered while compiling blk-iocost.c with
> > > > GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> > > > result of the division operation to (unsigned int) to match the expected
> > > > format specifier %u in two seq_printf invocations.
> > >
> > > Can you detail the warnings? Was that on 32bit compiles?
> >
> > The problem is caused by gcc 13 changing the types of the
> > constants inside an enum to be all the same.
> >
> > The best fix is (probably) to replace all the enum used to
> > define unrelated constants with #defines.
> 
> Yeah, but then you end up without any way to read that value from outside
> the kernel for BPF, drgn or any other tools which use debug info. That
> actually matters.

Some of those constants (probably including the one that forces
the enum to 'long' are very boring.
I don't remember which one caused the change, but some were
similar to 'microseconds in a second'.

In any case it is enough to split the enum.
If you really need unrelated constants to be defined in an enum
them maybe use a separate enum for each.
Using (on one line):
	enum { name = constant };
may work best.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

