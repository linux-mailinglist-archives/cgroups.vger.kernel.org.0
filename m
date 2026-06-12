Return-Path: <cgroups+bounces-16902-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KnA5Mu4lLGr2MAQAu9opvQ
	(envelope-from <cgroups+bounces-16902-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 17:29:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAEB67A84D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 17:29:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=K1bIzaql;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16902-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16902-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74683300B1A3
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED8349CD0;
	Fri, 12 Jun 2026 15:29:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071A346E72
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 15:29:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278185; cv=none; b=sOUtFBuVxUxamXcwzRFE4JItm1c2pPzJ5XO3+fQt/cP8HqW9aN+kQ8UHTmYGQZyYguRbAYm394a4wJaCkfHcGtDKN9V9oMlDaC4LNfSZfsNCHGG08OldIDzoRxi9BO6TqnPf5Us9/kQLVitvyhnbo1VMGQIfGQEN8O2alpItENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278185; c=relaxed/simple;
	bh=mVnLEdPsEZ4bwU/Ei3LWYtLLBe2x/ajf/pLUxSqCLVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IffscQIzDT6vXBQ+effGVsNDnRhtE3vdo3/2i/L5ewCPk5gUgklGb5DsSBvPB/8TPztY88/rlyzZnweTmz3kvoYcVDqVsinRF2KCYZbgs//itidI/AC9KEaGGPYI7Rn0v36Rz4p5mbqpEHEFY8XoX5Xoj3PvKQ1lOoOauOALC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K1bIzaql; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51776b4de37so9180591cf.1
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781278183; x=1781882983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGTIoUK/OWYjJAAY1+ZmAOAhqsOqMD1OUbmAHjFef1Y=;
        b=K1bIzaqleRmv6I9IUmhsv2jcoLba2fJJFC1vzoGElN4JNWQYZSY2iw6COwt9IpCVPi
         HceY2zcM6PrcDrijB787Yg50WsXLzVDns/vEeg+pV1yiJHIhdEH2IxRuAI2XyCSw0ay8
         gLUsl3pFsW5nPQx2MN48OeZrS+hC6A0brcTkSli0VejhkElL4j/FvIwGq6GlWhL114cC
         EsnqwZLFOeT2xwgBInMmxMlB3z858KT+BMyNILpcdDJms151iSH79ih/dLELmVKzTGT2
         KV9Ztq1twFuWtXoqOi7xa7+QBLAN6x4tc0oubXkXSdsrrFKn+Ol2HMVdH5CJBAX+wK6+
         zv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278183; x=1781882983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGTIoUK/OWYjJAAY1+ZmAOAhqsOqMD1OUbmAHjFef1Y=;
        b=XrDwOHDIRRocZhiiwpz8fJJjDGWvReV5c3W3bGcVaoKKnroNSc2Dwyw7M4tFW64e3Y
         MuELiNRAMbvTizc1WkbYjij7oer6AcUbWMh4I6xVQf54BXdxvW3lkqhJInqNz77CChdp
         ceVbDA29jJ2QWFnNMmf850NREms0DgOPOFQoPpvE5T5+4ySuMX3xoK/r5R0BSmfrvtk+
         8Wglh5sv3yfJKTC/lIw57O+Yo5rTFzl48VzqZxauBc0x6CzkqMyx8A970aRgqZ6aZtZA
         6aahtVeQ0obx+XRQ6E0wMVXZM6kjIZ64EJe1xpR6GP8ISdRgPgnFrKg+uWJCkYteAVvW
         nNCA==
X-Forwarded-Encrypted: i=1; AFNElJ8UzfUvNhVGpLseeN6jp2Y7xmiHISNhxLp4Bf4/I0Wv1in7X0ICWxirjooZdPAtYQMH2BuVriG/@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6jHTV+FPgsDhMFCEeXHM5A4yC9H2zer08s2NXhWTC/dKvWdW
	Cpxz2LIExdtmYmSj4WPw5Mf9OSWipyZeKD+dbFkWrAHIdqI1jpTTJFscjQBx0JTga/Q=
X-Gm-Gg: Acq92OF+jsqSJ5U3yV7ZvWwImHoZ2wTLl+zRG8PP4PSHJc30zfyb+72fjVr0j2nsmJe
	5RPk5CfXpbXvsOk7NNpdrbcqTdzCgTTWTC5Fk4lPIEiUXHPuMJ9ile8cOiiP7NWqigrmS/CM4Ma
	ER8X/4fDTM4NWnt4xp3LIr3iACp/xFnAE5/C1txaCn89H62lYACo6Ao93B16NmkqSJcyB6le8i3
	ETb/RwdRwLFR3kJQ1hWjuzlvkDS+eXSJTPfJ8p1d3RYh5XHImO0Ino9AWhZP9YF6uYzDVC3vZag
	SmuSXLP4CJTtJm9LI2a0/I5Tt4kBk9hXhLmz/6MRHAG7S8M62PVwNCZ5LQxd6AtJucluUeE4Cnq
	8MvnsXIugJ0j0X1NPc8PcBL9HvKPi/L87XbdN8dsR8nqq/DP+L42wNfs+XbrpEqeh/pyD5VxEfI
	q2Kpl/2ZxZH00Zr7FHhX1Z7lZCF6Nm9jLCROKMpM191yrpsg1BJr1Y3dUA6/4KrjzH/V6rYH8m6
	my1i+U=
X-Received: by 2002:a05:622a:1445:b0:516:ce43:f4ee with SMTP id d75a77b69052e-51953395db3mr1534991cf.20.1781278182636;
        Fri, 12 Jun 2026 08:29:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7ec47asm23782211cf.24.2026.06.12.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:29:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:29:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
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
Message-ID: <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
References: <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16902-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmus
 villemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
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
	RCPT_COUNT_GT_50(0.00)[74];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EAEB67A84D

On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
> > > 
> > > I understand this question in two ways:
> > > 
> > >   1) Can we disallow PAGE allocation and limit this to FOLIO allocation
> > 
> > Yes. Can we only allow folios to be allocated from private memory nodes. So let
> > me reply to that one below.
> > 
> ... snip ...
> > 
> > At LSF/MM we talked about how GFP flags are bad and how deriving stuff from the
> > context might be better. I think there was also talk about how the memalloc_*
> > interface might be a better way forward. Maybe we would start giving the
> > allocator more context ("we are allocating a folio").
> > 
> > The following is incomplete (esp. hugetlb stuff I assume), just as some idea:
> >
> 
> I will still probably send the next RFC version tomorrow or friday,
> as I want to get some eyes on the __GFP_PRIVATE-less pattern.
> 
> Also, I made a new `anondax` driver which enables userland testing
> of this functionality without any specialty hardware.
> 

