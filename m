Return-Path: <cgroups+bounces-3356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D840391654D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA41C2355A
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EA14A4CC;
	Tue, 25 Jun 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c2VrqUPI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c2VrqUPI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098D149C61;
	Tue, 25 Jun 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311673; cv=none; b=rV+cjICwgrNzo8Uod3QxWwfyCmS/eMvn4CL0wwkV9GK9FksKuzYTzu7OmHRdGxgyUAmfMBpFy4atDOWBZZfJ1bIuKEerronHjp2KRCawcl3jwwsg1vbkTNt2is8ALzGeX/Evk31Yv3uD97x81NLMNPEdkK5Y5mtCuIhk6DBXRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311673; c=relaxed/simple;
	bh=7h2iGnNs0bYKsRaat5k6tNv0NDc9bOwiploDSqabJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK09qE/I4nVihV7wUo9PE2R4iwdvp5D0SIwHTnWBf+yy0iNR4tGgP2hvYdMOGUgbe295q8TiC+xpppvicR+KvXOLbf6h7H0dnAPdK86n2Fy0ec6oTpihCg+q60GQDDcGnTuuatzoZLZulvf0xbO6Y8d6/p3A/vVAw56apdcec4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c2VrqUPI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c2VrqUPI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD5C41F84E;
	Tue, 25 Jun 2024 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719311669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7h2iGnNs0bYKsRaat5k6tNv0NDc9bOwiploDSqabJgc=;
	b=c2VrqUPISoPbvbp0PtnEHPAjzy4Q5ua65IWk42loyaDEQweYTdg7fXsYvKhCedGAjY7DYq
	DdQWKzRU3mtWjMKf81uRA7FY3QJIph5USLG87lnHM5kp/eclHpPv+HRUQi7nHon4S5+f8c
	+9buScuxfHfDQyKN7F9phLOz25JdHwM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c2VrqUPI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719311669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7h2iGnNs0bYKsRaat5k6tNv0NDc9bOwiploDSqabJgc=;
	b=c2VrqUPISoPbvbp0PtnEHPAjzy4Q5ua65IWk42loyaDEQweYTdg7fXsYvKhCedGAjY7DYq
	DdQWKzRU3mtWjMKf81uRA7FY3QJIph5USLG87lnHM5kp/eclHpPv+HRUQi7nHon4S5+f8c
	+9buScuxfHfDQyKN7F9phLOz25JdHwM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE9861384C;
	Tue, 25 Jun 2024 10:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgB7KjWdemZpXgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 25 Jun 2024 10:34:29 +0000
Date: Tue, 25 Jun 2024 12:34:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	lilingfeng3@huawei.com
Subject: Re: [PATCH] block: cancel all throttled bios when deleting the cgroup
Message-ID: <5emugcorjnrcgczkmi7njfzwbotpqn6heu7acfho2zfkdsajpv@yrztl7hoa6ky>
References: <20240624130940.3751791-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpnrwrpuh4qaakga"
Content-Disposition: inline
In-Reply-To: <20240624130940.3751791-1-lilingfeng@huaweicloud.com>
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BD5C41F84E
X-Spam-Flag: NO
X-Spam-Score: -6.11
X-Spam-Level: 


--cpnrwrpuh4qaakga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Jun 24, 2024 at 09:09:40PM GMT, Li Lingfeng <lilingfeng@huaweicloud=
=2Ecom> wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>=20
> When a process migrates to another cgroup and the original cgroup is dele=
ted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.

When pd_offline_fn is called because of disk going away, it makes sense
to cancel the bios. However, when pd_offline_fn is called due to cgroup
removal (with possibly surviving originating process), wouldn't bio
cancelling lead to loss of data?
Aha, it wouldn't -- the purpose of the function is to "flush" throttled
bios (in the original patch they'd immediately fail, here they the IO
operation may succeed).
Is that correct? (Wouldn't there be a more descriptive name than
tg_cancel_bios then?)

And if a user is allowed to remove cgroup and use this to bypass the
throttling, they also must have permissions to migrate away from the
cgroup (and consistent config would thus allow them to change the limit
too), therefore this doesn't allow bypassing the throttling limit. If
you agree, could you please add the explanation to commit message too?

Thanks,
Michal

--cpnrwrpuh4qaakga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZnqdMgAKCRAt3Wney77B
SSnoAQCyPsjfbI6gXXW4WhHfulYy/fr4WrXplUFlX4XDxgVglQD/berfS1nRJ/Kh
4jSU8Xn4I4WUEd+YUcjDdBzafItdRgw=
=JIso
-----END PGP SIGNATURE-----

--cpnrwrpuh4qaakga--

