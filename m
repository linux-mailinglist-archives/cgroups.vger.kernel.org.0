Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E588B67AAFB
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 08:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAYHgk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 02:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjAYHgj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 02:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8896367E0
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fnKT1MJD+ucJIxHKvxLLC0LjfVH19PUsoy+1ammqfUQ=;
        b=QacYW2qie/BHxX5mmKBFbbt7KS+Vi4xBtkpUGUIv04MCoIYnl0oeLNIXAdkPdUyYQEodBQ
        IgKwcuVTrXqTMnMwfVeZCd1nemHZDquB6VGdwhI+zjscFJdR85Q3GhPK5uIGfMLfYvp9tQ
        ioQJWVMePtDV+8u18HiNUjjW0u/lsKQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-hyOrLf7eNM-7azsuscXAqg-1; Wed, 25 Jan 2023 02:35:46 -0500
X-MC-Unique: hyOrLf7eNM-7azsuscXAqg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-16320d2b9c7so1378644fac.19
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnKT1MJD+ucJIxHKvxLLC0LjfVH19PUsoy+1ammqfUQ=;
        b=7CbPXSF8eliEjIGpzZ+Qmtle4OeSNFF9QSniFqQ+F2sRAijZ9jDdwrGZoxfFAZibvy
         5vzzqkk1VWC9xjmTCSHHzeOBZnr4ytx0uMXfYJaWWrx6nfhCR/vKZgVY6LZuHMcIuHn4
         dnND1m0lEb9Tu9cZGvda1A52ntfO4JDeQYcM3SnpgZ//9WbgWwdF5ve+lKEI0ZzPkwbe
         RrLmN1SWUht8S3xfiLgSrdGZ+Ej99AmPpB5xbWr64M61E2i9l3Ih/qK5mrcOQEFKbL8z
         e6EwEEY1v8BM7KBAk1vpJiqdl0hzx8riecnuC7Rb+GWVKBpvGeb3QDP4bfZQqdosi5Qw
         Lz6Q==
X-Gm-Message-State: AFqh2kq3aCGZx11WirDFmtayasUNEl1/jza2jLs9PTm6C8PN+If0VluQ
        Q+U/dVbXyhQjmyjO5dK0K7fiAR1iaBXNF4MGJok+OC4Fub5yChcpm+5R+2Y2rO4OqWiIMWoqO/a
        ZKJ085AlsssM6/5q5Jw==
X-Received: by 2002:a4a:b542:0:b0:502:a732:f8f5 with SMTP id s2-20020a4ab542000000b00502a732f8f5mr7489703ooo.5.1674632144801;
        Tue, 24 Jan 2023 23:35:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlSfi5XHt02LX8y2cukx3jlCSkr0tODzZuof9xvw5qoVzLqkPz/nSgbEX8rYko34VuDssNUw==
X-Received: by 2002:a4a:b542:0:b0:502:a732:f8f5 with SMTP id s2-20020a4ab542000000b00502a732f8f5mr7489692ooo.5.1674632144483;
        Tue, 24 Jan 2023 23:35:44 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id x189-20020a4a41c6000000b0050dc79bb80esm1538802ooa.27.2023.01.24.23.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:35:43 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Date:   Wed, 25 Jan 2023 04:34:57 -0300
Message-Id: <20230125073502.743446-1-leobras@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Disclaimer:
a - The cover letter got bigger than expected, so I had to split it in
    sections to better organize myself. I am not very confortable with it.
b - Performance numbers below did not include patch 5/5 (Remove flags
    from memcg_stock_pcp), which could further improve performance for
    drain_all_stock(), but I could only notice the optimization at the
    last minute.


0 - Motivation:
On current codebase, when drain_all_stock() is ran, it will schedule a
drain_local_stock() for each cpu that has a percpu stock associated with a
descendant of a given root_memcg.

This happens even on 'isolated cpus', a feature commonly used on workloads that
are sensitive to interruption and context switching such as vRAN and Industrial
Control Systems.

Since this scheduling behavior is a problem to those workloads, the proposal is
to replace the current local_lock + schedule_work_on() solution with a per-cpu
spinlock.

