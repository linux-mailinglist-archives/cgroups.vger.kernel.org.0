Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53A6654202
	for <lists+cgroups@lfdr.de>; Thu, 22 Dec 2022 14:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLVNjT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Dec 2022 08:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLVNjR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Dec 2022 08:39:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED01262C;
        Thu, 22 Dec 2022 05:39:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18B04761F4;
        Thu, 22 Dec 2022 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671716354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vtrUvg4YowUHHaB/oWDczwXqJMHTjVYGpm9kUzl8kTI=;
        b=BX65IxCWiuGYFzvTkZ+nr3VtDH+usLyg+BU9HM+jdMWyoRpJ+3k3OCpwuGNDqcMNpirHtA
        DLSXITsn3LTiR/TPLke2cOGEITISuFRggz4oAfhTnUt14xTl305toFm7z1ogtSDIOxn92w
        CihiLx8o6X0kl8zur6D6H4APW/OxlSs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0DFD138FD;
        Thu, 22 Dec 2022 13:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5/7nNQFepGNtNQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 22 Dec 2022 13:39:13 +0000
Date:   Thu, 22 Dec 2022 14:39:12 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Subject: Re: [PATCH v2] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <20221222133912.GA20830@blackbody.suse.cz>
References: <20221218111314.55525-1-hanjinke.666@bytedance.com>
 <20221221104246.37714-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20221221104246.37714-1-hanjinke.666@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jinke.

On Wed, Dec 21, 2022 at 06:42:46PM +0800, Jinke Han <hanjinke.666@bytedance=
=2Ecom> wrote:
> In our test, fio writes a 100g file in sequential 4k blocksize in
> a container with low bps limit configured (wbps=3D10M). More than 1200
> ios were throttled in blk-throtl queue and the avarage throtle time
> of each io is 140s. At the same time, the operation of saving a small
> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
> the sync ios of fsync will be blocked by a huge amount of buffer write
> ios ahead. This is also a priority inversion problem within one cgroup.
> In the database scene, things got really bad with blk-throtle enabled
> as fsync is called very often.

I'm trying to make sense of the numbers:
- at 10 MB/s, it's 0.4 ms per 4k block
- there are 1.2k throttled bios that gives waiting time of roughly 0.5s
  ~ 0.4ms * 1200
- you say that you observe 280 times longer throttling time,
- that'd mean there should be 340k queued bios=20
  - or cummulative dispatch of ~1400 MB of data

So what are the queued quantities? Are there more than 1200 bios or are
they bigger than the 4k you mention?

Thanks for clarification.

(I acknowledge the possible problem with a large population of async
writes delaying scarce sync writes.)

Michal

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY6Rd9AAKCRAkDQmsBEOq
ua1JAQDsiMRSLjxEJBtDI7L1TSV+aXGoBObxymsZ8wdIom3evQD/RFAuRv6/4e6V
GjV/UcnvMk5iZ5R2P+SQNC3uHiNJTQU=
=95C9
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
