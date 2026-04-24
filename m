Return-Path: <cgroups+bounces-15491-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJFpLAfs6mnCFgAAu9opvQ
	(envelope-from <cgroups+bounces-15491-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:05:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0901459A35
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF4743004D89
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 04:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729EA331A64;
	Fri, 24 Apr 2026 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LE5Ak+/H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D3325714
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003436; cv=none; b=D5oCZ3SgzZCfjhYjFHDUYX8iO2flxGsBsJ8ziHfRxFOdaLDRjOxykRzeQhRKurYqKxnaSVA+f6JBBX3JBYx4nMhz4Fpk80C8Ee3LHDMNcf1uGTIVEDKsdegDQAqP2s+nc/UqfJP9zwWcM+nxa+huH6W66iugNfAhBZYF7RgE8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003436; c=relaxed/simple;
	bh=vFgN2he2wn7NXny2fx3vIJs8kMnvkzqTUSZ0mPgUoMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1NLDBMHLHtngPiE2oTsvmw7XqsQiGVPwgArL2ZCI9WDDppt2vA54GkBbWZ7kwcFDDl/jsASdERHU83x3dpyBdIkgFaN6sfaC4r7xPQumvqKBn8xlMIorH6cEJyHx96HTSP4MJVY0EQLYDF83d0VhQXQBpqJCb3TdZAUVAuieUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LE5Ak+/H; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb856a674so88634096d6.0
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777003433; x=1777608233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0FSatf25bGDOpWwH0IGYTUNBidZ18cuj6W5qCjaLYU=;
        b=LE5Ak+/Hq4WkxgBgHnsjhWLAGCQZ28AIxOFH5UUuXNJcW9XvsrE1KGN50Ei3W5EyTa
         SCXQHvs/IJC36gZukDdtk3L/nIS9yD4LyRD2IaMGsBO8Unphd4emO2xP+PGUrNC3MPQK
         NtQPdOVFXFH5LAEiSvtf0/tc0s5aWPnEieXa9x25jzrFPIeFLO+bVtw5/EX99eoDVozR
         pHldb4B0SzyA/8lwf5yMQPXg9pwUmO9g/XIAZxDVi50e8Sj5SqF0gG2LIfmGYtSq62ov
         yH9squnmpC553pKeu75AkKkiNaMzRXP+2j7xn2RtYkEPbEOa0+LfSnJo32ETianLvZJl
         WMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777003433; x=1777608233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0FSatf25bGDOpWwH0IGYTUNBidZ18cuj6W5qCjaLYU=;
        b=XuCn/MUdomfFDjIlxIpM3U5ZQgQOa8AMmJpBAUhgUNWd6dBv+88mQ3NYgL1eKPJ06I
         c2PwOPuJ+emcajA0nZpRMHvQUurhxASiB7VznHDT0o5fil30LgvlOwOpgAfVH+M6Tniz
         7QisV6yTstiY6fNC7zmAwir10wtc4m+sLYp93xEI6CZqwDXW+tdkvpLmN1j01g6eewie
         mstdE5dUE60/5uQDic4ilUNff7ktUfzMxcuEnEHCWTFbv1K/tgbVS+BDzrzZSIN2HW/j
         udA4wlhhIOCZJw0wGzNwUX56oXzbgrQyHz6p85+rCJqk9H/DW9U+kwp06NvzLwX9FRV0
         jxMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tGj50RrKROIZgUU7NYJkLyHqUgskzEBR8ZF9vwS6kLYzAK0Jxk29fPfuhI11rOZqMmfLSpOzl@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYC3pIvmhhQguRPZJRLrgIOW8L8WBco2jIBZa29NQEJZ6zi4i
	fpUSmCy5Q48WlwVQ9ynnBxMQjvowrt6kMgBMBH3pVA8mFKh4l0orw43Q6OPAS8N2ETA=
X-Gm-Gg: AeBDieslBmKW5Rqp7G8v8s2dvWuoX6lz6KFpuVD5bnRTHbQ8SOD5/IcP0xyWLD0X2X5
	a82Z+WVKTrLEI36dgQdPL6Sb4f62x6tPs6j2IuFkJW5g3oRu85TvqH8Jp/gJ90yzAk38MEEEcBK
	8hxcJIoy8d94H4ZUPm9tnz3twJi5A66MadqXRrZPlzUDtav30nQaYjyU4sCUYloVjnIBfYg06hp
	DPjO7xnYDW1i+JKHjupDhtSIGEtmbo0U11bGwsODXQM1Cgh1yp2EHjoIkAMbq0E9hRpqX8ex1vk
	Khtkyd13gNKELBpPGodfGQwVu1eLJ4ejH/0nSOoHrCgvF/l/ybmT/4ASqVu+bvvqta9l5GZRpk+
	ndGTG2wD7KTQaCF4FNXk3mOAR5VOx0c47QYzEgruxgjWTSzLv5m+Kgizko6sL2eBQJtiUn+5ptO
	sdwx+fenp8JrDdfubeubhey4kVhkLIyVdW78IBEbF5ioZCmKYrStmsek2rEw9lK2t7Kg52bbDSA
	ESjrioFQOt2nrVqsA==
X-Received: by 2002:a05:6214:5b86:b0:89c:cfa9:f1fe with SMTP id 6a1803df08f44-8b028324ee8mr410764656d6.2.1777003433560;
        Thu, 23 Apr 2026 21:03:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-70-94.washdc.fios.verizon.net. [173.79.70.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae97d89sm178440226d6.42.2026.04.23.21.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 21:03:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:03:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, hannes@cmpxchg.org, hughd@google.com,
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev,
	lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org,
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org,
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <aerrps94j70MkgdW@gourry-fedora-PF4VCD3F>
References: <20260320192735.748051-1-nphamcs@gmail.com>
 <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com>
 <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
X-Rspamd-Queue-Id: D0901459A35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15491-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 01:47:50PM -0700, Yosry Ahmed wrote:
> 
> IOW, I think the whole reason we want a virtual layer is to separate
> the backends, which would facilitate tiering. If the virtual layer is
> itself a swapfile, wouldn't it become one of the tiers?
> 

Sorry to add to the fun, but i do think this is mildly relevant.

I've been testing hardware-compressed RAM as a swap tier (CRAM) w/ vswap.

Will hopefully be publishing soon - but was waiting to see how vswap
would go first.  But I think this is a good insertion point.

With vswap - this integration was so absurdly clean.  We just add
VSWAP_CRAM and being able to writeback the folio to zswap or regular
swap was surprisingly straightforward.

The alternative was to inherit an absurd amount of boilerplate from
zswap, and then the complexity explodes if you have to decide whether to
go to backend X or backend Y.

So I just wanted to say, in support of this series, there is functional
value in the virtualization here that isn't fully represented by just
zswap/zram/swap interactions.

> I think this was discussed before but I still wonder if we really need
> a reverse mapping, if it's only to optimize swapoff then I don't think
> it's a requirement. We can still scan the virtual swap layer to look
> for slots to swapin. It would still be better than scanning the page
> tables as we do today. But I think there were other use cases for the
> reverse mapping, I just forgot what they were.

For the sake of discussion - there may be value in the reverse map for
CRAM, since it can soft-fault its folios into page tables read-only.  In
this case, you can have multiple mappers in various states (softleaf vs
read-only).

In the case that you want to writeback a multi-state cram folio, the
reverse mapping may be useful.  Right now I'm using rmap, but maybe
there's an optimization here.

Maybe not worth it "until something actually uses it" though.

~Gregory

