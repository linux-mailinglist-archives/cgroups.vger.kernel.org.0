Return-Path: <cgroups+bounces-14221-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ii9NrvKnWmxSAQAu9opvQ
	(envelope-from <cgroups+bounces-14221-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 16:58:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF9189746
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1CBE3004636
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07331519B4;
	Tue, 24 Feb 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Bi2bxutr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAF3A0B21
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948726; cv=none; b=H3xcE0N10YEs6xDF41Qhn5sxp8JwOXaF9+kR+fiN2VAkXA3bOg0QdF5xVQf/MHAo2aGj0AGY7nNoaRus5359L/QAUFTTI8lygjvavoY1cRMev5Y21rU7C5ttdb27ac043lMhePShmtiB9wK5992jA29YnFL5NFZfSvSdQ5BMAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948726; c=relaxed/simple;
	bh=t1S/lyFT3Tly1pHl3bf4eCsWNS2vHQC8ZOIOI5m87rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjOR/4ojMvc7dGuvwngVwXbmaYb0FUcaJiOzHqJEzBOc4Du6MJwKFK6k/+dm6Rc4kuvQdOvjzRE0T5hU+A+KZbKpEZE9v8jGowGNOBv3zgzdFgcHWYxq8RCb/EYdmJ/fb3uplJfI9nvJ6/HhTQzfs1e1JaRPIkZ564zlhlJi1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Bi2bxutr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89577f866d6so72083256d6.0
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771948723; x=1772553523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K0Cl8twM23eFbKY4o+AiEr3XIzEfi52x6hS0RyhMeTs=;
        b=Bi2bxutrWtX3OrlH0ZSrapi1UxzL5zcma6ciw1lBLniaA2bsXaC2Vpa3cpDJ/Ccnzq
         iT/7+yDLtL2JbnQgGGacj4jWmPzN3fY7V4sqSxnE4XENaIoAyWgazhhgyv4si1P9jSUS
         nnA+QOzL5Wj+NTzzb4djC9r20EogVfI6JLnCDc2hzBkH98LjnBORayKAtg10QmTgR3Zu
         kDvA6TWyDNNhEkdu6K8C8zV2YFjhhlArUAyqFTwZcer3TwhE6yvvFha1sPqny0CyjIMg
         nYg+8kBc9Vs7+3pyjBnqKByZ1WVmdSWQgE6TxftnYvhXwn8QJBk5zWdzrOIHE71zIsPf
         5kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771948723; x=1772553523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0Cl8twM23eFbKY4o+AiEr3XIzEfi52x6hS0RyhMeTs=;
        b=QovjrR7XqYVQ2ZA7OtY9DNNlmOiNGHOtV5Q7dxbMdeB4ngWlpOn0uwON8Siitfj/lX
         qeIeamY+/CoeDnT/x9iWO/trjHJ0GLMKu8kU3nzxTfh0aU/r2SVr29kYI4jNU5w5oAaR
         /RV0WRtrfM9OQ1nx17gQA3jVtB8VSbfSvNsmbZOlt5GKPND2LoA6HlFWoGw5Z4Y5tKcq
         ONIPofUcEXT/K2Wl8HO9RMotkMxzbfBlJmSIg8eo8KQvy8LE7Y0WYA5DICG+tH2Hg+ek
         z4nfuQhWLuKhrhXoYW3QP0Bq2XKUGGkbmRywu/J4BSR1tljsh8QoVFrH0SxC1UQv6VFF
         XQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTZtl6xkbQTh631OBGtlLv+e5A3bXe7Jyxw4DFg2UEjE3cNRXlynQW1DY/cccLgo5PMgfDdoZs@vger.kernel.org
X-Gm-Message-State: AOJu0YyGk3/hfh5M3+fFIpuyC1W7xUGs4nnsK512ThwQKXOCvXhsk4Pu
	akSmYuyYYDOCKjI/fCslCCA+oB7Ou6esID6FAdya9/a9cbOs1JlWhozjc+6+ve9NfG0=
X-Gm-Gg: ATEYQzx28Yo6xRfQWL1sT++1H0x7TDszEd9syPOz8WjPXktN7phgd/esi4bRZbDI+OA
	VbP7Pc8qp5pBUpN6AOTVIv5stv4Q8yIS+7iXP4+u4R3RktCxMgphDpo1NUCOFrdyCs+W4kmItei
	fUIeLp+aWPju2gH5UGYXyzc4vSeyeluJNR+nNBgakWaYI8f9n1Jeja86FWIFg+tArJe+lekBSgY
	XtI8JMSynkS+jD/+mh7PvK7LJg1Et7JlB/vrnsHPHmpmoCcbuOhKS/yu8kgEugL5CWbMFkKx5Ya
	QV8f3Mp+7MskC5u7OU02/3tv08sLrhO7kcRG8UxCIMQhkVBLw5WvdAptiq6CotANtT7tiX/LGU4
	T7mHRwmnhQPVmm7wEKeQJZ68EnKGn5KQJlagefos71ffGanN3aVp20SjYzZxJfYRU/F6p++pQGF
	J3/nJgxxaiTwUEH9E8nyGPEQ==
X-Received: by 2002:a05:6214:e4d:b0:880:88cf:59ff with SMTP id 6a1803df08f44-899b34f0ec0mr7442706d6.22.1771948722556;
        Tue, 24 Feb 2026 07:58:42 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ebcd0sm1219652585a.28.2026.02.24.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:58:41 -0800 (PST)
Date: Tue, 24 Feb 2026 10:58:37 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 08/15] mm, swap: store and check memcg info in the
 swap table
