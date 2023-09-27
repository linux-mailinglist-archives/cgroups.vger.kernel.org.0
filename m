Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A227B0002
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 11:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjI0J1p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjI0J1n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 05:27:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F72FC;
        Wed, 27 Sep 2023 02:27:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF0A91F8D5;
        Wed, 27 Sep 2023 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695806860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bG0Pnzalm348LFro+ihVWQatuPRDGf85MA2c4irdNsI=;
        b=OtmhifT4gJuFMQRN8jjvl3M7OE01MBb0hmeyqMbNXyWDdszTxiaIgRpU8IqnB2RfpNbmXv
        Qmf0rUghVdxc7YIzOBsgXiwXXTf/Bp78e13U2td3W2H8KgP0M5qHDZriRr7XMYjQfaJbjF
        9TFsQ2CcH3V9C2NcjlGJ3R3gS2VEr/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 893FB1338F;
        Wed, 27 Sep 2023 09:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7/vAIIz1E2V/DgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 27 Sep 2023 09:27:40 +0000
Date:   Wed, 27 Sep 2023 11:27:39 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, kamalesh.babulal@oracle.com,
        lcapitulino@gmail.com
Subject: Re: [PATH v3] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <hegunkr2yuuhxvqevza5qthqnhv66dmru2c2elfk3rl7rwycl5@levqk6gto7e5>
References: <20230926211617.42746-1-luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvxntxtnmhzpfusm"
Content-Disposition: inline
In-Reply-To: <20230926211617.42746-1-luizcap@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--mvxntxtnmhzpfusm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 09:16:17PM +0000, Luiz Capitulino <luizcap@amazon.c=
om> wrote:
> We have a need of using favordynmods with cgroup v1, which doesn't support
> changing mount flags during remount. Enabling CONFIG_CGROUP_FAVOR_DYNMODS=
 at
> build-time is not an option because we want to be able to selectively
> enable it for certain systems.
>=20
> This commit addresses this by introducing the cgroup_favordynmods=3D
> command-line option. This option works for both cgroup v1 and v2 and also
> allows for disabling favorynmods when the kernel built with
> CONFIG_CGROUP_FAVOR_DYNMODS=3Dy.
>=20
> Also, note that when cgroup_favordynmods=3Dtrue favordynmods is never
> disabled in cgroup_destroy_root().
>=20
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
> ---
>  .../admin-guide/kernel-parameters.txt          |  4 ++++
>  kernel/cgroup/cgroup.c                         | 18 ++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)

Thanks,

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--mvxntxtnmhzpfusm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZRP1iQAKCRAGvrMr/1gc
jsr1AP4tFlDP1JxCkCQQQanb8dPX0P90i82rcOq6fKAF7PKMHQEAp3/0+E0VebU3
IxXBMCjqJvEx7hEhL5bygjmy8HOdsAM=
=e3lV
-----END PGP SIGNATURE-----

--mvxntxtnmhzpfusm--
