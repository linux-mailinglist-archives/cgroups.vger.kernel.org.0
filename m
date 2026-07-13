Return-Path: <cgroups+bounces-17700-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rYrxOeC5VGqKqAMAu9opvQ
	(envelope-from <cgroups+bounces-17700-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:11:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C53749A57
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:11:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=cZLy3GGr;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17700-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17700-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC40302C1AA
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7CD3E2AA1;
	Mon, 13 Jul 2026 10:11:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154E3655C9
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:11:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937502; cv=none; b=stAEiY/NQQoZFbdCzTvinjQSayDSkaIyX17phMAacmjAe21eljlOnPkVkEPY/g+3laqVlMWsUmxpQxvQ6tSkgxMzivSvvGhiMuDguqVptCRwucdstBkqOXUsf9nSKvM9omYT3hHvi7IEblSCHNE2TOHuXP56LHFEc2LDLU3pfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937502; c=relaxed/simple;
	bh=NXID7B6Axf96SFrkITnk60Dk3zu2sSrdxdXBC+apFgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw0RSZlxJIDs8kV95JYTcHgW/ZITQ6sMdWgUpB80HnA0BklTsUNM7mNDCaGh5XoaHkyGsWdYMRMRlfx932Z++lxHz1wXiBl7SE2FNb0F+ISJoSRwcEFxnk8pUlTZ9BhAxFJcK8SDYSYR1YNA9FZuwU4QDg9Np1c8cGWCpYbcdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cZLy3GGr; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b1710405so15057035e9.2
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783937499; x=1784542299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B7iIgOh4QNobVdUpoap6YvKLETqNCDd+ytv+al45uGc=;
        b=cZLy3GGrZOPH3dxKXmKN+PSV5//KzDaZPoTsOZTjr3c7mqe026QNPGjVjyQccjU7pI
         zCQ03cfcoviTv0Uy8tMr6JimIMtVlynAV1LNmLLZtfOvv7a6aFoGSBtRIXWHT7ibtQkL
         skg9GnmZD8hA7fSoRAyDZRyotBTJPnJdB4yfBLJ/vLWufCed3CIDUzDPn9Fh/zDE2Xt2
         +LAsKhrqZu6B7XOt74PLE5H+PTrUtvrdD0GTW9U60gljnoknTXhXLhgLsVGe/b2SlDw8
         8Rw6PtCGvEJbrAqeJWEJ+x2Ap7X9lKp9d9HcREUwC4WdhCYpZgIlk6csgcOUd02RcvEG
         5D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937499; x=1784542299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7iIgOh4QNobVdUpoap6YvKLETqNCDd+ytv+al45uGc=;
        b=hoZ5/4emNCSPdqQEVsdx8V03TBbA7qnj1TW9uGgQ6PGwYPK+ROcJYIFiDVKOc7hoq8
         KSnatl9+lH0SuCM5ewjuvUVdzdeqgAiaKbnEyiV+QSy74w4HA+Fjoh640EOxcVHwN7gQ
         icFFvS3n4jEKlBun1LjzFsf+c4hA9UlU5wLPg41MjRz77ktmzQekYmVZXWVbspIkNeTi
         dQjpji4/Wm8zoXwudLxKv951WbHd4hNLKen4CRMtscdRO/sz5Vbf5Csa9gcRx/oh7GZY
         ZMNbLEq5oCsVCzgPycQ1bhlCRB2p+EFHPZPpJcfm+Hn6A4268kB+bVjTYvkXZV0wJUpb
         I5ig==
X-Forwarded-Encrypted: i=1; AHgh+Rq0/BgvxbwuQJfFO2MRTCRgPc7Isv7WfJ9sywL7vvk453uNy9OuZxvhn75qCDEAvREOr1mP1bE9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZwezaBYyv8hZ+JGEKqrCkGgaGuif+m37uTJR8VappekJt61l
	5cUwx/D6E2bo4SJWyXQbSr52vFKjSaDNSWa4DVGcIk4mV3nQLPY5kPbdUGLT9A2gGQ0=
X-Gm-Gg: AfdE7ckkrtM9Dr9TilitmQhHpHmqT+AAg+R2oTHzhv7LkZb8udWA5gkMdrN2oO0mNcS
	Ri5jcDSwc9lGnMnG1fIfZ0BqJtUVdj1cRKJ41Jmr/oCKeepLxWtqY+V16oQqPhkcOuKC+S6ApxJ
	x69aTBduxg8ULH19l/BgUMo3Uoxp2nwjKo/mMklIj/5TCRPZqliSziIn9rrVXqOnueg/FWpvAQ/
	+XamSbNhy5xnzYaOMDd+No714lHQVIJyQqDO5fM/tXXoBINgsubzPJE9ixTKiAGPjxfHaSd8+IP
	mcppDiuqv4WMgQ2iI3m9T2q1ctuWHIqotS18NOhL6BsyYxirWGWsJ6zjQ/oTzbXliqGQTVAdF+6
	9/ePPlfTK4OlsDFEr/dkfeag6gr5svF8ClBQcdEzI0xAZvKNxdLtqqipao1IIGn+mIhnETX8Y0Y
	pdRCsDRjCFqqHDjeRUrafm+HI=
X-Received: by 2002:a05:600c:4ed4:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-493f8780525mr96750285e9.0.1783937499056;
        Mon, 13 Jul 2026 03:11:39 -0700 (PDT)
Received: from localhost (109-81-90-85.rct.o2.cz. [109.81.90.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm79380244f8f.31.2026.07.13.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:11:38 -0700 (PDT)
Date: Mon, 13 Jul 2026 12:11:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcg-v1: make mem_cgroup_oom_notify_cb() return void
Message-ID: <alS52SCoict_OkLp@tiehlicka>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17700-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tiehlicka:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36C53749A57

On Mon 13-07-26 17:37:37, Guopeng Zhang wrote:
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

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol-v1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index e8b6e1560278..73bea1b5c8dd 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -752,7 +752,7 @@ static int compare_thresholds(const void *a, const void *b)
>  	return 0;
>  }
>  
> -static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
> +static void mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
>  {
>  	struct mem_cgroup_eventfd_list *ev;
>  
> @@ -762,7 +762,6 @@ static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
>  		eventfd_signal(ev->eventfd);
>  
>  	spin_unlock(&memcg_oom_lock);
> -	return 0;
>  }
>  
>  static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs

