Return-Path: <cgroups+bounces-15011-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJlEHXoNwmkrZQQAu9opvQ
	(envelope-from <cgroups+bounces-15011-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:05:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708B301EB2
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D7D3302493F
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 04:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA81A381B12;
	Tue, 24 Mar 2026 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGnEWDkM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB970818;
	Tue, 24 Mar 2026 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325111; cv=none; b=eOThzDHvOwfyVLeW9BrvjNfmPcaQBV0LNW9Xreb7KYhemJCtR1YU6MKDvyGb1u465HI6dihWDX8XlNR3CorTP+rhtrjO0JHfYRkBHf/xKi/adE6mOPXxsB++QRBs3db2RG4Rc6FGIwCU+8fltPJIuIhkWB1gAU6NynDMm9yQunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325111; c=relaxed/simple;
	bh=eo7hLe/UY2d6bsTGJr+MAuwNH1sx7hGm4F8hmnA4vUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew9MNoNExTU5zc/SHWlStVy7Me+1wKSPCrQ0qLCRfpbGBGXZPwuW2I88ufRkLE7iAqD6El1vJ0A0tEv615d8hXPIQN25JAbkgYUZS2Ei88Ny5bg/LNuGLiialiCVgyjasuHgdaZ+a5sbGkkXcTs02W9dI2tEX2VyfC3GW3+5CAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGnEWDkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D02C19424;
	Tue, 24 Mar 2026 04:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774325111;
	bh=eo7hLe/UY2d6bsTGJr+MAuwNH1sx7hGm4F8hmnA4vUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGnEWDkMGtKovAsotKqzcJxOtPk7vEtz18C1/IMUcYQzgymgXnYtn/P88DzKkS1C/
	 9bg1dZCG9YL6jHVkxvebJbkMXCHR/5ZikFRdC0bZBxN6A1MZzHaqo4e6m0z51R5r94
	 5QntqB0qAEFSx1N2RVmQTbPNdtBmHjCTPNauPwYev5mEcYTxUHd0XImtli9lne/OHg
	 LVydXzK8oeQWtKHC7IBq8Uow2rx4Nc4Q4W6MjphUTmt2e6zeikJrHKUlAmE2fSFtZr
	 ckU0C98Prp/XpM/CQGb6WbIkph7GraYrtiBP9FauBYnwH9P8cbDiZZuPGi3dPBC6ka
	 3hizjTu3jMTPw==
Date: Tue, 24 Mar 2026 13:05:09 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
	usamaarif642@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <acINdWKdH_b5LdhH@hyeyoo>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
 <acDxaEgnqPI-Z4be@hyeyoo>
 <2d39ea5e-fd69-4acf-8518-a504f5f7a838@linux.dev>
 <acExNWaaKdhrBH-J@hyeyoo>
 <c913ce46-bc83-4d36-b1b0-a51b12e515e9@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c913ce46-bc83-4d36-b1b0-a51b12e515e9@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15011-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1708B301EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:54:48AM +0800, Qi Zheng wrote:
> On 3/23/26 8:25 PM, Harry Yoo (Oracle) wrote:
> > On Mon, Mar 23, 2026 at 05:47:27PM +0800, Qi Zheng wrote:
> > > On 3/23/26 3:53 PM, Harry Yoo (Oracle) wrote:
> > > > On Thu, Mar 05, 2026 at 07:52:48PM +0800, Qi Zheng wrote:
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index 23b70bd80ddc9..b0519a16f5684 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -473,6 +501,30 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> > > > >    	return x;
> > > > >    }
> > > > > +#ifdef CONFIG_MEMCG_V1
> > > > > +static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
> > > > > +				     enum node_stat_item idx, int val);
> > > > > +
> > > > > +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> > > > > +				       struct mem_cgroup *parent, int idx)
> > > > > +{
> > > > > +	int nid;
> > > > > +
> > > > > +	for_each_node(nid) {
> > > > > +		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > > > > +		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
> > > > > +		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
> > > > > +		struct mem_cgroup_per_node *child_pn, *parent_pn;
> > > > > +
> > > > > +		child_pn = container_of(child_lruvec, struct mem_cgroup_per_node, lruvec);
> > > > > +		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
> > > > > +
> > > > > +		__mod_memcg_lruvec_state(child_pn, idx, -value);
> > > > > +		__mod_memcg_lruvec_state(parent_pn, idx, value);
> > > > 
> > > > We should probably change the type of `@val` from int to val to avoid
> > > > losing non hierarchical stats during reparenting?
> > > 
> > > The parameter and return value of memcg_state_val_in_pages() are both
> > > of type int, so perhaps we need a cleanup patch to do this?
> > 
> > Yes!
> > 
> > and @val in memcg_rstat_updated() too, I think.
> 
> Right.
> 
> > 
> > > I will send a cleanup patchset to do this, which includes the following:
> > > 
> > > https://lore.kernel.org/all/5e178b4e-a9e0-44dc-a18d-8c014365ee2f@linux.dev/
> > 
> > Thanks!
> > 
> > Should that ideally be applied before this patchset?
> 
> This would conflict with the current patchset.

Right.

> The v6 has been in mm-unstable for some time

Right.

> so I prefer to add a cleanup patchset to
> avoid interfering with the merge of this patchset.

but it's a little bit more than a cleanup, no?

I'd say without the followup, this patchset introduces a very subtle
(likely nobody would notice) functional regression visible on memcgs
with billions of pages.

> Otherwise, sending v7 might be more appropriate.
 
I think it should be sent either as v7 or as part of v7.1-rcX.
(Whichever way Andrew prefers)

-- 
Cheers,
Harry / Hyeonggon