1 - Possible performance losses:
With a low amount of shedule_work_on(), local_locks are supposed to perform
better than spinlocks, given cacheline is always accessed by a single CPU and
there is no contention. The impact on those areas is analyzed bellow:

1.1 - Cacheline usage
In current implementation drain_all_stock() will be remote reading the percpu
memcg_stock cacheline of every online CPU, and remote writing to all cpus that
succeed the mem_cgroup_is_descendant() test. (stock->flags, stock->work)

With spinlocks, drain_all_stock() will be remote reading the percpu memcg_stock
cacheline of every online CPU, and remote writing to all cpus that succeed the
mem_cgroup_is_descendant() test. (stock->stock_lock, on top of the above)
While the spinlock may require extra acquire/release writes on some archs, they
will all happen on an exclusive cacheline, so not much overhead.

In both cases, the next local cpu read will require a fetch from memory (as it
was invalidated on the remote write) and cacheline exclusivity get before the
local write.

So about cacheline usage, there should not be much impact.

1.2 - Contention
We can safely assume that drain_all_stock() will not run oftenly. If it was not
the case, there would be a lot of scheduled tasks and kill cpu performance.

Since it does not run oftenly, and it is the only function that acesses remote
percpu memcg_stock, contention should not be too expressive, and should cause
less impact than scheduling (remote) and running the scheduled work (local). 


2 - Performance test results:
2.1 - Test System:
	- Non-virtualized AMD EPYC 7601 32-Core Processor, 128 CPUs distributed 
	in 8 NUMA nodes:  0-7,64-71 on node0, 8-15,72-79 on node1, and so on.
	- 256GB RAM, 2x32GB per NUMA node
	- For cpu isolation: use kernel cmdline:
	isolcpus=8-15,72-79 nohz_full=8-15,72-79
	- Memcg group created with:
		[Slice]
		MemoryAccounting=true
		MemoryLimit=1G
		MemoryMax=1G
		MemorySwapMax=1M
	- For pinning runs on given CPU, I used 'taskset -c $cpunum command'
	- For restarting the memcg, it was used:
	restart_memcg(){
	  systemctl stop test.slice
	  systemctl daemon-reload
	  systemctl start test.slice
	}

2.2 - Impact on functions that use memcg_stock:
	2.2.1 - Approach: Using perf or tracepoints get a very course result, so
	it was preferred to count the total cpu clocks between entering and 
	exiting the functions that use the memcg_stock, on an isolated cpu. 
	Something like this was used on x86:

	fun_name(){
		u64 clk = rdtsc_ordered();
		... <function does it's job>
		clk = rdtsc_ordered() - clk;
		<percpu struct dbg>
		dbg->fun_name.cycles += clk;
		dbg->fun_name.count++;
	}
	
	The percpu statistics were then acquired via a char device after the 
	test finished, and an average function clock usage was calculated.

	For the stress test, run "cat /proc/interrupts > /dev/null" in a loop
	of 1000000 iterations inside the memcg for each cpu tested:
	for each cpu in $cpuset; do 
		systemd-run --wait --slice=test.slice taskset -c $cpu bash -c "
		for k in {1..100000} ; do 
		  cat /proc/interrupts > /dev/null;
		done"
		
	For the drain_all_stock() test, it was necessary to restart the memcg
	(or cause an OOM) to call the function.
	
	2.2.2 - Results
	For 1 isolated CPU, pinned on cpu 8, with no drain_all_stock() calls,
	being STDDEV the standard deviation between the average on 6 runs,
	and Call Count the sum of calls on the 6 runs:
	
	Patched			Average clk	STDDEV		Call Count
	consume_stock:		63.75983475	0.1610502136	72167768
	refill_stock:		67.45708322	0.09732816852	23401756
	mod_objcg_state:	98.03841384	1.491628532	181292961
	consume_obj_stock:	63.2543456	0.04624513799	94846454
	refill_obj_stock:	78.56390025	0.3160306174	91732973
			
	Upstream		Average clk	STDDEV		Call Count
	consume_stock:		53.51201046	0.05200824438	71.866536
	refill_stock:		65.46991584	0.1178078417	23401752
	mod_objcg_state:	84.95365055	1.371464414	181.292707
	consume_obj_stock:	60.03619438	0.05944582207	94.846327
	refill_obj_stock:	73.23757912	1.161933856	91.732787
			
	Patched - Upstream	Diff (cycles)	Diff %	
	consume_stock:		10.24782429	19.15051258	
	refill_stock:		1.987167378	3.035237411	
	mod_objcg_state:	13.08476328	15.40223781	
	consume_obj_stock:	3.218151217	5.360351785	
	refill_obj_stock:	5.326321123	7.272661368	
	
	So in average the above patched functions are 2~13 clocks cycles slower
	than upstream.
	
	On the other hand, drain_all_stock is faster on the patched version,
	even considering it does all the draining instead of scheduling the work
	to other CPUs:
	
	drain_all_stock
	cpus	Upstream 	Patched		Diff (cycles)	Diff(%)
	1	44331.10831	38978.03581	-5353.072507	-12.07520567
	8	43992.96512	39026.76654	-4966.198572	-11.2886198
	128	156274.6634	58053.87421	-98220.78915	-62.85138425
	
	(8 cpus being in the same NUMA node)
		
