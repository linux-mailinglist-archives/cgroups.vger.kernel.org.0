Return-Path: <cgroups+bounces-15960-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE3PARrOBmpjoAIAu9opvQ
	(envelope-from <cgroups+bounces-15960-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 09:41:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5854ABD1
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D43C306D142
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74113F0A97;
	Fri, 15 May 2026 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bpAixRwG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE873EF655
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830677; cv=none; b=tbO8COunR6uV/FRAH0ULkIQ4IyvS7y2LCD7KH7WE12IcB2nlkiskePgU+iVB5LXHHVhQCaB3gdx584P2MD40R6kzJFBW72F1vuSSLLQ+IB8SJrAYprYfeAI5A7PZJze12LyrfZA+A9ybcuiUkkCEn5wBeuOoBGfKYzAvXiVGNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830677; c=relaxed/simple;
	bh=/zszxV63yQl9QS3gAn9zgd8eqQk4e2vU9TQYrE07AnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6eWnUghm8RgBISwU2yP7q1x/L6D9KCfo0TTjMeIjaS3fatjXWQjN3Q8uJxKqo4aMM6NNmwr2enZHW5O8qpy7wFYtYm3YdA78nE4pOxqxRp7ONR4vi4FOa9z6VzcmAbZ3O1m5MT20oC8DjG8GxkJR+4C9pllqpEBfYjMXeZCEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bpAixRwG; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778830659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOY+UfSbkiURn5lqdu1cK6qgeFPXa2eCUvtmnbh0Ojs=;
	b=bpAixRwGvXoQTfc+K7SEOUIT6mL7vMSosBRb3K7wqeEgFX6n+1naKwV2b8/aJfRc9ijYYp
	WYKyV7NF77J5eXZp7BkCE+/8xVzVLwMvNJ0h6DzvdFTW7cfLun6fUY6orOYyQYnEsAIghp
	aDgytDTXNco0RzPcGPODh8atTZqYc9s=
Date: Fri, 15 May 2026 15:37:22 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
To: Shakeel Butt <shakeel.butt@linux.dev>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, David Carlier
 <devnexen@gmail.com>, Allen Pais <apais@linux.microsoft.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Baoquan He <bhe@redhat.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, David Hildenbrand <david@kernel.org>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 Imran Khan <imran.f.khan@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Lance Yang <lance.yang@linux.dev>, Liam Howlett <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Muchun Song <songmuchun@bytedance.com>, Nhat Pham <nphamcs@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
 Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <202605121641.b6a60cb0-lkp@intel.com> <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev> <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev> <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 72B5854ABD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15960-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,linux.dev,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Shakeel,

On 5/14/26 9:40 PM, Shakeel Butt wrote:
> May 14, 2026 at 12:46 AM, "Qi Zheng" <qi.zheng@linux.dev mailto:qi.zheng@linux.dev?to=%22Qi%20Zheng%22%20%3Cqi.zheng%40linux.dev%3E > wrote:
> 
> 
>>
>> On 5/13/26 10:27 PM, Shakeel Butt wrote:
>>
>>>
>>> On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
>>>
>>>>
>>>> On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
>>>>
>>>   On 5/13/26 12:03 AM, Shakeel Butt wrote:
>>>   On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
>>>
>>>   Hello,
>>>
>>>   kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
>>>
>>>   commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
>>>   https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>>   This is most probably due to shuffling of struct mem_cgroup and struct
>>>   mem_cgroup_per_node members.
>>>
>>>   Another possibility is that after objcg was split into per-node, the
>>>   slab accounting fast path is still designed assuming only one current
>>>   objcg per CPU:
>>>
>>>   struct obj_stock_pcp {
>>>   struct obj_cgroup *cached_objcg;
>>>   };
>>>
>>>   So it's may cause the following thrashing:
>>>
>>>   CPU stock cached = memcg/node0 objcg
>>>   free object tagged = memcg/node1 objcg
>>>   => __refill_obj_stock --> objcg mismatch
>>>   => drain_obj_stock()
>>>   => cache switches to node1 objcg
>>>
>>>   next local allocation tagged = node0 objcg
>>>   => mismatch again
>>>   => drain_obj_stock()
>>>
>>>>
>>>> Actually I think this is the issue, we have ping pong threads running on
>>>>   different nodes where though theu are in same cgroup but their current->obcg is
>>>>   for local node and thus this ping pong is thrashing the per-cpu objcg stock.
>>>>
>>>>   The easier fix would be to compare objcg->memcg instead of just objcg during
>>>>   draining and caching. In addition we can add support for multiple objcg per-cpu
>>>>   stock caching.
>>>>
>>>   Something like the following:
>>>   From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 2001
>>>   From: Shakeel Butt <shakeel.butt@linux.dev>
>>>   Date: Wed, 13 May 2026 07:24:55 -0700
>>>   Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled objcg
>>>   shares memcg
>>>   Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>   ---
>>>   mm/memcontrol.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>   diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>   index d978e18b9b2d..01ed7a8e18ac 100644
>>>   --- a/mm/memcontrol.c
>>>   +++ b/mm/memcontrol.c
>>>   @@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>>>   unsigned int nr_bytes,
>>>   bool allow_uncharge)
>>>   {
>>>   + struct obj_cgroup *cached;
>>>   unsigned int nr_pages = 0;
>>>   > if (!stock) {
>>>   @@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>>>   goto out;
>>>   }
>>>   > - if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
>>>   + cached = READ_ONCE(stock->cached_objcg);
>>>   + if (cached != objcg &&
>>>   + (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
>>>   drain_obj_stock(stock);
>>>   obj_cgroup_get(objcg);
>>>   stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>>>
>> This change looks like it should be able to fix the ping-pong issue, but
>> I stiil haven't reproduced the performance regression locally. I'll
>> continue testing it.
> 
> Same here, couldn't reproduce locally. It seems like we had to craft a scenario
> where the pair pingpong threads get their current->objcg from different nodes.
> I will try that.

I still haven't been able to reproduce the LKP results locally, but I
used an AI bot to generate a pingpong test case (pasted at the end) and
automatically ran the test on a physical machine. The results are as
follows:

   parent: 8285917d6f
   bad:    01b9da291c
   fix:    01b9da291c + stock patch

   | kernel | mq_ops/sec mean | vs parent | drain_obj_stock / round |
   |--------|-----------------|-----------|-------------------------|
   | parent |     9.743M      |  baseline |          ~0             |
   | bad    |     7.821M      |  -19.73%  |          ~11.16M        |
   | fix    |     9.274M      |  -4.81%   |          ~0             |

Probing the drain_obj_stock() calls confirms that the fix restores the
frequency to the parent's baseline.

And it seems that besides __refill_obj_stock(), we should also modify
__consume_obj_stock()?

Thanks,
Qi




=========
test case
=========

objcg_pingpong_mq.c
-------------------

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <mqueue.h>
#include <pthread.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

#ifndef SYS_mq_timedsend
#define SYS_mq_timedsend __NR_mq_timedsend
#endif
#ifndef SYS_mq_timedreceive
#define SYS_mq_timedreceive __NR_mq_timedreceive
#endif

struct worker_arg {
	mqd_t send_mqd;
	mqd_t recv_mqd;
	int cpu;
	long count;
	size_t msg_size;
	int send_first;
};

static pthread_barrier_t start_barrier;

static void die(const char *what)
{
	fprintf(stderr, "%s: %s\n", what, strerror(errno));
	exit(1);
}

static int add_cpu(int **cpus, size_t *nr, size_t *cap, int cpu)
{
	int *tmp;

	if (*nr == *cap) {
		size_t new_cap = *cap ? *cap * 2 : 64;

		tmp = realloc(*cpus, new_cap * sizeof(**cpus));
		if (!tmp)
			return -1;
		*cpus = tmp;
		*cap = new_cap;
	}

	(*cpus)[(*nr)++] = cpu;
	return 0;
}

static int read_cpulist(const char *path, int **cpus, size_t *nr)
{
	char buf[4096];
	char *p, *end;
	size_t cap = 0;
	int fd;
	ssize_t len;

	*cpus = NULL;
	*nr = 0;

	fd = open(path, O_RDONLY | O_CLOEXEC);
	if (fd < 0)
		return -1;

	len = read(fd, buf, sizeof(buf) - 1);
	close(fd);
	if (len <= 0)
		return -1;
	buf[len] = '\0';

	p = buf;
	while (*p) {
		long first, last, cpu;

		while (*p == ',' || *p == '\n' || *p == '\t' || *p == ' ')
			p++;
		if (!*p)
			break;

		errno = 0;
		first = strtol(p, &end, 10);
		if (errno || end == p)
			return -1;
		p = end;
		last = first;

		if (*p == '-') {
			p++;
			errno = 0;
			last = strtol(p, &end, 10);
			if (errno || end == p || last < first)
				return -1;
			p = end;
		}

		for (cpu = first; cpu <= last; cpu++) {
			if (add_cpu(cpus, nr, &cap, (int)cpu))
				return -1;
		}
	}

	return *nr ? 0 : -1;
}

static long read_cmdline_long(const char *key, long fallback)
{
	char buf[4096];
	char *p, *end;
	int fd;
	ssize_t len;
	size_t key_len = strlen(key);
	long val;

	fd = open("/proc/cmdline", O_RDONLY | O_CLOEXEC);
	if (fd < 0)
		return fallback;

	len = read(fd, buf, sizeof(buf) - 1);
	close(fd);
	if (len <= 0)
		return fallback;
	buf[len] = '\0';

	p = buf;
	while ((p = strstr(p, key))) {
		if ((p == buf || p[-1] == ' ') && p[key_len] == '=') {
			val = strtol(p + key_len + 1, &end, 10);
			if (end != p + key_len + 1 && val >= 0)
				return val;
		}
		p += key_len;
	}

	return fallback;
}

static void pin_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	if (sched_setaffinity(0, sizeof(set), &set)) {
		fprintf(stderr, "sched_setaffinity(%d): %s\n", cpu,
			strerror(errno));
		exit(2);
	}
}

static void *worker(void *data)
{
	struct worker_arg *arg = data;
	char *msg;
	long i;

	msg = malloc(arg->msg_size);
	if (!msg)
		die("malloc msg");
	memset(msg, 0x5a, arg->msg_size);

	pin_cpu(arg->cpu);
	pthread_barrier_wait(&start_barrier);

	for (i = 0; i < arg->count; i++) {
		int ret[2];

		if (arg->send_first) {
			ret[0] = syscall(SYS_mq_timedsend, arg->send_mqd, msg,
					 arg->msg_size, 0, NULL);
			ret[1] = syscall(SYS_mq_timedreceive, arg->recv_mqd,
					 msg, arg->msg_size, NULL, NULL);
		} else {
			ret[0] = syscall(SYS_mq_timedreceive, arg->recv_mqd,
					 msg, arg->msg_size, NULL, NULL);
			ret[1] = syscall(SYS_mq_timedsend, arg->send_mqd, msg,
					 arg->msg_size, 0, NULL);
		}
		if (ret[0] < 0 || ret[1] < 0) {
			fprintf(stderr, "mq failed cpu=%d iter=%ld: %s\n",
				arg->cpu, i, strerror(errno));
			exit(3);
		}
	}

	free(msg);
	return NULL;
}

static double nsec_diff(struct timespec a, struct timespec b)
{
	return (double)(b.tv_sec - a.tv_sec) * 1000000000.0 +
	       (double)(b.tv_nsec - a.tv_nsec);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [-p pairs] [-n iterations] [-s msg_size]\n",
		prog);
}

int main(int argc, char **argv)
{
	long count = read_cmdline_long("pp_count", 100000);
	long pairs = read_cmdline_long("pp_pairs", 0);
	long msg_size_arg = read_cmdline_long("pp_size", 64);
	struct mq_attr attr = {
		.mq_flags = 0,
		.mq_maxmsg = 1,
		.mq_msgsize = 64,
		.mq_curmsgs = 0,
	};
	struct rusage ru;
	pthread_t *threads;
	struct worker_arg *args;
	struct timespec start, end;
	int *node0_cpus, *node1_cpus;
	size_t node0_nr, node1_nr;
	long messages, mq_syscalls;
	int opt, i;

	while ((opt = getopt(argc, argv, "p:n:s:h")) != -1) {
		switch (opt) {
		case 'p':
			pairs = atol(optarg);
			break;
		case 'n':
			count = atol(optarg);
			break;
		case 's':
			msg_size_arg = atol(optarg);
			break;
		default:
			usage(argv[0]);
			return opt == 'h' ? 0 : 1;
		}
	}

	if (count <= 0)
		count = 100000;
	if (msg_size_arg <= 0)
		msg_size_arg = 64;
	if (msg_size_arg > 65536) {
		fprintf(stderr, "msg_size too large: %ld\n", msg_size_arg);
		return 1;
	}
	attr.mq_msgsize = msg_size_arg;

	if (read_cpulist("/sys/devices/system/node/node0/cpulist",
			 &node0_cpus, &node0_nr) ||
	    read_cpulist("/sys/devices/system/node/node1/cpulist",
			 &node1_cpus, &node1_nr)) {
		fprintf(stderr, "need at least two NUMA nodes with cpulist files\n");
		return 1;
	}

	if (pairs <= 0 || pairs > (long)node0_nr || pairs > (long)node1_nr)
		pairs = node0_nr < node1_nr ? (long)node0_nr : (long)node1_nr;
	if (pairs <= 0) {
		fprintf(stderr, "no CPU pairs available\n");
		return 1;
	}

	threads = calloc(pairs * 2, sizeof(*threads));
	args = calloc(pairs * 2, sizeof(*args));
	if (!threads || !args)
		die("calloc");

	printf("CONFIG pairs=%ld count=%ld msg_size=%ld node0_cpus=%zu 
node1_cpus=%zu\n",
	       pairs, count, msg_size_arg, node0_nr, node1_nr);
	printf("CPUS first=%d:%d last=%d:%d\n",
	       node0_cpus[0], node1_cpus[0],
	       node0_cpus[pairs - 1], node1_cpus[pairs - 1]);
	fflush(stdout);

	pthread_barrier_init(&start_barrier, NULL, pairs * 2 + 1);

	for (i = 0; i < pairs; i++) {
		char name_ab[64], name_ba[64];
		mqd_t mqd_ab, mqd_ba;

		snprintf(name_ab, sizeof(name_ab), "/objcg_pp_ab_%d_%ld", i,
			 (long)getpid());
		snprintf(name_ba, sizeof(name_ba), "/objcg_pp_ba_%d_%ld", i,
			 (long)getpid());
		mq_unlink(name_ab);
		mq_unlink(name_ba);
		mqd_ab = mq_open(name_ab, O_CREAT | O_RDWR, 0600, &attr);
		mqd_ba = mq_open(name_ba, O_CREAT | O_RDWR, 0600, &attr);
		if (mqd_ab == (mqd_t)-1 || mqd_ba == (mqd_t)-1)
			die("mq_open");
		mq_unlink(name_ab);
		mq_unlink(name_ba);

		args[i * 2] = (struct worker_arg) {
			.send_mqd = mqd_ab,
			.recv_mqd = mqd_ba,
			.cpu = node0_cpus[i],
			.count = count,
			.msg_size = msg_size_arg,
			.send_first = 1,
		};
		args[i * 2 + 1] = (struct worker_arg) {
			.send_mqd = mqd_ba,
			.recv_mqd = mqd_ab,
			.cpu = node1_cpus[i],
			.count = count,
			.msg_size = msg_size_arg,
			.send_first = 0,
		};

		if (pthread_create(&threads[i * 2], NULL, worker,
				   &args[i * 2]))
			die("pthread_create");
		if (pthread_create(&threads[i * 2 + 1], NULL, worker,
				   &args[i * 2 + 1]))
			die("pthread_create");
	}

	clock_gettime(CLOCK_MONOTONIC, &start);
	pthread_barrier_wait(&start_barrier);

	for (i = 0; i < pairs * 2; i++)
		pthread_join(threads[i], NULL);

	clock_gettime(CLOCK_MONOTONIC, &end);
	getrusage(RUSAGE_SELF, &ru);

	messages = count * pairs * 2;
	mq_syscalls = messages * 2;
	printf("RESULT pairs=%ld messages=%ld mq_syscalls=%ld seconds=%.6f 
msg_per_sec=%.0f mq_ops_per_sec=%.0f user_sec=%.6f system_sec=%.6f 
voluntary_cs=%ld involuntary_cs=%ld\n",
	       pairs, messages, mq_syscalls, nsec_diff(start, end) / 1000000000.0,
	       (double)messages * 1000000000.0 / nsec_diff(start, end),
	       (double)mq_syscalls * 1000000000.0 / nsec_diff(start, end),
	       (double)ru.ru_utime.tv_sec + (double)ru.ru_utime.tv_usec / 
1000000.0,
	       (double)ru.ru_stime.tv_sec + (double)ru.ru_stime.tv_usec / 
1000000.0,
	       ru.ru_nvcsw, ru.ru_nivcsw);

	return 0;
}

objcg_stock_probe.c
-------------------

#include <linux/atomic.h>
#include <linux/init.h>
#include <linux/kprobes.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/uaccess.h>

static atomic64_t drain_hits;
static atomic64_t refill_hits;
static atomic64_t post_alloc_hits;
static atomic64_t free_hits;

static int drain_pre(struct kprobe *kp, struct pt_regs *regs)
{
	atomic64_inc(&drain_hits);
	return 0;
}

static int refill_pre(struct kprobe *kp, struct pt_regs *regs)
{
	atomic64_inc(&refill_hits);
	return 0;
}

static int post_alloc_pre(struct kprobe *kp, struct pt_regs *regs)
{
	atomic64_inc(&post_alloc_hits);
	return 0;
}

static int free_pre(struct kprobe *kp, struct pt_regs *regs)
{
	atomic64_inc(&free_hits);
	return 0;
}

static struct kprobe probes[] = {
	{
		.symbol_name = "drain_obj_stock",
		.pre_handler = drain_pre,
	},
	{
		.symbol_name = "__refill_obj_stock",
		.pre_handler = refill_pre,
	},
	{
		.symbol_name = "__memcg_slab_post_alloc_hook",
		.pre_handler = post_alloc_pre,
	},
	{
		.symbol_name = "__memcg_slab_free_hook",
		.pre_handler = free_pre,
	},
};

static struct kprobe *probe_ptrs[] = {
	&probes[0],
	&probes[1],
	&probes[2],
	&probes[3],
};

static void reset_counts(void)
{
	atomic64_set(&drain_hits, 0);
	atomic64_set(&refill_hits, 0);
	atomic64_set(&post_alloc_hits, 0);
	atomic64_set(&free_hits, 0);
}

static int counts_show(struct seq_file *m, void *v)
{
	seq_printf(m, "drain_obj_stock=%lld\n",
		   atomic64_read(&drain_hits));
	seq_printf(m, "__refill_obj_stock=%lld\n",
		   atomic64_read(&refill_hits));
	seq_printf(m, "__memcg_slab_post_alloc_hook=%lld\n",
		   atomic64_read(&post_alloc_hits));
	seq_printf(m, "__memcg_slab_free_hook=%lld\n",
		   atomic64_read(&free_hits));
	return 0;
}

static int counts_open(struct inode *inode, struct file *file)
{
	return single_open(file, counts_show, NULL);
}

static ssize_t counts_write(struct file *file, const char __user *buf,
			    size_t count, loff_t *ppos)
{
	reset_counts();
	return count;
}

static const struct proc_ops counts_fops = {
	.proc_open = counts_open,
	.proc_read = seq_read,
	.proc_lseek = seq_lseek,
	.proc_release = single_release,
	.proc_write = counts_write,
};

static int __init objcg_stock_probe_init(void)
{
	int ret;

	reset_counts();
	ret = register_kprobes(probe_ptrs, ARRAY_SIZE(probe_ptrs));
	if (ret)
		return ret;
	if (!proc_create("objcg_stock_probe", 0600, NULL, &counts_fops)) {
		unregister_kprobes(probe_ptrs, ARRAY_SIZE(probe_ptrs));
		return -ENOMEM;
	}
	return 0;
}

static void __exit objcg_stock_probe_exit(void)
{
	remove_proc_entry("objcg_stock_probe", NULL);
	unregister_kprobes(probe_ptrs, ARRAY_SIZE(probe_ptrs));
}

module_init(objcg_stock_probe_init);
module_exit(objcg_stock_probe_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Count memcg obj stock kprobe hits for ping-pong tests");






