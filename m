Return-Path: <cgroups+bounces-1703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73985AD0B
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 21:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE791F25F1C
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E501535BB;
	Mon, 19 Feb 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjpUcB1I"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655A52F9B;
	Mon, 19 Feb 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374210; cv=none; b=fjba62Ar33FrTx/M5Jx6hKgXiw2FQLN6cAL5mECYn2oNrEZqtIqdOGnIj4dg80ecHqyj6TLY4KB+KGriSglLuwl24iq+hh3epZAGrH8cSaMMgTo4dlOCU5D5TpENYB6CxDEn0tRpOHnZU4ZGmC0eZD1xpjl//UMNXDpLB4JqoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374210; c=relaxed/simple;
	bh=ixHV3knXhwlKaNm/H5VZf90xSon7xbNx8HdzY1OHTaE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Dpehsvbmg6I9Ca1ZlsApovOj41KiM472ygwU72XtYhNAeYqEAWtquSUeKQdUbcLzagDQpZD3CiC9XssYoExRi/Kg8saz6N7ZoeKOtl07YcpoMk3G3zQcLI93qk8DleYBhTl9lNlJ+Ar2bFr3jEKaC2/mKTg4fzXaSAgdG1HqvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjpUcB1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F0DC433F1;
	Mon, 19 Feb 2024 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708374209;
	bh=ixHV3knXhwlKaNm/H5VZf90xSon7xbNx8HdzY1OHTaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjpUcB1IXEiERVGSZfOvbUCkCuR4TmpnrjXZViMy49DFN74vJyxOHJLpZnI/mluoy
	 5t+48D1/yfNRnngCi3+O0k93X+tzsXNC7dAfSJM1dwk67yAW2JS1kc+dPAxzYGD9Va
	 OV5MRb5nxQL8BnJo8n/GRJqfacljYIXCAX4FOOisF+xFEjguF/rcH7Lmv+D3rQGvaA
	 IQbOSumem2riEQiubkyQhsh9xN9QoS7/OMHYNw+DwKzoexy78hpiAEfsMZdIvzZ3w7
	 OWAMjZu1i7F0TgNnDh9tR9RVkP93uO1muS6llIweMUmrsexc+d2ZHttmbOHLbMQJlU
	 T3j5ctixMwO1w==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 20:23:23 +0000
Message-Id: <CZ9C42ETAIZ5.2QF94SIXDWCHR@seitikki>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>
Cc: <anakrish@microsoft.com>, <bp@alien8.de>, <cgroups@vger.kernel.org>,
 <chrisyan@microsoft.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <kristen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <mikko.ylinen@linux.intel.com>,
 <mingo@redhat.com>, <mkoutny@suse.com>, <seanjc@google.com>,
 <sohil.mehta@intel.com>, <tglx@linutronix.de>,
 <tim.c.chen@linux.intel.com>, <tj@kernel.org>, <x86@kernel.org>,
 <yangjie@microsoft.com>, <zhanb@microsoft.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH] x86/sgx: Remove 'reclaim' boolean parameters
X-Mailer: aerc 0.15.2
References: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
 <20240219153957.9957-1-haitao.huang@linux.intel.com>
In-Reply-To: <20240219153957.9957-1-haitao.huang@linux.intel.com>

On Mon Feb 19, 2024 at 3:39 PM UTC, Haitao Huang wrote:
> Remove all boolean parameters for 'reclaim' from the function
> sgx_alloc_epc_page() and its callers by making two versions of each
> function.
>
> Also opportunistically remove non-static declaration of
> __sgx_alloc_epc_page() and a typo
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>

I think this is for better.

My view point for kernel patches overally is that:

1. A feature should leave the subsystem in cleaner state as
   far as the existing framework of doing things goes.
2. A bugfix can sometimes do the opposite if corner case
   requires some weird dance to perform.


BR, Jarkko

