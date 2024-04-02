Return-Path: <cgroups+bounces-2279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F4895ADA
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 19:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DF2289034
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9415AAB7;
	Tue,  2 Apr 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MYizSPNJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17415991B;
	Tue,  2 Apr 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079608; cv=none; b=F3jZAYRLMgArQsGKR8kIS0j0kQHbxuheHfO2d8qy9aT346AnFt7kBTlNB9ZMP96yBJwwXwp3WriA013mTX5P8RrFaKySO2Hm6vdXbcbvKnZDPogNgcTaw5IAQ1CcgYogWmuGTj/2wMte+dqmDoUNI+IczEycLeg/xIGWWpkNmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079608; c=relaxed/simple;
	bh=+6iOyRz9ZaM1hjjBwv9H9tsp/d85fEt5HBevd/gKSYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKlm+3xHn9Vw3Lg94VtSTDp1ufXh3ofrq/NdZrO71wpkZEhar1cwD2mgUtBimjqrYMi8Eyj2qQsHv47aEmN0tGWHM1Vrew62YYWWYaQyJCckL3OnntR0sTCaCfZ+HmQ8FiPLSzWjZ3gQXcxktqIXd58mtXnutwTGBFt1m393nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MYizSPNJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF2FD5C0B3;
	Tue,  2 Apr 2024 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712079604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5F6GGyhdpvo/TM/Z4dxkuGDKQ/Qzalz5AOzBbLucHQ=;
	b=MYizSPNJqr9GMzaMQfyIO9JwnVNU2Ig6nmXsBZqXDBHJ8R1PdmkHgbClwifgWkc7CgH54D
	XO8DenBimyBtFcyd6T79pGlsdamcvHECD+G8oRW9WBObAV/4bislB1VEBnuCLFy1WkmloS
	TqO0dFxwCjwkJl2RBltQdDyhH0r/S+g=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AF26413A90;
	Tue,  2 Apr 2024 17:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n0+TKvRCDGaRKQAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 02 Apr 2024 17:40:04 +0000
Date: Tue, 2 Apr 2024 19:40:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, dave.hansen@linux.intel.com, 
	tj@kernel.org, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, 
	x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, 
	zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com, 
	anakrish@microsoft.com, mikko.ylinen@linux.intel.com, yangjie@microsoft.com, 
	chrisyan@microsoft.com
Subject: Re: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
Message-ID: <yjremy4leipriqfd547wvjd6jt3r6t4tgz36eazy3slfuew4mc@v4iye7sm7yqn>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>
 <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
 <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>
 <D09MB26IPFFW.3UBD7M0S17SG6@kernel.org>
 <op.2llzn7wgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtyyx7wt5l7xfjnz"
Content-Disposition: inline
In-Reply-To: <op.2llzn7wgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spamd-Result: default: False [-1.94 / 50.00];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	BAYES_HAM(-0.04)[58.36%];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.94
X-Spam-Level: 
X-Spam-Flag: NO


--qtyyx7wt5l7xfjnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2024 at 11:20:21AM -0500, Haitao Huang <haitao.huang@linux.intel.com> wrote:
> Do we really want to have it implemented in c?

I only pointed to the available C boilerplate.

> There are much fewer lines of
> code in shell scripts. Note we are not really testing basic cgroup stuff.
> All we needed were creating/deleting cgroups and set limits which I think
> have been demonstrated feasible in the ash scripts now.

I assume you refer to
Message-Id: <20240331174442.51019-1-haitao.huang@linux.intel.com>
right?

Could it be even simpler if you didn't stick to cgtools APIs and v1
compatibility?

Reducing ash_cgexec.sh to something like
	echo 0 >$R/$1/cgroup.procs
	shift
	exec "$@"
(with some small builerplate for $R and previous mkdirs)


Thanks,
Michal

--qtyyx7wt5l7xfjnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZgxC8AAKCRAGvrMr/1gc
jigRAP4mWe5bB10SBzjHzWt7c38yCgtq7Vmjj/SA7W8goippqAEAovEnsLpMZFKJ
LXRH+hlVdIAOhf4njhycDoJINsgoUQ0=
=Lkg+
-----END PGP SIGNATURE-----

--qtyyx7wt5l7xfjnz--

