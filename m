Return-Path: <cgroups+bounces-8920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F2B14B83
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 11:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D6916C967
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16808217701;
	Tue, 29 Jul 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxiBp5yc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9C1A76BB
	for <cgroups@vger.kernel.org>; Tue, 29 Jul 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782156; cv=none; b=P0PK6n43vJ2JZ6awpYW4oo+/spfwaffsjIRthmiUm8ZK2dUR9zaRoqLbvaKFKcObCxTzlFGLRN5EslZTf6BVtLa1nxONR556e6U2UfDZ5RLLssugz0KBTc5pZnMCGo8S2tojgdOhoZPrRALZyuUHvYHA7Z3qs9rTaeVJrsMLcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782156; c=relaxed/simple;
	bh=qt58Gnd/lzcr1Ku8NCqo7aCR8cm6ZUzHGC/tvVv9LuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=optKvIyYHhfas4DOhZLdVWvmvtmx2Q8QkTfZwCYFpxH8QXNkcvNi0PSyfqFo4jB9P8aMJ1os9Sqs7TTgAh3Ao198i19RVS0lfVzBh74+t8Kd+1EqlZPfUk514TAgRWNWr7xmzvHfb2E+b2zOXT8VRtJR5HAqw/8qKy7IveMFB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cxiBp5yc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d3f72391so49542535e9.3
        for <cgroups@vger.kernel.org>; Tue, 29 Jul 2025 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753782153; x=1754386953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ef5rgY2lnt4OvcvoVg9/XVQwH6qXB6/1hQPiF6E+H4=;
        b=cxiBp5ycthmtNXiDAHXWr08AXMTXNGnBTJ5hVu18xDKcA2bskvXWQDC28uc0IG3f4e
         j0pWxNOmu2VqDE/WJsUc5eAIASvyjYFySoSDZsU332c5mdotNPT0cGfm73DQfh3WGCjs
         T7YpaWBWim3TEn9mEXQFIJ/4JBkPZbsKoMfc2oJkTm3/XOCbjF+Fiwy0oONrc/3iWW3J
         pdjCxyOyToPRCE9NUI4yMfPmE6viRqvjFzc+Iv0PHfwlKg8HIX89ju0WeA9ar7X9YXfG
         nU3/UCgf815scX8085W+FqrFVA6S29ofaRruBGTlsWeFosSyqXv6hxOV/klLFQi4a67q
         TPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782153; x=1754386953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ef5rgY2lnt4OvcvoVg9/XVQwH6qXB6/1hQPiF6E+H4=;
        b=d+cPH3SYrN/BTtsWiPgXmYG5l31sZ36oiFXT+HqQTPtSeic+ceA3SwtrgETU+Lzca2
         Ej001wPjOn01b9OP7bQ1aoulFhl8kOgZaOJ5bUvWCf7C6pL2qlid3w/WJMOOPU0bFMD8
         0QRSElFNm1fnOz4/6zw5MvHZ9aO6Zk+TAuBFnvHDGersjLXrAc/kYdQ/Tn3wqFPfT6i1
         TctXUabLCaZ/aH/ZSajTfvXKyertm8sOa68C9heR4+S8QAcE40ICy8o6VQrLR8VD6ohn
         N25gQ8BOEoAQmCuLANVP4SdftuAJUW5GFWApCf4GLKFICupRfXDSA5i5KF4mzmRu39HG
         bNvg==
X-Forwarded-Encrypted: i=1; AJvYcCVKbIxjFy3/e2Yw+ycac+VEGx5eYnUkSWRWxzSr8WTmoWvAP5qMGsaCHr+ITZFeLLanmavBpSNX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ML3eRigxsF8ndmtgnbk6ocAdWkKWXKFFqWBlNacQLxl1odrZ
	PR816fjPVeINTZtlg5z9n7+KKz3S6+27fI9aBnAqMaqnrZdBN2MkL5fGzVX+4DayoEo=
X-Gm-Gg: ASbGnct3o4Xk+cg8PGO6dyv4vr4sQ8MNR9vmvuC+UWPD8l2vj2+/wnip5xjlMjNlZTw
	QhVlBQSWLuHA24WnZ6W2J4yeOMc09sfU0sKmIy0x2SnhcVSGU57LQEz3zTqOcTVGCRi67EhkpCD
	k1iCMdE0kgWQdIqSpe3wb7Nf8K/5s0RfRJ18K8f+sMdg9MdCjnV1dIbzK9hrGDdhNPn5OWGr5vF
	0T4uXA7mFY+sma+YcDE9cnKYrqlW8EWI99qsf7Gbe/WOIAkkdNGNBUcxXEeZ2ob1UVhzFUn2DdO
	KeRNfWtiS4j2UNVmV4m7clqvnU1lfZ6UI5Uuz4VBNwopy43d9IyetUbdYkTZVFflC2FumuXI/Du
	aw9gvt0pDtOU2kWs6lijxhx/3JbFkI50xB28PcDQdFg==
X-Google-Smtp-Source: AGHT+IEg3FocgRMXUTosfo8Ye9Llf6PkHfOrGNXyUlE+u8EhOKaN0vlka4uim4KCJebnGYemr/ns7Q==
X-Received: by 2002:a05:600c:1992:b0:455:fc16:9ed8 with SMTP id 5b1f17b1804b1-45876651bfamr145394865e9.30.1753782153141;
        Tue, 29 Jul 2025 02:42:33 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcb96sm196404755e9.21.2025.07.29.02.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:42:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:42:30 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
Message-ID: <lvfxjlx6gok6lhwvf2h3reiizfztjfsyuspa7avzog6fbuozsq@bqpqe5g4fj5j>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
 <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
 <e8156c36-48f3-4983-8a2e-5a5a4444a473@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yc5dur3zyh2gvpsd"
Content-Disposition: inline
In-Reply-To: <e8156c36-48f3-4983-8a2e-5a5a4444a473@gmail.com>


--yc5dur3zyh2gvpsd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
MIME-Version: 1.0

On Mon, Jul 28, 2025 at 11:04:56AM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> I did consider adding an "initialized" flag to the css but since there can
> be multiple css's per
> cgroup it felt like it would be adding overhead. So I went the path of
> getting the call
> sequence right. I'm open to feedback on this, though.

An implicit flag that builds upon the assumption that css_rstat_init()
must only succeed after it allocates ->rstat_cpu (didn't check gotchas
of this approach with !CONFIG_SMP)

--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -488,6 +488,10 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
        if (!css_uses_rstat(css))
                return;

+       /* Incomplete css whose css_rstat_init failed */
+       if (!css->rstat_cpu)
+               return;
+
        css_rstat_flush(css);

        /* sanity check */

--yc5dur3zyh2gvpsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIiXhAAKCRB+PQLnlNv4
CLYZAQCNoqPVQ+80PlkqExKestU8doSIpaQsFTe+9sM3bMirGgEAlP9HHPLTU5lU
ooXDiqP+bfhMUnoLW5mj85Pa0BKKNAY=
=QcPV
-----END PGP SIGNATURE-----

--yc5dur3zyh2gvpsd--

