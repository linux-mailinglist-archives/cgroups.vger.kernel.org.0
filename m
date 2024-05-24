Return-Path: <cgroups+bounces-2996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B178CE8C0
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 18:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B935B20B88
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124312E1F8;
	Fri, 24 May 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FCHcLXt4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RyF2DcAg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01218626E;
	Fri, 24 May 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568522; cv=none; b=VfcBAKUI06hpbAARKc+ZMMqds3FvT237Y2jb5bKPwwRpuTbiTx9PfXJWejjcRk1ib+n8M5tZ3gn7wevLVNVElsnouFKc+4sFIctlhSB8eTnemb2UthFU063vhOD1EdsHPH2EyALPLmO6ivMOsRub9HSlJCCEjAUsPFzl003hZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568522; c=relaxed/simple;
	bh=5/h1AdkQCn+nFHKEW9DSnbpp0ir6DIALkgSxnxwkY3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twRIbQRN5lLWacup8h0PU/08/kPiLWKWeeacZ3390JaJGIfBLn7NeJoZB/N7pRX3ILI2p6jBTfV91aE94kPoE2FmZ/SWhsRw7HfkX0EwmFCBizu2uYI6bmN3E+SgvSSTaxq7p4PK6jg/yE+ZWctMAIakBSqR8nN4jlDHQbtc0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FCHcLXt4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RyF2DcAg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD9C233A20;
	Fri, 24 May 2024 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716568518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Trx8PEqK2lg/z39VeQSPx/0n4M09a/yG2ngOoEZyV+A=;
	b=FCHcLXt4oB/EFC/3PJvScbh19/TE5UhSyLDyB91sSOtq2UoY3Wl2niwCmZincfvN3l2MtA
	TQUaXxu6fnWW9Y4tYPDCJWi/J81XzOCeBhvcRmFcYDjJcw7+9PcMEH3H/NvHW2WYdCt63A
	/lKNLRZt1FuB3sdaenTCyUX8NHFpXdg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RyF2DcAg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716568517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Trx8PEqK2lg/z39VeQSPx/0n4M09a/yG2ngOoEZyV+A=;
	b=RyF2DcAg6s8CsXHYliBPaAryIMl/dtqY/lF/URJVRey+W2dltoQesWIM4TcZUck/Algr57
	a+h9UefvO8gSoYI0uwu8mF/gyo07sFAMZXHCbIr2EZITNYsyWM2NLW9q+B6bAJWOlXa1il
	L5kDgBn8VJ645ouXxqoFqM1nV47cBiA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF77213A6B;
	Fri, 24 May 2024 16:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zWh+MsXBUGZsPgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 24 May 2024 16:35:17 +0000
Date: Fri, 24 May 2024 18:35:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: restore incremental cgroup iteration
Message-ID: <lgfq42xzqihzrz2hy32ktfdofhoub6pzvphjgwocpma55m5t3l@t6ckdxlk7wlw>
References: <20240514202641.2821494-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4bf6d4mqghjgxbc"
Content-Disposition: inline
In-Reply-To: <20240514202641.2821494-1-hannes@cmpxchg.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.07 / 50.00];
	BAYES_HAM(-2.96)[99.84%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DD9C233A20
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.07


--k4bf6d4mqghjgxbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, May 14, 2024 at 04:26:41PM GMT, Johannes Weiner <hannes@cmpxchg.org> wrote:
> The shared iterator state is maintaned inside the target cgroup, so
> fair and incremental walks are performed during both global reclaim
> and cgroup limit reclaim of complex subtrees.

Here it sounds like same fairness is maintained...

>  static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
...
> +	 * persists across invocations. This strikes a balance between
> +	 * fairness and allocation latency.

...but here you write about balance between fairness and allocation.

IIUC, this spreads reclaim (of whole subtree) over longer time when more
events may affect the state of memory (e.g. more allocations), so
fairness would be "different". So the statement from code comment is
correct, right?

(I was also wondering how does this affect determinism of reclaim and
whether some chaotic or oscillatory patterns aren't possible but I guess
that needn't to be considered given it used to work before
1ba6fc9af35b.)

Thanks,
Michal

--k4bf6d4mqghjgxbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZlDBwgAKCRAGvrMr/1gc
jhe/AQDeuUp02+73sDIL5zqyPUXNV1J4tLh52NWJ4CJkOBS7fgEA8xyeMuWDv/nm
f8A0QEu/w2m5znd1sLbI3LdmB+334Q4=
=7NM5
-----END PGP SIGNATURE-----

--k4bf6d4mqghjgxbc--

