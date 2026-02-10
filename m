Return-Path: <cgroups+bounces-13828-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LgrKNoLi2lXPQAAu9opvQ
	(envelope-from <cgroups+bounces-13828-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 11:43:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28E119BEF
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 11:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79BA230160FD
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462334216C;
	Tue, 10 Feb 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fdYwWhGZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDF330666
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720209; cv=none; b=FF4hgao9N1ZdCDJpzbi/M/iUbf3z5QthZPHT+953ByjJDRu+K0D4CA2oLnE1ZkcWjk+trbGCMnbZ09oXRl6VtYDEn/iBeZ+eI6vZmQ/77lrZnqd+IaW4kfrd3YZrnbQ01VVx+cuOtLcOoExfdXvAtG9X4IvHQjOm+9DIdSGtfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720209; c=relaxed/simple;
	bh=runTbpTUp4+7VO5AD1+vvnMLrl5RDPcZS5+sNX7pqJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4O3iexpzdXr9HhJJAtyUHC25hd6jrTDfdicsTUkz6F4PDCnOEG99/bvSvCl1aE96ERt2iaZjJEs5e84zexWv6TmcgQFFA7p6qP+S4N8aqQNIdHhcc5Jo37qKr3RtAzAG9nE6DrO3PMUzvYZJoxTmZTnj6UyemtnEvk5i1CbflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fdYwWhGZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806bf39419so39964625e9.1
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770720206; x=1771325006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESLy7xskhHqRSLwhEQNcBnuHQ0VOxD4Qd3ZqFxQhArA=;
        b=fdYwWhGZBuneTIxln8Zn7LgcRlB+E2OBs1tU9bKjLHpc+2nrE1YnAqYpkgPNFj48oD
         29x5KesUcQdgoypaDFfP8esZ5El+SeZfdih/luCiq0lKKS9ACTrsU6GM5C2lR30v6QdL
         WPaUXFQxVORucoLC+inxeMANUmpev+FgrV25qqF/en6I0am6UovGnc/8KlRqHYGuz3cO
         3qCEIgKlUo1fQ/27ca4XDnSqDJYTiF+H09RuITT3sG9psgjCLLnFZ+p+qOBLpZjCYumn
         lKD8OyS9jhy/qfBnDUnphxcy/pXdU930l6zlDfCEQvacgr+L+Jp7XhIFilhKAbZvhfqY
         kU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770720206; x=1771325006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESLy7xskhHqRSLwhEQNcBnuHQ0VOxD4Qd3ZqFxQhArA=;
        b=i3VlQo275IqzPkTBjZkmuToC5u+tEH/GC1cgLqvs3qw4xhjGvcVBVzBN76qUT1pYYx
         zBUGzgsS9CJrKUf1RDZCIQ+hd3PCLMI1tV0WwlJ8Px8OBBu8B837raLg62p9di+4nIJH
         rB8VTTK4Frdfzpz9Wn2nV6qlQ8mUiHxZYFROCZ4rqCx2H5K5bPlcXWtQpWkcfiV2Kegl
         3j5ZmMT50/Sxr8lHVvbLChHRrQsyAWd6cGJVThkxyZM14M8vtC9xgk9HN1T+LdFEvSaO
         NpRMtR+tCPnfG3LIgJ5YzgPD+dWky2QC2L0m5oNei7UiSHyS0goET589umluK7C3sKBN
         4iFw==
X-Forwarded-Encrypted: i=1; AJvYcCWycs4zJ7cZk2DbcCSxoTgE2l6zAUFlcRPcho9TydtSLuvkAZA7pdxsYI/QOuMTF7F1VOthm1dw@vger.kernel.org
X-Gm-Message-State: AOJu0YzP53A8B+XUZmOncQlW6LCthSINPDEqIBnmPhHKwqmQKj9R7X+o
	ukFlU+auvLqonokkS2AXNPg7wEwJTgTnPfxBaF4EcUSM7LJ6IMLxKUs8rOZa8DDZ/K8=
X-Gm-Gg: AZuq6aL3Fj9TC8AozZsKryWj4Eobq6i4RZ1/SGdY9lfofM5bSHCh/R0csDomklwhe1I
	JZ9AY+sCJE/8QqR785xX819U0kwoOIMrPGIZWJMf0JIECkJxnS9DnMdG/lHeZ3UAb8MSYd00YqS
	vj3VAFR22sUz7irAhB5ty1g3iKhYlW6REiGNplnK1TYkkGZteWgXRGJeCDbgmwjCLjpZu3IVb5L
	jP4RSSin3RqPpl3fa+wyBzlbSSZ9NS2u8GWs9KCKVzgvv8Uj40LZhskoQzzotlwr8FFFadfLJ2q
	KfS/hznJQ2HuYXz0iXZkUagzuwHCZ/HlMg5CSrpnImtC2SRY7maoWZquo0ZCyajFFCXQzV/AUDY
	7Bi6FqpITWjVSZFSI+wf8yVkYBVm6AXpdxcgvW1YRB53dz+5RBE9HhNlYTlIfnChAV8qeYCqenv
	f1RrwTjGrDW3Jbk35CwbTRUpJLqBpTU6zXeewdGbGmqw4=
X-Received: by 2002:a05:600c:6c5:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-4834ffb25fdmr15526095e9.18.1770720206384;
        Tue, 10 Feb 2026 02:43:26 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm153113885e9.6.2026.02.10.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:43:25 -0800 (PST)
Date: Tue, 10 Feb 2026 11:43:23 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Message-ID: <jt6kzvdkp4obq7jszyt4muc5ktjjft2idbz3mzkknlxdch6iit@yeumuxzp6gbn>
References: <20260122112951.1854124-1-mjguzik@gmail.com>
 <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
 <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
 <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gumy7av24fsy5x4o"
Content-Disposition: inline
In-Reply-To: <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13828-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 1D28E119BEF
X-Rspamd-Action: no action


--gumy7av24fsy5x4o
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
MIME-Version: 1.0

Hello Mateusz.

On Thu, Jan 29, 2026 at 02:22:32PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> And I'm wondering whether removal only in cgroup_css_set_fork() improves
> parallelism because the tasks (before patching) are queued on the first
> css_set_lock, serialized through the first critical section and when
> they arrive to the second critical section in cgroup_post_fork() their
> arrival rate is already reduced because they had to pass through the
> first critical section. Hence the 2nd pass through the critical section
> should be less contended (w/out waiting).

I was still curious about this, so I tried own measurement.
I ran your clone'ing will-it-scale testcase [1].
Basically it was
	clone_processes -s 1000 -t 40
on a 40 CPUs/80 SMTs machine.
I watched for the `total:` iteration counts reported by wis
periodically.

6.18.8-0-default (baseline :=3D stable + pidmap patches [2][3])
  2.9383e+05 =B1 1135.5

6.18.8-1.g886f4c4-default (baseline + rwlock impl (previous message))
  2.9363e+05 =B1 1219.8

6.18.8-1.gb21e8f8-default (baseline + seqcount impl (your patch))
  2.9147e+05 =B1 1125.6

So I could not reproduce any non-random change with this css_set_lock
split (I consider even the apparent difference between implementations
rather random).

At this point, I should look into profiles whether the bottleneck is
really css_set_lock in cgroup_post_fork() but I'm sharing what I have,
glad for your possible insights.

Regards,
Michal

[1] Only clone_process variant, clone_threads randomly hung.
    will-it-scale/glibc (2.42-3.1) likely doesn't work well with the
    cancellation/(no) join (but I got hangs even with pthread cleanup
    handlers that joined the child thread)

    #0  futex_wait (futex_word=3D0x7ffff7ffd840 <_rtld_local+2112>, expecte=
d=3D2, private=3D0) at ../sysdeps/nptl/futex-internal.h:146
    #1  __GI___lll_lock_wait_private (futex=3D0x7ffff7ffd840 <_rtld_local+2=
112>) at lowlevellock.c:34
    #2  0x00007ffff7c98d69 in __GI___nptl_deallocate_stack (pd=3D0x7ffff7ab=
16c0) at nptl-stack.c:113
    ...
    #5  0x00000000004029ca in kill_tasks () at main.c:151

[2] https://lore.kernel.org/linux-mm/20251206131955.780557-1-mjguzik@gmail.=
com/
[3] Those patched improved the metric about some 10% (but I haven't
    measured this difference so thoroughly).

--gumy7av24fsy5x4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYsLwxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhHMQEAhM8JFYEoqdsJZ4x63Hpf
5xcL1MOdnxmJxPUan7AT7sQBAL/JAgaggE3EA6NEfx/0C6BdTTBWix1s2O8DkSh3
O3wO
=SCK0
-----END PGP SIGNATURE-----

--gumy7av24fsy5x4o--

