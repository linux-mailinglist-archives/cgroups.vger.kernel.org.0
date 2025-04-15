Return-Path: <cgroups+bounces-7582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11383A8A522
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA743AC4BD
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A119E967;
	Tue, 15 Apr 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BUNFvunA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C41422AB
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737351; cv=none; b=Lyu3kmjdOXwdcVRFGYjkf3KsD723sK+hYS7MhdSOWif9OLGPPVDBfoONKmxDWAYQc7lDrwWU+Yi4FfM3tD5Det+j8IHSH686jYJOL43fRqBXwr1HNyPTRoIKUQ74WZ43xhIahw8/SDiWrW8PhsoQz2W9KwxmKu/7J77cpLlBZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737351; c=relaxed/simple;
	bh=5wPPGolptxcr67kmWWt6dCnYtrk5o2IkDb+v1i54egs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw/3lJJFY1O+JLUMkvXN5CG3qNSZSVhoLrxeNvvmMQY3Nuqwg0FvF5K3KjavQkE2DbYT4Rrd5DqWKJvIfPGyNavkkd7pjhmdAra1lZyIrlKgPILfjMuTjI4mhOth28BksS0vbuZMkxMnd7st/uTOawKz6VkOrVGMasV6OPH7pBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BUNFvunA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c14016868so5393152f8f.1
        for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744737347; x=1745342147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JyKYwEYcJ4/dTWg3WGVRIKX7PyHNNzlpyn8DZMXNLU=;
        b=BUNFvunARU/VJynrdlC4Rl/KYcT7Ka9UkrJ1Wwx7qUynK38kB0AgrXxF9uALrtY6dt
         0limWLh3R7bivmp11xJkjKBZN04p6w61TmTH9dd3IjKt+U69+0aZMAiiVodpNltmeWzv
         ZtjarZOuElW+qiAbW0k3GzI1MBXDSuSxv00eY41YE/uIgb6elJWD8aefDi7q7lCcpR4U
         pXNYGsXh50dAAh0JP75idJrH0Am0BwckTEZh+U9a9ufqkIsr+uk0nKWV660S5sQU2toa
         saL7yxKYffdkUGQEVJCTmwfPL49+DD/wy+1LwR5w52DRt88djBew5ksrxEcZE566PjVp
         DpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737347; x=1745342147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JyKYwEYcJ4/dTWg3WGVRIKX7PyHNNzlpyn8DZMXNLU=;
        b=pEYO6sMi23H65YX3++NL7MdsFncTz8kORU8Y4lK84ilqwLr90KB8yzamitQGA/BobN
         SUovzKhTlUAeRdd/cIO1ANpZhqNLCCgbAWtwQyqpSu2zqxB4NNtc0F0LCybbnLqKU0tq
         DxA0as+whp8ybeNjGCZrxWyfvAsbz+2RVtRStotaXw2MDYalm7oaqYMuvhIUBBKVo97b
         ofsVjjgQ+8VlPV/FJkvPDE44RdIehvpAzIWDNzWyDK631CUI50HhUwlQiJyng8bopRjy
         MVwbLY3r3snSSn2T0cBwMjM5Nv54uCeV8MzW0VbWln/8TEbOVE5spUn+RHhxx8/wLzAt
         BO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxHQXTByBDeHHVOX8SNU9snOhOWAIhG/v38KeQbl2yK0IlxUXA17FE56FVGbRcjeSyLWD/q93e@vger.kernel.org
X-Gm-Message-State: AOJu0YyZeDLqLDG8yNNbAjjukaum4Zwtxbyxf5BHECLEv+l6CvBzBIlN
	+ktH+u5w8S0afKVP2AgVw1BA7Zn7nyH4Aw6VfAjahJWVu2TknKpDKUoxkgwKODA=
X-Gm-Gg: ASbGnctp8yWe1iw/I6FZeyjUwvPzqkh5a1QDaUNWxYIYVo9dQF6DPhXUM4hPElpsow6
	xD7yjVSxFsOf8Q/iod+yFMi7lVrEU6qnQpqitF9EUQELA7o6G3pG5Hk+Xf1AoKQBH3dvi5McX7v
	nuQUsKe6+CK0ar+iKq8jgyDjFEmyt6SMM18B4DaFWo9kxc6i908jZxkCL/Mzfmw8ydAE86b5SHr
	pSKrtz48RjdjjK/5/qGH/SjjGaHZoUFRlX6YgdG4vdRF/h8NB9Xb5092YKJdhQ6QrNE3fxIPw9m
	gcwBCQnw2JqbEVD4mRL+EWJBxMSYmPAZLUyvSZzUBno=
