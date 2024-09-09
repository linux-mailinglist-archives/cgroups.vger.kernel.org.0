Return-Path: <cgroups+bounces-4775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6089972246
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73012B22DE0
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C71898E0;
	Mon,  9 Sep 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QzjylISA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8A189531
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908520; cv=none; b=PDABQyUy7OFVOFk6zdgP7vZ0f+zg/f+DPG/31kTqWyGQTVyzSmqJjnaXrVFF7sS9Xwh99SuuzW39H4TVA6wcnPJrRFqH/JDgr7TyGonRCzWBb+WvljmF53mCiWnyPMqnmbKYWV7BfYFSrNu+7XRB63fMEuZhJWxILWjhPybRLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908520; c=relaxed/simple;
	bh=UUWKqD8lriEdS8wZdH79VyocGcpjNV/3c+Z1gw2ZAVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxNU13XqtaAz2Nzpw9ajTV4CjpPbAZyPDqB1SO6ALSmxKFaxZejHy6L4iXrFc0pbd5idwYODw+z7fudeteRZYFDGFHF+GzAxVcfh8euL5+mrPwRwhxd2qDi1a9pWEYuTkkldL5NQ2l5DIAh4nHyC9d8lDCgIgqFdXU73Gt0drMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QzjylISA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e1915e18so40435505e9.1
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725908516; x=1726513316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwbNU2x4QPfAS3MGCVrGiN68ie1CP+a7m8Muz5lyEEE=;
        b=QzjylISAMb2tXtRPoxUBAC9WvG4gQJnVt4LAlEx2GIbONQ8NA2FktjvtNZoBf71Pm5
         xpWU1ppjU5lTzFvU78iyDtvgDAqiV0BmAa2dml0pcxiN9Ys/I/U9BnadNWNP7OHwE4Pg
         fjiP9YmGRpfQ3y2EJURuS5HvXnbhj8mYqyN2OczOQ0mQsTWKULMfVxJBBUzD7qWvplyg
         t0TkCaAvixxBS87pgEhIIvEvqIB8QOURCG0GgbxIlOqTEHxFnOcgehRXRfF+kYjmHmFM
         6wKsMrTAZvW5SJ2lES6pB4dou+8lQIZ/U4GIprL7g2vLI+rI1RKRjrTetpfWJakOpUml
         SWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908516; x=1726513316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwbNU2x4QPfAS3MGCVrGiN68ie1CP+a7m8Muz5lyEEE=;
        b=G9dpfABvCcLzri13PvOvyCKbMVJcV549eaHDU6ml9uVM9XkFcOiBvVbduiODSM12B5
         SV2kpckqXzcuU/985059g0MAoBJ0WbCB53yYGWqEsvfu210gYcw+obCv0VYgZcX0HlQf
         ExFKWornasOBaLDoLYS8HHBqsoiyr34VyhTXXR/H6PfUkX4L9lgnCLwGgpudB2cLmBW2
         u6LMOGboCRaYrlm3FQWK3xfMLSHdDTIDT5a1+DXndbLe/AQiLTFXy4/XRbPLm2V9jH5c
         oK0uMon7phIekT27r/yrk4559pSwJ/xQMP+TfNU+7zLvScoL8ZTSVcSBLdjNPRqYIu9u
         l9jg==
X-Forwarded-Encrypted: i=1; AJvYcCXewG6lUbWapRKdcQZX+EAuFacnvHA6fIfk4TGcPtvzL+LYlox2KQJnejMnUvNzuxilR9+B6qUS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/wv7SbTeXLzKC4/5nrXoT9GE7znfdPDJqvVWlV4K/mCXBqR0
	77k303xSyE5yl6KmBWn+0972JQmhDwtiDG3xxfQ/Sd7YIale4MoRe4UGoiCvZ38=
X-Google-Smtp-Source: AGHT+IGicLwywVtqmrNHcKbpRNCT4u9ynzQ+I5hc7ApdqEpOBOxM4NumiNZt27caMDAfOs/lvK6IUA==
X-Received: by 2002:a05:600c:3b98:b0:42c:baf9:beed with SMTP id 5b1f17b1804b1-42cbaf9c1edmr16934255e9.27.1725908516429;
        Mon, 09 Sep 2024 12:01:56 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956650fdsm6740503f8f.25.2024.09.09.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:01:55 -0700 (PDT)
Date: Mon, 9 Sep 2024 21:01:54 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v1 -next 1/3] cgroup/freezer: Reduce redundant traversal
 for cgroup_freeze
Message-ID: <quuw3s2y47l74ge54a43yjeaeoofqwg6ozofb3nwgvn55oj55p@o7bb5yrhvbj2>
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="we2v5fu7yb44atvh"
Content-Disposition: inline
In-Reply-To: <20240905134130.1176443-2-chenridong@huawei.com>


--we2v5fu7yb44atvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 01:41:28PM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> Whether a cgroup is frozen is determined solely by whether it is set to
> to be frozen and whether its parent is frozen. Currently, when is cgroup
> is frozen or unfrozen, it iterates through the entire subtree to freeze
> or unfreeze its descentdants.=20

It's more to maintain the numeric freeze "layers".

> However, this is unesessary for a cgroup that does not change its
> effective frozen status.

True.

> +static inline void cgroup_update_efreeze(struct cgroup *cgrp)
> +{
> +	struct cgroup *parent =3D cgroup_parent(cgrp);
> +	bool p_e =3D false;
> +
> +	if (parent)
> +		p_e =3D parent->freezer.e_freeze;
> +
> +	cgrp->freezer.e_freeze =3D cgrp->freezer.freeze | p_e;

Better be || on bools

I'd open code this inside the loop of cgroup_freeze since it is not
context-less function and it relies on top-down processing.

Root cgrp cannot be frozen. You can bail out early in the beginning of
cgroup_freeze() (possibly with a WARN_ON) and then assume parent is
always valid when iterating.

I think maintaining the e_freeze in this "saturated arithmetic" form is
a sensible change.

Thanks,
Michal

--we2v5fu7yb44atvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt9GHwAKCRAt3Wney77B
SZ9TAP43zQDtXIDM4IACasv4ofnkznamTnG5TI1ddulHOQngcQEAja7a8e506jo7
5UnApJEhT6UGFQbcm+uF+DZsfohhYg0=
=HzgX
-----END PGP SIGNATURE-----

--we2v5fu7yb44atvh--