(apologies for the length of this email: this will all be covered in
the coming cover letter, but I just wanted to share a bit of a preview)

===

Just another small update - I am planning to post the RFC today once i
get some mild cleanup done.  It will be based on the dax atomic hotplug

https://lore.kernel.org/linux-mm/20260605211911.2160954-1-gourry@gourry.net/

But a couple specific details regarding the memalloc pieces that i've
learned the past couple of days playing with it.

1) memalloc_folio is required to ensure non-folio allocations don't land
   on the private node, even if it happens within a memalloc_private
   context.  Since memalloc_folio may be useful in contexts outside of
   private nodes, I kept this as a separate flag.

   If we think there will *never* be additional users of memalloc_folio,
   then we could fold _folio into _private to save the flag for now and
   add it back when we actually need it.

2) memalloc_private is needed to unlock private nodes, but in the
   original NOFALLBACK-only design, you also needed __GFP_THISNODE.

   This is *highly* restrictive.  I found when playing with mbind that
   MPOL_BIND + __GFP_THISNODE generates a WARN (valid WARN, it normally
   implies a bug). 

   That leads me to #3

3) If a private node is opted into something like Demotion (the node is
   a demotion target) or mbind(), such that normal kernel operation can
   place memory there - it's *pseudo-private*, and should actually land
   in it's own FALLBACK list (reachable without __GFP_THISNODE, but not
   reachable as a normal fallback allocation target).

I'm still playing with this, but I think we can even omit the
__GFP_THISNODE requirement (my initial feeling that __GFP_THISNODE
didn't buy us anything in particular seems to have panned out).

At the end of the day, this makes the whole memalloc_private_save()
pattern a heck of a lot cleaner than trying fiddle with GFP.

I think you will all enjoy how clean the code ends up, and how easily
testable it is.

As a testbed I've implement an anondax (we can discuss naming) that
adds some sample NODE_PRIVATE_OPT_* flags so you can do the following.

I'm including this in the next RFC - but we can hack the entire thing
off (including the OPT flags) if we prefer to just get the base set in
without a new driver as a start.

echo 1 > dax0.0/reclaim   # kswapd and reclaim run normally on this node
echo 1 > dax0.0/demotion  # it is a demotion target
echo 1 > dax0.0/mbind     # mbind() can target this node for anon-vma's
echo 1 > dax0.0/madvise   # allow madvise() to operate on its folios
echo 1 > dax0.0/numa_balance  # allow numa balancing for this node
echo 1 > dax0.0/ltpin     # allow GUP longterm pin to operate normally
echo * > dax0.0/adistance # set the adistance for hotplug time
echo * > dax0.0/hotplug   # same as kmem/hotplug

This also means *existing hardware* can leverage private nodes if
they're capable of generating a dax device.

I've even gotten it such that you can put a private node above dram in
the adistance heirarchy - which means demotion flows downward from
device to CPU, but allocations don't default or fallback there.

This seems *immediately* useful for a variety of use cases.

~Gregory

