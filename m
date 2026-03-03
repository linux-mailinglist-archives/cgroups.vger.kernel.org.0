Return-Path: <cgroups+bounces-14542-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLykMhpRpmmxNwAAu9opvQ
	(envelope-from <cgroups+bounces-14542-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 04:10:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307281E856B
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 04:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2314330087B7
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685137CD31;
	Tue,  3 Mar 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QyVeESPa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B733A9D1;
	Tue,  3 Mar 2026 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507367; cv=none; b=WMNArqKYG837UgMfLkg1dLl55kQ1oSpXNNljCcfXYcbNqaZyQPtvE+Gs/S2q+r6athViIoGm0qd4CVD7Ktrkg6q+TUX76D43MqAak4+mZ3f5m2I5vB0gX/f3gYCXG2VX6/ZBEqndDPHTQP5i1jfPWxt82mK7NdXiUQOR0Csa9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507367; c=relaxed/simple;
	bh=efVxg2nJsWIH0vvBmC1ejzUCEKnuP8Oq7UWgHL0TMM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U53uWJ2Gk6QhG4C8GetrIKOjmBLL/VYe73cHDXJLY9uLJI4z9TZN2XioCI6BkoY14BB1RDiB6AGdmQPTWQ3xxVOKQ1mG77vPhR+og6A8mS74XW4oOmGsUfPlyjCq8wG8lBGSxt2CNa7tJZ1wcrINNsQmKp5JceVif2K8ndltULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QyVeESPa; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772507363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBs9bcabgCEvuY4u0v9/Zsg1qM7B1u6PtJQeoLsqsQQ=;
	b=QyVeESPaWFJLoQzS37FHot8bE0Mv+NxgIBjalY7avmEkv0ZeizppPT+OoVZJEzwHQOX2IT
	U3njDt7ffGXBk2bUNFimSYNg+4wknqLnu0vTTmgV+E782nA1Mhg9gqTLtOr3BeTQhLjTRB
	J/nsZ1VHUXl8ykXDxlffhIrVdjuTb7I=
Date: Tue, 3 Mar 2026 11:08:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Yosry Ahmed <yosry@kernel.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
 usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <20260228072556.31793-1-qi.zheng@linux.dev>
 <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 307281E856B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14542-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

Hi Yosry,

On 3/2/26 11:53 PM, Yosry Ahmed wrote:
> [..]
>> @@ -763,6 +851,64 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
>>   #endif
>>          return x;
>>   }
>> +
>> +static void __mod_memcg_state(struct mem_cgroup *memcg,
>> +                             enum memcg_stat_item idx, int val)
>> +{
>> +       int i = memcg_stats_index(idx);
>> +       int cpu;
>> +
>> +       if (mem_cgroup_disabled())
>> +               return;
>> +
>> +       cpu = get_cpu();
>> +
>> +       this_cpu_add(memcg->vmstats_percpu->state[i], val);
>> +       val = memcg_state_val_in_pages(idx, val);
>> +       memcg_rstat_updated(memcg, val, cpu);
>> +       trace_mod_memcg_state(memcg, idx, val);
>> +
>> +       put_cpu();
>> +}
>> +
>> +static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
>> +                                    enum node_stat_item idx, int val)
>> +{
>> +       struct mem_cgroup_per_node *pn;
>> +       struct mem_cgroup *memcg;
>> +       int i = memcg_stats_index(idx);
>> +       int cpu;
>> +
>> +       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>> +       memcg = pn->memcg;
>> +
>> +       cpu = get_cpu();
>> +
>> +       /* Update memcg */
>> +       this_cpu_add(memcg->vmstats_percpu->state[i], val);
>> +
>> +       /* Update lruvec */
>> +       this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
>> +
>> +       val = memcg_state_val_in_pages(idx, val);
>> +       memcg_rstat_updated(memcg, val, cpu);
>> +       trace_mod_memcg_lruvec_state(memcg, idx, val);
>> +
>> +       put_cpu();
>> +}
> 
> I don't think we should end up with two copies of
> __mod_memcg_state/mod_memcg_state() and
> __mod_memcg_lruvec_state/mod_memcg_lruvec_state(). I meant to refactor
> mod_memcg_state() to call __mod_memcg_state(), where the latter does
> not call get_non_dying_memcg_{start/end}(). Same for
> mod_memcg_lruvec_state().

Okay, like the following? But this would require modifications to
[PATCH v5 31/32]. If there are no problems, I will send the updated
patch to [PATCH v5 29/32] and [PATCH v5 31/32].

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e927530156fee..3d9e2cfad5b12 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -528,7 +528,8 @@ unsigned long lruvec_page_state_local(struct lruvec 
*lruvec,

  #ifdef CONFIG_MEMCG_V1
  static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
-                                    enum node_stat_item idx, int val);
+                                    enum node_stat_item idx, int val,
+                                    bool reparent);

  void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
                                        struct mem_cgroup *parent, int idx)
@@ -544,8 +545,8 @@ void reparent_memcg_lruvec_state_local(struct 
mem_cgroup *memcg,
                 struct lruvec *parent_lruvec = 
mem_cgroup_lruvec(parent, NODE_DATA(nid));
                 unsigned long value = 
lruvec_page_state_local(child_lruvec, idx);

-               __mod_memcg_lruvec_state(child_lruvec, idx, -value);
-               __mod_memcg_lruvec_state(parent_lruvec, idx, value);
+               __mod_memcg_lruvec_state(child_lruvec, idx, -value, true);
+               __mod_memcg_lruvec_state(parent_lruvec, idx, value, true);
         }
  }
  #endif
