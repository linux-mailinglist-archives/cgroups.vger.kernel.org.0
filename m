Return-Path: <cgroups+bounces-893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E99808DB7
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2563F281A08
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5540BF3;
	Thu,  7 Dec 2023 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nK/helao";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nK/helao"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5B010D1;
	Thu,  7 Dec 2023 08:46:07 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A62071FBAA;
	Thu,  7 Dec 2023 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701967565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4o5AJYQxRQ7xI7OJGpx4sGxsNO6SfxiY/aIwYIlBMw=;
	b=nK/helao8UuRYPbf5PTb5WnKD2dW1pIgAbiTjBiHsPy5TwwiKzduacVuf+XBYbDzqqc0XB
	Py+coW3Htj10SCh519vgWzg2uwfFBguI7UqXhD/PpWd6ULfELsB8I8CdT3cYHQGQSjxXlv
	vTv/uEeM+oxaAhNuDKt7zqJ3jOw8/YE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701967565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4o5AJYQxRQ7xI7OJGpx4sGxsNO6SfxiY/aIwYIlBMw=;
	b=nK/helao8UuRYPbf5PTb5WnKD2dW1pIgAbiTjBiHsPy5TwwiKzduacVuf+XBYbDzqqc0XB
	Py+coW3Htj10SCh519vgWzg2uwfFBguI7UqXhD/PpWd6ULfELsB8I8CdT3cYHQGQSjxXlv
	vTv/uEeM+oxaAhNuDKt7zqJ3jOw8/YE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 91A68139E3;
	Thu,  7 Dec 2023 16:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Drj4Is32cWUSUwAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 07 Dec 2023 16:46:05 +0000
Date: Thu, 7 Dec 2023 17:46:04 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of
 cgroup_root
Message-ID: <65h3s447i3fkygdtilucda2q6uaygtzfpxb6vsjgwoeybwwgtw@6ahmtj47ggzh>
References: <20231207134614.882991-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yoh2mfr4t3txcwc4"
Content-Disposition: inline
In-Reply-To: <20231207134614.882991-1-longman@redhat.com>
X-Spam-Level: 
X-Spam-Score: -1.40
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.40
X-Spamd-Result: default: False [-1.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,bytedance.com,cmpxchg.org,gmail.com,vger.kernel.org,canb.auug.org.au,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO


--yoh2mfr4t3txcwc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 08:46:14AM -0500, Waiman Long <longman@redhat.com> =
wrote:
> Commit 77070eeb8821 ("cgroup: Avoid false cacheline sharing of read
> mostly rstat_cpu") happens to be the last straw that breaks it.

FTR, when I build kernel from that commit, I can see

> struct cgroup_root {
> 	struct kernfs_root *       kf_root;              /*     0     8 */
> 	unsigned int               subsys_mask;          /*     8     4 */
> 	int                        hierarchy_id;         /*    12     4 */
>=20
> 	/* XXX 48 bytes hole, try to pack */
>=20
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct cgroup              cgrp __attribute__((__aligned__(64))); /*    =
64  2368 */
>=20
> 	/* XXX last struct has 8 bytes of padding */
>=20
> 	/* --- cacheline 38 boundary (2432 bytes) --- */
> 	struct cgroup *            cgrp_ancestor_storage; /*  2432     8 */
> 	atomic_t                   nr_cgrps;             /*  2440     4 */
>=20
> 	/* XXX 4 bytes hole, try to pack */
>=20
> 	struct list_head           root_list;            /*  2448    16 */
> 	struct callback_head       rcu __attribute__((__aligned__(8))); /*  2464=
    16 */
> 	unsigned int               flags;                /*  2480     4 */
> 	char                       release_agent_path[4096]; /*  2484  4096 */
> 	/* --- cacheline 102 boundary (6528 bytes) was 52 bytes ago --- */
> 	char                       name[64];             /*  6580    64 */
>=20
> 	/* size: 6656, cachelines: 104, members: 11 */
> 	/* sum members: 6592, holes: 2, sum holes: 52 */
> 	/* padding: 12 */
> 	/* paddings: 1, sum paddings: 8 */
> 	/* forced alignments: 2, forced holes: 1, sum forced holes: 48 */
> } __attribute__((__aligned__(64)));

2480 has still quite a reserve below 4096. (I can't see an CONFIG_*
affecting this.)

Perhaps, I missed something from the linux-next merging thread?


Michal

--yoh2mfr4t3txcwc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZXH2ygAKCRAGvrMr/1gc
jpZuAP9RgMwrR6LBFr+2ohXuCMXaICW4Vd3Wj2jt2+aVwhZUMwEAv+h6B/ZFotnw
BWbde0bO3MEumhkx4R695l/j/sSxdws=
=dUG2
-----END PGP SIGNATURE-----

--yoh2mfr4t3txcwc4--

