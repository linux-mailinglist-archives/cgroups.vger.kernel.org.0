Return-Path: <cgroups+bounces-2381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26089D50F
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA1D1F22500
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2D7E798;
	Tue,  9 Apr 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LFKFhsR/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LFKFhsR/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A027E580;
	Tue,  9 Apr 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653411; cv=none; b=ngsl4Li6bbPBswnbvgk0kfGdMbE9T9ZKoCs2fu7dWd+0qydLrZNfGgAca4wmJTQUdVo7sxunOlcOJN8Ls16p2lnhursKqbIdvjV2nm6x1qE1okegDFICcG8/aHUciRgRiM8qif5p9udCZtBeNuwcY7VsHMB/Muc7TQPc9N8U7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653411; c=relaxed/simple;
	bh=h2kiHo+GgQz/ZCISfMuUvv0y5uUfdVCdxMdXR1Xy7zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVQmGUUbuSnqpx92bVQXPqxcyN4znPMQAoG9+TdWpiHY+6fnTypMhwn9PhQkJZGX+pZosX4WTOkId4jS2zCiDrMHzlDSYQGOZAZv9vz04viEPdotUp8ujzEWrRomZ3MOfpCDiIB1W+YQDCF7z7H86Bb/hoH+vyQ3cpTu2osw9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LFKFhsR/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LFKFhsR/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21BA622C8E;
	Tue,  9 Apr 2024 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712653408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvyrWquLz7geaixcVsAUQI3Ex1g1XLIRXoJG2iDV3q8=;
	b=LFKFhsR/O3HPCXRLhG6lA9hzbnDne02ClR7rfW/zzyLDNHsX6Qwj3M+hs/tUx61xlnR/Pm
	KeIJWt+2wkYO1tAV8a1eNsHwcvNjS98Nl6wgFhT2Kfh+9/rSDgoDywHh+5CQDTfmilPXkb
	8P/1X9iKX5h8BmVwPKjyGM/CXN0muzk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712653408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvyrWquLz7geaixcVsAUQI3Ex1g1XLIRXoJG2iDV3q8=;
	b=LFKFhsR/O3HPCXRLhG6lA9hzbnDne02ClR7rfW/zzyLDNHsX6Qwj3M+hs/tUx61xlnR/Pm
	KeIJWt+2wkYO1tAV8a1eNsHwcvNjS98Nl6wgFhT2Kfh+9/rSDgoDywHh+5CQDTfmilPXkb
	8P/1X9iKX5h8BmVwPKjyGM/CXN0muzk=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 095811332F;
	Tue,  9 Apr 2024 09:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5FoaAmAEFWaaQAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 09 Apr 2024 09:03:28 +0000
Date: Tue, 9 Apr 2024 11:03:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, 
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Mehta, Sohil" <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"Huang, Kai" <kai.huang@intel.com>, "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>, 
	"Zhang, Bo" <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, 
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: Re: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Message-ID: <imqjuxgmm5updfnl75molzixlq52ttlufd6sn2vpcevaby5l7f@22j23whlbvux>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-13-haitao.huang@linux.intel.com>
 <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
 <op.2lw8gfg2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7a21c0de-ba59-4e76-8d67-70957f9db581@intel.com>
 <op.2lx047lrwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltmvwvtmhbsdsweo"
Content-Disposition: inline
In-Reply-To: <op.2lx047lrwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Flag: NO
X-Spam-Score: -5.39
X-Spam-Level: 
X-Spamd-Result: default: False [-5.39 / 50.00];
	BAYES_HAM(-2.49)[97.68%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]


--ltmvwvtmhbsdsweo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 11:23:21PM -0500, Haitao Huang <haitao.huang@linux.=
intel.com> wrote:
> It's always non-NULL based on testing.
>=20
> It's hard for me to say definitely by reading the code. But IIUC
> cgroup_disable command-line only blocks operations in /sys/fs/cgroup so u=
ser
> space can't set up controllers and config limits, etc., for the diasabled
> ones. Each task->cgroups would still have a non-NULL pointer to the static
> root object for each cgroup that is enabled by KConfig, so
> get_current_misc_cg() thus  sgx_get_current_cg() should not return NULL
> regardless 'cgroup_disable=3Dmisc'.
>=20
> Maybe @Michal or @tj can confirm?

The current implementation creates root css object (see cgroup_init(),
cgroup_ssid_enabled() check is after cgroup_init_subsys()).
I.e. it will look like all tasks are members of root cgroup wrt given
controller permanently and controller attribute files won't exist.

(It is up to the controller implementation to do further optimization
based on the boot-time disablement (e.g. see uses of
mem_cgroup_disabled()). Not sure if this is useful for misc controller.)

As for the WARN_ON(1), taking example from memcg -- NULL is best
synonymous with root. It's a judgement call which of the values to store
and when to intepret it.

HTH,
Michal

--ltmvwvtmhbsdsweo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZhUEVgAKCRAGvrMr/1gc
jpkmAQDC0m6kfTm0e/ebDdbus7JzB7oXpjF+aa05c4n6JTgMZAD/cof9Y5sOlPGG
my7EEJBDBJYKcFgS8YtpUYJdZwjKvwE=
=CQHh
-----END PGP SIGNATURE-----

--ltmvwvtmhbsdsweo--

