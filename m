Return-Path: <cgroups+bounces-16802-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EOlXCslMKWorUQMAu9opvQ
	(envelope-from <cgroups+bounces-16802-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 13:38:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B97668DD1
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 13:38:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=TkVnRhQO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16802-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16802-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 347B3310DF53
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133A3FBB6B;
	Wed, 10 Jun 2026 11:34:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF813E5ED6
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 11:34:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091256; cv=none; b=ujCOJ9BdELOO9IYJQeZR807ary2RVSfaYCeNI+A6CmwpfaIyu+kaC3BYs/j5GY2SFTbJxHw2fQoR1vSqFgzZmOfmI6qgKknrP2VlfwXIZPx/GOrZ58qmBvNn0ZvTFZhyNjJyRla6dcanaclg0GSeK3zDK8fYFZTw8X33BtbzCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091256; c=relaxed/simple;
	bh=x+F2KXtZ3AnoeA2HgEo4T3r8Mhf5qGBjX2zVqGVu+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxNm6CKw+oG5tRzXrElKGWQMGTfyljEoa5M9w+GxsxKK6m8nc6wKADarN1+WDRcGeW2aw38g0VaYv5vLTsz7Mqkfu4wnWiCgUap2sAoVs5CZ0J6TlbJo2CqzTBpvIzADnh3yMdKMI9WHRF1//zlAhMOoJXK/O3KvLF6kyrNxcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TkVnRhQO; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso71642256d6.0
        for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781091254; x=1781696054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojEE6G7x5Hyz18bffBqmv/qKtAjxoG29cTYIDqTjZjM=;
        b=TkVnRhQOheaFAt1gnoN6Hm6e7ZI73qtlI/OTAapfcVVpOcZTGyBfKZpk9Tu0CN3Pf5
         N2XdfGhogTuXo0rOwhstopK4jZaUj7DZCoz+F5nibrgF/rn5wdZImS2JSuaZLj+f5zMH
         eqGiVRwTRy8x6GxMuWk4IQDWV23DjhrEWnlIzU0xO0qwhLkOd9U+ujuys1Dfj/i6dWoH
         eOyjRmKHGd7swRgX8SAqc1kOhmR10rnrw670mDgJLq5t2mwxsZLB6AE3v6bJCG/53Rla
         SswirCsJYZyK5SGIeTLdHO6en1qqrZKgGc8L4wp20EZmdI3uXoKfIB8/NzpDNCQbUyQd
         1nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091254; x=1781696054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojEE6G7x5Hyz18bffBqmv/qKtAjxoG29cTYIDqTjZjM=;
        b=eJe07cOtTf20QwkmoWFsJhvkdU4+X06CXQmQLLqTeOK94tuTTxLyZVMwLP2zYYVL0e
         y9w8mALlB/5UeGOk+c3HTZ/e+kKmQFJ2+xrkazFXEWZ/qvJcXyztkla/6/BRRrgDLeRP
         3Uw61KeMHB3YN4Y0NbbkLySuBr2Urfs6VzyiwL7ZMlax284wuBJRBin/SbyNbdQZ5B65
         J0LtELO1Aur+jFH2DpM5R4LYAt86E7Hl0mZwaSNgNeHHTdH/Ty/d/smPcIrSiKAclXvp
         V/urlAZcbMk7HJUudjq7dzRSVM3U+2Z13v+Of8Zg6mXw6sF/HDN02c/dL/4F0HD0X9bF
         g5HQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BR3hz1mLq+9Lsa2AysUIPh/bUo9FwyUJfKlHLr4/11AmNHmzDG7ZxWvpbojsUr9JaCcLMV/5d@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZxM6bBrFtzVwP9fmvT81z3HlJhdf7YXeqEnWR60Qb/wSrV51
	jO/zwiUPXOsoC0TNOeGRRTm0M4VMk2mRK7ztlH9kB+VsKhmKAQ43zMHyf3RM2iGQ5jO+Oig81Pa
	GWgwL
X-Gm-Gg: Acq92OHr0nKMhpAzeev2KsNindBD/UqSqO5TQd45kJpgodfYb3IWJIQaJ/IE/zvvat4
	TVQgjEErg3VWTrf+gnM+5k5Drc3/7tRGDMMxgHzYhyjHxhYv4hPeF7iuPMiSXSW5HWHhYIhk5uN
	SoBY0AiNLVx4XP7Yzt7Y2Ap2S8zfciqpaZF8JTAkCJ7dTAtqU3udK1nRjnDFiapcv6QuuzVnrsC
	ihn8BGsp70/ENeb6OAVBh3ajuVZeXWuVRl8OOMT+Y2S0NlmncOJreCbPbDskD2/6gjKs9uM6hBj
	pSWxY+lWEfOE+Fre1fCAtFESUe0auHvaHli3hN9hrCxSdtqBNoabSc0+AJ877tWOJNnJbxgJwjp
	/Im6A9d0qQcQqgcsDGN3MlmgE3EsORr+sqaid5qYKBTaP0IopeZqx6jXw47eIVPwmNLNKYSDiX1
	kw8rDu4zQv9RLjYe7sPXRfNWlHoe/v2TeKo0UOynXFjOBeoJquJLfYP8ndhLiE95i/7PyAOPJtO
	NeqwiGrMElYLJHhOWNwiGtpnl9l
X-Received: by 2002:a0c:fde3:0:b0:8ce:ca78:409c with SMTP id 6a1803df08f44-8cee5fe4e78mr277619976d6.10.1781091253735;
        Wed, 10 Jun 2026 04:34:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26e9e3sm225660056d6.46.2026.06.10.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:34:13 -0700 (PDT)
Date: Wed, 10 Jun 2026 07:34:11 -0400
From: Gregory Price <gourry@gourry.net>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Farhad Alemi <falemi@asu.edu>,
	Yury Norov <ynorov@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-ID: <ailLs4akasGP1KLZ@gourry-fedora-PF4VCD3F>
References: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
 <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16802-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:david@kernel.org,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:longman@redhat.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,redhat.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,berkeley.edu:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95B97668DD1

On Tue, Jun 09, 2026 at 07:57:41PM -0400, Farhad Alemi wrote:
> cpuset_update_tasks_nodemask() rebinds a task's own mempolicy to the
> cpuset's effective, online mems (newmems, from guarantee_online_mems()),
> but rebinds that task's VMA mempolicies to the *configured* mask instead:
> 
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
>

I think you can make this a bit more concise:

  Creating a child cpuset where cpuset.mems is never set leads to
  a div/0 when a VMA mempolicy with MPOL_F_RELATIVE_NODES rebinds
  in response to a CPU hotplug event.

  Reproduction steps:
     1) Create a cgroup w/ cpuset controls (do not set cpuset.mems)
     2) Move the task into the child cpuset
     3) Create a VMA mempolicy for that task with MPOL_F_RELATIVE_NODES
     4) unplug and hotplug a cpu
          echo 0 > /sys/devices/system/cpu/cpu1/oneline
          echo 1 > /sys/devices/system/cpu/cpu1/oneline
     5) mempolicy rebind does a div/0 in mpol_relative_nodemask on the
        call to __nodes_fold()

  The cpuset code passes (cs->mems_allowed) which is not guaranteed to
  have nodes to the rebind routine.  Use mems_effective - the value
  returned by guarantee_online_mems() - instead, which is guaranteed to
  have a non-empty nodemask..

Maybe add a link to your reproducer and the original [BUG]

Link: https://lore.kernel.org/linux-mm/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
Link: https://lore.kernel.org/all/CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com/

Does this need a Closes tag?

> Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Cc: stable@vger.kernel.org
> ---
>  kernel/cgroup/cpuset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
> 
>  		migrate = is_memory_migrate(cs);
> 
> -		mpol_rebind_mm(mm, &cs->mems_allowed);
> +		mpol_rebind_mm(mm, &newmems);
>  		if (migrate)
>  			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>  		else
> -- 
> 2.43.0

