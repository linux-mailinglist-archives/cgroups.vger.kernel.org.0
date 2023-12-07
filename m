Return-Path: <cgroups+bounces-896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E57808F8B
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233CCB20BA0
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688294B5D9;
	Thu,  7 Dec 2023 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OJgFe+nK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OJgFe+nK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3355F12E;
	Thu,  7 Dec 2023 10:04:51 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B24491FBAB;
	Thu,  7 Dec 2023 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701972289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLjVSgLSr+DpQGgWVegzMuPTYBiHHcVlQ4ufqsDcJ/g=;
	b=OJgFe+nKua0/xlo/z1goVpC2DyPrWMgAegzOVxR2NRz/rTQiMN6yvM31QEb4+WL1vKRuoc
	MDIC4wO6O8q8zk/e0NcqmuW3J+6jQQYbTjMRIbkt4uBAw23actuIQvY5BwhQdHkoo5GQSr
	M3dy5a7opaNZYEqTeADtYni5e9/opcU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701972289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLjVSgLSr+DpQGgWVegzMuPTYBiHHcVlQ4ufqsDcJ/g=;
	b=OJgFe+nKua0/xlo/z1goVpC2DyPrWMgAegzOVxR2NRz/rTQiMN6yvM31QEb4+WL1vKRuoc
	MDIC4wO6O8q8zk/e0NcqmuW3J+6jQQYbTjMRIbkt4uBAw23actuIQvY5BwhQdHkoo5GQSr
	M3dy5a7opaNZYEqTeADtYni5e9/opcU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE1C139E3;
	Thu,  7 Dec 2023 18:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 07E6JkEJcmX5aQAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 07 Dec 2023 18:04:49 +0000
Date: Thu, 7 Dec 2023 19:04:48 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of
 cgroup_root
Message-ID: <z7363pa5vy6trlioqe2eczgz2yfww2xqzxf3ocbqvgc4jvb7vk@rubf3ey4ktoh>
References: <20231207134614.882991-1-longman@redhat.com>
 <65h3s447i3fkygdtilucda2q6uaygtzfpxb6vsjgwoeybwwgtw@6ahmtj47ggzh>
 <5c35f648-88cc-4de2-91d7-fb95ceae15b9@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7ko5kwlhvwt5kqj"
Content-Disposition: inline
In-Reply-To: <5c35f648-88cc-4de2-91d7-fb95ceae15b9@redhat.com>
X-Spam-Level: 
X-Spam-Score: -1.63
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.89
X-Spamd-Result: default: False [-2.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-1.49)[91.64%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,bytedance.com,cmpxchg.org,gmail.com,vger.kernel.org,canb.auug.org.au,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO


--x7ko5kwlhvwt5kqj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 12:40:33PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> CONFIG_LOCKDEP and some other debug configs are enabled with allmodconfig.

Interesting, I had CONFIG_LOCKDEP=3Dy.

I shared the numbers to rule out you're after something unrelated

> However, I can reproduce the build failure and the patch is=A0 able to
> fix it.

That is a good proof :-)
The patch makes sense for future robustness,

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--x7ko5kwlhvwt5kqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZXIJPAAKCRAGvrMr/1gc
jikeAQDBVBhL2ZmHFJhCrUslotrq1E5GyDUl+G6/YhtK0soS+wEAoU5+JKfzLD3g
flBe5ZR5rcUuFM0IQuz24EHcyW+WsA0=
=v72Q
-----END PGP SIGNATURE-----

--x7ko5kwlhvwt5kqj--

