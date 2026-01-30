Return-Path: <cgroups+bounces-13550-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAXQIaPYfGlbOwIAu9opvQ
	(envelope-from <cgroups+bounces-13550-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 17:13:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFC1BC6E3
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAD7E300B50A
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BDD34A76A;
	Fri, 30 Jan 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="IIUoQdfX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24205346E72
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789591; cv=none; b=FYZsE1uL/VKPSKMCXAFE5a6Bx2sWui+Nojak4cGS6P2bHK1JveKYEbWWvc4Bgk+fw0DLd/rlyI1q31F8hs4/TA8MPSr/G5ZxhYV9lP2NZNsPBnUWzE0VVsZadMb6SHpO5RPVJRr1mdBpmSVtCRRm26sn35gx4f3eLQ/V8c6J2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789591; c=relaxed/simple;
	bh=1zch/1ZkNKibJGzl/KXh3eNSniKdCPTOoWWscqay4XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W73t+X4B38xbTJwJBZ3PKwCT24D1ttzDG/VBqoNNO4xCc4oOXQB/oioc+6TNmkflmljiA12lmW5zYUkkgmN8WzF9fNl0XIOCOq4D4khnQ++UJ9KKlCG8PTJWzpmxEPJyR0FxwxzhhnzXpTVBSzwyQ/VPCZFp8vQai2+mhexlbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=IIUoQdfX; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c07bc2ad13so177410585a.2
        for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1769789587; x=1770394387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QG90dLm8lMXI0BfNfS8WSlG5utZKp+E9ek/YEYpHTH0=;
        b=IIUoQdfXpzqDGlDeV+THJ6919SVX5x/xjzIAwemJrw9sPUA0pkZhPkY3H++2RfwfZx
         YKI4wsqKFP6hUZGspp0dWMs6IzZC+hvp2JIHu6ufMUepnKsMbc9A43mZTOB+7IQFpvYr
         x3oMGXUKiWsTorsoNoZty+rn3emJOX4sf0MdEl87cU4L3eBck9dh26/uKaoLJ7QNlMJQ
         1yOiwDOErEWVqJXwGkbKo5ruWNqqmyxc8aP87bec/e71qvQ36F3uVH0LmnNnv/ZGiyHo
         y9XEr/hZKsDZPquC0KTrMHGDklGnVZ6BNxMSuUFg58wXTPibSe58UtyFbyIOKqs0bs/M
         fs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789587; x=1770394387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG90dLm8lMXI0BfNfS8WSlG5utZKp+E9ek/YEYpHTH0=;
        b=VYRW1Sdp2CBRuuOvfsJRkGtHQGQoZZ4o3N3PaNhjiF+xUHsD77nEIs3mvqszDMNaZh
         3rYMPlvgjRsYMljb1B8T47Y+ImSKGm3MCmktjcLAKKRyjDm+Mfe/ZGZmItKgKX3EdBiM
         og+rTY0MALMJiU1pfYqUicnrRZWjqZi4SVVU9GOb4E0AM/SK4EpQ6nIY+P0JVtw1mHp/
         W5QGI9aGurHj6QAtm0SDYe2IFyzrPIR4NPOnASab5IQsRFb71V4yagHba022FuiicIPq
         NRqPwzsq9VZLqyvRUFrB4vXBqOcRNkQOQuYaB8MCPw4xhOS2ldWCmwR6w+1ZPNSkz/bT
         FtxA==
X-Forwarded-Encrypted: i=1; AJvYcCVSuNc8fwkmSr0SNIO7sWrFxTWFJKgznyJXu4Id3/TJtG6xjlVRAsN/if74eJPzuUqGZXmVhEsw@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDU8tdz3zNQjoiMxzWU/xVOi9GhBlfz/m9YG/E5TDn7TDyJky
	IsUVr7ZONrPDi/NQydnCxJFFXgYvoMATdd6cOkDM4sCrCEkwm0+wrXNAx6IUaSNVMd0=
X-Gm-Gg: AZuq6aJZy/CPqK+3Yu4/OYrZYkpC5TjXfiqdripMvet0oC2kg753VmEIcx+iO/EcsbN
	QTdnWdab4pvmIuOWrDtjotQFe53+NRe75QAprvrJ/oj96nJlJwagG25KjE8K8zJHldLBaudLoNk
	Iai9xjpHTHiRChCKR5r2H6d9Jy23NlkUPDxh7XTOpX/d2AC1Ag5NtrZjUB2XtZgMGbhSRzcjmtf
	3Ezld3XekUT+Qs4sHfhKadb+Ol2hvNKLcMveTVEU1nW/CuKHryDQOqKDWH8pPT8fwQqbKNCYeGQ
	i93dHgW7CN4q5+d9AGsvzK1bhvO7lYltp7wIxgboZDNl0/aY1QkaUOPF5ctLxJsqUbI1lzjWQLD
	TWVdTAQ7PAvRDcZXR5OvsSTYhK3CReVKeRkxpuzFOaogkEsBUz/OVfarygUoSvjtjCKXKBUl1rk
	eRRQNYP3RJsQ==
X-Received: by 2002:a05:620a:4103:b0:8c6:e37f:ec2c with SMTP id af79cd13be357-8c9eb227cf2mr476327685a.1.1769789586691;
        Fri, 30 Jan 2026 08:13:06 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740c86sm59598226d6.34.2026.01.30.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:13:05 -0800 (PST)
Date: Fri, 30 Jan 2026 11:13:05 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>, Song Liu <songliubraving@fb.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in
 collapse_file()
Message-ID: <aXzYkeJWUvEzp7oU@cmpxchg.org>
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130042925.2797946-1-shakeel.butt@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,infradead.org,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13550-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: BDFC1BC6E3
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:29:25PM -0800, Shakeel Butt wrote:
> In META's fleet, we observed high-level cgroups showing zero file memcg
> stats while their descendants had non-zero values. Investigation using
> drgn revealed that these parent cgroups actually had negative file stats,
> aggregated from their children.
> 
> This issue became more frequent after deploying thp-always more widely,
> pointing to a correlation with THP file collapsing. The root cause is
> that collapse_file() assumes old folios and the new THP belong to the
> same node and memcg. When this assumption breaks, stats become skewed.
> The bug affects not just memcg stats but also per-numa stats, and not
> just NR_FILE_PAGES but also NR_SHMEM.
> 
> The assumption breaks in scenarios such as:
> 
> 1. Small folios allocated on one node while the THP gets allocated on a
>    different node.
> 
> 2. A package downloader running in one cgroup populates the page cache,
>    while a job in a different cgroup executes the downloaded binary.
> 
> 3. A file shared between processes in different cgroups, where one
>    process faults in the pages and khugepaged (or madvise(COLLAPSE))
>    collapses them on behalf of the other.
> 
> Fix the accounting by explicitly incrementing stats for the new THP and
> decrementing stats for the old folios being replaced.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

