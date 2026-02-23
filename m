Return-Path: <cgroups+bounces-14145-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH22FMpqnGmcGAQAu9opvQ
	(envelope-from <cgroups+bounces-14145-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 15:57:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD5C178500
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FAB33076B40
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65102566E9;
	Mon, 23 Feb 2026 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UK48vArf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB024A069
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858509; cv=none; b=sghDgefJbY7UBZnVuYIuL3yVi+GwSHh3TGBic03ScFirOeyoL6l9yiY2KjZ+PG7q/O80wCj5gPxlUu06hql3TuW1VgBsmC7t+SuMP/URZMub4gDvHBu/L5HiTLp6gEVie+rgKr4VD4mAwYolhd7KDsMRhVXVWBGvrTmAlBgkICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858509; c=relaxed/simple;
	bh=EwLgLwdt857/iVMGq6pQA6+6jmF6tAKLgAXdu3hsyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8W62AazpGR9fwum0AeYy/aUgfvn4SK7cMV9uf08+kLSzDFuWy/Q6dYQQcxMkiMuadOze9apcUiPTZMtX1MNT8DTwX3qpQVPuzyqOj+m4G033xMBNH9R6Pk/tfqpWgDPUSmEq2anfN03/W8pdNgTW98NdfvUpHyfePFOjCU6pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UK48vArf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3a8494c5so416117485a.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771858507; x=1772463307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpjmdBXuQUotNZnT57UveTMGt/2pk8eLf+dmkyC2/50=;
        b=UK48vArf08KA5aTQnFg4R6N9JPDKtMRG8jDFipLeXsMcerBwfaMYS7qWhRwaxPFo23
         MptoD2XxdIVcLFDydvEjFYGs7Iv6O9a8T78ZhMUW90dnuqVOhdQjKF7TQ66radXtAjEz
         KPjB9YNTD4g2R0HMRhvTAr7uKXETR7/aOQ7fo5pW6rAVsdmhiD/tOhN1sEm0SiWz+Pph
         ZAfoaey1NWX2d3Ck0cEsmUaNI0aFl0bDWLw8/354ICn2iN7FTcnKjosR+vYRvAiWXjNq
         eWlDGe+kHfadsPDy3AA3XpawqBVQKcywy/YSO7VHniejTsPmvXArVJ930Jbfl6OMT2iD
         ofmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858507; x=1772463307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpjmdBXuQUotNZnT57UveTMGt/2pk8eLf+dmkyC2/50=;
        b=AdPZcs0LgBg2nYQOSWeXZi1KgPk6TZobOyiVW8cFst7t73+FirCsDjhhYVR06FW5Nj
         dAOG37o7veXN9WrLToCehj5eeRX1SQ/V8aR5vnqFCHXr8T49mkR0xsuuPuuF5jMSr0+c
         k8HsSNmFMUyTZ7amtlzj4QYT1Ce1kC1p+7prKCZGN0MVJe98iO88GL2u05KKFazuR2e/
         dhx4LY49oyzp97/KhabuskGtYKv9tOpg7jO0XE9LhayuGF/FbyzEElAJB54adEMrhW48
         UJfW/f1v7Fa8Y0LVU+V1uT9yDtarRc+k26+ZEC8GTAijw+jFW62Wsc//el4KBm1aG7X4
         rnAA==
X-Forwarded-Encrypted: i=1; AJvYcCXzaOMUe4pAqRDu1tc8TH1LezPtp2MQgjsk/2ggQkwCQ+FAsANLZbNQdVXWBzYaZcNycZ2v9L+w@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPql65WKeXeSvAmj3vayUcq4imuh762YwrS6vQw3MbQxHpIZl
	cnpwnXmVpz38fRB0zDrWQfRHq49TWQiT+j7dmYa2dZkMq7rHTH5SCmq7qd7YhbclUQs=
X-Gm-Gg: AZuq6aIK/IXUNbGsSQCgPrKPNH6iTwkOoD8buHLHIatMEZPyVOr0SNXKxFpC7MJsMoM
	OdmxMqwFHBzeQNzlh42Fk7Oe0jZCJqC/gyFtOxkySUUXTfor3hRW8bIAPyd1V9tA/FUovC2ma+L
	xXY6PFz12horMUPLQvnvDxac1vFbWrevgRneXlhOumtopcXb3LPLnlWiYGA9RlBzJ6XDyy2uNBD
	FkMebseLAVIwx4iZz1x20BlfZvbxvDQ74+FIChfgiqw/7gQ9N1yBYmQEkxjrrvOa3mcLNiYBwJF
	f9yL6vkqq4PDhr5uY1MpHNSHPng34BfiF+tdCod/um8uZoyv+zgyF917jBhZePilFiBkUa8enFJ
	LxXkkSyyte3cwzH6gzuFTDt8jBf8Jdz1eblE7+JKp8+6fB9mZ+db9sYkFQA96tPFxdYv0HqQmDX
	W9vWAt9ZDWmR19lUnuJDpw8XCKQY4w601PENMsIGuMk1X/fAfpJe+6dJmCbQOgq1tFTlpodBc9q
	Y2zBHQE5A==
X-Received: by 2002:a05:620a:1a18:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cb8ca0e16fmr993255985a.28.1771858506861;
        Mon, 23 Feb 2026 06:55:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ebcd0sm845419885a.28.2026.02.23.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:55:06 -0800 (PST)
Date: Mon, 23 Feb 2026 09:54:55 -0500
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
Message-ID: <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14145-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: AAD5C178500
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> > 
> > Gregory Price (27):
> >    numa: introduce N_MEMORY_PRIVATE node state
> >    mm,cpuset: gate allocations from N_MEMORY_PRIVATE behind __GFP_PRIVATE
> >    mm/page_alloc: add numa_zone_allowed() and wire it up
> >    mm/page_alloc: Add private node handling to build_zonelists
> >    mm: introduce folio_is_private_managed() unified predicate
> >    mm/mlock: skip mlock for managed-memory folios
> >    mm/madvise: skip madvise for managed-memory folios
> >    mm/ksm: skip KSM for managed-memory folios
> >    mm/khugepaged: skip private node folios when trying to collapse.
> >    mm/swap: add free_folio callback for folio release cleanup
> >    mm/huge_memory.c: add private node folio split notification callback
> >    mm/migrate: NP_OPS_MIGRATION - support private node user migration
> >    mm/mempolicy: NP_OPS_MEMPOLICY - support private node mempolicy
> >    mm/memory-tiers: NP_OPS_DEMOTION - support private node demotion
> >    mm/mprotect: NP_OPS_PROTECT_WRITE - gate PTE/PMD write-upgrades
> 
> I'm concerned about adding more special-casing (similar to what we already
> added for ZONE_DEVICE) all over the place.
> 
> Like the whole folio_managed_() stuff in mprotect.c
> 
> Having that said, sounds like a reasonable topic to discuss.
> 

It's a valid concern - and is why I tried to re-use as many of the
zone_device hooks as possible.  It does not seem zone_device has quite
the same semantics for a case like this, so I had to make something new.

DEVICE_COHERENT injects a temporary swap entry to allow the device to do
a large atomic operation - then the page table is restored and the CPU
is free to change entries as it pleases.

Another option would be to add the hook to vma_wants_writenotify()
instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.

This would require adding a vma flag - or maybe a count of protected /
device pages.

int mprotect_fixup() {
    ...
    if (vma_wants_manual_pte_write_upgrade(vma))
        mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
}

bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
{
    if (vma->managed_wrprotect)
        return true;
}

That would localize the change in folio_managed_fixup_migration_pte() :

static inline pte_t folio_managed_fixup_migration_pte(struct page *new,
                                                      pte_t pte,
                                                      pte_t old_pte,
                                                      struct vm_area_struct *vma)
{
    ...
    } else if (folio_managed_wrprotect(page_folio(new))) {
        pte = pte_wrprotect(pte);
+       atomic_inc(&vma->managed_wrprotect);
    }
    return pte;
}

This would cover both the huge_memory.c and mprotect, and maybe that's
just generally cleaner? I can try that to see if it actually works.

~Gregory

