Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C0710E08
	for <lists+cgroups@lfdr.de>; Thu, 25 May 2023 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbjEYOLz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 May 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjEYOLy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 May 2023 10:11:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F6183;
        Thu, 25 May 2023 07:11:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A32F1FE6A;
        Thu, 25 May 2023 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685023912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2JH6pTYcJePjQtM79Iqz39SbWKAXK4Qz2x1GSVTfLY=;
        b=RGyV9NO3PzYGEcee4AtXtXB1xO4jeCtqPc89Ldtc0+jxV2LTOn8SQ2TVpUKhPg82a72hSf
        YbPYy5G/nF0nG2sLTc/iU8w/kbOdF8XcQEeWGzx+nvYujx9CrkrQOgXNaZVwM/7RqJZIQQ
        djbtpQ6hb7F/xxxVsfTH6VBOufQttEQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23246134B2;
        Thu, 25 May 2023 14:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yJTQB6hsb2RpZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 25 May 2023 14:11:52 +0000
Date:   Thu, 25 May 2023 16:11:50 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Linux-MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <3ej42djuuzwx36yf2yeo5ggyrvogeaguos5jtve2bvuaejnwff@fak3yjwe2fbi>
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yw4zsdelcidbb6wx"
Content-Disposition: inline
In-Reply-To: <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--yw4zsdelcidbb6wx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 10:37:10AM +0800, Ming Lei <ming.lei@redhat.com> wr=
ote:
> > I am not at all familiar with blkcg, but does calling
> > cgroup_rstat_flush() in offline_css() fix the problem?
>=20
> Except for offline, this list needs to be flushed after the associated di=
sk
> is deleted.

Why the second flush trigger?
a) To break another ref-dependency cycle (like on the blkcg side)?
b) To avoid stale data upon device removal?

(Because b) should be unnecessary, a future reader would flush when
needed.)

Thanks,
Michal

--yw4zsdelcidbb6wx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZG9spAAKCRAkDQmsBEOq
ufTLAP9NX8DIiij6/hpnoy9/M+nnSBemEZ9lY1LODUguhjSJrAEA5g8mQPrBr8KR
A7VHGk9AX3B3eIPAFYavVz4cMoIrYwE=
=56eg
-----END PGP SIGNATURE-----

--yw4zsdelcidbb6wx--
