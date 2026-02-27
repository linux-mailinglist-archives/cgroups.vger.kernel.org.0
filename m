Return-Path: <cgroups+bounces-14475-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PDyKODIoWmqwQQAu9opvQ
	(envelope-from <cgroups+bounces-14475-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 17:40:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B01BAE75
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F20930F0F12
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8A3469EE;
	Fri, 27 Feb 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk8Xf2rX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14EA32A3C8
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210340; cv=none; b=bzp68e/0UbCdyryGwi6zdf+nIqcCIztC6HZl90z9xXOW+fqqQiBdtlbMuEJQzVzBzI6ZnC5671iW8p9pTSWv5y1VUz/a4+3O2YtrEdwLESq8Z1qH9I2U21UZcgkgtsWYjdIeXmcmOX5ishkOXlAGPYijdK+Gnp6IGaRMSUjzxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210340; c=relaxed/simple;
	bh=8LI0IHWaLRjB8r9+a9Ui59W+8wlvcSSs+xwYYse+CrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0eu/4e+8lKrcszW/3JIlCFrLM2zeCthl+++NV6MQNk1sg+bA/Y9LP+xhmMJIog2YKS4G9SwKrGimgz1GPDjn6h1Uk0iqVLsLQXSLQ3ukYPC+llW6gc729lJrmIipyZIKpcOG1EjqqA8zM2nKz9nwKHfq+q20R+32J7xYGuNolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk8Xf2rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F8C4AF09
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772210340;
	bh=8LI0IHWaLRjB8r9+a9Ui59W+8wlvcSSs+xwYYse+CrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kk8Xf2rXlgtDFPWh7Pu08N+o5ooDHD1DRsTbyTnBozhflNcUJTpjltYXYFzOHbQ32
	 mW1uNuerniEputNLokVShP9qXF2SGiXDvMoixeUzBDmVvy+kSQgDZOTaKvOUAIucFB
	 KfixiYZSucAmCkrziwNu24WEs0waGb8RvD8j8bdjnntMMnw88Sua5efxHb+Fl+ZSY7
	 pDXZkmEX3UP9+DqPaWwr+kRyKQVIH6luxB3HuWQT/W0zWVAupgPeqExTXZZkcKO7hm
	 gAy0BtVFD07/6C8sIisWT+vcoxvy+eSAOiGZ8M9S8rt6d9Jvvty9x3XvXgrcvDuY2O
	 E3I0DEZROz34Q==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ca01dc7d40so242339285a.1
        for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 08:39:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfCUhS9k72Vyili8UxgibxT0G05rmwk42iPoRPa+oqrLwSEBABZ+cfX9zCxFSOch+LwaGPt8vd@vger.kernel.org
X-Gm-Message-State: AOJu0YySTk5MG410n63zGeSz5nYb/JkXxLV+IXMy4FuOimXfvZsKIX2E
	mffZBk121q9g1J2eHET1yHGz/iPNmIVyF8xb/XLJYKUdtvAs4lZbhSJQndsavfMhX9vS4yOFcbb
	h3UB6t93bK6mH1Kg8dMsO0PvWHfOgXKA=
X-Received: by 2002:a05:620a:7087:b0:8c6:d343:79a4 with SMTP id
 af79cd13be357-8cbc8ef670amr394649685a.40.1772210339338; Fri, 27 Feb 2026
 08:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com> <20260227-nullnummer-eisdiele-08db4c8fe99e@brauner>
In-Reply-To: <20260227-nullnummer-eisdiele-08db4c8fe99e@brauner>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Feb 2026 08:38:48 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5GCK02OXvFeNQVW-QoX9eJ7CyiT=oEDsCYyht-Hve3sQ@mail.gmail.com>
X-Gm-Features: AaiRm53vvomrYN97zb9oJr-YpBvWojGs_OXdsLpf7lORcARGDVNdLKSnamBhnGI
Message-ID: <CAPhsuW5GCK02OXvFeNQVW-QoX9eJ7CyiT=oEDsCYyht-Hve3sQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14475-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD2B01BAE75
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 2:28=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
[...]
> >
> > If we change the hook as
> >
> >    bpf_lsm_namespace_alloc(ns, inum);
> >
> > We can move it to the beginning of __ns_common_init().
> > This change allows blocking __ns_common_init() before
> > it makes any changes to the ns. Is this a better approach?
>
> I don't think it matters tbh. We have no control when exactly
> __ns_common_init() is called. That's up to the containing namespace. We
> can't rely on the namespace to have been correctly set up at this time.
> My main goal was to have struct ns_common to be fully initialized
> already so that direct access to it's field already makes sense.

Good point on having ns_common initialized. Besides inum, we
should also pass ns_type and ops into the hook.

OTOH, shall we have the hook before proc_alloc_inum()? With
this change, the hook can block the operation before it causes
any contention on proc_inum_ida. IOW, how about we have:

@@ -71,6 +71,10 @@ int __ns_common_init(struct ns_common *ns, u32
ns_type, const struct proc_ns_ope
        ns_debug(ns, ops);
 #endif

+       ret =3D bpf_lsm_namespace_alloc(ns, inum);
+       if (ret)
+               return ret;
+
        if (inum)
                ns->inum =3D inum;
        else

With this change, ns is already initialized, except the inum.

WDYT?

Thanks,
Song

> The containing namespace my already have to rollback a bunch of stuff
> anyway.

