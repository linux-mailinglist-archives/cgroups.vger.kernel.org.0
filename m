Return-Path: <cgroups+bounces-4248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93B95173E
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 11:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF27B1F262A7
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FD213BC26;
	Wed, 14 Aug 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMsu0Hoq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFB6F2FD
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626021; cv=none; b=jmgSkCgVNuEWxa5TyctSfyfFEcrLM39l5DzdAgtsTYALT0UxkWquGrPqWqBWxEE6bGSLi04SY0qREXX2OJ/lkbYvQRItG18oWDfcn8BEd+H0JR8kpWu1/bgI3nNs6BfDyBSEMEFmjSb6IKD6kmEWt5wd7AapOXas1y9+LdLVhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626021; c=relaxed/simple;
	bh=k3PIOHirFFiAiTxdGmsgCjp8CS/hNFpTjCKvP+qzXSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0fxPt7tfQCGc/977uOs3dgE5IIODaBnH+PcdyxY5J1O0ajhj26Aexe6Mgy+5oN7ohWlerhADzzz4wtjoh28UkoafmSjyzCuTZkH77/3MTkChSzOoHCpF/kp4/v+fkO/sBl2Ww8L3Qf+xTxUWuO6J9PEcrLkq6PSPU714nlzKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMsu0Hoq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso47242805e9.0
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723626018; x=1724230818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYn3EAWwM4yksejs7G7ely3yb9R9FB21TAMqGrL5nTo=;
        b=VMsu0HoqfP3slTjkfe3oK36q5TCGCjlFAqCg86jba2+7mXF9N+Q4w1ab4Q04UmMniY
         eLj83GFpZkEZTQQNfsQoKnlfsv4agwLmJBTbIo2iQnd5r3ARzaBx2LYXv8Hov4GLKdr4
         wfKQ7TzqEjhBzuZOc8hlA1KqjhE+vcxN6NHxI3C5vNfHs5JSqbuVPlW6MdFaOMWO7uEl
         IZYBm3kJxbgGQwGcPxcvlWZwWxhPw4kkkk4WatAspBFn4GeewjLM3t6/1989qgp58Thg
         Zhd3ajBckXr5dbQcGnkizpWtD1hzEA5pFrN22m67BTD+AuOgPtHP674k/Oby/0uw7VkY
         gy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626018; x=1724230818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYn3EAWwM4yksejs7G7ely3yb9R9FB21TAMqGrL5nTo=;
        b=USzKPTpDJcn2DotADtogPXS2GjA4sAlZftGzoFloofLlhZ6aQmHMhmeO2YZ/TvExRf
         sNGtbu/dJiXoLjpAW2+N/9gAIOyUmZd0o0dv8N+v29VTzECbCQlf5nwL4DDsWzeOS4po
         tNyO2sbauX7CjG+FHVSeU7mvFYBrGxaW4Vg82gAyQmK7ls8fgfRaNdBbvFBB0SlKJZLx
         jnhKPq2yL85kX8ZRTm5fWjIVUs17mrXWX8pP9WBfuooKMBKb3oezln8xSZO1x3o4skKU
         JcaHvcaA2qA/nSJuFSrtA6ujwg2Ug8SuxPbwDDDa/wP9B1wp+Q3HfgU2C+3xfb/vC/vv
         quMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY0GbSh8iVCSmmuKQcyHMz26GrpTr5rt+drRawQ2jomm3qwIWpIXPO5E62HEpDm82w/rG2rkEGRBIvB4l2VE9m90zFlYoZzA==
X-Gm-Message-State: AOJu0Yz4UvLbBAF1gnvMiWtW8DUDRARCEXysknWFax1dVevWcb5FAgk9
	03jegS+MYWZ9EOel5nTe/DFNVbOo/AO3hP9JAYyWvqBOfjjiLLx8OBwQqh2P74g=
X-Google-Smtp-Source: AGHT+IEKFIA3xVyiHl0S4CHquhD9H7i4oMxDI2QtnLHMSqppM2exFdmcTZJI49EE5Eun1Fvk2Pc9IA==
X-Received: by 2002:a05:600c:4751:b0:426:6e8b:3dc5 with SMTP id 5b1f17b1804b1-429dd2674b8mr15872225e9.32.1723626017484;
        Wed, 14 Aug 2024 02:00:17 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded5c166sm13425345e9.46.2024.08.14.02.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:00:16 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:00:15 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH mm-unstable v2 1/5] cgroup: clarify css sibling linkage
 is protected by cgroup_mutex or RCU
