Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC964B135
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 09:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiLMIbj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 13 Dec 2022 03:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiLMIbJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 03:31:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53DF10
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 00:30:12 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-7JytmWPuMGiigtX7_hd_5g-1; Tue, 13 Dec 2022 08:30:09 +0000
X-MC-Unique: 7JytmWPuMGiigtX7_hd_5g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 08:30:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 13 Dec 2022 08:30:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tejun Heo' <tj@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Thread-Topic: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Thread-Index: AQHY7hGH734dfSyX20WOi86L/FtKtq4rTpIAgD+71dKAALHkcA==
Date:   Tue, 13 Dec 2022 08:30:08 +0000
Message-ID: <f5220f08bd7f45248d718f1919503261@AcuMS.aculab.com>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org> <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
 <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
 <Y2Kaghnu/sPvl0+g@slm.duckdns.org> <Y2KePvYRRMOrqzOe@slm.duckdns.org>
 <320c939e-a3f0-1b1e-77e4-f3ecca00465d@kernel.org>
 <Y5ehU524daymEKgf@slm.duckdns.org>
In-Reply-To: <Y5ehU524daymEKgf@slm.duckdns.org>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tejun Heo <htejun@gmail.com> On Behalf Of 'Tejun Heo'
> Sent: 12 December 2022 21:47
> To: Jiri Slaby <jirislaby@kernel.org>
> Cc: David Laight <David.Laight@ACULAB.COM>; Christoph Hellwig <hch@infradead.org>; linux-
> kernel@vger.kernel.org; Martin Liska <mliska@suse.cz>; Josef Bacik <josef@toxicpanda.com>; Jens Axboe
> <axboe@kernel.dk>; cgroups@vger.kernel.org; linux-block@vger.kernel.org
> Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in prints
> 
> On Mon, Dec 12, 2022 at 01:14:31PM +0100, Jiri Slaby wrote:
> > > If so, my suggestion is just sticking with the old behavior until we switch
> > > to --std=g2x and then make one time adjustment at that point.
> >
> > So is the enum split OK under these circumstances?
> 
> Oh man, it's kinda crazy that the compiler is changing in a way that the
> same piece of code can't be compiled the same way across two adjoining
> versions of the same compiler. But, yeah, if that's what gcc is gonna do and
> splitting enums is the only way to be okay across the compiler versions,
> there isn't any other choice we can make.

It is also a silent code-breaker.
Compile this for 32bit x86:

enum { a = 1, b = ~0ull};
extern int foo(int, ...);
int f(void)
{
    return foo(0, a, 2);
}

gcc13 pushes an extra zero onto the stack between the 1 and 2.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