2.3 - Contention numbers
	2.3.1 - Approach
	On top of the patched version, I replaced the spin_lock_irqsave() on 
	functions that use the memcg_stock with	spin_lock_irqsave_cc(), which
	is defined as:
	
	#define spin_lock_irqsave_cc(l, flags)				\
		if (!spin_trylock_irqsave(l, flags)) {			\
	              	u64 clk = rdtsc_ordered();			\
        	      	spin_lock_irqsave(l, flags);			\
        	     	clk = rdtsc_ordered() - clk;			\
        	      	pr_err("mydebug: cpu %d hit contention :" 	\
        	      	" fun = %s, clk = %lld/n",			\
        	      	smp_processor_id(), __func__, clk);	\
      	}

	So in case of contention (try_lock failing) it would record an 
	approximate clk usage before getting the lock, and print this to dmesg.

	For the stress test, run "cat /proc/interrupts > /dev/null" in a loop
	of 1000000 iterations for each of the 128 cpus inside the memcg 
	(limit set to 20G):
	
	for each cpu in {1..128}; do 
		restart_memcg()
		systemd-run --wait --slice=test.slice taskset -c $cpu bash -c "
		for k in {1..100000} ; do 
		  cat /proc/interrupts > /dev/null;
		done"

	This loop was repeated for over 8 hours
	
	2.3.2- Results
	
	Function		# calls
	consume_stock:		15078323802
	refill_stock:		2495995683
	mod_objcg_state:	39765559905
	consume_obj_stock:	19882888224
	refill_obj_stock:	21025241793
	drain_all_stock:	592
	
	Contentions hit: 0
	
	(Other more aggressive synthetic tests were run, and even in this case
	contention was hit just a couple times over some hours.)
	
