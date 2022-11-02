Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7A615DD1
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKBIfq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 2 Nov 2022 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiKBIfn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 04:35:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B051A04C
        for <cgroups@vger.kernel.org>; Wed,  2 Nov 2022 01:35:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-guNOfW50N0qHgkOwqcty6g-1; Wed, 02 Nov 2022 08:35:37 +0000
X-MC-Unique: guNOfW50N0qHgkOwqcty6g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Nov
 2022 08:35:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Wed, 2 Nov 2022 08:35:35 +0000
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
Thread-Index: AQHY7hGH734dfSyX20WOi86L/FtKtq4rTpIA
Date:   Wed, 2 Nov 2022 08:35:34 +0000
Message-ID: <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org> <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
In-Reply-To: <Y2FNa4bGhJoevRKT@slm.duckdns.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tejun Heo
> Sent: 01 November 2022 16:47
> 
> Hello,
> 
> On Tue, Nov 01, 2022 at 06:46:56AM +0100, Jiri Slaby wrote:
> > Yes. The real problem is that using anything else then an INT_MIN <= x <=
> > INT_MAX _constant_ in an enum is undefined in ANSI C < 2x (in particular, 1
> > << x is undefined too). gcc manual defines unsigned int on the top of that
> > as defined too (so this holds for our -std=g*).
> >
> > > I suppose the most reasonable thing to do here is just splitting them into
> > > separate enum definitions. Does anyone know how this behavior change came to
> > > be?
> >
> > C2x which introduces un/signed long enums. See the bug I linked in the
> > commit log:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113
> 
> I see. So, it was an extension but the new standard is defined differently
> and we're gonna end up with that behavior.
> 
> > The change is also turned on in < C2x on purpose. AIUI, unless there is too
> > much breakage. So we'd need to sort it out in (rather distant) future anyway
> > (when we come up to -std=g2x).
> 
> The part that the new behavior applying to <C2x feels like an odd decision.
> I'm having a hard time seeing the upsides in doing so but maybe that's just
> me not knowing the area well enough.
> 
> > > Do we know whether clang is gonna be changed the same way?
> >
> > In C2x, Likely. In < C2x, dunno what'd be the default.
> 
> It looks like we can do one of the following two:
> 
> * If gcc actually changes the behavior for <c2x, split the enums according
>   to their sizes. This feels rather silly but I can't think of a better way
>   to cater to divergent compiler behaviors.
> 
> * If gcc doesn't change the behavior for <c2x, there's nothing to do for the
>   time being. Later when we switch to -std=g2x, we can just change the
>   format strings to use the now larger types.
> 
> Does the above make sense?

I think the enums have to be split.
There will be other side effects of promoting the constants to 64bit
that are much more difficult to detect than the warnings from printf.

I'm also not sure whether the type is even consistent for 32bit
and 64bit builds.
Casts are (sort of) horrid.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

