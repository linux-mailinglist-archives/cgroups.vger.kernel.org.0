Return-Path: <cgroups+bounces-13971-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIp2FDAOlGn4/QEAu9opvQ
	(envelope-from <cgroups+bounces-13971-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 07:44:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED14D1490E4
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 07:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F08F30071FC
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F62C11C2;
	Tue, 17 Feb 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZRQrc7j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5A298CC4;
	Tue, 17 Feb 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310636; cv=none; b=Ovd0gvnnaU6fezg/AVHXYD9AT3v3n3IWpLcDQNYnNoZT6na6VyxdasZel5ElUxpxyIHde4Vt/nKyehALPwLcyBOjml4O/ugiINvbN/Xpe4kxdQfq/epzb3hFhH/Myk9XajYTX+Xi8onnlKqXC4AJJXGFs1ukoieQKfO7L7ecbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310636; c=relaxed/simple;
	bh=RL8wZb/KGujFWK7DHIooqWJaLqn+f83yP0M7AoFklkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLwj8GjVQN2k+K8yzlAoN/CR5ScSaFrVjlh/aDZNUzWIo4fRGKxfUU8pzi4eAKqIWUqt70m3BYO8k9kHZz2UMDfvxCxpxBkwMo2BmiqdPzYaBrl2EPKrMhHyDb9/gBGWXGZM59GqRdSpuRtZ6MRy951T9+pwbjYtroL4qt7dT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZRQrc7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B997C4CEF7;
	Tue, 17 Feb 2026 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771310636;
	bh=RL8wZb/KGujFWK7DHIooqWJaLqn+f83yP0M7AoFklkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZRQrc7jHpGvHElmGqMAABrS7epNMxGntrnhbm8r/UN3f5kO9iPy8j1LnBdVCISq3
	 JS8SXUcF9tLztjvp8mg4OHvvwDYn+nSGI1ZLUsTVInmTAC01MYBOwnppnwD8ipXa+r
	 1a5M12OU7d5yZy+WTTf9aLr30cqx3ssVdvEhyG3SUz18+0rcrUCHn10RMuEo2nE1Qi
	 kAoWbZ8I7PLJeN6BuzmrvJVignuSnklJ4XXPjDGPtZFpA5I+hy4rOP5T+gUEUhQrDa
	 dBu6nYyDUeDPWiXO8EkYNTOETe4OFw0HlQXRG5eUVbuf1BnuVYPsf4cio5MJFN0R3e
	 JDZfSDhjEi/CA==
Date: Mon, 16 Feb 2026 20:43:55 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED
 support for files
Message-ID: <aZQOK_xnxQn09qmP@slm.duckdns.org>
References: <20260212215814.629709-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212215814.629709-1-tjmercier@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13971-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid]
X-Rspamd-Queue-Id: ED14D1490E4
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:58:11PM -0800, T.J. Mercier wrote:
> This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
> events to kernfs files.
> 
> Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
> but fails to notify watchers when the file is removed (e.g. during
> cgroup destruction). This forces userspace monitors to maintain resource
> intensive side-channels like pidfds, procfs polling, or redundant
> directory watches to detect when a cgroup dies and a watched file is
> removed.
> 
> By generating IN_DELETE_SELF events on destruction, we allow watchers to
> rely on a single watch descriptor for the entire lifecycle of the
> monitored file, reducing resource usage (file descriptors, CPU cycles)
> and complexity in userspace.
> 
> The series is structured as follows:
> Patch 1 refactors kernfs_elem_attr to support arbitrary event types.
> Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
>         on file removal.
> Patch 3 adds selftests to verify the new behavior.

The patchset looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

