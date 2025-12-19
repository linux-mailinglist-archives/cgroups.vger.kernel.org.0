Return-Path: <cgroups+bounces-12533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0ECCF1D4
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4C273014AA0
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FA2EE5F4;
	Fri, 19 Dec 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJeGBQSm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422923F422;
	Fri, 19 Dec 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136251; cv=none; b=eqKNX5tp1fJFHhqhcw3Jm7luOxe5TddGJHWIy4IvmJQjKuAV7tHdGUOqzSViQRFkDNYYm70H1JlQzMW+hUZ7ymd9QzMOKwN/XRbhv9lnySpMuSsrHfKLe34dMXlUEILXoerHYWcfwQ/NTsgSdhZqzCMUgbUBywTAaevpP2nGWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136251; c=relaxed/simple;
	bh=Q7Tat+DlNEr9zwMi10HMp4z6C9OLetF7wpcLmG3Nr6o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FwQSafTfd4dalOHLti1/yWiRqvQEtkWVVY4jC+kPBn26kx8+zhnEw+TbZMOgx06ZCScPL5s2a0m3/5s/NAzloL53VO/Azgx406b0o8w8dvU/puJOdzUdE3iNC5KzEKGnnVqRYGerOMdxqPdDviNjb4jqxfFuvgsySGFve5GJnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJeGBQSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B4DC4CEF1;
	Fri, 19 Dec 2025 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766136250;
	bh=Q7Tat+DlNEr9zwMi10HMp4z6C9OLetF7wpcLmG3Nr6o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iJeGBQSmHJ7xw1ebYcMUv3OrvqEJD8ApYHkRX1ViM7KpcnS7B1rgP9tfs5oxhCWxG
	 Rm4PC/W74o0ejiM5LppZqRSXCRA3mkvKrEqhBNHF71/01oLwgSlur+w8TiPru/pfNA
	 u6gD2qSIkrLr/pl0EqJdTRIO8VIvSkp7K+EKwRy+3CX8K6jyknqpEOkcpvKCfSjXuU
	 O7A015VxRzBIkWTt7M5mRFS65Q2fWGTO7PtKfATaKOMZ9P7oS7GZMVehzzLliUCnad
	 dP+OOoFlqnFYcbQVr75YsMhKxRupFcTd8VU1IytrRfG1l56lCgntqqYmaXktA3+9wo
	 TD0xhhbb/eLhg==
Date: Fri, 19 Dec 2025 17:33:24 +0900
From: Kees Cook <kees@kernel.org>
To: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
CC: =?ISO-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
User-Agent: K-9 Mail for Android
In-Reply-To: <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
References: <20251217162744.352391-1-mkoutny@suse.com> <20251217162744.352391-4-mkoutny@suse.com> <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com> <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
Message-ID: <6387B54B-7524-4AB9-AB05-4AB529353EF4@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 19, 2025 1:09:42 AM GMT+09:00, Tejun Heo <tj@kernel=2Eorg> wro=
te:
>On Thu, Dec 18, 2025 at 03:09:32PM +0800, Chen Ridong wrote:
>> Note that this level may already be used in existing BPF programs (e=2E=
g=2E,
>> tools/testing/selftests/bpf/progs/task_ls_uptr=2Ec)=2E Do we need to co=
nsider compatibility here?
>
>That's a good point=2E Is __counted_by instrumentation tied to some compi=
ler
>flag? If so, might as well make it an optional extra field specifically f=
or
>the annotation rather than changing the meaning of an existing field=2E
>
>Thanks=2E
>

CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS use the information for inst=
rumentation=2E

--=20
Kees Cook

