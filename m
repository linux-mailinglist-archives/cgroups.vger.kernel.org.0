Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2830698344
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 19:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBOSZz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 13:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOSZy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 13:25:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75621F76F;
        Wed, 15 Feb 2023 10:25:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F063D1F898;
        Wed, 15 Feb 2023 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676485549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P42oJWVw8QVuwSC+c50ruu3wOmb36a3Nrnfl7WXxgLs=;
        b=nIw20IgL2GT8wQHlWmqHCqEmwhG/Pq1EZmuhoFV1Eq83obXVTTxm6QMGgetdPgY5pyg+Mg
        sRhZf3gkQmfDS7Qk2HLmV4mMHvHMER3OnoK44UCuxI0d3Du7zug6DQDsigpDegbn3bs/Ow
        ZFOSDYvp5GwPsWz11xW3WnDUG/+0L/Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF370134BA;
        Wed, 15 Feb 2023 18:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fdzCLa0j7WNTcAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Feb 2023 18:25:49 +0000
Date:   Wed, 15 Feb 2023 19:25:48 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
Message-ID: <20230215182547.GA17571@blackbody.suse.cz>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-3-ryncsn@gmail.com>
 <20230208172956.GF24523@blackbody.suse.cz>
 <Y+P17OVZZWVpYIb0@cmpxchg.org>
 <CAMgjq7Bem+8g8A_OR26PHhYYx-A7LHHO3tyQNR_tMnaaKNxkug@mail.gmail.com>
 <CAMgjq7CKG_pNxm5ofciK-aBKwGuRCiyWPm1BXhjmcg=N0bfFcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <CAMgjq7CKG_pNxm5ofciK-aBKwGuRCiyWPm1BXhjmcg=N0bfFcg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 01:49:22AM +0800, Kairui Song <ryncsn@gmail.com> wr=
ote:
> With rootcg:
> 55718.9 op/s (unpatched) compared to 55862.2 (patched)
> With 5 levels:
> 49975.5 op/s (unpatched) compared to 50778.5 op/s (patched)
>=20
> Previous tests are a bit biased since I only run the test for 100 * 3
> times, or maybe it is sensitive to some random kernel structure
> changes.
>=20
> But I ignored one important thing in my previous test, that the
> performance actually drops heavily with deeper levers of cgroups:
> With 8 levels:
> 48902.4 op/s (unpatched) compared to 47476.6 op/s (patched)
> With 50 levels of cgroup:
> 25605.7375 op/s (unpatched) compared to 20417.275 op/s (patched)

IIUC, one could also interpret this as the parent caching within
psi_group is effective especially with deep hierarchies.

I'd say practical hierarchies are below 10 levels deep. But yeah, the
averaged results aren't so impressive.

Thanks for sharing your insights,
Michal

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+0jqAAKCRAkDQmsBEOq
uUXvAP4+saOtuGucCO0aCQxHAbvhTyM5VvwDko7ulIHrCJqItwD/Ygb9MEG1fYtK
kuirW9/kbrOKIwB1g5aix6+CxtrydQw=
=eG0E
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
