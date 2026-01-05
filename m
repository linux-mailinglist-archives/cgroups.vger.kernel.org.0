Return-Path: <cgroups+bounces-12925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64282CF5AED
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 22:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88DEC300D910
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303E2E62B7;
	Mon,  5 Jan 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gtPO5ovt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F867131E49
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648859; cv=none; b=C21x7zp9RAI92+UxXDXp8uNlCibxL2Cj0UbGvgA0zroH4L2+m/qYFNM02SNhhpYrL7nRXDgIJ0pwxU/Rfxx1UotmrDD4kirTd89eq45XpiOpFAMEDUIHAoGNlc35CY7meI1+kmvr8E2nRzCcVkx3XTNj2rSd0lvGACG0nWdYmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648859; c=relaxed/simple;
	bh=N+H/IYCytCmutkTzoo8ai0zjgOK0uD+Nm2V9f0FC6/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB+CeTi9QVRouIcW6p2i8t+FSwWuuQE9BWzx+6Gi+ULrLlfgpWkwGaayZwBVmxKRAnbCS+bPnzbaQQQOmlzCwTrnW/TxE5Uy+4g7ukCeabbPZBXRgPSoJ+dp6eZI28bPkmmqiGJnPm6JYzlMAm62hmng1pKYOszwxtWszE9Hx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gtPO5ovt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a35ae38bdfso13485ad.1
        for <cgroups@vger.kernel.org>; Mon, 05 Jan 2026 13:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767648858; x=1768253658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSWfb6WbMa4GK6t36QHV/UhaSlBkhsogc7OHaBLtTbE=;
        b=gtPO5ovtiFfdGucp8k4+aSTBcJGTc7Nh9q1M2vFXL9tLnfNTJiC+IVH5wtZZgrfx1h
         z9DaM8vjYXOUkdq7BUFN0NA3MXiW5kXRWzCsxXGimvr+/FSPh3rSDL1i/nYZFZdp24SZ
         Tjgfy36FwquxT94Qg0gHjocLEnOAmOuUfcCtDnj5FPe5v2Kl9ggCCK6UO/bSBexPJvU7
         UCeQyfBvfabFbIxodI0VLgmBmZqxYnZX0Rh703w7pq5JUqPhZlrPV5CIJCWd6KJDZHr+
         mGVh70ia/onjimACLtt6oic5jDkZ0eIlb+xBm7qELz5S4pwwyxPyQAYgCZ+xOt1SRj4F
         4u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648858; x=1768253658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSWfb6WbMa4GK6t36QHV/UhaSlBkhsogc7OHaBLtTbE=;
        b=LyOY1YTHo1zjYFm0Rbjuh9Ga1PKoyaHhwQ1s4ZaW5OoCMpSQIb89HMinXmaH5P+S+Q
         5ei4YX9LG7v+2nByW/ASb5QnKEjLoOddIKMs0GqkvsmKqb9SFsz/3B+hqBCXrUau9ycm
         TvqJX/3oC1DWj3R+Cumw7MWDXBeju2ItHF+0rf4l7t0zxlxk8xmtjvbif4zNBG0axwZP
         w4MUa/aTifeDA0NvtsqMpXgwXy1XkzIK+rsnA4D4ECI+hDd1CCLqNIpHfF6c2drcnVHR
         TjmcDcn6+VY5A2/xQ1lleW/fmOm1n4Xnj9rhJ6lwunMwJrP3D4A08B3ixwX3LYvVkv5O
         IxJw==
X-Forwarded-Encrypted: i=1; AJvYcCVi0Rl3G7rQ0gk5EC7v5CuVZAojAUucoznIZDUb8LhI8G9Zljo4X5/iTc7ae4ap1+qzsfIW1kSC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bT0ztxPeSF05RsdoBtbzf9D+ZDJ+bY563eIRqiRmS099zk8L
	3PLaBlXwR+v0MzPu0OKxgEPlyo0S6f1/EqgIfUd1gwMuQxHqB9696kMtvUCPqxN4Gw==
