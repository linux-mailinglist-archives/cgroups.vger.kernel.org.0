Return-Path: <cgroups+bounces-14153-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHH5MYp9nGm6IQQAu9opvQ
	(envelope-from <cgroups+bounces-14153-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:17:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A701798F5
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87BFD304E714
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1E530B509;
	Mon, 23 Feb 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BsPhcHiQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9D3090E8
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862924; cv=none; b=sBb/NgUgSMQagVh/o8zDOFN9kYYil3OmixvvOn6dzOm2kLL6m1S0WhpPB0maAg9olKVLapcPwhQLu9X2Gl/o1RvawB0lUtVS5fWVYekVgNHGX7MXG/k8SIwW9o7xyhTjqHBOL60JDTv+gX6eC8eYKTkDQitXlhENKW7aB7bN9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862924; c=relaxed/simple;
	bh=EnsbfZuxC9RIxnGqfBuxuj/9JrH+GEm1z2N32vhH5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6L/06LbHnTCuFUml56k36w1dr5gsd6FbhR9U01JV8md93uW/euYv6zwZpD9qwV/ZuGq3/IByQvHx4qX/kI1Hnh9pOM06AsTSt16pr8EEW+uesZuaG2zxKAk7NZ3sOuFWepHwBqCCsrg4YY1HP+DfZsK4TOyZQaKmAuYwU75TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BsPhcHiQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896f82e5961so67078426d6.0
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771862922; x=1772467722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=BsPhcHiQGsO4aoJboaOZn97P6uBmWUfSjz3Od8jXn/z1O+Gnwj6js3XjU09uVlsnSB
         9zRAzlb9E5oo++sFMpDsKG0UH7a0/+s8tFHwHbczUDpVVL9KM3CI3mfmBljlKYBt+xX3
         l/nCtNXkxQJLPWl+OlSUT5LRiz6tuDrFGyiBDeq8dQ7GRvow1YoSDnDsDs0Fs/MisV0S
         pef6NHm9kuIXh+HpG6hX+aDkR5WJqhM3HXtKt6Z9YnWCfjtHaRaVi2jxBnF5h7M0Wjmi
         CG9Ii/EHnmggQMJVwfnFdJ9p+BX2e0arNJHAjIt8QmHCCXxWin+Jseb8pDRwEVgXjGvF
         MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862922; x=1772467722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=Yylp8IVlON3a6jTBPIQpR+bpoPTiNTIC6RokBENfc3Ql5pVVmLFUTeW25YGPKrPvz7
         tyTJENFl5+xfl9mmGbtNPTYFpWFerwWfQbgnnTkocyN5LkPQSVSBitJQdkmoZi1jr5gr
         h0JlIMIo0plW9eAIPEH7v9Mh6E7SERZuY8Gpir1Bh8ATLaEH1SwFHX5O1LaL4ofpFcc4
         LTEletQBA1eiX6/7aFuAwDhBawg76gPG7DNlP/u+qNE/XKL7HYF9520nalRAVEYNgyFg
         xOHN7+E4SuEJ3Ul68qWNK6QLjofpQffgwoy2WWfxE9L3ZZzVkRDVjRowpwaKADomih1a
         Y28g==
X-Forwarded-Encrypted: i=1; AJvYcCUQTuyqy/eEe6oaQh4Ly6BuOSg2miJ+6DJ4fANCCe+UFtsEoKbD3yNyqgB5P187elpP67TAys3j@vger.kernel.org
X-Gm-Message-State: AOJu0YxGza7mFXMRf3rOooqW6+/EYjBYwX5dlwZihtwm97/HYqHxvU5m
	4Up7/0Oiv9eBasnlzzNO+kw+ZwW4zNWaAM2Mp2dDCIbBPm7kCJwwI8wL/EX4ivxGusQ=
X-Gm-Gg: AZuq6aLXEZeqaPOHntOZmFXQNyAGYEFRdfWs21f/zWKxqXa1YSFybN2z4e5CFt0Zy9V
	sFzWP2X6P4N7/BMbKri971c3EUEcvZ7g4tXNot0OouggL7ijLWqerrIl/B+QIfmh0MV5RpGbZb+
	oMY8i+rm5QV1dMy+1YW1uJfymuskBup2+GE2IcoMjH8HRD8u5kOFJrHQOtDHsO+YiYe4csp+qeL
	r/qlL3CdE4eMmbmEJ3+Pk3V0LryYYDEbaZBkPaOrA0x3bEF/tNR6P99CoNGNW8UYCW/D9lcfwyO
	g7Gt31bnil7pTUtO1iZ+5ArDLp6auafyDId0HwY2evyuooGspxVrQEvGP3JD5zkiIDkd9i7YKiK
	j87jDIywMUr+L8flpoR876ZQ+acgfF4bBedcwzx1acjFRA+3a5PfbXuDw4gcN5pgm0zQu0QGRIY
	WqpoY3zMhtj2qpD1FODt4XrMZGZjVvDW928WJCi2ckdsCSenWCQ5C+oovvMwFHayDQr9cL2Td6l
	FNLn/bpzLmyoSmgjSgZ
X-Received: by 2002:a05:622a:1922:b0:4f3:5835:e946 with SMTP id d75a77b69052e-5070bca9868mr136790871cf.55.1771862921369;
        Mon, 23 Feb 2026 08:08:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm71259831cf.10.2026.02.23.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:08:40 -0800 (PST)
Date: Mon, 23 Feb 2026 11:08:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
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
Message-ID: <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14153-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: F2A701798F5
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> > 
> > I'm concerned about adding more special-casing (similar to what we already
> > added for ZONE_DEVICE) all over the place.
> > 
> > Like the whole folio_managed_() stuff in mprotect.c
> > 
> > Having that said, sounds like a reasonable topic to discuss.
> > 
> 
> Another option would be to add the hook to vma_wants_writenotify()
> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> 

scratch all this - existing hooks exist for exactly this purpose:

	can_change_[pte|pmd]_writable()

Surprised I missed this.

I can clean this up to remove it from the page table walks.

Still valid to question whether we want this, but at least the hook
lives with other write-protect hooks now.

~Gregory

