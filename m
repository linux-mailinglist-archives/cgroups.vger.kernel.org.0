Return-Path: <cgroups+bounces-13270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E248D2DAD1
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A61630185E3
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2AF2EFD98;
	Fri, 16 Jan 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t22fWYQr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7122EBDE9;
	Fri, 16 Jan 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550737; cv=none; b=ZB9iJPVbqeRKZt7fTgsR9pmYhwaQ55iyos9f4brQV7O0fkn7nKqZoK7EIhlRGObwT1kdrC2+sBAog5a3/zf1Z/IcyaHQ6H0ywFXXiy7dYL/pFMMJg3TIR0+r0IpkdWmWBZV+FfSXJ2xCWXxi3yWzcpPviByvQxwjoULbcOnM42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550737; c=relaxed/simple;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eGphLaABVNTN++Nyeh47C9r+MHfsX5L2ry29vtAXAoG924/WFFFr02Qd1sXmj3hzHNh0g3aDrdCBkWypRdqzUgTzE3YRnLt5TWcJHnX7ZbYiXt66kAnDViaLmZVCH1rhUozYQw1Gm+MAAmQG4D+FpcEJziBUGag+oTqfHRz52d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t22fWYQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B9BC19425;
	Fri, 16 Jan 2026 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550736;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t22fWYQrFoVBUVxAdFbYWJSSvvGHbAOvCkR5B8pD5RIrYPd0XFNPtYvZJsyHsPqXA
	 FD1vI8h8eukPoyzrh2AdhjvMCMptKvbvmMRvA8O3LYAEunTd2TfgeaDPayENnpyQ3A
	 vIPFfe/p47BjbsZ+61P1wvjnfaEMTOiZ+/dUPuM0idQMwmy53M06z0CPE36vRfCsHf
	 0nAeEypdnIkMvilssxDnTlztZYYmAq5A5p+90HUeOwaSMotmEyLATmLqvb1g6ML4Vx
	 63chsccCR2iSj8yQxf5lE0FcJNcDYZ4bIY87WxrJyMEqB2T7+JqCMvQTV5dMvGTpTx
	 /EjL5ExJpj0KA==
Date: Thu, 15 Jan 2026 22:05:35 -1000
Message-ID: <229d8f308fb77cf98869e3a3ca128888@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tim Bird <tim.bird@sony.com>
Cc: clg@redhat.com,
 mhelsley@vmware.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 linux-spdx@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: cgroup: Add LGPL-2.1 SPDX license ID to
 legacy_freezer.c
In-Reply-To: <20260114232208.592606-1-tim.bird@sony.com>
References: <20260114232208.592606-1-tim.bird@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19-fixes.

Thanks.

--
tejun

