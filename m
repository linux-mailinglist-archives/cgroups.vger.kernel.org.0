Return-Path: <cgroups+bounces-17722-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7dHcEzLtVGpuhQAAu9opvQ
	(envelope-from <cgroups+bounces-17722-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:50:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AE74BE22
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:50:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=readmodwrite-com.20251104.gappssmtp.com header.s=20251104 header.b="VE3W/5CL";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17722-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17722-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5DFE3028622
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D1431E7C;
	Mon, 13 Jul 2026 13:50:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF2433E77
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 13:49:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950601; cv=none; b=KDMrUSlccUEmj3HYtg6wVcYvCjxBwcUlpaijIOJKru/FM9MlSuVWv6WDHKG7WQsCJID/3KyXNriXlSKszdJF+NAL4mx/VgMnv1WpUWkD9BbIe5pJXX+wuQ6pwwcwotHZcaiYRb2bVIHkj1JS4gIZ6MXHCLFv9YrEqxOxiCoPSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950601; c=relaxed/simple;
	bh=+lMCCcsL9KhGqzAnvde2v5Etjt6yi8xbmgjj8iFutzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjy34xcOTpWR7rJa8BqIwoh/SjwC2veKm0vJVJeuH7mVYb83+ePSOA0+7DHxAvezi++tuS24MYwzhBKwS6as6nlpvrfqKMoQ6w6+DwUfsENr4ZDBOzI9z8VqvdS/yFAzcpMoolRFyChWMyInZR6+Wzq7k+0idqf69mjLde2P+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=VE3W/5CL; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15b33f7b23so449963366b.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783950597; x=1784555397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHaZPwi3IrnhWNTxPLfcIu6e1zyZHnrUTB5eDWHk9VE=;
        b=VE3W/5CLfwjnt5rRAWRRQBWyjvHP58SuUMw7ueNsskTOU0DyKAq/wIVdkopYq21JQu
         k4v/2XpwCwHWfAHk6NQZQQNqFXTXEqFIxBkMLjy5/CwcPHSBgK2xc2rEbWOVmja2etow
         QDFS1HIa9W7yHBrFAPCC+rznXdYolMGUlTXW4LVRd/VxdOVL8I3to6WHP3mYYN4dFfVh
         uVqGEFkI87ACwMd5yCef/2yozObT62LHYzAdwvkc+uzRn0+TmaTjf6LhNKXhcnyhFLMy
         t+fX3tnzH33Mkp0ORNLg6HZSQE6oUA4cSZiMKuEcz20Crv6xfnp49cOpuATaWI/4gZYY
         b4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950597; x=1784555397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHaZPwi3IrnhWNTxPLfcIu6e1zyZHnrUTB5eDWHk9VE=;
        b=B/HP6MaK/yeVEm6tDANLoib5TP+w8HPlQg0fD19NBA1ZAJJQ9pQAUhG6gplqSaEE5I
         /kLW/F9pEM/vqtkzEQYQGirEJgkh/aczJ6oHd73bGg0Awhdlf0ikOFIQ+S/pSVlTN4MI
         FNBQ8Csa5HRuz6c00HPrfwy75okXICmrJmDKDelpzdMn74QJQADL6tn3vMnanVXNIiXG
         fm60AYilG98xtdG6Be/B//eZdSqVQfqMQYLbg/3ddfy5qIqaM8WnRjWexchdZJSXStne
         Yf+Mgm6UOmjTEki2ZxXXn1mjeGHH1bf08TpxILwPP1zKvsA/HM8VKa6xt/jjZgNyufqv
         lWEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbjABK0kX62VlsodHI7KUa7eLE0vG3j45IeRpwj0I6ETzjVAGVVWnpR//kZzqPilCAWpSoOWpj@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6Bd7kpn1UPFiT8u2L23YDj2pxgdFJKsTgju4M8ru3U4L8Bf4
	lgKLcvz15iBWO2rWr2AIAyQ82FnJQnZVzQvBEb/9680aTgiIG6yejSJ5rj3FyNQAf7k=
X-Gm-Gg: AfdE7clflBkY/4IvNPMoAVAeoOQVUw0kyKEiNwlmqB8ddgtocXH5JBM4ErMzV8jPL01
	WNmM7Z6Sj4yVakrC5WDFyt4wzoepz4SVHP96vibzYuC+qkikhWyWaXQGcZm9Wn/YLMIOwvLfzW8
	rSC8R8vQRnoeaO9UTKZT4QJYFOENYQ2lHMaK8rJQDMHwTtw9JkqowUddphxIkvo95V88gnZ5u3J
	Eo1hKH6no4W5VZ7uoSAxYo/IPnBfd65NQZvWW8WLdm+/gnxuEke5Tg/eAznMpFXYSFOg7LjQKdw
	6/peR3woXDO95hvZvYAZ/SRdR/DQCl2aXXepE+Mm+m7XwsKd+0K7j+W3KYZ4ChGulfvc6WnA7LE
	XgpgYgkc7Ttr9BvM2RDlKuJmPMgqo74+8g2MLldVZ109VTAN2NIKLCwJgvB3b96ZPtZBnHSz2JN
	oO
X-Received: by 2002:a17:907:95a8:b0:c16:581a:2a51 with SMTP id a640c23a62f3a-c16581a50bemr62872666b.12.1783950597109;
        Mon, 13 Jul 2026 06:49:57 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ca1bd81asm819021466b.30.2026.07.13.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:49:56 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:49:55 +0100
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
Subject: Re: [PATCHSET v2] sched/psi: Fix psimon fork deadlock and
 rtpoll_timer UAF
Message-ID: <alTs1drVX4kb124h@matt-Precision-5490>
References: <20260712174619.3553231-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-1-tj@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[readmodwrite.com];
	FORGED_SENDER(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17722-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,readmodwrite.com:from_mime,readmodwrite-com.20251104.gappssmtp.com:dkim,matt-Precision-5490:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD8AE74BE22

On Sun, Jul 12, 2026 at 07:46:17AM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: - Retagged sched/psi (was cgroup) (patch 1).
>     - Added a fix for a pre-existing rtpoll_timer use-after-free that the
>       Sashiko AI review flagged on the previous posting (patch 2).
> 
> v1: https://lore.kernel.org/r/20260710134945-psimon-fix-tj@kernel.org
> 
> a5b98009f16d ("sched/psi: fix race between file release and pressure
> write") made pressure_write() fork the psimon kthread while holding
> cgroup_mutex, which deadlocks against the sched_ext enable path blocking
> forks before grabbing cgroup_mutex. Patch 1 moves the fork outside
> cgroup_mutex. Patch 2 fixes the use-after-free from a schedule attempt
> re-arming group->rtpoll_timer behind psi_trigger_destroy() by shutting
> down the timer when the group is freed.
> 
> Matt, patch 1 is unchanged from the previous posting except for the
> subject prefix, so test results against that posting still apply.

I ended up testing both patches. This resolves the issue for me!

Thanks,
Matt

