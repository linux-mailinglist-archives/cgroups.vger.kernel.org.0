Return-Path: <cgroups+bounces-17258-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IM+yGuQ7PGo7lggAu9opvQ
	(envelope-from <cgroups+bounces-17258-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:19:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9936C1315
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IilsfYkB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17258-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17258-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05703034A84
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571A3E1208;
	Wed, 24 Jun 2026 20:19:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3C34C124;
	Wed, 24 Jun 2026 20:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332381; cv=none; b=EcGva4Eq1pOYUG7Ux9/UcbuLRpDGykipe7P5l+JymxVXqKCJSMe1Zcc7/vYzJOFVsl5R1p6IwitC0GqzSclUpVFg1kQ976PF4uUcs/e9l8ZmPjoTTE6r722Pcx9uxkorWz+jpmlYvHBkKyJ2+vsSxqCHhgXX1MQxCKq5okKPtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332381; c=relaxed/simple;
	bh=UkcFBmck2UzEImYlqiPL0rz+GkuiHZU3oHSEblXkohs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR4WpOfdh/oj5CxXFiIa09tjZKyba+64xTAxBzFwg9uyT9z6DLHxVwRmQbkbmeY+qIUikvrBOuQXl/UNHpWSmPKJH7b8AcwcUG/QMivYoKLIpwwTphaODZP0Bo7HID06mRX4fq0KTyCMiF5QGTdLdD+tDAgctTLn2sWkjVy9Ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IilsfYkB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645391F000E9;
	Wed, 24 Jun 2026 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782332380;
	bh=UkcFBmck2UzEImYlqiPL0rz+GkuiHZU3oHSEblXkohs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IilsfYkBqbhSvEAS0iD6jQmR7LnM1114G9hWZnjYMZMkaxSl3j3n+Gq47Z5TwjHdI
	 TDEeQ6BEprTbfGt4uTb7uNstXvj/OeNCpryGg/21+fJB0zlNx/gZ1iQdpkrHgSJbLY
	 3M9aaX3YaD6GbcRDNoSWAvwvqmGtBS4WWmpxsz9vMdU9YY2xLurA8tHxsNUa+CbBIh
	 qdpQtLRM4mKf5pr8H24N3ELG455uAOVxbDx08moxg92S9CNsinBLf/bP0ybjZz33m7
	 8WaJ9Zhn4SVmvsSALnPMI8U3EFI5qcjJgv29nCUs44QU72dhDOUoHrB1+LppdHodrs
	 frHv8EUKyNO7g==
Message-ID: <b71f08a7-c767-4551-8e74-bc37aa1b028b@kernel.org>
Date: Thu, 25 Jun 2026 05:19:25 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Zlek49xErrqEW3E7sgpVdAin"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17258-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,gentwo.org,google.com,suse.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF9936C1315

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Zlek49xErrqEW3E7sgpVdAin
Content-Type: multipart/mixed; boundary="------------kzqmt7N2n4K0yCl8bLirR5xJ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <b71f08a7-c767-4551-8e74-bc37aa1b028b@kernel.org>
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>
In-Reply-To: <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>

--------------kzqmt7N2n4K0yCl8bLirR5xJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/25/26 1:30 AM, Alexei Starovoitov wrote:
> On Wed Jun 24, 2026 at 6:11 AM PDT, Harry Yoo (Oracle) wrote:
>>
>> Bug 1 was reported by lockdep, and bugs 2 [2] and 3 [3] were
>> reported by Sashiko.
>=20
> ... and in fixes for sashiko complains sashiko finds more issues.
> I don't think it will ever end. I suggest to fix realistic scenarios
> instead of one out of billion cases that sashiko think is plausible
> but will never be hit in reality.

But we can trigger debug warnings for the first two bugs fairly
easily with slub_kunit. Doesn't that count as realistic scenarios?

(Ok, I admit that the last bug was purely theoretical, and would not
 have bothered if the fix was not straightforward)

You might argue that it's not as urgent as we might assume
(e.g., it's okay to not fix them asap or backport), but I don't think
we can just ignore them.

It might be bit harder to cause an actual deadlock than to
trigger a debug warning, though. We can discuss that [1] [2].

> The chance of server crashing
> due to cosmic rays are higher than such bugs.

I'm not convinced that it's the case.

Well, I don't know what are the chances of calling kmalloc_nolock()
in NMI, or within slab or memcg (via tracing), and that is an important
factor here.

>> To BPF folks: do we need to backport kmalloc_nolock() support
>> for architectures without __CMPXCHG_DOUBLE to v6.18?
>=20
> nope.

Thanks, that was what I was hoping :)

# The discussion

[1] Bug 1: freeing a slab object via kfree_nolock() or draining
the stock in kmalloc_nolock() happens very frequently. The objcg should
have been reparented (which happens upon cgroup removal, which is not
too rare) at some point if the objcg stock or a slab object is holding
the last reference.

Can this cause an actual deadlock? That depends on the chances of
calling kmalloc/kfree_nolock() in the middle of reparenting (see
reparent_[un]locks()) or objcg list manipulation under objcg_lock.

[2] Bug 2: You should exceed memcg limit to invoke
memcg_alloc_abort_single(), but you don't even have to be under
memory pressure to exceed that. (yeah, I had to modify the
kernel to implement a fault-injection-like-feature to trigger this).
Unfortunately, you cannot reclaim memory in unknown context when you
hit the limit. This should be fairly easy to trigger.

Can this cause an actual deadlock? That depends on the chances
of calling kmalloc/kfree_nolock() within the slab allocator.

--=20
Cheers,
Harry / Hyeonggon

--------------kzqmt7N2n4K0yCl8bLirR5xJ--

--------------Zlek49xErrqEW3E7sgpVdAin
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajw7zQAKCRCGXBN6rc5S
1vouAQCh/9K0kC43Qqi/NglK+SA4uEYxDJKy+mVHY1nJ74W2dwD9EPoXul5oeRjb
Ss+SQ/ewNmWISbYG47kjTqE2cnJ8rQ0=
=8pG+
-----END PGP SIGNATURE-----

--------------Zlek49xErrqEW3E7sgpVdAin--

