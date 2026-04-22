Return-Path: <cgroups+bounces-15462-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJaCMr4E6Wl5SgIAu9opvQ
	(envelope-from <cgroups+bounces-15462-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 19:26:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57F449473
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9967300CBE1
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532A3815C5;
	Wed, 22 Apr 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrCs5imr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0F351C1F
	for <cgroups@vger.kernel.org>; Wed, 22 Apr 2026 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878706; cv=none; b=RerQ5INuyAojLDDV1BGPHEJSqiZodpv/GO0MugbZ6igDqz9XBySFBTFRjvnzII5bNrBOnXQivEunTBM7hjOqpgH/zAJymQ3egM5KC7P2M36dMJ+t5OYBD2NkOjxxLChXls7h3MvjOiCv7G5PWTqDImmLzNNCBIxoMs5HKTdfRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878706; c=relaxed/simple;
	bh=tn4HfWfJPYZGKMVmZBVTldabB9Uf8lpKAQp4kB5iTPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb5gOJvRpYpBBjkp4B8pzD9MzJJzGG7qXiGa4d0+VIvKJbVfU3Smwadw8139WrrbLXW8QDEUsiSwR8/nVoqTheH4WBMbcFgZ8h1+OYRkQ/lrqKxMsni2/8siMUj9W7LYY4EQM9HuNSGWARoZvcWir/ERf44RrubsEzW4AZOQTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrCs5imr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C3BC19425;
	Wed, 22 Apr 2026 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776878705;
	bh=tn4HfWfJPYZGKMVmZBVTldabB9Uf8lpKAQp4kB5iTPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrCs5imrijH2CZYPv6O132roWJVlDOg31C/QdJn1rSMyXC+HpNvzYbg4kXybrFlEX
	 v5P98nb9P82ZAJ9a9nSFIQx6cXvc9yTffrDfroza+HFlAFeOWYhSTw2+sBmxUgouht
	 TXa1igEuV3Mp0nGYe8CTqYOnpINh4S1EecNeL5uMgdfP+HLcpMNcXu88f1Iaxvzg1k
	 qC5xtcyyOFX8htMtyYKLXOFe85He/PmJoS5z9Q9KmLDJAis4OYbqpgOMaWxPvPUMHs
	 36VrPrdw411bBsfO6SYznummcNEIfETlyajkSbT5rK4qzy1/aOJa/e7YHzaz9Xp6cD
	 JFmAA9lINnxkw==
Date: Wed, 22 Apr 2026 07:25:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Subject: Re: [PATCH v3] cgroup/rdma: refactor resource parsing with
 match_table_t/match_token()
Message-ID: <aekEcJoPGpy72yo0@slm.duckdns.org>
References: <d2d00a690c69213cad3d469f0ef478a9@kernel.org>
 <20260422021709.333689-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422021709.333689-1-cuitao@kylinos.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15462-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D57F449473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:17:09AM +0800, Tao Cui wrote:
> Replace the hand-rolled strsep/strcmp/match_string parsing in
> rdmacg_resource_set_max() with a match_table_t and match_token()
> pattern, following the convention used by user_proactive_reclaim()
> and ioc_cost_model_write().
> 
> The old strncmp(value, RDMACG_MAX_STR, strlen(value)) also had two
> bugs that are fixed by this refactor:
> 
>   - It matched "ma" as "max" because strncmp only compared the
>     shorter strlen(value) bytes.
> 
>   - It silently accepted "hca_handle=" (empty value) as "max"
>     because strncmp with n=0 always returns 0.
> 
> The match_token() approach also robustly handles extra whitespace in
> the input by splitting on " \t\n" and skipping empty tokens.
> 
> Suggested-by: "Michal Koutný" <mkoutny@suse.com>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Looks fine to me, Michal?

Thanks.

-- 
tejun

