Return-Path: <cgroups+bounces-16365-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN9+GFRNF2r7AAgAu9opvQ
	(envelope-from <cgroups+bounces-16365-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:00:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E15E9D72
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35627302E2CD
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10373B19D1;
	Wed, 27 May 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELTN3QR6"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183E2F3C26;
	Wed, 27 May 2026 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911972; cv=none; b=dHKixEKKKrHCZDAR/a0LUKXrI9REBrkX9nbyC3YUnmEXke6ab/pLHDq9ZAvhm8Clcz3WZJtMGZ2aEK1bySiLbuXEVLeisLhF4hoinaM9kYqF7OMxsvxTQTdeDBHF8IdASh7M2ze/IQQqQTS8Icq3OZTh/9coY2etJ0GOntDvuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911972; c=relaxed/simple;
	bh=dGLzAB7+QWK1Gwqw39KPEq+ogXaxGhIVT7a7pkAe2yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS4p6eq1l4xNNY+JFbkNDNQMpjNpNgPJ+zujRRbpIzHJG+qoMlVWwOFEMwoWV3BbpQBnd+UEgUt7yh0WHXkTfbMwIBGYqNY5r9vhE682Yl+ybPCzzogoMfiUBQE3mZoE3MaDFk4qLdGs4ByTgK588xPaO0hwq0Bv42OfbxUwQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ELTN3QR6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dGLzAB7+QWK1Gwqw39KPEq+ogXaxGhIVT7a7pkAe2yE=; b=ELTN3QR6sMG44bP9QyVSBeLylu
	8lRV9ni3yRDtklEwyJmFsAeypKQNkkXvFE7GlkSBXjY8sF/U8CFy1tQ0mpAusLZpZTEKzCjOAHypl
	GjVqkLWx5uykPyxnm3NfS31r4/wADnQww1ntE/gYwJhlEmn9nu9cFgs9yZxE/VFUBQbYqHo0LjUNs
	8sqjWNdLqqRvj8nf9ADfisaUJnTzne+bIbnMIP9byI2TAhGaMOlwKcruGBWP9liQQtllCFNevGLBn
	Cp5biHaoWTFBUbgy3liMkWfM1OVjdTb4G7f5ExW9ApcDzqwlUmizXFDn1xd9nD+nSf5R8DJYOZB/J
	4aRGLMyg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKP6-0000000ErAf-0irf;
	Wed, 27 May 2026 19:59:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D3CC6300CB5; Wed, 27 May 2026 21:58:58 +0200 (CEST)
Date: Wed, 27 May 2026 21:58:58 +0200
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
Message-ID: <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
 <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o0gcLVW1g+NX126n"
Content-Disposition: inline
In-Reply-To: <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16365-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 652E15E9D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--o0gcLVW1g+NX126n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 01:41:52PM -0400, Aaron Tomlin wrote:

> > > The actual use case here is multi-tenant workload isolation and visib=
ility.
> > > Passing the evaluated cpumask to the BPF LSM allows operators to writ=
e a
> > > simple eBPF program to detect spatial boundary overlaps (e.g., loggin=
g an
> > > event if a requested mask intersects with platform-reserved cores).

Why isn't cgroups good enough to enforce this? If you create a cgroup
hierarchy per tenant, and constrain them using the cpuset controller,
they should not be able to escape, rendering this event impossible.

> > > If this justification makes more sense, I will focus strictly on the
> > > seccomp pointer limitations and multi-tenant workload isolation.
> >=20
> > I suppose it does, my only remaining question is if that is indeed
> > proper use of LSM -- I really don't know much about that.
> >=20
>=20
> We are not creating a bespoke BPF hook here; rather, we are rectifying a
> historical blind spot within the API. The existing LSM hook is invoked
> during sched_setaffinity(), yet it presently receives only the task_struct
> pointer. Consequently, the security module is essentially asked, "Should
> Process A be permitted to alter Process B's affinity?" without being
> informed of the proposed affinity itself. Providing in_mask simply
> furnishes the existing hook with the requisite payload to make an informed
> decision.

It occurs to me that this same argument would require to also pass in
the new sched_attr, no? That way the LSM can inspect the new policy
before it becomes effective.

> Were the objective solely one of observability, a tracepoint would indeed
> be the most suitable mechanism. However, if the aim within multi-tenant
> environments is active enforcement (namely, safely returning -EPERM to de=
ny
> the pinning request before the scheduler applies it), the LSM layer remai=
ns
> the standard, architecturally supported gateway for returning syscall
> errors in accordance with administrative policy.

Indeed; but being constrained in a cpuset cgroup would result in the
same, no?

> I shall defer to Paul Moore and the LSM maintainers for their final
> blessing on the LSM API semantics.

Yes, I think that this is an interesting test-case of the LSM purpose.

You seem to be mostly aiming at resource control, something that is
traditionally done elsewhere.

> Thank you once again for the thorough review and for keeping the
> architectural boundaries honest.

No problem, just trying to understand myself ;-)

--o0gcLVW1g+NX126n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmoXTP0ACgkQdkfhpEvA
5LoosQ//XlaEdrjiSG7UqRemo3EjCKgYC4JnDuk0gK8Jjj7CT4JOA1uvnNt84hC9
JUsAkRQ984DrAwXrsIkJuPu3D9NziW+8W7Z9vYczAtTVgptyNIkGP15S6cXFX4yC
0Qd9bBNG0EhB31fLvONobc8iMpCT1zvCtUYJeq+TYvqKAwitQD8smMUpk1PKgZcf
Ij5E7jrX4WpvD1GsLZn7vd/vGhGvUXz2WABj1urHNyMK3F6itWDpei8uODKK9cJz
Ea6GUDNenHPMZbXCCRCDJUVfAPQHeeL+zWF8SYyt6+nruQNW561/UjVOD0+bEW5F
tLLcgYYblXI/BNdVPfs7O8Cu99644DSJxvd2smVS5od0IwZTMe7bqAZ747a7drNu
B9RwbYTb46/nHRNe1ad1KUpLDSkMOQm2PRjkdpA2OL3HhDdE49KutblbSI1kvLh1
sOJdZIGIcPvkrNosZTXu/tc2AOfc90Zp/WcaLjfqc+5LY5o8jnHBksn36SohPBqf
MM8FGqbBrq5DfyVrE/59aCPEJyTYQz25JBT+2NbELDVCFI1sinCA1qIKWBB5iIOK
Tq5G37nzhDw2WAp/e9BCnF+3adNqUuUbldIL4PsuobrPlIQHgIq6I9rKul3OkhYw
5L4lfLU/lFF/HfpMY5xlWEHzEO47vS4dG7DpHHlUynEmoLTSu88=
=rSBb
-----END PGP SIGNATURE-----

--o0gcLVW1g+NX126n--

