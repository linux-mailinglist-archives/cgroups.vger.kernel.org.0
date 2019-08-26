Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB89D121
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHZNy6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 09:54:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727261AbfHZNy6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Aug 2019 09:54:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 572F8AD78;
        Mon, 26 Aug 2019 13:54:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DEBEE1E3DA1; Mon, 26 Aug 2019 15:54:52 +0200 (CEST)
Date:   Mon, 26 Aug 2019 15:54:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 5/5] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190826135452.GF10614@quack2.suse.cz>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
 <20190815195930.GF2263813@devbig004.ftw2.facebook.com>
 <20190821210235.GN2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821210235.GN2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 21-08-19 14:02:35, Tejun Heo wrote:
> There's an inherent mismatch between memcg and writeback.  The former
> trackes ownership per-page while the latter per-inode.  This was a
> deliberate design decision because honoring per-page ownership in the
> writeback path is complicated, may lead to higher CPU and IO overheads
> and deemed unnecessary given that write-sharing an inode across
> different cgroups isn't a common use-case.
> 
> Combined with inode majority-writer ownership switching, this works
> well enough in most cases but there are some pathological cases.  For
> example, let's say there are two cgroups A and B which keep writing to
> different but confined parts of the same inode.  B owns the inode and
> A's memory is limited far below B's.  A's dirty ratio can rise enough
> to trigger balance_dirty_pages() sleeps but B's can be low enough to
> avoid triggering background writeback.  A will be slowed down without
> a way to make writeback of the dirty pages happen.
> 
> This patch implements foreign dirty recording and foreign mechanism so
> that when a memcg encounters a condition as above it can trigger
> flushes on bdi_writebacks which can clean its pages.  Please see the
> comment on top of mem_cgroup_track_foreign_dirty_slowpath() for
> details.
> 
> A reproducer follows.
> 
> write-range.c::
> 
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <fcntl.h>
>   #include <sys/types.h>
> 
>   static const char *usage = "write-range FILE START SIZE\n";
> 
>   int main(int argc, char **argv)
>   {
> 	  int fd;
> 	  unsigned long start, size, end, pos;
> 	  char *endp;
> 	  char buf[4096];
> 
> 	  if (argc < 4) {
> 		  fprintf(stderr, usage);
> 		  return 1;
> 	  }
> 
> 	  fd = open(argv[1], O_WRONLY);
> 	  if (fd < 0) {
> 		  perror("open");
> 		  return 1;
> 	  }
> 
> 	  start = strtoul(argv[2], &endp, 0);
> 	  if (*endp != '\0') {
> 		  fprintf(stderr, usage);
> 		  return 1;
> 	  }
> 
> 	  size = strtoul(argv[3], &endp, 0);
> 	  if (*endp != '\0') {
> 		  fprintf(stderr, usage);
> 		  return 1;
> 	  }
> 
> 	  end = start + size;
> 
> 	  while (1) {
> 		  for (pos = start; pos < end; ) {
> 			  long bread, bwritten = 0;
> 
> 			  if (lseek(fd, pos, SEEK_SET) < 0) {
> 				  perror("lseek");
> 				  return 1;
> 			  }
> 
> 			  bread = read(0, buf, sizeof(buf) < end - pos ?
> 					       sizeof(buf) : end - pos);
> 			  if (bread < 0) {
> 				  perror("read");
> 				  return 1;
> 			  }
> 			  if (bread == 0)
> 				  return 0;
> 
> 			  while (bwritten < bread) {
> 				  long this;
> 
> 				  this = write(fd, buf + bwritten,
> 					       bread - bwritten);
> 				  if (this < 0) {
> 					  perror("write");
> 					  return 1;
> 				  }
> 
> 				  bwritten += this;
> 				  pos += bwritten;
> 			  }
> 		  }
> 	  }
>   }
> 
> repro.sh::
> 
>   #!/bin/bash
> 
>   set -e
>   set -x
> 
>   sysctl -w vm.dirty_expire_centisecs=300000
>   sysctl -w vm.dirty_writeback_centisecs=300000
>   sysctl -w vm.dirtytime_expire_seconds=300000
>   echo 3 > /proc/sys/vm/drop_caches
> 
>   TEST=/sys/fs/cgroup/test
>   A=$TEST/A
>   B=$TEST/B
> 
>   mkdir -p $A $B
>   echo "+memory +io" > $TEST/cgroup.subtree_control
>   echo $((1<<30)) > $A/memory.high
>   echo $((32<<30)) > $B/memory.high
> 
>   rm -f testfile
>   touch testfile
>   fallocate -l 4G testfile
> 
>   echo "Starting B"
> 
>   (echo $BASHPID > $B/cgroup.procs
>    pv -q --rate-limit 70M < /dev/urandom | ./write-range testfile $((2<<30)) $((2<<30))) &
> 
>   echo "Waiting 10s to ensure B claims the testfile inode"
>   sleep 5
>   sync
>   sleep 5
>   sync
>   echo "Starting A"
> 
>   (echo $BASHPID > $A/cgroup.procs
>    pv < /dev/urandom | ./write-range testfile 0 $((2<<30)))
> 
> v2: Added comments explaining why the specific intervals are being used.
> 
> v3: Use 0 @nr when calling cgroup_writeback_by_id() to use best-effort
>     flushing while avoding possible livelocks.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

