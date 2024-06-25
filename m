Return-Path: <cgroups+bounces-3355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D3A916502
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80741F2212C
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784C14A0BD;
	Tue, 25 Jun 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j/WwbyUp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hB6sBP7d"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14127149C4F;
	Tue, 25 Jun 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310264; cv=none; b=NwK65jgReGMn24Oe8EAfdMqVZu+MCHrhoDKKHJiX025A9OQZY9Y+9FrCYYnFdmEhIci/rXWqSjjrAkMz3eJo9s8/jhQVHGGwgbuvRctbetHBwzzbgpCZa4inMYKazKoHvDD/uOBb55wnDh/MEoCf06aUQJlI1mXMr+pzn9U+qvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310264; c=relaxed/simple;
	bh=O5k6HiCgGzdumVyAm2y+a4Xb1B54fWyGUfCrc2+Wtpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhgqvW32DJ69/znFp8SZero9TTzKNXANbtyO5WrVgSPHN0XWS84wbf1LWJMipJBw6/iKRpW1auak2CgKaLWUNZUa9VghuJiz4TyN3Kz8rL+0xGpBLY8UCNra54uodFSxl/wrZkVtbB147lVvFBiIQ8L01VEqqa6HFZYmX/68/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j/WwbyUp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hB6sBP7d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08B5421A65;
	Tue, 25 Jun 2024 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719310260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nrj3iYY7vg8oGyDA8rTIg8nVgzOuP92Uvoq0xxIIzzk=;
	b=j/WwbyUpZcc6pbf65F3+sa3Ny2gNkzXTdQnjASCE9nlGTfrnFwZTOZ1MgOSpxb78hlXZj8
	EhIMGcsqufURQ8DuC+CO/4GpBmZ9fXK0vxurfQTIINqbqvzf1AReNC7mc6nr1bevIhIvz1
	cEbeeiga9QADjEInTlut3pyL/JGdlsU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719310259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nrj3iYY7vg8oGyDA8rTIg8nVgzOuP92Uvoq0xxIIzzk=;
	b=hB6sBP7dbna49SyFSh72Z2R4YXZJ7jCPGFZGz0r3bnBdn3PH0KeVKW9/zb2qaWjcc4G8Tb
	Vhx+6yypcuSRGiDc1rDxOqFLGdk6BFA9oWu9eJXGa9t72R6RboclBHaCf/enopCFhZ4vvV
	Kh6yDqYefzEV8bEKWCFcp93rWffkhHc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDD5013A9A;
	Tue, 25 Jun 2024 10:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PBWdObKXemalVgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 25 Jun 2024 10:10:58 +0000
Date: Tue, 25 Jun 2024 12:10:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: chenridong <chenridong@huawei.com>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
Message-ID: <gke4hn67e2js2wcia4gopr6u26uy5epwpu7r6sepjwvp5eetql@nuwvwzg2k4dy>
References: <20240622113814.120907-1-chenridong@huawei.com>
 <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
 <71a9cc3a-1b58-4051-984b-dd4f18dabf84@redhat.com>
 <8f83ecb3-4afa-4e0b-be37-35b168eb3c7c@huawei.com>
 <ee30843f-2579-4dcf-9688-6541fd892678@redhat.com>
 <3322ce46-78a1-45c5-ad07-a982dec21c8e@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fin4heviwo2qame"
Content-Disposition: inline
In-Reply-To: <3322ce46-78a1-45c5-ad07-a982dec21c8e@huawei.com>
X-Spam-Score: -5.90
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email]


--3fin4heviwo2qame
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Jun 25, 2024 at 11:12:20AM GMT, chenridong <chenridong@huawei.com> wrote:
> I am considering whether the cgroup framework has a method to fix this
> issue, as other subsystems may also have the same underlying problem.
> Since the root css will not be released, but the css->cgrp will be
> released.

<del>First part is already done in
	d23b5c5777158 ("cgroup: Make operations on the cgroup root_list RCU safe")
second part is that</del>
you need to take RCU read lock and check for NULL, similar to
	9067d90006df0 ("cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()")

Does that make sense to you?

A Fixes: tag would be nice, it seems at least
	a79a908fd2b08 ("cgroup: introduce cgroup namespaces")
played some role. (Here the RCU lock is not for cgroup_roots list but to
preserve the root cgrp itself css_free_rwork_fn/cgroup_destroy_root.

HTH,
Michal

--3fin4heviwo2qame
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZnqXpwAKCRAt3Wney77B
SRfRAQCp3qpPjMr/V93EnQBn55wrHhON4TlrezYJc+buOblYxAEAuJyDRQUA9Jxr
sAuWz53C0zuFeXpcKwPfaEbF5fhTrAU=
=O2Ze
-----END PGP SIGNATURE-----

--3fin4heviwo2qame--

