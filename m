Return-Path: <cgroups+bounces-15601-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGvfDkSg+WmQ+QIAu9opvQ
	(envelope-from <cgroups+bounces-15601-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 09:46:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A04C82E6
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97AC13007500
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE4D3E5ED2;
	Tue,  5 May 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RCxXV9LX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1923D47C4
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967164; cv=none; b=eqSOEnO4CQRN90O7HHF4EAMfuBhdtYjD9q5XCNaD1EAGZyxvPa+HiX+JGhDVkVtSSvoFdIF8Oe++4PdDgYj8dtPBnyZSv+x7WcbGyjKdsksBbvP8AiWxzmqfQIjm/qfqOfll9Az42FuJZdoiMc6jBvYCYOc1RdNDgjfm/YEBKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967164; c=relaxed/simple;
	bh=nHnlIoIYgby//JTQJ23HCL1ahPlq53pZkc5FnZs96GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b00+oz6VeyF+NXlQcXRYQ0T7fPS/A2LahehvdMEN3wHqYR3dKmkiZB4LE4pmnSa1N1oYi+8ggALa/R9DDorRm8qBik9hlfqLFm2vwx7+IIN9byAGqO+HnUaUsEo9JwhRahD3wLmvmzzG5sOAp+WHJ8jOFunSGftOrIe925OGQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RCxXV9LX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44c350a5b87so1335172f8f.3
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777967152; x=1778571952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=RCxXV9LXriGz7JRe2657MNsE9158pU5CsAEXPaH9YbbRZ/cfEQ97T8nzjxqQjQr5Tn
         cDofYN/4NWz7D6fQ0XyKzFFVvPjtjBQlZHA3QbOgUBs8QtP4K+9gf8/fsKCBnqxH/TK1
         X4iWCPRpvJFKG+JvKL9st/yXEg+fRWRqnYMnJfGqCpTSaO/ibNLdZvUcr1bkSbuQZ/RT
         XYonchiGOgElt7+ZCAfg5bUasPzSmjsXzu+ZyL8JwvG44CpBF5GENiDxbTsee6+s0d9g
         jADSjFrbF2OEvx3nBUEynYfZo0W1FQcf3mu4y0whLlt21Yk+xCcDIIosGizPIqBT7eUF
         77FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967152; x=1778571952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=BbwG6KSAuJhB7z6Je5fapph4MUyh3CUlcsLe33k+C8UD6i45HQgzoJD4uMViaP0o3f
         YxxKgYoSDVBZAwN5DpgsLiu2p3F/eo9nHKRPc/A8V0Ya3izERe7yLUQnmBKCbmJmvir6
         PXSGmgQkDoVNoSDLQTRXUiwUj4QGK0Co+6x8mUlRr1JQgywmlQ+efY/c4+rljRjweAj+
         oGl27Wwz4GTPMab9i5SM6rVkOacAKCooVr2tElAkf+JaTbVnLRwhs9qs1WeLPM1gZIPD
         3/HhbovSz3ETqtc8ICkyMs4Iqn6mhaJW7nEwiWB1sZ3TsCzp2HJU40VFUw4NYxmTyq6/
         X7XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+keFvvy+HxxbC2+vQkyNGhPrR+m4d0Fcs0UKoVPrKoQ6p2vCL5qc79E5ToHjlmhEnjPN+kt8Vy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SQSPD35EB12AxoHUukYVG8Meu0dCK5MoWgkUVrEcQJjoGQ6k
	WykRCN6w3K4mEViBaUmF/UTFmLATHADCBHOOupHFlh6NY3h3L4hDtL5V40gtKeqcFmc=
X-Gm-Gg: AeBDietEPTwd6lxn9RcJettVxotKxkvMjkllvUkQMFyUdY5HsoMdxFFdHMd/5nidHhT
	VPgFD8OvqwfiO96fpS8yMzWjSu2fPPllw0m3C7Cmw+yVcdannuc/4a5UGMILoXvYgAg0wkYxv88
	V2NRpRR5zA49OwviMn5uNHJ1lmBIvbHQGHhX3CO56L6I8GoNcRwDm5p1xEh7fsbxQy9nTvFF1xr
	UiZeCyBRJagirGjB2sKLFRZE1dTQyyPS7YUUYMSVI1NIsE8z4XJz9GAAlTWs9hUUOo62tUYSLa6
	FoPdF/wSV/8+1adUrIwaW3EcwdbyNZTFE7dPHRFnthS1jCT1mHuTaDJLPVFJy0xYvAppaH1aLdd
	Bd5p1w7k3Rn/60ygAS7uPyhiFGOsfUgDJmuRgzP1+I5YN4CyKOcU1L3LG2aZnN5wVuL1x7R8mBH
	1iM4FGD76qV9FNtGB0MdB8ObhmK2Eqjeg6j1yZz3ebgoi5
X-Received: by 2002:a5d:5d87:0:b0:44a:2f78:e873 with SMTP id ffacd0b85a97d-450041b08d5mr3594275f8f.17.1777967152279;
        Tue, 05 May 2026 00:45:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm2455028f8f.32.2026.05.05.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:45:51 -0700 (PDT)
Date: Tue, 5 May 2026 08:45:41 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
 <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
 <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
X-Rspamd-Queue-Id: D42A04C82E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15601-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[76];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 06:38:54PM +0530, Arun George/Arun George wrote:
> On 29-04-2026 07:12 pm, Gregory Price wrote:
> 
> But I see this 'write budget' (budget in terms of number of write 
> operations that can be handled by the device, not capacity) to be 
> provided by the device in control plane; not by the workloads in the host.
> 

In the scenario i'm talking about, a "write budget" is defined as a
number of pages that are allows to be mapped writable in the page
tables at any given time.

>   1) We can modulate the write budget depending on the actual 
> compressibility in the device (and so workloads data). We don't have to 
> do estimation based on the workloads.
>

Barring the device causing backpressure to increase latency and slow
down writes, modulating a write budget doesn't actually do anything
useful.   Once a page is mapped writable - the CPU is free to write to
that page uncontended.

I think a write budget is "doable" but maybe a bit optimistic for an
MVP.  There are many corner cases to handle, and I would prefer to see
that as an experimental optimization.

>   2) We don't have to do the capacity modulation - as in ballooning or 
> shrinker.
>

You still need capacity modulation in some way to respond to drops in
compression ratio.

~Gregory