@@ -831,14 +832,9 @@ static inline void get_non_dying_memcg_end(void)
  }
  #endif

-/**
- * mod_memcg_state - update cgroup memory statistics
- * @memcg: the memory cgroup
- * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
- * @val: delta to add to the counter, can be negative
- */
-void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
-                      int val)
+static void __mod_memcg_state(struct mem_cgroup *memcg,
+                             enum memcg_stat_item idx, int val,
+                             bool reparent)
  {
         int i = memcg_stats_index(idx);
         int cpu;
@@ -846,24 +842,38 @@ void mod_memcg_state(struct mem_cgroup *memcg, 
enum memcg_stat_item idx,
         if (mem_cgroup_disabled())
                 return;

-       if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", 
__func__, idx))
+       if (!reparent && WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat 
item %d\n", __func__, idx))
                 return;

         cpu = get_cpu();

-       memcg = get_non_dying_memcg_start(memcg);
+       if (!reparent)
+               memcg = get_non_dying_memcg_start(memcg);

         this_cpu_add(memcg->vmstats_percpu->state[i], val);
         val = memcg_state_val_in_pages(idx, val);
         memcg_rstat_updated(memcg, val, cpu);

-       get_non_dying_memcg_end();
+       if (!reparent)
+               get_non_dying_memcg_end();

         trace_mod_memcg_state(memcg, idx, val);

         put_cpu();
  }

+/**
+ * mod_memcg_state - update cgroup memory statistics
+ * @memcg: the memory cgroup
+ * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
+ * @val: delta to add to the counter, can be negative
+ */
+void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+                      int val)
+{
+       __mod_memcg_state(memcg, idx, val, false);
+}
+
  #ifdef CONFIG_MEMCG_V1
  /* idx can be of type enum memcg_stat_item or node_stat_item. */
  unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
@@ -882,51 +892,6 @@ unsigned long memcg_page_state_local(struct 
mem_cgroup *memcg, int idx)
         return x;
  }

-static void __mod_memcg_state(struct mem_cgroup *memcg,
-                             enum memcg_stat_item idx, int val)
-{
-       int i = memcg_stats_index(idx);
-       int cpu;
-
-       if (mem_cgroup_disabled())
-               return;
-
-       cpu = get_cpu();
-
-       this_cpu_add(memcg->vmstats_percpu->state[i], val);
-       val = memcg_state_val_in_pages(idx, val);
-       memcg_rstat_updated(memcg, val, cpu);
-       trace_mod_memcg_state(memcg, idx, val);
-
-       put_cpu();
-}
-
-static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
-                                    enum node_stat_item idx, int val)
-{
-       struct mem_cgroup_per_node *pn;
-       struct mem_cgroup *memcg;
-       int i = memcg_stats_index(idx);
-       int cpu;
-
-       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-       memcg = pn->memcg;
-
-       cpu = get_cpu();
-
-       /* Update memcg */
-       this_cpu_add(memcg->vmstats_percpu->state[i], val);
-
-       /* Update lruvec */
-       this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
-
-       val = memcg_state_val_in_pages(idx, val);
-       memcg_rstat_updated(memcg, val, cpu);
-       trace_mod_memcg_lruvec_state(memcg, idx, val);
-
-       put_cpu();
-}
-
  void reparent_memcg_state_local(struct mem_cgroup *memcg,
                                 struct mem_cgroup *parent, int idx)
  {
@@ -936,14 +901,14 @@ void reparent_memcg_state_local(struct mem_cgroup 
*memcg,
         if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", 
__func__, idx))
                 return;

-       __mod_memcg_state(memcg, idx, -value);
-       __mod_memcg_state(parent, idx, value);
+       __mod_memcg_state(memcg, idx, -value, true);
+       __mod_memcg_state(parent, idx, value, true);
  }
  #endif

-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-                                    enum node_stat_item idx,
-                                    int val)
+static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+                                    enum node_stat_item idx, int val,
+                                    bool reparent)
  {
         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
         struct mem_cgroup_per_node *pn;
@@ -951,7 +916,7 @@ static void mod_memcg_lruvec_state(struct lruvec 
*lruvec,
         int i = memcg_stats_index(idx);
         int cpu;

-       if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", 
__func__, idx))
+       if (!reparent && WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat 
item %d\n", __func__, idx))
                 return;

         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -959,8 +924,10 @@ static void mod_memcg_lruvec_state(struct lruvec 
*lruvec,

         cpu = get_cpu();

-       memcg = get_non_dying_memcg_start(memcg);
-       pn = memcg->nodeinfo[pgdat->node_id];
+       if (!reparent) {
+               memcg = get_non_dying_memcg_start(memcg);
+               pn = memcg->nodeinfo[pgdat->node_id];
+       }

         /* Update memcg */
         this_cpu_add(memcg->vmstats_percpu->state[i], val);
@@ -969,13 +936,21 @@ static void mod_memcg_lruvec_state(struct lruvec 
*lruvec,
         val = memcg_state_val_in_pages(idx, val);
         memcg_rstat_updated(memcg, val, cpu);

-       get_non_dying_memcg_end();
+       if (!reparent)
+               get_non_dying_memcg_end();

         trace_mod_memcg_lruvec_state(memcg, idx, val);

         put_cpu();
  }

+static void mod_memcg_lruvec_state(struct lruvec *lruvec,
+                                    enum node_stat_item idx,
+                                    int val)
+{
+       __mod_memcg_lruvec_state(lruvec, idx, val, false);
+}
+
  /**
   * mod_lruvec_state - update lruvec memory statistics
   * @lruvec: the lruvec

> 




