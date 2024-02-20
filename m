Return-Path: <cgroups+bounces-1709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896685BCFF
	for <lists+cgroups@lfdr.de>; Tue, 20 Feb 2024 14:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34029B213EE
	for <lists+cgroups@lfdr.de>; Tue, 20 Feb 2024 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644F6A035;
	Tue, 20 Feb 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SK62GqNJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UAJcSX72"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB769DE4;
	Tue, 20 Feb 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435122; cv=none; b=ImQOWAK41kWZsi/mUBCsM9THR7A652LPsUEJ2Kud508dNoqePc5ZEzYXtZrGpS34LAhwQZelz6QZgWkW+7m1aGFFH2WzUh6SvE2IuI++rYT9IyEweVCDS7w6MtDyv8bUP3UCgzlHOl4fQIYU81qw7DCYOQdUdPDesmValehdTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435122; c=relaxed/simple;
	bh=UV/cpuRtRlaCri5lx4C7nu174G6nc2pEi2+tO4UB9kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K37vF0n78ZqtNQAEdGazBeR/sFW0TYh+CoA7Si8f7gamKJDfOHaqUkrtu35Y7wwNhntPehIU9Yj4MmcEFjU7iFIPXZ+cbwOgUzgNbxfoNWu/13WT5ThWyoG8bMPWbcpVKKLgcmHHkLxtTT4q/3aIPC108wXnY0NchUuPKT4v4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SK62GqNJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UAJcSX72; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5D7B21DFD;
	Tue, 20 Feb 2024 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708435117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UV/cpuRtRlaCri5lx4C7nu174G6nc2pEi2+tO4UB9kI=;
	b=SK62GqNJCm6uU0Fa4MBbStGEj9foFB5OuS97qZTajQ5GavoJZZyohkDN2/S2NQ4yXptyja
	+DWu6c9EZjfxoWm7joQohVu1tY9NJfo4yCkD3dPnr278iRH2e99zbKlH6CMX2C20QfLQMX
	NrKAht9SApV9h66DG8DRA5nctCrCPZQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708435116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UV/cpuRtRlaCri5lx4C7nu174G6nc2pEi2+tO4UB9kI=;
	b=UAJcSX72EekECg5QLU6R/pfmVEasbhaK81mjqzyFjuZtSTHNNOuFX3oFrysF3XDF7t4Hw3
	xBNEkenU+Q1qasUgYjsAgdpEN+7ET613iEuIYgSvuwSfaC84n/Pnp4XdLIh9KygOcLOYmi
	dAMbtPCRLqwXmIcEjM5XxxCnftZsVKo=
Date: Tue, 20 Feb 2024 14:18:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, 
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>, 
	"Zhang, Bo" <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, 
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows
 for cgroup
Message-ID: <2ni2jychs6oe4ckplvbg7usrn7f4fsa2fi3ys6lrtyhbprpr7c@hokylc73dlwi>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwjkzrolygogphrr"
Content-Disposition: inline
In-Reply-To: <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.24
X-Spamd-Result: default: False [-4.24 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.17)[-0.867];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-1.37)[90.67%]
X-Spam-Flag: NO


--nwjkzrolygogphrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 09:52:39AM +0000, "Huang, Kai" <kai.huang@intel.com> wrote:
> I am not sure, but is it possible or legal for an ancestor to have less limit
> than children?

Why not?
It is desired for proper hiearchical delegation and the tightest limit
of ancestors applies (cf memory.max).

Michal

--nwjkzrolygogphrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZdSmqQAKCRAGvrMr/1gc
jkKzAQDey//gJluYyxAmAACFkpQEQZs7Wq4LdwtcKfaXOfgwmwD8D4Tj0lWyyCDt
aiID/E7nvQWorGQQc1J6VlBjBfMhagU=
=CG6M
-----END PGP SIGNATURE-----

--nwjkzrolygogphrr--

