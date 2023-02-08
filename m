Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715FE68F42A
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 18:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBHRRt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 12:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBHRRs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 12:17:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948416305;
        Wed,  8 Feb 2023 09:17:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC0F11FED5;
        Wed,  8 Feb 2023 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675876643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKiKDcbX0O3C0B5XD/0OrKN1mlV/CCJFvoMfJCxlhbI=;
        b=lWaEd33QaHTanA50H4oKn1xkRJTVCdWnoCf0A/vduJWWyNtpD241CG6E07XTVjUv11eFWo
        ki6GQxVQvonR5jhFfwsVJOZPhfsoUD3UIJzgBWxkcHG7QveRZuXVr069rAKLn30yHjbJJw
        51UnzDqzVuraHYyBoEhLfLdBUdNMFpc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BC4B13425;
        Wed,  8 Feb 2023 17:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1ZkUJSPZ42OFbQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Feb 2023 17:17:23 +0000
Date:   Wed, 8 Feb 2023 18:17:22 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/psi: simplify cgroup psi retrieving
Message-ID: <20230208171722.GE24523@blackbody.suse.cz>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-2-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20230208161654.99556-2-ryncsn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2023 at 12:16:53AM +0800, Kairui Song <ryncsn@gmail.com> wr=
ote:
>  include/linux/psi.h    | 2 +-
>  kernel/cgroup/cgroup.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+PZIAAKCRAkDQmsBEOq
uXmaAP9GahvmyU1IMscq/W8nIcRpdXXf5uzJ2rdXIi3O0wGeogEApX/xE7jsIBDr
aJiP9He48sQ6TTXy0X0NtNU45JjqvQg=
=h2+9
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
