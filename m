Return-Path: <cgroups+bounces-13738-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMlcIVb9hWnUIwQAu9opvQ
	(envelope-from <cgroups+bounces-13738-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:40:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFBFF153
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F011301584F
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7B41B36F;
	Fri,  6 Feb 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CojOxct5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817E376488
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388816; cv=none; b=pYY7ciLiZurbk3X54YuZ1iZRvdHu/70M2Dy9U0kiebEsNC61gYPdzzXyTxXbIBqNNKJoFcMPzXtOz69+dTjORnZwAtgSf1JKC8ADQXDsse8r1vnLQgmPBL4nxg6jDL+Pjd4py6MvU4iKYXqMQn/DPN3xgfnki/MU0PNrIYU3Wpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388816; c=relaxed/simple;
	bh=9o+mBU4e8Zgy1c2zCjPizhrxqwt+dEg1yc9v5J326d8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=stEvcmVqEiXBduh7NqXwWSt3cNoOWOTPQvOj2Cu0TV/lCHCNDSw1vzGVUZVQphLGwAd2T6pcw/7gxGH1N/kmrJaiM5OLRcc+vhrLbfUlfHw1t1kKEWgs4YVV98MTqCAV/lmBHw8WQLOpsyFWG9uXwO2LlgfPvDod5cU0uvvPNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CojOxct5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770388815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ZJOPyIeuN4YpQvteY0c57G969uic9qUJI9o0lGN6g88=;
	b=CojOxct5xFfu+mH+QoLT4aPr37RDsRPg8hv3z2OMXeXFQDIikDOQFypbLt0B64XtvjLdCD
	A1OP/0x+rWumMv1Shoca7DHNtN5YD4opsObInV/YRajn5Ma52WowKtXMFFnm33ttBMTl8j
	DqELE3fF/SG1frGKGtxmJSkbkpa/vtk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-_sk-7kBwPcOgQlIMf14EzA-1; Fri,
 06 Feb 2026 09:40:12 -0500
X-MC-Unique: _sk-7kBwPcOgQlIMf14EzA-1
X-Mimecast-MFC-AGG-ID: _sk-7kBwPcOgQlIMf14EzA_1770388809
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF63118005B6;
	Fri,  6 Feb 2026 14:40:09 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.22.74.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DF8B19373D8;
	Fri,  6 Feb 2026 14:40:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id A16CE400DF80B; Fri,  6 Feb 2026 11:39:20 -0300 (-03)
Message-ID: <20260206143430.021026873@redhat.com>
User-Agent: quilt/0.66
Date: Fri, 06 Feb 2026 11:34:30 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH 0/4] Introduce QPW for per-cpu operations
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-13738-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EEBFBFF153
X-Rspamd-Action: no action

The problem:
Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem: getting
an important workload scheduled out to deal with remote requests is
sure to introduce unexpected deadline misses.

The idea:
Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
In this case, instead of scheduling work on a remote cpu, it should
be safe to grab that remote cpu's per-cpu spinlock and run the required
work locally. That major cost, which is un/locking in every local function,
already happens in PREEMPT_RT.

Also, there is no need to worry about extra cache bouncing:
The cacheline invalidation already happens due to schedule_work_on().

This will avoid schedule_work_on(), and thus avoid scheduling-out an
RT workload.

Proposed solution:
A new interface called Queue PerCPU Work (QPW), which should replace
Work Queue in the above mentioned use case.

If PREEMPT_RT=n this interfaces just wraps the current
local_locks + WorkQueue behavior, so no expected change in runtime.

If PREEMPT_RT=y, or CONFIG_QPW=y, queue_percpu_work_on(cpu,...) will
lock that cpu's per-cpu structure and perform work on it locally. 
This is possible because on functions that can be used for performing
remote work on remote per-cpu structures, the local_lock (which is already
a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
is able to get the per_cpu spinlock() for the cpu passed as parameter.

RFC->v1:

- Introduce CONFIG_QPW and qpw= kernel boot option to enable 
  remote spinlocking and execution even on !CONFIG_PREEMPT_RT
  kernels (Leonardo Bras).
- Move buffer_head draining to separate workqueue (Marcelo Tosatti).
- Convert mlock per-CPU page lists to QPW (Marcelo Tosatti).
- Drop memcontrol convertion (as isolated CPUs are not targets
  of queue_work_on anymore).
- Rebase SLUB against Vlastimil's slab/next.
- Add basic document for QPW (Waiman Long).


The following testcase triggers lru_add_drain_all on an isolated CPU
(that does sys_write to a file before entering its realtime 
loop).

/* 
 * Simulates a low latency loop program that is interrupted
 * due to lru_add_drain_all. To trigger lru_add_drain_all, run:
 *
 * blockdev --flushbufs /dev/sdX
 *
 */ 
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <stdarg.h>
#include <pthread.h>
#include <sched.h>
#include <unistd.h>

int cpu;

static void *run(void *arg)
{
	pthread_t current_thread;
	cpu_set_t cpuset;
	int ret, nrloops;
	struct sched_param sched_p;
	pid_t pid;
	int fd;
	char buf[] = "xxxxxxxxxxx";

	CPU_ZERO(&cpuset);
	CPU_SET(cpu, &cpuset);

	current_thread = pthread_self();    
	ret = pthread_setaffinity_np(current_thread, sizeof(cpu_set_t), &cpuset);
	if (ret) {
		perror("pthread_setaffinity_np failed\n");
		exit(0);
	}

	memset(&sched_p, 0, sizeof(struct sched_param));
	sched_p.sched_priority = 1;
	pid = gettid();
	ret = sched_setscheduler(pid, SCHED_FIFO, &sched_p);
	if (ret) {
		perror("sched_setscheduler");
		exit(0);
	}

	fd = open("/tmp/tmpfile", O_RDWR|O_CREAT|O_TRUNC);
	if (fd == -1) {
		perror("open");
		exit(0);
	}

	ret = write(fd, buf, sizeof(buf));
	if (ret == -1) {
		perror("write");
		exit(0);
	}

	do { 
		nrloops = nrloops+2;
		nrloops--;
	} while (1);
}

int main(int argc, char *argv[])
{
        int fd, ret;
	pthread_t thread;
	long val;
	char *endptr, *str;
	struct sched_param sched_p;
	pid_t pid;

	if (argc != 2) {
		printf("usage: %s cpu-nr\n", argv[0]);
		printf("where CPU number is the CPU to pin thread to\n");
		exit(0);
	}
	str = argv[1];
	cpu = strtol(str, &endptr, 10);
	if (cpu < 0) {
		printf("strtol returns %d\n", cpu);
		exit(0);
	}
	printf("cpunr=%d\n", cpu);

	memset(&sched_p, 0, sizeof(struct sched_param));
	sched_p.sched_priority = 1;
	pid = getpid();
	ret = sched_setscheduler(pid, SCHED_FIFO, &sched_p);
	if (ret) {
		perror("sched_setscheduler");
		exit(0);
	}

	pthread_create(&thread, NULL, run, NULL);

	sleep(5000);

	pthread_join(thread, NULL);
}



