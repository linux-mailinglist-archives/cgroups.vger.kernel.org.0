Return-Path: <cgroups+bounces-15366-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGVlG+CV5WnrlgEAu9opvQ
	(envelope-from <cgroups+bounces-15366-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:56:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105EF42671B
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5268230071D8
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE737EFEE;
	Mon, 20 Apr 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t1b3S+bk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FC37EFE2
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653787; cv=none; b=lTkdh6ADcwGQn4R6kXz3a8t2YDSu5qXUSXGLYVm/4EkRBwzmCpxI54Cv+NNi5s0gY34ML80Xvb5Y9NpgBaOnXbQKhoQRq+00Tf+U8LgyGLPS/VbGr/6NkL5z9JVKOr2QS6nEu486EOjqv40pzkI+NuK5pFSxz0VoTzCMcH0dBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653787; c=relaxed/simple;
	bh=Gy7C5LgAy0+dNJVh3a/spG3LUsjag46Tvhe61CPzqjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrZVNCpOw4JvkAjPQOBFD/QhH88CZo4BWg5lo7AtjbTsWRZsUixD6p0NncfOtL5LagRt6Y8IiDkbpuHC0tvb3/FZM+O+sohQz1Np5sqtDYPAqnORfhSUms6uVGmtqrSsRrDFhW5w+tKhAJtml59pQKLwJNZrdTN/vyMr49M+g30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t1b3S+bk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so287819185a.3
        for <cgroups@vger.kernel.org>; Sun, 19 Apr 2026 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776653784; x=1777258584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tugQt2aIOJgoqj0Ob37lQ1a1TrVKhZ7jSIgjv7qjxfc=;
        b=t1b3S+bkTXE3j00v5UNCH8rPHlmuEMJsB+F6lwv8trpr/PskjdnmsL4XxF9lpDjdF0
         hzhD9hJ/y1a/SqHQ9k6S04uBN6tyzhw5ddh6/Dr0Efbu75Z1tYBl2rwLwqjXkXjwnWgi
         zo99c5KrKmAg31ptTacy0m7WGoFP2qXpCPOewg5RUjcFmBnHyEsPkQ3CXu4Ap0yWF8Jp
         y2Tsuja+wRqOw1p5f5NtBwF5g9oGJSKcc6UHi76irOasuXa4l6PJP9bbsi4xnRWezIZd
         Dv7TbLaOn+YYUq/YkJ20RultXKWF5eKRrsoyZjlEXfxwcliifnoOs3LV8VCvxdCBCLUA
         uHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653784; x=1777258584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tugQt2aIOJgoqj0Ob37lQ1a1TrVKhZ7jSIgjv7qjxfc=;
        b=a4lH7N4GVIYb8sdFHo9Ou2ZZZAGEaZRmw6ZIa3mUd9qfcbe6A/oVRpUlY81y+Cs56X
         x32D8G/U5oIBvet58OjbnBrBhrVSPln/7a4+LshT7dALL+nCLd5wXj5wWJ2ar5jfyyIf
         htTMzycjhjRC4Qea4HmWySTzyiofoQwU/SAqS6hcZisbcXar8m7MApm2OlfXv5OW+bOm
         j6drR/dseqeNKfMJiKmUcfliszuW0+SfJIxdo9Amts1H0DYUUgngPtYCe9bfXR7UL0or
         mqOzxmVzCQVC2CCmiJVzjARIvj2itaITHFyk6IX8uddx8B2l6mg262ZBombEmtthOnVC
         BMEg==
X-Forwarded-Encrypted: i=1; AFNElJ//U1PyEV7OQtzT724xxpIptw1UnkTG9VT3Op2pW7l5pjxA8KmJfZPjn5PzRz6o8K3EOQlee94m@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5HiHxhPLXSEDtCnCWTHuXI5e32I8/mS/BtRVx3rz86iAIWC+
	VH5kfW2Ba6vNkpldytL1SNmQ00dtsrZfgAV/BDSNUB3hpxqZpMAJrYSuW3tuYsMgcOQ=
X-Gm-Gg: AeBDieuUj7dcxPTAeprvqeRqyll9tNXpnvr0jk1IrF9ICviooNYYPsFW9c9IgI7OZ4D
	cYjQzFUxzpXzxj4OxZseQ9sJWQJEepwnY9Wj3SAIBvvxNY5BMmwfp3kmBTMxfNWHb3qPa+nrf/c
	S4ke2AJuhMjLQcojkEW8LsQv9mLaJmwOyyoQb/fSg9gVuXMKbY+Z3ZOi004ophNCwLU6ucOtrf+
	q06UonXGai0e6kbsmwd1EanIXTiTw6dlWkP9VX8P66CWBaVj9bodcC1Usgcfw00bWQ9Le7qOrOc
	kzGAEp92n6zeMMytrOA6vUHTUtiMzocQtQRXlonOpdZmQzpdwgM3Qm12Wd9GZUH4jv9Y+OElwMD
	wQN9vHOasdsWzqzuqMIPS1HKPLzDju++mdl15jb21m1gfinrECuC87xHrAbwQLzzOcEN8DXQv1+
	6aSfRqju9Sn/DbLIDJ5zp21LZZoQ10GJxDZW5C5uRwdDg47IBplEyinJM35IyWHiiFNuouSqu9j
	MiwjULa7hodSH1c/h3pnSI=
X-Received: by 2002:a05:620a:a2c3:10b0:8e8:bedd:14b2 with SMTP id af79cd13be357-8e8bedd1701mr799144185a.43.1776653784400;
        Sun, 19 Apr 2026 19:56:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-28-184-223.washdc.fios.verizon.net. [108.28.184.223])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9638sm706089185a.1.2026.04.19.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:56:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 22:56:20 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aeWV1CvP9ImZ3eEG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15366-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 105EF42671B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 11:37:36AM +0200, David Hildenbrand (Arm) wrote:
