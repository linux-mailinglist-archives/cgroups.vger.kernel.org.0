Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858043B4636
	for <lists+cgroups@lfdr.de>; Fri, 25 Jun 2021 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYPD2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Jun 2021 11:03:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39326 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhFYPD1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Jun 2021 11:03:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1115E21BBC;
        Fri, 25 Jun 2021 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624633266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYtZDXXBqmKds5ECLI57WHQ/cGmnmFmRdFQQ8+omhQE=;
        b=Ad3QdyvjV7SEr9bcC67SXHdKQKRdG7EDQ3/jLqhiiGKnxSVQ/XvSKx64WeaqvddAvxYEeS
        y71ooSfUBNpR3vdqQzIKMvijIwx4GLBeN2+yO/FyAbtCsBLP7SUKLzdh4ldpBEuSXRRHHp
        5YduV78lzrexanPUQ+l4iLCc2GiGwNs=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8B77B11A97;
        Fri, 25 Jun 2021 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624633266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYtZDXXBqmKds5ECLI57WHQ/cGmnmFmRdFQQ8+omhQE=;
        b=Ad3QdyvjV7SEr9bcC67SXHdKQKRdG7EDQ3/jLqhiiGKnxSVQ/XvSKx64WeaqvddAvxYEeS
        y71ooSfUBNpR3vdqQzIKMvijIwx4GLBeN2+yO/FyAbtCsBLP7SUKLzdh4ldpBEuSXRRHHp
        5YduV78lzrexanPUQ+l4iLCc2GiGwNs=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id UxbpILHv1WD5JQAALh3uQQ
        (envelope-from <mkoutny@suse.com>); Fri, 25 Jun 2021 15:01:05 +0000
Date:   Fri, 25 Jun 2021 17:01:03 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <YNXvr81YFzbaTxCb@blackbook>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
 <20210610173944.1203706-4-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5j6/vlzLDa+2hbwL"
Content-Disposition: inline
In-Reply-To: <20210610173944.1203706-4-schatzberg.dan@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--5j6/vlzLDa+2hbwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Thu, Jun 10, 2021 at 10:39:44AM -0700, Dan Schatzberg <schatzberg.dan@gm=
ail.com> wrote:
> The current code only associates with the existing blkcg when aio is
> used to access the backing file. This patch covers all types of i/o to
> the backing file and also associates the memcg so if the backing file is
> on tmpfs, memory is charged appropriately.
>=20
> This patch also exports cgroup_get_e_css and int_active_memcg so it
> can be used by the loop module.

Wouldn't it be clearer to export (not explicitly inlined anymore)
set_active_memcg() instead of the int_active_memcg that's rather an
implementation detail?

> @@ -2111,13 +2112,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>  	}
> =20
>  	/* always use the first bio's css */
> +	cmd->blkcg_css =3D NULL;
> +	cmd->memcg_css =3D NULL;
>  #ifdef CONFIG_BLK_CGROUP
> -	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
> -		cmd->css =3D &bio_blkcg(rq->bio)->css;
> -		css_get(cmd->css);
> -	} else
> +	if (rq->bio && rq->bio->bi_blkg) {
> +		cmd->blkcg_css =3D &bio_blkcg(rq->bio)->css;
> +#ifdef CONFIG_MEMCG
> +		cmd->memcg_css =3D
> +			cgroup_get_e_css(cmd->blkcg_css->cgroup,
> +					&memory_cgrp_subsys);
> +#endif
> +	}
>  #endif
> -		cmd->css =3D NULL;
>  	loop_queue_work(lo, cmd);

I see you dropped the cmd->blkcg_css reference (while rq is handled). Is
it intentional?=20

Thanks,
Michal

--5j6/vlzLDa+2hbwL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmDV76sACgkQia1+riC5
qSiuSQ//RuLrhmEm2tqe6ciRm5NFiZQF/gEoqlfIygG6S/Q5lzHaXfunSnld8aeQ
mEfUp2V9cgNCloT0+TK4jwg+JMBZo5rHOwUS43uE/S36e+X1KrfvJy2Gwo5rzjuS
Ih+8YChC2/BFILPNh7Ff3rN3yCXc35JNO8Jhd6W0sfFRWiwfydsxRJArpmyCfHZS
K3B1T9vx7FDqwgVIF8EFkSfTV0ELERvePr9uqnBteAjWVOX4iJDxd8oOfQ9MGi1j
NlsFe3HJJnHkB7S0fwcg+n4znvHldSbGaUWlLJceNAXvnYYKrx8uyLBn4tuCVmis
ybVEOEJMpU3YoHFi8WJZhparWwjuvRd0fTMM+0HjdRzbi3scw+u3UzIP+Q4rF4lz
kN3pFSKX9TS0wHOWBxdgzIhxjeea0CQWFtZ2upcx0aHtKAgT3ipHwaOpBi4ewwdA
NlArBZPV8VMZ7pcIZiUb+7HMVmJZvHNYJdY2vaA7lKu17cDpzVbps+4XCrJnZh66
y2knZUttm8qON1cbenO9D1j9eXvqQz1Yczn/yEWwWr6QwRAqWo94fdnvN+PPlmvY
2zVC6tOjwmmlLMQiJnl7Nwoj26LjCdW3tzra5706RL1z0lhxo2GuEyxdF5MBzu4t
F3fe/RPcF8/h9FL4aZ43dyqeHARpmCrqD632nRYxSSvSR6PtcDA=
=evY+
-----END PGP SIGNATURE-----

--5j6/vlzLDa+2hbwL--