X-Google-Smtp-Source: AGHT+IEug3noF7TDDxvScRmm08BUgJDWetNXWEt+gsO9BPiipq7mHBr4P9Dqj0LFuIisoG9oaUpmeQ==
X-Received: by 2002:a5d:598e:0:b0:39e:cbf2:4344 with SMTP id ffacd0b85a97d-39ee2738765mr257790f8f.4.1744737347078;
        Tue, 15 Apr 2025 10:15:47 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8219sm213001185e9.21.2025.04.15.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:15:46 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:15:45 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <2llytbsvkathgttzutwmrm2zwajls74p4eixxx3jyncawe5jfe@og3vps4y2tnc>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyiutkqthgkq6eto"
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-5-inwardvessel@gmail.com>


--oyiutkqthgkq6eto
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
MIME-Version: 1.0

On Thu, Apr 03, 2025 at 06:10:49PM -0700, JP Kobryn <inwardvessel@gmail.com=
> wrote:
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
=2E..
> @@ -5425,6 +5417,9 @@ static void css_free_rwork_fn(struct work_struct *w=
ork)
>  		struct cgroup_subsys_state *parent =3D css->parent;
>  		int id =3D css->id;
> =20
> +		if (ss->css_rstat_flush)
> +			css_rstat_exit(css);
> +

It should be safe to call this unguarded (see also my comment below at
css_rstat_flush()).

>  		ss->css_free(css);
>  		cgroup_idr_remove(&ss->css_idr, id);
>  		cgroup_put(cgrp);
> @@ -5477,11 +5472,8 @@ static void css_release_work_fn(struct work_struct=
 *work)
>  	if (ss) {
>  		struct cgroup *parent_cgrp;
> =20
> -		/* css release path */
> -		if (!list_empty(&css->rstat_css_node)) {
> +		if (ss->css_rstat_flush)
>  			css_rstat_flush(css);
> -			list_del_rcu(&css->rstat_css_node);
> -		}

Ditto.

>  __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>  {
> -	struct cgroup *cgrp =3D css->cgroup;
>  	int cpu;
> =20
>  	might_sleep();
>  	for_each_possible_cpu(cpu) {
> -		struct cgroup *pos;
> +		struct cgroup_subsys_state *pos;
> =20
>  		/* Reacquire for each CPU to avoid disabling IRQs too long */
>  		__css_rstat_lock(css, cpu);
> -		pos =3D cgroup_rstat_updated_list(cgrp, cpu);
> +		pos =3D css_rstat_updated_list(css, cpu);
>  		for (; pos; pos =3D pos->rstat_flush_next) {
> -			struct cgroup_subsys_state *css;
> -
> -			cgroup_base_stat_flush(pos, cpu);
> -			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
> -
> -			rcu_read_lock();
> -			list_for_each_entry_rcu(css, &pos->rstat_css_list,
> -						rstat_css_node)
> +			if (css_is_cgroup(pos)) {
> +				cgroup_base_stat_flush(pos->cgroup, cpu);
> +				bpf_rstat_flush(pos->cgroup,
> +						cgroup_parent(pos->cgroup), cpu);
> +			} else if (pos->ss->css_rstat_flush)
>  				css->ss->css_rstat_flush(css, cpu);

These conditions -- css_is_cgroup(pos) and pos->ss->css_rstat_flush
should be invariant wrt pos in the split tree, right?
It's a =CE=BCoptimization but may be worth checking only once before
processing the update tree?


> -			rcu_read_unlock();
>  		}
>  		__css_rstat_unlock(css, cpu);
>  		if (!cond_resched())
> @@ -362,29 +359,38 @@ int css_rstat_init(struct cgroup_subsys_state *css)
>  	struct cgroup *cgrp =3D css->cgroup;
>  	int cpu;
> =20
> -	/* the root cgrp has rstat_cpu preallocated */
> -	if (!cgrp->rstat_cpu) {
> -		cgrp->rstat_cpu =3D alloc_percpu(struct cgroup_rstat_cpu);
> -		if (!cgrp->rstat_cpu)
> -			return -ENOMEM;
> +	/* the root cgrp has rstat_base_cpu preallocated */
> +	if (css_is_cgroup(css)) {
> +		if (!cgrp->rstat_base_cpu) {
> +			cgrp->rstat_base_cpu =3D alloc_percpu(struct cgroup_rstat_base_cpu);
> +			if (!cgrp->rstat_base_cpu)
> +				return -ENOMEM;
> +		}
>  	}
> =20
> -	if (!cgrp->rstat_base_cpu) {
> -		cgrp->rstat_base_cpu =3D alloc_percpu(struct cgroup_rstat_base_cpu);
> -		if (!cgrp->rstat_cpu) {
> -			free_percpu(cgrp->rstat_cpu);

Thanks,
Michal

--oyiutkqthgkq6eto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/6UPwAKCRAt3Wney77B
SXhvAP0fYzrGyul0zdsk2AKaVbEw2YFY/B409kj7aoFfU71UoQEAodZjuutxz63K
x2A8PjL6VQ2o4thy8TkQqKpYLJYE6g8=
=56Oo
-----END PGP SIGNATURE-----

--oyiutkqthgkq6eto--

