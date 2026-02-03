Return-Path: <cgroups+bounces-13632-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J3VApq7gWm7JAMAu9opvQ
	(envelope-from <cgroups+bounces-13632-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 10:10:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB9D69C6
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B0430305D7
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98E395DBC;
	Tue,  3 Feb 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZUvIt8fg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90830C614
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109604; cv=none; b=VnIcS4vh2HtBNK23Pb31KR8mDpqze6ALjM5mmW1TgbmDLOJ7/DwBiuzlTgC0k2KhmyXhHTeH2FRkwQvw0jgWf19tdH05Zp4q2+s+ew5tt/PogLFejyehB4i2INW+QJw8mRkfI5h7WQJHyIH09fedRh89RrgOmc/LutA8z77xvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109604; c=relaxed/simple;
	bh=MOKpDNTqNF8fAwtcWjo9j4D4UG1yJPkppdfmDHB9hNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4Pg0dgzbdIaPljtizQEYDyPwIjQvuvG2np7tp8RCFAc/eA9G36zmVrtrl3E5s55G92zPg7ALhfgoTcqn//HXhWCK4k6yvF3ofcZG+SYFZQpSQrMscjcRABHSQT7+xxSGBn3vo3P69MkgmXK975J+BJN0VtHJ1WlxI9GQd8sck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZUvIt8fg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806bf39419so2983715e9.1
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770109601; x=1770714401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaA9Uux9+RofOmmDHbyRFguFePFUhjemsJOqSAyT258=;
        b=ZUvIt8fgmgGCjFssb1+TXvQeDodNR3iSAIdKeBbWit1oy4XyOESYEtL4vY3Mh9qffi
         w3jtY8i+o6fF2RXMkUjvK52LBwklyRtqVTVWjBjreG3QnlQy9PC4URcWurr9RoAfonHQ
         sVKcruz8kZDTxWQsP+q3n6kJcgB3Tpj7qAva7FzhXCFDkhtnztMHU4mMsgld+bNnnMSQ
         Ra7MThdzfjF0VUAZN0yAOVf1YTU4vBfIGCCJzNDquMhUgetPbQBJ3RxE4aOJBUdPrxLc
         lUNNj2ykc1Kms+LHbrCjJxiPX/hW++COXOP7mt+gvrp0TBUYNj0jCxLsd6L45UYgK/y4
         /LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109601; x=1770714401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaA9Uux9+RofOmmDHbyRFguFePFUhjemsJOqSAyT258=;
        b=ea46XoFh52LNsW9Fo/F+8bxJ12VSANSYxCcfewQWfwgqqYcYXMmxhmRdNiGONT1S9D
         zAYqNRnrj9yK+18FKUPGb7f2sD3qUq+WhP05nUvhgf3Y9MPKSj+iXRij+NWBKiPs3P6b
         SlOen2nF2oHtjuOafsEUDO5Xg2Ijzm5moe0ulgX22bcxd4E8VVRS15UErk2geiq8pBrE
         URLmdFCXsv4b9jp5gPHIABznWlKHQrUbWN4SVrhEX5ZA/PEsvSct1kA/zfPQcih5IW27
         lJ5uhqoi0usLN78OKq/MiWQ72fGWDXl0IiMMWKWKujcfkCVzM2Gh857zs/+A6Qj4I8gQ
         rKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBxmTrMkp4v+muSrGNegjxYJqeRFlY9MFE/61DiwY6lDmkUQBODSbu6u0fjngPmyHS8SW3lIrP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7jIBDxXWXiLtLSXYrQEvronmNEJKOo0bTgqhYPFbC5l7+R9Q
	OWkSkUW/hSiyx/8F0QoqRvRVZmS4nbhvlc/84NKP9a1fpMoOx/BLrlsmAVXZOtUYlbg=
X-Gm-Gg: AZuq6aJDeFIHRhLTrYjQq0MvqCh7A6/Vv+9pMTddfxYPKbvKfnaKZ+LvWmNFDQuZD1G
	kGjLXE8KJX+XiXPREcVoo50GXRFQ9v+tE9SVobQ8hrJxp9SshpcEMpECdfvQsXsUpNpux/4aPQh
	cEN8C+971zsHOCt9dlSH6Zq1oXfT3+mrH3E7sG4mPRoMiibWmSyCEJH2lbIv995P2ynMejB0LVy
	PgJiDR6iwxnpdqnfMHgZ96LNIE3WEUIqQSruD15gbfWlZaaLr3mkmsQ4jmXJ0xmb45FwKvNZ7LH
	CHwiiRPNrbCWAcKj5X+MlUE9RDJ1umTlmQd7DAhjse/9AyPjhS56AEeKXfpyUXHV4Fk2hOWpp6e
	dEhnPOOAA/vk++Qpm4w1tNG4lK0pDRplfVW8RNWIj7cX4zwxSUAbsF5YQ2bRIYoULwiIDgcAIyb
	k2gdIIzUMx7Xh+vD/q9q6dkG6zH71RcP7sTv7B//Q2zA==
X-Received: by 2002:a05:600c:5394:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-483050f3f03mr32702305e9.0.1770109600817;
        Tue, 03 Feb 2026 01:06:40 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830515381esm52449765e9.11.2026.02.03.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:06:40 -0800 (PST)
Date: Tue, 3 Feb 2026 10:06:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhengqixing@huawei.com, hch@infradead.org, ming.lei@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 6/7] blk-cgroup: allocate pds before freezing queue in
 blkcg_activate_policy()
