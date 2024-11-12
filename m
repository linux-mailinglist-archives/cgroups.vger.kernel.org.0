Return-Path: <cgroups+bounces-5514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7949C52AA
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 11:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE9EB25D9E
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B720E303;
	Tue, 12 Nov 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2FkgLyr5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B361OqMl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2FkgLyr5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B361OqMl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521171AB535;
	Tue, 12 Nov 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404751; cv=none; b=pW58Inq3ljwkjqW28+b0LRoIKGo+DMhRfAp4QhQouCY/+04SId89hgiWuUn8gD/BLUBWvyS6NwH2Ih2teuO8GcSOjGUQ7bRZoMM4xvn73gwN0CrVyStO1tPjfFCtIkIqIviSjW9LER+er8kayKgZmWdfU2hBfVxeibfUCFysZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404751; c=relaxed/simple;
	bh=ljeR1gVYmyDdFviM5rf/02C23DvoOrC5RNVx3TCT1js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhDSIsazpVC3FpDjoL8UDgQFv1X4AQhx3zER6HK38vZpS8Y+8Pbk5PjBkJMPnizqpBXCbE86TbzEukXJHuaLoecZOQdQiy7nxD9c9cjS/qvVOmDZgJWup+sFPxpmwhiR/dsKBOypLtfVgDhqRqJMz5EKy8AGynlg0YQz0YUMGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2FkgLyr5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B361OqMl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2FkgLyr5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B361OqMl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67F841F453;
	Tue, 12 Nov 2024 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731404748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljeR1gVYmyDdFviM5rf/02C23DvoOrC5RNVx3TCT1js=;
	b=2FkgLyr5sEp6oGB9zgoO5mKZSHX7dFg7/01ERs4UexgnjBd4XmcFEWXeCIOcs+waHDYRJc
	OvbCm33g4BI76jjXDm4fmW5uuYYPWXpXlcjacTsiRp5g4dxaw1YEqz3ztJipKbAumHkyoK
	nzbJ6x0BVyxx/nEe/wAh41RMaFui1p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731404748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljeR1gVYmyDdFviM5rf/02C23DvoOrC5RNVx3TCT1js=;
	b=B361OqMlRcnQ7O8RFgCZOd8ATT6PsJhYgmp0htOTMgQc8XvQAICMvY5lPF/HSU+b3DcThG
	dMRi2AjfVxHf1aDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2FkgLyr5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B361OqMl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731404748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljeR1gVYmyDdFviM5rf/02C23DvoOrC5RNVx3TCT1js=;
	b=2FkgLyr5sEp6oGB9zgoO5mKZSHX7dFg7/01ERs4UexgnjBd4XmcFEWXeCIOcs+waHDYRJc
	OvbCm33g4BI76jjXDm4fmW5uuYYPWXpXlcjacTsiRp5g4dxaw1YEqz3ztJipKbAumHkyoK
	nzbJ6x0BVyxx/nEe/wAh41RMaFui1p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731404748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljeR1gVYmyDdFviM5rf/02C23DvoOrC5RNVx3TCT1js=;
	b=B361OqMlRcnQ7O8RFgCZOd8ATT6PsJhYgmp0htOTMgQc8XvQAICMvY5lPF/HSU+b3DcThG
	dMRi2AjfVxHf1aDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D78813721;
	Tue, 12 Nov 2024 09:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rTuAEMwjM2eaIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 09:45:48 +0000
Date: Tue, 12 Nov 2024 10:45:47 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, 
	Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
Message-ID: <6604a1a1-e1cb-4d34-997e-de5a4263a68a@flourine.local>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108054831.2094883-3-costa.shul@redhat.com>
X-Rspamd-Queue-Id: 67F841F453
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 08, 2024 at 07:48:30AM +0200, Costa Shulyupin wrote:
> The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
> boot command line options, are used at boot time to exclude selected
> CPUs from running some kernel housekeeping subsystems to minimize
> disturbance to latency sensitive userspace applications such as DPDK.
> This options can only be changed with a reboot. This is a problem for
> containerized workloads running on OpenShift/Kubernetes where a
> mix of low latency and "normal" workloads can be created/destroyed
> dynamically and the number of CPUs allocated to each workload is often
> not known at boot time.
>
> Cgroups allow configuring isolated_cpus at runtime.
> However, blk-mq may still use managed interrupts on the
> newly isolated CPUs.
>
> Rebuild hctx->cpumask considering isolated CPUs to avoid
> managed interrupts on those CPUs and reclaim non-isolated ones.

As far I understand this doesn't address the issue that the drivers
need also to be aware of isolcpu mask changes. That means even though
the cpumask is updated in the block layer, the driver doesn't know about
it and still runs on the isolated CPUs.