Message-ID: <mh6fy7l44s34x3nz5u2rvp7qpc7bpt4ah4ruy5ixeuj3p6ggs3@2bbetdmdgjxt>
References: <20240813204716.842811-1-kinseyho@google.com>
 <20240813204716.842811-2-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4dnk2aszlbpflxkv"
Content-Disposition: inline
In-Reply-To: <20240813204716.842811-2-kinseyho@google.com>


--4dnk2aszlbpflxkv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:47:11PM GMT, Kinsey Ho <kinseyho@google.com> wro=
te:
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -172,7 +172,11 @@ struct cgroup_subsys_state {
>  	/* reference count - access via css_[try]get() and css_put() */
>  	struct percpu_ref refcnt;
> =20
> -	/* siblings list anchored at the parent's ->children */
> +	/*
> +	 * siblings list anchored at the parent's ->children
> +	 *
> +	 * linkage is protected by cgroup_mutex or RCU
> +	 */
>  	struct list_head sibling;
>  	struct list_head children;

Thanks, this is good.

> =20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 0a97cb2ef124..ece2316e2bca 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4602,8 +4602,9 @@ struct cgroup_subsys_state *css_next_child(struct c=
group_subsys_state *pos,
>   *
>   * While this function requires cgroup_mutex or RCU read locking, it
>   * doesn't require the whole traversal to be contained in a single criti=
cal
> - * section.  This function will return the correct next descendant as lo=
ng
> - * as both @pos and @root are accessible and @pos is a descendant of @ro=
ot.
> + * section. Additionally, it isn't necessary to hold onto a reference to=
 @pos.
> + * This function will return the correct next descendant as long as both=
 @pos
> + * and @root are accessible and @pos is a descendant of @root.
>   *
>   * If a subsystem synchronizes ->css_online() and the start of iteration=
, a
>   * css which finished ->css_online() is guaranteed to be visible in the
> @@ -4651,8 +4652,9 @@ EXPORT_SYMBOL_GPL(css_next_descendant_pre);
>   *
>   * While this function requires cgroup_mutex or RCU read locking, it
>   * doesn't require the whole traversal to be contained in a single criti=
cal
> - * section.  This function will return the correct rightmost descendant =
as
> - * long as @pos is accessible.
> + * section. Additionally, it isn't necessary to hold onto a reference to=
 @pos.
> + * This function will return the correct rightmost descendant as long as=
 @pos
> + * is accessible.
>   */
>  struct cgroup_subsys_state *
>  css_rightmost_descendant(struct cgroup_subsys_state *pos)
> @@ -4696,9 +4698,9 @@ css_leftmost_descendant(struct cgroup_subsys_state =
*pos)
>   *
>   * While this function requires cgroup_mutex or RCU read locking, it
>   * doesn't require the whole traversal to be contained in a single criti=
cal
> - * section.  This function will return the correct next descendant as lo=
ng
> - * as both @pos and @cgroup are accessible and @pos is a descendant of
> - * @cgroup.
> + * section. Additionally, it isn't necessary to hold onto a reference to=
 @pos.
> + * This function will return the correct next descendant as long as both=
 @pos
> + * and @cgroup are accessible and @pos is a descendant of @cgroup.
>   *
>   * If a subsystem synchronizes ->css_online() and the start of iteration=
, a
>   * css which finished ->css_online() is guaranteed to be visible in the

I'd say these comments are unnecessary given the functions have
cgroup_assert_mutex_or_rcu_locked() but if it helps overall
understanding in broader context, why not.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--4dnk2aszlbpflxkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrxyHAAKCRAt3Wney77B
Sf7iAP495CZoLwNsmRlK6GZnIO5bw5+Tz9MpJH0otiZdp9dsQAD9HYZ3QHSy7TNL
O0igPt3UhE8+G+NKHJC0Usreo2lbSAs=
=9Uke
-----END PGP SIGNATURE-----

--4dnk2aszlbpflxkv--

