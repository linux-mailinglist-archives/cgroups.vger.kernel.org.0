Return-Path: <cgroups+bounces-15335-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJpjEDVF4WlErAAAu9opvQ
	(envelope-from <cgroups+bounces-15335-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 22:23:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA941498A
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 22:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC2C0301EDBF
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD52C0F8C;
	Thu, 16 Apr 2026 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uxnbTcmG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358932C0268
	for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370994; cv=none; b=XxcDJBACm2PZN/4F+NzD9/WrX6K3XgnhFg9dEI/5wwHPMgLft8vlyA8jRyOF3FYevy0/VfBw6BnzT1jehNjo4M+KMhSLtMbtpoR/oXGgIPYJ8R49ztbVjQGHlSWLg7P2HkPpAVKXqVMNK4X5WDltU7X+13pBTYkjVb/GM8BDVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370994; c=relaxed/simple;
	bh=/jHN3AKrXKDhewo5A4ppG7b+41Xeu+rziVT/eh08bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjaD02FS9tYvt4TnSgaAiO6TUl6Fna/Z9O43ewzPo8chGRbEUiEVa/++Azd8ng3p1CWbBDNL4wqu3cIP+WsZSaKaHKWByJbsIbE+mh+z3gm3GdJakukmUETUdCwnM55sqDBxRk5h8x56LnV5botp6kUHvlSBHzRZetnfWyzQlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uxnbTcmG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50de80b9567so42638921cf.0
        for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776370992; x=1776975792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQIC/zWz5OJ08TBOSJwx1m1q+xpY5Pl9ONSV8Ev4djw=;
        b=uxnbTcmGcyjxqVHuWZqJ9OckKCFgnYarPQ965GpLUwI5pVDxfogLlDNeuBCPedAcrO
         nlvqIRLQYrtJe72ihtLgGHgrC1myR3O+EWrzJybE37/OIMxHiEsSrt5zdG6KyShnAz1F
         3NlEanODL+1+YjHfNjfjJZTv+ZFj4n3j2/sWps68IVzeifI7zHk8pS79AnFZz2gBbTT9
         4gmIQU8KbB+rm9nSOd9smTOUulfubLU85Hw2XLHRM08J668JeRdFdX/AnaHKmYuCWlai
         zEK1r73u9jw3gTKVYu2yNUF5VH5ncJN9+Tv+y5FcujDa1KL5RcrX6MX8J73ctBWDUN0F
         OUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370992; x=1776975792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQIC/zWz5OJ08TBOSJwx1m1q+xpY5Pl9ONSV8Ev4djw=;
        b=eY19bUicSk5zO8l8Lb4Mn9b5Vu6n8GSSagYk9oaIoDW6l0/dvrE/GuMt8aB//Ki3rp
         hvkSj9GCX0Fp8x6rYeSq1smi3+tMvguH4emD742n2mZpou4bc4V3w2ezbRnkzJqA5ZuE
         DGqATyqBcv/PY39rNyALMv43UXwv0reRulz4wLTG3pgeifZpceUvnr9uA5bOvea2PD/R
         qYSZ5t/j3F7kmOzDwSYxJRPfw6ZkjYVqzPECqVCr0jIyoJMyRGHxOoOxN+u+6e7Ef4mh
         Fg4Z/SE3u2Tes3FWGglp+eJKZvcCQcN8RXeSjokjqVuLNgn8BTg/xNvXf2+qsqUGnA6X
         kWgg==
X-Forwarded-Encrypted: i=1; AFNElJ9Lk89C3KdbZlKS7TAjjTZ5u8/aXZGDoUMrwOxoeBTglOp1DXCggaZinKrsHHpTYvaHPet0caDb@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNvFH7Jo5xipFkrnTMEj5Gm9InBeTeYgoErqmDhrd7kqQnKYN
	aV/kb8X8iwHF2GxuV+LyUZsUOmfLcqfT5Lq22AJVzxZjjIQJ6TPli7hCsIGR/eyYBQo=
X-Gm-Gg: AeBDievOc4BA1z7zdNJSW1yuqwhP7jzKMguoHwWYHvGw9kRP0ZvLlMfVAv7n8bT2eIW
	UCUF2IecxM6Zj1S0w7+Yi/BeseX+pKQ6iLZ1bZScdnyBjugeHwTrbx8fPis1LMqrM6nZiOCsBh7
	fUAZY6u1Vd7lWn/XMuMtLils9Gc6/tbgbFqTInbl008/hGhQ6idQ905o/Neeq26znQFI5eGvJFh
	tNK1fGBtQyKKNjIQmKMn2ul/1e184nksKZ10GiY7c4aHMxADtJBucLSmujSK0oGT/PM0zuE8uWl
	nj8PG/FW2c110W6MfvK1FoPteCTRiI4ih2o+eAXdqnfCys3m45N9Nkhb/kTI39soDSIirRSJOWN
	L12PEF/nVc8e95jS95eMJ/DgS7s4nbUrmnRaCU8SRunyACoUZuuO1rxNF3I8p3kkkAo2VT30IAB
	Vx1v87YxiAuBavRNv+ji8wiODJvacBKfp4On+KCakGZJqhWBAS
X-Received: by 2002:a05:622a:7917:b0:50d:a7d9:d9af with SMTP id d75a77b69052e-50e34a76ca8mr7683091cf.53.1776370992242;
        Thu, 16 Apr 2026 13:23:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea1b:4643:9f36:3ffb:fc60:9518])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b0063easm49480691cf.29.2026.04.16.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:23:11 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:23:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Frank van der Linden <fvdl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aeFFKlSgOctW2W84@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-15335-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D3EA941498A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
> >
> > > I also have some questions about longterm pinnings, but that's better
> > > discussed in person :)
> > >
> >
> > The longterm pin extention came from auditing existing zone_device
> > filters.
> >
> > tl;dr: informative mechanism - but it probably should be dropped,
> > it makes no sense (it's device memory, pinnings mean nothing?).
> >
> >
... snip ... stitching together some context here
> 
> So, looking at having some properties set at the node level makes
> sense to me even in the non-device case. But perhaps that is out of
> scope for the initial discussion.

I think there's an argument burried in this observation (useful for
non-device case) that suggests there could be a world where longterm
pinning on this memory makes sense.

But it doesn't need to be introduced from the start, and it's a 5-10
line change to add it in later, so I think it will get trimmed unless
there's a user out there actively experimenting with it.

~Gregory

