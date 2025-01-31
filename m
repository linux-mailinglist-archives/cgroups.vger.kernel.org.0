Return-Path: <cgroups+bounces-6405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC9A23B76
	for <lists+cgroups@lfdr.de>; Fri, 31 Jan 2025 10:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236343A6534
	for <lists+cgroups@lfdr.de>; Fri, 31 Jan 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207115F330;
	Fri, 31 Jan 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ENU7Qlu8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA5322B
	for <cgroups@vger.kernel.org>; Fri, 31 Jan 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738316024; cv=none; b=V4iB+6TE0HcqLe3JzC4I+L+VyO+pEfGuWOwJnTJVY6WCenJioyHq5e4fbmPmzpfGGYt725ayhcYx7lvjnA8KXoqoQpsvf9afJDSogjYZL9l/pnKAWy8d0T0QEwCPSCNTpGLOU6v2doNdTHj7apcjSV9BabOtiL7iBugmgS8TV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738316024; c=relaxed/simple;
	bh=9psyarGdV+Rf6x2zMJJATLHTqIUxMK5PgiUYtLsiP3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8wh3jO+GmP3W3h5daBguSVUkt1ifk7PqVB6qUNE2i6XaY1y02BpdfsnalgRSs0b1gAceXVi2kSauJJ1VHVk/tLdyFa26Jtau1WDY4kNCw0aX7exd4KNzjA5ACF2vY//Iv6UajrCdeck1M2ZUM3DgAeg0TsvVgWg3jAVlfjD9zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ENU7Qlu8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso1738483f8f.2
        for <cgroups@vger.kernel.org>; Fri, 31 Jan 2025 01:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738316020; x=1738920820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jVAND7Ai4ETwfLpYMCrer3/CF37TNvowAyVGMzEzZ0=;
        b=ENU7Qlu8HPw5RPo6IR0rCRMab4aX6e1as5ErR5GbOwT8vrdQkFCdU1wEYLPWs+Dlyp
         4nQzfw8M8r6HEAjEmDSCycEk2VILJ2ULZP+Y4H+VbuJSToKPKjCZBu4SB42EWECPlZM7
         6O3jaDwYBwlAQwxKKDc2TmjUQ6L61zDBpggCiATfJrLC53mrBZ07h+tFI4ZlS64jn1PF
         fK4DY0WxJB2WBsF80D18wXgZNN7Tn7hK49L+gmzlErlwk1+ge3gjgHHjuTUnmVIbvGSH
         tnY05rMJ+nG9wLhZRtllHd0/k1LpyUeAY6Mc/ujx1P0vdWSXT1xKSLeJGVMLC/ib99g7
         vkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738316020; x=1738920820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jVAND7Ai4ETwfLpYMCrer3/CF37TNvowAyVGMzEzZ0=;
        b=WYpMZBSPfiLRVOalhedn5FTl2cAMTAuQmYU+LSEDkkB5LGWO9Y6/8cEwPvwOU60oID
         oiW4dBIvlJoB6dmVV0biKGwWAO1UH5U27VoH/qbLXNb8ssZeg+iuT/1LAkqaDQtZzf/n
         1m0sBGydrIz0Zr/XU5/Gfl+QX7M93A/JrmTAHmU1NdxAsNKJC7CF/KaOo5svp390iAqd
         AOJy/1nrQllCucwvXkDiFe1xb3wbwX+/wzo04i9ATZCYV5MRmPuVoCFnpribqtoorfmZ
         nlyMKM6ClzQF/mfGFSyk7IIG4DpcTkl1yJ85bYw8JAfrsK50RnYaan1zPet/960/kSjM
         q/zA==
X-Forwarded-Encrypted: i=1; AJvYcCWdn8k7a/IXuzYZjmB0k7c8Fz4SlxL+BuGfRgZpkwqrFMQdoY71018Z/SfVeaFh/uBmtXNxDPpj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93fiE5NAAmB6bTVct+jqPM6aVsXFXfjj+6sntd1NSM1j00n05
	tYaxjcGY968HLIzhIzyJqaV1o19JYtNNGEYAKpwvNp2J2CL1dmmW9jsNP7bGtBQ=
