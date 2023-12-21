Return-Path: <cgroups+bounces-987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52481AEF7
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 07:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B143B1C22C41
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30205BA38;
	Thu, 21 Dec 2023 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2bfbSOH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBBC2C6;
	Thu, 21 Dec 2023 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1181919a12.0;
        Wed, 20 Dec 2023 22:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703141802; x=1703746602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEtEt++hhmQprHsmNzuao+3x/xY9EBfmLNIQ2caP2ME=;
        b=b2bfbSOHrtWP0FEqxOX3TCEXIUNR/0OlKn0bQy/LMmibG8bwl2DuxcUVlIy4kJ9Wlu
         C4apg1zHM4eGgWPj8w4pUmJi9qgZVGbU6fUxN1xbn2t5VQqIV9q5AzV8ecvWhlDGAGNT
         UQZNi3FOhz5IKGO1SSCBI+cpmadqgypxcWeUnoI2uP9qVhu4L3RbqpJFETxbqNe+cwlR
         ryCc7NHp3jrhoDrM7/VVDDXN7gQjN6IGbaY1qRin/ykPpfbwDkeY5yjrNKeH4c/Q+IaV
         tP4maWxruf6R4NMxRe7zu75xs8DSLffkSuJ3XEjpYdfOwk02fxU4L6iQ37qqcW9Xl/+/
         4w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141802; x=1703746602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEtEt++hhmQprHsmNzuao+3x/xY9EBfmLNIQ2caP2ME=;
        b=bYQCjwaEmzTkp1eLGLA83lHWGnfNV5/TnfLKC3ZH74XG2e1zY2SGizyOA2wOXbuOGI
         A+Nrq64+3ZnvcUBakGSj1WxwDLJWn4Bp1nmN8pYurOAV7HmeaCT6dlurGz7TZb/FGtW6
         bO1fXKXvc0CheCl7BZFrtHSHkLSuZfSM06FMmEPIUQRNPLJGI3iCIOn5yP3T+fbTX/KT
         NmA7lwsCYySVKLV3EgxteKglc/w9jogDyH6LyWWcrNlZ1XyrChhPZnWT1H0uTGeHGLtB
         nG6tGgPctBfgI3n4lx8cweEHQmGPPndomYCLtbhs8u0H5byvOx/lbrrmEKHpzLWBV6iv
         pynw==
X-Gm-Message-State: AOJu0YxQ4b8bYMK3fx3NSZN0cfaIQi/dMabfr5o/gtZvuPt7gSL7Ua5B
	FGHjfHs18h3HaCYegFRUi5s=
X-Google-Smtp-Source: AGHT+IGOcBb85kPB2NAjer3W1zoymTt2tLScYSZwOMMxzAbb+/4OGwChG9GHN9fy0S6j858l24HXEw==
X-Received: by 2002:a17:90a:df14:b0:28b:bdf1:fd25 with SMTP id gp20-20020a17090adf1400b0028bbdf1fd25mr313549pjb.11.1703141801836;
        Wed, 20 Dec 2023 22:56:41 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id so17-20020a17090b1f9100b0028658c6209dsm4890665pjb.2.2023.12.20.22.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:56:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E694B101D8A8C; Thu, 21 Dec 2023 13:56:36 +0700 (WIB)
Date: Thu, 21 Dec 2023 13:56:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux CGroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Message-ID: <ZYPhpKOewFkYIDFL@archie.me>
References: <20231208093310.297233-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MF3osqI6+GUgm1Na"
Content-Disposition: inline
In-Reply-To: <20231208093310.297233-1-max.kellermann@ionos.com>


--MF3osqI6+GUgm1Na
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 10:33:09AM +0100, Max Kellermann wrote:
> By passing the fsugid to kernfs_create_dir_ns(), we don't need
> cgroup_kn_set_ugid() any longer.  That function was added for exactly
> this purpose by commit 49957f8e2a43 ("cgroup: newly created dirs and
> files should be owned by the creator").
>=20
> Eliminating this piece of duplicate code means we benefit from future
> improvements to kernfs_create_dir_ns(); for example, both are lacking
> S_ISGID support currently, which my next patch will add to
> kernfs_create_dir_ns().  It cannot (easily) be added to
> cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
> from there.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> --
> v1 -> v2: 12-digit commit id
> ---
>  kernel/cgroup/cgroup.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
>=20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 4b9ff41ca603..a844b421fd83 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4169,20 +4169,6 @@ static struct kernfs_ops cgroup_kf_ops =3D {
>  	.seq_show		=3D cgroup_seqfile_show,
>  };
> =20
> -/* set uid and gid of cgroup dirs and files to that of the creator */
> -static int cgroup_kn_set_ugid(struct kernfs_node *kn)
> -{
> -	struct iattr iattr =3D { .ia_valid =3D ATTR_UID | ATTR_GID,
> -			       .ia_uid =3D current_fsuid(),
> -			       .ia_gid =3D current_fsgid(), };
> -
> -	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
> -	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
> -		return 0;
> -
> -	return kernfs_setattr(kn, &iattr);
> -}
> -
>  static void cgroup_file_notify_timer(struct timer_list *timer)
>  {
>  	cgroup_file_notify(container_of(timer, struct cgroup_file,
> @@ -4195,25 +4181,18 @@ static int cgroup_add_file(struct cgroup_subsys_s=
tate *css, struct cgroup *cgrp,
>  	char name[CGROUP_FILE_NAME_MAX];
>  	struct kernfs_node *kn;
>  	struct lock_class_key *key =3D NULL;
> -	int ret;
> =20
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	key =3D &cft->lockdep_key;
>  #endif
>  	kn =3D __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
>  				  cgroup_file_mode(cft),
> -				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				  current_fsuid(), current_fsgid(),
>  				  0, cft->kf_ops, cft,
>  				  NULL, key);
>  	if (IS_ERR(kn))
>  		return PTR_ERR(kn);
> =20
> -	ret =3D cgroup_kn_set_ugid(kn);
> -	if (ret) {
> -		kernfs_remove(kn);
> -		return ret;
> -	}
> -
>  	if (cft->file_offset) {
>  		struct cgroup_file *cfile =3D (void *)css + cft->file_offset;
> =20
> @@ -5616,7 +5595,9 @@ static struct cgroup *cgroup_create(struct cgroup *=
parent, const char *name,
>  		goto out_cancel_ref;
> =20
>  	/* create the directory */
> -	kn =3D kernfs_create_dir(parent->kn, name, mode, cgrp);
> +	kn =3D kernfs_create_dir_ns(parent->kn, name, mode,
> +				  current_fsuid(), current_fsgid(),
> +				  cgrp, NULL);
>  	if (IS_ERR(kn)) {
>  		ret =3D PTR_ERR(kn);
>  		goto out_stat_exit;
> @@ -5761,10 +5742,6 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, co=
nst char *name, umode_t mode)
>  	 */
>  	kernfs_get(cgrp->kn);
> =20
> -	ret =3D cgroup_kn_set_ugid(cgrp->kn);
> -	if (ret)
> -		goto out_destroy;
> -
>  	ret =3D css_populate_dir(&cgrp->self);
>  	if (ret)
>  		goto out_destroy;

No noticeable regressions with this patch applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--MF3osqI6+GUgm1Na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYPhnwAKCRD2uYlJVVFO
o90vAQDDn55gsGPiaCKeuPg75TssDbT5TrTVA4bncC2D1RsxcAEAxMKDFyns+uYR
wZ6IxDR+1liL6ADVLXNTLi1xVPi5OA8=
=FLCG
-----END PGP SIGNATURE-----

--MF3osqI6+GUgm1Na--

