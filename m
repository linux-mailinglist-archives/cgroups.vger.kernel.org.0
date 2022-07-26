Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CAA581550
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiGZOcD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiGZOcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 10:32:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2C32C;
        Tue, 26 Jul 2022 07:31:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58AE537809;
        Tue, 26 Jul 2022 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658845918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bsbGkr+ml3ccu5dQDVYwxJTp4j0IzVNFei719oDR5g=;
        b=STBJKCutDeRpcV4piN3dyy6Q7s+/PZX/QfVLGhYZGPG/3K5mGwgF5D6Qgmr8Lqyp7B9MLp
        XZnivzHP6JzcJkMqM+lNYANR4ZblsmElZxeIlorLvwjEcq0phL02P+zBf0qtagFOo0NDIA
        76C370KAMi/SpSKUDQlogfZj6DS5DQ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 292A713322;
        Tue, 26 Jul 2022 14:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LPQWCd7632IHPwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 26 Jul 2022 14:31:58 +0000
Date:   Tue, 26 Jul 2022 16:31:56 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/3 cgroup/for-5.20] cgroup: Elide write-locking
 threadgroup_rwsem when updating csses on an empty subtree
Message-ID: <20220726143156.GA14370@blackbody.suse.cz>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Jul 14, 2022 at 06:38:15PM -1000, Tejun Heo <tj@kernel.org> wrote:
> However, if the subtree doesn't contain any tasks, there aren't gonna
> be any cgroup migrations.

Nice catch.

> This condition can be trivially detected by testing whether
> mgctx.preloaded_src_csets is empty. Elide write-locking
> threadgroup_rwsem if the subtree is empty.

This check is perhaps even more robust than, e.g. cgroup_is_populated()
due to possible zombie cases.

>  kernel/cgroup/cgroup.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYt/6twAKCRAkDQmsBEOq
ubXRAQD90uqCtIlSRrYwhHsL3H1Goqr3zq/aW3zZtjBIDp5HWQD/c2FILXRb5yDW
GMTSvPlWlLg8Q8IgL0Exn+tuoQwgDwM=
=yafZ
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
