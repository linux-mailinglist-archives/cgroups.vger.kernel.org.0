Return-Path: <cgroups+bounces-2276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7672895A56
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF551F23668
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623215990A;
	Tue,  2 Apr 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZbLTC8t1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC5132C38
	for <cgroups@vger.kernel.org>; Tue,  2 Apr 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077503; cv=none; b=icKA1gwkC7SdIPIcpmqjWWBaSUsAiujdyXyKE4ZIqNOQ59ZbWDdJSOp4SzAw8vPmhQEbnRm/SeJnQa/ss3SyUOZiY6MY9IpIfy/0LoOSQ2Luwzc54W9xG6jooztaIJ/rq+cmFidgOKtn1P6WUNualjhSzOGrqr1wZuw3LXHcV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077503; c=relaxed/simple;
	bh=JMsavF9E8jV7zEcFxbiq9+OylvrBmne0FvUV96+/x5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeCm2P3yYhXAw1xqtwepUAI9EtCCr8iEa0eojmgXT3q4lm+SZL9roFIZVMwO1EUS7mWZj87dLxZKgxriVNufLaU04sl44vYafckI2dziJWj9GSVDsiJInh6jz+kci6Sy2uhMN5sTVKWdvZuoZKiJzJGdIwCLCQq2+IlnePWrfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZbLTC8t1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BF345C058;
	Tue,  2 Apr 2024 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712077499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OX2xvF4wQ5WhD1IS4KQSSQ9DnagarlT0hY8OHMyE7Oo=;
	b=ZbLTC8t1m25+dfXvsxnFacGzavsjvSHG0SYPSOfhf5gnjHKOCxUpfZPIWEbomPq697Xy5O
	kwsGQhwNf4Yt6EZgqnVKbVQxzypPOsovBR4bRcAHcNNJiT5w8aesTm2ZJv4XbOQ5ecJiWq
	njKkIu92bt0HYkRiKN4+Grty19r7GiQ=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EC5813357;
	Tue,  2 Apr 2024 17:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lD7lDrs6DGadHgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 02 Apr 2024 17:04:59 +0000
Date: Tue, 2 Apr 2024 19:04:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Malat <oss@malat.biz>
Cc: cgroups@vger.kernel.org, tj@kernel.org, longman@redhat.com
Subject: Re: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective independent of
 cpuset.cpus
Message-ID: <xdx55wvvss44viwmszsss2tohyslirqu3jrrexroyc5knamful@2sdajjhw45sj>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <20240321213945.1117641-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lj5zjdn5y2ata35t"
Content-Disposition: inline
In-Reply-To: <20240321213945.1117641-1-oss@malat.biz>
X-Spamd-Result: default: False [-1.90 / 50.00];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	BAYES_HAM(-0.00)[31.11%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -1.90
X-Spam-Level: 
X-Spam-Flag: NO


--lj5zjdn5y2ata35t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Mar 21, 2024 at 10:39:45PM +0100, Petr Malat <oss@malat.biz> wrote:
> Requiring cpuset.cpus.effective to be a subset of cpuset.cpus makes it
> hard to use as one is forced to configure cpuset.cpus of current and all
> ancestor cgroups, which requires a knowledge about all other units
> sharing the same cgroup subtree.

> Also, it doesn't allow using empty cpuset.cpus.
                               ^^^^^^^^^^^^^^^^^
                          _this_ is what cpuset has been missing IMO

I think cpuset v2 should allow empty value in cpuset.cpus (not only
default but also as a reset (to the default)) which would implicitely
mean using whatever CPUs were passed from parent(s).

Does that make sense to you too?

Thus the patch(es) seems to need to be extended to handle a case when
empty cpuset.cpus is assigned but no cpuset.cpus.exclusive are
specified neither.

Thanks,
Michal

--lj5zjdn5y2ata35t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZgw6twAKCRAGvrMr/1gc
js8FAQC6PK8Vz77D/URPaGG3w/LUOiCoAP/H693O1LQRbR0I8QD/UGAinnNfVh3e
WnLFNiajsYbEh7YcJN5qjIoXV9QeugI=
=Imuo
-----END PGP SIGNATURE-----

--lj5zjdn5y2ata35t--

