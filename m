Return-Path: <cgroups+bounces-17001-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id omViADlUMWqegwUAu9opvQ
	(envelope-from <cgroups+bounces-17001-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 15:48:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6AD690169
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 15:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=LCkTe2IB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17001-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17001-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0494E30942CA
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9E33C182;
	Tue, 16 Jun 2026 13:47:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4F332EAE
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 13:47:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617634; cv=none; b=sHcnqHtFx+3jKnFMaqVRx9lbRwSVjvBQAfzR+758sbDihhL0RFVGg3cexO299Nn9ChR+UI4qAsXFDRWijHqNOvIRb06voDq+9HvDCBV+TXO8tqC3boAFSCn0LZUWKmOFskOiUDd9avLdJmbwxMqp0q0p+mfC2+LFo/J5A/6VmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617634; c=relaxed/simple;
	bh=ON5XRz8lHOpOJ8xktgKhULmQK7Hl4dNNx6xl4pP0U7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4kUzNGniSJY5etw2pBfp3zxmOSdYnPUuLCMrrnzcmij9c1l+w0T5XD28z5DteZPNZ9SBdTgKM84n8GkGPzfku4nXei9bGMpWiFD/R1seGpQU3rGPLAEGrVuefC4QWieipGmzHPrNPTdqgFuzISErmltHp62hbE5EZieFJGD/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LCkTe2IB; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51788280e71so50753631cf.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781617632; x=1782222432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvNzegJ7+heyexsBUGAQ0jwoVUjk7efTCiVuRf1VOy0=;
        b=LCkTe2IBkv5qsv/rAmGrOexkI/ZfXf5q6AV8BqKMOOZ+sHg78vk69hSs+G8iRTCY5v
         cBhcigAqcSSFuNUN6XPPFKundVuwRQFhop+/+/fUKrv3GG/rLB7va1VT2qASgn0EHkQH
         fIHaDBVjEL5IiGHZs1jE6KCzQxaM+SSybNLhFBQj9Uwl3v/L2i+i6lch40EIrpPmaVFQ
         c55fGSwNOIdqM4IPGd8JBp7QTkM8ULCKMIFgubmM5K7RtnuAWHk0qvXXik2UHAk/NcMx
         SuBqjt0rDc3YlRFJu1MXZNOhDqTDk5tk3S0IND+cMCL74Nhq+x5UQ3pvsyhBUR8CUkD8
         WwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617632; x=1782222432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvNzegJ7+heyexsBUGAQ0jwoVUjk7efTCiVuRf1VOy0=;
        b=eiWLhiVUSj9j6Sp2fX2HWW2twMouzUQZ4pu1hxLqCDKoOqP/g6mTbO33MhwOVHz/pj
         Tog1rosSKmFoZ5l9FCQgapFtLqRTAphCMdFpe9lg6YPGLey3AGijqemjLkf4q32G5dlW
         76zzQsCxBxKiKbHvycaxXC3WiCnYQtyCNvKnqgAwkf2q0EXDCBAZohPmzSZk8ya6bikh
         7qFx3F+eceQIDJhva7i/BUw8yZyNlGk/PDT7gjOR5NbGdzw5iAIn9Js9uUMUu13dmXmp
         CseIULBCINw8prK2x80stKfvf9iXNkrL3D18/SCobaKO81qK6afyuiBAA7nsVnmnJcUv
         ck1w==
X-Forwarded-Encrypted: i=1; AFNElJ/LIynp8sBqBNHhJkhs/nftW8+gJ9Nkx8ypTsfIRmGgzhTLKIIe+adBpynWcWY7P5RqhvLi9+p1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3B3jp4/vaViGDXSs1eX1/7S5gT/YDHk5zu4JgeJQfvgIqASMs
	DCzLqtyi4zSedkPHVQ4eXryISNFjXRbR4PLNjd1DJBsAn/OdkhWDNzfS7Zuyy6TQhk8=
X-Gm-Gg: Acq92OEF0zOy2MWQhmnLoBWgFOHGtGqyvvi7F0AdWNilqjJgR6/M7/qwjNxKk/8Tee0
	1E+1UdX675QpfPawObHzMs7xEZ7rbO6sbqj0psMHiDjWPgwzc+M4uqbfMyt4CiJgOfTEFf38ubW
	WMSu+fmvppUdULfTrg1q/6MuwLDZxIt6XMlOtJFZsaCcCE/ng0RAwapI5y8RFbwBbUTPAIjOccB
	Jss2e6g+/9n7cOmcjAfPph1tjjThGe6mRvDtfMr2Z3NDBsRYewo2t48d4WdKy10Vrh4FwsV5aYi
	znsheheht473ef6qUHOdciAo0+1Yij1tkfBNvYlzt8zw59dnlElHjqef4WrYRLyOZFb2RjWMx9k
	w2z7bjwWDFdmw4s19VSy97AlbcsGZ4zX3YpxCOyXUgBbjPmSkpu1TU6EiHK20oYTiryXQXtyM1c
	o1SoX9AsazQDXgM5Vgnhyh
X-Received: by 2002:a05:622a:a6d4:b0:517:7e3a:5ee1 with SMTP id d75a77b69052e-519916d65f2mr43449041cf.1.1781617631680;
        Tue, 16 Jun 2026 06:47:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:437e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb84188asm150577021cf.29.2026.06.16.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:47:10 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:47:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory
 Nodes (w/ Compressed RAM)
Message-ID: <ajFT235iYsSJ7nbR@gourry-fedora-PF4VCD3F>
References: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
 <DJAGEUY8S09F.3V3HF570G85OF@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJAGEUY8S09F.3V3HF570G85OF@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17001-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brendan.jackman@linux.dev,m:vbabka@kernel.org,m:david@kernel.org,m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@
 google.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E6AD690169

On Tue, Jun 16, 2026 at 11:57:42AM +0000, Brendan Jackman wrote:
> On Mon Jun 15, 2026 at 2:38 PM UTC, Vlastimil Babka (SUSE) wrote:
> > On 6/12/26 17:29, Gregory Price wrote:
> >> On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
> >>> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
> >>> > > 
> >
> > I think the memalloc approach is dangerous due to unexpected nesting. There
> > might be nested page allocations in page allocation itself (due to some
> > debugging option). But also interrupts do not change what "current" points
> > to. Suddenly those could start requesting folios and/or private nodes and be
> > surprised, I'm afraid.
> 
> Minor side-note: couldn't we just define it such that the allocator
> ignores the context when not in_task() (and warn if you try to enter the
> context while not currently in_task())?
> 
> (Don't think this would change the conclusion very much, e.g. doesn't
> help with the nesting issues. Mostly curious in case I'm missing a
> detail here).
>

I looked at this - only solves one issue and oh boy is that an obtuse
confusing condition to understand.  We still suffer from recursion in
reclaim.

~Gregory

