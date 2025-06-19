Return-Path: <cgroups+bounces-8601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD2ADFF68
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6273ABBFC
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BA25DB10;
	Thu, 19 Jun 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qV4ZAk1x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DCwPT26y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F14/RhsO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0fulWgP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724825D903
	for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320301; cv=none; b=tzOW+KCqEakAN1eZEx+qn8/A42asUo0ek/pb0n/L2iKqcf6q31rfQu7Gv9EfbQbEFxYr/xJMHx8AM8Y4KylC+RC995oTCmhSRnf2FrGD8L1OE1QcqlqZ9ozUp6OpKKHof6mFQtNzr2rUQjJ04RK2vEgSa9299+aZew9oOMSb2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320301; c=relaxed/simple;
	bh=kMUwQy5yS/0UyV2suBDJYNHnJnmJCAsNt2MeM163mxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGZKqxQjTgmctdt5HXrwQA535dA/jvQJxfrW29+l83AfC6Ftqfz/a2Bm0rvdRhJAtTwf/2yI62WU/6JjoIQjQAG2s2eWuseylt6A1duK9HRvPWRf3kDcDvG0ZrbgAJpo9NAI9n/LKICeZ1SgSrJzeuMu0doI6I+2u5rmKtKqjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qV4ZAk1x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DCwPT26y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F14/RhsO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0fulWgP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10B6B1F38D;
	Thu, 19 Jun 2025 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750320298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9tK8I/Q1RuDUNKJbS5HFbDvN87u0BlSb6P1raJhR/Y=;
	b=qV4ZAk1xOpeep+2wuxQ9eVRiMcnmcq7d5nQk+FcnPAUvTaxCKSE3xrVAMJt03ZyMf59D8m
	wR1bi6/sJ1X1nQU3GCVEoatGvzfxM3+s1Fqm8oyksAkyrk7iKkltWA0V2Dw6d4uMvm3F0W
	GdMZRglRKoQ/HPiveUvlUnH4K1qkhSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750320298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9tK8I/Q1RuDUNKJbS5HFbDvN87u0BlSb6P1raJhR/Y=;
	b=DCwPT26ympUpgRDG5u31i3DmStOmi2k8OHp00O/tw2SXmu9/tGFrW9GZwqB2ebs+xKILIA
	lPIhESnGR4YJNDCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="F14/RhsO";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D0fulWgP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750320297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9tK8I/Q1RuDUNKJbS5HFbDvN87u0BlSb6P1raJhR/Y=;
	b=F14/RhsOG85KUrUZtUhzvqbUUmz9ZYsPR+P48pPUZh+d6cjAtMGaPxMJ5w3msp3obKCfAU
	KeD+qUXnnVC1wHEYyj1IKRG+Msn41PZqhwPI3rK2K6TbJhmbfgZsvWO9J5RFBlbVZjYHrt
	yxee3S1EdMWbxNruyMT2xYBFaX2sRs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750320297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9tK8I/Q1RuDUNKJbS5HFbDvN87u0BlSb6P1raJhR/Y=;
	b=D0fulWgPAXA28aOQkWf1m3PkSOVzGVFu04vFk8DFtU+htyrvU7MtKaMASx+ibAv9qf/sEh
	Y3CUVkHsekSkgxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00B56136CC;
	Thu, 19 Jun 2025 08:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ROUkAKnEU2g4LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 08:04:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD44DA29F1; Thu, 19 Jun 2025 10:04:56 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:04:56 +0200
From: Jan Kara <jack@suse.cz>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, akpm@linux-foundation.org, 
	tytso@mit.edu, jack@suse.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	muchun.song@linux.dev, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] Postpone memcg reclaim to return-to-user path
Message-ID: <bkql5n7vg7zoxxf3rwfceioenwkifw7iw4tev4jkljzkvpbrci@6uofefhkdzrx>
References: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
 <a57jjrtddjc4wjbrrjpyhfdx475zwpuetmkibeorboo7csc7aw@foqsmf5ipr73>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57jjrtddjc4wjbrrjpyhfdx475zwpuetmkibeorboo7csc7aw@foqsmf5ipr73>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 10B6B1F38D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 18-06-25 15:37:20, Shakeel Butt wrote:
> > This is
> > beneficial for users who perform over-max reclaim while holding multiple
> > locks or other resources (especially resources related to file system
> > writeback). If a task needs any of these resources, it would otherwise
> > have to wait until the other task completes reclaim and releases the
> > resources. Postponing reclaim to the return-to-user path helps avoid this issue.
> > 
> > # Background
> > 
> > We have been encountering an hungtask issue for a long time. Specifically,
> > when a task holds the jbd2 handler 
> 
> Can you explain a bit more about jbd2 handler? Is it some global shared
> lock or a workqueue which can only run single thread at a time.
> Basically is there a way to get the current holder/owner of jbd2 handler
> programmatically?

There's a typo in the original email :). It should be "jbd2 handle". And
that is just a reference to the currently running transaction in ext4
filesystem. There can be always at most one running transaction in ext4
filesystem and until the last reference is dropped it cannot commit. This
eventually (once the transaction reaches its maximum size) blocks all the
other modifications to the filesystem. So it is shared global resource
that's held by the process doing reclaim.

Since there can be many holders of references to the currently running
transaction there's no easy way to iterate processes that are holding the
references... That being said ext4 sets current->journal_info when
acquiring a journal handle but other filesystems use this field for other
purposes so current->journal_info being non-NULL does not mean jbd2 handle
is held.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

