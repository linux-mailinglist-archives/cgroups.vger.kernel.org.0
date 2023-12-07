Return-Path: <cgroups+bounces-892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8519808D8D
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1071F21409
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACEA40C19;
	Thu,  7 Dec 2023 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lAECtclf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HNBCnP6J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17C10F3
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 08:37:09 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA1751FB9C;
	Thu,  7 Dec 2023 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701967028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lC/9sJIQtdb20KFSBLKzQkparSg+XZznezebtOT4XM4=;
	b=lAECtclffs8VgIkacF4gJBtAWzx7hZVufT+//MtigmEOusCrrXho8Zj2htYQ7dj89MFbrK
	hTrJZAow1suDwlXiucIRp4cNqQukb3q+GIZiEw9OCtCpu/ahJLoghiMaVVr9q9mVRs96P9
	xqdMdzHpRf/V4wpU9pSBjMSwROmOqw0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701967027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lC/9sJIQtdb20KFSBLKzQkparSg+XZznezebtOT4XM4=;
	b=HNBCnP6Jb74oS5G7N9N5FMXTKeYkXeHTzGdop5g1+059/752BRpNJLDlUnhhZNYrTmd8fn
	58MSzBiE44WtmBE51W3D3ChoTly3PPG1eZTgxtc4WxewSvuuc0n7a63g8sU12mozbV568/
	oBp7ysYWr2XoCof845U7RqPhTfgXoFw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E18D013B95;
	Thu,  7 Dec 2023 16:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 277ANrP0cWV+UAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 07 Dec 2023 16:37:07 +0000
Date: Thu, 7 Dec 2023 17:37:06 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: donoban <donoban@riseup.net>
Cc: cgroups@vger.kernel.org
Subject: Re: EOPNOTSUPP while trying to enable memory on
 cgroup.subtree_control
Message-ID: <6alnige6ue22honr2a5a3k255ikvosanp2f4za3musgseadzki@6alspejj3hvp>
References: <rare3lakkfrp7lkcfosuhivot6vuwuuwkgj74bbzmsjjpgwkt7@udo2e6layb3d>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sztxe6llea5tnkcz"
Content-Disposition: inline
In-Reply-To: <rare3lakkfrp7lkcfosuhivot6vuwuuwkgj74bbzmsjjpgwkt7@udo2e6layb3d>
X-Spam-Level: 
X-Spam-Score: -1.70
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.90
X-Spamd-Result: default: False [-2.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO


--sztxe6llea5tnkcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Dec 07, 2023 at 11:25:09AM +0000, donoban <donoban@riseup.net> wrot=
e:
> 'cgroup.type' is "domain threaded", I'm not sure if it affects.

It does. Memory controller cannot be passed down to a threaded subtree (i.e=
=2E you
only get memcg for the whole `docker` subtree) because memory controller
is not threaded (e.g. two threads that share memory space but could be
in two different cgroups make no sense for such a controller).

> Any clue? Is there some bug here or could be some problem with kernel
> build/config?

And why your cgroup subtree is threaded? I suspect because of some
threaded controllers were passed down [1] the tree while there are also some
internal node processes (see cgroups(7) paragraph beginning with: "The
second way of creating a threaded subtree").

To get out of this, your docker(?) needs to migrate all processes down
=66rom `docker` cgroup before enabling the memory controller.

HTH,
Michal

[1] `cat /sys/fs/cgroup/docker/cgroup.subtree_control` should tell you

--sztxe6llea5tnkcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZXH0sAAKCRAGvrMr/1gc
jhzLAP4rRkA7ICiLGDo3d7XnqNlxV++xkid26+Vl/Jvilf31AAEAsbwzHaOWEGl2
Lq5TGGYN8MCVDeEYtaK2zZab1hjF+gI=
=+5pv
-----END PGP SIGNATURE-----

--sztxe6llea5tnkcz--

