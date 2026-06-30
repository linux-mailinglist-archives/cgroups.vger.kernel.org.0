Return-Path: <cgroups+bounces-17408-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mCIpM8UhRGqipAoAu9opvQ
	(envelope-from <cgroups+bounces-17408-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 22:06:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF476E7BA3
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 22:06:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=sA2f0Ptl;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17408-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17408-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE88D307C4FF
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB140B381;
	Tue, 30 Jun 2026 20:05:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B736F901
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 20:05:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849912; cv=none; b=Qz8W4GVY2y7fSy7oY5/8KHdSsHnMr4WwPdCoE//9zxgu5GNOJ05mKonujARyuMKrKRbpObb6ICeu8mHTq8YsaITEQ8kBjAfoLB7MPtIBRy1mXyhw0Te+8ttquLXv05GZoMpyjDbOmZobLCqRbfbIQxLRpzEKglzIemno2A6Wg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849912; c=relaxed/simple;
	bh=fXIeK3lDyrC3rYWBTJWVzXebmaEWCPSPJp1omazYlKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6un7C33KhQPpMFc8l2Pr5l9Ep87m3deOtx4NE9/e6gfmB7vSUPK9oKpf7vX/GF7xVQTzRkJN6z/sGtDeSvuTev9b3K5fRIZMwY4dPz1+i/tV40CIVqekD2ls/Kl3ijkzuiFErLOXcE+xJoDuuGTLaCF4ELWN3fupIpk5jJtqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=sA2f0Ptl; arc=none smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e65e18969so115959685a.1
        for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782849909; x=1783454709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBntxfJjDeY6lbfZFcve9iM3vJRAJtRX1PiDvu17VyE=;
        b=sA2f0Ptl0fbzt9gYOFsMsUKi9dA8QcB8P1ogbMdVhFKrjkiOxzjKrGXkQSUFpJ5QWZ
         w211rlndxtxbQrFyrnMK4scSEr1oYjKaS4yMNlm+zLQjXsjX2zaZ0cZGobInjhc/33nE
         Ntxa2HmPbq1jwl4M2XoNtoroT/Vlomk2tbLqMbumZMqCFxSsdvejntHhzPH6bLeQMzic
         rfZ8YoebO4FkeTvFXyQj6/UaUSdBCXulU2dTpbOXUO1ZgGR2hLHvNLMuN+fyR0rMWyLx
         Z0WBD5/JzZw2usWyPQzPjKX89NB1nmg3alVZdxiI8nGwa7d6/fDYG1RuSyYFMOmbmYav
         IDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849909; x=1783454709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBntxfJjDeY6lbfZFcve9iM3vJRAJtRX1PiDvu17VyE=;
        b=tSrGA1PM5vlZSjzHv3ENMUoHFfTR2xyfM1gPEfky1p7CHv0bRu0xUy6tGw0rNuXIwY
         bA7s9pH3h/QnxaLvPKzw0/mqNlgfVu2XY9CDJxUl5K6necRiSMMGHpWDCikyjt59WImI
         G9eRyVAjn7Mwd363huhyfkumt+96gQPEK9ZmOefDYd26wVy1b8dBgnHMJ5t7H8vApsWs
         A+b0w85qgOV/vEyJkFmnczXDUx4/Pm5Wr8lzREGfJDvOqCjXZdn97wCkgXGpMsabU6Y/
         9NSKw0GuD3RKSTOhpFoquhNI57ittabMcEun5QZ1sXuusNnoDx73LTLHJJ+l5uGYpxw5
         XS0A==
X-Forwarded-Encrypted: i=1; AFNElJ+mVqBgzK6nViZLzjLtJJJEV3oohN2yX2FAyWrxqZDs8sjDPwF8QKTy+n51KkNiTuWFrd2E2Z2+@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3LNz9RNmmn6+gNRRpO+rGOzpckvWYM/2sURgp/mFtO2gb1N9
	odVlUWQnABo9z+oVqVDFw4eNaOI4whyqzLU4Vf0MgW/Iz4ZEE3q4uyOTfazzhLNQQPY=
X-Gm-Gg: AfdE7ckKRrEo5qL5affVGR48pwdmlq+PXhe2cvKJtSTs6Kow6bN/txglSfVbEnOxwGB
	TeKcgISc7oKKaOCeXUNozX2sf6uFoTkIElZkM1zFq7AwOhfhzzFbrOf63LOd8p4A/UHbpDiGl9A
	nb6FaniIvlCmEKjjjdcLR5ay/LFA67PWKcMdB9uvMKMx9mYL/Imksd1gCxW6KPAvu34+jH9Pfr4
	VqzyJ5+4y46IhWOww8uG4EaScMEBr1A7ibq0vRNh/mf1qAa9GNpVdZCdZIGiZ35A5zuk9XYLfRb
	DVZbzFw8GYIq80++AFSDY0jpY0FVJg0pm2KBP23ULAep7JRnrhwtLCrnvGduxd81hcgnFK+EY2Y
	Mm1mjRwFqIk7zvtxGFsnHWFQcCqPdMmCpi+MKhmlucIFkdpUDIK/k1yF/RmDBZ27wyY5c/xvi+z
	3tiQeQDD1MEAY=
X-Received: by 2002:a05:620a:4587:b0:929:7356:2e51 with SMTP id af79cd13be357-92e696e6c05mr450617885a.11.1782849908902;
        Tue, 30 Jun 2026 13:05:08 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622eb9d2sm325891585a.29.2026.06.30.13.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:05:08 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:05:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, jiayuan.chen@shopee.com, yingfu.zhou@shopee.com,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/4] memcg: bail out reclaim when memcg is dying
