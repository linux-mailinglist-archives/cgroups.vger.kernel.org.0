Return-Path: <cgroups+bounces-6638-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C73A3FE86
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 19:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C5189E10B
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA992512C9;
	Fri, 21 Feb 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BlR9uFS0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837C24CEE2
	for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161700; cv=none; b=hENXxC+wrHaeIcolgw9oo1pWKLmdRmpCdK2DSAiWOsI/ZXeNVGaIrz0FAU+fImELgIZW5crnXe6vSOLlQMubLc2vbA5+40M+m/clkhO/SsKwwRGLkBu32AyVJ2lbPx84T1LZU9GUDsNfT/r0eyu0hJYtdYK2b4hyb4Z05i4MNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161700; c=relaxed/simple;
	bh=A50HU0Hw9ycKqvMIS6Jb2kRv2X3kM4xxyKkc5JA3WQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju4Rfy3t7901SYuBJnT25hvSLag9KtsfckCnZL36/mqAAFWZJ7Wx/JVArkKM+E7eQNZalMiuwB9usfQPUmL5hTNhoMblm687r0jeFzSH0sFCqI93MNmpe9d0NqbUwYFBojmcI6EBQhAIO/4qusnh8CoYQjU51zkiEGJLlFcCDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BlR9uFS0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 10:14:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740161695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWj3nEIXIzXvDvRcJsnu7wuSwT8d2VWs1fuwJH3BtHE=;
	b=BlR9uFS0GeOlZTJ8/hGj7f0ehH1tSBEtAMedhUbljeHOgoglPaBjpsiOhF/R4/Oo7EcrL9
	LoBgcKIgBsWi+cpgdhNekiStLN671hblyti0dn8hKJGDsC/TxpNSpCEVRdEvKZlrTNKSMn
	5UW3RKzDdJO60sBWVh435uJ5vd39kZQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 05/11] cgroup: separate rstat for bpf cgroups
Message-ID: <ecngwun2typ5apf5isg6syrtzujxnfyio2tghndajzk6rc7y5v@onswi23idm2q>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-6-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-6-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:42PM -0800, JP Kobryn wrote:
> The processing of bpf cgroup stats is tied to the rstat actions of other
> subsystems. Make changes to have them updated/flushed independently.
> Give the cgroup_bpf struct its own cgroup_rstat instance and define a
> new cgroup_rstat_ops instance specifically for the cgroup_bpf. Then
> replace the kfunc status of the existing updated/flush api calls with
> non-kfunc status. As an alternative, create new updated/flush kfuncs
> specifically for bpf cgroups. In these new kfuncs, make use of the
> bpf-specific rstat ops to plumb back in to the existing rstat routines.
> Where applicable, use pre-processor conditionals to define bpf rstat
> related stuff.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Since we deicided to keep bpf with the base stats, this patch will go
away.

