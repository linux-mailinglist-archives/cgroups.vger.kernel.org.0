Return-Path: <cgroups+bounces-14234-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLitKm4vnmmkTwQAu9opvQ
	(envelope-from <cgroups+bounces-14234-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 00:08:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161418E0EC
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 00:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF11230C31F0
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9C353EE3;
	Tue, 24 Feb 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbMuUD3a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303434F48B
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974296; cv=none; b=JnqCjd7nHMMwKA5XWWroTjQn7SP0blVkoUTy36j/Rga7uRtC1w9HOf9QPhH5654eCJQhgW7spjlwINdEY61UnS0JucKEe+w1uq26f3kzMeWlfy3AHW7v6g/fWwsurxkS3jZKxaJHPZM0jnBQIqfKmOArGYSrSxcRotaNCa2R5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974296; c=relaxed/simple;
	bh=Xrb6lBw0L9oSHnmf27fppipDXsNqCIMeCc69WlctW20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMtwaUP2xOLJW1A+CxzxfdgZWIUBYzRBZviHBzJY6/uuJyYgZ6wI1NFTI3r7vBHai2SycEjNhmi4cOxLwNqh4Nn3bQyQVPOV1xtC1TZX8D4LOcKtC7+e302KSRErRyJMgXiWx/UzfWXqpRO21Gjh8FfP39iwBvaV8cktU+6Wer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbMuUD3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083A3C116D0
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 23:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771974296;
	bh=Xrb6lBw0L9oSHnmf27fppipDXsNqCIMeCc69WlctW20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gbMuUD3aTNmzocowocDUB6yEI6vZSw9xcwzEeuyj+kKFkr9kJZ2JxV7Ic3aDTz9XA
	 n0EbIKQM4f+xv1aO5ks5hwQeBvFcZGiWZ1IqfHtd8aaEjHsWqmomZUHhhp4ZBmjlqn
	 yse6UXXDCK13x078so4zB9XbQ24ABUR411D7OnLM1Fz2DIPRjxIAQAtktMAbMg1vlx
	 ec6Tjo6VX4obsysV/4AbVnBslhg9xNtiBypoNRDRnIgI+PPSxdHQJ9KrsDw01c24fq
	 qnXL2T25KejENVLn5GuCbqh4+ghsMYlrSAU1O9r3wLgZ/2ENYnAf4vEkPorWmHfKmz
	 kpy6992FobETg==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb38e86cf2so625148685a.1
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 15:04:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkpqjbKiihZTqSMrHuiAM2UwtVg8ZdC3sdPv1vcjt1tiKGjeTdIxuriJ7vLISRMiwAKLA23Jv+@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYUulmfUO9y0d6WYWjcuwW6x7qNw5I5+qipi4xYcjdkyjSH7a
	tZVP/LIwA2xE3wNQx1CvnjAw/fGYNxj2WOnLdlAk+OdHb7X2ELcDNiyc27EYGR3fUGFlGc5BQmk
	n47agEOlRefMIHTVAZZCvlKuRgHPvRF0=
X-Received: by 2002:a05:620a:40cc:b0:8c9:fa97:75ad with SMTP id
 af79cd13be357-8cb8c9fb379mr1832296585a.27.1771974295227; Tue, 24 Feb 2026
 15:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org> <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
In-Reply-To: <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 24 Feb 2026 15:04:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com>
X-Gm-Features: AaiRm53P5ZysZT84k28QIAoeRFwD6jEVrfNAXpq-cDIk91wzh1FA2Mcq8bekeUI
Message-ID: <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14234-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1161418E0EC
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 4:38=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
[...]
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
>
> +#include <linux/bpf_lsm.h>
>  #include <linux/ns_common.h>
>  #include <linux/nstree.h>
>  #include <linux/proc_ns.h>
> @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>                 ret =3D proc_alloc_inum(&ns->inum);
>         if (ret)
>                 return ret;
> +
>         /*
>          * Tree ref starts at 0. It's incremented when namespace enters
>          * active use (installed in nsproxy) and decremented when all
> @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_typ=
e, const struct proc_ns_ope
>                 atomic_set(&ns->__ns_ref_active, 1);
>         else
>                 atomic_set(&ns->__ns_ref_active, 0);
> -       return 0;
> +
> +       ret =3D bpf_lsm_namespace_alloc(ns);
> +       if (ret && !inum)
> +               proc_free_inum(ns->inum);
> +       return ret;
>  }

If we change the hook as

   bpf_lsm_namespace_alloc(ns, inum);

We can move it to the beginning of __ns_common_init().
This change allows blocking __ns_common_init() before
it makes any changes to the ns. Is this a better approach?

Thanks,
Song

[...]

