Return-Path: <cgroups+bounces-16794-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SSOGHz23KGrlIQMAu9opvQ
	(envelope-from <cgroups+bounces-16794-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 03:00:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1A665181
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 03:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=acgc7xgk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16794-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16794-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3676306E2AD
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 00:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57023817E;
	Wed, 10 Jun 2026 00:53:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3881FA859;
	Wed, 10 Jun 2026 00:53:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052829; cv=none; b=gO4OgDhyoP2DuOOggJCIIn69HQ8vBBaKDL7NgKT42wMwpV+v1an3BntDRLWQsqQqXCzvOMUjlkFCpdFybZ1BSUpJhOPrnFR2X2llgvKQULV8VYDMZSec9s5kZNTHx4lEDq5SHke3ik//Hgjru0vdYmZQcutwr+b3KfCLKdXju9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052829; c=relaxed/simple;
	bh=KB1rQPbtWmaqaVgJwVHfcqLWERwD+WGRldQxAg4xbhE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p8tn9NG+nOVVz19+8yS1w19O2rJ3C+6aNqNykQXRaOmgk95mW5nYw0Vb8GNwaS040mipaVPQ14QxC2UvZ6I180XpxnBUxUa6/EV12AHO/thmKZ1U/Xv3lhIEBm1YZVLmYeA0E9UnNOA6RLbsgQQ4x+Y1Vfn5+K8CuFA+KBV+XN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=acgc7xgk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE071F00893;
	Wed, 10 Jun 2026 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781052828;
	bh=9sO0gIm4z95R8a+HuLm1r79PfCgTK1qEypIW9uF7ZLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=acgc7xgkEu753ugPGGUjJS42dHPmgrdSxWxEl3bEd/o06wO8hf6DWmidvkiwJLPFQ
	 hH3311AyJa+Z/NfGYRTP9TDVz6X/iSlQSoFPBQmczKZpHJ1s8+ftom0oW9mcuE7YyE
	 gC2Lk9CMpaW6K6cnd1jRSb7PF67cSUFrf66896tE=
Date: Tue, 9 Jun 2026 17:53:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>,
 Farhad Alemi <falemi@asu.edu>, Yury Norov <ynorov@nvidia.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Waiman Long <longman@redhat.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-Id: <20260609175347.9688ac8060bc072ebd58cbe1@linux-foundation.org>
In-Reply-To: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
References: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
	<CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:farhad.alemi@berkeley.edu,m:david@kernel.org,m:gourry@gourry.net,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:longman@redhat.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16794-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gourry.net,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,redhat.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime,berkeley.edu:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AD1A665181

On Tue, 9 Jun 2026 19:57:41 -0400 Farhad Alemi <farhad.alemi@berkeley.edu> wrote:

> cpuset_update_tasks_nodemask() rebinds a task's own mempolicy to the
> cpuset's effective, online mems (newmems, from guarantee_online_mems()),
> but rebinds that task's VMA mempolicies to the *configured* mask instead:

Hard to understand.  Was "rebinds" supposed to be "is supposed to
rebind"?

> 	cpuset_change_task_nodemask(task, &newmems);
> 	...
> 	mpol_rebind_mm(mm, &cs->mems_allowed);
> 
> On the default (v2) hierarchy a cpuset that has never had cpuset.mems
> written keeps mems_allowed empty while effective_mems is inherited
> non-empty from the parent, and tasks may be attached to it (the
> empty-mems attach check is v1-only).  A subsequent rebind -- e.g. from a
> CPU hotplug event walking the cpuset -- then calls mpol_rebind_mm() with
> an empty mask.  For a VMA policy created with MPOL_F_RELATIVE_NODES this
> reaches mpol_relative_nodemask() ->
> nodes_fold(..., nodes_weight(cs->mems_allowed) == 0) -> bitmap_fold(),
> whose set_bit(oldbit % sz, dst) divides by zero:
> 
>   Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:bitmap_fold+0x5e/0xb0
>    mpol_rebind_nodemask
>    mpol_rebind_mm
>    cpuset_update_tasks_nodemask
>    cpuset_handle_hotplug
>    sched_cpu_deactivate
>    cpuhp_thread_fun
> 
> cs->mems_allowed is the only nodemask in this function that is not the
> effective set: the task-policy rebind, the page-migration target and
> cs->old_mems_allowed all use newmems.  The sibling cpuset_attach() path
> already rebinds VMA policies against the effective mems
> (cpuset_attach_nodemask_to = cs->effective_mems) and explicitly notes
> that mems_allowed can be empty under hotplug.  Rebind the VMA policies to
> newmems too: it is guaranteed non-empty by guarantee_online_mems(), which
> fixes the divide-by-zero, and it makes the VMA policies consistent with
> the task policy and with the nodes the task is actually allowed to use.

How is this bug triggered?



