Return-Path: <cgroups+bounces-1504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C828F852CE8
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EC7B2582D
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D4487B6;
	Tue, 13 Feb 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PxGx4mjI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DllEvvoi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374B4CE18;
	Tue, 13 Feb 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817352; cv=none; b=B/kapRszbY/j7EIpDmtbKbtpeeeSSDi9q5xDcshbcrzpwoNaocT9Z+Q/QWKZfwbtPeZChYpIeIe2f7nDQSYI3pjGxkUPFvsMwDtd371AepLVPfsphXzjTSPDZLYetOtNuXIFg19XXK3IZsN4YslY35s56xV4/4T8GcenJibVv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817352; c=relaxed/simple;
	bh=E1fFov0gm3FcTflVmoUjwoUZ3Umb2yAAIG80SuNXqfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY5IOqsB3bhjJMvi3q1Fv3XxB/G9DWtHBxdiudaZd6HqJgXakHf1eWh/sz/zJtaA9znBe01rLmBBoM88+dPcSc4cRi3GliAROuEZzjv7RgylzHyTtTbdw1/Wx+epUXv8mgiy+wtevDMxWEUhIxXqiEFHjDg/7kvyZfWrnT68BkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PxGx4mjI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DllEvvoi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED45F1FC81;
	Tue, 13 Feb 2024 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707817348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2Ltw12kqpA6OxvwDncuH/HwlbdCgZy0yfwT2wFnJeI=;
	b=PxGx4mjIyTfC5qkijDQ3F7ewptxWcNNvw/5AwqogaCDSrwUGuiddySK7UNzHm5ZyUI5yju
	3OpEPOPoimtCqrbNiO9m96DBgvQuZ9/Kx6hub8QfM6HItxfNsvsJApA0jAJz+CYCrprns0
	uFLipUkmHrCUtIv2sxyogGEGQ9X2hQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707817347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2Ltw12kqpA6OxvwDncuH/HwlbdCgZy0yfwT2wFnJeI=;
	b=DllEvvoiBQpim82m7fFn3FEJrkiQnFxNNdXKl0fo3lcDWOuJ74M5VE2PvNGKT/I8MKfDqS
	jBf5tlEEwBWkRCpNPEbbX2pM/W6iuhj02h4Kt/3bW70l3jjkYwTBFbTsbKHMx3GB51gwLG
	nj5nBNP9jAzq8GcP6An2pi5nYT1O0tk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4C1A13A69;
	Tue, 13 Feb 2024 09:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B5n2MIM5y2UOXQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 13 Feb 2024 09:42:27 +0000
Date: Tue, 13 Feb 2024 10:42:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonas =?iso-8859-1?Q?Sch=E4fer?= <jonas@wielicki.name>,
	Narcis Garcia <debianlists@actiu.net>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
Message-ID: <Zcs5g8ILg9WXfZYm@tiehlicka>
References: <20240213081634.3652326-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213081634.3652326-1-hannes@cmpxchg.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[28.71%]
X-Spam-Flag: NO

On Tue 13-02-24 03:16:34, Johannes Weiner wrote:
> The swapaccount deprecation warning is throwing false positives. Since
> we deprecated the knob and defaulted to enabling, the only reports
> we've been getting are from folks that set swapaccount=1. While this
> is a nice affirmation that always-enabling was the right choice, we
> certainly don't want to warn when users request the supported mode.
> 
> Only warn when disabling is requested, and clarify the warning.
> 
> Fixes: b25806dcd3d5 ("mm: memcontrol: deprecate swapaccounting=0 mode")
> Cc: stable@vger.kernel.org
> Reported-by: "Jonas Schäfer" <jonas@wielicki.name>
> Reported-by: Narcis Garcia <debianlists@actiu.net>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ed40f9d3a27..107ec5d36819 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7971,9 +7971,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
>  
>  static int __init setup_swap_account(char *s)
>  {
> -	pr_warn_once("The swapaccount= commandline option is deprecated. "
> -		     "Please report your usecase to linux-mm@kvack.org if you "
> -		     "depend on this functionality.\n");
> +	bool res;
> +
> +	if (!kstrtobool(s, &res) && !res)
> +		pr_warn_once("The swapaccount=0 commdandline option is deprecated "
> +			     "in favor of configuring swap control via cgroupfs. "
> +			     "Please report your usecase to linux-mm@kvack.org if you "
> +			     "depend on this functionality.\n");
>  	return 1;
>  }
>  __setup("swapaccount=", setup_swap_account);
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs

