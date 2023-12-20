Return-Path: <cgroups+bounces-983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F481A534
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2961C2090F
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD42BB0C;
	Wed, 20 Dec 2023 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k6uVNW/8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k6uVNW/8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6C47764;
	Wed, 20 Dec 2023 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5A741FD8F;
	Wed, 20 Dec 2023 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703090018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3txGCFnv+fFGAn/7zE+fM+oGbA7UAP/Dw8mQZx9T5Wc=;
	b=k6uVNW/8MLmwVi2RRg1ophEOLDD2h1C6eVfDbqwlvIBxGesBwodkyTZ6syuWX6UL1dZaMF
	TpO7/yzHNckEH0jg0VYrZXyBtCvmtb2U8QjhV0iSgFGkqkfcyckoSLKWqSrcygt2vd24wS
	TMjYITwor0mP4NTnQQtshqMsy+3sTSc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703090018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3txGCFnv+fFGAn/7zE+fM+oGbA7UAP/Dw8mQZx9T5Wc=;
	b=k6uVNW/8MLmwVi2RRg1ophEOLDD2h1C6eVfDbqwlvIBxGesBwodkyTZ6syuWX6UL1dZaMF
	TpO7/yzHNckEH0jg0VYrZXyBtCvmtb2U8QjhV0iSgFGkqkfcyckoSLKWqSrcygt2vd24wS
	TMjYITwor0mP4NTnQQtshqMsy+3sTSc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A9F2B13927;
	Wed, 20 Dec 2023 16:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lii8KGIXg2UBPAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 20 Dec 2023 16:33:38 +0000
Date: Wed, 20 Dec 2023 17:33:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Message-ID: <4fqs4cgvon3gk6lxtltjdxshau7qlw7fdawkrdje2o4klfc3kp@kh7phzqls4jo>
References: <20231208093310.297233-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnfj44t3athyinw4"
Content-Disposition: inline
In-Reply-To: <20231208093310.297233-1-max.kellermann@ionos.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.65
X-Spamd-Result: default: False [-3.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.75)[84.14%]
X-Spam-Flag: NO


--jnfj44t3athyinw4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 10:33:09AM +0100, Max Kellermann <max.kellermann@io=
nos.com> wrote:
>  kernel/cgroup/cgroup.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)

Nice,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--jnfj44t3athyinw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZYMXWwAKCRAGvrMr/1gc
jvPPAQDL62W9HhhXWuOmbmqIAR9YgSAEtdsl7gbff3g/rpMJZgD+MtmIIU5iY/Pm
b9tWFt+Ofdhfyx188kEtJ+Hesi2nBAQ=
=TFxT
-----END PGP SIGNATURE-----

--jnfj44t3athyinw4--