Message-ID: <aZ3KrfD_6vfxjRcs@cmpxchg.org>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-8-104795d19815@tencent.com>
 <aZyCJ6pH4hey-ZoU@cmpxchg.org>
 <CAMgjq7Aq5ckraKtNtet8+1ANuqnitFsXxefbDJQZpBxNmaW7Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7Aq5ckraKtNtet8+1ANuqnitFsXxefbDJQZpBxNmaW7Cg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14221-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,linux-foundation.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:mid,cmpxchg.org:dkim,cmpxchg.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BDF9189746
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:34:00PM +0800, Kairui Song wrote:
> On Tue, Feb 24, 2026 at 12:46 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, Feb 20, 2026 at 07:42:09AM +0800, Kairui Song via B4 Relay wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > To prepare for merging the swap_cgroup_ctrl into the swap table, store
> > > the memcg info in the swap table on swapout.
> > >
> > > This is done by using the existing shadow format.
> > >
> > > Note this also changes the refault counting at the nearest online memcg
> > > level:
> > >
> > > Unlike file folios, anon folios are mostly exclusive to one mem cgroup,
> > > and each cgroup is likely to have different characteristics.
> >
> > This is not correct.
> >
> > As much as I like the idea of storing the swap_cgroup association
> > inside the shadow entry, the refault evaluation needs to happen at the
> > level that drove eviction.
> >
> > Consider a workload that is split into cgroups purely for accounting,
> > not for setting different limits:
> >
> > workload (limit domain)
> > `- component A
> > `- component B
> >
> > This means the two components must compete freely, and it must behave
> > as if there is only one LRU. When pages get reclaimed in a round-robin
> > fashion, both A and B get aged at the same pace. Likewise, when pages
> > in A refault, they must challenge the *combined* workingset of both A
> > and B, not just the local pages.
> >
> > Otherwise, you risk retaining stale workingset in one subgroup while
> > the other one is thrashing. This breaks userspace expectations.
> >
> 
> Hi Johannes, thanks for pointing this out.
> 
> I'm just not sure how much of a real problem this is. The refault
> challenge change was made in commit b910718a948a which was before anon
> shadow was introduced. And shadows could get reclaimed, especially
> when under pressure (and we could be doing that again by reclaiming
> full_clusters with swap tables). And MGLRU simply ignores the
> target_memcg here yet it performs surprisingly well with multiple
> memcg setups. And I did find a comment in workingset.c saying the
> kernel used to activate all pages, which is also fine. And that commit
> also mentioned the active list shrinking, but anon active list gets
> shrinked just fine without refault feedback in shrink_lruvec under
> can_age_anon_pages.

                    *if inactive anon is empty, as part of the second
                     chance logic

Please try to understand *why* this code is the way it is before
throwing it all out. It was driven by real production problems. The
fact that some workloads don't care is not prove that many don't hurt
if you break this.

Anon refault detection was added for that reason: Once you have swap,
you facilitate anon workingsets that exceed memory capacity. At that
point, cache replacement strategies apply. Scan resistance matters.

With fast modern compression and flash swap, the anon set alone can be
larger than memory capacity. Everything that
6a3ed2123a78de22a9e2b2855068a8d89f8e14f4 says about file cache starts
applying to anonymous pages: you don't want to throw out the hot anon
workingset just because somebody is doing a one-off burst scan through
a larger set of cold, swapped out pages.

Like I said in the LSFMM thread, there is no difference between anon
and file. There didn't use to be historically. The LRU lists were
split mechanically because noswap systems became common (lots of RAM +
rotational drives = sad swap) and there was no point in scanning/aging
anonymous memory if there is no swap space.

But no reasonable argument has been put forth why anon should be aged
completely differently than file when you DO have swap.

There is more explanation of Why for the cgroup behavior in the cover
letter portion of 53138cea7f398d2cdd0fa22adeec7e16093e1ebd.

