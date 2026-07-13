Return-Path: <cgroups+bounces-17720-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pbUXO+7sVGpihQAAu9opvQ
	(envelope-from <cgroups+bounces-17720-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:49:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037174BE00
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:49:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=readmodwrite-com.20251104.gappssmtp.com header.s=20251104 header.b=y0btpEGD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17720-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17720-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 737A3301F8F2
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83577431E58;
	Mon, 13 Jul 2026 13:48:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BB4307B9
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 13:48:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950520; cv=none; b=PzuHBIz5Z4CigY5ITo6ayddPowX2CrAIVezaMQVnckWQZMEk069bnPL50ol8FMbF4s7MhwaRE9DqKfQhdnGLsoCUYGbYNmf+sn+e0ScIQULVJ2p5t1C3uMv+DbXM7km7gh0LtLHpHEVNtHqbHcWrZTa3gB3YxhXwE25Aj47OQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950520; c=relaxed/simple;
	bh=TZ3tsMwiJUiaaTsevwJ4o+L1EGJMO6hFNrbfM3qjrPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAzdkzFPznCwrxJEZbgen7/uA+h3ogOXBfqIES/dowciTr8xRlYuW+7r+ANut/9TIN+WOVyAZ2Byy2FP7g1h7etnbSxbKKhvgMdwMfw2snO1zxZTPozyGwKuRFiKM5Nw2I6fkuuAd6161Qh77u8CUumh9F+7CdV0ZRE+pBIyN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=y0btpEGD; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso4183424a12.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783950517; x=1784555317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6DMbuqOtH23SHLzkFv4+Shmk8usPkwua39wHbFqGJE=;
        b=y0btpEGDbt5xb744hsgMZGhHKUpiHWw9b4KFynYz0jcJ8dVx1IEWrEklT21Lyj4fUM
         CFPIVyiqVQYrO8d3VlafwtzXvqmqR0gB7ONMopwOGiZip5fPUDvc+Zcyoqsb/R5E/Bsj
         /e9qmHwqStA7aVraFVkxyMCAoguT4tQFh/3ooGqz6CCi6dg/V5+Zkt04uvQjkCq9N0Ae
         lYMXa511DhWgy8HyBcCEGtnzM7DWxTJUnk+CwY8FdZgiNtdw/wav1RyQEt4bKqyt/Uv4
         UZScHf1jzjTrc+83MBzcWDrrxPsrQkJ4Nkag/cxQ4dOvwsRDZT/17zWG4AwFwCodauUG
         xoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950517; x=1784555317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6DMbuqOtH23SHLzkFv4+Shmk8usPkwua39wHbFqGJE=;
        b=Z5X4bzvItwqzl/Hz+/pPdoogpI91UDlreaOUS1LQtfdBJgKN+ptYDxdEK5Pbo3UyqT
         Z9bGXlHSaczk45CTe0C2+SBZeH3SZLO8QyDfYJqpmWKFzOBqNqcO0lTHkjkLkRidmGGi
         zYgLWOC59S8Cy0P1op5Dt1LjISWMFgtQECn3dgOk1oU2+6hq838GXc8FmfpgWqAjGq3n
         v+EuQtD61msO7/GzKsRV2LRpVRMyhBHQGNwZ8l/fQuFazyuBKZPOT4TjT68nhc33Sk7L
         /IV5iGHqWgp6uqlWVodBjNXp85uz+bolR5DnxhBuW82UTX9FIUYhvs5PZskXoGbUIlF2
         CNwg==
X-Forwarded-Encrypted: i=1; AHgh+RoEG0Fud+m6OfbsgGNZFBY9/hla1jJuFcOVW66S64zxh+GFh37O6ng17mqxuXmPwe68NEpYXnMt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7orqmVLqhBNJAJhdlulFb1flxvRbwIaJr+vXVCF1P5c0q4pL
	sJdo/u30dVXmd4lUGcxfIxEG1LopRnmiuJQCZ7+m2zPXPbfKieD+p812Faw8LsKYVQg=
X-Gm-Gg: AfdE7cmsIPCixTLxSZFgHiMKJADF+lCYip/anSv+Y+IcVNSvuf6RZGz95TCNJDuHsVA
	J+5/MPXVedm5812SphOTrN9fnyXfmzunJp5SQHb5LyVOvTVPMPf4kFXhbpXI6gIk2v8MA2PoA9H
	L3T7qRgdsICNZ+OxPxRsBzpIRu0DUsTUN8biTpKB/BBFX0FK8NgSf3onC8Kp/7BRWWmEqggAqbq
	1o/EkJHE75Bk4/temlchPcCcjNYiRCV4X5gCAFRIpCDxaRhr8EezHs9L7OdWuLEg6ZsIcz0XJF6
	7OxjzNFnHP8Zy70X2TU5CVYBy48jXy3kfi3uPWfLikdp5witYNnXWEV2zu8ZV2NzlTbCi7JEU7D
	HI50/xP+s4rLNA7uaPtFmeFaLrQUk/V3c9/RyRQy6y284zzhUhmZ6i1ENt79BdFAl8O5Ufc82dh
	Hm
X-Received: by 2002:a05:6402:3585:b0:698:62b7:a4cc with SMTP id 4fb4d7f45d1cf-69c5ef82f71mr4143024a12.5.1783950516676;
        Mon, 13 Jul 2026 06:48:36 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm9753669a12.0.2026.07.13.06.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:48:36 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:48:35 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, 
	sched-ext@lists.linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
Message-ID: <alTsERFTlUKCLw4C@matt-Precision-5490>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	FORGED_SENDER(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17720-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cloudflare.com:email,qq.com:email,huaweicloud.com:email,readmodwrite-com.20251104.gappssmtp.com:dkim,readmodwrite.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5037174BE00

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
> ---
>  include/linux/psi.h    |  4 ++-
>  kernel/cgroup/cgroup.c | 23 +++++++++++++-
>  kernel/sched/psi.c     | 69 ++++++++++++++++++++++++++++++++----------
>  3 files changed, 78 insertions(+), 18 deletions(-)

Tested-by: Matt Fleming <mfleming@cloudflare.com>

