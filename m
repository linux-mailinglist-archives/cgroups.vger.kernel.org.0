Return-Path: <cgroups+bounces-7686-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD0A959A8
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 00:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E12189614E
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5B22B8B3;
	Mon, 21 Apr 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EgWVdVWN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990222ACE7
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745276366; cv=none; b=KBU9+9CEmIYxQy8L9D8oFj8bdCpYYgXp71D3cTHcka+kwsRdQhxpBKGrzRfQs/sZiVNTGhLfJzj8B1pTwJtEqlIGX3MgfPEzUnFfDUnNWAUWNlqd+HjPYrqxiPqZMGO8kwXfSAVJuhy4xl8uOQAhr6VeIASo1718+BlnSv3ceRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745276366; c=relaxed/simple;
	bh=ebsskF4Rmx9x2NEcLJ3VCcQSQ/+L1tQBK+Pn+z3GXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drhpVcvzfFeaLFIbH0a38ncoer6+pcB3QHHHu6eBh0/Q6dMVj7Dlh014ybJEpFOGlHoT4IuZsO0X4vesCBSHe3iruW7zZpN5qZAC+gPkRuEdOiQ1UHxUO1OlLUhqYL9geTEC1e1hiMzabqD1fVK4GPwEFMpxglcYQL6ktU/Q4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EgWVdVWN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476b4c9faa2so57892011cf.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745276363; x=1745881163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCxYzSvMQrXsgyqCqZOeSZ06BULrmA1cRmi98g2+icg=;
        b=EgWVdVWNBi9KfwYxmeMa80V7aPGhahxPd63cLqj4un87WlNvXolXZ/nj8QfWt/3K61
         xwMhuO630wQL8P/IR+6S3G8WmpgSnoNXv6snIbLKxFHXBL3KODtZ97ZW0tiT/xcjYAkT
         sBPhqt78QMJCFa0QfGZkkh/OJ0v+y7iq080XdU1jlG14mQP/+fGggCqYyb33YOeU++Fz
         UtFlQCX8B9F20AwMbbhQaZOEfe3IMoxLutCITT4UYNTCUzFrERREqSsVgzbPOimeUBK+
         DIn8SwZ07EPeCmCGNten1GqXeyTBzfxekHifNmPM1VCLImQjgLZjw/dEIk/O2PHtiojM
         SVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745276363; x=1745881163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCxYzSvMQrXsgyqCqZOeSZ06BULrmA1cRmi98g2+icg=;
        b=EyHnm4TRqzqVLry11BICl8yRxRfRwTODdHBN1a2t2GlVfUYiEdISSdGvd0weNWXpCJ
         YOHP6KdOGJN0CD1nFSugGoFjTLXYn+6tfKbe+m2TZ2A6Z6urr/xthj59MwEWDpb3Hhze
         RCQdlzAxDU0o31CxRhSqrsID6Ps4ChV1pzL4fJwdnFywFCtfqSk30HARVTPiNAwPmpF8
         XkJj9NYoUCCbXlxqfl7odWZEvNhvObz6mXrUgv3CdEZCa/4WJmKMo31BE5ZtxZ19w3OV
         ZKvqIE2ZtWzzncOB1cNguDyYqBnxzlQPBT26HwCTlh6FrVy+UdzAi843groqi7mmTVcM
         9XJg==
X-Forwarded-Encrypted: i=1; AJvYcCXUEPa4YCf8ocRhgGBaK4QmWE8CiFJ8lhuCMdYVqi8EfKg+DTZzNptGRJZQf33OJ9W4I3Wl8kb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2eUYI1rRh5UaYHaPHU7a+YoCUPsft/AHh8x01U2A5A3N2dmu
	ZWZCSj8D0wg8ViR1B35B8xs55bJWzjVatu6RSIt8RmmSKCvyckDbQEQFsUWbCAw=
X-Gm-Gg: ASbGncs7B0dy54uf90FRiu3I/kKivKbVwZVCuY4KIyw78Kkdxg/9RFj3zhGLRSfuxU4
	7QFU4F9nRkmnrUfEcnoIIGM3GdRHa7idh2syYFFty99EJiY9IaxsuL3w7DJOx4SulCVqoJXzMjl
	4D2e2UF8bNYDB4ZuLgfgimfAb3oiWn5rCiHtPiS6rlw1T0dSaethdX5VdrQBVIFBZlBkHA+8McT
	3cBLq6tyavURXSb3G5zxTCkwFKNQ8DNqeq3RjgiTaKyv+fxcUZVJ3WklsO3zQe5rqU0OMxdB6VP
	kfaRIBiPIpMP0ClSUBZOS9pBFZyp1dXKaR9esM0tFsDhvJzvdbczlQ==
X-Google-Smtp-Source: AGHT+IETwYmaYx0EttRck+9kgxlJI3atNAQf8VACLl80GW0wQZExnGpeej3Nd8ilBizlPR2Jq06v1g==
X-Received: by 2002:a05:622a:180c:b0:477:13b7:8336 with SMTP id d75a77b69052e-47aec394c93mr174731611cf.17.1745276363290;
        Mon, 21 Apr 2025 15:59:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4d68csm48905001cf.47.2025.04.21.15.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:59:22 -0700 (PDT)
Date: Mon, 21 Apr 2025 18:59:20 -0400
From: Gregory Price <gourry@gourry.net>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Waiman Long <llong@redhat.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>

On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
> On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
> > 
> > On 4/19/25 2:48 PM, Shakeel Butt wrote:
> > > On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
> > > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > > +{
> > > > +	struct cgroup_subsys_state *css;
> > > > +	unsigned long flags;
> > > > +	struct cpuset *cs;
> > > > +	bool allowed;
> > > > +
> > > > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > > > +	if (!css)
> > > > +		return true;
> > > > +
> > > > +	cs = container_of(css, struct cpuset, css);
> > > > +	spin_lock_irqsave(&callback_lock, flags);
> > > Do we really need callback_lock here? We are not modifying and I am
> > > wondering if simple rcu read lock is enough here (similar to
> > > update_nodemasks_hier() where parent's effective_mems is accessed within
> > > rcu read lock).
> > 
> > The callback_lock is required to ensure the stability of the effective_mems
> > which may be in the process of being changed if not taken.
> 
> Stability in what sense? effective_mems will not get freed under us
> here or is there a chance for corrupted read here? node_isset() and
> nodes_empty() seems atomic. What's the worst that can happen without
> callback_lock?

Fairly sure nodes_empty is not atomic, it's a bitmap search.

~Gregory

