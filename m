Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0B581558
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiGZOdD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiGZOdC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 10:33:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A346129813;
        Tue, 26 Jul 2022 07:33:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2758437EFB;
        Tue, 26 Jul 2022 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658845979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmzxlrD4MfGqasLwf7DeQPvyp1YsjrHWacTayMiVBgs=;
        b=VzaexPvcMynfjlBtImA2nTgG3+dH5jaMLEtGNj2QeksXbstkDRq1u8e7ogp2JZUAqJFhEK
        +TgJXVLp7L7TwUNj+MkJRDnMCThwYCv0CKz6ZWhZFabsQjJMSm9ABubb+3Vf685KftagjK
        IyigtmDwXokwRz35tcgFW3KQ/BGxWfg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F40C413322;
        Tue, 26 Jul 2022 14:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1FjDOhr732J3PwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 26 Jul 2022 14:32:58 +0000
Date:   Tue, 26 Jul 2022 16:32:57 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <20220726143257.GA23882@blackbody.suse.cz>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
 <YtwFjPnCtw8ySnuv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <YtwFjPnCtw8ySnuv@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 23, 2022 at 04:28:28AM -1000, Tejun Heo <tj@kernel.org> wrote:
> This makes the hotter paths - fork and exit - slower as they're always
> forced into the slow path. There is no reason to force this on everyone
> especially given that more common static usage pattern can now completely
> avoid write-locking the rwsem. Write-locking is elided when turning on and
> off controllers on empty sub-trees and CLONE_INTO_CGROUP enables seeding a
> cgroup without grabbing the rwsem.

Just a practical note that CLONE_INTO_CGROUP may not be so widespread
yet [1][2].
But generally, the change makes sense to me.


> +	CGRP_ROOT_FAVOR_DYNMODS =3D (1 << 4),
> +
> +	/*
>  	 * Enable cpuset controller in v1 cgroup to use v2 behavior.
>  	 */
> -	CGRP_ROOT_CPUSET_V2_MODE =3D (1 << 4),
> +	CGRP_ROOT_CPUSET_V2_MODE =3D (1 << 16),
> =20
>  	/*
>  	 * Enable legacy local memory.events.
>  	 */
> -	CGRP_ROOT_MEMORY_LOCAL_EVENTS =3D (1 << 5),
> +	CGRP_ROOT_MEMORY_LOCAL_EVENTS =3D (1 << 17),
> =20
>  	/*
>  	 * Enable recursive subtree protection
>  	 */
> -	CGRP_ROOT_MEMORY_RECURSIVE_PROT =3D (1 << 6),
> +	CGRP_ROOT_MEMORY_RECURSIVE_PROT =3D (1 << 18),

Why this new gap in flag bits?

[1] https://github.com/systemd/systemd/pull/16706
[2] https://github.com/search?q=3Dorg%3Aopencontainers+CLONE_INTO_CGROUP&ty=
pe=3Dall (empty)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYt/7FwAKCRAkDQmsBEOq
uUu7AQCTUIpH8K9WfOjrd4atmJg3ivYL9Dq6gqtpvNZrS7XStgD+Prz9fzwjGXvO
Fw86GZpQI02CRHvZdUw+lRMJ8r7qhAQ=
=bB6g
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
