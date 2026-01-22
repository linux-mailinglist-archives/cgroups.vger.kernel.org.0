Return-Path: <cgroups+bounces-13376-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMQuCv9icmnfjQAAu9opvQ
	(envelope-from <cgroups+bounces-13376-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:48:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B2D6BA59
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20D71308E540
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C1A367F42;
	Thu, 22 Jan 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vVvwcwn7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860F2F9984;
	Thu, 22 Jan 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102033; cv=none; b=JxGRkTJ/iXyWm9EjJX5xWyXaqxlbc2Kj9gvEh2OBrLUQmpBiKtxQsyJVOpSybF3tvpss7NHuCoVm8KLfRTotBl9FYeT8D4Fsx1t4UeEd/QE+053+gDAz+n00bd8QDTZMxWmO6A1vKCl9Dje+NVeoOP084bTZgyYvAf+N8dgL0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102033; c=relaxed/simple;
	bh=7G/QqXvcC6v2q6kq4mByfBDUfC++L542v7aEpHMt1Gs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CT8iL+PkAduU9D/SxDLg46CnOH2xSNtMlHh7iLiO7YE4sUD44xT3VR3Hb+TCO5QK6A++g6RAQndhP4edD4xCx412YsplAyVXbE7xwtr6vwRS17FM/SPsigktour6bKUmOrQasqbZ5VRIVN34RT80HTQ0m/5+DorNgpgL4VkSQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vVvwcwn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2411EC116D0;
	Thu, 22 Jan 2026 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769102032;
	bh=7G/QqXvcC6v2q6kq4mByfBDUfC++L542v7aEpHMt1Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vVvwcwn7p2eSF8OAMa7tYkMn2kTkDU/wPhaNdoQeovpIeSndvlEMTIfKF7OgArV1j
	 qCwF4mUnFifje2mTXdum7upR7dZSnWm+Tt5Md5YEmTBtT4SyYPn1JbB53Q68xYIo9r
	 Hsze7rW0ouJRsMqAxWIlCC1LYhSwc9ceYZvNUKVA=
Date: Thu, 22 Jan 2026 09:13:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: optimize stat output for 11% sys time reduce
Message-Id: <20260122091351.0cc1afd5d419fafa1d98b32f@linux-foundation.org>
In-Reply-To: <20260122114242.72139-1-wujianyue000@gmail.com>
References: <20260110042249.31960-1-jianyuew@nvidia.com>
	<20260122114242.72139-1-wujianyue000@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13376-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94B2D6BA59
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 19:42:42 +0800 Jianyue Wu <wujianyue000@gmail.com> wrote:

> Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
> printf parsing in memcg stats output.
> 
> Key changes:
> - Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
> - Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatting
> - Update __memory_events_show(), swap_events_show(),
>   memory_stat_format(), memory_numa_stat_show(), and related helpers
> - Introduce local variables to improve readability and reduce line length
> 
> Performance:
> - 1M reads of memory.stat+memory.numa_stat
> - Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
> - After:  real 0m9.051s, user 0m4.775s, sys 0m4.275s (~11.4% sys drop)

So the tl;dr here is "vfprintf() is slow". 

It's quite a large change, although not a complex one.

Do we need to change so much?  Would some subset of these changes
provide most of the benefit?

It does rather uglify things so there's a risk that helpful people will
send "cleanups" which switch back to using *printf*.  Explanatory code
comments would help prevent that but we'd need a lot of them.

I dunno, what do people think?  Does the benefit justify the change?

> Tests:
> - Script:
>   for ((i=1; i<=1000000; i++)); do
>       : > /dev/null < /sys/fs/cgroup/memory.stat
>       : > /dev/null < /sys/fs/cgroup/memory.numa_stat
>   done

