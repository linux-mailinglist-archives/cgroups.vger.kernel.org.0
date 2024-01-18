Return-Path: <cgroups+bounces-1172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A232831567
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 10:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A201C22A11
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F013ADC;
	Thu, 18 Jan 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q0utVZF0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lK5Ihehp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DF12E41;
	Thu, 18 Jan 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568676; cv=none; b=Dq87nOGQcpBNHEADlrdmZcky48NBC4SUz7aMf2O83JSJuiRGQ5AJ81WrROHunQxSvfn8T+LM0DRv3z3snrQ46TGiv0NN3MNyZG7GFfvR1063KImbhMtJ6DNziM8dGP+GtBtdvThfnkleLfTi3XQwDzAgYKRYHM5GTpVgQJi3b08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568676; c=relaxed/simple;
	bh=Lx9tonMV0p2LmGJzOUVmxlBkhvvyPY8HKeuAJPQh4ks=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=r6/ZBXmghL1pSTCZT60clqnakMvobrTNWlDGoYucKNIFVQpFIE/r8s44BQi5y7P8DKQnEMUbmRGTe+GUuL4ztb+NqITNXMFG3jgHKjvs9oEAGmJeTGyF8Kg9EmZETngJbRfmcWyhKtVNcnil9Qd+5/8YedTc/U9l9gIdWEhfaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q0utVZF0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lK5Ihehp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FA5922049;
	Thu, 18 Jan 2024 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705568672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx9tonMV0p2LmGJzOUVmxlBkhvvyPY8HKeuAJPQh4ks=;
	b=q0utVZF0O92nhdxl2kE4a6MZyKsKAtvwi2N/IkUkbVsotX2YQISspqe6TosRHNUqMz6vvd
	UMuwMgDMufs7dSmREmYrsR45+gZH1uOI5mW655ZZuwG2jbpRKj7+1wxZXy69NcoCfWoU51
	qrMnarvLlmNUaTJEwYqtrWXp9d++Yew=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705568671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx9tonMV0p2LmGJzOUVmxlBkhvvyPY8HKeuAJPQh4ks=;
	b=lK5IhehpmssMnTKxdBPOWJ6FwenHO4AUxX3t+ItSvSa8aQd1liz32rxnFfsuF4P4mEVXmm
	x5N5wbY5N+SOGshCLSfORkSdYDJbvlOiTfwb0Q+su98rU52Qwz5S/b/9EF680lLKga9eTF
	uE2CvXGmtfCRkv5pLJThqB1Ki728rMA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E026113874;
	Thu, 18 Jan 2024 09:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PpbYNZ7pqGXBMQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 18 Jan 2024 09:04:30 +0000
Date: Thu, 18 Jan 2024 10:04:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Shakeel Butt <shakeelb@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Vasily Averin <vasily.averin@linux.dev>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 4/4] mitigations: Add flock cache accounting to
 'mitigations=off'
Message-ID: <dxd775xvo2r4vonmpvzb6sgrwgfqrsvekqabyh4mjljgrqzecj@eiubz4t2lepu>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <3e803d5aee5dd1f4c738f0de1e839e6cfcb9dc41.1705507931.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4b4gqso4ihknobk"
Content-Disposition: inline
In-Reply-To: <3e803d5aee5dd1f4c738f0de1e839e6cfcb9dc41.1705507931.git.jpoimboe@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lK5Ihehp
X-Spamd-Result: default: False [-4.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.17)[70.01%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4FA5922049
X-Spam-Level: 
X-Spam-Score: -4.08
X-Spam-Flag: NO


--u4b4gqso4ihknobk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 08:14:46AM -0800, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Allow flock cache accounting to be disabled with 'mitigations=off', as
> it fits the profile for that option: trusted user space combined with a
> performance-impacting mitigation.

Note that some other kernel objects that don't have any other tight
limit are already charged too (but their charging likely did not stand
out in any performance regression tests).
In the situation you describe, users can already pass
`cgroup.memory=nokmem` and get rid of charging overhead in general.

IOW, if flock objects are charged, there already is a boot option to
turn off such behavior.

Regards,
Michal

--u4b4gqso4ihknobk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZajpkQAKCRAGvrMr/1gc
jnI1AQCbThmyZZHc0yb1sSU87kRYGU6A+8Qm5wtthTdtlNoPuwEAnOxavnxMkLvy
VhsoAek+ajhMUjJp7v03BI1OEx2X/AA=
=LaB0
-----END PGP SIGNATURE-----

--u4b4gqso4ihknobk--

