Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C2654225
	for <lists+cgroups@lfdr.de>; Thu, 22 Dec 2022 14:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLVNuv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Dec 2022 08:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiLVNut (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Dec 2022 08:50:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1486382;
        Thu, 22 Dec 2022 05:50:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C58D23CF6;
        Thu, 22 Dec 2022 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671717046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKCiYQ23O3uBl9KybsaGHQdKwg661OuoQvd3fEpwuvo=;
        b=M08TLcqeLRGth27rtQLEqHTEGmfzGkrqCZ28m6wQlz4q5subWsUifO6MKgLung/h4RS3BB
        P5H7klPHvF5K/SUmOS5SqH4qKAEn2djJ0sBN8Hs22P5KNCpHvI90xMQc+6tYJHw5YkbVVz
        NshLbpDNi5HYwlu2rdu7WSWw4CZfKS8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2914A138FD;
        Thu, 22 Dec 2022 13:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JLUfCbZgpGNZOgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 22 Dec 2022 13:50:46 +0000
Date:   Thu, 22 Dec 2022 14:50:44 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 2/2] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <20221222135044.GB20830@blackbody.suse.cz>
References: <20221220182745.1903540-1-roman.gushchin@linux.dev>
 <20221220182745.1903540-3-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20221220182745.1903540-3-roman.gushchin@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 10:27:45AM -0800, Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> To charge a freshly allocated kernel object to a memory cgroup, the
> kernel needs to obtain an objcg pointer. Currently it does it
> indirectly by obtaining the memcg pointer first and then calling to
> __get_obj_cgroup_from_memcg().

Jinx [1].

You report additional 7% improvement with this patch (focused on
allocations only). I didn't see impressive numbers (different benchmark
in [1]), so it looked as a microoptimization without big benefit to me.

My 0.02=E2=82=AC to RFC,
Michal


[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D216038#c5

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY6RgsgAKCRAkDQmsBEOq
uee9AP0XW2wd7WEaYeLk8NGJ88vIfhH8dybRnl5vWnQZqfHw9AEA1OHVGGFOMlz6
lYuj11/kUl2A4R6elqCcLj9yPsw26QY=
=OHxW
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
