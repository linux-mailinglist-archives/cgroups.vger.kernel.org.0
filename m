Return-Path: <cgroups+bounces-8438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9EACECFB
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 11:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E931897C07
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686FC20FA81;
	Thu,  5 Jun 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPqgb72s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1CqfV7Dk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPqgb72s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1CqfV7Dk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED520A5D6
	for <cgroups@vger.kernel.org>; Thu,  5 Jun 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116429; cv=none; b=KrmZmB6eNIwWg8RTB6QZp9oqdyiVj1F7yGT9ovuzdDi7vcS3grV9AHfHUrvhCXlS/+RzKSuox4MZQbrawfKBBKtNRGHCeJIolZpXXuNk30EDdN2t5UpCV3yzW23TyLDeBnzoqwwJzZ3/yS8UyDX+F3h6exXkeWKCWSZ3TdPFoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116429; c=relaxed/simple;
	bh=lVHCZ7PYX9+bq8eB6t8RCwhYKZgX8GhTAFw0k2l96Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6iorhfKiSimUZN4I4noHLk8INrJa5RX7bHA+ME+Jr2qtZMnUe3Ux1z684g+HDGgIs5F3jJA4oawanMaXTImXnupGucJwi0tYf2mdmWdPpx/xC0L65LJ1EcCR/wI9VMulNknyY6CWVP/aeYbAUXWBGfb+OPmgvLWd4U5CqFvRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPqgb72s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1CqfV7Dk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPqgb72s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1CqfV7Dk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 560E45BDFD;
	Thu,  5 Jun 2025 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749116425;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
	b=aPqgb72sQHj6CLOTo7+4S+SwYMWeVwYK4Cgqn3LcLIy32FuUB6o6Cm+8VwBmoRnwzgYgrE
	PV3dVC1kdQCt5Qlhgf3U61vhI+JtqYjW0ngDSOxD2svnj+TeaisoD4iPmWOy+gSchSpygy
	nEk3QCpGTieeKP/oW03FZZ5uQix/wDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749116425;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
	b=1CqfV7DkbTyTTahvLSLSTgv6RPrGlWqG+AvLQ/X/xjPOzRyD0butL539NRJQTpuwm2Vjga
	oW5Dmxl8x5uLI3Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aPqgb72s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1CqfV7Dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749116425;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
	b=aPqgb72sQHj6CLOTo7+4S+SwYMWeVwYK4Cgqn3LcLIy32FuUB6o6Cm+8VwBmoRnwzgYgrE
	PV3dVC1kdQCt5Qlhgf3U61vhI+JtqYjW0ngDSOxD2svnj+TeaisoD4iPmWOy+gSchSpygy
	nEk3QCpGTieeKP/oW03FZZ5uQix/wDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749116425;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
	b=1CqfV7DkbTyTTahvLSLSTgv6RPrGlWqG+AvLQ/X/xjPOzRyD0butL539NRJQTpuwm2Vjga
	oW5Dmxl8x5uLI3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B501373E;
	Thu,  5 Jun 2025 09:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UGTCBglmQWgMXgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 09:40:25 +0000
Date: Thu, 5 Jun 2025 11:40:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it, Michal =?iso-8859-2?Q?Koutn=FD?= <mkoutny@suse.com>,
	Li Wang <liwang@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
Message-ID: <20250605094019.GA1206250@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250605142943.229010-1-wegao@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605142943.229010-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 560E45BDFD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.71

Hi Wei, all,

> When the CONFIG_RT_GROUP_SCHED=y config is set, test cases like sched_rr_get_interval01
> will failed since limitation of RT processes with cgroup v2 cpu controller.
> The limitation is RT processes have to be in the root cgroup before enabling cpu controller.
> By default the shell will not running in root cgroup "0::/" since systemd will put shell
> into 0::/user.slice/user-xx.slice/session-xx.scope, so ltp case run within shell will failed.
> We can use this patch to workaround above limitation. If we agree on this patch, i will
> continue do same patch to following cases:
> sched_rr_get_interval02
> sched_rr_get_interval03
> sched_setparam02
> sched_getscheduler01

Acked-by: Petr Vorel <pvorel@suse.cz>

LGTM.

@Michal @Li WDYT?

Kind regards,
Petr

> Fixes: https://github.com/linux-test-project/ltp/issues/1245
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../sched_rr_get_interval/sched_rr_get_interval01.c         | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index b4d75bdcc..55516ec89 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -43,6 +43,12 @@ static void setup(void)

>  	tp.type = tv->ts_type;

> +	if (access("/sys/fs/cgroup/cgroup.controllers", F_OK) == 0) {
> +		int pid = getpid();
> +
> +		SAFE_FILE_PRINTF("/sys/fs/cgroup/cgroup.procs", "%d", pid);
> +	}
> +
>  	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
>  		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");

