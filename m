Return-Path: <cgroups+bounces-17124-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id STc7EJjGOGqxhwcAu9opvQ
	(envelope-from <cgroups+bounces-17124-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 07:22:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453F6ACBAC
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 07:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=VPoPKF9k;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17124-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17124-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1FED3026F2E
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 05:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2235836B;
	Mon, 22 Jun 2026 05:22:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE972AD00;
	Mon, 22 Jun 2026 05:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105734; cv=none; b=GC5Rvv04JijapjK3y0sFbn185sJKyKuFDlpxwhGOxwDoEUShVV9EvcqG6jg1wQE0s8niu+S2EQHfe77yIhkiYezb5VVM0TWMdbRafFnefQomx4fEET0X3s82bvTtJID45/d2Bbo2+DCCXsvbOZ/PgINaE+0k6Zr2Wv8fqwylLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105734; c=relaxed/simple;
	bh=TLqjtoxyQNBS4x+LOScCt7CwmrTyt3kjY6p33duqeE4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ev/zTAYT7vazGoPoDRAYDe8Faj81Pf7zpbO73ibC6hSmt1pENNFvRiz8Xr1qWVczOdInpNCIw0Zg0Jxi/9NRnuf6AOv6bheQEBEozzhykDAIccQkihO4A5KMvIMoCAwvsmZCQWVD69UH5tfx3yEeuqOp0+AZ8HmoSjAtrVKEbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPoPKF9k reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378331F00A3F;
	Mon, 22 Jun 2026 05:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782105733;
	bh=IjSWiRWMU9Ee27IawNNdMZlcd+pdKiRJTFL+L2RHmwk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VPoPKF9kD8SQIQF6VNPVqYW4nAuqARtP874wgBw9ktl1VwB0bHFPLCbcXYj7HUMxH
	 Mj3NKz7moMW1j+SXZ5JmJDnOZXBZW5IRtgrf/R6VIt2WEKZCRvzJOEpijHbPfQq0b0
	 nm0TeCZgQXRR4HX/TRhbDsnY+V7xNwuVA9DRk2Y55c/zCXC+PjQS50Jq+EMuggkTRd
	 9oW5HaoUighBQ6x6uk8YcD6TgdtMpwCo25V+L/RnXeQZlOC/g45FDA5+g0tzRvIsbT
	 YyCpmQk1Wl7rkCzOR5GCrA3tMSulv6dAwtezT3ajTjhRDdDcAq0rBDJrWSlu6Ht97u
	 uxcDgxs29F2vw==
Content-Type: multipart/mixed; boundary="===============3341382443539626176=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a431d311fb11ec06b89a5986cbacf2ebe983bdaddc4a93076564d83799471cad@mail.kernel.org>
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622042811.31684-1-kaitao.cheng@linux.dev>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,paul@paul-moore.com,eparis@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,tj@kernel.org,hannes@cmpxchg.org,mkoutny@suse.com,dev@lankhorst.se,mripard@kernel.org,natalie.vock@gmx.de,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mhiramat@kernel.org,oleg@redhat.com,oberpar@linux.ibm.com,akpm@linux-foundation.org,baoquan.he@linux.dev,rppt@kernel.org,pasha.tatashin@soleen.com,pratyush@kernel.org,naveen@kernel.org,jpoimboe@kernel.org,jikos@kernel.org,mbenes@suse.cz,pmladek@suse.com,will@kernel.org,boqun@kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,da.gomez@kernel.org,samitolvanen@google.com,steffen.klassert@secunet.com,daniel.m.jordan@oracle.com,rafael@kernel.org,dave@stgolabs.net,paulmck@kernel.org,josh@joshtriplett.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,urezki@gmail.com
 ,juri.lelli@redhat.com,vincent.guittot@linaro.org,kees@kernel.org,bsingharora@gmail.com,anna-maria@linutronix.de,tglx@kernel.org,jstultz@google.com,kpsingh@kernel.org,mattbobrowski@google.com,nathan@kernel.org,martin.lau@linux.dev,song@kernel.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,dietmar.eggemann@arm.com,void@manifault.com,rostedt@goodmis.org
Cc: audit@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,cgroups@vger.kernel.org,dri-devel@lists.freedesktop.org,linux-perf-users@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kexec@lists.infradead.org,live-patching@vger.kernel.org,linux-modules@vger.kernel.org,linux-crypto@vger.kernel.org,linux-pm@vger.kernel.org,rcu@vger.kernel.org,sched-ext@lists.linux.dev,llvm@lists.linux.dev,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 05:22:12 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-17124-lists,cgroups=lfdr.de,bpf-ci];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kaitao.cheng@linux.dev,m:paul@paul-moore.com,m:eparis@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mhiramat@kernel.org,m:oleg@redhat.com,m:oberpar@linux.ibm.com,m:akpm@linux-foundation.org,m:baoquan.he@linux.dev,m:rppt@kernel.org,m:pasha.tatashin@soleen.com,m:pratyush@kernel.org,m:naveen@kernel.org,m:jpoimboe@kernel.org,m:jikos@kernel.org,m:mbenes@suse.cz,m:pmladek@suse.com,m:will@kernel.org,m:boqun@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:steffen.klassert@secunet.com,m:daniel.m.jordan@oracle.com,m:rafael@kernel.org,m:dave@stgolabs.net,m:paulmck@kerne
 l.org,m:josh@joshtriplett.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:urezki@gmail.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:kees@kernel.org,m:bsingharora@gmail.com,m:anna-maria@linutronix.de,m:tglx@kernel.org,m:jstultz@google.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:nathan@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:dietmar.eggemann@arm.com,m:void@manifault.com,m:rostedt@goodmis.org,m:audit@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-perf-users@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:live-patching@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-pm@vger.kernel.org,m:rcu@vger.kernel.org,m:sched-ext@lists.linux.dev,m:llvm@lists.linux.dev,m:chengkaitao@kylino
 s.cn,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,paul-moore.com,redhat.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,cmpxchg.org,suse.com,lankhorst.se,gmx.de,infradead.org,linux.ibm.com,linux-foundation.org,soleen.com,suse.cz,google.com,secunet.com,oracle.com,stgolabs.net,joshtriplett.org,nvidia.com,linaro.org,linutronix.de,arm.com,efficios.com,manifault.com,goodmis.org];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[93];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9453F6ACBAC

