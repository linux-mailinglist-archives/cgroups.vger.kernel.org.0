Return-Path: <cgroups+bounces-3498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5739240B8
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5371C2317A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CA1BA888;
	Tue,  2 Jul 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kNeqxcg/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfCIB0yu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC161B583E;
	Tue,  2 Jul 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930324; cv=none; b=N4lG2xGL5TpbxLRNi4HwFBJRLppGkwooywlHvq6oqeHbTWVZj11dG4cXgbYLGCY9ncxEtHTRJirMOTCu8TJioMWcfmTiQFCGsh9qPkScMH9PEdSDGMgW0/CDeaarNteDyvE3cnXFfbRnkrLsjHtqiwxdxK8xQvnxt6erdfM8NP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930324; c=relaxed/simple;
	bh=iVY1vfSsFSEYqt9XQodSWGL/2M6yIcSREvR7X1WLMJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuC+MWQ5LUF/dDpZpNZQdG2UELqa2B7M9axktkYG/v+1CR2xco7ReOhmV8QUK5BIbXwstZZKpqhRp6Gr04BJzYYZ7oQx5SHH8JvRMbHdpNxMdx3qIOMTg+w3wGuS3aLKWGXxt9T9I3PZXNXrtU+2h0UUaZIldKIZUO0ovwqwtOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kNeqxcg/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfCIB0yu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D8151FBAB;
	Tue,  2 Jul 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719930320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVY1vfSsFSEYqt9XQodSWGL/2M6yIcSREvR7X1WLMJk=;
	b=kNeqxcg/3M8efqVZyYkPUn3QNc54WivORPj22uyg7GexEq0pPKf9R5O4rC0hEIsABgyoBQ
	APVSnZIHPp/kIbtWtgoqHYo5j50sNsTvYEvgrM4ASjDMtBZaRoJbryOq7KWy5GtDSQgTjv
	UdALnOg3s3ZoYtbQxLMY4a/ZFafy33Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719930318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVY1vfSsFSEYqt9XQodSWGL/2M6yIcSREvR7X1WLMJk=;
	b=mfCIB0yupx8ZNeMCkxp/wOhvrORO7czh9Tub99cpA1ewU0MWIdReZkM2u5gYekPAkofzPP
	GHCCgeFqdEaX8Erc0yoOOLHP4oCwhBRKKhGCfEXjX2mxTSKgd5JqdAjcfaYEAn4F34fJM/
	flwZoLAHbIxrAA6aeJIl0HWtSBzh7G0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A64213A9A;
	Tue,  2 Jul 2024 14:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gWOjHc4NhGbDEgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 02 Jul 2024 14:25:18 +0000
Date: Tue, 2 Jul 2024 16:25:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, josef@toxicpanda.com, hch@lst.de, 
	axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, yukuai1@huaweicloud.com, 
	houtao1@huawei.com, yi.zhang@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH v2] block: flush all throttled bios when deleting the
 cgroup
Message-ID: <7kmlqdvltacofugn7tzg6ylu25louwnmvdfa64cgdrecpveow7@rxvvbduuvjlz>
References: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>
 <Zn3O47DUoLliwbWm@slm.duckdns.org>
 <c9802312-d9c9-f262-e1d3-9d3343255b6b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iyowxzavzfjl2dg3"
Content-Disposition: inline
In-Reply-To: <c9802312-d9c9-f262-e1d3-9d3343255b6b@huaweicloud.com>
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Spam-Level: 


--iyowxzavzfjl2dg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 10:04:20AM GMT, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
> I think it may be more appropriate to remove the limit of bios after the
> cgroup is deleted, rather than let the bios continue to be throttled by a
> non-existent cgroup.

I'm not that familiar with this part -- can this also happen for IOs
submitted by an exited task? (In contrast to a running task migrated
elsewhere.)

> If the limit is set too low, and the original cgourp has been deleted, we
> now have no way to make the bios complete immediately, but to wait for the
> bios to slowly complete under the limit.

It makes some sense, it's not unlike reparenting of memcg objects, IIRC
flushed bios would actually be passed to a parent throtl_grp, right?

Thanks,
Michal

--iyowxzavzfjl2dg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZoQNxgAKCRAt3Wney77B
SWUqAP40GfmMEfXmFIR+/auvUwxfLvyefVIhE2VoOxRf/T4L2gEAsJBHXpz3Tv9h
FBSUq6Z4uXLPnCUQ94faVWq/eJLDpQA=
=n7yG
-----END PGP SIGNATURE-----

--iyowxzavzfjl2dg3--

