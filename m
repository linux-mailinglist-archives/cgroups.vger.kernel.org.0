Return-Path: <cgroups+bounces-13163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F0D1B522
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 21:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10BA5300816C
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105B3203A5;
	Tue, 13 Jan 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KFbKNiGe"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57608318B9E;
	Tue, 13 Jan 2026 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337888; cv=none; b=eSyLN2F3X9oZiAfSX41+vyLzISrSvzSHn7lj/tDz+h3DYXdacIKdvhz9ImVOyC3c3sFRG65Bqc+4Tpj7aOEn8NbVfGHXcPI1peNR86i9lS/UJ3IuIsFMiYk9jIzrluGMmAJph8kVBrFqQd34olSSfYszbuhLfxbqAtHKMwH/fAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337888; c=relaxed/simple;
	bh=TD2Vm9wqBzFMKU8+rXMduQiJ/DYduTKCttxOJrynlJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XwKzJWOGDWQkvHSrK0NIr86RvfeUq/IpLYm5gNYhqHZxUXs397C98BfWAkXtFmoKN9Vrz/DxahB8fpizxO/TnThCvCOng0yDmNlA173Hf+QpZM3tLK6+XAWgL2S2WJM5GK4GP/dA2p4qL5CbIdZ05cqi9mw1tETSRXoiBcnQyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KFbKNiGe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8ECE440C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1768337886; bh=jqbRJsomiPWk6cLkmHUFygsj5IDMKDpLe8eU/EmOQZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KFbKNiGe2YaK8agCCcuhtI6+jquk1zq0gG+KF8tf26qgrt+mu/JiJ+gzbKP6bqQMN
	 o7GNTc4J3fQM8W/8z9Yx+/EG84EKlxLg/7D0V7II0cgTusmeD6IcxuPu8sgGfOQzpy
	 4N4Gkr2u0sDZzk9fId6gcMxp8Ciq4WMgzd/vmlwqjgiD+v3Cy9kMqvJz2MNhhjW7gN
	 lpVos9KUAT0bDV2gX0BhW+OGZIfJ9cCaY9mK+GH8vWLbsEG7FHDMcQKw3rsAHsVS4d
	 Cc/SUpnN4GZzmtLCv3EguW3eyNyTVrc0OnxJvFwbyJ5loGgMWHfxEQXNZaBGW3v4kw
	 xXElLZXpMaoyw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8ECE440C7C;
	Tue, 13 Jan 2026 20:58:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nauman Sabir <officialnaumansabir@gmail.com>
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kbuild@vger.kernel.org, Nauman Sabir
 <officialnaumansabir@gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation: Fix typos and grammatical errors
In-Reply-To: <20260112160820.19075-1-officialnaumansabir@gmail.com>
References: <20260112160820.19075-1-officialnaumansabir@gmail.com>
Date: Tue, 13 Jan 2026 13:58:05 -0700
Message-ID: <87o6mxw7qa.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nauman Sabir <officialnaumansabir@gmail.com> writes:

> Fix various typos and grammatical errors across documentation files:
>
> - Fix missing preposition 'in' in process/changes.rst
> - Correct 'result by' to 'result from' in admin-guide/README.rst
> - Fix 'before hand' to 'beforehand' in cgroup-v1/hugetlb.rst
> - Correct 'allows to limit' to 'allows limiting' in hugetlb.rst,
>   cgroup-v2.rst, and kconfig-language.rst
> - Fix 'needs precisely know' to 'needs to precisely know'
> - Correct 'overcommited' to 'overcommitted' in hugetlb.rst
> - Fix subject-verb agreement: 'never causes' to 'never cause'
> - Fix 'there is enough' to 'there are enough' in hugetlb.rst
> - Fix 'metadatas' to 'metadata' in filesystems/erofs.rst
> - Fix 'hardwares' to 'hardware' in scsi/ChangeLog.sym53c8xx
>
> Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>

The "3/3" in the subject suggests there's two other patches somewhere?

Thanks,

jon

