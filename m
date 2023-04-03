Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D216D4DFF
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjDCQfY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjDCQfX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 12:35:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F4A8;
        Mon,  3 Apr 2023 09:35:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAF9C21E5B;
        Mon,  3 Apr 2023 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680539720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YumwonmjqV5t8gQykDIe5ctbpkmmD9ZrmoXWSUWe1do=;
        b=N0VbH0/+8edCmRFNoLs7Nov6WXcDZGyB9J97iFTrRiHXqz+LakqSg32CAN27DF4AynJUnB
        vLQQRta/XZsWkTZ+dE/8+egPOtY3Z/0K0XvulUL8oleP+EuBeYYM1i9+6MDWZ8o9BwA0x2
        lWs9+7ZOlxpKoXxG2HxY84tAqA1l2SM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BC2113416;
        Mon,  3 Apr 2023 16:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xlEyIUgAK2TCYgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Apr 2023 16:35:20 +0000
Date:   Mon, 3 Apr 2023 18:35:19 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 2/3] cgroup/cpuset: Make cpuset_attach_task() skip
 subpartitions CPUs for top_cpuset
Message-ID: <20230403163519.6xyb66firoqm5eti@blackpad>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dt4gx7d3cwpgnbwk"
Content-Disposition: inline
In-Reply-To: <20230331145045.2251683-3-longman@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--dt4gx7d3cwpgnbwk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, Mar 31, 2023 at 10:50:44AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> It is found that attaching a task to the top_cpuset does not currently
> ignore CPUs allocated to subpartitions in cpuset_attach_task(). So the
> code is changed to fix that.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--dt4gx7d3cwpgnbwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCsAPwAKCRAkDQmsBEOq
ue7hAQCSejv7qXqOG2OYhV4G4WEbQ0/ok1yV2453mEPMO20QoQEArOj5iQ9yrLXt
pXQCdi4gTkstrXHCQ5IzHq1FFQO2jgU=
=Rr4W
-----END PGP SIGNATURE-----

--dt4gx7d3cwpgnbwk--
