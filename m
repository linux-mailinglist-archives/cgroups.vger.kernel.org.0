Return-Path: <cgroups+bounces-14904-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO/gNr4tu2nqgAIAu9opvQ
	(envelope-from <cgroups+bounces-14904-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:57:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866F2C3ACB
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 428AE3032DFA
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606C35A38E;
	Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2yStBZe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF03019AA;
	Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874619; cv=none; b=c2tuhJrX0LXwaXi11pxGjcXQ2Mv2dwG9M1x+b0eScuL4krfSLEznxhpixcCoU4mizA+aD9Z6evZKUM3tOwsESStjBgteRRTcsRwgTKXawYWwg8IjiRXt78P4EzlaIWJPCMjFOZi7eKUEuHag0znuBNYuy9kOxMunSgLBc5AvtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874619; c=relaxed/simple;
	bh=ObfiedzrwsT34Y8biasL83aWxVvgU9ByOpIkysicBaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOPTxFUkqFS65ULtUJK1LVVUXkKeoOII5tIkq7bJcOcbpcWzkydSH0TdH1qdDP5ofstnArRQr//oQWfiodA9uSuACWeL0Dz1A52m8MCsLcysK7/7aeFrnAUeXUc/WCnvwg6t4S+P7pYGCWbBSUxnrGXnuFkqw9mGs2EaH828O1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2yStBZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1719EC19421;
	Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773874619;
	bh=ObfiedzrwsT34Y8biasL83aWxVvgU9ByOpIkysicBaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2yStBZe2+vQHXAU97dz9MtvegAKXsuZUAxqH+mDtFLlNP/8TYDcD1AHgZoXTTTvO
	 KnQ2ioQ574gvQnL4AzSUmQhhRj5g/UWA091Reybt+i7aRaFe5j3oS9jLeCMw2fh0fS
	 D/GN3wge8/ByiLaBT2OvkQeDuUqvzIlTACOvbzQfUn6c5C50JNAVEedQG9PsAGgAvX
	 IjsV5pg2NusfKkR52Mq0p5i/amUZep0A34rn+r+RkTCw/I1/yS9sfyJ1mjkAHntq1Q
	 1H+AqekIERYMikOLJYCMGx50jNayfuXvZMupL3/C1S5hhH6CSBQCM3P3n3w/ar/wz2
	 dkBgIf9sBO4jg==
Date: Wed, 18 Mar 2026 12:56:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
Message-ID: <abstuhuD4FJ-RMcc@slm.duckdns.org>
References: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14904-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org,igalia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5866F2C3ACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:34:17PM -0300, Thadeu Lima de Souza Cascardo wrote:
> page_counter_set_max may return -EBUSY in case the current usage is above
> the new max. When writing to dmem.max, this error is ignored and the new
> max is not set.
> 
> Return as soon as setting one of the regions max limit fails. This keeps
> with the current behavior of returning when one of the region names is not
> valid.

Ugh, I don't know why dmemcg_limit_write() is trying to handle multi-line
inputs. After this, there's no atomicity w.r.t. failures either, so this
seems entirely pointless. I'd much prefer to strip out the multiline
handling.

Thanks.

-- 
tejun

