Return-Path: <cgroups+bounces-14451-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNz3CvjNoGkomwQAu9opvQ
	(envelope-from <cgroups+bounces-14451-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 23:49:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB321B08E2
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 23:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9536C305AC85
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81D3A7849;
	Thu, 26 Feb 2026 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D2J2ejrd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4F3A1CED
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772146160; cv=none; b=YXr9gi29TSVedZb+Pmxv0i0wlNWG6uvp+wRI3KiKOGQ3q+2fnU06DeIVzexBIn0jsdt217obwI3VhmFzGK0diKEqL0G2Q+dZi2YoTMpzcTBdW6xaCul0MvwOxA2UMwIPjW7RUQUJ2wyDvE2/oeqssMbDG1B4M+Zev0DzjQMUjjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772146160; c=relaxed/simple;
	bh=9XJprUJHH+fYbJ7JRjThngQYjlckG3iYgJf41aqrPaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLAYffIjxfmDQ6Oj2kcWwrSrHfboWWcmkhTEjKwWGw06qxkTftrb0jUlsvYbhOaMyO+PvVifYzKVDKjTmXlfH2qOfTYH+7+afYCjFp+aAbezcVANnBRzKyIlLtz5/geJBG1rP7F2ePo2Lcy/G6+ESPypNzaxyrtu8KhpE89mIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D2J2ejrd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506251815a3so12073661cf.0
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772146158; x=1772750958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYDaj+HYxxwd2SoII0inXN8E5ab2WhHpXFva2vqM1nA=;
        b=D2J2ejrdhnArACxLg9uAeQ9+NW5S58YpyCDQaZzSokmaJcfCXRGYy436PIK29mgmtu
         cx4dA240xqdH99Lqtyty1l/UHS+QiMTCJ5lBHUFmehAIddTtEAESjsz1AA1FovL8m8Ha
         Yp0QUrFqZp/kzwVMJ3ihV5z37VwNSmpv83VYfN8XfU+OzVz7dUk+xTkEFkLxmQcOogMB
         +8pQ4g6zOtVqZUnsIXZ+DvndxzGO3sSgEe2z/JUQ4GLOESFfCF5YFAHKNzpcK6wbEWx0
         QXILWTf/u2qZQirY+fTysy5oe3z7emyye3x8fU5gSeNEvCBGImKazCPHekFy/ga5/uRE
         8rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772146158; x=1772750958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYDaj+HYxxwd2SoII0inXN8E5ab2WhHpXFva2vqM1nA=;
        b=WFd1azyD1fCjG4vI4HO1E/WhdZsoe9l9jQ0NC2cAwVg6a5PEAoyQVL1AbVCmaL3nmM
         PeRsQaz9f/KHSN2AsFk6WG1OUj9UbBXn/Nb91SNZvOfWK58/BIluFKgsQX7yGMEjI/mx
         AY+kHVkxXPeZ2tikQ7D1uSDQVlrxoVpoPTO5/JTHn1/5VjRyMlTE9HUSCutFOyMacc27
         EZ0Kwi7tE4SSg1x+ES8At2Hsc5ydSoSwZPmmsfMVCbroaE8XrPHvkZi5uSZn59oaDbuJ
         z9dIPP+djwL8zm+z3nQZ2RD8n7VXS7m3f7fA6N0+kANnCIPs2IyXbH1Pne4UB8kMAF1q
         20fA==
X-Forwarded-Encrypted: i=1; AJvYcCVbhS3rhYavIVHyjtgH17KsQL8le5ByuuXp0s+p9PC40A4WJOXGhw3EruVbiXoR+2L12otccBV3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4K6mDU2+HA7RhmibT5D/EDfQ8KHZshUoat4bC2f7WLlDmUr44
	6d06ohTHTA7COtkmR6wLYkQyw3V4I6D+0qAupTWJmvaSU1iVvhyeULgSJpxQWNYkcBk=
X-Gm-Gg: ATEYQzyQ8TNtuYGa3utPHqGjVdJMpM8aJhJTlUMw3m6dXzt3d8p3aLd4I+n8kq8V01Q
	s0nnT4WjM1N8YnxHk/jJk2YJXYd5HN8IxDnvk4JwYgyFk54gkKJtMlo7DaY0RQCmBG4jR6NNBvI
	btI4kuFQ9xT2ZaCsIIUyXCgFOig4uNAb+yV7sNgbKERe3yFs5OYVsfRJHM2X6QCAcSYGeSDqpw8
	zssKfIetdAVrTWYFr9MMiwHgLK//ByITJsMpSfM5FzLpR9pp/Sn6PcpAxJiPLUi2egltaRuKLnP
	6JEOoPsM4V+fZp9eqLi7PXA2RS/u6RKHv/+EPRmmpwiTBHPBHBlHQtV4p91fpqQomNmaLnGSroG
	QnpFsfT0GkdbbZt3sDEk4Xjd4G0cW1H3ulnz4Dqq7fSrO0urGio2GO9BAaSv45r7kfPK7ukJjVB
	zp6d8lFCtk8ep2X3gOqbTo6H60WcG4+juL6kGg6etcit1rbScFG8WUNDahrSF++DkkOs0cPumuw
	1DGY0j6qw==
X-Received: by 2002:a05:622a:1984:b0:502:a100:4054 with SMTP id d75a77b69052e-507528c1f89mr8534231cf.23.1772146157581;
        Thu, 26 Feb 2026 14:49:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b72sm29449326d6.7.2026.02.26.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 14:49:17 -0800 (PST)
Date: Thu, 26 Feb 2026 17:49:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aaDN6ocubzGUz6zc@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
 <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>
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
	TAGGED_FROM(0.00)[bounces-14451-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FB321B08E2
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:54:08AM -0500, Gregory Price wrote:
> On Thu, Feb 26, 2026 at 02:27:24PM +1100, Alistair Popple wrote:
> 
> > > If NUMA is the interface we want, then NODE_DATA is the right direction
> > > regardless of struct page's future or what zone it lives in.
> > > 
> > > There's no reason to keep per-page pgmap w/ device-to-node mappings.
> > 
> > In reality I suspect that's already the case today. I'm not sure we need
> > per-page pgmap.
> >
> 
> Probably, and maybe there's a good argument for stealing 80-90% of the
> common surface here, shunting ZONE_DEVICE to use this instead of pgmap
> before we go all the way to private nodes.
> 

Out of curiosity i went digging through existing users, and it seems
like the average driver has 1-8 discrete pgmaps, with Nouveau being an
outliar that does ad-hoc registering in 256MB chunks, with the relevant
annoyance being the percpu_ref it uses to track lifetime of the pgmap,
and the fact that they can be non-contiguous.

tl;dr here:  a 1-to-1 mapping of node-to-pgmap isn't realistic for most
existing ZONE_DEVICE users, meaning a 1-op lookup (page->pgmap) turns
into a multi-op pointer chase on and range comparison.

Not sure that turns out well for anyone (only on ZONE_DEVICE / managed
node users, all traditional nodes still have a simple pgdat or page->flag
lookup to check membership).

There's an argument for trying to do this just for the sake of getting
pgmap out of struct page/folio, but this only deals with the problem on
NUMA systems.

For non-numa systems the pgmap still probably ends up in folio_ext
(assuming we get there), but even that might not be sufficient get LRU
back.  Might need Willy's opinion here.

~Gregory



