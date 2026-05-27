Return-Path: <cgroups+bounces-16358-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIRfL9sTF2pf3QcAu9opvQ
	(envelope-from <cgroups+bounces-16358-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:55:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A05E73FB
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF86B303B328
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A03806C0;
	Wed, 27 May 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MOZLMcq8"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B493803D1;
	Wed, 27 May 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897296; cv=none; b=rnUbkCZ4TE74LFuHZz9HBoUGSclbIPr1UsYQ6d5PEDH1BMd2H4FXxik6LnamcUER7/+5fSMxleWyd03b8pSaRiiPys9LoOhCiDQpMfeZf5HVs8Dd2d3TYqk11QEj8OfTkgA5IrvA3vmO1SbXJ557wxKrHt3gpmL11lS/DnVPV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897296; c=relaxed/simple;
	bh=4rxWlRhuXflcFfsFtKVEugiUA30HpjLBuNuDdkZPplk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNXY11uGiyRF8IiFbewDkIxFCFlnsfAbGtiOFdCST3rDwMMLxgNWKQlTCyu+3orjqWctgEJ+cjEwr/5BckUZivPqGB0yOc1eQ35EhGQorRgvOBU0f+B6q6NVDBxNVLEMjc8N+mK/kaAjfC7YNZVZlz8TaPGaTMavcnyhBHM29LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MOZLMcq8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4rxWlRhuXflcFfsFtKVEugiUA30HpjLBuNuDdkZPplk=; b=MOZLMcq8DX7B31KbNM36uzJzmA
	4QcW9ClstTXLuYRBVgyGxZf1kqD6OkVcuwTRaaA8ham35soKrM6viojqCgIZtW08cx1nsqgBvINUg
	HpGernC7vyt2EtMxDWUo97v8IwYRoy/gKbEH33XBSYZnw1YsSk2SyAywEdWmF/Qy80COv90tie95v
	z/gMxNJ1nQVYxqlszwF4ioEGSjhT8woJTVCuWXKblLFSGoOGSH9eGjK/kNmFUdREPARzD1h8cPGhm
	MUYVNs+tNyckmTKaP2qf59AHlC+DO1cO7D4F7gLDNs8QG4nKes0eq90w265ON9L/cMd/VgDJlPj7T
	srIYCZag==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGa5-0000000EPMa-0BdH;
	Wed, 27 May 2026 15:54:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F686300385; Wed, 27 May 2026 17:54:04 +0200 (CEST)
Date: Wed, 27 May 2026 17:54:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io,
	chjohnst@gmail.com, steve@abita.co, mproche@gmail.com,
	nick.lange@gmail.com, cgroups@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tm1INNgsBeticMLK"
Content-Disposition: inline
In-Reply-To: <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16358-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 630A05E73FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tm1INNgsBeticMLK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:05:17AM -0400, Aaron Tomlin wrote:
> On Wed, May 27, 2026 at 10:52:21AM +0200, Peter Zijlstra wrote:
> > I'm not sure I really buy the Real-Time argument here; that really feels
> > like a straw man. Real-Time will need to account for the shared resource
> > usage inherent in using a single kernel image across the CPUs, affinity
> > alone does not Real-Time make in any way shape or form.
> >=20
> > And the compromised task vs crypto thing feels like it wants sandboxing,
> > but wasn't that what seccomp is for, rather than lsm?
> >=20
> > So while I don't think I object very much to the patch, I do find the
> > whole Changelog to be utterly questionable. Which makes me very
> > suspicious as to wtf this is actually for.
>=20
> Hi Peter,
>=20
> Thank you for the blunt and honest feedback.
>=20
> You are completely right to call out the changelog. It obscured the actual
> practical use case. I will rewrite the commit message to drop those
> statements.
>=20
> To answer your question regarding seccomp: seccomp-bpf is strictly limited
> to inspecting syscall arguments by value at the syscall entry boundary. F=
or
> sched_setaffinity(), the mask is passed as a "__user" pointer. Seccomp
> cannot safely dereference this pointer to inspect the requested CPU bits.

There has been work to allow tracepoints, specifically syscall
tracepoints, to access the syscall arguments and to do exactly this
(deref user pointers). I *think* most of that work landed, but I might
be mistaken.

Would this then not also allow seccomp-bpf to access these?

(while writing this, I wonder if that would then not be subject to
TOCTOU)

> To actually evaluate which CPUs a task is trying to pin to, we must
> evaluate the mask after copy_from_user() has safely brought it into kernel
> memory.

Right this.

> The LSM hook is currently the only infrastructure positioned to do
> this safely for eBPF-driven security policies.

But is that correct use of LSM? Or is that working around short comings
elsewhere?

I realize that bpf people rarely care about things like this, they just
want to hack their thing and will take any hook they can get. But I feel
people *should* care.

> The actual use case here is multi-tenant workload isolation and visibilit=
y.
> Passing the evaluated cpumask to the BPF LSM allows operators to write a
> simple eBPF program to detect spatial boundary overlaps (e.g., logging an
> event if a requested mask intersects with platform-reserved cores).
>=20
> If this justification makes more sense, I will focus strictly on the
> seccomp pointer limitations and multi-tenant workload isolation.

I suppose it does, my only remaining question is if that is indeed
proper use of LSM -- I really don't know much about that.


--tm1INNgsBeticMLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmoXE5QACgkQdkfhpEvA
5LoeHQ/+MTZkJvg0y4B5A5uc2/yn7DCD8uHFDSQg2GviwzzreXPFiUJ7xsMl27aC
gWvHrYtdt30AYrYApmdtWiFttFG3KbX0ytIZZt7GKRCBq2tQCcoz+w+iR1/HvkPy
zetCM7hsvlUoB0niBn+09pgk1Qv8yPDUJDenIdNgj/7IduX8T+3vmcWDftKBgudt
0u+ZgolTrYqWXAkewJF+1wLanXq8M+dIshqiBn3U2LCI2B+B4StlNtxnbjjo/mu0
EOb73x4pKGxlvrVfA1LkmslD2tTkvdVdIYGccTSwN/EtvwUY8DAL8BXn3c63A9R0
PHR18s9SOpTRyija7ekEyE5EAZhoGUDz+px6mF963+PhQKrnoEeik+HP/m/DFxjk
0hE3Dc9oP5LrfkWDLo9u7TV9ygBLBTgGPVw2fNHrE2ojQap0gvGgzO9I78Ro5pkQ
h2X9BYIz/aOpi4XaIakO/ZBYyg/7K0ENMzaUqXCun64aqnu5jNW4AKYrQC2iGRPs
W97qhxhChQhGmToFNoxy8/MTUdycr/Oa8qEypTjRoz93Px+d2BlrtVR05ySG+3Q8
ex0CgPIm9xh+AbJoMUUA04mQNV4hDH6QwFb1UMBnuORHXF/u1EofINy/qGcBxUmf
uzHZNo7skAzJnjxUh0uE3ZkVpWrMPopndllixneoonkHIzdIGZg=
=GtEU
-----END PGP SIGNATURE-----

--tm1INNgsBeticMLK--

