Return-Path: <cgroups+bounces-7496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3AA869E1
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147CC1B85648
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D605BAF0;
	Sat, 12 Apr 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B6QQxSDY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21323481CD
	for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418649; cv=none; b=iEef8J3Nr8jfxAgr8xQ5RVKd7muUPk+2ayWfZQrcVdKZBcDFKbN0gcqCb9VZ2XnbGAOC3WxDYsUYPHDEgT6tz3KCl3T+fHJCormiF/KoIrtL2YtX/JvzY38rD5J0e/XP++j27LGHcXknbJkqgN49UbK0gXUucMt5/SofYg7c6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418649; c=relaxed/simple;
	bh=AsQTfIAqCCtsNfV8wUHTPMqEUj/kreoDSDWwnN+iuJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKmQ2q1PlSv76ZdUcgcD6w1zDAwS9e3Qu6tAdFVLQ4P1X6tlsl9Etdq2sRhTs1b/6gRTvPSu15yiAxYd24FYRu03X/mWaR/3OqAeP/fCFE1p8AFtHkfeE1gDd8ixXQX7fuGo/CZUcL5NlBTttMw+BHOfIdMBjuQd4vxIoCh87kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B6QQxSDY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fc176825so20722736d6.0
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744418647; x=1745023447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7x4PJRTgrhycfo/8/g/qX4itzULAojrATFMqPaOifE=;
        b=B6QQxSDYaCORhBx5IFNUNAlzolBz+wUv33oqkuesYIdYSyIonBMYyV6S2/LmRjWPxa
         AlgMWYySxujd2mJSEGrKWJxhNIbSgJLxYDaK4rYr4JRXXXkcVXyyLQKnrhYly3AaPUQO
         DrBv3GYx0Bya+8kQ3czkL3kaqo7H7l+fUmhgaC9FcQbsvhame9Pj/VE7URjPiob22acF
         QKCWGWRpRNlXUtcvWzLSAjd8hshTNM/Vb1OKiI6pLs01KIvM3nYugqY5QxTACN2Gi544
         BPTxI00WOjw5qd6Hsp5+mIjehZRkCf4HUO4sgS6Mz+ph5789ObBF1szlJFc+slB5oBXf
         keOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744418647; x=1745023447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7x4PJRTgrhycfo/8/g/qX4itzULAojrATFMqPaOifE=;
        b=P9lgniYQZr7O33OgdXN6mAWqsI4aK9ZsGQjt5ktW08MZk94Xw9p1iHu3BfaQNf38uk
         D5v5qU69k0BJCOxoKlSmeaZ8EZUM6L+/1fhNnIqVtWuChIcK7dJjZhWHKJfZ+r8K8AYj
         mAzPXxypPUXjR3tE9RgMumyU67wZviEKu+E7u5uvhqSLUY3UrLT9bl1FZJ1cqwF/BlH7
         WnDaoZ4Re6WqH1GRNP99SLjj3W+T7TVBDBn4H+q1w2W/Rg2TnaDrp3ylKpbnRwcyD04H
         HOapR2Zt/iEk4ZSKebdBynMMJaOevaxRJUKVvsGs/HeyHjYadG95LoOV5U9+clpTq3YS
         wXkw==
X-Forwarded-Encrypted: i=1; AJvYcCXVRx1RjqF4P62GA7clTh7CS9WayCcUEeq0wLpgVGFdiPDrZPj/SNaup2LN+KOjmsMsF9QjEPNw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HjkEXDREyPAuEp0+dRsUQArzd9jY+7UKz6lhU4mm4JKnvf+3
	+gn3nW79dmNaPxeuPE/aIpKFY5lL6QkkWFeMz4xs+txRbrAENXppauUe1JHhmyA=
X-Gm-Gg: ASbGncvohn3sHEwcENT8sMhGZxckoom6XXrk5opZ8c/EtCuUGd/nw2rE6AGpbKErcvK
	RjeFYux9j7Ayzr/TDMTyMsUOzcbcpclT9d4V+b/au/yDLcCIc3qj9iQ/428z4jrDpWmxgwdDH9o
	5z8GuCSZVR5ATllfFe6oDYbXn+V3MSz0jRIUF01uOppwsBpECsdIgdRVUm3jf4mDQyrgOvQg3g5
	jxwHkEFII8NBU5z6Z5pow9YmkFjt36hw+Ln147rRtieLC3+hHFeHuih4Pfm+ouunB/AI9AeP2Y1
	QGry/kgsFcVEqznYxPSQhojuaAisEifmJ9Vx32IcwD/zYHZz7Q2iAOZPxvo7SKfLYZ91RiGPqdd
	mk6bbDMimg3Vx2mJba/kB32M=
X-Google-Smtp-Source: AGHT+IGZ+HsJjXTfcfVil7aIEcHChlVs3KaHbif0HrBfavH0A7MXCaU7PrLVQn+CXw2aOQJYs2FHxg==
X-Received: by 2002:a05:6214:2488:b0:6e8:fac2:2e95 with SMTP id 6a1803df08f44-6f230d91baemr71436696d6.11.1744418646809;
        Fri, 11 Apr 2025 17:44:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea2179esm44146526d6.124.2025.04.11.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 17:44:06 -0700 (PDT)
Date: Fri, 11 Apr 2025 20:44:04 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, donettom@linux.ibm.com,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Message-ID: <Z_m3VKO2EPd09j4T@gourry-fedora-PF4VCD3F>
References: <20250411221111.493193-1-gourry@gourry.net>
 <Z_mqfpfs--Ak8giA@casper.infradead.org>
 <Z_mvUzIWvCOLoTmX@gourry-fedora-PF4VCD3F>
 <Z_m1bNEuhcVkwEE2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_m1bNEuhcVkwEE2@casper.infradead.org>

On Sat, Apr 12, 2025 at 01:35:56AM +0100, Matthew Wilcox wrote:
> On Fri, Apr 11, 2025 at 08:09:55PM -0400, Gregory Price wrote:
> > On Sat, Apr 12, 2025 at 12:49:18AM +0100, Matthew Wilcox wrote:
> > > On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
> > > > Unmapped page cache pages can be demoted to low-tier memory, but
> > > 
> > > No.  Page cache should never be demoted to low-tier memory.
> > > NACK this patchset.
> > 
> > This wasn't a statement of approval page cache being on lower tiers,
> > it's a statement of fact.  Enabling demotion causes this issue.
> 
> Then that's the bug that needs to be fixed.  Not adding 200+ lines
> of code to recover from a situation that should never happen.

Well, I have a use case that make valuable use of putting the page cache
on a farther node rather than pushing it out to disk.  But this
discussion aside, I think we could simply make this a separate mode of
demotion_enabled

/* Only demote anonymous memory */
echo 2 > /sys/kernel/mm/numa/demotion_enabled

Assuming we can recognize anon from just struct folio

~Gregory

