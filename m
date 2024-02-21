Return-Path: <cgroups+bounces-1726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD785D560
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05101F2366F
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575083D98E;
	Wed, 21 Feb 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WJvTciW+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WJvTciW+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23D3D96B;
	Wed, 21 Feb 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510948; cv=none; b=EtCChpGkit9qPMub8M7TNnYADRAyLeMKZCJ9H82tpLfV/dzJcInkiZgMt9hRHqTODbo11lmQa3Yd3QMldhNvC0R1pTk5o4EBPykZCh4V/5dXieRgxRgJIpeeA0f9R8bkKIzsSbE/NhFvKWkSqUEwm+5uKzwMdetsegfFOSGoTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510948; c=relaxed/simple;
	bh=mL+kprjzT51esIJmHGVmrkTR6renHmueE7JLTXsvRow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moW1qosDG4oW2yy7iAQ8Zs+hiKuY0iggw2xuGY9tAdHSGQF9RZit7Kwid5Qq4MB2+zu59zNAcIORLzK8N4v2K4+p0lKdU1D7sL6ttAzJ+Cer1fSp59dPJKfnutx/JCL+5Kh4I2tgRuqImQS3J8h/UBAztIVz0cOnRQIiNLH6dD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WJvTciW+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WJvTciW+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865FD1FB4E;
	Wed, 21 Feb 2024 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708510944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUQXQbWJgELZMgcNLwzkaVchD+3Rj5s227haqHX0N/s=;
	b=WJvTciW+etvqI61sZ2YON21tndWkWqxdlXhMC1CzDAlJWk8l1QG4fhrkXb6u9LQ5ewo9Eo
	nKhqOBvylDd8dLQtbbZOZsXWJoUSDa0s/MHEKCPB/TBjtX8nlrkIQb/Kn5OEjNoUWPdA8w
	wECuTljBPVjTe8xoXGJkuolbzTR2xb0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708510944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUQXQbWJgELZMgcNLwzkaVchD+3Rj5s227haqHX0N/s=;
	b=WJvTciW+etvqI61sZ2YON21tndWkWqxdlXhMC1CzDAlJWk8l1QG4fhrkXb6u9LQ5ewo9Eo
	nKhqOBvylDd8dLQtbbZOZsXWJoUSDa0s/MHEKCPB/TBjtX8nlrkIQb/Kn5OEjNoUWPdA8w
	wECuTljBPVjTe8xoXGJkuolbzTR2xb0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6933E13A69;
	Wed, 21 Feb 2024 10:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gcG0FuDO1WV9RAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 10:22:24 +0000
Date: Wed, 21 Feb 2024 11:22:23 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Message-ID: <ZdXO39jcmhWeYUxS@tiehlicka>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <ZdW2gMajIw_cUN2-@tiehlicka>
 <5436af7a-26d4-7c04-466a-7163d5a26040@huawei.com>
 <ZdXLgjpUfpwEwAe0@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdXLgjpUfpwEwAe0@tiehlicka>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WJvTciW+
X-Spamd-Result: default: False [-1.93 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.12)[95.77%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 865FD1FB4E
X-Spam-Level: 
X-Spam-Score: -1.93
X-Spam-Flag: NO

On Wed 21-02-24 11:08:02, Michal Hocko wrote:
[...]
> You are right. Thanks! IRQ disabling is there in one form or the other
> since db2ba40c277d ("mm: memcontrol: make per-cpu charge cache IRQ-safe
> for socket accounting") so 4.8+ is safe. Backports to older kernels
> would nee to pull this one as well.

Scratch that. Prior to db2ba40c277d, we used to disable preemption via
{get,put}_cpu_var and that should achive the same result.
-- 
Michal Hocko
SUSE Labs

