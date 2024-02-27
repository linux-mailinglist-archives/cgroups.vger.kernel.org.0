Return-Path: <cgroups+bounces-1871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B3868C2C
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60FE1C202D5
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D613665F;
	Tue, 27 Feb 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o78DBzFV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o78DBzFV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82986135A6A;
	Tue, 27 Feb 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025970; cv=none; b=ReV2SEbASrcsM/tEGUIOyQeD11xQoY2/PHZRVuhGXsp0QRhgWZkmIvxPQdBf3+hoBA4ViEpESncI0voGQF8poG9X6lAClN40io1AmGSGvcnP/4GmbXDo8d2ktFnYVDH7a0oCQClAJ8yNklxyhaQqeVM9pnKzZwoSZ/X6hBWOuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025970; c=relaxed/simple;
	bh=AV2g7x0ZOwdpFQAqqqsupfpbYCDFszGJNfaXqw2PErY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwXg3tu98wJQ4Vve68WyX+dM6b0EefQ2rHGXy3bIKd3IQzuuQ6ARrp+7YEs45PPlwdtbusyE8UQB4sopA/tafcGhg1lKEVTOh3MCIUB2gM+E8AU4b8PW+nxyDXog9kxxrTD4+OMCq1PZq3O/9esLBv3pSVg5QLsjViw7RrVcahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o78DBzFV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o78DBzFV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548101F44B;
	Tue, 27 Feb 2024 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709025964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AV2g7x0ZOwdpFQAqqqsupfpbYCDFszGJNfaXqw2PErY=;
	b=o78DBzFVfaaMsZwIDFMng7AX6nAFB6C+qrsPZuR9yH7ebz4LQNm83BxfazGxZ9uY3x9iSE
	ltgMHPJx3Onc/OmnYlRCYIVD4RFyg07vVxG3Vj4oZg4w0IkLHRG1CsaUEKypOssQMSBZrA
	Ce0xYZtn8TCcjtJrjesUpiXb/qs1hw0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709025964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AV2g7x0ZOwdpFQAqqqsupfpbYCDFszGJNfaXqw2PErY=;
	b=o78DBzFVfaaMsZwIDFMng7AX6nAFB6C+qrsPZuR9yH7ebz4LQNm83BxfazGxZ9uY3x9iSE
	ltgMHPJx3Onc/OmnYlRCYIVD4RFyg07vVxG3Vj4oZg4w0IkLHRG1CsaUEKypOssQMSBZrA
	Ce0xYZtn8TCcjtJrjesUpiXb/qs1hw0=
Date: Tue, 27 Feb 2024 10:26:03 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, "tj@kernel.org" <tj@kernel.org>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>, 
	"Zhang, Bo" <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, 
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Message-ID: <wz5s5gocjwceojh4by6pvhreggw7zalethwo32ljxar3zswnow@d7v3hn2qwctp>
References: <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
 <d9b0df06-da68-4729-8aac-2a77e890e152@intel.com>
 <op.2jrquskiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksqmcolhrndbzaus"
Content-Disposition: inline
In-Reply-To: <op.2jrquskiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.88
X-Spamd-Result: default: False [-2.88 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.18)[-0.922];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.00)[22.14%]
X-Spam-Flag: NO


--ksqmcolhrndbzaus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Feb 26, 2024 at 03:48:18PM -0600, Haitao Huang <haitao.huang@linux.=
intel.com> wrote:
> In case of overcomitting, i.e., sum of limits greater than the EPC capaci=
ty,
> if one group has a fault, and its usage is not above its own limit
> (try_charge() passes), yet total usage of the system has exceeded the
> capacity, whether we do global reclaim or just reclaim pages in the curre=
nt
> faulting group.
>=20
> > Also, what does the core mm memcg code do?
> >=20
> I'm not sure. I'll try to find out but it'd be appreciated if someone more
> knowledgeable can comment on this. memcg also has the protection mechanism
> (i.e., min, low settings) to guarantee some allocation per group so its
> approach might not be applicable to misc controller here.

I only follow the discussion superficially but it'd be nice to have
analogous mechanisms in memcg and sgx controller.

The memory limits are rather simple -- when allocating new memory, the
tightest limit of ancestor applies and reclaim is applied to whole
subtree of such an ancestor (not necessearily the originating cgroup of
the allocation). Overcommit is admited, competition among siblings is
resolved on the first comes, first served basis.

The memory protections are an additional (and in a sense orthogoal)
mechanism. They can be interpretted as limits that are enforced not at
the time of allocation but at the time of reclaim (and reclaim is
triggered independetly, either global or with the limits above). The
consequence is that the protection code must do some normalization to
evaluate overcommited values sensibly.

(Historically, there was also memory.soft_limit_in_bytes, which combined
"protection" and global reclaim but it turned out broken. I suggest
reading Documentation/admin-guide/cgroup-v2.rst section Controller
Issues and Remedies/Memory for more details and as cautionary example.)

HTH,
Michal

--ksqmcolhrndbzaus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZd2qqQAKCRAGvrMr/1gc
jpqeAP9p9303GerwhSN+u/jfAVtaDaMZNVnW9y8mi5Y8wwbX9wD/QAsthQ0lsxca
Gaywp98WdnvlIFy1wDF4VD3bMJlbCAk=
=yTmB
-----END PGP SIGNATURE-----

--ksqmcolhrndbzaus--

