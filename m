Return-Path: <cgroups+bounces-4514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1049961698
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D5A1C22E51
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039E1D1F70;
	Tue, 27 Aug 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOutDUOE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BD1C9EC8;
	Tue, 27 Aug 2024 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782564; cv=none; b=Exck0MvxcZDLVBWSNKRXXCLTuj/oR5zFs+2aozxShbEMf4CCLsz5z9qxM3rUMMHY1+4my0rKXdR6DCSnLYAUXeU4qzAAgOL8xisdyIAjvhAAiulfk8e7pBH+1dfPx9N7Qhce43PmEEYd8RSeec63U4Xow+pirWX3gbfprDz6RtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782564; c=relaxed/simple;
	bh=ksH9jXO8i3tKAuJWox1KqrNbHbzqNUGd/zk7k3ircp8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RL50KluTp7UeST0TymKu+NvlV81ulqKGvEu1phE5pa+4r68L9OhgGB8DHsckNrnzCGIKAYlPkRd5Zzuem9enmQapz8ksRmG+5znf3VAQXsPD5h45A2vTOawWRxsE6+19jTktREX9V5ziOwHCSrFTBOYBM567cL4AREdXrGfsYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOutDUOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F967C567C2;
	Tue, 27 Aug 2024 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782562;
	bh=ksH9jXO8i3tKAuJWox1KqrNbHbzqNUGd/zk7k3ircp8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MOutDUOExWpk/4joejGqGfZPi/exnMaswomCZdP5ZA+ilPdk4USLv0FOXj9Q5Hq2n
	 oEqzCujazgptd/nlL2lwxei/oR24UXYHyV/o3vz8/DDsU4taJkoymgGbsxOsqYaA62
	 dz+S1oblAPm0jalf+/m4hqRYgO7fa3MTzu7jLiCQd4hFlHVfLf0kedVZ5/raJoe/DH
	 zV9NuvPKP6NkBk1MfAb8vcIpKe+zaXvZ3fAEdLTJyrvhlmkf4yoLbViOellnmibwi7
	 Bg0rz4kMMoHrt6ZLXlSsylbkysUS2DMVFdOuTyXyogy/+I0VVci0ywd+NtQIM8bX6V
	 d0s7flQQbXSxQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 21:15:58 +0300
Message-Id: <D3QWE0Z23AVM.1ZWNVW0C9NWMR@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 10/16] x86/sgx: Implement async reclamation for
 cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <chenridong@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-11-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-11-haitao.huang@linux.intel.com>

On Wed Aug 21, 2024 at 4:53 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> In cases EPC pages need be allocated during a page fault and the cgroup
> usage is near its limit, an asynchronous reclamation needs to be
> triggered to avoid blocking the page fault handling.
>
> To keep implementation simple, use a workqueue instead of kthread to
> schedule the asynchronous reclamation work. Add corresponding work item a=
nd
> function definitions for EPC cgroup.
>
> In sgx_cgroup_try_charge(), if caller does not allow synchronous
> reclamation, queue an asynchronous work into the workqueue.
>
> The current global reclaimer, ksgxd, maintains a threshold for the
> minimal free EPC pages to avoid thrashing when allocating EPC pages.
> Similarly, only reclaiming EPC pages from the current cgroup when its
> usage actually reaches limit could also cause thrashing.  To avoid that,
> define a similar "per-cgroup usage threshold" and actively trigger
> asynchronous per-cgroup EPC reclamation when the usage reaches the
> threshold after try_charge() is successful.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

