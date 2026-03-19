Return-Path: <cgroups+bounces-14907-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFcWJA6pu2nHmQIAu9opvQ
	(envelope-from <cgroups+bounces-14907-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 08:43:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E62C76A7
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 08:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6884D3010708
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D43126B9;
	Thu, 19 Mar 2026 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="WTp8CUaE"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089E3A2553;
	Thu, 19 Mar 2026 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906181; cv=none; b=qRGvwAzDT63LjlfnAXgSHzWALfTnAxVnv+4zKO3JXaDmxlKo0f8aJAw2zRAUEm/SEAZsp0H2nU/cfmN41lWl+YOgNHsy1OUSG7JYwa72OnPMOHaUkZqFbz0GWt0sqMTohMPd5wySAOoOe34UN4kQuPCzZSBv6+6myRXwQ2zUhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906181; c=relaxed/simple;
	bh=GI1MMOu7ozOvsqPhn3U+jh0cQvqHV/DjuV5hbp6Xjhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw/WMAStq5F3hTJhJgZkI7xQEGT006tiUSOddp7xEAmOHQEHK6HUbtMRUl9jh/kXlo8BcrrwnX0qVvyy6eAU6983srKhmYkPkWxtb6Qt+2S26/WSBbHJV6+IYK9UfVQ4nEyhiIAG6J+5qphkN3ayLDiz6EdsE0dx4tr9RIsmqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=WTp8CUaE; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1773905593;
	bh=GI1MMOu7ozOvsqPhn3U+jh0cQvqHV/DjuV5hbp6Xjhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WTp8CUaE7W0/ZezWpjqDPg1ObjGKeXeopsPhsbRIhFwfzWEDHpkztoHwFDzY57wsq
	 OmKpggVaRUuOC5K2+XVlZmUr9eJB3l0kBmvDeDJawaS8zWX19nRuNPO71UBWktouZw
	 IiqVbVcVqAdoRkpc0fnvTA7EqZV20Tt7CgCY35LXT1OxqPzA9T8np3wRfTmEbHDkYh
	 E9uaQN31MvYTIlXqVXIPIU26lp5NAaROOSEUboR++qFwGiWb+yNq/9xEqZMS4buUS6
	 nq4p4n4G8KJAfFEuDCRNFr8043ieRggyGwAfvpIZ+nhE32w/bUhQ3TI4Hx+t4l+SEw
	 aC7VUoUKoC2og==
Message-ID: <02c0752a-1a66-4938-9f5e-152c8c98741f@lankhorst.se>
Date: Thu, 19 Mar 2026 08:33:12 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14907-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[igalia.com,kernel.org,gmx.de,cmpxchg.org,suse.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lankhorst.se:dkim,lankhorst.se:mid]
X-Rspamd-Queue-Id: 907E62C76A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-03-18 kl. 20:34, skrev Thadeu Lima de Souza Cascardo:
> page_counter_set_max may return -EBUSY in case the current usage is above
> the new max. When writing to dmem.max, this error is ignored and the new
> max is not set.
> 
> Return as soon as setting one of the regions max limit fails. This keeps
> with the current behavior of returning when one of the region names is not
> valid.
> 
> After this fix, setting a max value below the current value returns -EBUSY.
> 
>  # cat dmem.current
>  drm/0000:04:00.0/vram 1060864
>  # echo drm/0000:04:00.0/vram 0 > dmem.max
>  -bash: echo: write error: Device or resource busy
>  #
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
The semantics of dmemcg should not substantially differ from the memory cgroup
controller. I believe the memory cgroup controller does allow setting a lower
max, and will evict until below the new max.

See mm/memcontrol.c:memory_max_write

We should probably do the same in dmemcg instead, although we currently have no
mechanism to evict, setting a new lower max at least prevents future allocations
from failing.

I believe we should have a similar loop in dmemcg, and allow ttm to evict until
the new max is reached.

Kind regards,
~Maarten Lankhorst

