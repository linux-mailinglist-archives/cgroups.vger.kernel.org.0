Return-Path: <cgroups+bounces-143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E72EF7DE449
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 16:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D725B21001
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBF1427E;
	Wed,  1 Nov 2023 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CffbJxxM"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25111C8E;
	Wed,  1 Nov 2023 15:56:55 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E190FD;
	Wed,  1 Nov 2023 08:56:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD9761F74D;
	Wed,  1 Nov 2023 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1698854208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhOU82J6gtFbXATOdYHg9ph1z7E+qrxaje1ToC2RTQk=;
	b=CffbJxxMziIZIy4ia/GdXHp+0VgZdpc7Eg5Xw9ipYG6CMn+XjbMD+GsJkm+xTPzUMsMNcA
	0wwmtNmnBOgH+Sx1kT/C43LZAaT6Y2hEr+7WIS96B/lRcZMyDudwJy4kzZPB9GiuiA35Cf
	tAl9rkZ1ieBuy1s5x5gB7slhsmnKhgA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89AE613460;
	Wed,  1 Nov 2023 15:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NlreIEB1QmXcMwAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 01 Nov 2023 15:56:48 +0000
Date: Wed, 1 Nov 2023 16:56:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, akpm@linux-foundation.org, 
	kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1] tools/cgroup: introduce cgroup v2 memory.events
 listener
Message-ID: <eqvaejfo5uoz5m7e5g3wjgegfo4ribajdgu57fst3hu5m6gfa4@beugaul6pjjz>
References: <20231013184107.28734-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2vvgyykebaacuqp"
Content-Disposition: inline
In-Reply-To: <20231013184107.28734-1-ddrokosov@salutedevices.com>


--n2vvgyykebaacuqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

I think the tools/cgroup/cgroup_event_listener.c was useful in the past
to demonstrate the non-traditional API of cgroup.event_control with FDs
passing left and right.


On Fri, Oct 13, 2023 at 09:41:07PM +0300, Dmitry Rokosov <ddrokosov@saluted=
evices.com> wrote:
> This is a simple listener for memory events that handles counter
> changes in runtime. It can be set up for a specific memory cgroup v2.

Event files on v2 are based on more standard poll or inotify APIs so
they don't need such a (cgroup specific) demo. Additionally, the demo
program lists individual events, so it'd be a maintenance burden to keep
them in sync with the kernel implementation.

My .02=E2=82=AC,
Michal

--n2vvgyykebaacuqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZUJ1PQAKCRAGvrMr/1gc
jvhcAQCUjTNWbtpe3NaqFagBmyBnMYqk8L1TerFT4RmMIyjOWwD/fvrevKAsZOxp
e6hUE/uLByN0AfsTqVtXgPo/ZtnjYwo=
=9QWy
-----END PGP SIGNATURE-----

--n2vvgyykebaacuqp--

