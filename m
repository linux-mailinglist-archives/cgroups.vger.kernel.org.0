Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94DC665D82
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjAKOSP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 09:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjAKOR4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 09:17:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51BDF6F
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 06:17:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19CAF337D6;
        Wed, 11 Jan 2023 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673446639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sVrq4Dniw5KnDcNZ1C6CZNPXzD9gn2lEBhnqlgUWQg=;
        b=EXtg4ez0ch4jeVKmyNXeCXnuQie+WMbN7uTHT/Spqz9Lhu82IcRtoMI7K5IzlqjRl53JvS
        lX9U23sleXpjF1VHRMIjz8XuTjeI6ptzTin6V3ueNjB8Fe/HltDjp6Dvx/uso5a3AEEKdW
        WhWP6WtVCkCyZYq9t2oINfZk5XlclYI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C686513591;
        Wed, 11 Jan 2023 14:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V0KDL+7EvmOECgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 Jan 2023 14:17:18 +0000
Date:   Wed, 11 Jan 2023 15:17:17 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: working set extensions
Message-ID: <20230111141716.GA14685@blackbody.suse.cz>
References: <20221214225123.2770216-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20221214225123.2770216-1-yuanchu@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 02:51:21PM -0800, Yuanchu Xie <yuanchu@google.com> =
wrote:
> that's frequently used. The only missing pieces between MGLRU
> generations and working set estimation are a consistent aging cadence
> and an interface; we introduce the two additions.
>=20
> Periodic aging
> =3D=3D=3D=3D=3D=3D
> MGLRU Aging is currently driven by reclaim, so the amount of time
> between generations is non-deterministic. With memcgs being aged
> regularly, MGLRU generations become time-based working set information.

Is this periodic aging specific to memcgs? IOW, periodic aging isn't
needed without memcgs (~with root only)
(Perhaps similar question to Aneeh's.)

> Use case: proactive reclaimer
> =3D=3D=3D=3D=3D=3D
> The proactive reclaimer sets the aging interval, and periodically reads
> the page idle age stats, forming a working set estimation, which it then
> calculates an amount to write to memory.reclaim.
>=20
> With the page idle age stats, a proactive reclaimer could calculate a
> precise amount of memory to reclaim without continuously probing and
> inducing reclaim.

Could the aging be also made per-memcg? (Similar to memory.reclaim,
possibly without the new kthread (if global reclaim's aging is enough).)

Thanks,
Michal


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY77E6gAKCRAkDQmsBEOq
ufzXAP9oSegjiyAMqSaGyInbRBFZQWAgWZSfIZLFLnPaHnPLewD/abXGqTRB65aj
qyqWc5cOAqYeuzRkjwwaFp6QKtrImwE=
=Jo1y
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
