Return-Path: <cgroups+bounces-17713-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wRRnIR7QVGqufAAAu9opvQ
	(envelope-from <cgroups+bounces-17713-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:46:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C819C74A7DD
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:46:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=Jj+OBDEf;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17713-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17713-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3703A3034DF0
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A43EAC76;
	Mon, 13 Jul 2026 11:43:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973938D40D
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 11:43:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942997; cv=none; b=ZiKloGVuhXOCjsmcSE2Z4R3ovqnSu1hhG/F90uyByNrxDsxucj8RERrqbKPQYTJy6JZj79a8GMK7bH2LvnsHxAz3SJiqk33FjMyy0Dslm9+NkKVMWmWAbnQNU5u6I+0SU41wEuD5IcfcckMq2HHLw/gL0BbVZB0nl3ux6jwVbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942997; c=relaxed/simple;
	bh=sWTQtwbNmhIp1zIM6xBig+wZw3y4IjqXhA4icc8iX9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piK8tJh52Dm0Cx4625lH5cPJa7QNf9QX3TIDjBuIwdS339fTKszkg/lbJxQwwreQ/qNtEijytjlaDT8pJfbJLrITJI8rHThP2Amf9Akle99GtkRKVH+i6mN/ElXRIdGGGnQP63x4XTvD8E4WbHU54cXS3/2MIOZuQa/J5kk7q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Jj+OBDEf; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ec555a26so19852465e9.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783942995; x=1784547795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SeyDTwT5eBKqoeDyITbPcULJkHcUnTXSu2CQ0OyNzGY=;
        b=Jj+OBDEfPrbeVFPMtvXK+d+F4368Z3JGZtNACzHXYIYNxa2fS/JojcWjzPtbOlxD3a
         5gDC1PCfCu5oyBizqgxD3RVhSUNGw3pe0zZp5ungATK1GSbiv5jJ9qAE2ka4SyiMUduV
         dN0FuJDUlw8s27m1AFQUnJmrGB6Z9+XipJDzhg/Xr+4834xksPMiXSroa5zGSm75vOU+
         HhPfd5utfRL4JN7neSBhxum4zyTaj4yCTs5/UBeeXxZzaC0wp5ECFoxEJntr/pUyoc1+
         a9sKyC3LtanDNxg7zZZDiLCNo/vTx/37WavEU99YlgOm4V21NwsHzwvfc9BMXqcv59hy
         dh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942995; x=1784547795;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeyDTwT5eBKqoeDyITbPcULJkHcUnTXSu2CQ0OyNzGY=;
        b=OJF18mKh4WnqkKUh7Y2E3gvTlUGGR+eOZdPvuPNGAXLLqlHsPorVTykNDkYZVmVLfM
         Qi+BP1ic2Q45+7SB54IEyOj7cI5FmbGqJdHrtaM3yIoJKqwzGKmYdNqDdd/0qUQakobg
         YpoIT2E6ZFRcArEIDT1+16T9NvU6yCCulYBWfdomspwvuxkPb/Yu7UbLrVXzbB2HQjtt
         L/O0hJxSoq3rChw2pQVwGOuoYOptPRekZp3/s0TFr/3Shiw2lU/t6RvRIQNsZIvKW6Cz
         o6FF1b9QuUHE5URd7iowEXvbntFtj7rl7RApueXytrqwkdmSw0cs+jig5+Q8PzDGfh/T
         owhw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2WOwsnQolahJxCGuT3Ptny435n8D4YnVO9Nrcg9+VTwrpX8boY0ZE1jYRNw/54NZrhYlFHzfX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yVvqGcYE6pGBek1MGnruDYArwEQIZvBf9ukq08yE3B4NSicA
	Gh+E6AES58fcFE60Ux80KmVsKxR1V0D8UEy9p7GoFlScnQ7ulDaLmLh+Why6depUQyI=
X-Gm-Gg: AfdE7cmAFFBpgk5/vp9X4hmKx3HCfp3Do5JwrQ6/YRX7oe3GeKjwkZGuN0HCbfPGllX
	zrNa6kFfLzWXyshNbGQLQv86fSmopscw3ZkMYWd9xadP5tzi7/Fg8oD/NxAUJUaJBKh81+k8FMj
	E58vumiN87hct+iQZet/5FzHjoVqUWzHVa/QcL35d3xdO0gljNgYdxfEo2PKkA041OU2gbofiHY
	KJuc5WgKL9jipOzL8wLeW1G+DY62R/hNTbqXRcpzDlYm2t7VRuXMKLCZZ76b0QaTsRv1XUQeVsV
	r/pog92AwL6SJH9inQun53s/7oi9ORzs1QmxFikPySCgD6Zj1nb+r0UbvQHhQGReN30KIQzwYWS
	ro5jHqM/vY1NymqrezxIP+opMVwTYCEp4ASvYsXVKcbQu6X8Yx5iRIRkUBGTXT1K6dd6xAjHnXE
	I3jrZVrKxUfu3XKMKx6HKs
X-Received: by 2002:a05:600c:5392:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-493f8826bbfmr88216405e9.28.1783942994704;
        Mon, 13 Jul 2026 04:43:14 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3dcdsm349445725e9.3.2026.07.13.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:43:13 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:43:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcg-v1: make mem_cgroup_oom_notify_cb() return void
Message-ID: <20260713114311.GL276793@cmpxchg.org>
References: <20260713093737.3299646-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713093737.3299646-1-guopeng.zhang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17713-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:from_mime,cmpxchg.org:mid,cmpxchg.org:email,cmpxchg.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C819C74A7DD

On Mon, Jul 13, 2026 at 05:37:37PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> Commit 7d74b06f240f ("memcg: use for_each_mem_cgroup") replaced the
> mem_cgroup_walk_tree() call in mem_cgroup_oom_notify() with
> for_each_mem_cgroup_tree(), but left mem_cgroup_oom_notify_cb() with the
> int return type required by the old callback interface.
> 
> The function now has a single direct caller and no failure path. Make it
> return void.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

