Return-Path: <cgroups+bounces-13217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4FD20B0B
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F36C30086CA
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64532D7DE;
	Wed, 14 Jan 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lhGNGefv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562F2FF64C
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413450; cv=none; b=J5x33ES5NCGjW6U+EJIMwrlbQPjtkKweCT5cb6SQT3J9X2Jdi9u800sFU9z1ew42lQIpHqUOjiiKT/AH3rAPp/NGcq7M+oUNABYqxH3Hs2ks3HxQ0t29NP7VBrKVVrl4j7jsJJ0kqzP54rTUlABffm67HiOENPjV3tup0oeCA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413450; c=relaxed/simple;
	bh=8Hf59U1nFakMucNrjS9X9X0ZNbnqMOC1ykgLljQW7VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOAezMiRWAFQiTcKnqUt35PWMwBhjRej1reamj7XBOeFR3I2dxB1T0OE8rX1xMdvmWVH17zF8jRFKPCC2guEEzeTxMKFwCpkWeYosT1jAsC8NdZ52g2pii34zW2NvuMIjVW5l8vg0Mcd18bYlVottEbpEEGC/E4wR1wtUn+vQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lhGNGefv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c52f15c5b3so7309685a.3
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 09:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768413448; x=1769018248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m08Yl7EtzwefnAMN6c+XsJuXztPdRxM3+g7qCQe9UyA=;
        b=lhGNGefvKIRACklkyppBnlckg0K6g9LdnGbNmGBcIU0gcey/WuONyI0thvGZmhrIez
         dSIIyKE543aOpoRJVv0/0zoIRdkB4MQzYOdMaBdNLHwkTZ1GYbFBtzj5GOejxB2v5+c4
         dKlqwQ7/7dfAK+txaOz/9waFBvFud8z9eIyXHCdkzEHs7I4vaBd9BCD3K4HEBfe2i6JG
         RREJPR8tc7SljjM7tkPKN3HNhmt91KMa+8+p0ra3NiWuzuBzM9nWxd6GFTPo3YfQzR5u
         18/yP/PB87JbVjXKaQDuog9GaZ7vbvjcsPXL2TSvCRuBEeJT1z1XpuTzTiOx97EgvOqE
         NMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413448; x=1769018248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m08Yl7EtzwefnAMN6c+XsJuXztPdRxM3+g7qCQe9UyA=;
        b=DGX9BNt9NPRa9Eo0Hek6hfrTpIZSaDLJYyKcLfIejcJHi1+3UhsBLqxqldkaxQprip
         2oRwdsdvDb+jRV0cR5CvwkoAcOoBLyj1cam3w0mwZ+PV68AwhMOJM0PqO+FrSwoD2dng
         zk14aEOjSyzMKwpdeDtKHHARkKeXECo6Vax/i1WYbOT0oz1bjRv4JBfkDg2bmTFLPjt3
         ANN0IWWarv39h9qwRtzo0ZmY76s7fpTov0jATSTeorheyXCa7Cg+6GKn0AHZhiaNKG/+
         5w7fltU0XbXKbljJQXkOG+fxT28VOaM9TqF4ZqTuYxGvjcyTocjFD9lunvD1MSka6oND
         Rf9g==
X-Forwarded-Encrypted: i=1; AJvYcCW088g0IRXevvdqVOiJpkOjrC1R4xdcLFDUIXLvPnzw77UfJidDDa0p4LQczU49w2d6ru40tXnV@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNUW6Xtp1QzzzcDs4r520u7cT3gzTnptuxaZoAg4W1R00PkIY
	Qntrv6rjO3JrbcAq9OU853A409Hq+Sx5V4qDu25FreBXRO9RvSow3ZoVAlippoA3wv0=
X-Gm-Gg: AY/fxX6DxCIbcSya6+1Go4OYqPFWXX/V5MBX1sG7OdD7xjhPwER0UQBLg/uhkqqs7Cl
	SOUW/+vyYGkGA+ZnAPg6olVzYWy4w5SbGwj84NjRPfIRXKN9xw6CcJoPmo4zC+Ados4eGFfmvmn
	lzabMLrbCShNFbhuffX6OQGmXlAnsOiUBpdv7Ehu/VOm8I6CHpKp9O/b4aLJgCWYMqmGh3GhSDd
	IbCMwUzo3ZTvAotl7taYSY/IbMKd5FFEq9eXDW3UJSPkLNOASlicRZifPhcFGSqCsa+ncTdKNun
	KLe2YjatweTDaezWntSZkVZmO84MUzmfnlQR6x1f+GR0u1AC18uZgscDeX67TQqn2liX7dSTx5w
	FGePFOHJuU8mdZIJAuneoYlVPL964M7pdkqAnpz0BKQ8bcPpIszD2UmPfC5EG7pmQFln3Gmcj6K
	XN1QBPBN+Vhox86o0FbXbFPLceVbixcr0aamFGVc/Z2MbLIUfm3EF4oaaD+oT8tq+fuP1z7ErCV
	cx8N/e7
X-Received: by 2002:a05:620a:3942:b0:8b2:eb79:d380 with SMTP id af79cd13be357-8c52fb2f623mr544823485a.5.1768413448323;
        Wed, 14 Jan 2026 09:57:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530a6bdbdsm204232785a.10.2026.01.14.09.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:57:27 -0800 (PST)
Date: Wed, 14 Jan 2026 12:56:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Ying Huang <ying.huang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: use nodes_and() return value to simplify client
 code
Message-ID: <aWfY5pUPCD3mOou7@gourry-fedora-PF4VCD3F>
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-3-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114172217.861204-3-ynorov@nvidia.com>

On Wed, Jan 14, 2026 at 12:22:14PM -0500, Yury Norov wrote:
> establish_demotion_targets() and kernel_migrate_pages() call
> node_empty() immediately after calling nodes_and(). Now that
> nodes_and() return false if nodemask is empty, drop the latter.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


