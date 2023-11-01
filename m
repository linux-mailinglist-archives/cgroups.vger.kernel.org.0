Return-Path: <cgroups+bounces-141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81A7DE2FE
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF24CB20F94
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98E1427E;
	Wed,  1 Nov 2023 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JkkSKAbB"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858711CAA
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 15:29:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C10102
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 08:29:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96E6621A17;
	Wed,  1 Nov 2023 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1698852553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0033M7BgBhzHmBZuazXv/Y6r4rqY5z+jPe6fPM5VS0=;
	b=JkkSKAbBxrpkMsqR1AiIjrhDxsxQneGyT2uV/y38WUL+NFgAiI4NlucxSYzvfmXYkp/s5A
	yukd4Jo9cs+Oihc6GnZtdnSwcX3+45xVW84mmieHB10VCN+F5jAEisVUDoA0SR4m7S6m3W
	aiaLSDVtjuhea+b64H+cBID4SaARbOc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 757511348D;
	Wed,  1 Nov 2023 15:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id st/PG8luQmXvJgAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 01 Nov 2023 15:29:13 +0000
Date: Wed, 1 Nov 2023 16:29:12 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
Message-ID: <tejgnlgx3yr6vktof6kkje26b445aw2y5f2umrpraoas2jpgbl@eamdjvqfvvel>
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
 <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
 <CABdmKX2jJZiTwM0FgQctqBisp3h0ryX8=2dyAgbPOM8+NugM6Q@mail.gmail.com>
 <5quz2zmnv4ivte6phrduxrqqrcwanp45lnrxzesk4ykze52gx7@iwfkmy4shdok>
 <CABdmKX0h6oi7VE=rzSAvCFGPHhG6jWh+7k1_p6SwV5dYGcUPDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vjof2ccpxjftbjpt"
Content-Disposition: inline
In-Reply-To: <CABdmKX0h6oi7VE=rzSAvCFGPHhG6jWh+7k1_p6SwV5dYGcUPDQ@mail.gmail.com>


--vjof2ccpxjftbjpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2023 at 11:29:56AM -0700, "T.J. Mercier" <tjmercier@google.com> wrote:
> The cgroup_is_populated check in cgroup_destroy_locked is what's
> currently blocking the removal, and in the case where
> nr_populated_csets is not 0 I think we'd need to iterate through all
> csets and ensure that each task has been signaled for a SIGKILL.

> Or just ensure there are only dying tasks and the thread group leader
> has 0 for task->signal->live since that's when cgroup.procs stops
> showing the process?

Yeah, both of these seem too complex checks when most of the time the
"stale" nr_populated_csets is sufficient (and notifications still).

(Tracking nr_leaders would be broken in the case that I called "group
leader separation".)

> Yes, I just tried this out and if we check both cgroup.procs and
> cgroup.threads then we wait long enough to be sure that we can rmdir
> successfully.

Thanks for checking.

> Interesting case, and in the same part of the code. If one of the exit
> functions takes a long time in the leader I could see how this might
> happen, but I think a lot of those (mm for example) should be shared
> among the group members so not sure exactly what would be the cause.

I've overlooked it at first (focused on exit_mm() only) but the
reproducer is explicit about enabled kernel preemption which extends the
gap quite a bit.

(Fun fact: I tried moving cgroup_exit() next to task->signal->live
decrement in do_exit() and test_core cgroup selftest still passes.
(Not only) the preemption takes the fun out of it though.)

Michal


--vjof2ccpxjftbjpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZUJuxgAKCRAGvrMr/1gc
jlsZAP93UXLbtlVFlU3m8/0UInRVnnEc/EwJ/NPOc+z7GL085wD+INsRxMOyN6T8
1/+/n/hVyB1mdx1c4Yrn12Q0EDSlpwY=
=tBnA
-----END PGP SIGNATURE-----

--vjof2ccpxjftbjpt--

