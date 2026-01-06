Return-Path: <cgroups+bounces-12934-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5989CCF984B
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 18:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A8B300FFA2
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5A338F52;
	Tue,  6 Jan 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSC/XXQz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA273385B3
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718329; cv=none; b=BYRi+TuQAoKJyhJfoyJknF8aR1E1+k9egH59ALwndKxs4aJQhyoOU2hZUZ1n7hBXZkCrDkQSVLcx3koVrWuLejp9X4anEpdNWUHRAF9gvWdaW12oZE7uVdheRmUQEoGwsuWSbUA9XMzS+iH6w17rik0H//avz2bI5kdpv3vcmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718329; c=relaxed/simple;
	bh=/cozL3/Rh/PlDZC1K3Uq/siJXAJfJfX35y05ub3Fuu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYAwKYG/VD4iqZv4Z5LdWg8gJiB5W5JxwDA0wtBPgDPSbhQY+2KIoW8SJdeutjb6kVTUHe9uqJFg15KjuJ3Le0jKXgxgLUygdtex/PqffM0ZnklOEPZMQesliiD+gjbKpPwACwu0oAUPiRdaWjVuxxUNmAwsD9tsxIr/7vBSxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSC/XXQz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Jan 2026 16:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767718325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UD2crwKJYyiE4FPL7vLzqYvJnd70fea19UnIDBPEH4=;
	b=qSC/XXQzEPYB8mYYbl5kz8Iup6+I0c+PuosEUAn+P0l9OnYITWEyFnsWS3YHzC7RxSIjKX
	/ECPfpMCnkTAj2RVpOrTblRbAci0VykKCsjWwTcG7ZfT9X5zQX7BnNVm/9gc0O2TW7HiWI
	dUS79Urxyls4YO/zMZdZWzyz/HWMOAI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, hannes@cmpxchg.org, 
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <rga5pjrjnrzzminflnwfd2lckedg4pdzaypwsa4ad2ovyjkavt@kegiy7cthefu>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>
 <prqhodx7wc3cbrlh7tqf632b3gpcciwmn5n22qqv7c7rbtsoy3@lsnd7rtdhfmh>
 <hrxsjzcyj2uvxi5h5edtkoc3br4ljvz7m36nczoctyyoinrz56@27gcuui7wfpw>
 <d016b76d-581a-4582-920d-21f64318090a@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d016b76d-581a-4582-920d-21f64318090a@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 06, 2026 at 03:08:57PM +0800, Qi Zheng wrote:
> 
> 
> On 1/6/26 12:14 AM, Yosry Ahmed wrote:
> > On Mon, Jan 05, 2026 at 11:41:46AM +0100, Michal Koutný wrote:
> > > Hi Qi.
> > > 
> > > On Wed, Dec 17, 2025 at 03:27:51PM +0800, Qi Zheng <qi.zheng@linux.dev> wrote:
> > > 
> > > > @@ -5200,22 +5238,27 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
> > > >   	unsigned int nr_pages = folio_nr_pages(folio);
> > > >   	struct page_counter *counter;
> > > >   	struct mem_cgroup *memcg;
> > > > +	struct obj_cgroup *objcg;
> > > >   	if (do_memsw_account())
> > > >   		return 0;
> > > > -	memcg = folio_memcg(folio);
> > > > -
> > > > -	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
> > > > -	if (!memcg)
> > > > +	objcg = folio_objcg(folio);
> > > > +	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
> > > > +	if (!objcg)
> > > >   		return 0;
> > > > +	rcu_read_lock();
> > > > +	memcg = obj_cgroup_memcg(objcg);
> > > >   	if (!entry.val) {
> > > >   		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> > > > +		rcu_read_unlock();
> > > >   		return 0;
> > > >   	}
> > > >   	memcg = mem_cgroup_id_get_online(memcg);
> > > > +	/* memcg is pined by memcg ID. */
> > > > +	rcu_read_unlock();
> > > >   	if (!mem_cgroup_is_root(memcg) &&
> > > >   	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
> > > 
> > > Later there is:
> > > 	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
> > > 
> > > As per the comment memcg remains pinned by the ID which is associated
> > > with a swap slot, i.e. theoretically time unbound (shmem).
> > > (This was actually brought up by Yosry in stats subthread [1])
> > > 
> > > I think that should be tackled too to eliminate the problem completely.
> > 
> > FWIW, I am not sure if swap entries is the last cause of pinning memcgs,
> > I am pretty sure there will be others that we haven't found yet. This is
> 
> Agree.
> 
> > why I think we shouldn't assume that the time between offlining and
> > releasing a memcg is short or bounded when fixing the stats problem.
> 
> If I have not misunderstood your suggestion in the other thread, I plan
> to do the following in v3:
> 
> 1. define a memcgv1-only function:
> 
> void memcg1_reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup
> *parent)
> {
> 	int i;
> 
> 	synchronize_rcu();
> 
> 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
> 		int idx = memcg1_stats[i];
> 		unsigned long value = memcg_page_state_local(memcg, idx);
> 
> 		mod_memcg_page_state_local(parent, idx, value);
> 	}
> }
> 
> 2. call it after reparent_unlocks():
> 
> memcg_reparent_objcgs
> --> objcg = __memcg_reparent_objcgs(memcg, parent);
>     reparent_unlocks(memcg, parent);
>     reparent_state_local(memcg, parent);
>     --> memcg1_reparent_state_local()

Something like that, yeah. I think we can avoid introducing
mod_memcg_page_state_local() if we just use mod_memcg_state() to
subtract the stat from the child then add it to the parent.

We should probably also flush the stats before reading them to
aggregate all per-CPU counters.

I think we also need to ensure that all stat updates happen within the
same RCU read section where we read the memcg pointer from the page,
ideally with safeguards to prevent misuse.

> 
> > 
> > > 
> > > As I look at the code, these memcg IDs (private [2]) could be converted
> > > to objcg IDs so that reparenting applies also to folios that are
> > > currently swapped out. (Or convert to swap_cgroup_ctrl from the vector
> > > of IDs to a vector of objcg pointers, depending on space.)
> > 
> > I think we can do objcg IDs, but be careful to keep the same behavior as
> > today and avoid overexhausting the 16 bit ID space. So we need to also
> > drop the ref to the objcg ID when the memcg is offlined and the objcg is
> > reparented, such that the objcg ID is deleted unless there are swapped
> > out entries.
> > 
> > I think this can be done on top of this series, not necessarily as part
> > of it.
> 
> Agree, I prefer to address this issue in a separate patchset.
> 
> Thanks,
> Qi
> 
> > 
> > > 
> > > Thanks,
> > > Michal
> > > 
> > > [1] https://lore.kernel.org/r/ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexoeq3tb@5gj5y2exdhpn
> > > [2] https://lore.kernel.org/r/20251225232116.294540-1-shakeel.butt@linux.dev
> > 
> > 
> 

