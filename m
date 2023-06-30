Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC90744231
	for <lists+cgroups@lfdr.de>; Fri, 30 Jun 2023 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3S0u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jun 2023 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjF3S0t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jun 2023 14:26:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A40125
        for <cgroups@vger.kernel.org>; Fri, 30 Jun 2023 11:26:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2F91F8C2;
        Fri, 30 Jun 2023 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688149606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjudmYc+t4AhUeg8M5MES9aRhblFwTPNdMxP3nSzsE4=;
        b=jHBqhOoevdO4MK0tHEKrzcIFh/sNfQ/P1KGheod6Yvsqv2GYsCqzjwN0rRx9aS/Yol9wU2
        fHkniBSsYGU5FLUKRiUpwOdL1eF0SMh5eb9MSZ4u7sL3NQUwhpWx7QJUP+CVHoHJQjQUIQ
        zxwIDZ5XAnzUu7wL37HeFXtVz5eZUgs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65A85138F8;
        Fri, 30 Jun 2023 18:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pJDYF2Yen2TjaAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 30 Jun 2023 18:26:46 +0000
Date:   Fri, 30 Jun 2023 20:26:45 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Ofir Gal <ofir.gal@volumez.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, cgroups@vger.kernel.org,
        tj@kernel.org
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Message-ID: <vjb27jezj3j45l4gwcgge54st32xfoduvam6lu2irdg7xligea@erxg5rhvklr3>
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vsldarc2hw5fdqjn"
Content-Disposition: inline
In-Reply-To: <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--vsldarc2hw5fdqjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Jun 29, 2023 at 06:21:34PM +0300, Ofir Gal <ofir.gal@volumez.com> w=
rote:
> >>> Currently there is no way to throttle nvme targets with cgroup v2.
> >>
> >> How do you do it with v1?
> With v1 I would add a blkio rule at the cgroup root level. The bio's
> that the nvme target submits aren't associated to a specific cgroup,
> which makes them follow the rules of the cgroup root level.
>=20
> V2 doesn't allow to set rules at the root level by design.

I think you want to add a per-nvme port (device?) throttled-bandwidth
attribute (instead of param_associated_cgroup) to control this on the
client (whole host) side -- even without cgroups.
Associating ports with cgroups and then bios with cgroups looks
superfluous.
(But it is understandably tempting because then IO controller's
throttling implementaion may be reused.)


How are the nvmet_bdev_execute_rw() et al functions called? (Only via
kthreads without (uspace) process context? Or can the reqs be traced to
a user space process?)

Thanks,
Michal

--vsldarc2hw5fdqjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJ8eYwAKCRAGvrMr/1gc
jhfgAP9NUZ0UHO1rcdmDFFxkaXaqqbBN5FcUsYD34VDU684djwD/RL9E71JMN1Fd
E1uJRAC4up2kwbfgkuuCGPhA2jx5nAE=
=+Y3/
-----END PGP SIGNATURE-----

--vsldarc2hw5fdqjn--
