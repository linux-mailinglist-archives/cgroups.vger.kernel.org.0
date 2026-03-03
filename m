Return-Path: <cgroups+bounces-14572-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKrsEosep2kUeAAAu9opvQ
	(envelope-from <cgroups+bounces-14572-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 18:46:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA81F4C7A
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FFDC3046DBC
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397A47CC87;
	Tue,  3 Mar 2026 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHPXDNMN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B523504B;
	Tue,  3 Mar 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560008; cv=none; b=mafZ06LzQ0shQMCHBAxLeofvT7FmazJNBdUjs2ewCSvbpiveWJgGzuzHBcj/SZOagu3TRfwRMdHjfvBF2ab4udznwC68KQhmlVq0n7Ck5fX52C2kG+aydCiqIWrUXo6lnAU61xZTOTpOBA6XVdvb/OFIbJjzjOERN61bsR1nhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560008; c=relaxed/simple;
	bh=pkZZGED7G2fAh6j3YIUUz6F68t5YZV31NNoav7BnR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAWKLiGbCTGCp1gafjW9z6LwJZXjz+sfZLf96WzJNb2VMfdox4MmzXH97kBaF/MwgrJ+uCTsR6B8+2TemK2k/gxyH72ejBlFQ/mxi9E/iLeRfZlPD080IF4rtTTzWaWJ1GCdiLlbT7GQgJDnoOtl4MiTddLLCjXpWZdhFiCocf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHPXDNMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C8DC116C6;
	Tue,  3 Mar 2026 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772560007;
	bh=pkZZGED7G2fAh6j3YIUUz6F68t5YZV31NNoav7BnR5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHPXDNMNz/mef/W/uZkh+FjjEBrvxDpUYyNbmnwRJwzFuyt8+XNwPjFnQbd9kCdPE
	 ShEK3kp5k2jhW0r3s/f53116GhH757HsRtknsGldVldwZMJ3jkL7XE3QLH52Ynh+1Z
	 r3pEvCxYBwt1xLLRwq45TNGnLPhgvVS2AZhYWSgaOKPWJ8lijSVMR4HLg733dz9NNw
	 EqbAdo2UqHLcnJZRmKujo3o9mFjSwWMj7n72509Q8nl1I3PIloxsgdYomjjErcqM8A
	 s3aEWqUmWZd8E28hCVleRF1FHsB1oSACBEnutGuYy1WOm9qp5ih/K1aEWmoW1YttB4
	 GRqvzTBjE8PhA==
Date: Tue, 3 Mar 2026 07:46:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <aacehv3rpO9irhEG@slm.duckdns.org>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
X-Rspamd-Queue-Id: C0DA81F4C7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14572-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

On Tue, Mar 03, 2026 at 06:11:15AM -0800, Breno Leitao wrote:
> Remove the blkcg_debug_stats toggle and always display detailed
> statistics in the cgroup io.stat file. This includes use_delay and
> delay_nsec information, cost.wait/cost.indebt/cost.indelay for iocost,
> and latency statistics for iolatency.
>
> The stats are already being collected regardless of the toggle, so
> gating their display provides no real benefit. Additionally, blk-cgroup

The reason for gating is that these are more internal implementation details
and might change in the future.

> has not been modularized since commit 32e380aedc3de ("blkcg: make
> CONFIG_BLK_CGROUP bool"), making the module parameter a historical
> artifact. Readers of the nested-keys format should be able to handle
> additional fields.

I'm not sure what the above para means. Module param works just fine for
built-in modules on both boot command line and through sysfs.

> Before (without blkcg_debug_stats enabled):
>   253:0 rbytes=6273024 wbytes=0 rios=20 wios=0 dbytes=0 dios=0 cost.usage=0
> 
> After:
>   253:0 rbytes=6273024 wbytes=0 rios=20 wios=0 dbytes=0 dios=0 cost.usage=0 cost.wait=0 cost.indebt=0 cost.indelay=0

Given that they haven't changed for a long time, maybe it's okay to expose
them by default, but why? This is something which can be toggled on easily
at any time. What's the benefit of exposing these extra numbers which
probably don't mean much for most people?

Thanks.

-- 
tejun

