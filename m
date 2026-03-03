Return-Path: <cgroups+bounces-14570-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJVqEoIRp2k0cwAAu9opvQ
	(envelope-from <cgroups+bounces-14570-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:51:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAA1F421E
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B18DA30E11ED
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DE3264CB;
	Tue,  3 Mar 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCs4Bq9x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191A37CD59
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556274; cv=none; b=dy3CX6GMoHpQUNL7C6X62j1NDHtfRB12TUBvXQ0noufHO+dk/ZxYV1fnkMfr3RPfPfnwBwSWK1ryFczqbEVLDF39MysL6EjsYR/Bz1GzJZaleBPbH1eo+gzJhxDeYpRyo299R1f/lVIQEEuLNYSaAWXClX3DH+POrFcxM6wqqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556274; c=relaxed/simple;
	bh=GD8R4MrS3YxxeJH+XqUwYY0ZgQukNMSTXS7hk3+dkhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idLpgWkW8oT3Ump+jHnjoPMi1P9/lgrMKHjiCxF5XcnSjJPZNmSR79AkPtwEZQE4o7YReGEEzym+bEEfm+P0jdZpFk9LtLg+Hl2obtM1dBimkjN3JtLRaYFRjWEuoD9IzCMXFQ0673YpQG7Iv3cw15xRAFehjNiNuSQCexQlS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCs4Bq9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E25C2BCB4
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556274;
	bh=GD8R4MrS3YxxeJH+XqUwYY0ZgQukNMSTXS7hk3+dkhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UCs4Bq9x70nl85+v+7lx+5fxXDSiy1/L1s882ijSWgoOXGAHqqFbB3LIzwWfhGPHa
	 sLvBiNGJgqfLmqFH2hTJuTzuKBVa10PynN/CRC5q/T2GBVh8sbMIMVEEPAJE5VtZZT
	 DATB6dKCk1GvngeQc75cLoGOrnZ0aQqEwhkmDRfHJ9Dm2lW3Egrxb+CgK2doq/0nle
	 VlqSiAP6TFR2UWMQwBe3X08EF58ofHmH6IK6tSr6g20D0/j7zgfBGc6xAT0jZhUSgf
	 Gu+kDkTynguPLCzel88ifRGSRee1UTnjeK50yAnBvMJnvMRdjBXTtlheGQj0k+byCC
	 rzCd36trU+vEw==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a14be4733so3147716d6.2
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 08:44:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1p5IvUh+FCkgXsHrWRigZ2tHEk0ccNt/VuiI5KspfyLNwEKh3mdLg3IKI9w+RFN6Cdu8D7Daa@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4ToBLbRD5VYnttqBfvUoDJo63PAOEFhxJTf46SRMrFoWMkp7
	IsI0xzdUcSLs8NHmpMiNZe+xHKPtPk2JJQTdZcOGMoHMZT1jg8JnpVDIss4tCwWOcG8gfAa0KDw
	t28BoiFxZdDoHdjnTl0knLP4mkmKOyMw=
X-Received: by 2002:a05:6214:d4b:b0:89a:14c5:f53 with SMTP id
 6a1803df08f44-89a14c511a9mr11079146d6.53.1772556273364; Tue, 03 Mar 2026
 08:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com>
 <20260227-nullnummer-eisdiele-08db4c8fe99e@brauner> <CAPhsuW5GCK02OXvFeNQVW-QoX9eJ7CyiT=oEDsCYyht-Hve3sQ@mail.gmail.com>
 <20260302-begehbar-kanister-9801d1198abf@brauner>
In-Reply-To: <20260302-begehbar-kanister-9801d1198abf@brauner>
From: Song Liu <song@kernel.org>
Date: Tue, 3 Mar 2026 08:44:22 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4gRcU-5RhiR=BcDS3J=Px+5n_4nbex+KjAkw0fzXFTZg@mail.gmail.com>
X-Gm-Features: AaiRm52-DKXlpufIhvmyCV4nEob2wQGCqkaDCXdRM0qSJ1z5Eq_QFD3SWEY4o-Q
Message-ID: <CAPhsuW4gRcU-5RhiR=BcDS3J=Px+5n_4nbex+KjAkw0fzXFTZg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DAAAA1F421E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14570-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 1:46=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Feb 27, 2026 at 08:38:48AM -0800, Song Liu wrote:
> > On Fri, Feb 27, 2026 at 2:28=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > [...]
> > > >
> > > > If we change the hook as
> > > >
> > > >    bpf_lsm_namespace_alloc(ns, inum);
> > > >
> > > > We can move it to the beginning of __ns_common_init().
> > > > This change allows blocking __ns_common_init() before
> > > > it makes any changes to the ns. Is this a better approach?
> > >
> > > I don't think it matters tbh. We have no control when exactly
> > > __ns_common_init() is called. That's up to the containing namespace. =
We
> > > can't rely on the namespace to have been correctly set up at this tim=
e.
> > > My main goal was to have struct ns_common to be fully initialized
> > > already so that direct access to it's field already makes sense.
> >
> > Good point on having ns_common initialized. Besides inum, we
> > should also pass ns_type and ops into the hook.
>
> But why? The struct ns_common is already fully initialized when it is
> passed to bpf_lsm_namespace_alloc() including ops, inum, ns_type etc.

I meant if we pull bpf_lsm_namespace_alloc() to the beginning of
__ns_common_init(), we need ns_type etc. because ns_common
is not fully initialized. IOW, I agree with your early comment.

> >
> > OTOH, shall we have the hook before proc_alloc_inum()? With
> > this change, the hook can block the operation before it causes
> > any contention on proc_inum_ida. IOW, how about we have:
>
> I think that contention is meaningless and I'd rather have struct
> ns_common fully set up so that all fields can be accessed.

If contention is not a concern, which I believe you know better
than I do, I think this patch works fine. So

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song

