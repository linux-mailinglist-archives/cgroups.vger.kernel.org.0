Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12996D76F0
	for <lists+cgroups@lfdr.de>; Wed,  5 Apr 2023 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjDEIaz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Apr 2023 04:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjDEIay (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Apr 2023 04:30:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE81FF6;
        Wed,  5 Apr 2023 01:30:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A524E22A1C;
        Wed,  5 Apr 2023 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680683449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qYT3efqmHupYQzBMEWpHyiW3zRVpGSvNxrK3q6d/Z5Y=;
        b=BiTyZQ4po4bomPYKWo6d6qsQRVFEIhovjNpaQ1YKONLThAsO7Ylz7XJ90Fo6co43jdLMkp
        +EWnfAaHoLX4M2fGMYspnxpyRRtwf08nJryPJ2V3n2x4WDuiV+ZcV8Odwhn0ttX52OoPLW
        tykNg3ZsU50ztNG7wI7cIKyqQlTVuAk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76AED13A10;
        Wed,  5 Apr 2023 08:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sPYVHLkxLWSFQwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Apr 2023 08:30:49 +0000
Date:   Wed, 5 Apr 2023 10:30:48 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH v2 1/4] cgroup/cpuset: Wake up cpuset_attach_wq tasks in
 cpuset_cancel_attach()
Message-ID: <20230405083048.rjmmcgi5pf2fghl5@blackpad>
References: <20230404170546.2585050-1-longman@redhat.com>
 <20230404170546.2585050-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dotmodrsnhmcfw25"
Content-Disposition: inline
In-Reply-To: <20230404170546.2585050-2-longman@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--dotmodrsnhmcfw25
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 01:05:43PM -0400, Waiman Long <longman@redhat.com> =
wrote:
>  kernel/cgroup/cpuset.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--dotmodrsnhmcfw25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZC0xswAKCRAkDQmsBEOq
ucxiAP9ShvWz5fRrmtWn2/9Q3HBI+48SYFw86Qmn/mUFBG5qSAD/Rs+iroyu1MsW
+1iL+QZz6CNF+O4heMZjFBjMmY+ieAY=
=phxN
-----END PGP SIGNATURE-----

--dotmodrsnhmcfw25--
