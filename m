Return-Path: <cgroups+bounces-988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B481AEFC
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E104A1C20B04
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9668BA39;
	Thu, 21 Dec 2023 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+xU+aV/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7ABA33;
	Thu, 21 Dec 2023 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9389583edso459411b3a.0;
        Wed, 20 Dec 2023 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703141863; x=1703746663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSSFqrzbHEXNTzMZg0vJmST5AGzDIOxvv040iEauRhs=;
        b=E+xU+aV/dKhCET38amSmg5SKsSaIqBziuq4XitAkh+Di9WD+J1Q9uQPXgnaTpeAvnm
         Sp6/kfmYcGf/M/SVhgE/0+ldkgN1ebRGmDYv0RdQi2onZo7p5CeP7T+Y/WB4pLwIgwuz
         NnT4v1mAhamC0cyPClu/kqffLN/drzSyMrj+3qQp6fxCGr515Z2fDdPWHfxMFo/7wTMQ
         V6IEgqSn35UXOtMGZNO0n9VXAUkVfmGBSpslB3BbkGHiOTd/42gj4N9K7jopQ7E4Up2c
         CDaqVApzfiL9l/maKSwQgUyZCr3G4harDVni6WNuGb1llDn504DKYOLCXBMjqEnZRkY8
         s5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141863; x=1703746663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSSFqrzbHEXNTzMZg0vJmST5AGzDIOxvv040iEauRhs=;
        b=u3TdQ7Pg0gvQxjENKLR+ZckddDCFiDsSjJ1EWgCvib1ZuafHzxagiMapN8XERfMjWh
         Z7Zn0g5kwzs9VTUlZGkLDSSYMVKA0TGl1PO+LSgfXA3wxIMN6sFmM6jMi6sgZZfJhufp
         kUg4D7iVBr9l3zyqRNLsp0aCIOA24XS0cwHl4uO8lqGi+/E7+cnjsf9KcuKy60ASb8vU
         rCQs0mcoK956Rz4pE4FHTntJDLln9+QEDQTt7AgzWzaUw9IzFLTbE68jSFbJtUvxBArk
         krkqcjdmBY5VRhjTTjX+6rSUVj2wyIuX8TsdWHc8eHBm+8VybgMIR/wUAJzecOmTYnxF
         P48Q==
X-Gm-Message-State: AOJu0YzebwQWIkrEQCKH4++FFaYJBezI3lk9vwIs520mInyoDvoDoJZZ
	dU7f4MPIxRXKzPS7xuz1Q+uISTRjzulOHw==
X-Google-Smtp-Source: AGHT+IH54dPx3DWE19yj91lbFk3++PIHUvL3+l0d1KoJu1by96ITRjHnYYJrTjmEtmTxfeVnlMreZQ==
X-Received: by 2002:a05:6a20:9151:b0:194:efaa:8762 with SMTP id x17-20020a056a20915100b00194efaa8762mr1050438pzc.87.1703141862608;
        Wed, 20 Dec 2023 22:57:42 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902700a00b001d3b308aff2sm838231plk.129.2023.12.20.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:57:42 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EC03B101D8A8C; Thu, 21 Dec 2023 13:57:37 +0700 (WIB)
Date: Thu, 21 Dec 2023 13:57:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs/kernfs/dir: obey S_ISGID
Message-ID: <ZYPh4T21-6DAbxq5@archie.me>
References: <20231208093310.297233-1-max.kellermann@ionos.com>
 <20231208093310.297233-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWO6PprgJ1tduci0"
Content-Disposition: inline
In-Reply-To: <20231208093310.297233-2-max.kellermann@ionos.com>


--cWO6PprgJ1tduci0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 10:33:10AM +0100, Max Kellermann wrote:
> Handling of S_ISGID is usually done by inode_init_owner() in all other
> filesystems, but kernfs doesn't use that function.  In kernfs, struct
> kernfs_node is the primary data structure, and struct inode is only
> created from it on demand.  Therefore, inode_init_owner() can't be
> used and we need to imitate its behavior.
>=20
> S_ISGID support is useful for the cgroup filesystem; it allows
> subtrees managed by an unprivileged process to retain a certain owner
> gid, which then enables sharing access to the subtree with another
> unprivileged process.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> --
> v1 -> v2: minor coding style fix (comment)
> ---
>  fs/kernfs/dir.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 8b2bd65d70e7..62d39ecf0a46 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -676,6 +676,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_no=
de *parent,
>  {
>  	struct kernfs_node *kn;
> =20
> +	if (parent->mode & S_ISGID) {
> +		/* this code block imitates inode_init_owner() for
> +		 * kernfs
> +		 */
> +
> +		if (parent->iattr)
> +			gid =3D parent->iattr->ia_gid;
> +
> +		if (flags & KERNFS_DIR)
> +			mode |=3D S_ISGID;
> +	}
> +
>  	kn =3D __kernfs_new_node(kernfs_root(parent), parent,
>  			       name, mode, uid, gid, flags);
>  	if (kn) {

No noticeable regressions with this patch applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cWO6PprgJ1tduci0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYPh4QAKCRD2uYlJVVFO
o26ZAP4r4J3I/Nd9h7weNBy5Qw8g6Kgy2tV9RcfYL4qS36KoeQEA3T33VwzqzLb0
gitkBNYZ6MQltYWRNtkpj0zs3bzuyg4=
=eiS0
-----END PGP SIGNATURE-----

--cWO6PprgJ1tduci0--