Message-ID: <akQhcC60mufcxVHm@cmpxchg.org>
References: <20260630012909.144372-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630012909.144372-1-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17408-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:yingfu.zhou@shopee.com,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tj@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CF476E7BA3

The series looks good to me. But please add

	/* cgroup_rmdir() waits for us with cgroup_mutex held. */

to these bailouts. It's a bit unfortunate that we need to have these
inside memcg. But decoupling this on the cgroup core/kernfs side looks
like a bigger project, and we should get this bug fixed.

With that, please feel free to include in your patches:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

CCing Tejun as well, full quote follows.

On Tue, Jun 30, 2026 at 09:29:00AM +0800, Jiayuan Chen wrote:
> Hi,
> 
> This series mitigates a system-wide stall we hit when a cgroup is
> removed while one of its memory control files is doing synchronous
> reclaim.
> 
> Problem Description
> ===================
> 
> Writing to memory.high, memory.max or memory.reclaim runs reclaim
> synchronously in the writer's context, looping until the usage drops
> below the target (or, for memory.reclaim, until the requested amount has
> been reclaimed). On a large cgroup this can take a long time. The
> latency is especially bad when reclaim has to perform swap I/O, where it
> is bound by the swap device write bandwidth, and under thrashing it is
> effectively unbounded - each round reclaims a few pages that the
> workload immediately faults back in, so the loop keeps making "progress"
> and never converges.
> 
> The legacy (v1) reclaim loops in memory.limit_in_bytes,
> memory.memsw.limit_in_bytes and memory.force_empty share the same
> pattern.
> 
> These writes go through cgroup_file_write(), which does not take
> cgroup_mutex and does not pin the css. Instead, kernfs guarantees the
> node (and thus the css) stays alive for the duration of the operation by
> holding an active reference. So while the reclaim loop runs, the active
> reference on the file is held.
> 
> If another task removes the same cgroup in parallel, cgroup_rmdir()
> takes cgroup_mutex and then blocks in kernfs_drain() waiting for that
> active reference to drain. Because cgroup_mutex is held throughout the
> wait, every other task that needs it piles up behind the remover - in
> our case the whole machine ground to a halt, with hung_task reports for
> the remover and for unrelated tasks merely reading /proc/<pid>/cgroup:
> 
> INFO: task cgdelete:366634 blocked for more than 159 seconds.
>       Not tainted 6.6.102+ #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Call Trace:
>  <TASK>
>  __schedule+0x3da/0x1650
>  schedule+0x58/0x100
>  kernfs_drain+0xe6/0x150
>  __kernfs_remove.part.0+0xd0/0x200
>  kernfs_remove_by_name_ns+0x75/0xd0
>  cgroup_addrm_files+0x325/0x410
>  css_clear_dir+0x50/0xf0
>  cgroup_destroy_locked+0xdf/0x1e0
>  cgroup_rmdir+0x2d/0xd0
>  kernfs_iop_rmdir+0x53/0x90
>  vfs_rmdir+0x98/0x240
>  do_rmdir+0x172/0x1b0
>  __x64_sys_rmdir+0x42/0x70
>  x64_sys_call+0xeb0/0x2210
>  do_syscall_64+0x56/0x90
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> 
> INFO: task systemd-journal:2352 blocked for more than 182 seconds.
>       Not tainted 6.6.102+ #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Call Trace:
>  <TASK>
>  __schedule+0x3da/0x1650
>  schedule+0x58/0x100
>  schedule_preempt_disabled+0xe/0x20
>  __mutex_lock.constprop.0+0x3bb/0x640
>  __mutex_lock_slowpath+0x13/0x20
>  mutex_lock+0x3c/0x50
>  proc_cgroup_show+0x4d/0x380
>  proc_single_show+0x53/0xe0
>  seq_read_iter+0x12f/0x4b0
>  seq_read+0xcd/0x110
>  vfs_read+0xb1/0x360
>  ? __seccomp_filter+0x368/0x590
>  ksys_read+0x73/0x100
>  __x64_sys_read+0x19/0x30
>  x64_sys_call+0x18d3/0x2210
>  do_syscall_64+0x56/0x90
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> The system recovers only once the reclaim finally finishes and releases
> the active reference. The reclaim itself is pointless here: the cgroup
> is being torn down and its remaining pages will be reparented to the
> parent anyway.
> 
> Even though we check signal_pending(current) in the reclaim loop, the
> typical symptom is that cat /proc/<pid>/cgroup gets stuck.
> By the time someone looks for which task is actually stuck in reclaim,
> the hung task timeout has already been hit. This makes the problem
> particularly nasty to debug from a hung-task report alone, because the
> blocked tasks shown are often the victims, not the reclaim writer itself.
> 
> Our Mitigation
> ==============
> 
> cgroup destruction sets CSS_DYING in kill_css_sync() *before*
> css_clear_dir() triggers the kernfs_drain() that blocks the remover. The
> in-flight reclaim loop is therefore guaranteed to observe it before
> starting another reclaim iteration. This series checks memcg_is_dying()
> in the v2 reclaim loops (memory.high, memory.max and proactive reclaim)
> and the v1 reclaim loops (memory.limit_in_bytes,
> memory.memsw.limit_in_bytes and memory.force_empty), and bails out early,
> so the writer drops the active reference promptly and the remover can
> make progress.
> 
> Unlike the no-progress guard (MAX_RECLAIM_RETRIES), which only fires when
> reclaim makes zero progress, the dying check also covers the slow swap
> I/O and thrashing cases, where reclaim keeps succeeding a little and the
> loop would otherwise never converge.
> 
> For memory.reclaim, bailing out because the memcg is dying means the
> requested reclaim amount was not satisfied, so the write returns -EAGAIN.
> 
> This is orthogonal to commit c8e6002bd611 ("memcg: introduce
> non-blocking limit setting option"): O_NONBLOCK lets a caller avoid the
> synchronous reclaim up front, while this series handles the case where
> reclaim is already running when the cgroup starts being removed.
> 
> Changes since v1:
>   - Return -EAGAIN from memory.reclaim when the memcg is dying.
>   - Add the same bailout to the legacy v1 reclaim loops.
> 
> v1:
>   https://lore.kernel.org/linux-mm/20260623062800.298514-1-jiayuan.chen@linux.dev/
> 
> Jiayuan Chen (4):
>   memcg: bail out memory.high when memcg is dying
>   memcg: bail out memory.max when memcg is dying
>   memcg: bail out proactive reclaim when memcg is dying
>   memcg-v1: bail out reclaim when memcg is dying
> 
>  mm/memcontrol-v1.c | 6 ++++++
>  mm/memcontrol.c    | 6 ++++++
>  mm/vmscan.c        | 3 +++
>  3 files changed, 15 insertions(+)
> 
> -- 
> 2.43.0