Message-ID: <gq45vl55n2gucipjc5jk5e5kp7ups3nw672ua6nvksooycezv5@lfr62hy5br4f>
References: <20260203080602.726505-1-yukuai@fnnas.com>
 <20260203080602.726505-7-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg37qi5glisvi4nl"
Content-Disposition: inline
In-Reply-To: <20260203080602.726505-7-yukuai@fnnas.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13632-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 53EB9D69C6
X-Rspamd-Action: no action


--dg37qi5glisvi4nl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/7] blk-cgroup: allocate pds before freezing queue in
 blkcg_activate_policy()
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 04:06:01PM +0800, Yu Kuai <yukuai@fnnas.com> wrote:
> Some policies like iocost and iolatency perform percpu allocation in
> pd_alloc_fn(). Percpu allocation with queue frozen can cause deadlock
> because percpu memory reclaim may issue IO.
>=20
> Now that q->blkg_list is protected by blkcg_mutex,

With this ^^^

=2E..
> restructure
> blkcg_activate_policy() to allocate all pds before freezing the queue:
> 1. Allocate all pds with GFP_KERNEL before freezing the queue
> 2. Freeze the queue
> 3. Initialize and online all pds
>=20
> Note: Future work is to remove all queue freezing before
> blkcg_activate_policy() to fix the deadlocks thoroughly.
>=20
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-cgroup.c | 90 +++++++++++++++++-----------------------------
>  1 file changed, 32 insertions(+), 58 deletions(-)
>=20
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 0206050f81ea..7fcb216917d0 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1606,8 +1606,7 @@ static void blkcg_policy_teardown_pds(struct reques=
t_queue *q,
>  int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_polic=
y *pol)
>  {
>  	struct request_queue *q =3D disk->queue;
> -	struct blkg_policy_data *pd_prealloc =3D NULL;
> -	struct blkcg_gq *blkg, *pinned_blkg =3D NULL;
> +	struct blkcg_gq *blkg;
>  	unsigned int memflags;
>  	int ret;
> =20
> @@ -1622,90 +1621,65 @@ int blkcg_activate_policy(struct gendisk *disk, c=
onst struct blkcg_policy *pol)
=2E..

> +	/* Now freeze queue and initialize/online all pds */
> +	if (queue_is_mq(q))
> +		memflags =3D blk_mq_freeze_queue(q);
> +
> +	spin_lock_irq(&q->queue_lock);
> +	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
> +		struct blkg_policy_data *pd =3D blkg->pd[pol->plid];
> +
> +		/* Skip dying blkg */
> +		if (hlist_unhashed(&blkg->blkcg_node))
> +			continue;
> +
> +		spin_lock(&blkg->blkcg->lock);
>  		if (pol->pd_init_fn)
>  			pol->pd_init_fn(pd);
> -
>  		if (pol->pd_online_fn)
>  			pol->pd_online_fn(pd);
>  		pd->online =3D true;
> -
>  		spin_unlock(&blkg->blkcg->lock);
>  	}
> =20
>  	__set_bit(pol->plid, q->blkcg_pols);
> -	ret =3D 0;
> -
>  	spin_unlock_irq(&q->queue_lock);
> -out:
> -	mutex_unlock(&q->blkcg_mutex);
> +
>  	if (queue_is_mq(q))
>  		blk_mq_unfreeze_queue(q, memflags);
> -	if (pinned_blkg)
> -		blkg_put(pinned_blkg);
> -	if (pd_prealloc)
> -		pol->pd_free_fn(pd_prealloc);
> -	return ret;
> +	mutex_unlock(&q->blkcg_mutex);
> +	return 0;

Why is q->queue_lock still needed here?

Thanks,
Michal

--dg37qi5glisvi4nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYG6kBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjEEQD/S6QTA3Md9Aw4rFLx2TGh
sAf5TpmWFXBsYFlAeJMSE9kBALzTT27YQL8oCWii6gU0StNOW5kiSEH01UyxNckM
+9UN
=BbWt
-----END PGP SIGNATURE-----

--dg37qi5glisvi4nl--

