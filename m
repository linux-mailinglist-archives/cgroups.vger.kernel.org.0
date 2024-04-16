Return-Path: <cgroups+bounces-2531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4B8A7021
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24149281BC5
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E9131730;
	Tue, 16 Apr 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gf1F0DdC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gf1F0DdC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A51311B5;
	Tue, 16 Apr 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282483; cv=none; b=NUWDHA1XEsGhOHKtzYCkxjwW7d0SmdeGPSGnFaHDAWk72W0zQeBzdxNEbZi3T2HJO7vg3TlQbP0KpVSIbPBh8caJ6z3/f8m2YK0EzhetaCEUSjmjVklAv2yFQQwfXrZRLWiXSj9pwwObqlhdfeRbV4P6dw0WXYJG9rwIsT+lu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282483; c=relaxed/simple;
	bh=NZbRBNmAfMK+3yRMDzPReQ4j2EbQWHeftMW0C5d1kgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg7mPM7erFgzAJcCQzR/T7ERjNpKJX0gjMZkw+phKyV2QZLZs1nxlhDtCbnqwOLaNiPSJbQ23Apd4Z5917sScKPTBFJhYZMgvFY37xomiP91G/2u9wKAMwdDI2O/kI8BseZdcxm4CIUplJtcMmQ0mMGrDsQp4ArLX1HnsF29bhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gf1F0DdC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gf1F0DdC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1741F839;
	Tue, 16 Apr 2024 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713282478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhHu6jDC7cPxVBgNGim8Ty4Xl/VPDyVPLXO3H+HEHLU=;
	b=gf1F0DdCsPbSyTZntqKQhmd1fCFIF5GAMuucKYL9GyW+Rl53AIgDWqiFxtvWkMRvUg5ejE
	AydMtfUHF8EbREB0/xk6Mna8SKL1XOvzTdKGeRFR+MHKvPFSLExHedp+wgBRSHGaavDk7o
	bRNQoP9gKBZKvBgTS3LUcwfPUlR1PuI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713282478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhHu6jDC7cPxVBgNGim8Ty4Xl/VPDyVPLXO3H+HEHLU=;
	b=gf1F0DdCsPbSyTZntqKQhmd1fCFIF5GAMuucKYL9GyW+Rl53AIgDWqiFxtvWkMRvUg5ejE
	AydMtfUHF8EbREB0/xk6Mna8SKL1XOvzTdKGeRFR+MHKvPFSLExHedp+wgBRSHGaavDk7o
	bRNQoP9gKBZKvBgTS3LUcwfPUlR1PuI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F83813931;
	Tue, 16 Apr 2024 15:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fo7uCq6dHmZKDwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 16 Apr 2024 15:47:58 +0000
Date: Tue, 16 Apr 2024 17:47:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, tj@kernel.org, 
	josef@toxicpanda.com, jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, 
	pctammela@mojatatu.com, yukuai3@huawei.com, qde@naccy.de, zhaotianrui@loongson.cn, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 1/6] blk-throttle: remove
 CONFIG_BLK_DEV_THROTTLING_LOW
Message-ID: <f3jd5hflezlknl2np2ybrcmqpqohcsow2ldoh53xdzfe2vieti@zkd7e4oj4cgm>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrzldp3lzaugn3vy"
Content-Disposition: inline
In-Reply-To: <20240406080059.2248314-2-yukuai1@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -5.80
X-Spam-Level: 
X-Spamd-Result: default: False [-5.80 / 50.00];
	BAYES_HAM(-2.90)[99.57%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,toxicpanda.com,mojatatu.com,gmx.de,themaw.net,huawei.com,naccy.de,loongson.cn,vger.kernel.org,lists.linux.dev];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]


--xrzldp3lzaugn3vy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 06, 2024 at 04:00:54PM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>  Documentation/ABI/stable/sysfs-block       |  12 -
>  arch/loongarch/configs/loongson3_defconfig |   1 -
>  block/Kconfig                              |  11 -
>  block/bio.c                                |   1 -
>  block/blk-stat.c                           |   3 -
>  block/blk-sysfs.c                          |   7 -
>  block/blk-throttle.c                       | 901 +--------------------
>  block/blk-throttle.h                       |  26 +-
>  block/blk.h                                |  11 -
>  9 files changed, 45 insertions(+), 928 deletions(-)

I'm (also) not aware of any users of (be)low throttling.
I like this cleanup.

Michal

--xrzldp3lzaugn3vy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZh6dogAKCRAGvrMr/1gc
jmjlAPwLwNkZQJFhrEDRQd2UPVOTYJsmlBNuzIDoL+vMV1NMgAEAq01YDiSpW/+Z
V1EP2A64wd4WcjGJKLfZ/x4r2l/8iA4=
=cgb7
-----END PGP SIGNATURE-----

--xrzldp3lzaugn3vy--

