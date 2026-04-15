Return-Path: <cgroups+bounces-15310-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHxtMvhs32kzSwAAu9opvQ
	(envelope-from <cgroups+bounces-15310-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:48:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA940367A
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4A9304F208
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DB33F378;
	Wed, 15 Apr 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5YaRU94"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7C2E22B5;
	Wed, 15 Apr 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250044; cv=none; b=uUyAi+0Eabkh94TOwwAD1iTZuImSfJuLnuUCbT4FN2mPi86lbJi786+ZtVUTK1Ls7+pyJf+OKlcf1nQBnko1p0ppeMZksvD8yd3ahUsJLQ0w67Av/GIGfBlZs59okAcMXfmbGFQ87oX7y70aYU6yFwMCZK5IbEr/9W0IvM8G5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250044; c=relaxed/simple;
	bh=NPkH3odK+y9+Iw7bAZA8ca0+l9lmm7YtInB3PhCdnWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG0Kbgi+Pj4T6SwFuYOTHwlLdhWTMH2u+GCyXW8Y+db61aIPuUWHcO+cn943h+n6VBfSOlJN7lIRMXw9iTXV5fcETmnXpk95nCSXZW/yIkfD3Bz5kAG4EFkjCj7MyecOn1gOA1Ncmyt/D1HH+Dopmsmx2WSaHOffqP7WvFNEsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5YaRU94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65598C19424;
	Wed, 15 Apr 2026 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776250043;
	bh=NPkH3odK+y9+Iw7bAZA8ca0+l9lmm7YtInB3PhCdnWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5YaRU942uo88Bz6wJUMEWxPz7pezQji73dhxljy8WgWWZ4oFdKiaj8kuMNQbpe3g
	 ejnm2n6TJZKu8Fd24uQcxpxMMqjKvNdrdpr4FHtvEB//unXAmXS78psdWFCgHAur1x
	 OlSYp1JF8WOOKOzMujadJS5MzqtSAzCtYc1SrfM/mOMdLeZKjOha+BWUJq/nwn0ozM
	 +UXqlvJ86RrNkIoid3QazzX3gIiOsPBYSGxbFbfNNW6/iOkHBa0tVVcc0SWWG6iHuf
	 9yoEIMUTqisydm7Ql118U3OEEwU2vjENDOZNeM1go+4dNgInjFn2laS5salb/EiDaN
	 qOJiF4UAEw3Tg==
Date: Wed, 15 Apr 2026 12:47:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/12] sched/core: Dynamically update scheduler domain
 housekeeping mask
Message-ID: <ad9sudAozBTBfI5U@localhost.localdomain>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-7-06df21caba5d@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413-wujing-dhm-v2-7-06df21caba5d@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15310-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77AA940367A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Mon, Apr 13, 2026 at 03:43:13PM +0800, Qiliang Yuan a écrit :
> Scheduler domains rely on HK_TYPE_DOMAIN to identify which CPUs are
> isolated from general load balancing. Currently, these boundaries are
> static and determined only during boot-time domain initialization.
> 
> Trigger a scheduler domain rebuild when the HK_TYPE_DOMAIN mask changes.
> 
> This ensures that scheduler isolation boundaries can be reconfigured
> at runtime via the DHEI sysfs or cpuset interface.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
>  kernel/sched/core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 496dff740dcaf..b71c433bbc420 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -39,6 +39,7 @@
>  #include <linux/sched/nohz.h>
>  #include <linux/sched/rseq_api.h>
>  #include <linux/sched/rt.h>
> +#include <linux/sched/topology.h>
>  
>  #include <linux/blkdev.h>
>  #include <linux/context_tracking.h>
> @@ -10959,3 +10960,25 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> +
> +static int sched_housekeeping_update(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct housekeeping_update *update = data;
> +
> +	if (action == HK_UPDATE_MASK && update->type == HK_TYPE_DOMAIN)
> +		rebuild_sched_domains();
> +
> +	return NOTIFY_OK;
> +}

This is already handled by cpuset isolated partitions.

Thanks.

> +
> +static struct notifier_block sched_housekeeping_nb = {
> +	.notifier_call = sched_housekeeping_update,
> +};
> +
> +static int __init sched_housekeeping_init(void)
> +{
> +	housekeeping_register_notifier(&sched_housekeeping_nb);
> +	return 0;
> +}
> +late_initcall(sched_housekeeping_init);
> 
> -- 
> 2.43.0
> 

-- 
Frederic Weisbecker
SUSE Labs

