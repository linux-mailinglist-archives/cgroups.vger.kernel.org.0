Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B438F296355
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898631AbgJVRGt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 13:06:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34934 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898289AbgJVRGt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 13:06:49 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2020 13:06:48 EDT
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVduW-0001tE-8q; Thu, 22 Oct 2020 12:57:56 -0400
Message-ID: <004fe66ee1d111ec006dd065b9bed5fdcfdaad01.camel@surriel.com>
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
From:   Rik van Riel <riel@surriel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Date:   Thu, 22 Oct 2020 12:57:55 -0400
In-Reply-To: <db4f86f30726a1a33c868155b4c681ac25569179.camel@fb.com>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
         <db4f86f30726a1a33c868155b4c681ac25569179.camel@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-q/yjJ9zoR2cgocIosU9b"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-q/yjJ9zoR2cgocIosU9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 12:49 -0400, Rik van Riel wrote:
> On Thu, 2020-10-22 at 11:18 -0400, Johannes Weiner wrote:
>=20
> > index e80aa9d2db68..334ce608735c 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -204,9 +204,9 @@ static void unaccount_page_cache_page(struct
> > address_space *mapping,
> >  	if (PageSwapBacked(page)) {
> >  		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
> >  		if (PageTransHuge(page))
> > -			__dec_node_page_state(page, NR_SHMEM_THPS);
> > +			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
> >  	} else if (PageTransHuge(page)) {
> > -		__dec_node_page_state(page, NR_FILE_THPS);
> > +		__dec_lruvec_page_state(page, NR_FILE_THPS);
> >  		filemap_nr_thps_dec(mapping);
> >  	}
>=20
> This may be a dumb question, but does that mean the
> NR_FILE_THPS number will no longer be visible in
> /proc/vmstat or is there some magic I overlooked in
> a cursory look of the code?

Never mind, I found it a few levels deep in
__dec_lruvec_page_state.

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-q/yjJ9zoR2cgocIosU9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+RuhQACgkQznnekoTE
3oNrzwf9GSWmH30yYW4VoJhqcAiuVzpHRu/K7HGUTezlWzZgMV+ef6NYaUk0NItK
sIgNpwCkeBZXg99ZG6y7o/yBiMLB7LR9E5PdREv+7CQrgZ8dvTbu0OhsmhOvo8TL
+ufRBaAt4aK1Melt27dbnooHH43PVqRODDI9nkp4NU/aSIGami/KCAIGf3JfMEyR
mK7THczWyFCknk1LWfPIbhYb3cneiwM62w07Xn3Fs4ord5612IvbW3iULFEMQwAO
FUQ8DZycLWEIJL9DDa/eYeNH9c0cq0tzdiRBsaESVnT4q/I0gapNN4eLora3VCzi
xqEBWQ22PQDOuUdJ0Lc7fyrhnplMWA==
=/3Jx
-----END PGP SIGNATURE-----

--=-q/yjJ9zoR2cgocIosU9b--

