Return-Path: <cgroups+bounces-2253-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F41892AD0
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 12:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6358A282E09
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906532C6BB;
	Sat, 30 Mar 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQERnMEI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465B847B;
	Sat, 30 Mar 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798163; cv=none; b=OWE5QMjiw2JtBzqb2FOg6gmCFN0tWaznEF/Uj08qKlai9VtlcJX3+t0Yu/u8YfpzBqLJ5zBpXiLtVH9gMfZeK8HeR3TYgPwijFRXZoiauJKHvh7vZBQvfHCCY1tXZ2INh3VC5yRWR6Rp2XohzdYhcakCvWTKNgUZ1jMHPY2ZU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798163; c=relaxed/simple;
	bh=+7B/yrGFp37Kx0nQkDUOYGW1RCsXvAn6Vinrds5Ck7U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k59iTB/zZ5+mXG8Zj8v2eenYO6go2oSpqqD8ODDMFic7gw8b+oAoliDIvtPOrntrUaJso9FnQcHOe4oSjsw4PBMCr4s6CxEzGqxVp5+loz+DYp/eofkQERw9BlK0Y04Ir9p0F50Sp20RpgrDIg6Rvwx0Irrqc7jcMCFP+6WnfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQERnMEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980FBC433C7;
	Sat, 30 Mar 2024 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711798163;
	bh=+7B/yrGFp37Kx0nQkDUOYGW1RCsXvAn6Vinrds5Ck7U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FQERnMEIux1+CObR1szJYJNmA/d8A5k7dAPxpJGXjm1bv5IwW/vLzdmMAu6FiyndL
	 fIGdSA+TShvM1YEc92h441kk58jgGPRK5noalj6Y3flv+O93rllQg8FOEyhMijSP8k
	 BE39KUbFfuLPo3cXpewkOxyaAIy3h1CpSKcKuddiyn93c+N58mZZUa5FGHpqtimSgy
	 rFGq0klYspjuY/dDcdKTEXhB06v52ftojpZGlZqFRCpmrsyx8hSJvPjcVJXGiX9IpH
	 +dym2EGC/In7T61OTdnZeNS4a0dvC2J5q5jFv2YrWBqDfNW3hj1Y22tY5JpjcHzR39
	 +A+PuApC7vSEg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:29:16 +0200
Message-Id: <D071SWVSOJLN.2C9H7NTS4PHGI@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-15-haitao.huang@linux.intel.com>
In-Reply-To: <20240328002229.30264-15-haitao.huang@linux.intel.com>

On Thu Mar 28, 2024 at 2:22 AM EET, Haitao Huang wrote:
> The scripts rely on cgroup-tools package from libcgroup [1].
>
> To run selftests for epc cgroup:
>
> sudo ./run_epc_cg_selftests.sh
>
> To watch misc cgroup 'current' changes during testing, run this in a
> separate terminal:
>
> ./watch_misc_for_tests.sh current
>
> With different cgroups, the script starts one or multiple concurrent SGX
> selftests, each to run one unclobbered_vdso_oversubscribed test.  Each
> of such test tries to load an enclave of EPC size equal to the EPC
> capacity available on the platform. The script checks results against
> the expectation set for each cgroup and reports success or failure.
>
> The script creates 3 different cgroups at the beginning with following
> expectations:
>
> 1) SMALL - intentionally small enough to fail the test loading an
> enclave of size equal to the capacity.
> 2) LARGE - large enough to run up to 4 concurrent tests but fail some if
> more than 4 concurrent tests are run. The script starts 4 expecting at
> least one test to pass, and then starts 5 expecting at least one test
> to fail.
> 3) LARGER - limit is the same as the capacity, large enough to run lots o=
f
> concurrent tests. The script starts 8 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all process exit.
>
> The script also includes a test with low mem_cg limit and LARGE sgx_epc
> limit to verify that the RAM used for per-cgroup reclamation is charged
> to a proper mem_cg.
>
> [1] https://github.com/libcgroup/libcgroup/blob/main/README
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

My previous comments and you have two undocumented dependencies for your
selftest (I searched for cgexec and cgroups-tools as keywords).

BR, Jarkko

