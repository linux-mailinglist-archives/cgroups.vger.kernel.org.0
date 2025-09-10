Return-Path: <cgroups+bounces-9923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C0FB51C1D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C7756185B
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6229327A17;
	Wed, 10 Sep 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hJz8qJI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NO112gBK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hJz8qJI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NO112gBK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC0262FD3
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518936; cv=none; b=aeSaGIFlgs7HsfA13xOMm1i1TRil5+DCZi1gYkigbTRUSoEjt/N0IQlVPntGhTGCWt+N217L197ZFQl4NuP9relZOhSLLGhOY7I/EledtTqhyJhhp7seHKs7ypY3gjjGN8CEHjN7jS0zl5Zd8IMCGmn+68SKJkTnlXzsMjkflpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518936; c=relaxed/simple;
	bh=Cs1kFRlQ5H7zhahjzYxf2EK0Ra5jh3dfdDPi7R9oOc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia9SOkF3oW2kBMfqW1dnE6HHl9RDTsSwANKmh6HSklV5/1mK4zWOgAbLybpTiphGlkM6CrjYE7E8pXPB7V4eVH5fPIdJ7DHlJD6Jk0/m0sj4skoGzmQSYHNvMa1IjkzG0d3nOjcT9LPShqtd4ZE7JUZ0zfMqXUq3mWzBfa47hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hJz8qJI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NO112gBK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hJz8qJI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NO112gBK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2063760CB6;
	Wed, 10 Sep 2025 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0R0410H9t/wQv6VWGxdRlhWH/TFZcB3Ys4tmpubotY=;
	b=0hJz8qJIt9pnNE9GrmCOKEPsxj3b104wsLuy5m1dUwzy+fYbkc+ncy0yC+FGGGqiEVHyrL
	JyLvwnytnQo8BnsE1cN9I0me0VDqOBmwfSTYTX0fakvFwSh17o0IMVY8HTGhBB8daRW43b
	HJR7rkkPlKqt6liput/+nBAssMzq9jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0R0410H9t/wQv6VWGxdRlhWH/TFZcB3Ys4tmpubotY=;
	b=NO112gBKAY+URMsCiPhYqoPvatOeZMZyN2/EtDGZaqXBhRBIQL2KAUjQ3/vSjudxVZjXON
	kQDYCerV3kK39/CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0hJz8qJI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NO112gBK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0R0410H9t/wQv6VWGxdRlhWH/TFZcB3Ys4tmpubotY=;
	b=0hJz8qJIt9pnNE9GrmCOKEPsxj3b104wsLuy5m1dUwzy+fYbkc+ncy0yC+FGGGqiEVHyrL
	JyLvwnytnQo8BnsE1cN9I0me0VDqOBmwfSTYTX0fakvFwSh17o0IMVY8HTGhBB8daRW43b
	HJR7rkkPlKqt6liput/+nBAssMzq9jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0R0410H9t/wQv6VWGxdRlhWH/TFZcB3Ys4tmpubotY=;
	b=NO112gBKAY+URMsCiPhYqoPvatOeZMZyN2/EtDGZaqXBhRBIQL2KAUjQ3/vSjudxVZjXON
	kQDYCerV3kK39/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B84713310;
	Wed, 10 Sep 2025 15:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUvNAlOcwWitOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:42:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91891A0A2D; Wed, 10 Sep 2025 17:42:06 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:42:06 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 09/32] cgroup: use ns_common_init()
Message-ID: <rxztx4fsz3ylr4k7w77e5bppfvxcnkddov5ltfj24ieteykwev@kykmn333w45z>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-9-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-9-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2063760CB6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:54, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/cgroup/namespace.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 144a464e45c6..0391b6ab0bf1 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -21,20 +21,16 @@ static void dec_cgroup_namespaces(struct ucounts *ucounts)
>  
>  static struct cgroup_namespace *alloc_cgroup_ns(void)
>  {
> -	struct cgroup_namespace *new_ns;
> +	struct cgroup_namespace *new_ns __free(kfree) = NULL;
>  	int ret;
>  
>  	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
>  	if (!new_ns)
>  		return ERR_PTR(-ENOMEM);
> -	ret = ns_alloc_inum(&new_ns->ns);
> -	if (ret) {
> -		kfree(new_ns);
> +	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
> -	refcount_set(&new_ns->ns.count, 1);
> -	new_ns->ns.ops = &cgroupns_operations;
> -	return new_ns;
> +	return no_free_ptr(new_ns);
>  }
>  
>  void free_cgroup_ns(struct cgroup_namespace *ns)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

