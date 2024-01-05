Return-Path: <cgroups+bounces-1093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A774825118
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5631C22F12
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE4249F3;
	Fri,  5 Jan 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p1Gvid2Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tqecptw3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16524201;
	Fri,  5 Jan 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F05761F850;
	Fri,  5 Jan 2024 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704447908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjMAyVdiebrt/Q0pS2dmmJub9qx0XoEkNWeuoUlkfwo=;
	b=p1Gvid2Yx7rB6xquGDuCYppBhbc/gAtKc0wrv0gBT50BqlzJK8hTKFQrytCCjyOzHWLfbE
	Y2XGpbQrz1c7Q21Zex4/mE+1dqaHMGda58PuiBXIVOfXVJlhO8bcPm8+xGa+sclP5720lq
	1jW4vWn0cOfeFiuLR8q9NrkKVPpNXnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704447907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjMAyVdiebrt/Q0pS2dmmJub9qx0XoEkNWeuoUlkfwo=;
	b=Tqecptw3BTnIUZiudoZwWXFz8DvrhvVQ0cdCR01ZJWtLoMYC076yGW/+VYDFm0jYgsOFWe
	9XhBmBIqpkC/1O3YAtp2rYCgoCC3vXVrS9ggqVEcJJ0V4NRKYrrUJNQcVQxP0nnzdtm9Dk
	/+AT7ckcg18sWIFSJ0Q9pX8pMUvyYqg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8D5413C99;
	Fri,  5 Jan 2024 09:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5C6NKPPl2WQUgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 05 Jan 2024 09:45:07 +0000
Date: Fri, 5 Jan 2024 10:45:02 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org, 
	cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, sohil.mehta@intel.com, zhiquan1.li@intel.com, 
	kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com, anakrish@microsoft.com, 
	mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v6 01/12] cgroup/misc: Add per resource callbacks for CSS
 events
Message-ID: <5qfjx2vvirtffkro5u6zdbbwia2bhhbjxwgij2igdnxk5hysaq@kpqboajvuzbc>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-2-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkycr2ejudi4nnse"
Content-Disposition: inline
In-Reply-To: <20231030182013.40086-2-haitao.huang@linux.intel.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-0.00)[19.25%];
	 ARC_NA(0.00)[];
	 URIBL_BLOCKED(0.00)[intel.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.90


--gkycr2ejudi4nnse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:20:02AM -0700, Haitao Huang <haitao.huang@linux.=
intel.com> wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>=20
> The misc cgroup controller (subsystem) currently does not perform
> resource type specific action for Cgroups Subsystem State (CSS) events:
> the 'css_alloc' event when a cgroup is created and the 'css_free' event
> when a cgroup is destroyed.
>=20
> Define callbacks for those events and allow resource providers to
> register the callbacks per resource type as needed. This will be
> utilized later by the EPC misc cgroup support implemented in the SGX
> driver.

I notice now that the callbacks are per resource and per cgroup.
I think that is an overkill that complicates misc_cg allocation code
with parent's callbacks while freeing is done by own callbacks.
It's possibly too much liberal to keep objects' lifecycle understandable
in the long term too.=20

For some uniformity, I'd suggest struct blkcg_policy array in
block/blk-cgroup.c as the precedent. (Perhaps indexed with static enum
misc_res_type instead of dynamic index assignment as
blkcg_policy_registeer() does.)

I hope you don't really need per-cgroup callbacks :-)

Michal

--gkycr2ejudi4nnse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZZfPnAAKCRAGvrMr/1gc
jiP8AP0Q8YvyVS22t8yNx/wVtFr60JLTA5zAgGTIFU7k+w/G+AEA9Jr2ZtxN0QWV
FYzPie0m1EL3RCqoPrIQleZGYmOfMAw=
=d7Pm
-----END PGP SIGNATURE-----

--gkycr2ejudi4nnse--

