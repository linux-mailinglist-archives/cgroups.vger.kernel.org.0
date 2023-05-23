Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6A70E028
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjEWPQW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbjEWPPx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 11:15:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABEE7A;
        Tue, 23 May 2023 08:15:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 375842209D;
        Tue, 23 May 2023 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684854870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkLyPkT+GsXSuBlfsNmALpub2P5cbuZv3uR/8NK1ky0=;
        b=fcrH5ERbBAosvtM3sKUk3hFQzKgQeSkCA4K9SRdafLYsKszWYKAZid+OERHyO74Tz7T82s
        JSUdRkqoJzEk0MGj7qlVteas8OpU4uxXh/zsuaM/Kkkw8G8E2URO+5W8hru2wqxtrggH3Z
        2EF4m4urlnB9MG4mUGJYmbxLqQzgC6Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 180A213A10;
        Tue, 23 May 2023 15:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IfL6BFbYbGSSewAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 23 May 2023 15:14:30 +0000
Date:   Tue, 23 May 2023 17:14:28 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: rstat: Simplified cgroup_base_stat_flush()
 update last_bstat logic
Message-ID: <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
 <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wg2kypm56q6zgssf"
Content-Disposition: inline
In-Reply-To: <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--wg2kypm56q6zgssf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jia.

On Fri, May 19, 2023 at 12:15:57PM +0800, Hao Jia <jiahao.os@bytedance.com>=
 wrote:
> Maybe something like this?

(Next time please send with a version bump in subject.)


> In cgroup_base_stat_flush() function, {rstatc, cgrp}->last_bstat
> needs to be updated to the current {rstatc, cgrp}->bstat after the
> calculation.
>=20
> For the rstatc->last_bstat case, rstatc->bstat may be updated on other
> cpus during our calculation, resulting in inconsistent rstatc->bstat
> statistics for the two reads. So we use the temporary variable @cur to
> record the read statc->bstat statistics, and use @cur to update
> rstatc->last_bstat.

If a concurrent update happens after sample of bstat was taken for
calculation, it won't be reflected in the flushed result.
But subsequent flush will use the updated bstat and the difference from
last_bstat would account for that concurrent change (and any other
changes between the flushes).

IOW flushing cannot prevent concurrent updates but it will give
eventually consistent (repeated without more updates) results.

> It is better for us to assign directly instead of using
> cgroup_base_stat_add() to update {rstatc, cgrp}->last_bstat.

Or do you mean the copying is faster then arithmetics?

Thanks,
Michal

--wg2kypm56q6zgssf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZGzYUgAKCRAkDQmsBEOq
uW/EAPwMre77h1BOYEzmFLgU5ag4wBzdTwS70cy56P6QTg7dgAEAwdZrK+0lAsgP
xGFhjmxnFKU0VP6MC3rCl/yhKOddwQ8=
=25fp
-----END PGP SIGNATURE-----

--wg2kypm56q6zgssf--