X-Gm-Gg: ASbGncs36+nFVjHYPFgWpEUx/Q/smxxz1rHpQGvJOvUhKBNDV0JhZLZ9FdPsJzFinfn
	7xXHQayGdVHou3EyVQz1tQV3fi1MmMExAYuteXHJDDQjTunyeKT6px7YaTjGKui5lv2CyzZeDKE
	nxPnKJVZ+VsVRSCyR81ALUE3Pt0Fzlw50vfuXUZhsloOY7MtUkqUOZ/RNGqNIHPMytaY2jpz6LI
	29daWAUH9mJhFOSp5DDt1pF/pKbHfMQZHX9k1rytWxM499rEs3yqhEu8w2vBD1S3p3SoRGWjOGm
	UCidJ2/lkIsRkpSjlw==
X-Google-Smtp-Source: AGHT+IEcJnDN7OyY4JFBguUKcLFVGFjVNtkB7wXSfnIUxmCyBN3PrLsgzDawFD8pqHavqueW1oz+Kw==
X-Received: by 2002:a5d:5f4d:0:b0:386:256c:8e59 with SMTP id ffacd0b85a97d-38c519378damr9845345f8f.3.1738316020544;
        Fri, 31 Jan 2025 01:33:40 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b576csm4227208f8f.63.2025.01.31.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 01:33:40 -0800 (PST)
Date: Fri, 31 Jan 2025 10:33:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: fix race between fork and cgroup.kill
Message-ID: <nsh73lyuoctjbeudj7o35jrkcygnfehhwj5dbf4u3hdvawx54v@nz6l2v5q2iin>
References: <20250131000542.1394856-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtbw32lzcqctsvga"
Content-Disposition: inline
In-Reply-To: <20250131000542.1394856-1-shakeel.butt@linux.dev>


--jtbw32lzcqctsvga
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: fix race between fork and cgroup.kill
MIME-Version: 1.0

On Thu, Jan 30, 2025 at 04:05:42PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> @@ -6668,6 +6668,7 @@ void cgroup_post_fork(struct task_struct *child,
>  		      struct kernel_clone_args *kargs)
>  	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
>  {
> +	unsigned int cgrp_kill_seq =3D 0;

This initialization is only needed for the extra "init tasks" branch
(the value should equal to whatever init_css_set.dfl_cgroup has, i.e.
0).

>  	unsigned long cgrp_flags =3D 0;
>  	bool kill =3D false;
>  	struct cgroup_subsys *ss;
> @@ -6681,10 +6682,13 @@ void cgroup_post_fork(struct task_struct *child,
> =20
>  	/* init tasks are special, only link regular threads */
>  	if (likely(child->pid)) {
> -		if (kargs->cgrp)
> +		if (kargs->cgrp) {
>  			cgrp_flags =3D kargs->cgrp->flags;
> -		else
> +			cgrp_kill_seq =3D kargs->cgrp->kill_seq;
> +		} else {

This should not be strictly necessary thanks to cgroup_mutex during
cgroup_kill and CLONE_INTO_CGROUP.

>  			cgrp_flags =3D cset->dfl_cgrp->flags;
> +			cgrp_kill_seq =3D cset->dfl_cgrp->kill_seq;
> +		}
> =20
>  		WARN_ON_ONCE(!list_empty(&child->cg_list));
>  		cset->nr_tasks++;
> @@ -6719,7 +6723,7 @@ void cgroup_post_fork(struct task_struct *child,
>  		 * child down right after we finished preparing it for
>  		 * userspace.
>  		 */
> -		kill =3D test_bit(CGRP_KILL, &cgrp_flags);
> +		kill =3D kargs->kill_seq !=3D cgrp_kill_seq;
>  	}
> =20
>  	spin_unlock_irq(&css_set_lock);

The above are only notes for better understanding, I don't think the fix
needs changes in that regard. Thanks

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--jtbw32lzcqctsvga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5yY8AAKCRAt3Wney77B
SQxPAQC1JHFXydeDfUZtGe+DtusOXERhm1syeRw5oNET0yL2XAD+Nf/iWTkBn4wg
b3rL3A7T9sHALkkSEQ1pjPSeNQRmrgY=
=Wonb
-----END PGP SIGNATURE-----

--jtbw32lzcqctsvga--