> On 4/15/26 17:17, Gregory Price wrote:
> 
> >> Needs a second thought regarding fallback logic I raised above.
> >>
> >> What I think would have to be audited is the usage of __GFP_THISNODE by
> >> kernel allocations, where we would not actually want to allocate from
> >> this private node.
> >>
> > 
> > This is fair, and I a re-visit is absolutely warranted.
> > 
> > Re-examining the quick audit from my last response suggests - I should
> > never have seen leakage in those cases, but the fallbacks are needed.
> > 
> > So yes, this all requires a second look (and a third, and a ninth).
> > 
> > I'm not married to __GFP_PRIVATE, but it has been reliable for me.
> 
> Yes, we should carefully describe which semantics we want to achieve, to
> then figure out how we could achieve them.
> 

Ah, I finally dug up my notes on this.

If we overload __GFP_THISNODE - then we have to audit all gfp_mask's
with THISNODE against the use of any of the following *forever*:

#define node_online_map         node_states[N_ONLINE]
#define node_possible_map       node_states[N_POSSIBLE]
#define for_each_node(node)        for_each_node_state(node, N_POSSIBLE)
#define for_each_online_node(node) for_each_node_state(node, N_ONLINE)

  or

cgroup.cpuset.mems_allowed / mems_effective


Anyone that attempts to do:

    for_each_online_node(node):
        buf = alloc_pages_node(node, __GFP_THISNODE, NULL)

*will* get incidental access to private node memory, and it won't be
obvious to existing tooling that this should be considered a bug.


rate of occurance in the current code:
-----------------
node_online_map       -  21 instances
node_possible_map     -  25 instances
for_each_node         -  346 instances
for_each_online_node  -  67 instances
GFP_THISNODE          -  58 instances
(notes don't have mems_allowed/mems_effective instances)


But it's not always going to be obvious - since nodemasks and gfp_masks
get passed around as variables all throughout the kernel.

I ultimately determined that auditing this in-tree is already a fools
errand - and suggesting we try to validate this never occurs for all
future code moving forward is just not realistic in any sense.

I could not come up with a way to remove private nodes from
node_online/possible_map - and private nodes must be added to
cpuset.mems_allowed to allow cpuset control (otherwise all userland
access is blanket denied).

So I moved back to __GFP_PRIVATE.

=== TL;DR:

The core premise of private nodes is isolation first.

So we want this code:

   for node in cpuset.mems_allowed / online_map
       buf = alloc_pages_node(node, __GFP_THISNODE, NULL)

To explicitly fail - so that the caller knows they can't use these
masks this way anymore (it was already potentially a bug, but could
have been masked if all online nodes had memory).

~Gregory