2.4 - Syscall time measure
	2.4.1- Approach
	To measure the patchset effect on syscall time, the following code was
	used: (copied/adapted from
 https://lore.kernel.org/linux-mm/20220924152227.819815-1-atomlin@redhat.com/ )
 
 	################
 	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/mman.h>
	#include <unistd.h>
	#include <string.h>

	typedef unsigned long long cycles_t;
	typedef unsigned long long usecs_t;
	typedef unsigned long long u64;

	#ifdef __x86_64__
	#define DECLARE_ARGS(val, low, high)    unsigned long low, high
	#define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
	#define EAX_EDX_ARGS(val, low, high)    "a" (low), "d" (high)
	#define EAX_EDX_RET(val, low, high)     "=a" (low), "=d" (high)
	#else
	#define DECLARE_ARGS(val, low, high)    unsigned long long val
	#define EAX_EDX_VAL(val, low, high)     (val)
	#define EAX_EDX_ARGS(val, low, high)    "A" (val)
	#define EAX_EDX_RET(val, low, high)     "=A" (val)
	#endif

	static inline unsigned long long __rdtscll(void)
	{
		DECLARE_ARGS(val, low, high);

		asm volatile("cpuid; rdtsc" : EAX_EDX_RET(val, low, high));

		return EAX_EDX_VAL(val, low, high);
	}

	#define rdtscll(val) do { (val) = __rdtscll(); } while (0)

	#define NRSYSCALLS 30000000
	#define NRSLEEPS   100000

	#define page_mmap()     mmap(NULL, 4096, PROT_READ|PROT_WRITE, \
			       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
	#define page_munmap(x)  munmap(x, 4096)

	void main(int argc, char *argv[])
	{
		unsigned long a, b, cycles;
		int i, syscall = 0;
		int *page;

		page = page_mmap();
		if (page == MAP_FAILED)
		        perror("mmap");

		if (page_munmap(page))
		        perror("munmap");

		if (argc != 2) {
		        printf("usage: %s {idle,syscall}\n", argv[0]);
		        exit(1);
		}

		rdtscll(a);

		if (strncmp("idle", argv[1], 4) == 0)
		        syscall = 0;
		else if (strncmp("syscall", argv[1], 7) == 0)
		        syscall = 1;
		else {
		      	printf("usage: %s {idle,syscall}\n", argv[0]);
		        exit(1);
		}

		if (syscall == 1) {
		        for (i = 0; i < NRSYSCALLS; i++) {
		                page = page_mmap();
		                if (page == MAP_FAILED)
		                        perror("mmap");

				#ifdef MY_WRITE
		                page[3] = i;
		                #endif

		                if (page_munmap(page))
		                        perror("munmap");
		        }
		} else {
		        for (i = 0; i < NRSLEEPS; i++)
		                usleep(10);
		}

		rdtscll(b);

		cycles = b - a;

		if (syscall == 1)
		        printf("cycles / syscall: %d\n", (b-a)/(NRSYSCALLS*2));
		else
		    	printf("cycles / idle loop: %d\n", (b-a)/NRSLEEPS);
	}
	################

	Running with ./my_test syscall will cause it to print the average clock
	cycles usage of the syscall pair (page_mmap() and page_munmap());
	
	It was compiled with two versions: With -DMY_WRITE and without it.
	The difference is writing to the allocated page, causing it to fault.
	
	Each version was run 200 times, pinned to an isolated cpu.
	Then an average and standard deviation was calculated on those results.

	2.4.2- Results
	Patched: no_write	write
	AVG	2991.195	5746.495
	STDEV	27.77488427	40.55878512
	STDEV %	0.9285547838	0.7058004073	
	
	Upstream: no_write	write
	AVG	3012.22		5749.605
	STDEV	25.1186451	37.26206223
	STDEV %	0.8338914522	0.6480803851

	Pat - Up: no_write	write
	Diff	-21.025		-3.11
	Diff %	-0.6979901866	-0.05409067232
	
	Meaning the pair page_mmap() + page_munmap() + pagefault runs a tiny bit
	faster on the patched version, compared to upstream.
	
3 - Discussion on results	
	On 2.2 we see every function that uses memcg_stock on local cpu gets a
	slower by some cycles on the patched version, while the function that
	accesses it remotely (drain_all_stock()) gets faster. The difference is
	more accentuated as we raise the cpu count, and consequently start
	dealing with sharing memory across NUMA.
	
	On 2.3 we see contention is not a big issue, as expected in 1.2.
	This probably happens due to the fact that drain_all_stock() runs quite
	rarely on normal operation, and the other functions are quite fast.
	
	On 2.4 we can see that page_mmap() + page_munmap() + pagefault ran 
	a tiny bit faster. This is probably due to the fact that
	drain_all_stock() does not schedule work on the running cpu, causing it
	not to get interrupted, and possibly making up for the increased time
	in local functions.
	
4- Conclusion
	Scheduling work on isolated cpus can be an issue for some workloads.
	Reducing the issue by replacing	the local_lock in memcg_stock with a
	spinlock should not cause much impact on performance.
	
Leonardo Bras (5):
  mm/memcontrol: Align percpu memcg_stock to cache
  mm/memcontrol: Change stock_lock type from local_lock_t to spinlock_t
  mm/memcontrol: Reorder memcg_stock_pcp members to avoid holes
  mm/memcontrol: Perform all stock drain in current CPU
  mm/memcontrol: Remove flags from memcg_stock_pcp

 mm/memcontrol.c | 75 ++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 44 deletions(-)

-- 
2.39.1

