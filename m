Return-Path: <cgroups+bounces-12923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F273CF4B89
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 17:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C57A1302017B
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8D33F8BB;
	Mon,  5 Jan 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xvyoeqb9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A133F8C5
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629677; cv=none; b=B4MlQqQJS774lVoV9J2oUR+zUMdbAHRQLfVxaRtq5LDNk/sOB4gOKarSWY3FgMRD7UvBZkp6lbeggnqVPeuLe4WjY0/VJ29SO/6CjADEOClY7I8gyHnuRaddBg0SovOf7HNW2gHlif2I/DcUYdU5WpFz0gVpB4EsdIaBylHWZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629677; c=relaxed/simple;
	bh=nS8lAS+WPwTyzF9EkSMckwtpotNYK5g5JLOVOkwYc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUHkRjgcxjKPaJOy1uW4QsZvUWYaFa0BJTVnEAA4iDEmmv8hdhZ2Hi8C/FD692Lh3STQcWx/ahsZojpEtZFtdJ8iBJZjI8X4KddtagQ84WmfcDRSzTRTvXUZdVvA2HSPswgrAL/En+7uxTfo51B8JtcGorD0TuJorZs/8BfsROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xvyoeqb9; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Jan 2026 16:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767629672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+zivRqtPV0Ur5FftE/Ma5edksPr76yL6W4pGhtZvKQ=;
	b=xvyoeqb9YUuPLOPwb1xhwhjXWvmC0P5r/sUVBZbYz40OC3g+x1zmHzp9BDL3A+WY3mi290
	HcRtHH+n6I6xzqDpAeW9cdHaDloKX0Onm3OFcwie/5oGYl8UriG43YM7nMEa7BFeAHG5/Q
	IZmnFWL9tc86FoM2YxipJWgkX/t1tG4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <hrxsjzcyj2uvxi5h5edtkoc3br4ljvz7m36nczoctyyoinrz56@27gcuui7wfpw>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>
 <prqhodx7wc3cbrlh7tqf632b3gpcciwmn5n22qqv7c7rbtsoy3@lsnd7rtdhfmh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <prqhodx7wc3cbrlh7tqf632b3gpcciwmn5n22qqv7c7rbtsoy3@lsnd7rtdhfmh>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 05, 2026 at 11:41:46AM +0100, Michal Koutný wrote:
> Hi Qi.
> 
> On Wed, Dec 17, 2025 at 03:27:51PM +0800, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> > @@ -5200,22 +5238,27 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
> >  	unsigned int nr_pages = folio_nr_pages(folio);
> >  	struct page_counter *counter;
> >  	struct mem_cgroup *memcg;
> > +	struct obj_cgroup *objcg;
> >  
> >  	if (do_memsw_account())
> >  		return 0;
> >  
> > -	memcg = folio_memcg(folio);
> > -
> > -	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
> > -	if (!memcg)
> > +	objcg = folio_objcg(folio);
> > +	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
> > +	if (!objcg)
> >  		return 0;
> >  
> > +	rcu_read_lock();
> > +	memcg = obj_cgroup_memcg(objcg);
> >  	if (!entry.val) {
> >  		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> > +		rcu_read_unlock();
> >  		return 0;
> >  	}
> >  
> >  	memcg = mem_cgroup_id_get_online(memcg);
> > +	/* memcg is pined by memcg ID. */
> > +	rcu_read_unlock();
> >  
> >  	if (!mem_cgroup_is_root(memcg) &&
> >  	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
> 
> Later there is:
> 	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
> 
> As per the comment memcg remains pinned by the ID which is associated
> with a swap slot, i.e. theoretically time unbound (shmem).
> (This was actually brought up by Yosry in stats subthread [1])
> 
> I think that should be tackled too to eliminate the problem completely.

FWIW, I am not sure if swap entries is the last cause of pinning memcgs,
I am pretty sure there will be others that we haven't found yet. This is
why I think we shouldn't assume that the time between offlining and
releasing a memcg is short or bounded when fixing the stats problem.

> 
> As I look at the code, these memcg IDs (private [2]) could be converted
> to objcg IDs so that reparenting applies also to folios that are
> currently swapped out. (Or convert to swap_cgroup_ctrl from the vector
> of IDs to a vector of objcg pointers, depending on space.)

I think we can do objcg IDs, but be careful to keep the same behavior as
today and avoid overexhausting the 16 bit ID space. So we need to also
drop the ref to the objcg ID when the memcg is offlined and the objcg is
reparented, such that the objcg ID is deleted unless there are swapped
out entries.

I think this can be done on top of this series, not necessarily as part
of it.

> 
> Thanks,
> Michal
> 
> [1] https://lore.kernel.org/r/ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexoeq3tb@5gj5y2exdhpn
> [2] https://lore.kernel.org/r/20251225232116.294540-1-shakeel.butt@linux.dev



