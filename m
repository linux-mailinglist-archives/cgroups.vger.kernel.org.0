Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB645552D6
	for <lists+cgroups@lfdr.de>; Wed, 22 Jun 2022 19:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376762AbiFVRuB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359446AbiFVRuA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 13:50:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904933A1E;
        Wed, 22 Jun 2022 10:50:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD03221B9F;
        Wed, 22 Jun 2022 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655920198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opRo91P/GqK7yMzaovz4eIUEVNzRY22y9hP9e6SynAE=;
        b=D+jNeDTCFQct16h23qveyk5vzFvj/kMfo/QQR3E6yoNoigE+Frq/OOcIgnkqPh7y9namtq
        mj78bxp35TL74EPYrn99JM4gLqtVq/vNwS8vF00br3rWKiqQHWVE67NGbPEYqoanRFYTPU
        2WNEO0SeZeekiINyeRZE7VxL9KstvGY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B550A134A9;
        Wed, 22 Jun 2022 17:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z7W3KkZWs2JOMwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 22 Jun 2022 17:49:58 +0000
Date:   Wed, 22 Jun 2022 19:49:57 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Lin Feng <linf@wangsu.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup.c: remove redundant check for mixable cgroup in
 cgroup_migrate_vet_dst
Message-ID: <20220622174957.GB669@blackbody.suse.cz>
References: <20220621092358.223594-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20220621092358.223594-1-linf@wangsu.com>
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2022 at 05:23:58PM +0800, Lin Feng <linf@wangsu.com> wrote:
> so explicitly checking in cgroup_migrate_vet_dst is unnecessary.

Good catch.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYrNWQQAKCRAkDQmsBEOq
ucMQAQC0vzEGYqYMe6iT+QCRjrhLmh+/uMOR0c3LFFtmaHJ61QEAqVYmOYC4n0eP
w/y9++DuP60Q2oG0yFUWmok1L6iL1gs=
=mSj7
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
