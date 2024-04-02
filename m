Return-Path: <cgroups+bounces-2270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64B8951BC
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 13:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F931C23534
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599D627E8;
	Tue,  2 Apr 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cSpaHOMj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF05A4C7;
	Tue,  2 Apr 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057004; cv=none; b=qsWeHZVz9IoFdTCS11FLxJo+SM2qWPXMLhfu9eX86dYF+UnLuLm4c0z93Iq155QdoP/SCmWljbuVKrAyAtF1G1GW3Z053WQa6MMkSp26UYRBLck3zpZWEHsMwiR/70TuxSL2Fj9nFx/73mjWRDoaHPamvyOqWoKensMT4TCDGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057004; c=relaxed/simple;
	bh=kFQafWpdwS8a62X9B+PMGLnjifo/WJdCTGlM47vNwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkVVLKboqWYhb0YfO/b4vipHD64CFtEVMKgsXgGz8qxnNQxedNnz3YbNHsVUILVrYcSfydkUdrXnleQZ0RTVks0dUCps5ZF3AYPOhKrdlFjaVol8v/5z93muvXwhtZJL8/6xjSg+kE2FOn2UZCuFX1mBSc/nWJueYLmfaGzzex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cSpaHOMj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09885345FD;
	Tue,  2 Apr 2024 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712057001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiA6cT3DACqPDQYZoNSD9fJjMgMwVm21gc3jD1ih9Xs=;
	b=cSpaHOMjoD2Ebf4+v7HYedKy+DG1tr48ChErsvqd4AaNVDSoQusa/YBFeUurda60RwQlpZ
	/Jr6F5e4gMqXkzI9bM0MmQpndn6eNZzEfUn1A0mL4+lpj4mt/iFHpa49moPSmBSx58/rmu
	2jQnp0fFCgkqUP75i+RLAMK01QGdqCc=
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DD76913357;
	Tue,  2 Apr 2024 11:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QQ7oNajqC2boKAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 02 Apr 2024 11:23:20 +0000
Date: Tue, 2 Apr 2024 13:23:19 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Haitao Huang <haitao.huang@linux.intel.com>, 
	dave.hansen@linux.intel.com, tj@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com, 
	tim.c.chen@linux.intel.com, zhiquan1.li@intel.com, kristen@linux.intel.com, 
	seanjc@google.com, zhanb@microsoft.com, anakrish@microsoft.com, 
	mikko.ylinen@linux.intel.com, yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
Message-ID: <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>
 <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhu3ebu6ybc3o4aj"
Content-Disposition: inline
In-Reply-To: <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
X-Rspamd-Queue-Id: 09885345FD
X-Spamd-Result: default: False [-1.91 / 50.00];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.975];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[37.54%];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Flag: NO


--yhu3ebu6ybc3o4aj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sat, Mar 30, 2024 at 01:26:08PM +0200, Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> > > It'd be more complicated and less readable to do all the stuff withou=
t the =20
> > > cgroup-tools, esp cgexec. I checked dependency, cgroup-tools only dep=
ends =20
> > > on libc so I hope this would not cause too much inconvenience.
> >
> > As per cgroup-tools, please prove this. It makes the job for more
> > complicated *for you* and you are making the job more  complicated
> > to every possible person in the planet running any kernel QA.
> >
> > I weight the latter more than the former. And it is exactly the
> > reason why we did custom user space kselftest in the first place.
> > Let's keep the tradition. All I can say is that kselftest is=20
> > unfinished in its current form.
> >
> > What is "esp cgexec"?
>=20
> Also in kselftest we don't drive ultimate simplicity, we drive
> efficient CI/QA. By open coding something like subset of
> cgroup-tools needed to run the test you also help us later
> on to backtrack the kernel changes. With cgroups-tools you
> would have to use strace to get the same info.

FWIW, see also functions in
tools/testing/selftests/cgroup/cgroup_util.{h,c}.
They likely cover what you need already -- if the tests are in C.

(I admit that stuff in tools/testing/selftests/cgroup/ is best
understood with strace.)

HTH,
Michal

--yhu3ebu6ybc3o4aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZgvqoQAKCRAGvrMr/1gc
jlAqAP9I+NeX7O9Wk3opsGFG1Fr8xK5z/v51TgzJ8ZmcnNxyHwD/aF7TmuF17oXt
aq0+sYznVp7gX2pLq4q7YyJ28in9uQM=
=9sGJ
-----END PGP SIGNATURE-----

--yhu3ebu6ybc3o4aj--

