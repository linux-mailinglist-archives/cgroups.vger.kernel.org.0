Return-Path: <cgroups+bounces-756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E880034A
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 06:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23F6B210F4
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009448BFD;
	Fri,  1 Dec 2023 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXnoOuFB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE85C1734;
	Thu, 30 Nov 2023 21:48:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d03bcf27e9so1682745ad.0;
        Thu, 30 Nov 2023 21:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701409737; x=1702014537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZbnJURuf0YnsoB4uScWxuFhK6jg2U0wRIA3IoSThz8=;
        b=PXnoOuFB3awpRWChL3Jgs+16RjqeshglPwp+iNSuCgPSivP7rslQ8FnXWyu7Gu6p2Q
         NR3HbyaWJKebGrP9WlQJroqCQ5B0aPJK7LJGgBBnCm3DM5LI7hcwHdBtB+ygIbhWc/+V
         X7yK1RcFZHTcIfUk3x3PTFsf+13uKK6JZEHwfBedpYmDgAGBbnBNfIWez4MuDCg+/Zmt
         yeImHzppCKLZ5BJXTPztEUIBFh409w1LN3i3H+R7P7FjHaK9CfqoraGFeEDDlNznKRVO
         uN4zpgJLx4uhAEhCmJTth7x+MZ96IxsPVcC8cmDIChwsF2oH1nXYFT8yT1v2NK0GrpK/
         gfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701409737; x=1702014537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZbnJURuf0YnsoB4uScWxuFhK6jg2U0wRIA3IoSThz8=;
        b=ubPdTGZij0I7uw2LfUdaijIfdK0+W+3+tIyrrJb31pC9eVyHKcaF05C27JT4ZP9t8s
         lAw3yCOMTX/IaqWFVZC4Dsv7uczKtZ4opO+mTDweZNIAlsksZWagY6fzFc87tNCtH8DK
         +7Be6uVUqcyqQe3zCID+HQbhY8PfTsx4LjrELTUViPxSfUeGNor+FKHJ8YRgDiOR50fQ
         rUDe/2v+GHHLPBjfJMjDCY2EY5WOUdkK2ip44TtnWQwuAfLXP6bfPpXUE52CfCyQHc4B
         pZGY7bo2d6AxwWr0PwtzQKBJFuHkGohILsM+CO884YGJZP7r/r7I+yOmE8lTfyppxAgB
         yLzA==
X-Gm-Message-State: AOJu0Yxa0meDDuHWG/jIt+/qBdUWJufvLKE5jTx0OIw3HZiDBTxJQJbZ
	I4Ji6CUmSUkHKP3c7Pst88Q=
X-Google-Smtp-Source: AGHT+IGZqlD0EmL3ZVck683sJvma02d++2s3GfxmJHMjTUkw5O7CYkyRj5MofR4ZpGBrs++rk2ndkg==
X-Received: by 2002:a17:90a:a407:b0:286:5811:2571 with SMTP id y7-20020a17090aa40700b0028658112571mr1018948pjp.0.1701409736984;
        Thu, 30 Nov 2023 21:48:56 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a348700b00280c285f878sm2508465pjb.55.2023.11.30.21.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 21:48:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 0CFE6100823C0; Fri,  1 Dec 2023 12:48:50 +0700 (WIB)
Date: Fri, 1 Dec 2023 12:48:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Josh Don <joshdon@google.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Linux CGroups <cgroups@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] cgroup: Fix documentation for cpu.idle
Message-ID: <ZWlzwnO7PcOWQ2q_@archie.me>
References: <20231201005203.309873-1-joshdon@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CCIfMmdnUlJnGiMR"
Content-Disposition: inline
In-Reply-To: <20231201005203.309873-1-joshdon@google.com>


--CCIfMmdnUlJnGiMR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:52:03PM -0800, Josh Don wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 3f85254f3cef..9debf02bcb39 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1093,7 +1093,11 @@ All time durations are in microseconds.
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default is "100".
> =20
> -	The weight in the range [1, 10000].
> +	For non idle groups (cpu.idle =3D 0), the weight is in the
> +	range [1, 10000].
> +
> +	If the cgroup has been configured to be SCHED_IDLE (cpu.idle =3D 1),
> +	then the weight will show as a 0.

This one LGTM.

> =20
>    cpu.weight.nice
>  	A read-write single value file which exists on non-root
> @@ -1157,6 +1161,16 @@ All time durations are in microseconds.
>          values similar to the sched_setattr(2). This maximum utilization
>          value is used to clamp the task specific maximum utilization cla=
mp.
> =20
> +  cpu.idle
> +	A read-write single value file which exists on non-root cgroups.
> +	The default is 0.
> +
> +	This is the cgroup analog of the per-task SCHED_IDLE sched policy.
"... cgroup analogy to ..."
> +	Setting this value to a 1 will make the scheduling policy of the
> +	cgroup SCHED_IDLE. The threads inside the cgroup will retain their
> +	own relative priorities, but the cgroup itself will be treated as
> +	very low priority relative to its peers.
> +
> =20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--CCIfMmdnUlJnGiMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWlzvwAKCRD2uYlJVVFO
o/DQAP0bPgK2LiPMvZkW1bC1ur0ZYQb6pysH6EF0VG3CEwC6zwEAxtHE0k2WmUk3
XESJyv4hqDUe0jLIYGDVjuLeDf59JAU=
=TNFj
-----END PGP SIGNATURE-----

--CCIfMmdnUlJnGiMR--

