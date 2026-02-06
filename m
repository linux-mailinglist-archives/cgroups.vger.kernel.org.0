Return-Path: <cgroups+bounces-13758-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDPYIc1/hmmVOAQAu9opvQ
	(envelope-from <cgroups+bounces-13758-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 00:57:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B086104340
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 00:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ECEE303BB25
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE32FD7A3;
	Fri,  6 Feb 2026 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvtmtm60"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA28313E22
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770422186; cv=none; b=Fn885z9CDzBFNnFOs0InUcuNOw5ydAqfjDplXTv8v8pFiQkmaE8Mw4ABUy0h1a8b/IvHVPVIBeZ2kzEmxq/8G+ux0Zplm8avh06JEd7k9i4bdURB8ofxeDzxy7K7KwMs+w7XhiJykXxmaU39Otx9nR0LGXudmr9MMkCYP9Gjk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770422186; c=relaxed/simple;
	bh=OkJt9zpckdw22ZpKHkb7JRzpfCA6dn//rhBE2I0MbLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=YmPa/MZemQR7c9RP+Ks6rAT9D6Dbbu3Cq2do+sJeLU0Wfu1dz3EHe9KMJXxNItUUkBek2tHXS94tPpzOdFbm52uSLFLx3bYigfvJNII1WXbcV3As5dD2dXBrCWryM8y64uwOC4Fi3jW9FytdKKysrdojhdXLHIeVOxwuVBJbHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvtmtm60; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4362c63531bso840012f8f.0
        for <cgroups@vger.kernel.org>; Fri, 06 Feb 2026 15:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770422184; x=1771026984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMvWXl+16besIoFxtupa8KqKhPGPXd3D6bW5GUBT3Eo=;
        b=gvtmtm6051gjSwpWkUc64ozoNQiIt4kWtnrwTcz87UpduA/wFYE8SJt5XlZ5LAFH+3
         rFwhE1g0jORg6UV9d7ihmSKPkAWJWfvrjyesfASOWQtDBb6bm0Sj64ZELLh/Crzye6Di
         8uP1FnZyd/SaZyGfnGd1VRM7N22Y41ImtlfamW5cmZpIUqZOEoGRy9iKTPtNZBoKEr2A
         hEArJLze8Z6A01mmiC7ExA6aQHwY4XDvqx5CGXmhXZAmIHPGSuPfElMkY5Sx53SZ+9am
         xpJWyNdtEoXcAaBDMlaR5tryHOlq8tSUY7RbmRQvZ/RAg4hISyCGYMmn9xQwxsg4dXHK
         AFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770422184; x=1771026984;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMvWXl+16besIoFxtupa8KqKhPGPXd3D6bW5GUBT3Eo=;
        b=kAu6aICWUQ2iqSgwWX8b7dIFNrLDvLSll951luyUJ2STzVKvYrmDp26kDxTeaLYRqV
         WtSLNEGL/GNLTo0jUcr26yhBP7qcDCbxHpBi+UsqOwlIvyzczKTcspQ8Y9+Qe9hHqDSb
         Scj5cqqxV7Xx3XwMbtnn7oJa2766qXEMFgm2svJCXZaF9zN10pelehadbOTr7wgd9ULk
         VDrpGip76YsYpXE7eEmfg/r85rLI4dVTBPS/pzc49m5gKtfp1IDnA5/EVaAWU1BPLieo
         9+HBcn/A/bZ4gZm6i4d4mbm93Ipjz/8zYNJuE6+M62aTiqJCGix0BgG6tYDwXDVcPq2L
         d60Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZYDfbfEHKOrPamhvIbUdGzcBVZReG0EYlFI4HeUGB2ZBmo/p0Khjs9fxOUKoyQoq4pqwUy0IU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tryIPvXyw74Gde8/fStuNYgTRiJSaU3hrF2xN8k2il35TOvq
	LAnW7WlwImrl0Ft723TtE9r9ynvMRdz/z8iqNTLof5ftAXpiEgQ8evFf
X-Gm-Gg: AZuq6aLgf0gvMPqYSXC2ifLjYmvfWL5CqqACx17M+VU8LzN6DpoPuWJw20dyqmLowlk
	SnjzGJ7aIEFP9tdqiM24oOB+ycaWEFu8AN6idtOahgJ/AbKy9mgsovMe54rX4C/zE/7XsI6YGDN
	kRftkHKWuZohZSySJNxdDdBi6Q5pvteUoDe7oOsufaw+nWxiQMyPo/RzL/U3FhJRMK7kVWvwcic
	yoxSFM+WFZEwuMCfyZTJZOkt2exU/dpUzMUK67Unk93A8lwGBAUxWV6UpkP5pJudQJrJs6ol8is
	CFiWwDcKxYltriC9w+Ppzu9RUP/w3N2Yq0vXOXbpZFJUgs/dOL7AO2lWqKd72NGS1705FLVLkMk
	9UC4Cxu8RN0JyzkkV8RNOwsIpGn9dXLm//q+x/Ou0n2lYkIjFWJRgrHv0hKkZkj38dBapYLI7UY
	+zefCX4MRXV7+YMyh37xg8qfKZmqj3sysWgg==
X-Received: by 2002:a05:6000:2304:b0:436:cea:6165 with SMTP id ffacd0b85a97d-4362904b70dmr5665598f8f.6.1770422184414;
        Fri, 06 Feb 2026 15:56:24 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629754c62sm8306435f8f.38.2026.02.06.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 15:56:23 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
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
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Date: Fri,  6 Feb 2026 20:56:21 -0300
Message-ID: <aYZ2fM39jyoOF247@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206143430.021026873@redhat.com>
References: <20260206143430.021026873@redhat.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13758-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,redhat.com,linutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0B086104340
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:34:30AM -0300, Marcelo Tosatti wrote:
> The problem:
> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.
> 
> On the other hand, for RT workloads this can represent a problem: getting
> an important workload scheduled out to deal with remote requests is
> sure to introduce unexpected deadline misses.
> 
> The idea:
> Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> In this case, instead of scheduling work on a remote cpu, it should
> be safe to grab that remote cpu's per-cpu spinlock and run the required
> work locally. That major cost, which is un/locking in every local function,
> already happens in PREEMPT_RT.
> 
> Also, there is no need to worry about extra cache bouncing:
> The cacheline invalidation already happens due to schedule_work_on().
> 
> This will avoid schedule_work_on(), and thus avoid scheduling-out an
> RT workload.
> 

Marcelo, thanks for finishing this series!

> Proposed solution:
> A new interface called Queue PerCPU Work (QPW), which should replace
> Work Queue in the above mentioned use case.
> 
> If PREEMPT_RT=n this interfaces just wraps the current

Are we enabling it by default in PREEMPT_RT=y? If not,

If CONFIG_QPW=n or qpw=0 this interfaces just wraps the current

> local_locks + WorkQueue behavior, so no expected change in runtime.
> 
> If PREEMPT_RT=y, or CONFIG_QPW=y, queue_percpu_work_on(cpu,...) will

Same here

If CONFIG_QPW=y and qpw=1, queue_percpu_work_on(cpu,...) will

> lock that cpu's per-cpu structure and perform work on it locally. 
> This is possible because on functions that can be used for performing
> remote work on remote per-cpu structures, the local_lock (which is already
> a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> is able to get the per_cpu spinlock() for the cpu passed as parameter.
> 
> RFC->v1:
> 
> - Introduce CONFIG_QPW and qpw= kernel boot option to enable 
>   remote spinlocking and execution even on !CONFIG_PREEMPT_RT
>   kernels (Leonardo Bras).
> - Move buffer_head draining to separate workqueue (Marcelo Tosatti).
> - Convert mlock per-CPU page lists to QPW (Marcelo Tosatti).
> - Drop memcontrol convertion (as isolated CPUs are not targets
>   of queue_work_on anymore).
> - Rebase SLUB against Vlastimil's slab/next.
> - Add basic document for QPW (Waiman Long).

A document was a nice touch :)

> 
> 
> The following testcase triggers lru_add_drain_all on an isolated CPU
> (that does sys_write to a file before entering its realtime 
> loop).
> 
> /* 
>  * Simulates a low latency loop program that is interrupted
>  * due to lru_add_drain_all. To trigger lru_add_drain_all, run:
>  *
>  * blockdev --flushbufs /dev/sdX
>  *
>  */ 
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <string.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <stdlib.h>
> #include <stdarg.h>
> #include <pthread.h>
> #include <sched.h>
> #include <unistd.h>
> 
> int cpu;
> 
> static void *run(void *arg)
> {
> 	pthread_t current_thread;
> 	cpu_set_t cpuset;
> 	int ret, nrloops;
> 	struct sched_param sched_p;
> 	pid_t pid;
> 	int fd;
> 	char buf[] = "xxxxxxxxxxx";
> 
> 	CPU_ZERO(&cpuset);
> 	CPU_SET(cpu, &cpuset);
> 
> 	current_thread = pthread_self();    
> 	ret = pthread_setaffinity_np(current_thread, sizeof(cpu_set_t), &cpuset);
> 	if (ret) {
> 		perror("pthread_setaffinity_np failed\n");
> 		exit(0);
> 	}
> 
> 	memset(&sched_p, 0, sizeof(struct sched_param));
> 	sched_p.sched_priority = 1;
> 	pid = gettid();
> 	ret = sched_setscheduler(pid, SCHED_FIFO, &sched_p);
> 	if (ret) {
> 		perror("sched_setscheduler");
> 		exit(0);
> 	}
> 
> 	fd = open("/tmp/tmpfile", O_RDWR|O_CREAT|O_TRUNC);
> 	if (fd == -1) {
> 		perror("open");
> 		exit(0);
> 	}
> 
> 	ret = write(fd, buf, sizeof(buf));
> 	if (ret == -1) {
> 		perror("write");
> 		exit(0);
> 	}
> 
> 	do { 
> 		nrloops = nrloops+2;
> 		nrloops--;
> 	} while (1);
> }
> 
> int main(int argc, char *argv[])
> {
>         int fd, ret;
> 	pthread_t thread;
> 	long val;
> 	char *endptr, *str;
> 	struct sched_param sched_p;
> 	pid_t pid;
> 
> 	if (argc != 2) {
> 		printf("usage: %s cpu-nr\n", argv[0]);
> 		printf("where CPU number is the CPU to pin thread to\n");
> 		exit(0);
> 	}
> 	str = argv[1];
> 	cpu = strtol(str, &endptr, 10);
> 	if (cpu < 0) {
> 		printf("strtol returns %d\n", cpu);
> 		exit(0);
> 	}
> 	printf("cpunr=%d\n", cpu);
> 
> 	memset(&sched_p, 0, sizeof(struct sched_param));
> 	sched_p.sched_priority = 1;
> 	pid = getpid();
> 	ret = sched_setscheduler(pid, SCHED_FIFO, &sched_p);
> 	if (ret) {
> 		perror("sched_setscheduler");
> 		exit(0);
> 	}
> 
> 	pthread_create(&thread, NULL, run, NULL);
> 
> 	sleep(5000);
> 
> 	pthread_join(thread, NULL);
> }
> 
> 

Also, having the reproducer in the cover letter was a great idea!

Thanks!
Leo

