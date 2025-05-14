Return-Path: <cgroups+bounces-8184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608F0AB63D2
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 09:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15B3188ECDE
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C984205501;
	Wed, 14 May 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oC7vMgk+"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55E1E98E0;
	Wed, 14 May 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206717; cv=none; b=tlPlOIUM1BaYILY89lFcT0ZwnxvZCzK6mOfVPGIUcjs9WSsXJ9SjnaMhn8QN3NGaQWITNv69GfhD75xBFLUmldPQ8kYdZXe6A4iGdfSJdtHjIX9kMKqstUMON1u/w6S2CRxDMYOITm1gg8ThV+KFrylEjQq3Jv3cizkEuR5upWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206717; c=relaxed/simple;
	bh=qlq2DuLcKvogzQRme/kBzz6mvvH+xii/LpWouaVhH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+MQZkT50+52Wpsd4hGb2RjMoWhD66K4zXA/DOsp9bcb4+i2Jl9ouDRjbNTqjET7kPz7IMaqNzGjwzJJG3XL8lKzju3Bb7i5Q2Wi9AL7qfDvMvMBS1CB2ZnMcogCLEr5dqeetXIlCGXuqSb3hEOU10cvivXlLD1CSi2AOD0o5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oC7vMgk+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EFvseOXYys5kITisJ1qS0WFaJXYFq3Ac6sONg0UaglM=; b=oC7vMgk+wnSJF6DewHj87tRCxe
	3cRn1Wp1stx5BqyOYvm+qSvY65/J7pAPeF4N16Ud9Q+78FIzTmx5M4wj2aO29pfmZWHhLE+XRIn0B
	ivTv2XpYYyPw9ZuhqLaZyNLk+yhZSlKg2v/Fmc51mDktuvLIUbaWKQZ3oT7ynUE/GkYK9W+px1TpI
	PR7ugF4g8BWDhhRZV2IIXX+iORDvARjoTlpAjcuVmV3BN+YYpv5iWChCBeetfFhp0z8pzO81sNTWs
	WpbknI8uCulAXd7eHDNuhGjfct2nArqTuRkVbSWoH1YDOWhwInjKww+/mwCa201L+lilEvPk00eZU
	3aIyPujA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uF6HJ-0000000H6V6-0WhV;
	Wed, 14 May 2025 07:11:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D3B8300717; Wed, 14 May 2025 09:11:44 +0200 (CEST)
Date: Wed, 14 May 2025 09:11:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	npiggin@gmail.com
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <20250514071144.GB24938@noisy.programming.kicks-ass.net>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
 <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
 <07e4e8d9-2588-41bf-89d4-328ca6afd263@suse.cz>
 <20250513114125.GE25763@noisy.programming.kicks-ass.net>
 <ct2h2eyuepa2g2ltl5fucfegwyuqspvz6d4uugcs4szxwnggdc@6m4ks3hp3tjj>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ct2h2eyuepa2g2ltl5fucfegwyuqspvz6d4uugcs4szxwnggdc@6m4ks3hp3tjj>

On Tue, May 13, 2025 at 03:17:00PM -0700, Shakeel Butt wrote:

> > IIRC Power64 has issues here, 'funnily' their local_t is NMI safe.
> > Perhaps we could do the same for their this_cpu_*(), but ideally someone
> > with actual power hardware should do this ;-)
> > 
> 
> Is CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS the right config to
> differentiate between such archs? I see Power64 does not have that
> enabled.

> > There is no config symbol for this presently.
> 
> Hmm what about CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS?

Hmm, I didn't know about that one, and it escaped my grep yesterday.

Anyway, PPC is fixable, just not sure its worth it for them.

> > 
> > > - (if the above leaves any 64bit arch) its 64bit atomics implementation is safe
> > 
> > True, only because HPPA does not in fact have NMIs.
> 
> What is HPPA?

arch/parisc the worst 64bit arch ever.

They saw sparc32-smp and thought that was a great idea, or something
along those lines. Both are quite terrible. Sparc64 realized the mistake
and fixed it -- it has cmpxchg.


Nick, is this something that's useful for you guys?

---
diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index ecf5ac70cfae..aa188db68ef5 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -25,6 +25,11 @@ DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 #define percpu_first_chunk_is_paged	false
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#define __pcpu_local_irq_save(f) powerpc_local_irq_pmu_save(f)
+#define __pcpu_local_irq_restore(s) powerpc_local_irq_pmu_restore(f)
+#endif
+
 #include <asm-generic/percpu.h>
 
 #include <asm/paca.h>
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 02aeca21479a..5c8376588dfb 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -75,6 +75,11 @@ extern void setup_per_cpu_areas(void);
 #define PER_CPU_ATTRIBUTES
 #endif
 
+#ifndef __pcpu_local_irq_save
+#define __pcpu_local_irq_save(x) raw_local_irq_save(x)
+#define __pcpu_local_irq_restore(x) raw_local_irq_restore(x)
+#endif
+
 #define raw_cpu_generic_read(pcp)					\
 ({									\
 	*raw_cpu_ptr(&(pcp));						\
@@ -146,9 +151,9 @@ do {									\
 ({									\
 	TYPEOF_UNQUAL(pcp) ___ret;					\
 	unsigned long ___flags;						\
-	raw_local_irq_save(___flags);					\
+	__pcpu_local_irq_save(___flags);					\
 	___ret = raw_cpu_generic_read(pcp);				\
-	raw_local_irq_restore(___flags);				\
+	__pcpu_local_irq_restore(___flags);				\
 	___ret;								\
 })
 
@@ -165,9 +170,9 @@ do {									\
 #define this_cpu_generic_to_op(pcp, val, op)				\
 do {									\
 	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
+	__pcpu_local_irq_save(__flags);					\
 	raw_cpu_generic_to_op(pcp, val, op);				\
-	raw_local_irq_restore(__flags);					\
+	__pcpu_local_irq_restore(__flags);					\
 } while (0)
 
 
@@ -175,9 +180,9 @@ do {									\
 ({									\
 	TYPEOF_UNQUAL(pcp) __ret;					\
 	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
+	__pcpu_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_add_return(pcp, val);			\
-	raw_local_irq_restore(__flags);					\
+	__pcpu_local_irq_restore(__flags);					\
 	__ret;								\
 })
 
@@ -185,9 +190,9 @@ do {									\
 ({									\
 	TYPEOF_UNQUAL(pcp) __ret;					\
 	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
+	__pcpu_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_xchg(pcp, nval);			\
-	raw_local_irq_restore(__flags);					\
+	__pcpu_local_irq_restore(__flags);					\
 	__ret;								\
 })
 
@@ -195,9 +200,9 @@ do {									\
 ({									\
 	bool __ret;							\
 	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
+	__pcpu_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval);		\
-	raw_local_irq_restore(__flags);					\
+	__pcpu_local_irq_restore(__flags);					\
 	__ret;								\
 })
 
@@ -205,9 +210,9 @@ do {									\
 ({									\
 	TYPEOF_UNQUAL(pcp) __ret;					\
 	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
+	__pcpu_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_cmpxchg(pcp, oval, nval);		\
-	raw_local_irq_restore(__flags);					\
+	__pcpu_local_irq_restore(__flags);					\
 	__ret;								\
 })
 

