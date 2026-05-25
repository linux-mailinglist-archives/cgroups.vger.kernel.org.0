Return-Path: <cgroups+bounces-16249-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMgPCChSFGryMQcAu9opvQ
	(envelope-from <cgroups+bounces-16249-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 15:44:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A95CB51D
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 482B63026895
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C2387563;
	Mon, 25 May 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BK1QOEnU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81B386C2D
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716599; cv=none; b=EBzbNkGswfopC6oGIaWtijjZR2nsRg0Hy2YCclDS60gEM4Jcbw3HOsz/HwuhHyWovpGk/7QqPECI1vGQTHX5dkLROJAemvy60BQ4Gt7r4ppwMR4zcSkAW947iCVhM8/+qJHGHCKqeDrRtTgRL8Pu9b3rg8qQjjv0yekAjfLM0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716599; c=relaxed/simple;
	bh=rX5ujaAoQWVMDzAqpuns3YL5+t9b3MSp0k3Vn18HmDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERUjO6waGqO1dOVphgSvMiTj7KkyZxDIjq+jTyNii/1LzHPZX7KrLrbIH2XIHdVZ9LZQz94WrQt7tZDGEl/zBRoIDpk5JUIy6V9bcHmMUUag2dICDX/+QqwWWcCaFhqSMXrDQ0Njc4KWnBLQetw/LcyXWqoFqZUCvZXHRaSHJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BK1QOEnU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516d0119e4aso36415241cf.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779716596; x=1780321396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qbww/jwqpcTz4eQTSyik03DnGb34+sYwBbk3jakvlU=;
        b=BK1QOEnUdDCW6W7P+IIQjbnpym/hmuGj6DZK+pP2Qqc4F+smR9teys3SozYf0h2Jrs
         O5stmLBFyojeQbTnkfbul1/zfx3q22q2fZAAEVQwW/afZbjlu/fBmHjBOJqBkaUkG5TT
         oP66h/WO/R/FA1xrsMX1QKzmxX7NEZbrBVG+ymP6mVh+2CPf+pEN/WISd1E+IO8K+Y5L
         PEA2DZ61l23Z0MtbbExHzUoHztgjpkPgij1RGeyvXyFM0vuzQTRN6jxBWTYSYKPHYqIa
         EZz/qaPOkdnk5ACNHjR9yLKvtnvehKEWkCTYNmqKCYdTOl3uD64w0jfiDF/9fL/gRvge
         Bvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716596; x=1780321396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Qbww/jwqpcTz4eQTSyik03DnGb34+sYwBbk3jakvlU=;
        b=o2H1/UIlmvGbVRrAZ1UOkdq8Fubl7axvjJgTIY5WSzIavFJB7SmFi3/5foGl5EUqFO
         BfLL7Hd22WRvEzdiCdXiMpGn2mDgor8LiUzfUqygVEYO6cP0yTsLcNGTKeozerdHQaAv
         vUnhrCXOVCrZyhGCiuD4hRVP84g9+yQCbBwHjQ++/EEpzvgnN/5t9UxfVabUhYaaJ1jr
         p8tN49OdL/ip0so1UP/mQyI5AaIKtVmw1UQOV96hIZ8uuJ4NhMfT8ME0YkfzHk6NrlBk
         RJwk9e+mrgvZpRSveKjTkvASMCfZLSFC9ISsg+kTteH3W+1ObIy6c/Gfux5lCUjKHVSd
         flmw==
X-Forwarded-Encrypted: i=1; AFNElJ/RuvJlh++KvqL31V+R4tX/FYna69Ru3lyN1b6BzK6E2IFXbIwzlYFPPSG4jiw4DZiYAT0VQOvs@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1wAHOb21RzU0JP/HyicKNkloHXcdTEeyuSptf8k7gqObyt24
	74Gbc9WFOvt7H5lzjH7FyyiKFYNU8ag6rFKUm9A7gDAyxlxOb2Zrdb8VEwCHq3+FYtI=
X-Gm-Gg: Acq92OGj7SaohSwa/XWOYFxzaboAS3xyDCwb7Y1XfdbyPn2jjM5AcgUXFLUraD7Ygew
	RTL7IeVTRZGpsRct0mrY5r4SLMVlyEN2Ad72cyiiVkAAy+9nojztQ0gGQQRnVG2t+CL6BsGeTfh
	+IAs/Maafw4ducW2oL40Oc22200M3hKjztyMzdR3JkGvuTnYSKeIulOmagf6EyR4ggKT1YwnVV3
	XnVmA+Wfl6/qgPYf3YsgVK5y24wzzbLA22+jaT2AzlpVT9Pir3/M9NAdo1VuBM93JnLjMZ7/eab
	qzuxICtzpJp9p3bdfH3j3wFz2s2KuNEghZ4+78zzgWd1UBJeOzRJ3fuC+PoWCG2KAPROg+ngpOi
	z6UPcuoDVDqkDrmJscU1iId7Sos382e/SeVFoNDhvniEjWRFDrldnjkVAN6bBfiHvJW2bdMwryb
	47YhFk3fuWaSUbDvZn8eTYLVAP1pIr9x6iEH2RE9Qy63ikrHjSMjposggOZzV6D8V1RQxPKf0cz
	y8SNg==
X-Received: by 2002:ac8:594e:0:b0:50f:1b95:675a with SMTP id d75a77b69052e-516d566e649mr166000971cf.4.1779716596256;
        Mon, 25 May 2026 06:43:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d895ed9esm94690781cf.0.2026.05.25.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:43:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRVaM-0000000ADBd-2lhB;
	Mon, 25 May 2026 10:43:14 -0300
Date: Mon, 25 May 2026 10:43:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH rdma-next 0/5] cgroup/rdma: add per-type resource
 accounting for QP, MR and MR memory
Message-ID: <20260525134314.GI7702@ziepe.ca>
References: <20260525055506.2002985-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525055506.2002985-1-cuitao@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16249-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 939A95CB51D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:55:01PM +0800, Tao Cui wrote:
> Currently the RDMA cgroup only tracks two aggregate counters:
> hca_handle and hca_object.  This is too coarse for real-world
> deployment: a tenant can exhaust all HCA objects by creating nothing
> but QPs, while the administrator has no way to impose separate limits
> on QP count, MR count, or the cumulative memory registered through
> MRs.

This was a deliberate choice.

>   - qp      - Queue Pair count
>   - mr      - Memory Region count
>   - mr_mem  - Cumulative MR memory size in bytes

I would agree to mr_mem as a reasonable extension, but not splitting
out objects to finer grains. There are endless objects we don't want a
100 different cgroup knobs, it is not usable.

Jason

