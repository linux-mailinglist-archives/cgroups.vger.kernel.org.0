Return-Path: <cgroups+bounces-7223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C832A6E1C9
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 18:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4605189851E
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D426461F;
	Mon, 24 Mar 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YRnpGDQU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A5264624
	for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838488; cv=none; b=cS+iQVnabSxg3WKZtenrsH1er0LsIi4WhdzqxG7O8gqMp9jevimYWI7VjMW5IIF82uCMC2rcZacPcMc4arfde4iTEOjV1Q48sV4SHPQxm2zMY3jgSx4vu4pc27u2PG2+iiUgcNEdrJZYqABM2QA+ks+d7uVKtGhfw2QHDJAMdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838488; c=relaxed/simple;
	bh=x8Xd7TcAuYFexT0KmQseGSnMp/bI8usj5EVDZJXvlkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2SdayHDPA3pry8sZW2cQFBMZz93jg7oyC9gXJEGE1T0AeU17PWBphbemfliiwJrT53247kC9I2QKPa9L5q5nQpyTf77peHwX6nRdJv4/Vf2I9K8YBToWwjWRrsltRW/HKRivY2om4gxiaW6an933IFNPCiYiGeC66e5S32D+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YRnpGDQU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso21463855e9.3
        for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742838484; x=1743443284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/iivi4IReVWYmwVNehv3u9PvixYASh+cW9mV7NVv4E=;
        b=YRnpGDQUL1mizZGI1qrcbU4P+ck06yo4JGpruhdHOKx5HMzuH5PJnnHZcPjJg6kMhs
         pHhclNZKCHuA0ylxDn4kwaot9sdKuSYTqk+lo1NJbuW4ivf4UeTRyXdWlPhrM9yJjmnm
         TTIGLM5wOPozFQ04oREKnlqpP9IgzJcFfVo9+Kl81Lm0b6Uzz00c5CfBA3VkcWUVW6ho
         8Mo3knKS0LgpkEGd/lF2xZlDVAuervg0eb02iqEp50wBMnWpk7yYhmWUd6qwxp3l1t3G
         +enI06odRatwa+lpC05+jbiGCxBKykeAiKZRlnaB1aOoacSPeLDAoCGkYmReqCeciQt1
         l67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838484; x=1743443284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/iivi4IReVWYmwVNehv3u9PvixYASh+cW9mV7NVv4E=;
        b=fSsAWPREHS9QWZEoAh21qpgObLRGH65UM2h50ih7Gj4J3yfAYXmI/WnrGOGzFsxhN4
         htGW0ijvr7l228SPzjj1WiilImmcrzn+Vh34pt/zh/O88e44h8O4dSG+A3BO7c/A6dK7
         GQt2oNzWpp/4yWBsG4ASQnLAUBgYQEoYg8D8PeeJfvYvVCk+ynreAdIKLRFFJHAOszzj
         7+ckAY6tXCC/e/HechMWE0KR3rVemf+cbR4I+FTg1+p8dF3U7SPjuI33jrmyIX84RhW2
         RddRs4ig9E7vyZggGoCUOMYnrh/6Fubniz0Z1m2U2cnlPOR6Y5TKUJ5RT10rfSLLGXpE
         EbFg==
X-Forwarded-Encrypted: i=1; AJvYcCUPbvtjif8gSXJc7eDKmsyanSTF7ovmA+/HbSzLEG6aDS727VGJUAoP/QAYNhgXYfGgwwULnteV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+PUnbU6ElQeOhJgCP/AiBIL3UNvs0YKc+vpDb8IibMZkPH5i
	gQ8rYFK+B2pBcPrIj+pad/TCBqpjxbhdt5hh1vcpASz2fOJS1SA7dF92NGf+Tcc=
X-Gm-Gg: ASbGncvW1KMAd3+kyXTYILrV9WZOe9t7fuLieZeW2Gimjhh/TqbWMn433rkv8oHTHT6
	GD3ynoiffnsOcB/OqEPe/jRf+ZgA+atq03ccmrDC61HTV6Lpdv63cH+27Dwz+VWX4O6c8eXDXbA
	fh5eLAsR9wa96q2xhOwpMrBY/lojnSAYM67NTQ9bs7LVNH8yIUJ4cSrbtNHkHkHYXKYzVzxKOoo
	up45NCiHLBp+tfBqXgSFkp1LnOrFkNkmlG7Z86GV1HcTKbkJpGsbyWtowCi5al4NU0MD8HnuSmb
	MS2bKo7HexLVd2uq9Qc9HFZDAV1L+4BVM0tVWAXR6ODkO6Q=
X-Google-Smtp-Source: AGHT+IFq2OWbDN0VDKe6dxJ/5hKnNsuOPodW587cuYJsSJqE9sOupt9Mw2DZ2TerpViAf0fJkvB2VA==
X-Received: by 2002:a05:600c:1989:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-43d50873c28mr121472035e9.0.1742838483624;
        Mon, 24 Mar 2025 10:48:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd18621sm129426465e9.12.2025.03.24.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:48:03 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:48:01 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/4 v3] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <lkrhbbdiuymh555eaibf3ziifi2dtx467buysiya77uuz4e22m@d27xvpj5l6o3>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uo6755wetz5yix27"
Content-Disposition: inline
In-Reply-To: <20250319222150.71813-3-inwardvessel@gmail.com>


--uo6755wetz5yix27
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4 v3] cgroup: use separate rstat trees for each
 subsystem
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 03:21:48PM -0700, JP Kobryn <inwardvessel@gmail.com=
> wrote:
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -161,10 +161,12 @@ static struct static_key_true *cgroup_subsys_on_dfl=
_key[] =3D {
>  };
>  #undef SUBSYS
> =20
> -static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
> +static DEFINE_PER_CPU(struct css_rstat_cpu, root_self_rstat_cpu);

root_base_rstat_cpu
cgrp_dfl_root_base_rstat_cpu

(not a big deal, it's only referenced once next to definition)

> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
=2E..
> -static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
> -						 struct cgroup *child, int cpu)
> +static struct cgroup_subsys_state *cgroup_rstat_push_children(
> +		struct cgroup_subsys_state *head,
> +		struct cgroup_subsys_state *child, int cpu)

Forgotten rename?

> diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/to=
ols/testing/selftests/bpf/progs/btf_type_tag_percpu.c
> index 38f78d9345de..f362f7d41b9e 100644
> --- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
> +++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
> @@ -45,7 +45,7 @@ int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_=
tag_2 *arg)
>  SEC("tp_btf/cgroup_mkdir")
>  int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
>  {
> -       g =3D (__u64)cgrp->rstat_cpu->updated_children;
> +       g =3D (__u64)cgrp->self.rstat_cpu->updated_children;
>         return 0;
>  }

There are also some comments above needing an update.


Michal

--uo6755wetz5yix27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+GazwAKCRAt3Wney77B
SVhXAP4z12Zh/dNNDSm1avF6MFhShIyCd6WfB7mEgr4Rk9uQLAD/ShgqnWpUdSbj
qHh6FyfWS0LwtJaXCYuV0o6kcDDj4AQ=
=n5p+
-----END PGP SIGNATURE-----

--uo6755wetz5yix27--