The patch looks mostly good to me now. Just one thing:

> +void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
> +					     struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg = page->mem_cgroup;
> +	struct memcg_cgwb_frn *frn;
> +	u64 now = jiffies_64;

As I've checked, you should be using get_jiffies_64() to get value of
jiffies_64. Also for comparisons of jiffie values, I think you should be
using time_after64() and similar functions instead of direct comparisons...

								Honza

> +	u64 oldest_at = now;
> +	int oldest = -1;
> +	int i;
> +
> +	/*
> +	 * Pick the slot to use.  If there is already a slot for @wb, keep
> +	 * using it.  If not replace the oldest one which isn't being
> +	 * written out.
> +	 */
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		frn = &memcg->cgwb_frn[i];
> +		if (frn->bdi_id == wb->bdi->id &&
> +		    frn->memcg_id == wb->memcg_css->id)
> +			break;
> +		if (frn->at < oldest_at && atomic_read(&frn->done.cnt) == 1) {
> +			oldest = i;
> +			oldest_at = frn->at;
> +		}
> +	}
> +
> +	if (i < MEMCG_CGWB_FRN_CNT) {
> +		/*
> +		 * Re-using an existing one.  Update timestamp lazily to
> +		 * avoid making the cacheline hot.  We want them to be
> +		 * reasonably up-to-date and significantly shorter than
> +		 * dirty_expire_interval as that's what expires the record.
> +		 * Use the shorter of 1s and dirty_expire_interval / 8.
> +		 */
> +		unsigned long update_intv =
> +			min_t(unsigned long, HZ,
> +			      msecs_to_jiffies(dirty_expire_interval * 10) / 8);
> +
> +		if (frn->at < now - update_intv)
> +			frn->at = now;
> +	} else if (oldest >= 0) {
> +		/* replace the oldest free one */
> +		frn = &memcg->cgwb_frn[oldest];
> +		frn->bdi_id = wb->bdi->id;
> +		frn->memcg_id = wb->memcg_css->id;
> +		frn->at = now;
> +	}
> +}
> +
> +/* issue foreign writeback flushes for recorded foreign dirtying events */
> +void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
> +	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);
> +	u64 now = jiffies_64;
> +	int i;
> +
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
> +
> +		/*
> +		 * If the record is older than dirty_expire_interval,
> +		 * writeback on it has already started.  No need to kick it
> +		 * off again.  Also, don't start a new one if there's
> +		 * already one in flight.
> +		 */
> +		if (frn->at > now - intv && atomic_read(&frn->done.cnt) == 1) {
> +			frn->at = 0;
> +			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id, 0,
> +					       WB_REASON_FOREIGN_FLUSH,
> +					       &frn->done);
> +		}
> +	}
> +}
> +
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>  
>  static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
> @@ -4700,6 +4823,7 @@ static struct mem_cgroup *mem_cgroup_all
>  	struct mem_cgroup *memcg;
>  	unsigned int size;
>  	int node;
> +	int __maybe_unused i;
>  
>  	size = sizeof(struct mem_cgroup);
>  	size += nr_node_ids * sizeof(struct mem_cgroup_per_node *);
> @@ -4743,6 +4867,9 @@ static struct mem_cgroup *mem_cgroup_all
>  #endif
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	INIT_LIST_HEAD(&memcg->cgwb_list);
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> +		memcg->cgwb_frn[i].done =
> +			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
>  #endif
>  	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
>  	return memcg;
> @@ -4872,7 +4999,12 @@ static void mem_cgroup_css_released(stru
>  static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	int __maybe_unused i;
>  
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> +		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> +#endif
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
>  		static_branch_dec(&memcg_sockets_enabled_key);
>  
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1667,6 +1667,8 @@ static void balance_dirty_pages(struct b
>  		if (unlikely(!writeback_in_progress(wb)))
>  			wb_start_background_writeback(wb);
>  
> +		mem_cgroup_flush_foreign(wb);
> +
>  		/*
>  		 * Calculate global domain's pos_ratio and select the
>  		 * global dtc by default.
> @@ -2427,6 +2429,8 @@ void account_page_dirtied(struct page *p
>  		task_io_account_write(PAGE_SIZE);
>  		current->nr_dirtied++;
>  		this_cpu_inc(bdp_ratelimits);
> +
> +		mem_cgroup_track_foreign_dirty(page, wb);
>  	}
>  }
>  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
