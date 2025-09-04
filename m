Return-Path: <cgroups+bounces-9710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9FB4457A
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E02FA47747
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396512FF157;
	Thu,  4 Sep 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQsqtDpF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC2F90E0;
	Thu,  4 Sep 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010792; cv=none; b=hLcDicSAZ7CgKxL86BPoP7cPMp4bNr73lEPRn9QKqkW1F7BolcvofW59S2G7HOi2nvW77fa1xrQV5IkcYsooKHh3Ws1a6kiau3hDvHxeHX85E20Ebo7SuttFSEbjAckGSeit+hem088ZyzfLyAUiNUUNFt9NLjfRFDjU6kONhqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010792; c=relaxed/simple;
	bh=uHFmrP3T9SV/qtjgxYCxtF6VwU3YzJhnExVMP/U0hxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl+ehwSgnAiUijGrWizOsnEZv50fs7YNnZZbByUzK0VQjR0/w4z8NK0tRc/Fm7HbM2RASr124sU1K2+oK9Sc7MB8Orm1s0+2a+B8Yw2Wjj4/zHiIRZYc/y77NrAoAZ8bgUmvPByLG1bwt9cZ5aIgH0OZ6AyoOL6sAej6HS9CJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQsqtDpF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 18:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757010787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTK/8VgFFyhV8UKZppqhouh5PDUMUGXFSIseDaDeNx8=;
	b=TQsqtDpFpfOc0VcPqaZt8asiX8hKW3riIF99A5aWMAnfqwpo2+dCpWlRs0otMuAzKEcoF+
	7DIl6T04XYjq2MdibKD72dNhziOxbdvXnqrlV6IATfOjwuFiLOSlOubkGO+RfWfc/zQdM4
	J8NZlYzedzt/Ru1Y/Eiu9NavpoB7ZcI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, stable@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: Re: [PATCH] mm/memcg: v1: account event registrations and drop
 world-writable cgroup.event_control
Message-ID: <aLnbXSxyzhGYGjks@google.com>
References: <20250904181248.5527-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904181248.5527-1-disclosure@aisle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 04, 2025 at 09:12:48PM +0300, Stanislav Fort wrote:
> In cgroup v1, the legacy cgroup.event_control file is world-writable and allows unprivileged users to register unbounded events and thresholds. Each registration allocates kernel memory without capping or memcg charging, which can be abused to exhaust kernel memory in affected configurations.
> 
> Make the following minimal changes:
> - Account allocations with __GFP_ACCOUNT in event and threshold registration.
> - Remove CFTYPE_WORLD_WRITABLE from cgroup.event_control to make it owner-writable.
> 
> This does not affect cgroup v2. Allocations are still subject to kmem accounting being enabled, but this reduces unbounded global growth.
> 
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Small nit: please, use GFP_KERNEL_ACCOUNT instead of
GFP_KERNEL | __GFP_ACCOUNT.

Thanks!

