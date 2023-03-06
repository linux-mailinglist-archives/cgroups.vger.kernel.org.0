Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E16AC94D
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCFRIC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCFRHf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 12:07:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FDA5D76A;
        Mon,  6 Mar 2023 09:07:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A89D22114;
        Mon,  6 Mar 2023 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678122395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqhwY2lPFDKqTCuisG7qrwOwTn3FoFZkWgoREgP29v8=;
        b=hm2foqGrZ06Y6i1j0SnSjC4wlKPfurlYM008VAotDgueUi0QN4jlgObNfSS23IJKqFjKqG
        +a/FEvqy82lLP3iSMTqS9Punj69DQjt3JeOuGZCQTY7XqfzcjVuSvEplB1PwdhbR5evufB
        F3HHYNujVu4YQkYJexnd6mVfsAPF2KA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EBE113A66;
        Mon,  6 Mar 2023 17:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iSMxGpsdBmTSZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Mar 2023 17:06:35 +0000
Date:   Mon, 6 Mar 2023 18:06:34 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Subject: Re: [RESEND PATCH v6] blk-throtl: Introduce sync and async queues
 for blk-throtl
Message-ID: <20230306170634.os744umla72yoryw@blackpad>
References: <20230228085935.71465-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhuwt4jvay5ya4x6"
Content-Disposition: inline
In-Reply-To: <20230228085935.71465-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--jhuwt4jvay5ya4x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jinke.

On Tue, Feb 28, 2023 at 04:59:35PM +0800, Jinke Han <hanjinke.666@bytedance.com> wrote:
> and gives a huge priority to sync write ios. Sync queue only make sense
> for write ios as we treat all read io as sync io.
[...]
> +/* For write ios, dispatch 4 sync ios and 1 normal io in one loop */
> +#define THROTL_SYNC_FACTOR 4

This looks like an unexplained number wired in.
E.g. I'd expect that 1st iteration would have this factor==1, i.e. RR
between sync and async queue.

What is the reason for this value? E.g. I assume it'd depend on number
of synchronous writers and flusher threads and their activity, i.e.
could you describe why this value caters the best for wide range of
various sync and async situations? Or add a comment what is the
particular value based on (so that it can be reassessed should those
dependencies change in the future).

Thanks,
Michal

--jhuwt4jvay5ya4x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZAYdmAAKCRAkDQmsBEOq
ub2YAQDaCWaGj/Xvs8G4Pm/2qCiJtHgjoH42bz+/IlGbTg3DywD/U7l4W1eG5LvM
oPCsWs+kfse5/fw4pnz49VDjkNLexgk=
=D9q5
-----END PGP SIGNATURE-----

--jhuwt4jvay5ya4x6--
