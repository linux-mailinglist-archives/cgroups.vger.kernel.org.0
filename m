Return-Path: <cgroups+bounces-2260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DF893C2D
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 16:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D49B20EF4
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A3621;
	Mon,  1 Apr 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ7fvW6E"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69F4087A;
	Mon,  1 Apr 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981348; cv=none; b=IdYkHdiw71k9r+QXDb60IbsfpfDTt9xCEbiV5mjl6cwyL14yaJWOllHUFLwgnZCSNNf8yEnWiJj7TRqJQWGWmdXZQYoCh6PphZRktp88aXLmf/lUYaas8dsihpYn1Pkd/n2/9n/Eh7KErByICGW4cBVfOl4ac27BoJd2JwsXsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981348; c=relaxed/simple;
	bh=EpJRJUCiWs16GDakKWHk4xl65Sv86m9+Q1f3XYISMCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aTtTA6mkpATC0f9F5lkZFelheRbyGibfAsjty3ha6sRjby/ZdSA0XXVUWwuG/ZcYCs0uFSnzn7BuQm4zW1aLDNs11dR6iVigB7IKzlAVpC4je03bX1w1wTqrPKq34Cv3GI5bbUEalYY8fKRTFpxU76MaRweuLefBhXC1iU/mwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ7fvW6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99E6C43394;
	Mon,  1 Apr 2024 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711981348;
	bh=EpJRJUCiWs16GDakKWHk4xl65Sv86m9+Q1f3XYISMCc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=rQ7fvW6EKj6tB6IDRwnyR5Rg1HoDXEevMleRodZuTwgvEDtU5pb1uziBqpNB6Pnbx
	 eX7OBsBzYxDOOtXXHryrP8gYfeaYoD0aNpv2P5yDVUOvEuFWEBzF8+yMAjzH7a3Kvl
	 eNYOAZ+jBUXoQuSXVoJuEBYLJcrdwQXZ/P/ky6FK2bIpO+vg3SYw3UWpEe+ugjqJGg
	 m2oT2v0KYGerkdRZbpmRvmPpzKZvStS3RtCIzahuqHwNyksD2Pp4UZ9QJDBu7C5EY4
	 JgUNGq7uOzaigaorDDJeSiXEudQvuQaR7brWSW0+ljh7toEhvdhgOFGRWoI/pSr1lE
	 gQumKrZuwXt+Q==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 17:22:21 +0300
Message-Id: <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
Subject: Re: [PATCH] selftests/sgx: Improve cgroup test scripts
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>
Cc: <anakrish@microsoft.com>, <bp@alien8.de>, <cgroups@vger.kernel.org>,
 <chrisyan@microsoft.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <kai.huang@intel.com>, <kristen@linux.intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <mikko.ylinen@linux.intel.com>, <mingo@redhat.com>, <mkoutny@suse.com>,
 <seanjc@google.com>, <sohil.mehta@intel.com>, <tglx@linutronix.de>,
 <tim.c.chen@linux.intel.com>, <tj@kernel.org>, <x86@kernel.org>,
 <yangjie@microsoft.com>, <zhanb@microsoft.com>, <zhiquan1.li@intel.com>
X-Mailer: aerc 0.17.0
References: <D071SWVSOJLN.2C9H7NTS4PHGI@kernel.org>
 <20240331174442.51019-1-haitao.huang@linux.intel.com>
In-Reply-To: <20240331174442.51019-1-haitao.huang@linux.intel.com>

On Sun Mar 31, 2024 at 8:44 PM EEST, Haitao Huang wrote:
> Make cgroup test scripts ash compatible.
> Remove cg-tools dependency.
> Add documentation for functions.
>
> Tested with busybox on Ubuntu.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

I'll run this next week on good old NUC7. Thank you.

I really wish that either (hopefully both) Intel or AMD would bring up
for developers home use meant platform to develop on TDX and SNP. It is
a shame that the latest and greatest is from 2018.

BR, Jarkko

