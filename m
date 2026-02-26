Return-Path: <cgroups+bounces-14403-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMpfHUCTn2k9cwQAu9opvQ
	(envelope-from <cgroups+bounces-14403-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 01:26:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A819F656
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 01:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB54F3037D40
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 00:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49B21D585;
	Thu, 26 Feb 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ey+g63E7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30F5FDA7
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065541; cv=none; b=cRsFlnaPL9w7BAo/ZbNeWWbPcnaez9NvEbYfiJjcOJDBsD7f1uUnQ2KADU2p/EE2Tq0ttPHV0J7XqdZcm7OilPYbTu38fEpsHMRs1kBbeM6zhA/1jtCyk1BmPQyzKOsDcHizkR0Q8oHzMv8CLVRdq1aLU3W94CZpdHRXUmvV+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065541; c=relaxed/simple;
	bh=K5LKe6svs8tWQQgxlXMn1Wqs6u8cT7mRfbIARL7w+WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWsEzK/vH4JI4hERNet9M2SiHfbKRzCLp8As85+9lm0maTvZ+Oc4jfhIB+iaDIMRrDZjKHIHosEVXiaulwiiSQuKUmFQ3kqXi5Hdjtt+/ik0GksV1QEOvdDpip8KvSuhScnJRP6WIQLKNm+m7t3V9PoC8aUADb6hpMtRWsYirmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ey+g63E7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 16:25:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772065537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yxPqJ6E7xvNtCuOu5zbMYJVgjaGYkAlt6qTcXlH4PpM=;
	b=ey+g63E7MYcvKk29/8ZzUc3pXSq1elfr4bhlsqngJRjogeai6DH6S2T7UWhCrTJSC1+Bdt
	nyff4LdW470iaVY2rFfXfbEfQtnqRAZ/jH/mY6iGY/XJn1ZQO7iPw3GVDrGvpWDUTW+q5y
	4uMIS9FVfmAwC2lXFCseF48lDsZ7Cy4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <aZ-R87JfacQ2gGq1@linux.dev>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14403-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC4A819F656
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:58:59AM -0800, Yosry Ahmed wrote:
> > @@ -473,6 +493,29 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> >         return x;
> >  }
> >
> > +#ifdef CONFIG_MEMCG_V1
> > +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> > +                                      struct mem_cgroup *parent, int idx)
> > +{
> > +       int i = memcg_stats_index(idx);
> > +       int nid;
> > +
> > +       if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
> > +               return;
> > +
> > +       for_each_node(nid) {
> > +               struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > +               struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
> > +               struct mem_cgroup_per_node *parent_pn;
> > +               unsigned long value = lruvec_page_state_local(child_lruvec, idx);
> > +
> > +               parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
> > +
> > +               atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
> > +       }
> > +}
> 
> Did you measure the impact of making state_local atomic on the flush
> path? It's a slow path but we've seen pain from it being too slow
> before, because it extends the critical section of the rstat flush
> lock.

Qi, please measure the impact on flushing and if no impact then no need to do
anything as I don't want anymore churn in this series.

> 
> Can we keep this non-atomic and use mod_memcg_lruvec_state() here? It
> will update the stat on the local counter and it will be added to
> state_local in the flush path when needed. We can even force another
> flush in reparent_state_local () after reparenting is completed, if we
> want to avoid leaving a potentially large stat update pending, as it
> can be missed by mem_cgroup_flush_stats_ratelimited().
> 
> Same for reparent_memcg_state_local(), we can probably use mod_memcg_state()?

Yosry, do you mind sending the patch you are thinking about over this series?

