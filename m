Return-Path: <cgroups+bounces-1389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78FB84CDFF
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 16:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65082288E7B
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B257F474;
	Wed,  7 Feb 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iHJI7Px6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iHJI7Px6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1B7F7F5;
	Wed,  7 Feb 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319709; cv=none; b=KV0NK+bQIenyGmsJzbLiMt1JpCnjRn9IAuNCKjyJhQp6IOfZum4/E7O1PutSmRtlClmQWktQJ9Xtxu0B2N9u1k9ua6IA6xCMJBGpUNypkE5z701lFIbN5Ul1a28wYCI7dUzwJqLl+M9FNnnDR2cJSgQoQ1jac0JDks5i0jnGMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319709; c=relaxed/simple;
	bh=PH7J5Ybjdewooxyy87hpCE5cUc+0UVOaPPRJadXyBqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5EmA7zibNCzfQjyW+XpyQCSzvRJUIofEs/dxzeN/dpWI8y/JsUSrDLwu2ihweNvMr3Ho9mok2Sc+wwB9FdwBlSW3G635UouaKzlDICgbhyVeB5mQCMOg7GWHATqquIL4gfnHx/cAYNlCDqXwuS3yNnWGdGluIyAMy7LLRZxjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iHJI7Px6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iHJI7Px6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84B441F78D;
	Wed,  7 Feb 2024 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707319705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0otgvNBb5KzjRCm8rrIOZU3r4HHRV/yk8Qfy0AQY/sk=;
	b=iHJI7Px6VMDyc9rNu9eZ6ZCRJb6Jbq6e1Ey8E7XA07Tt06+5agi3al/a/Aw2j+gCYaV5z+
	vcCdbjAxT9mxbywgCjlI/BX54JcWfXWbrdrRAcQSQe1HGKsM4Qby8kaK1FX/ChLGB/KhG7
	NjbflrpgVNLGrtxwWlNulz94PyoSvWI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707319705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0otgvNBb5KzjRCm8rrIOZU3r4HHRV/yk8Qfy0AQY/sk=;
	b=iHJI7Px6VMDyc9rNu9eZ6ZCRJb6Jbq6e1Ey8E7XA07Tt06+5agi3al/a/Aw2j+gCYaV5z+
	vcCdbjAxT9mxbywgCjlI/BX54JcWfXWbrdrRAcQSQe1HGKsM4Qby8kaK1FX/ChLGB/KhG7
	NjbflrpgVNLGrtxwWlNulz94PyoSvWI=
Date: Wed, 7 Feb 2024 16:28:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Rob Clark <robdclark@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, 
	"T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Brian Welty <brian.welty@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC 1/8] cgroup: Add the DRM cgroup controller
Message-ID: <7oxj33pfscydm6vgdpl5vppxbx5htqg6rjfyd7qyg27p3bu2gk@wzl3x3dgurom>
References: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
 <20231024160727.282960-2-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wkez2ktgloibqzk"
Content-Disposition: inline
In-Reply-To: <20231024160727.282960-2-tvrtko.ursulin@linux.intel.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.24 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLo1h4tb73ac66wms7hnks9h9b)];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-1.54)[92.03%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.24


--4wkez2ktgloibqzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Oct 24, 2023 at 05:07:20PM +0100, Tvrtko Ursulin <tvrtko.ursulin@li=
nux.intel.com> wrote:
> +struct drm_cgroup_state {
> +	struct cgroup_subsys_state css;
> +};
> +
> +struct drm_root_cgroup_state {
> +	struct drm_cgroup_state drmcs;
> +};
> +
> +static struct drm_root_cgroup_state root_drmcs;

Special struct type for root state is uncommon.
Have=20
struct drm_cgroup_state root_drmcs;
and possible future members can be global state variables.


> +static void drmcs_free(struct cgroup_subsys_state *css)
> +{
> +	struct drm_cgroup_state *drmcs =3D css_to_drmcs(css);
> +
> +	if (drmcs !=3D &root_drmcs.drmcs)
> +		kfree(drmcs);
> +}

I think it can be relied on root cgroup not being ever free'd by cgroup
core.

Michal

--4wkez2ktgloibqzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZcOhlgAKCRAGvrMr/1gc
jg8GAP4xhzIzp4cw/OdmjqaWeXT/ZMnZB9xNkDvNSnu+1WrU+wEA2fJ/0eG7EwFX
DwMdO1kNXwAxmU9NGjHLMO6Fd2AxegQ=
=50vt
-----END PGP SIGNATURE-----

--4wkez2ktgloibqzk--

