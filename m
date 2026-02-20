Return-Path: <cgroups+bounces-14077-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cRjEIVjimGm2NwMAu9opvQ
	(envelope-from <cgroups+bounces-14077-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 23:38:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D579B16B44E
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 23:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C93B301544A
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19A3101BD;
	Fri, 20 Feb 2026 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEhsmIRo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0B3033DE
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627093; cv=none; b=JM2XhpzGq6aoOh/aY+Ir6LLj6QinfiEg8vd+rbsFkrJJmzizm1ewuRg+I+VKrXyHlcrIH9/6/raZiE85lvLqkPk4J9K6s9cHY9B0nPs4wG6FZtAubndSwZONG8dwPIp0aLhkniY8t8itjdo44/0EW8GUjilZP4LdFYPu7ho76pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627093; c=relaxed/simple;
	bh=kznS5zbgByL4LswbVNS7+HIUnrX5/AH+cagKNemQ4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=aiy3W1LmU1NzqWtP8/ztHL+38qvGDN2u55mvNzd5lRAUiV+U3gDnx8K02LO4ZzUT0CSpcMdwTckawv3Hi1fnxQqiOJWovC6UojLDLtCgUKpXlzOuSmakX1ZugBhLccGTo8kcQpl0S59wORreiUWe5YoI+8YVjb7iRvoT0k/XOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEhsmIRo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4807068eacbso20634025e9.2
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771627090; x=1772231890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/XzsAqXyN/LDQgNAnCZM9h69cqY0mG7wY/zZ4ZIqdNg=;
        b=MEhsmIRoMxpNxMxPP2xr84OyAgziY2AGVHUAbRW+FUd4VS6ur35GsYwK/rCgZ5AqvN
         jdFqfve029Z+SUe75q9NhEJJbPalW04AJmohCTdLYnaZoZIXchNcXTBXQcFGMmPsthpH
         hwdA/wqf7FK9RvzMAqxgGa47DbzW8bMld7E86FRzFtI/oHE9/mSMnsg9AN+rTiU5vryu
         4/0/4ZtQfxITdB3+7lH+6LPkyQfshR7ajETCIeelXxbh4O0yfDdnuciP+vF3eAWQ8OzB
         juVGzADw2F3UR+GAC6xMVM2/y2jjHd8QQQIwdydI8QC1CtRdcZqk5uzV+zaPFdXKWUl7
         NZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627090; x=1772231890;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XzsAqXyN/LDQgNAnCZM9h69cqY0mG7wY/zZ4ZIqdNg=;
        b=XG9MhohCIHCLnksm6trLaiPzeQ+U+xbpNR7Kthn8N8g+YfUzVA+8FrA3EE3GucByjp
         UR9p0I7uesmQfHOZOuS5l+0AWhfUbG0tYaxIlPMraKkSUX6wdsNBMY+O8b+LM0fx66Ws
         mISztPbofc/5gOlvgLfSglC7PIj5iJ8R2yHu2WYCYx4ePBt93nU15D9WqhgopOlslsW0
         D8m9r72/sazp+t5GrDtj5AQHQ98HFvlnIe8hhBGBjZEulY37OoQaAUPd8VgF/FJi9ugZ
         WJPv8dV0S/PqJx0EYGePZzutDB/cLQg/OZFDBzjMceWB/eXjxbqf38y3J5zTpD1bFOaw
         2ddg==
X-Forwarded-Encrypted: i=1; AJvYcCUPCgLBmKQyNPMkKbVCQvuf36BZGhi+uEb3rbpKo1Y1YRio+KzQuXbd2yhlRM1cO5p2xj1Tr3jU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7MgtrccL0xcy0465hefP0DQj+9IDVTsHirKr3N5vRgnob1dr
	2zrN15qeK3EK7XtaWSEp1Xth3BIIsN3Wza656ePkuZm8BoPie1Co4SrY
X-Gm-Gg: AZuq6aLeRHj91GTQ/XGGLUFqvSEAYYWSJ98zQl7wl2FsTu19Y93uJKj+BsXC+/nCYLH
	7T5Dzvb3gQtEDP+JY5GkYryMyJ3C7Yb7ASGzBBU3zgFrDzNylGsPhaE4uxCjw7kmMPYyZz7avxR
	7+ya8I297oLtElX9qkEUauV5l9A0IRf9OOk3a8mvsm7JV4mK1iD+naLKt0nIT6rwFTna2cYPOqq
	gvunHGUpCHDROsDCSLv2KtVjHONOnAVze1D1JPSQvlV1wXWvvAo8exWw6BXGR/ZlEhphdS7BjKK
	acn0C4pZhycWtzd+7bMSV7TQhF6D3UdvMsKjCjx1bVbhb76xpAWVATs9E8dScGJBf5Erormz1p8
	KNE7OZB8Z9UEITjGCLMNPHIGgxovoO2uVT3C1fSbUZ1ElAFYjIzYsB2qQZzS8X7PyQAwli8qqv9
	U4TNE8nOUH8VPclhnPZ5Gg25G2qXYOwgJUlK8=
X-Received: by 2002:a05:600c:8b71:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-483a95dd932mr18372615e9.17.1771627089941;
        Fri, 20 Feb 2026 14:38:09 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3e0dsm167824285e9.1.2026.02.20.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 14:38:09 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Date: Fri, 20 Feb 2026 19:38:04 -0300
Message-ID: <aZjiTM5v-AOsaq2y@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aZiSHT5DwIZwc/cH@tpad>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka> <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka> <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka> <aZiRAa6uf4KhscJC@tpad> <aZiSHT5DwIZwc/cH@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14077-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D579B16B44E
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:55:57PM -0300, Marcelo Tosatti wrote:
> On Fri, Feb 20, 2026 at 01:51:13PM -0300, Marcelo Tosatti wrote:
> > On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> > > On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> > > > On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > > > > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > > > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > > > [...]
> > > > > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > > > > have requirements as strong as RT workloads but the underlying
> > > > > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > > > > moving those pcp book keeping activities to be executed to the return to
> > > > > > > the userspace which should be taking care of both RT and non-RT
> > > > > > > configurations AFAICS.
> > > > > > 
> > > > > > Michal,
> > > > > > 
> > > > > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > > > > boot option qpw=y/n, which controls whether the behaviour will be
> > > > > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > > > > 
> > > > > My bad. I've misread the config space of this.
> > > > > 
> > > > > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > > > > (and remote work via work_queue) is used.
> > > > > > 
> > > > > > What "pcp book keeping activities" you refer to ? I don't see how
> > > > > > moving certain activities that happen under SLUB or LRU spinlocks
> > > > > > to happen before return to userspace changes things related 
> > > > > > to avoidance of CPU interruption ?
> > > > > 
> > > > > Essentially delayed operations like pcp state flushing happens on return
> > > > > to the userspace on isolated CPUs. No locking changes are required as
> > > > > the work is still per-cpu.
> > > > > 
> > > > > In other words the approach Frederic is working on is to not change the
> > > > > locking of pcp delayed work but instead move that work into well defined
> > > > > place - i.e. return to the userspace.
> > > > > 
> > > > > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > > > > paths like SLUB sheeves?
> > > > 
> > > > Hi Michal,
> > > > 
> > > > I have done some study on this (which I presented on Plumbers 2023):
> > > > https://lpc.events/event/17/contributions/1484/ 
> > > > 
> > > > Since they are per-cpu spinlocks, and the remote operations are not that 
> > > > frequent, as per design of the current approach, we are not supposed to see 
> > > > contention (I was not able to detect contention even after stress testing 
> > > > for weeks), nor relevant cacheline bouncing.
> > > > 
> > > > That being said, for RT local_locks already get per-cpu spinlocks, so there 
> > > > is only difference for !RT, which as you mention, does preemtp_disable():
> > > > 
> > > > The performance impact noticed was mostly about jumping around in 
> > > > executable code, as inlining spinlocks (test #2 on presentation) took care 
> > > > of most of the added extra cycles, adding about 4-14 extra cycles per 
> > > > lock/unlock cycle. (tested on memcg with kmalloc test)
> > > > 
> > > > Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> > > > operations (even if in a local cacheline) in !RT case, but this could be 
> > > > enabled only if the user thinks this is an ok cost for reducing 
> > > > interruptions.
> > > > 
> > > > What do you think?
> > > 
> > > The fact that the behavior is opt-in for !RT is certainly a plus. I also
> > > do not expect the overhead to be really be really big. To me, a much
> > > more important question is which of the two approaches is easier to
> > > maintain long term. The pcp work needs to be done one way or the other.
> > > Whether we want to tweak locking or do it at a very well defined time is
> > > the bigger question.
> > 
> > Without patchset:
> > ================
> > 
> > [ 1188.050725] kmalloc_bench: Avg cycles per kmalloc: 159
> > 
> > With qpw patchset, CONFIG_QPW=n:
> > ================================
> > 
> > [   50.292190] kmalloc_bench: Avg cycles per kmalloc: 163

Weird.. with CONFIG_QPW we should see no difference.
Oh, maybe the changes in the code, such as adding a new cpu parameter in 
some functions may have caused this.

(oh, there is the migrate_disable as well)

> > 
> > With qpw patchset, CONFIG_QPW=y, qpw=0:
> > =======================================
> > 
> > [   29.872153] kmalloc_bench: Avg cycles per kmalloc: 170
> > 

Humm, what changed here is basically from

+#define qpw_lock(lock, cpu)			\
+	local_lock(lock)

to 

+#define qpw_lock(lock, cpu)								\
+	do {										\
+		if (static_branch_maybe(CONFIG_QPW_DEFAULT, &qpw_sl))			\
+			spin_lock(per_cpu_ptr(lock.sl, cpu));				\
+		else									\
+			local_lock(lock.ll);						\
+	} while (0)


So only the cost of a static branch.. maybe I did something wrong here 
with the static_branch_maybe, as any cpu branch predictor should make this 
delta close to zero.

> > 
> > With qpw patchset, CONFIG_QPW=y, qpw=1:
> > ========================================
> > 
> > [   37.494687] kmalloc_bench: Avg cycles per kmalloc: 190
> > 

20 cycles as a price for a local_lock->spinlock seems too much.
Taking in account the previous message, maybe we should work on making them 
inlined spinlocks, if not already.
(Yeah, I missed that verification :| )

> > With PREEMPT_RT enabled, qpw=0:
> > ===============================
> > 
> > [   65.163251] kmalloc_bench: Avg cycles per kmalloc: 181
> > 
> > With PREEMPT_RT enabled, no patchset:
> > =====================================
> > [   52.701639] kmalloc_bench: Avg cycles per kmalloc: 185
> > 

Nice, having the QPW patch saved some cycles :)


> > With PREEMPT_RT enabled, qpw=1:
> > ==============================
> > 
> > [   35.103830] kmalloc_bench: Avg cycles per kmalloc: 196
> 

This is odd, though. The spinlock is already there, so from qpw=0 to qpw=1 
there should be no performance change. Maybe in local_lock they do some 
optimization in their spinlock?


> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/timex.h>
> #include <linux/preempt.h>
> #include <linux/irqflags.h>
> #include <linux/vmalloc.h>
> 
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Gemini AI");
> MODULE_DESCRIPTION("A simple kmalloc performance benchmark");
> 
> static int size = 64; // Default allocation size in bytes
> module_param(size, int, 0644);
> 
> static int iterations = 1000000; // Default number of iterations
> module_param(iterations, int, 0644);
> 
> static int __init kmalloc_bench_init(void) {
>     void **ptrs;
>     cycles_t start, end;
>     uint64_t total_cycles;
>     int i;
>     pr_info("kmalloc_bench: Starting test (size=%d, iterations=%d)\n", size, iterations);
> 
>     // Allocate an array to store pointers to avoid immediate kfree-reuse optimization
>     ptrs = vmalloc(sizeof(void *) * iterations);
>     if (!ptrs) {
>         pr_err("kmalloc_bench: Failed to allocate pointer array\n");
>         return -ENOMEM;
>     }
> 
>     preempt_disable();
>     start = get_cycles();
> 
>     for (i = 0; i < iterations; i++) {
>         ptrs[i] = kmalloc(size, GFP_ATOMIC);
>     }
> 
>     end = get_cycles();
> 
>     total_cycles = end - start;
>     preempt_enable();
> 
>     pr_info("kmalloc_bench: Total cycles for %d allocs: %llu\n", iterations, total_cycles);
>     pr_info("kmalloc_bench: Avg cycles per kmalloc: %llu\n", total_cycles / iterations);
> 
>     // Cleanup
>     for (i = 0; i < iterations; i++) {
>         kfree(ptrs[i]);
>     }
>     vfree(ptrs);
> 
>     return 0;
> }
> 
> static void __exit kmalloc_bench_exit(void) {
>     pr_info("kmalloc_bench: Module unloaded\n");
> }
> 
> 


Nice!
Please collect min and max as well, maybe we can have an insight of what 
could have happened, then :)

What was the system you used for testing?

Thanks!
Leo