X-Gm-Gg: AY/fxX7zr189Q/EXmxBgzYD9o0Kc2jZV7+sSAsrmtcx2FJwulSUZLZf5glQQA4nWG3f
	fqtaBu6cRaxEq6sEHkNevHlWVn1wk6LOAbNcEUNtXr26Efekj9K/laLj0gzIPvIX0xa1yJB/SJx
	2+rWOwm8jbHFeHX3B8RgFTNh+P8AMz8UTRoa4U+lmgj/YF8hWInqXV6SlswQ1nd6qX0iWccJc9o
	sMPEBWCdjaPCqThYoALHEyIHLASWRiOAgtCm+x6RjzttFezS3tcHhIh/zUILt1eH5fBLpoH+t88
	U6eQqclbFJFEC92gSaHabM307yZSA7tg65B+dIS8AMAhqabQ0Jz+4fXD93EnlEEfLgGRYl6VGk8
	QL4QI/ydLc67kdeCqtZF3jwWmn5JH2qJPY7JC2tEMrC+OkdQnH3IHDe2ecoMEx8Ux5mlJjAGo//
	1Rq8DO8iqZuGLjX1FyHamdnKx2RH2hx+241CExqsGQLRF4//Nra9Eu
X-Google-Smtp-Source: AGHT+IE/9wbqXZpR+eCiNUPQoW/brnPaSVUSFMiUwvWM0JW5+HuqfmdEFWty6+NS58ihX3xiYnJu2A==
X-Received: by 2002:a17:902:d4cd:b0:2a3:ccfa:c41f with SMTP id d9443c01a7336-2a3e42564ecmr148435ad.1.1767648857501;
        Mon, 05 Jan 2026 13:34:17 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfaasm300231a12.14.2026.01.05.13.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:34:16 -0800 (PST)
Date: Mon, 5 Jan 2026 21:34:11 +0000
From: Bing Jiao <bingjiao@google.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v5] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aVwuU2o5bm7K5w_7@google.com>
References: <20260104085439.4076810-1-bingjiao@google.com>
 <20260105050203.328095-1-bingjiao@google.com>
 <aVvenfzgCU9uKJN8@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvenfzgCU9uKJN8@gourry-fedora-PF4VCD3F>

On Mon, Jan 05, 2026 at 10:54:05AM -0500, Gregory Price wrote:
> On Mon, Jan 05, 2026 at 05:01:52AM +0000, Bing Jiao wrote:
> ... snip ...
> > +/**
> > + * cpuset_nodes_allowed - return mems_allowed mask from a cgroup cpuset.
> > + * @cgroup: pointer to struct cgroup.
> > + * @mask: pointer to struct nodemask_t to be returned.
> > + *
> > + * Returns mems_allowed mask from a cgroup cpuset if it is cgroup v2 and
> > + * has cpuset subsys. Otherwise, returns node_states[N_MEMORY].
> > + *
> > + * Returned @mask may be empty, and nodes in @mask are not guaranteed
> > + * to be online.
> > + **/
> > +void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
> > +void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
> >  {
> ... snip ...
> >  	/*
> >  	 * Normally, accessing effective_mems would require the cpuset_mutex
> > -	 * or callback_lock - but node_isset is atomic and the reference
> > +	 * or callback_lock - but not doing so is acceptable and the reference
>
>
> "node_isset is atomic" is an argument that not taking cpuset_mutex is
> acceptable since it's a singular operation against a nodemask (one bit
> it checked) - and therefore for a moment in time the node is either
> allowed or not (and we make no absolute guarantee of corrected when this
> race occurs, we just note that we're corrected).
>
> nodes_copy is not atomic, and in fact this can result in returning an
> empty nodemask if cs->effective_mems is being recalculated at the time
> this copy occurs.
>
> Rather than just saying "not doing so is acceptable" - can you please
> change this comment to explain the implications of not acquiring the
> mutex a little more clearly?
>
> Example:
> ```
> We do not acquire cpuset_mutex during this check because the correctness
> of this information is stale immediately after the query anyway - this
> saves lock contention in exchange for racing against mems_allowed rebinds.
>
> As a result, @mask may be empty because cs->effective_mems can be rebound
> during this call.  Callers must check the mask for validity on return.
> ```
>
> The rest of the comments in the function explains a about this, but I
> think with this update the comments need a little more rework.
>
> ~Gregory

Thanks for the suggestions. I will reword the comment in V6.

Best,
Bing

