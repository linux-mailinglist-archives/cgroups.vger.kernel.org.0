Return-Path: <cgroups+bounces-9108-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D5B2365A
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 20:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03FF7BABE8
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6E2FE598;
	Tue, 12 Aug 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNAfaJeu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F62FE571;
	Tue, 12 Aug 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025066; cv=none; b=B0D26fW1Qecr/81Y1hKxbqybdlCoQNvI7jarBx0tt0sVZ5TmTlLD5242+0YHc4ZoThiV8NXtrE0rlEgXttuR7L3yBykI+UIbIAmn1GDyiG5JctX+FJgh9estUtTqaXpUQo9sqIlMxhU4TcM2EVXPOcWT0za06pZVbxUX4qf32II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025066; c=relaxed/simple;
	bh=bNqsqA0Vvn6/WZPo9sN/cczpXR1gxHH8wbCXQuSxeKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWokSj0FnKJC+nXDkTXJcAFDLgScgq27We9/1kq+tCEQcrKMQWNnm2g4KTGi14mfkBeNbfCecvgivR5/i6oLRR3O0MC2qhf6//jBWkSMzAz6YlMmETGCFfX/hAr4j1Q3bfSfReeaYnC4f12acGKy3XiC2pBnovDR8unURTevvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNAfaJeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD29C4CEF0;
	Tue, 12 Aug 2025 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025066;
	bh=bNqsqA0Vvn6/WZPo9sN/cczpXR1gxHH8wbCXQuSxeKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNAfaJeuYS2TtbGNP5OzKW8DLQ4FrEwV9bPrny54+lDwYTPMNpJv0+kCRXvuH+4t+
	 CIwQpF+UIxsLbcVlmR1j4RisaiMEzRlPFpne0USTzwMK2QZ8NG5ByJA3Plce9NbpKV
	 YOoAkAi6BG1j3Cj9EELpwQI/XkdSZGywaueMDXT4e2sgzE76pspCLtZ2LWvZHWs5x0
	 G+f03w+VmDHQnwB1GJdgvPRRvp12u3sc8/Fj8sSDXXMkzekNljF4HgDeWg8FGyW+wA
	 tSY0pvT8TZ0K0Im8PoXlG3xfJAcuudTP+DUkKk5QBWD300ggGeXuTKolKl85ulQCCJ
	 diVn8JwJx2DyQ==
Date: Tue, 12 Aug 2025 08:57:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Replace deprecated strcpy() with strscpy()
Message-ID: <aJuOqTiKNiJlvQSf@slm.duckdns.org>
References: <20250812115036.118407-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812115036.118407-1-thorsten.blum@linux.dev>

On Tue, Aug 12, 2025 at 01:50:35PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

