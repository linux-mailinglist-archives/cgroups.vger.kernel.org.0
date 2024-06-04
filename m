Return-Path: <cgroups+bounces-3072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F10A8FA739
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 02:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E2E1C22647
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A3D62;
	Tue,  4 Jun 2024 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJhmusNz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36896FD3
	for <cgroups@vger.kernel.org>; Tue,  4 Jun 2024 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462260; cv=none; b=all1a/bQ96dtqoCVT+VFE8wneGdQeFTyqOzSQzvws1W1MTjbGS3X+uqH8gBFjGUBTvmFnituxk3K3Zo1Vl6F7mzZIHZ0ZCjX/Q15pwKXp4EnMcCnY8EKNlO55ftAExq2CCmIT+7uy0qzUuOr3LnmzjtzRFR5a28deIUsHFGoV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462260; c=relaxed/simple;
	bh=kvqm95FAVHsS4gzNq8F2c1OzNJr7OhBJ9VpFC+4oRzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acp6x2bJUnwTNspDZMmGtqV7yun7y/+AzQUrJth5OnEb3y5qMQghQznKPhAsH8H4xNxfyANv2gArGL61GAAm2aH5pkdiUZQVBCtXxx8iuax04SEqKo4SrqxReIkRRwUXbOkEsW9FUL6L+RuNegQcQE6dbPy2adcp984uLynGiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJhmusNz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: peng.fan@nxp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717462253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfiErk9cyT5jpHhGRLqJ1Nw/Sx/QA7/vxsgsmTfebzU=;
	b=BJhmusNzm2f3T1h03F4TxBcCuirBjQ4bAMq/j9G4ooxkdgd4gMemqjr9RJ2nWQcg6NTOcC
	FugatxsePvvbT+xWpZzseZKufUbXslRYLBV6/dh/LCtAwgTao+Hz+AWmc+GKTNYC6b6K5H
	E4HN1mVcMcn3P3vL6ar0cbJSfKFxVJU=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: ast@kernel.org
X-Envelope-To: zlim.lnx@gmail.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeelb@google.com
X-Envelope-To: muchun.song@linux.dev
Date: Mon, 3 Jun 2024 17:50:46 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Peng Fan <peng.fan@nxp.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"ast@kernel.org" <ast@kernel.org>,
	"zlim.lnx@gmail.com" <zlim.lnx@gmail.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>
Subject: Re: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Message-ID: <Zl5k5ky1b6XFaPD9@P9FQF9L96D>
References: <DU0PR04MB941765BD4422D30FBDCFC1C388FF2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941765BD4422D30FBDCFC1C388FF2@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 03, 2024 at 09:10:43AM +0000, Peng Fan wrote:
> Hi All,
> 
> We are running 6.6 kernel on NXP i.MX95 platform, and meet an issue very
> hard to reproduce. Panic log in the end. I check the registers and source code.

Hi!

Do you know by a chance if the issue is reproducible on newer kernels?

From a very first glance, I doubt it's a generic memory accounting
issue, otherwise we'd see a lot more instances of it. So my guess it
something related to bpf jit code. It seems like there were heavy
changes since 6.6, this is why I'm asking about newer kernels.

Thanks!

