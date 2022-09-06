Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE45AF43C
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiIFTLS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 15:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIFTLP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 15:11:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B07A3D44
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 12:11:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87CA6336A9;
        Tue,  6 Sep 2022 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662491473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghVpqZbCJEhGOm8vLPxrUgwg0tE4oNBHkbMpPGSkKp8=;
        b=ZgVGHVOWUvLJp6O/urOg6d9Ib+KoIAVvUO6gWNPASSId7g7IdYUAz6JDkdmrdnxzzLXjAn
        u6i5fRzCbsduiSupoCb6NuhSSyE0mYQsqgHjkM+s0hXXcxQma7RjBIjqHA3yrs0DCZOzEJ
        OWsp5Lw5kMCLfXZizGz/+PYmO8dBw+o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66B9913A7A;
        Tue,  6 Sep 2022 19:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6fQhGFGbF2OIegAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 06 Sep 2022 19:11:13 +0000
Date:   Tue, 6 Sep 2022 21:11:12 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2 cgroup/for-6.1] cgroup: Improve cftype add/rm error
 handling
Message-ID: <20220906191112.GF30763@blackbody.suse.cz>
References: <YxUUISLVLEIRBwEY@slm.duckdns.org>
 <20220905131435.GA1765@blackbody.suse.cz>
 <YxeCdHfk2nOUISDw@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <YxeCdHfk2nOUISDw@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2022 at 07:25:08AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I prefer having it as a separate flag because it's explicit and can be
> tested together with other flags. It's a weak preference tho and I can go
> either way if it bothers you much.

No trouble, please proceed with the new flag.

BTW, while I was just looking over the patch I noticed that in

@@ -1717,14 +1722,22 @@ static int css_populate_dir(struct cgrou
                return 0;

        if (!css->ss) {
-               if (cgroup_on_dfl(cgrp))
-                       cfts = cgroup_base_files;
-               else
-                       cfts = cgroup1_base_files;
-
-               ret = cgroup_addrm_files(&cgrp->self, cgrp, cfts, true);
-               if (ret < 0)
-                       return ret;
+               if (cgroup_on_dfl(cgrp)) {
+                       ret = cgroup_addrm_files(&cgrp->self, cgrp,
+                                                cgroup_base_files, true);
+                       if (ret < 0)
+                               return ret;
+
+                       if (cgroup_psi_enabled()) {
+                               ret = cgroup_addrm_files(&cgrp->self, cgrp,
+                                                        cgroup_psi_files, true);
+                               if (ret < 0)
+                                       return ret;

Before the return here, the function should revert the base files first (or
silence the return value to 0 if such a partial population is acceptable).

(Actually, it looks like the revert in the subsys branch is unnecessary as
callers of css_populate_dir() would issue css_clear_dir() upon failure
eventually.)


Thanks,
Michal

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYxebSgAKCRAkDQmsBEOq
uX0hAP9JqfWxYBZ3k0lSDZiVadqGLr3H8eImMSC797nuN/vfPQEAt/Phe/hqdaM2
vOwjpoJwAVfE+EDmv3Hfb6RMYlZZNgY=
=sKtv
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
