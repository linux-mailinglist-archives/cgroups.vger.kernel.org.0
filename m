Return-Path: <cgroups+bounces-17705-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5vtMHo3DVGpuSQAAu9opvQ
	(envelope-from <cgroups+bounces-17705-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:53:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C0F74A025
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:53:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=JPVlFIdy;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17705-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17705-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B5F305F598
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63F3E8C78;
	Mon, 13 Jul 2026 10:51:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548513E63A6
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:51:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939891; cv=none; b=H33aQQh7jzsr3lrvx2YRIj29S/4YSKejrP1xIri+0Ic/zoVy82M4Y7vN/7GXCpo5KXhJMBWNeybWmSMX3Ot6C8I8omUZkLIAuPVDZ/ImaIYv8R6H4tpJzCCR0kIXuccBeAc7CzIDVWAXKykHCpdxuErle4zgP3Jja8oGLOiVobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939891; c=relaxed/simple;
	bh=z11t9LwXEAps95nmJFn9bgrfWgmUbK8OsamIUC9xo1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW3YUoQ9+baG5FB1ebBvAu/bUMS91xUF2BpX9iSLO7a4f7o3TDd5codOKZiUOXHk8whDRXIToXJoLX8fR/mIPQQnHEgtV/ILbVdePbIyIa0dWnM2SUHSNObCZzLuiglTsE12upQCE87DYE6GXJrKnp5ILIDp3ApP7A/o53byRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=JPVlFIdy; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c19bad03so26968065e9.2
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783939886; x=1784544686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xXW5DaPK6zTkeDY542N1FQHx5XzZ6y+YRGl+QSs6T8=;
        b=JPVlFIdyMwRdVhC86ydqr99/64xCRL6D6aF7eae8LtLF9rc06YsiWrtdCA6PObfymd
         3/iU7jvxeokSR0uG0D5kNWpUvJbKcYUgyzH971ynv8JdInuUHCC0bQRP+EH77UqyPLZt
         QCD0dX99TjviXX/e2LpI02dPhqLtVEwkJP8OMpRFTXpGek+0t/MceBgJ0OJB73KWgx3d
         qkEO8VFFRzJ97pHa2OCT7TnGdGAxFpPzTQZvw9a1Ycgni+XHAUtcJdTVbP2A8hjEwFFM
         d9N5tL+VwXNiTEbRZsNT9fODiW4YSz7GH8gqHcNZJRkbjMjKTC5cI+kWcNrEOE6OUQH0
         LFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939886; x=1784544686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xXW5DaPK6zTkeDY542N1FQHx5XzZ6y+YRGl+QSs6T8=;
        b=hCY8rNXk8mKVIS5a5FNj23FYrR3JEmKS8FqJEev4A/TyzRGproxcJ1BcnilnFdMS51
         IlWccGaNw/TTT0L3tZ5SmF97yeiY9hE4AEds9sLE6SrawAvIUrsGS+JWBFld5Cgq/d2a
         zEJBYVQ1uDIgu0T7kGSrx5xwHR+CXExQ327gDkMPddAQSWjUEsM0ulceE17iaH+5c6Bn
         8IFNrNBQ4GGeswnbF8gZqsjndoTe643KWwDOAfqniWNpzssW5GYXvGkGjj225pBhIOki
         ALfS0RKJ99WN1V9wcv9lwfT8vK6pTPTA5qUpka26yvSRx1m87XjvWu/6siW7v6jODUBo
         avKg==
X-Forwarded-Encrypted: i=1; AHgh+RpppPG2oSbzAfJ5BQesh0os7AdZEY6lP5UP1uW1psbcFRx7GhWrpat7w2thOJ9C7jk8XPgCHEBV@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUgr+OWuGPG9BNvy1b3SGVUFlb+yJS4CJ8fR7b406N+yKK0eq
	n3lrsrPxIicVmS4D0WD+ZPLx7MDcgSwBCoQbVVsu7Q86Jp7sNJ1B9Io7EYiqjiqrNuc=
X-Gm-Gg: AfdE7clBNdIbkSpccdfyGQ+PFioLsjcHvFCi10gm7t6cK6OPHvFEY86eHkYLBYPfbVZ
	OkbPV7+N4DEaLX/PHtSKFmaBUIuGBE33ER93gUV8dDqOXygiNNy7ouYWqGWctOdY84+MmwnXp79
	AyFmFPs9/mZPMkKrbCxoKcsphQkJeRGf0M8ropADw8v0bGgOga/mFRhFEhwD8onDmCsJ/3RBr1H
	A7DOsWerfYVIHKMchqyBtjEQDTR58gqWHz27mNAI/0DHaCTrr0m+Rq0pBOwh6xrEBRaqxcmY+Yt
	IbJ42XjvaFf/8yb9loDPbEc8oZGDZKI6ImyAHyjr+84Annq83U3Cxkn2mbBpTTs2rc1KATV0N/8
	K3ydQpoO4zLp6vMVWQMWg4fDDvv9atSCVVKBnI7pfwfcokVygW6QRbgQNTkPfBYol0HqYmxbuUR
	N1baXTG7vgwQ==
X-Received: by 2002:a05:600c:1906:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-493f883b7e8mr84731245e9.38.1783939886273;
        Mon, 13 Jul 2026 03:51:26 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm573716585e9.2.2026.07.13.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:51:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:51:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"ziwei . dai" <ziwei.dai@unisoc.com>,
	"ke . wang" <ke.wang@unisoc.com>,
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
Message-ID: <20260713105123.GB276793@cmpxchg.org>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-2-tj@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17705-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[readmodwrite.com,manifault.com,nvidia.com,igalia.com,google.com,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2C0F74A025

On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> made pressure_write() hold cgroup_mutex across psi_trigger_create(), which
> forks the psimon kthread for the first rtpoll trigger. As kthread creation
> depends on the whole fork path, the commit inadvertently created a lot of
> unwanted locking dependencies from cgroup_mutex.
> 
> sched_ext got hit by one: its enable path blocks forks and then grabs
> cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, with
> every other fork piling up behind.
> 
> Fix it by splitting trigger creation so that the worker is forked with
> cgroup_mutex dropped and the kernfs active reference left broken. The latter
> matters because rmdir and cgroup.pressure writes drain active references
> under cgroup_mutex. Publishing the trigger last keeps error reporting
> synchronous and preserves the of->priv lifetime rules.
> 
> The trigger registered in the first stage pins the group's rtpoll machinery
> across the unlocked window, leaving only creation races to resolve. The
> catch-up poll on installation covers scheduling attempts dropped while there
> was no worker.
> 
> v2: Retagged sched/psi (was cgroup).
> 
> Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> Cc: stable@vger.kernel.org
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Chen Ridong <chenridong@huaweicloud.com>
> Reported-by: Matt Fleming <mfleming@cloudflare.com>
> Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrite.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

