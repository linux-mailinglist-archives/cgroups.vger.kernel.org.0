Return-Path: <cgroups+bounces-11924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F3C57199
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 886AC34EE7A
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A433AD85;
	Thu, 13 Nov 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/vHGMR0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YuyFlFd5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="chw1No4n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZUKDf9Xf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32433858A
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031830; cv=none; b=JEodB87Kges6G1K0JmAwR6x+/WG5MEI34/PDBkkVqnXgCFGbtCNyBm39LfpBouxSLku8Ybj2FSaMPK7mKdPvSx6LzBiZ1bvGWvMt40x5l2Rqv8TdsicX/17iJJUawrHP8nEZEyk5+OE0kqv09PagkOuLATdCm68ujhnaU7p0UWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031830; c=relaxed/simple;
	bh=7pvprqGCaxvYR0EsvIa4Xj239Fj5fSjRW6OvMYmHi1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxD0c7AWrRNZ688Il6z6wiK+O2A1Azxhl+IHFLkgbFGjR1NljssDtNDk9LN5higJO/4jjuUIpYx2LwLLXccKVqWt+urcuuusByfPPgxwY8ohJrpEhfj6Q0znOxVsGdnc3BzNfBYuTjZ3VhTshykCCr9AVJOLmP9uwC4EqR7NBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/vHGMR0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YuyFlFd5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=chw1No4n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZUKDf9Xf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5F642126F;
	Thu, 13 Nov 2025 11:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763031825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/4XRvnt2+9/BGxrNjMgTCeqhd+ANIFzSSFsqPyLNwc=;
	b=k/vHGMR0+PWvJeo+y7ipIqryMVC8Y8R6I6NPUSmyB+K51V7MF/VHE4nN7ZwTeW1b5ayDpM
	MRnVV2ZD2yZeZw5fgLuwk4P3Dl42eR4QJBfM5COASPoQhtIG+BadzshiiewgPJBrOPFFRA
	zfmyxU1dlEHKFY2cSlk/rdE2PNasg3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763031825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/4XRvnt2+9/BGxrNjMgTCeqhd+ANIFzSSFsqPyLNwc=;
	b=YuyFlFd5vJr90MC0cQWKSfwNZIDG1txChoSaNQSA2ddOh2ko5fi4FNollB9v2nk3STq8ov
	xL9XXR/1w0m0EWDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=chw1No4n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZUKDf9Xf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763031824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/4XRvnt2+9/BGxrNjMgTCeqhd+ANIFzSSFsqPyLNwc=;
	b=chw1No4n9v1MzhzqfZtk7TG3kgcaPxaCvjAhmISTlsIK9U7XfUEUIIpLu14xyzV0raqdqW
	+rm5EEfVil1cvgqm41jtmVXiPtm2Fr0AxIaD2iYOOU0wVarANNtcgALzcxfVeLcQBrJHMr
	X6a8l2nZYKGNpC26dKQbPDjXd4OF/I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763031824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/4XRvnt2+9/BGxrNjMgTCeqhd+ANIFzSSFsqPyLNwc=;
	b=ZUKDf9XfjOZIOuC4/6r+5Q895+NgzMHhaQfiJ7D10yrMHAWhrmNDrp8CehJ+VAi2ICn4E5
	BDQyJ5d6UCmH7GDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD1C23EA61;
	Thu, 13 Nov 2025 11:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tT8yLhC7FWlsUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Nov 2025 11:03:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47636A0976; Thu, 13 Nov 2025 12:03:44 +0100 (CET)
Date: Thu, 13 Nov 2025 12:03:44 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/17] ns: header cleanups and initial namespace
 reference count improvements
Message-ID: <byhojbx5x73zxickqy4uje6fmcn3nuugau7afia6thsyomfnlx@exrz3jpwdfgs>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
X-Rspamd-Queue-Id: D5F642126F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,toxicpanda.com,kernel.org,google.com,yhndnzj.com,in.waw.pl,0pointer.de,gmail.com,cyphar.com,cmpxchg.org,linutronix.de,zeniv.linux.org.uk,suse.cz,arndb.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Mon 10-11-25 16:08:12, Christian Brauner wrote:
> Cleanup the namespace headers by splitting them into types and helpers.
> Better separate common namepace types and functions from namespace tree
> types and functions.
> 
> Fix the reference counts of initial namespaces so we don't do any
> pointless cacheline ping-pong for them when we know they can never go
> away. Add a bunch of asserts for both the passive and active reference
> counts to catch any changes that would break it.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

FWIW I've read the series and I like it. It looks like very nice cleanups.
I don't feel *very* confident with this code so it isn't worth much but
still feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Christian Brauner (17):
>       ns: move namespace types into separate header
>       nstree: decouple from ns_common header
>       nstree: move nstree types into separate header
>       nstree: add helper to operate on struct ns_tree_{node,root}
>       nstree: switch to new structures
>       nstree: simplify owner list iteration
>       nstree: use guards for ns_tree_lock
>       ns: make is_initial_namespace() argument const
>       ns: rename is_initial_namespace()
>       fs: use boolean to indicate anonymous mount namespace
>       ipc: enable is_ns_init_id() assertions
>       ns: make all reference counts on initial namespace a nop
>       ns: add asserts for initial namespace reference counts
>       ns: add asserts for initial namespace active reference counts
>       pid: rely on common reference count behavior
>       ns: drop custom reference count initialization for initial namespaces
>       selftests/namespaces: fix nsid tests
> 
>  fs/mount.h                                     |   3 +-
>  fs/namespace.c                                 |   9 +-
>  include/linux/ns/ns_common_types.h             | 196 ++++++++++++++++
>  include/linux/ns/nstree_types.h                |  55 +++++
>  include/linux/ns_common.h                      | 266 +++++-----------------
>  include/linux/nstree.h                         |  38 ++--
>  include/linux/pid_namespace.h                  |   3 +-
>  init/version-timestamp.c                       |   2 +-
>  ipc/msgutil.c                                  |   2 +-
>  ipc/namespace.c                                |   3 +-
>  kernel/cgroup/cgroup.c                         |   2 +-
>  kernel/nscommon.c                              |  15 +-
>  kernel/nstree.c                                | 304 ++++++++++++++-----------
>  kernel/pid.c                                   |   2 +-
>  kernel/pid_namespace.c                         |   2 +-
>  kernel/time/namespace.c                        |   2 +-
>  kernel/user.c                                  |   2 +-
>  tools/testing/selftests/namespaces/nsid_test.c | 107 +++++----
>  18 files changed, 576 insertions(+), 437 deletions(-)
> ---
> base-commit: c9255cbe738098e46c9125c6b409f7f8f4785bf6
> change-id: 20251110-work-namespace-nstree-fixes-f23931a00ba2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

