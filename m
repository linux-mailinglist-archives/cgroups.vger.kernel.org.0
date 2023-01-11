Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D8665B7A
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjAKMfp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 07:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjAKMfk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 07:35:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41415FE9;
        Wed, 11 Jan 2023 04:35:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32A1F17847;
        Wed, 11 Jan 2023 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673440534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KUl6YA1IKQUKcScNMyJ415yLqRxEtI8kTOV2MucdUwI=;
        b=j8rDezHZBy0CHoXmut/N/eeDkVcSrSq7aWYb5DR4MRZOYPn0lF3k4OfsNWh/JMkukmXI5a
        jnVqayNAkJa2dXnAOZ2jAW7c3IzpBFryMclHuyPIidoCAeQy0Uz42dbyRCZp1Waf/ELEBW
        WMG/RLx2vU0i9sSpqAnw6cTTTox7xYM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2AD413591;
        Wed, 11 Jan 2023 12:35:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VTo9OhWtvmPaTQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 Jan 2023 12:35:33 +0000
Date:   Wed, 11 Jan 2023 13:35:32 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     hanjinke <hanjinke.666@bytedance.com>, Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
Message-ID: <20230111123532.GB3673@blackbody.suse.cz>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3>
 <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

Thanks all for sharing ideas and more details (in time-previous messages).

On Sat, Jan 07, 2023 at 02:07:38AM +0800, hanjinke <hanjinke.666@bytedance.=
com> wrote:
> But for some specific scenarios with old kernel versions, blk-throtl
> is alose needed. The scenario described in my email is in the early stage=
 of
> research and extensive testing for it. During this period=EF=BC=8Csome pr=
iority
> inversion issues amoug cgroups or within one cgroup have been observed. S=
o I
> send this patch to try to fix or mitigate some of these issues.

Jinke, do you combine blk-throtl with memory limits? (As that could in theo=
ry
indirectly reduce async requests as dirtier would be slowed down.)

Thanks,
Michal

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY76tEgAKCRAkDQmsBEOq
uTntAQCFo6a3wu0l6VAEdVs14UXuwMrppoC19q2D3MXh03vohQEAjdb/QSHK87YF
XpY7Qj73w0N3r7QhlT9J4wOlGj1WVQ4=
=m0hK
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
