Return-Path: <cgroups+bounces-15083-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJvfGpTpxmloQAUAu9opvQ
	(envelope-from <cgroups+bounces-15083-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 21:33:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9734B091
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 21:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2515B3228966
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51E33F37A;
	Fri, 27 Mar 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs5btly7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7691AAE28;
	Fri, 27 Mar 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642980; cv=none; b=LANr0PIuMXuQwwqAc9aSVth0XHSlA0hq3KQQe/rCPdelYilyRhF/YKqfnONXU/+MGNVaxacarmFJHoyKm1Scbyvdx7L1ClfPyeKHU+BsUqkaA1DjHrxsSbsDjJYs1zysIr1GKTuYDZHakgkxuaDwdj6RL3YIQU5KD3kB6NgHjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642980; c=relaxed/simple;
	bh=MxC+Xuv4NLv/joNSqRmP6GEKENw6AfHHBXhz0BBGATI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ/VIf/v7TRf2tQFK+/kj0qBQUZohdUn73HNw/XmcJC415mI2YPqzmvKrCovoZ2wDwkaeVsYzreB4MeSb1AxJc+MPFl54qq8V4TzxTlJUE+B1cW7nJ1G4mwvczidRpnNMGbcnyz4+ueQpUL/uYqi3bSRyv7Ye5j0HkRYAD4AWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs5btly7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C7C19423;
	Fri, 27 Mar 2026 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774642980;
	bh=MxC+Xuv4NLv/joNSqRmP6GEKENw6AfHHBXhz0BBGATI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cs5btly70FXOrdhUtbcbIZRLGtH29Z0hdSXQr2zcpb0XUx9KhO1KAeKb9ncwIiuma
	 /F3rUyjkRewSJkwVzixqOcpnNmSyn90chxj6KwuYtw0aoG8PALdef4OlVZyc8jGk4i
	 6PE94krFoVhC1JUeQkXEKBlvYdjqja0fNxKoCkHli55/etbOpOu2kmnzoOLbngY6Tm
	 UGgr1rZPVszQTlYJqSTUkG+jQVmccpbXqF667dhV2M0+qzUvHqh0evCr2R4/BZRxoi
	 TAAmQfioHpPAuMFc0w6z2feAqF4gdVkz3eJcdujYPaq/UyORwZgGA/mSZajbKT8lUU
	 1XjZTe0npSBXw==
Date: Fri, 27 Mar 2026 10:22:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Skip security check for hotplug induced
 v1 task migration
Message-ID: <acbnI21DC-W_uE2F@slm.duckdns.org>
References: <20260327201546.2463644-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201546.2463644-1-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15083-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00A9734B091
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:15:46PM -0400, Waiman Long wrote:
> +	/*
> +	 * Set to true if a kthread is moving tasks away from a v1 cpuset with
> +	 * no CPUs
> +	 */
> +	kthread_move_task_from_empty_cs = !cpuset_v2() &&
> +					  cpumask_empty(oldcs->effective_cpus) &&
> +					  (current->flags & PF_KTHREAD);

PF_KTHREAD test seems odd. Can't you pass this in as a flag from hotplug
handler?

Thanks.

-- 
tejun

