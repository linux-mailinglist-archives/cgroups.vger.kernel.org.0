Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8867B8ACD
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjJDSkb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjJDSkb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 14:40:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B4AD;
        Wed,  4 Oct 2023 11:40:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A9CF1F38A;
        Wed,  4 Oct 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696444824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0b/Hy2qC+xrQUHKjE53J01KhR5PkM+fGaJhgF9dLKI=;
        b=CIRmL5rVXuVKNvEluhdeQYsdcFo47d2lJNpcXC6/E3RclyMV17oj8SKUu67znTPY2Jg4hM
        gnbTLdYsV0Q+JQf2Vm3ZisZAPHEz3W3NQDhHUhCT9wC4rdZ48Z1fjFaeKKDyNY70BLBfyG
        bf4WxgXBjQz7ypXE+DqP6U6KjobEt/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01653139F9;
        Wed,  4 Oct 2023 18:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9r4QO5exHWUBeQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 Oct 2023 18:40:23 +0000
Date:   Wed, 4 Oct 2023 20:40:22 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, kamalesh.babulal@oracle.com
Subject: Re: [RESEND v3] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <toy5zlfprf4t5mxk7lje6kv4zrlpm6oxzcpepmmubtzvodgnc4@mrqp657zsrgy>
References: <20230927142539.GB65411@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2dtbseo44kaj25fv"
Content-Disposition: inline
In-Reply-To: <20230927142539.GB65411@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--2dtbseo44kaj25fv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 02:25:40PM +0000, Luiz Capitulino <luizcap@amazon.c=
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

(resend too)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--2dtbseo44kaj25fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR2xlQAKCRAGvrMr/1gc
jhncAQCAY8bsHAYze4HbU9YSFMlgVGJPXFhgE5Kv4z4RBr/sOAEAt4pmDKQQM4Hk
od2v6vOBMtMATE/rcm5dpRtRxTLXQAY=
=E5vU
-----END PGP SIGNATURE-----

--2dtbseo44kaj25fv--
