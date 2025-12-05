Return-Path: <cgroups+bounces-12280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8094CA904D
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3633531D4118
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A2379B0F;
	Fri,  5 Dec 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgv+qnvZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F78379AEB
	for <cgroups@vger.kernel.org>; Fri,  5 Dec 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960739; cv=none; b=uygvnAe4J9l3Emr7ttLhiDeVXbgtOAkE1ENQh7D5VTIbWLxIL6AjzEsmUIJ9nt9qVwkHOcoH5yP3ghaN9UYCxbnSpy0NqGbVs7XirnU9pfyfHYc7sMvsIlEccWWJTGqdYerAnJbQSkuXuNRI7O2a8l0XIdUj0itsjo5XepeNDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960739; c=relaxed/simple;
	bh=uROwvKViFwJe9fH0WxSg1ug9woAjFYqviaXpUsmirsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn57+u8MN4YBidxFbXE+GWcZ9DrDE5gGBnMynUlGWu+nWh+RBs4afcs563iEHmeQbbLSW5KryU0MaxishfJTi4gDyRfs3p0tFl1zxHDof70KUZCFlL6DnHsxAG9rH+NKjFxWLH+7UyZHNw3vbb57xpSAiwA57ecT7PI4uavZFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgv+qnvZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Dec 2025 10:51:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764960725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwB4FIQ4wqkM4BN5rZZX2NVwtIL9s/PS1C1n75qh8Bo=;
	b=fgv+qnvZUf7HgDmod9GHbk7XDp+rCy+g3fOfQemdK4rVAfeO9zKwiz2WpvxvrLdQBmVLYc
	diSWUc68PGyWCqzvWBAQcm3mxH+g40438S3BSPYD4bW99ZNy4R6BxIQRNeFX8qyn6MJVhj
	vhIyoJQCAG/vrVzS00o7tt0QhfjJFZs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Message-ID: <efiagdwmzfwpdzps74fvcwq3n4cs36q33ij7eebcpssactv3zu@se4hqiwxcfxq>
References: <20251205022437.1743547-1-shakeel.butt@linux.dev>
 <aTMX4tycdzKlaqaH@slm.duckdns.org>
 <5i4ei2rbszdwlezpi63h5ksmckry27ffx6kfcg74qbvgjk22ao@2y2jeadg43y3>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5i4ei2rbszdwlezpi63h5ksmckry27ffx6kfcg74qbvgjk22ao@2y2jeadg43y3>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 05, 2025 at 09:59:39AM -0800, Shakeel Butt wrote:
> On Fri, Dec 05, 2025 at 07:35:30AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Dec 04, 2025 at 06:24:37PM -0800, Shakeel Butt wrote:
> > ...
> > > In Meta's fleet running the kernel with the commit 36df6e3dbd7e, we are
> > > observing on some machines the memcg stats are getting skewed by more
> > > than the actual memory on the system. On close inspection, we noticed
> > > that lockless node for a workload for specific CPU was in the bad state
> > > and thus all the updates on that CPU for that cgroup was being lost. At
> > > the moment, we are not sure if this CMPXCHG without LOCK is the cause of
> > > that but this needs to be fixed irrespective.
> > 
> > Is there a plausible theory of events that can explain the skew with the use
> > of this_cpu_cmpxchg()? lnode.next being set to self but this_cpu_cmpxchg()
> > returning something else? It may be useful to write a targeted repro for the
> > particular combination - this_cpu_cmpxchg() vs. remote NULL clearing and see
> > whether this_cpu_cmpxchg() can return a value that doesn't agree with what
> > gets written in the memory.
> 
> Yes, I am working on creating a repro for this and will share the
> results.
> 

I think I found the repro pasted below and can be built using following
command:

 $ gcc -O2 -pthread -o cmpxchg_race cmpxchg_race.c
 $ cat cmpxchg_race.c


#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <unistd.h>
#include <stdbool.h>
#include <sched.h>
#include <string.h>

// Kernel-style macros adapted for user-space
#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
#define WRITE_ONCE(x, val) do { *(volatile typeof(x) *)&(x) = (val); } while (0)

// Simple llist implementation - EXACT KERNEL DEFINITIONS
struct llist_node {
    struct llist_node *next;
};

struct llist_head {
    struct llist_node *first;
};