--===============3341382443539626176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index c4dfbc293bae..9e076106bee7 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c

[ ... ]

> @@ -100,7 +100,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
>  		return -EINVAL;
>
>  	mutex_lock(&event_mutex);
> -	for_each_dyn_event_safe(pos, n) {
> +	for_each_dyn_event_safe(pos) {
>  		if (type && type != pos->ops)
>  			continue;
>  		if (!pos->ops->match(system, event,

Does this leave the variable n unused? Looking at the function
declaration around line 74, it still has:

	struct dyn_event *pos, *n;

but after this change n is no longer passed to for_each_dyn_event_safe().
The macro now hides the temporary cursor internally, so n appears to be
dead code. This would trigger -Wunused-variable warnings and break builds
with CONFIG_WERROR=y.

For comparison, the sibling change at line 219 (dyn_events_release_all)
correctly removed the *tmp variable from its declaration.

> diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
> index beee3f8d7544..a4dc0812284f 100644
> --- a/kernel/trace/trace_dynevent.h
> +++ b/kernel/trace/trace_dynevent.h
> @@ -115,10 +115,9 @@ int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
>  /*
>   * for_each_dyn_event	-	iterate over the dyn_event list safely
>   * @pos:	the struct dyn_event * to use as a loop cursor
> - * @n:		the struct dyn_event * to use as temporary storage
>   */
> -#define for_each_dyn_event_safe(pos, n)	\
> -	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
> +#define for_each_dyn_event_safe(pos)	\
> +	list_for_each_entry_mutable(pos, &dyn_event_list, list)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27930295027
--===============3341382443539626176==--

