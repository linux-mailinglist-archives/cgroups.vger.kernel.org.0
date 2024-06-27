Return-Path: <cgroups+bounces-3404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750C91A9BE
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896CA1C20D63
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AE1990DA;
	Thu, 27 Jun 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hs3UUanY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oeZW2SuR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D77198E89;
	Thu, 27 Jun 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499731; cv=none; b=e3HD9KxI4SYmx4/Gtn9fu5ek9fXNSn5EXNQ4jc323KKy9XT+McCzlS2UrRKm1F95mi9TO0hJ4ZKGKDZDepAht3wawoEYQpUYeW2NP6c+wu+n3lW0xYP1WfcEKHZOXHfhBswXjLtBO3O+1yfndWJzIOQWNmbyf0YrDBfRp+LKyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499731; c=relaxed/simple;
	bh=LEXAqlk1jN2gNzWyszN/AYSSjGLCjTcYyJ3bECCChY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot6SJJ0Rq5WIv8ihhoyNpGGeHAKWbMOaW0rCV3Z8dg891RBvwBK2KUQBfRMpv2oR0kF7t/7HUsEIXDJg9WRyyQdeu78TeWgzSAT8A1w6vLMXKNOmoZsBEp7qPRsqO1R46/LLAjHraJUFUr+xEYyfgpQI4VHHm+WtiKF+6IxDL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hs3UUanY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oeZW2SuR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D6EF21B0B;
	Thu, 27 Jun 2024 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719499724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEXAqlk1jN2gNzWyszN/AYSSjGLCjTcYyJ3bECCChY0=;
	b=hs3UUanYQuzbd5Yw/z0ZDPOfeOrHbzarp/BWkTYd0cT0+NH9MhC53ex/6VDyUs8nHzN2s9
	i/m6u3U2vVzuk3FWMcHS+PCG+oBotPWA+l3FCsZvQEFCoxhOCYLd6MqiNsmGOiU2h4w+oQ
	3d6q5mh74auSMpD2cGya1YoRmizD5Bk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oeZW2SuR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719499723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEXAqlk1jN2gNzWyszN/AYSSjGLCjTcYyJ3bECCChY0=;
	b=oeZW2SuR3JUbdUouOLq/N8uJNXjrUBdxE3OpTLKyCzUI2UVWvHC66tNqE6I6Hr6T0ysH1U
	ovBoyfajFIahTRUtAQZedw1MgrqIz73csv9EJi1WPbqPehrSHEO9V8G+Wuq0rz/VSj+fCp
	Q3WsfDUSg6vVTmf+WXglLZShQkIhbdw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3100D1384C;
	Thu, 27 Jun 2024 14:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id myTFC8t7fWZGewAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 27 Jun 2024 14:48:43 +0000
Date: Thu, 27 Jun 2024 16:48:42 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	lilingfeng3@huawei.com
Subject: Re: [PATCH] block: cancel all throttled bios when deleting the cgroup
Message-ID: <lke5obdxztncs2mtbvgylngxspzzzrmlveibye32cqwog7xw5a@bk22ajawnbtn>
References: <20240624130940.3751791-1-lilingfeng@huaweicloud.com>
 <5emugcorjnrcgczkmi7njfzwbotpqn6heu7acfho2zfkdsajpv@yrztl7hoa6ky>
 <77ed0b42-60ac-0746-9a5b-23676e9668f2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e5n4haic7674hghp"
Content-Disposition: inline
In-Reply-To: <77ed0b42-60ac-0746-9a5b-23676e9668f2@huaweicloud.com>
X-Rspamd-Queue-Id: 4D6EF21B0B
X-Spam-Score: -6.11
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,huaweicloud.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org


--e5n4haic7674hghp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 07:38:34PM GMT, Li Lingfeng <lilingfeng@huaweicloud=
=2Ecom> wrote:
> Thanks for your advice. It's indeed more appropriate to use "flush" inste=
ad
> of "cancel" here, I will change it soon.

I saw your v2. Didn't you forget to change also the function name?

> I didn't quite get what you mean. Do you mean this patch will cause a cha=
nge
> in mechanics, and it is necessary to add an explanation?
>=20
> (After deleting the original cgroup,
> =A0Before: the limit of the throttled bios can't be changed and the bios =
will
> complete under this limit;
> =A0Now: the limit will be canceled and the throttled bios will be flushed
> immediately.)

I mean -- can the new mechanics be exploited to bypass throttling by
sending IO from a process, migrate it between cgroups and rmdir them?
That should be covered in the commit log.

Thanks,
Michal

--e5n4haic7674hghp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZn17xwAKCRAt3Wney77B
SezdAP95BXsHosNRfN2jjr9fIAxjsUPogamYQ3QPCdYAstMlHgEAzphiJpqD/nQo
teaCw4LZjTAFzrgCrv2kqzg80hEAAwg=
=Xv+3
-----END PGP SIGNATURE-----

--e5n4haic7674hghp--

