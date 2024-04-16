Return-Path: <cgroups+bounces-2532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1468A70BE
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 18:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF3C1F26496
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B03134431;
	Tue, 16 Apr 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NDqQLRjo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NDqQLRjo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB8131E33;
	Tue, 16 Apr 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283025; cv=none; b=EjSKckvkGmb8svaf08/yXv/Hj809YciQIiAHtcpamjUZHlLLT48EKJk5wIFM9qSWOzMn8R2K+EFeohcm3s9rifceZHzjFSNjP7kdsFZ6/97U1l2Cav4m/+sLEDdqo00nmqUpFwjne7+w2HaFM1tsXk7hNzbGqgJk4wC4JYLNCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283025; c=relaxed/simple;
	bh=Iu6ZI5gBqlme3cg5MEOC3W62ydJpeBmX4hJ+JUWNsy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFumoJTQX3CWvRHUtuVZl3nzd531zaOMPHezLZkNrWA5UEhWQTj4tD+Q0ztlGY93TABJmE8Yad0wV7g/TGojeVn43DxMiLCFKh4VksubX8pOP4kQ192b5R98Kcyfw2gM/Oxgx9BOMB+AFVy4fIVahuv9LxZaEkdMd4Az7zGuGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NDqQLRjo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NDqQLRjo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 731C637C62;
	Tue, 16 Apr 2024 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713283021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=anWo6fGpjMWEBqkA/kZa06BJ2jwAbp66h31uSjcrdZU=;
	b=NDqQLRjosYjcezQ8nZejzJ+RF7CAggNYviN83sEJr/QMQQrnVrIfXjPcAEP/093aI+Gz71
	R70+4hZL6C4Q1wIBVDvjJpZVszHKakptD1ElOJHzuEdn6da0NblG+YbDA7+2G/NslmPPyo
	ynPcVIcd8+MvjEV3ItcPi1R/y7Iakzc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NDqQLRjo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713283021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=anWo6fGpjMWEBqkA/kZa06BJ2jwAbp66h31uSjcrdZU=;
	b=NDqQLRjosYjcezQ8nZejzJ+RF7CAggNYviN83sEJr/QMQQrnVrIfXjPcAEP/093aI+Gz71
	R70+4hZL6C4Q1wIBVDvjJpZVszHKakptD1ElOJHzuEdn6da0NblG+YbDA7+2G/NslmPPyo
	ynPcVIcd8+MvjEV3ItcPi1R/y7Iakzc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E18A13931;
	Tue, 16 Apr 2024 15:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8zzEFs2fHmaCEgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 16 Apr 2024 15:57:01 +0000
Date: Tue, 16 Apr 2024 17:56:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, tj@kernel.org, 
	josef@toxicpanda.com, jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, 
	pctammela@mojatatu.com, yukuai3@huawei.com, qde@naccy.de, zhaotianrui@loongson.cn, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 0/6] blk-throttle: support enable and disable
 during runtime
Message-ID: <4exmes2ilp2cmfj3evf3jhhhq6tapfzgfzuasjejrxbj6a3327@3ecptofffblf>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcg27uqvq5iwros6"
Content-Disposition: inline
In-Reply-To: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.56 / 50.00];
	BAYES_HAM(-2.45)[97.49%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,toxicpanda.com,mojatatu.com,gmx.de,themaw.net,huawei.com,naccy.de,loongson.cn,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 731C637C62
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.56


--gcg27uqvq5iwros6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 04:00:53PM +0800, Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> I'm planning to support build all blk-throttle polices as kernel module,

There is only one blk-throttle policy (especially after your removal of
io.low). Did you mean blkcg policies in general?

The current code is complex because of various lifecycles in=20
	devices x cgroups.
Turning policies into modules seems to make it=20
	devices x cgroups x policy modules
=2E

Could you please add more info why policies as modules is beneficial,
how to keep complexity capped?

Thanks,
Michal

--gcg27uqvq5iwros6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZh6fwgAKCRAGvrMr/1gc
jk6XAQCeZFtufnuWTQip3NTiZ2vlcVYT97vuhRvyjVW1FUJmXwD/Ws2DBY85GsT2
hWc+vTpwYwuFW0zjBy+qQ871rrOUHAc=
=UDnt
-----END PGP SIGNATURE-----

--gcg27uqvq5iwros6--

