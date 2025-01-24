Return-Path: <cgroups+bounces-6267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FC5A1B320
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 10:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E0D3A527C
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA021A43B;
	Fri, 24 Jan 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JvzjG+NR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8823A0
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712573; cv=none; b=FbWRcNj5GzkuT9QGvAN8Hq5MnRCWE31+hWwGgGgJXI4B/zawO4MJS6L0LJlgB1/qQL7wtjQL2tBNZ6WVb9zAyCmd0KbCOAW24xt9KL2SN9YnkT6a4deulzPp7MgVA0yyei+HxXBM9zif1ycLYrZVNsgcUHlJudjUKv5wX51Vka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712573; c=relaxed/simple;
	bh=1CR4frQOomj1twb3rqRDUii/z5dGsK8gkFJnYl05f7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE7XOgtmrFsH49zOyiINMVgKII4DOW/LaIxW1BLDJtVmio6lIpekApBz+oQtcvQNiOYIgd6Slf9o0bmP0ixwqLq5UBEeBcecV0P8cJfja0v5E0wqdD6YWjNZH098uT0d5Mqq/LW4viYQ+WfDpuG9NkMs+rITYLMGXrWMUXbxMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JvzjG+NR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43626213fffso19233735e9.1
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 01:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737712569; x=1738317369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFtaZY6ZZraVAs4Am9Vg5xV1oypKfUrqh6METYm11sk=;
        b=JvzjG+NRF3eR149ubfs1Cxq/7yZCQuM91yIUs/qraQH7ru9Gd6fD7gfrIXpc0HVPEs
         pyoz+prr1KxW4RTpuKvsSmDp0S/FdEaK3Pe1tg9tcDQs7sw9WZiK1OnuesorUQKvs3Uk
         f5Ors7OpkorqeZjW5TCzoVuHFBsMjwODuhDUrnLtCObnjfWpFCNrMOAp58r9j3T3IlKW
         oO1BzMc8hGQU3MMSkXQWgE17dZrVrTKM4SVox7tT0rCcsXPp/huHMVSqbIHr0OZ3qxiZ
         J/98GrviMte6wy/8zKMxOeK4OdHMG57dfn5NlmVZAb+pqJt7Fd5OIMRVaTp7PszdzpiC
         clWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712569; x=1738317369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFtaZY6ZZraVAs4Am9Vg5xV1oypKfUrqh6METYm11sk=;
        b=YN1a1yTvdQ2xzqWEzy+EcH+MK+KSIFb9Ao+WQjfIOHRVkk8SwsJQmW5485rw5Lr94T
         JBYaVScUfnHWPv5nM/E27HSNer5UmDG4HYjeESR5JPurJ1VjD1Gc8BfDY4APUnkdgL1W
         Lv0ApGHpC7B8sDFvVpb4x212jRuHcEj7SpVfXtGhPZQS12C3Mthi68IS+en8FKaDydYP
         ZX7rHraT5eya6PRJiIlwXgJdYrpUgK70GffxJoWMmtKVdFSQyR9l6Vt37KFBnZ8L+JA1
         nEErLJlWdRyQM8vfAS/qdZvSJxJokhhO0BKa5aeKCLK+rkW7PKRXFmAw22eWzNtkEDUz
         Moyg==
X-Forwarded-Encrypted: i=1; AJvYcCWRzYbTQvBIZxRCueBa9S0Uqdo99f1+sqFuU70o2KOokWyOaQOrrc1QA7rOavCiqkCW0wX8ddQk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/27oc9SQgqurp3OkMVsodgCtH1X1Luj7f30RdQA+URxjTNIhM
	FIGr3doBqnpdr5oCWjx+rOKlc+VGeBhjgE896r9K3BVLBXasgZLSFCM5B/GvWJw=
