Return-Path: <cgroups+bounces-10783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778CBDF40A
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2006D506A79
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22A2DAFB1;
	Wed, 15 Oct 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uec79tIl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191A2D6E72
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540441; cv=none; b=itr5nLT0A8bVHg/CA2CjOyWPDJ8TQ/Z3ExpCGkQIhVEf9V6xIsksNG/pv8GOXqRCP4V0wQH1zuJ7dViQL6w6/fWQZD+0PsP1LQACRfefsFcGQo+cHlibU4JTxmd4QqGlRFqp96ZMpPY7hUV31EuTo5TB6cHntLDSfvjPJ/ZZWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540441; c=relaxed/simple;
	bh=x/Wec3rXVzrFga/CCbUHczriHqpQebp8j91OtXO3ueY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucR4RwPrWukFpaxndSHewCIKEz6XBnD3uKXfBMsEoWnmJHGxx2u/0zryCIS2SNzxXiQ/qe9XYPCtH0l7OuILiVTGZ1oEr3DxDo4roromPiSCOAC7qvTawZ9LGjiaijjEUtr0mwOb2WDIQZy5Nr/i4zIsmt66/vP2+E9DorfKzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uec79tIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6932C4CEF8;
	Wed, 15 Oct 2025 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760540440;
	bh=x/Wec3rXVzrFga/CCbUHczriHqpQebp8j91OtXO3ueY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uec79tIlrFYy7zx2tJSwV/BXpEHrdMTecjkEXHvKuFg+Q84HNEEAq4hj0rJpX+iGy
	 DTAB5VOZkigZ0VArSW7SC6Elp1Qo+RHCw6UtlDr/4XT2oKqLGUB3tD0Z221h+2t3rt
	 lvB53gaqPzO6uMbEVBGLMF/sHSPwyuMC5Ug6HCrnML9xL4800ObakGDuSzJocV27Wz
	 vbXBezYT/VNPdA3GXFmJG8kE4ZZhTnsGfDRzIRBAXmrchXkdl8s6FckO097mg8wFQV
	 QCLJX1VKu+ApbLAXbIBleTYd9PyVFnLFW1qUVRl8GRg7u3lbGxtrm8JZDAGwNbRxCW
	 /2nFPysDBEL8Q==
Date: Wed, 15 Oct 2025 05:00:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH v3 0/2] selftests: cgroup: improve diagnostics for CPU
 test failures
Message-ID: <aO-3F1bsrtwtIr93@slm.duckdns.org>
References: <20251015080022.14883-1-sebastian.chlad@suse.com>
 <20251015103358.1708-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015103358.1708-1-sebastian.chlad@suse.com>

On Wed, Oct 15, 2025 at 12:33:55PM +0200, Sebastian Chlad wrote:
> Sebastian Chlad (2):
>   selftests: cgroup: add values_close_report helper
>   selftests: cgroup: Use values_close_report in test_cpu

Applied to cgroup/for-6.18-fixes.

Thanks.

-- 
tejun

