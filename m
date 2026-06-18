Return-Path: <cgroups+bounces-17082-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iZ2XMD5bNGpBVwYAu9opvQ
	(envelope-from <cgroups+bounces-17082-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 22:55:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9C6A2AFB
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 22:55:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="RJ1n/ELn";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17082-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17082-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 969463025D00
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5233F597;
	Thu, 18 Jun 2026 20:55:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36C258EF9;
	Thu, 18 Jun 2026 20:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816120; cv=none; b=HdhrsnblVEV+BC6GNBe0OTjUJ4f//I2Ai0YG9yiei2I+8hYQwkA7i7dCG1g3r0TZLvfA3sf+Yemj1d3CqDNNY56buy8AjTWXrINEYX0QQvDRJAwtPl0szYyehDGa2uAXESebrYn77BvTyJ0wkBJW4JDRP5gSJuA078dIx8J8Pf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816120; c=relaxed/simple;
	bh=EFzOHf5GVZI7GX1gDGt7o9SqZnZV3AKOqT6Es/+ZJqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdLcpUyf7W+528zRsJTOKUfHWRl5fVUWpEglhiTqSVE1xKfApWeUCaPe9y50GYsoojRH0juasCL7py7EngeFXq4qgI34p0qxyx53e/+OVcXtlnTGXXzx3ImWKxGzH1Cx8JT0JC/t44C+QAp8kfxdFr6f9R9nuzvMfB4ApbTz67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ1n/ELn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49EE1F000E9;
	Thu, 18 Jun 2026 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781816119;
	bh=g3gG1NcphiUfU6jYPSArRgaQ3Q88ZPYaxNEFliPiUXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RJ1n/ELn5TyNV6qBTKBadpMEIpJ8AbEgZHkyanKb/x3jUMLwJEXg+d86TuIabGc9d
	 N+QSl+6OlQ2amqFyisNmFqSgUOeewuExxvAKBq1/33uFL73YqQu1m1Y+k+35teB2IJ
	 GyFt/xzsHrKc80RUPA6D9MJ2JAVn6enqTyvRsNKnm8H5d8cDN+en9V5cuxB8P1WGLq
	 14++h0grtU9DxGxgOZzisyf4/EXUrUYsToOS9+CyvxJo1Uys3xOEK8psS17okyYvPS
	 FplMvU2ilpd5k1gTalPob+5tcf4tSauWlTtk3LLp0tdFPQLlb+WR/Hd2ts9eWjTJQh
	 2SvQHqnV2Vnew==
From: Thomas Gleixner <tglx@kernel.org>
To: Jing Wu <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, Qiliang
 Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v3 11/13] cgroup/cpuset: Extend isolated partition to
 trigger kernel-noise isolation
In-Reply-To: <20260618-wujing-dhm-v3-11-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
 <20260618-wujing-dhm-v3-11-28f1a4d83b68@gmail.com>
Date: Thu, 18 Jun 2026 22:55:16 +0200
Message-ID: <877bnvefgr.ffs@fw13>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-17082-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,vger.kernel.org:server fail,fw13:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FB9C6A2AFB

On Thu, Jun 18 2026 at 11:11, Jing Wu wrote:
>  
>  	if (update_housekeeping) {
> +		static const unsigned long noise_types =
> +			BIT(HK_TYPE_KERNEL_NOISE) | BIT(HK_TYPE_MANAGED_IRQ);
> +
>  		update_housekeeping = false;
>  		cpumask_copy(isolated_hk_cpus, isolated_cpus);
>  
> -		/*
> -		 * housekeeping_update() is now called without holding
> -		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
> -		 * is still being held for mutual exclusion.
> -		 */

Why are you randomly removing useful comments?

