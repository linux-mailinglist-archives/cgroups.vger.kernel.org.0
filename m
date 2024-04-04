Return-Path: <cgroups+bounces-2313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0C8982DB
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B67128755A
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0C5D73B;
	Thu,  4 Apr 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LkVVivGp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822F5FEE3
	for <cgroups@vger.kernel.org>; Thu,  4 Apr 2024 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218186; cv=none; b=QRZR0yCd1m8DUZ7Q5N1YeO/PgIlTZ2p9vFNfnrYHVt/LVD0TfH8EnWFGM/tbElfgSkMxMvTXI3C0bmmVxozRQLsE2cPM2xIBPuQtmE2e9LqN1XCEJSb7+NYsymICawN8jfcer8MumWclZVS+wUu3GHRdmQ+lwneTBuhbLM3Aoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218186; c=relaxed/simple;
	bh=+RETk7LMLu0DOLsrdCcWL8qaTl4HgQomZlIPuSp3UFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWWcbBVMcpj+WCHKA8JSv4oDz7rluJFMFJPoe99jMknBLhtO4BzWP0JwMqWGKou5STD3xGu7aN821gNulM/F7p/9nm3yzdYUcs0VnuZxoflRzr8A8TEjlOYCXfMCLn0Dl1LWdYUxgeu4W2rSmcUAyx84DqapkeYMpTDGNB6+r/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LkVVivGp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88DDD37967;
	Thu,  4 Apr 2024 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712218181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6n6DByyXKoNuba0GvN+yYLk2T66kNe4KnkeA5kQZZM=;
	b=LkVVivGp3FuSbo++NVtCTQWd7pk/rUsr3Sd12+ajiGB69i5QHYTkVNLJFe2x4TGnOCfPof
	hjL9IWwR+rDMhcL/hRJ1FDaMfJVw8ZcByp22zbyKzJ5Z5UkEJAqCLT/kol/eVYkH6X869U
	lsiqZtAEgVWEnOJgUfV2IrV8eobqWNw=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 79FFD13298;
	Thu,  4 Apr 2024 08:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 22RRHUVgDmbCCAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 04 Apr 2024 08:09:41 +0000
Date: Thu, 4 Apr 2024 10:09:40 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Malat <oss@malat.biz>
Cc: cgroups@vger.kernel.org, tj@kernel.org, longman@redhat.com
Subject: Re: Re: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective
 independent of cpuset.cpus
Message-ID: <7smfbqhzzl7pggwvdleq4uj4iqixdeaj5gqaccsiwtepswygmm@bubny2ul3ihg>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <20240321213945.1117641-1-oss@malat.biz>
 <xdx55wvvss44viwmszsss2tohyslirqu3jrrexroyc5knamful@2sdajjhw45sj>
 <Zg4uaCep1Sg6Ynkl@ntb.petris.klfree.czf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qifcv7qyb263kco4"
Content-Disposition: inline
In-Reply-To: <Zg4uaCep1Sg6Ynkl@ntb.petris.klfree.czf>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.90)[85.97%]
X-Spam-Level: 
X-Spam-Flag: NO


--qifcv7qyb263kco4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 06:36:56AM +0200, Petr Malat <oss@malat.biz> wrote:
> So there is no point in creating B and one could use A directly.

There indeed isn't in this example.

Consider siblings A/B and A/C. B would have configured cpus (and
possibly be a partition root) while C is generally uninterested in
cpuset so would not be configured. (Setup like this is encountered more
easily on unified hierarchy where the tree is already organized without
cpuset considerations.)

If B took all A's CPUs, it would be an invalid partition, otherwise C
would use the remaining CPUs implicitly.

Documentation/admin-guide/cgroup-v2.rst already tries to describe
something like that:

        An empty value indicates that the cgroup is using the same
        setting as the nearest cgroup ancestor with a non-empty
        "cpuset.cpus" or all the available CPUs if none is found.

But it doesn't work like that (kernel 6.7.9):
	# cd /sys/fs/cgroup=20
	# echo +cpuset >cgroup.subtree_control
	# cat init.scope/cpuset.cpus
	   (empty is possible)
	# cat init.scope/cpuset.cpus.effective
	0-7
=09
	# echo 3 >init.scope/cpuset.cpus
	# cat init.scope/cpuset.cpus.effective
	3
	echo "" >init.scope/cpuset.cpus
	# cat init.scope/cpuset.cpus
	3  (I'd expect empty again)

IOW, cpuset cgroup can have empty cpuset.cpus when it's freshly created
but it seems it cannot be reset back to such an indifferent state.

(To match it to the previous example A/C=3D=3Dinit.scope, A/B would be some
foo.service (under -.slice) that requires configured cpuset.)

Michal

--qifcv7qyb263kco4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZg5gQgAKCRAGvrMr/1gc
jmreAQCdAmax+F++o0+0AZqNhgYRcmcEQ2SGijWyslGen6rMHAEA2ixipr86icZ1
iDrl418Swvus6Xq30NamAWb+HC1xaAU=
=6Ni/
-----END PGP SIGNATURE-----

--qifcv7qyb263kco4--

