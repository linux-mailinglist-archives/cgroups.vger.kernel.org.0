Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97201125D34
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 10:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLSJEl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 19 Dec 2019 04:04:41 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38427 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbfLSJEl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 04:04:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TlL37Kz_1576746267;
Received: from 30.30.208.2(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TlL37Kz_1576746267)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Dec 2019 17:04:28 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <CALOAHbCU2GHfupDRovk3Wvv=+qJr8sWO3tpu1upug=LM+VO1Og@mail.gmail.com>
Date:   Thu, 19 Dec 2019 17:04:27 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <23317BFD-8C0F-4CC7-A97B-DF339F83DCBA@linux.alibaba.com>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <CALOAHbCU2GHfupDRovk3Wvv=+qJr8sWO3tpu1upug=LM+VO1Og@mail.gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 在 2019年12月18日，18:47，Yafang Shao <laoar.shao@gmail.com> 写道：
> 
> On Wed, Dec 18, 2019 at 5:44 PM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>> 
>> Currently, memcg has some config to limit memory usage and config
>> the shrink behavior.
>> In the memory-constrained environment, put different priority tasks
>> into different cgroups with different memory limits to protect the
>> performance of the high priority tasks.  Because the global memory
>> shrink will affect the performance of all tasks.  The memory limit
>> cgroup can make shrink happen inside the cgroup.  Then it can decrease
>> the memory shrink of the high priority task to protect its performance.
>> 
>> But the memory footprint of the task is not static.  It will change as
>> the working pressure changes.  And the version changes will affect it too.
>> Then set the appropriate memory limit to decrease the global memory shrink
>> is a difficult job and lead to wasted memory or performance loss sometimes.
>> 
>> This commit adds global shrink priority to memcg to try to handle this
>> problem.
>> The default global shrink priority of each cgroup is DEF_PRIORITY.
>> Its behavior in global shrink is not changed.
>> And when global shrink priority of a cgroup is smaller than DEF_PRIORITY,
>> its memory will be shrink when memcg->global_shrink_priority greater than
>> or equal to sc->priority.
>> 
> 
> Just a kind reminder that sc->priority is really propotional, rather
> than priority.
> The relcaimer scans (total_size >> priority) pages at once.
> If the relcaimer can't relaim enough memory, it will decrease
> sc->priority and scan MEMCGs again until the sc->pirority drops to 0.
> (sc->priority is really a misleading wording. )
> So comparing the memcg priority with  sc->priority may cause unexpected issues.
> 
>> The following is an example to use global shrink priority in a VM that
>> has 2 CPUs, 1G memory and 4G swap:
>> # These are test shells that call usemem that get from
>> # https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git
>> cat 1.sh
>> sleep 9999
>> # -s 3600: Sleep 3600 seconds after test complete then usemem will
>> # not release the memory at once.
>> # -Z:  read memory again after access the memory.
>> # The first time access memory need shrink memory to allocate page.
>> # Then the access speed of high priority will not increase a lot.
>> # The read again speed of high priority will increase.
>> # $((850 * 1024 * 1024 + 8)): Different sizes are used to distinguish
>> # the results of the two tests.
>> usemem -s 3600 -Z -a -n 1 $((850 * 1024 * 1024 + 8))
>> cat 2.sh
>> sleep 9999
>> usemem -s 3600 -Z -a -n 1 $((850 * 1024 * 1024))
>> 
>> # Setup swap
>> swapon /swapfile
>> # Setup 2 cgroups
>> mkdir /sys/fs/cgroup/memory/t1/
>> mkdir /sys/fs/cgroup/memory/t2/
>> 
>> # Run tests with same global shrink priority
>> cat /sys/fs/cgroup/memory/t1/memory.global_shrink_priority
>> 12
>> cat /sys/fs/cgroup/memory/t2/memory.global_shrink_priority
>> 12
>> echo $$ > /sys/fs/cgroup/memory/t1/cgroup.procs
>> sh 1.sh &
>> echo $$ > /sys/fs/cgroup/memory/t2/cgroup.procs
>> sh 2.sh &
>> echo $$ > /sys/fs/cgroup/memory/cgroup.procs
>> killall sleep
>> # This the test results
>> 1002700800 bytes / 2360359 usecs = 414852 KB/s
>> 1002700809 bytes / 2676181 usecs = 365894 KB/s
>> read again 891289600 bytes / 13515142 usecs = 64401 KB/s
>> read again 891289608 bytes / 13252268 usecs = 65679 KB/s
>> killall usemem
>> 
>> # Run tests with 12 and 8
>> cat /sys/fs/cgroup/memory/t1/memory.global_shrink_priority
>> 12
>> echo 8 > /sys/fs/cgroup/memory/t2/memory.global_shrink_priority
>> echo $$ > /sys/fs/cgroup/memory/t1/cgroup.procs
>> sh 1.sh &
>> echo $$ > /sys/fs/cgroup/memory/t2/cgroup.procs
>> sh 2.sh &
>> echo $$ > /sys/fs/cgroup/memory/cgroup.procs
>> killall sleep
>> # This the test results
>> 1002700800 bytes / 1809056 usecs = 541276 KB/s
>> 1002700809 bytes / 2184337 usecs = 448282 KB/s
>> read again 891289600 bytes / 6666224 usecs = 130568 KB/s
>> read again 891289608 bytes / 9171440 usecs = 94903 KB/s
>> killall usemem
>> 
>> # This is the test results of 12 and 6
>> 1002700800 bytes / 1827914 usecs = 535692 KB/s
>> 1002700809 bytes / 2135124 usecs = 458615 KB/s
>> read again 891289600 bytes / 1498419 usecs = 580878 KB/s
>> read again 891289608 bytes / 7328362 usecs = 118771 KB/s
>> 
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>> include/linux/memcontrol.h |  2 ++
>> mm/memcontrol.c            | 32 ++++++++++++++++++++++++++++++++
>> mm/vmscan.c                | 39 ++++++++++++++++++++++++++++++++++++---
>> 3 files changed, 70 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index a7a0a1a5..8ad2437 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -244,6 +244,8 @@ struct mem_cgroup {
>>        /* OOM-Killer disable */
>>        int             oom_kill_disable;
>> 
>> +       s8 global_shrink_priority;
>> +
>>        /* memory.events and memory.events.local */
>>        struct cgroup_file events_file;
>>        struct cgroup_file events_local_file;
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c5b5f74..39fdc84 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4646,6 +4646,32 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>>        return ret;
>> }
>> 
>> +static ssize_t mem_global_shrink_priority_write(struct kernfs_open_file *of,
>> +                               char *buf, size_t nbytes, loff_t off)
>> +{
>> +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>> +       s8 val;
>> +       int ret;
>> +
>> +       ret = kstrtos8(buf, 0, &val);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (val > DEF_PRIORITY)
>> +               return -EINVAL;
>> +
>> +       memcg->global_shrink_priority = val;
>> +
>> +       return nbytes;
>> +}
>> +
>> +static s64 mem_global_shrink_priority_read(struct cgroup_subsys_state *css,
>> +                                       struct cftype *cft)
>> +{
>> +       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +
>> +       return memcg->global_shrink_priority;
>> +}
>> +
>> static struct cftype mem_cgroup_legacy_files[] = {
>>        {
>>                .name = "usage_in_bytes",
>> @@ -4774,6 +4800,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
>>                .write = mem_cgroup_reset,
>>                .read_u64 = mem_cgroup_read_u64,
>>        },
>> +       {
>> +               .name = "global_shrink_priority",
>> +               .write = mem_global_shrink_priority_write,
>> +               .read_s64 = mem_global_shrink_priority_read,
>> +       },
>>        { },    /* terminate */
>> };
>> 
>> @@ -4996,6 +5027,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>> 
>>        memcg->high = PAGE_COUNTER_MAX;
>>        memcg->soft_limit = PAGE_COUNTER_MAX;
>> +       memcg->global_shrink_priority = DEF_PRIORITY;
>>        if (parent) {
>>                memcg->swappiness = mem_cgroup_swappiness(parent);
>>                memcg->oom_kill_disable = parent->oom_kill_disable;
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 74e8edc..5e11d45 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2637,17 +2637,33 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>        return inactive_lru_pages > pages_for_compaction;
>> }
>> 
>> +static bool get_is_global_shrink(struct scan_control *sc)
>> +{
>> +       if (!sc->target_mem_cgroup ||
>> +               mem_cgroup_is_root(sc->target_mem_cgroup))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>> {
>>        struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
>>        struct mem_cgroup *memcg;
>> +       bool is_global_shrink = get_is_global_shrink(sc);
>> 
>>        memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
>>        do {
>> -               struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +               struct lruvec *lruvec;
>>                unsigned long reclaimed;
>>                unsigned long scanned;
>> 
>> +               if (is_global_shrink &&
>> +                       memcg->global_shrink_priority < sc->priority)
>> +                       continue;
>> +
>> +               lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +
>>                switch (mem_cgroup_protected(target_memcg, memcg)) {
>>                case MEMCG_PROT_MIN:
>>                        /*
>> @@ -2682,11 +2698,21 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>                reclaimed = sc->nr_reclaimed;
>>                scanned = sc->nr_scanned;
>> 
>> +               if (is_global_shrink &&
>> +                       memcg->global_shrink_priority != DEF_PRIORITY)
>> +                       sc->priority += DEF_PRIORITY
>> +                                       - memcg->global_shrink_priority;
>> +
> 
> For example.
> In this case this memcg can't do full scan.
> This behavior is similar with a hard protect(memroy.min), which may
> cause unexpected OOM under memory pressure.
> 
> Pls. correct me if I misunderstand you.

Thanks and agree with you.
Low priority task should do more shrink if the high priority task is ignored.

Best,
Hui

> 
>>                shrink_lruvec(lruvec, sc);
>> 
>>                shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>>                            sc->priority);
>> 
>> +               if (is_global_shrink &&
>> +                       memcg->global_shrink_priority != DEF_PRIORITY)
>> +                       sc->priority -= DEF_PRIORITY
>> +                                       - memcg->global_shrink_priority;
>> +
>>                /* Record the group's reclaim efficiency */
>>                vmpressure(sc->gfp_mask, memcg, false,
>>                           sc->nr_scanned - scanned,
>> @@ -3395,11 +3421,18 @@ static void age_active_anon(struct pglist_data *pgdat,
>> 
>>        memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>        do {
>> +               if (memcg->global_shrink_priority < sc->priority)
>> +                       continue;
>> +
>>                lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +               /*
>> +                * Not set sc->priority according even if this is
>> +                * a global shrink because nr_to_scan is set to
>> +                * SWAP_CLUSTER_MAX and there is not other part use it.
>> +                */
>>                shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>>                                   sc, LRU_ACTIVE_ANON);
>> -               memcg = mem_cgroup_iter(NULL, memcg, NULL);
>> -       } while (memcg);
>> +       } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
>> }
>> 
>> static bool pgdat_watermark_boosted(pg_data_t *pgdat, int classzone_idx)
>> --
>> 2.7.4