// smp_load_acquire - load with acquire semantics
#define smp_load_acquire(p)                     \
({                                              \
    typeof(*p) ___p1 = READ_ONCE(*p);          \
    __atomic_thread_fence(__ATOMIC_ACQUIRE);    \
    ___p1;                                      \
})

// try_cmpxchg - compare and exchange, updates old value on failure
static inline bool try_cmpxchg(struct llist_node **ptr, struct llist_node **old, struct llist_node *new)
{
    typeof(*ptr) __old = *old;
    typeof(*ptr) __ret;

    asm volatile("lock cmpxchgq %2, %1"
                 : "=a" (__ret), "+m" (*ptr)
                 : "r" (new), "0" (__old)
                 : "memory");

    if (__ret == __old)
        return true;

    *old = __ret;
    return false;
}

/**
 * init_llist_node - initialize lock-less list node
 * From: include/linux/llist.h:84-87
 */
static inline void init_llist_node(struct llist_node *node)
{
    node->next = node;
}

/**
 * llist_on_list - test if a lock-list list node is on a list
 * From: include/linux/llist.h:98-101
 */
static inline bool llist_on_list(const struct llist_node *node)
{
    return node->next != node;
}

/**
 * llist_add_batch - add several linked entries in batch
 * From: include/linux/llist.h:234-245
 */
static inline bool llist_add_batch(struct llist_node *new_first,
                   struct llist_node *new_last,
                   struct llist_head *head)
{
    struct llist_node *first = READ_ONCE(head->first);

    do {
        new_last->next = first;
    } while (!try_cmpxchg(&head->first, &first, new_first));

    return !first;
}

/**
 * llist_add - add a new entry
 * From: include/linux/llist.h:263-266
 */
static inline bool llist_add(struct llist_node *new, struct llist_head *head)
{
    return llist_add_batch(new, new, head);
}

/**
 * llist_del_first - delete the first entry of lock-less list
 * From: lib/llist.c:31-43
 */
struct llist_node *llist_del_first(struct llist_head *head)
{
    struct llist_node *entry, *next;

    entry = smp_load_acquire(&head->first);
    do {
        if (entry == NULL)
            return NULL;
        next = READ_ONCE(entry->next);
    } while (!try_cmpxchg(&head->first, &entry, next));

    return entry;
}

/**
 * llist_del_first_init - delete first entry and mark as off-list
 * From: include/linux/llist.h:303-310
 */
static inline struct llist_node *llist_del_first_init(struct llist_head *head)
{
    struct llist_node *n = llist_del_first(head);

    if (n)
        init_llist_node(n);
    return n;
}

// Global list and node
struct llist_head global_list = { .first = NULL };
struct llist_node node_self;

volatile bool stop = false;
volatile uint64_t success_count = 0;
volatile uint64_t already_count = 0;
volatile uint64_t del_count = 0;
volatile uint64_t empty_count = 0;

bool use_locked_cmpxchg = false;

// CMPXCHG without LOCK
static inline bool cmpxchg_unlocked(struct llist_node **ptr, struct llist_node *old, struct llist_node *new_val)
{
    struct llist_node *prev = old;
    asm volatile(
        "cmpxchgq %2, %1"  // No lock prefix!
        : "+a" (prev), "+m" (*ptr)
        : "r" (new_val)
        : "memory"
    );
    return prev == old;
}

// CMPXCHG with LOCK
static inline bool cmpxchg_locked(struct llist_node **ptr, struct llist_node *old, struct llist_node *new_val)
{
    struct llist_node *prev = old;
    asm volatile(
        "lock cmpxchgq %2, %1"  // WITH lock prefix!
        : "+a" (prev), "+m" (*ptr)
        : "r" (new_val)
        : "memory"
    );
    return prev == old;
}

// Check if node is in the list
bool is_node_in_list(struct llist_head *head, struct llist_node *node)
{
    struct llist_node *curr = READ_ONCE(head->first);
    while (curr) {
        if (curr == node)
            return true;
        curr = READ_ONCE(curr->next);
    }
    return false;
}

// Thread 1: Simulates css_rstat_updated()
void *thread_cmpxchg(void *arg)
{
    printf("Thread 1 (UPDATER): using %s CMPXCHG\n",
           use_locked_cmpxchg ? "LOCKED" : "UNLOCKED");

    while (!stop) {
        // Try to atomically change from self to NULL (win the race)
        bool success;
        if (use_locked_cmpxchg) {
            success = cmpxchg_locked(&node_self.next, &node_self, NULL);
        } else {
            success = cmpxchg_unlocked(&node_self.next, &node_self, NULL);
        }

        if (success) {
            // We won! Add to the global list
            llist_add(&node_self, &global_list);
            success_count++;
        } else {
            already_count++;
        }
    }
    return NULL;
}

