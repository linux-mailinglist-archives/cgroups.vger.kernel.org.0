Return-Path: <cgroups+bounces-2560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAF8A80DB
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88A91C20FB3
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCB713B798;
	Wed, 17 Apr 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g4qEvNbO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g4qEvNbO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26E13B29C;
	Wed, 17 Apr 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349547; cv=none; b=XR9QdWVBLjAx3aFAMeYtWjER4GDDR3MqPeggeDvG1zlirrJke1h9/PJPx1N/bBw5bIpTGpal0qIabEZFs7MJQtFYS27pnBAnqNQSrF1iFE6u6TdXvIiYbimzl88adak9W7Qixh++lTSHv7Puc2afEmte160ZtTrBaAKCpmEdbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349547; c=relaxed/simple;
	bh=NDbI6G+PFcKfCE8LvuHVfp8HdKCGX9NVA8UfW64rwDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgkZmWckaX4nbUn2OOQFc8rlpHec1gf32DhrbbKE6hm3PAkGjgfbJKumM/pt0YeF9Y7AKV7yaH+TLVbOPsC5L0JzEihUvnlby0UTIn3SQGDnQ0GzZm992xIGi1KH/aciseFaeG/S8Ct4SppVxR1XWJU9aLdcKeC5fJxv2N5hakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g4qEvNbO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g4qEvNbO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 359F9206F4;
	Wed, 17 Apr 2024 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713349544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDbI6G+PFcKfCE8LvuHVfp8HdKCGX9NVA8UfW64rwDM=;
	b=g4qEvNbOw9Ygwp5FSKied5syvo6aREx4Kys21vR69y+oE6P02Rq+sm75q+9wMf5kgsMfGT
	e/PODIsb3w7aGYYQf/+RKKdBGoalzFxHkqOMjPQLV1jb6D9eQOpgC4P/rXEZyIfiOtXaKG
	53i1WFVxMmvgX0WlniHtMATq5JOm2BQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=g4qEvNbO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713349544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDbI6G+PFcKfCE8LvuHVfp8HdKCGX9NVA8UfW64rwDM=;
	b=g4qEvNbOw9Ygwp5FSKied5syvo6aREx4Kys21vR69y+oE6P02Rq+sm75q+9wMf5kgsMfGT
	e/PODIsb3w7aGYYQf/+RKKdBGoalzFxHkqOMjPQLV1jb6D9eQOpgC4P/rXEZyIfiOtXaKG
	53i1WFVxMmvgX0WlniHtMATq5JOm2BQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 223101384C;
	Wed, 17 Apr 2024 10:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yDgjCKijH2aPbQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Wed, 17 Apr 2024 10:25:44 +0000
Date: Wed, 17 Apr 2024 12:25:42 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, tj@kernel.org, 
	josef@toxicpanda.com, jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, 
	pctammela@mojatatu.com, qde@naccy.de, zhaotianrui@loongson.cn, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Re: [PATCH RFC v2 0/6] blk-throttle: support enable and disable
 during runtime
Message-ID: <unns4jtkiqdde3v7hzmd4yi2y7ylh4fh545dsn3imytgbg4x72@iq3mwwemygh5>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <4exmes2ilp2cmfj3evf3jhhhq6tapfzgfzuasjejrxbj6a3327@3ecptofffblf>
 <f721f06e-e2c8-608e-0dd0-41f41e948f0d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mv5ylurrtbwdd6xr"
Content-Disposition: inline
In-Reply-To: <f721f06e-e2c8-608e-0dd0-41f41e948f0d@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.89 / 50.00];
	BAYES_HAM(-2.78)[99.06%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,toxicpanda.com,mojatatu.com,gmx.de,themaw.net,naccy.de,loongson.cn,vger.kernel.org,lists.linux.dev,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 359F9206F4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.89


--mv5ylurrtbwdd6xr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2024 at 09:09:07AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> Yes, bfq already support that,

I've never noticed CONFIG_IOSCHED_BFQ is a tristate that explains (me) a
lot. Thanks!

> First of all, users can only load these policies when they need, and
> reduce kernel size; Then, when these policies is not loaded, IO fast
> path will be slightly shorter, and save some memory overhead for each
> disk.

...and there is no new complexity thanks to the above.

(I'm only catching up with subthread of patch 5/6.)
It seems the old complexity could be simplified by the way of lazy
inits. Intereseting...

Michal

--mv5ylurrtbwdd6xr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZh+jpAAKCRAGvrMr/1gc
jtkfAP9yEajBdW3z7w7kWBfYAteHAXasz7VRVK4JZFJIWxNyeQD+Ii7z6SSsfVG5
K3EEHsVXHAgD9UkHeoqy9ADSNVIGZQc=
=l0yD
-----END PGP SIGNATURE-----

--mv5ylurrtbwdd6xr--

