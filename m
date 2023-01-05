Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D365F0F6
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjAEQTH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 11:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAEQTG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 11:19:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B514E42F;
        Thu,  5 Jan 2023 08:19:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59D3F17846;
        Thu,  5 Jan 2023 16:18:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 271F213338;
        Thu,  5 Jan 2023 16:18:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bxuMCHD4tmM3QwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 Jan 2023 16:18:56 +0000
Date:   Thu, 5 Jan 2023 17:18:54 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com, jack@suse.cz
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <20230105161854.GA1259@blackbody.suse.cz>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20221226130505.7186-1-hanjinke.666@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.20
X-Spamd-Result: default: False [-2.20 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         RCPT_COUNT_SEVEN(0.00)[9];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jinke.

On Mon, Dec 26, 2022 at 09:05:05PM +0800, Jinke Han <hanjinke.666@bytedance.com> wrote:
> In our test, fio writes a 100g file in sequential 4k blocksize in
> a container with low bps limit configured (wbps=10M).
> [...]
> At the same time, the operation of saving a small file by vim will be
> blocked amolst 140s.

Could you please elaborate why is this specific to blk-throtl?

I guess similar problem would arise for devices that are "naturally"
slow.
Then:
a) it must have been solved elsewhere in the block layer (but it's
   broken),
b) it should be solved generically in the block layer (thus this is only
   a partial solution).

Alternatively, I imagine your problem could be reduced with
corresponding memory limits on IO-constrained cgroups. (The memory limit
would increase cgwb's dirty throttling and consequently leaves more
IO bandwidth for sync IOs.)

Could you describe how the submitted solution compares to memory
limiting?

> This patch splits bio queue into sync and async queues for blk-throtl
> and gives a huge priority to sync write ios.

The "huge priority" corresponds to the THROTL_SYNC_FACTOR, right?
I'm slightly concerned about the introduction of the magical value.
What is the reasoning behind this? (E.g. I'd expect 1:1 could work as
well, while 1:4 suggests this is somehow better (empirically?).)

Thanks,
Michal


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY7b4bAAKCRAkDQmsBEOq
uQrgAQDs2aA08ChLFwdUU9xtUvTksAkbg4kIOJ6eonBHzYLMmQD9Eku/xsu7q+JO
bkt+bgPn6r1by/lxIByZFdvliq70/g0=
=VUBu
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