// Thread 2: Simulates css_process_update_tree() -> llist_del_first_init()
void *thread_write(void *arg)
{
    printf("Thread 2 (FLUSHER): doing llist_del_first_init\n");

    while (!stop) {
        // Remove first node from list and reinitialize it (sets next = self)
        struct llist_node *node = llist_del_first_init(&global_list);
        if (node) {
            del_count++;
        } else {
	    empty_count++;
	}
    }
    return NULL;
}

void run_test(bool use_lock, int duration)
{
    pthread_t t1, t2;

    use_locked_cmpxchg = use_lock;
    stop = false;
    success_count = 0;
    del_count = 0;
    empty_count = 0;
    already_count = 0;

    // Initialize: node_self.next = self (not on list)
    init_llist_node(&node_self);
    global_list.first = NULL;

    printf("\n=== Running test with %s CMPXCHG for %d seconds ===\n",
           use_lock ? "LOCKED" : "UNLOCKED", duration);

    pthread_create(&t1, NULL, thread_cmpxchg, NULL);
    pthread_create(&t2, NULL, thread_write, NULL);

    sleep(duration);
    stop = true;

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    // Check final state
    struct llist_node *next = READ_ONCE(node_self.next);
    bool on_list = is_node_in_list(&global_list, &node_self);

    printf("\n=== Results (%s CMPXCHG) ===\n", use_lock ? "LOCKED" : "UNLOCKED");
    printf("Successful cmpxchg: %lu\n", success_count);
    printf("Already on list:    %lu\n", already_count);
    printf("Deletions:          %lu\n", del_count);
    printf("Empty list:         %lu\n", empty_count);
    printf("\nFinal state:\n");
    printf("  node_self.next:   %s\n",
           next == NULL ? "NULL" : (next == &node_self ? "self" : "OTHER"));
    printf("  On global list:   %s\n", on_list ? "YES" : "NO");

    // Check for failure condition
    bool failed = false;

    if (next == NULL && !on_list) {
        printf("\n*** FAILURE DETECTED! ***\n");
        printf("node_self.next is NULL but node is NOT on the list!\n");
        printf("This means we 'won' the cmpxchg race but lost the update.\n");
        failed = true;
    } else if (next == &node_self && !on_list) {
        printf("\n✓ OK: node_self.next is self and not on list (expected state)\n");
    } else if (next == NULL && on_list) {
        printf("\n✓ OK: node_self.next is NULL and on list (expected state)\n");
    } else if (on_list) {
        printf("\n✓ OK: node is on list\n");
    } else {
        printf("\n✓ OK: consistent state\n");
    }

    if (failed) {
        printf("\nThis demonstrates the race condition where:\n");
        printf("1. Thread 1 does unlocked cmpxchg(node_self.next, self, NULL) → succeeds\n");
        printf("2. Thread 2 does init_llist_node() → writes node_self.next = self\n");
        printf("3. Thread 1 thinks it won but the write from Thread 2 was lost\n");
        printf("4. Thread 1 adds node to list\n");
        printf("5. Thread 2 removes node and does init_llist_node() again\n");
        printf("6. Final state: next=NULL but not on list (INCONSISTENT!)\n");
    }
}

int main(int argc, char *argv[])
{
    int duration = argc > 1 ? atoi(argv[1]) : 3;

    printf("=== Simulating css_rstat_updated() Race Condition ===\n");
    printf("Using EXACT kernel llist implementations from:\n");
    printf("  - include/linux/llist.h (init_llist_node, llist_on_list, llist_add)\n");
    printf("  - lib/llist.c (llist_del_first)\n");
    printf("\n");
    printf("This emulates the exact kernel scenario:\n");
    printf("  Thread 1: css_rstat_updated() - cmpxchg + llist_add\n");
    printf("  Thread 2: css_process_update_tree() - llist_del_first_init\n");
    printf("\n");

    // Run with unlocked CMPXCHG (the bug)
    run_test(false, duration);

    printf("\n");
    printf("========================================\n");

    // Run with locked CMPXCHG (the fix)
    run_test(true, duration);

    return 0;
}


