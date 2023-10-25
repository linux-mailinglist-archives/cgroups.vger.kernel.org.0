Return-Path: <cgroups+bounces-79-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220EF7D6D1F
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4769E281BC0
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00B27EFD;
	Wed, 25 Oct 2023 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OSqKqfnC"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4B8480
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 13:30:51 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F0138
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 06:30:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D597321AB3;
	Wed, 25 Oct 2023 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1698240647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpsE/iODolSAuwsU8/8sfqjYISH1RTPVc8qphm7S7Wo=;
	b=OSqKqfnCusnomm6OEjc4eYrkTlYqN4CThbuk4w+tMQTlMp7GZaRRJdqYzK56X6RA7bj0G3
	Al3oDuia0Snj1HnJspp+Vqo3B/JLm1tPWS+vbBvIaOH6cvBT1LmhQ2p06z9w10N0S+lu6J
	GWRV4RI7UoYwdNpnLUKiIfoxhYcc6/Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE71113524;
	Wed, 25 Oct 2023 13:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TP6VKYcYOWV8fQAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 25 Oct 2023 13:30:47 +0000
Date: Wed, 25 Oct 2023 15:30:46 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
Message-ID: <5quz2zmnv4ivte6phrduxrqqrcwanp45lnrxzesk4ykze52gx7@iwfkmy4shdok>
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
 <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
 <CABdmKX2jJZiTwM0FgQctqBisp3h0ryX8=2dyAgbPOM8+NugM6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecqyjlww4rwo236h"
Content-Disposition: inline
In-Reply-To: <CABdmKX2jJZiTwM0FgQctqBisp3h0ryX8=2dyAgbPOM8+NugM6Q@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.93
X-Spamd-Result: default: False [-7.93 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.23)[96.38%]


--ecqyjlww4rwo236h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Tue, Oct 24, 2023 at 04:10:32PM -0700, "T.J. Mercier" <tjmercier@google.=
com> wrote:
> Back on this and pretty sure I discovered what's happening. For
> processes with multiple threads where each thread has reached
> atomic_dec_and_test(&tsk->signal->live) in do_exit (but not all have
> reached cgroup_exit yet), subsequent reads of cgroup.procs will skip
> over the process with not-yet-fully-exited thread group members
> because the read of task->signal->live evaluates to 0 here in
> css_task_iter_advance:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/cgroup/cgroup.c?h=3Dv6.5#n4869

Well done! It sounds plausible, the task->signal->live is not synced
via css_set_lock.

>=20
> But the cgroup is not removable yet because cgroup_exit hasn't been
> called for all tasks.
>=20
> Since all tasks have been signaled in this case and we're just waiting
> for the exits to complete, I think it should be possible to turn the
> cgroup into a zombie on rmdir with the current behavior of
> cgroup.procs.

In this case it could be removed but it would make the check in
cgroup_destroy_locked() way too complicated (if I understand your idea).

>=20
> Or if we change cgroup.procs to continue showing the thread group
> leader until all threads have finished exiting, we'd still probably
> have to change our userspace to accommodate the longer kill times
> exceeding our timeouts.

Provided this is the cause, you could get this more (timewise) precise
info from cgroup.threads already? (PR [1] has a reproducer and its fix
describes exactly opposite listings (confusing) but I think that fix
actually works because it checks cgroup.threads additionally.)

> So I'm going to change our userspace anyway as suggested by Tejun. But
> I'd be interested to hear what folks think about the potential kernel
> solutions as well.

Despite that, I'd stick with the notifications since they use rely on
proper synchronization of cgroup-info.

HTT,
Michal

[1] https://github.com/systemd/systemd/pull/23561

--ecqyjlww4rwo236h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZTkYhAAKCRAGvrMr/1gc
jlZxAQCkWW9yAjE0jidCtWlVy87sFkPFoWC9JHgst2KKhpattAD6Asr6PQ8a+hrM
I7WG4DAilr2idj+ULfUyd9sErjJRPQI=
=QhDQ
-----END PGP SIGNATURE-----

--ecqyjlww4rwo236h--

