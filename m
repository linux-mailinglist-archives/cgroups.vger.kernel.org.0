Return-Path: <cgroups+bounces-10305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D640CB8BF24
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 06:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B065A42A4
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 04:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450B1DD525;
	Sat, 20 Sep 2025 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I8NnZzbJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB658634C
	for <cgroups@vger.kernel.org>; Sat, 20 Sep 2025 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758342711; cv=none; b=cTrRvrYQdwT2kINH2/er/rVnXzFgrFM8lrv37P7uoe4uuDa3Htm+6jLDGw/tFw+o9mT0FAltb88m2XaRnMGZNZS8iT3KMxWgG+z0A3KytPdGIbrlCDSMYrJsMwsC3WBHCpCR2mD4flXzulCQ6wmIiN51+E+UR1qBbmOEm3zOUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758342711; c=relaxed/simple;
	bh=/HHc4tXH8rjyY4NZiel1Lg0aj36HRddVSdgAZEWoriA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6w4+P3kerbBzbiKJgqf/+nTVb4Th9yKaj8rkBO9zfUwQWTC8FJ9eBynlyGw+Xpof7eOILmOODXKBa2olayvkSkwSS8x8sJqN7FTrGRpCbjF1TAtcAhek2l8PiQqdXe4lun8n+a7GH9pzoNBxkbjBPfMTbQeab90Nxx4INUUNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I8NnZzbJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 21:31:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758342706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7Oqwm27EVC3hegeL8o9rPQpBwMcTLBc733/TDvrqNg=;
	b=I8NnZzbJ2dD4btg1IUawDHxKrOqJfngGHi+zHOtn3M+Avc93+yeIKyVifm0k7Ituth24jD
	v1ABEIEgPqY2t9LKb+wsRUs39CNi7xQP/MQvDA4PocieQPmN4G9lhK+3tnxWs7fjokgrf8
	yWMAjK2Ngj4kBM79bYSfryXJBtZbTVY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <eba3aiglp2hmj65sd4vsmav26o45orrlog2ifexd44yovygcdg@43wfk6dbgqda>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd>
 <CAADnVQK_wvu-KBgF6dNq=F5qNk-ons-w3UenJNaew6h9qTBpGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK_wvu-KBgF6dNq=F5qNk-ons-w3UenJNaew6h9qTBpGw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 07:47:57PM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 18, 2025 at 7:49 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
[...]
> > +
> > +static DEFINE_PER_CPU(struct defer_memcg_events, postpone_events) = {
> > +       .memcg_llist = LLIST_HEAD_INIT(memcg_llist),
> > +       .work = IRQ_WORK_INIT(process_deferred_events),
> > +};
> 
> Why all these per cpu stuff ? I don't understand what it helps with.
> To have max_events per-cpu?
> Just one global llist and irq_work will do just fine.
> and global max_events too.

Right, global llist and irq_work will work but max_events has to be
per-memcg. In addition we will need llist_node per-memcg and I think we
will need to do a similar cmpxchg trick I did in css_rstat_updated() to
eliminate the potential race of llist_node of a given memcg i.e.
multiple CPUs trying to add llist_node of a memcg to the global llist.

This can work but I am still debating if this additional complexity is
worth it as compared to the original patch where we skip
cgroup_file_notify() for !allow_spinning condition.