X-Gm-Gg: ASbGncsUZxC8cunfvPiggrIOeXHD278eoUg9pMSt6L5lUHnyKYQOe/G5emb5o+zqThz
	ayfXWIiS1Q6YsKxZbxdyd/8SayosEGLGw3U+21DVBT7wNOXUzHvdi6UAkZBylDhlGL7EvX0sFhh
	vME5OwlVftRtZYDPejJEbRUgQljvogBWVY45/5vR7vze+nXjFHNWBTj0gREqO6A3fSNZCAt4x90
	hnPkIJt64kA917qjDgpb6JcvS5g3v2c2aZ4nBouIq3VRJLutJllOMAMHG49r1sHlUNP2J5KJ1Nd
	l5HUkSUIZ8NVcY935g==
X-Google-Smtp-Source: AGHT+IGxpw5taskk35HLdhUeYYcYpfgCX2aqes5gSqbZ3vWLljthfE6j/dI9FbVrsv4Q3UQvxshbzw==
X-Received: by 2002:a05:600c:63ce:b0:437:c453:ff19 with SMTP id 5b1f17b1804b1-438bd0bd5eemr23052955e9.14.1737712569291;
        Fri, 24 Jan 2025 01:56:09 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507c59sm20351855e9.17.2025.01.24.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:56:08 -0800 (PST)
Date: Fri, 24 Jan 2025 10:56:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
Message-ID: <qu3jdiik2sfstey4ecxdojndkzb5gzblg37i76p43xccnotawl@jlbafrgjad2x>
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <ijjhmxsu5l7nvabyorzqxd5b5xml7eantom4wtgdwqeq7bmy73@cz7doxxi57ig>
 <4d6ccc9a-3db9-4d5b-87c9-267b659c2a1b@gmx.de>
 <oe3qgfb3jfzoacfh7efpvmuosravx5kra3ss67zqem6rbtctws@5dmmklctrg3x>
 <672de60e-5c10-406b-927c-7940d2fbc921@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hrt3edpenmuek2m"
Content-Disposition: inline
In-Reply-To: <672de60e-5c10-406b-927c-7940d2fbc921@gmx.de>


--6hrt3edpenmuek2m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
MIME-Version: 1.0

On Fri, Jan 17, 2025 at 08:02:55PM +0100, Friedrich Vock <friedrich.vock@gm=
x.de> wrote:
> Yeah, there are pools for the whole path between limit_pool and
> test_pool, but the issue is that we traverse the entire tree of cgroups,
> and we don't always stay on the path between limit_pool and test_pool
> (because we're iterating from the top down, and we don't know what the
> path is in that direction - so we just traverse the whole tree until we
> find test_pool).
>=20
> This means that we'll sometimes end up straying off-path - and there are
> no guarantees for which pools are present in the cgroups we visit there.
> These cgroups are the potentially problematic ones where the issue can
> happen.
>=20
> Ideally we could always stay on the path between limit_pool and
> test_pool, but this is hardly possible because we can only follow parent
> links (so bottom-up traversal) but for accurate protection calculation
> we need to traverse the path top-down.

Aha, thanks for bearing with me.

	css_foreach_descendant_pre(css, limit_pool->cs->css) {
		dmemcg_iter =3D container_of(css, struct dmemcg_state, css);

		struct dmem_cgroup_pool_state *found_pool =3D NULL;
		list_for_each_entry_rcu(pool, &dmemcg_iter->pools, css_node) {
			if (pool->region =3D=3D limit_pool->region) {
				found_pool =3D pool
				break;
			}
		}
		if (!found_pool)
			continue;

		page_counter_calculate_protection(
			climit, &found->cnt, true);
	}

Here I use (IMO) more idiomatic css_foreach_descendant_pre() instead and
I use the predicate based on ->region (correct?) to match pool's
devices.

Would that work as intended?

Michal

--6hrt3edpenmuek2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5NjtQAKCRAt3Wney77B
Sb9kAQDx2dXNJx0ji8l5wnSMZa+EVuGB9ub0rZlAyG+KV+9M2QD/d5JuUzDjSqnA
KJTKp7PQu58CspZeNoeZdl8PWueJHwQ=
=2rqU
-----END PGP SIGNATURE-----

--6hrt3edpenmuek2m--

