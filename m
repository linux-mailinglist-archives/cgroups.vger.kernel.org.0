Return-Path: <cgroups+bounces-1304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF6846461
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035CA1F25B49
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61047F42;
	Thu,  1 Feb 2024 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0XzMuOd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0947A76;
	Thu,  1 Feb 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829887; cv=none; b=n2J1EeKAAeN+aWtEg060bdxW9vqTSeD6cRsmi1dn7ByOaP2cK3Ks97tJ830ljhSvQfFulJxqyg8GTcSx4hdq0H/OshDu9kIyc4r6lSD+0BpuKrn6jcz+3AmFOdh4/fK6HxW8X3t3ljR59pyqLBPEDXRdPqCGhr3kBB9vFgqrt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829887; c=relaxed/simple;
	bh=29ymSF83LMCAgc8Jc+xdiNbStl96qMAKQ7peACjIdJE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=a/aIsPv//f+L39a4XxLk5Z6i82pmOgro6NECk5TptA3UUR4a7E1lHgVBkNODfzK+HdbOOLWlCMh6MXoVaV0mH5Tar/B+bn4icDZA1oWP5b8qwkFUdtuzLF8l4i7/ti+YBkhNFuOwXa6eBCboMhyIEvTnebAMfdpPoOZqwDsLVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0XzMuOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6ACC433F1;
	Thu,  1 Feb 2024 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706829886;
	bh=29ymSF83LMCAgc8Jc+xdiNbStl96qMAKQ7peACjIdJE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=X0XzMuOd5hoPWvC8SnCXX3g/KE61k/Y6XlPYjysECtn3CJZb+ZMifLZZGzG2dzDfg
	 +m961kMAvogUvDsnjjF45qisnqlarAm+v5K7wuMtNgMg1XheVPs3HqkDCWdep6Knkh
	 GwgEyJpAq8xrON0LuLUlE+PZeQtZdGaXSDyLkXvETLu2lvk2/UtCKgqA9JFXBuFn1V
	 8GLwjnJDstSrTOiSqZVnCf1mmaiXIalokWDaf87W2lCQFlx9fbsYn+eLnedZ1BRm5j
	 x6q6IRH+NosAEI0GvUSWGaVmfF6nCCXnNufbRKyvs/IOwyhaDOf4RNc67sOEZvbB7K
	 mK5sTJzYqpjXA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:24:40 +0200
Message-Id: <CYU4P2CYNVSK.1UECAD4N86P8Z@suppilovahvero>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 01/15] cgroup/misc: Add per resource callbacks for
 CSS events
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-2-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-2-haitao.huang@linux.intel.com>

On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> The misc cgroup controller (subsystem) currently does not perform
> resource type specific action for Cgroups Subsystem State (CSS) events:
> the 'css_alloc' event when a cgroup is created and the 'css_free' event
> when a cgroup is destroyed.
>
> Define callbacks for those events and allow resource providers to
> register the callbacks per resource type as needed. This will be
> utilized later by the EPC misc cgroup support implemented in the SGX
> driver.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V8:
> - Abstract out _misc_cg_res_free() and _misc_cg_res_alloc() (Jarkko)
> V7:
> - Make ops one per resource type and store them in array (Michal)
> - Rename the ops struct to misc_res_ops, and enforce the constraints of r=
equired callback
> functions (Jarkko)
> - Moved addition of priv field to patch 4 where it was used first. (Jarkk=
o)
>
> V6:
> - Create ops struct for per resource callbacks (Jarkko)
> - Drop max_write callback (Dave, Michal)
> - Style fixes (Kai)

This version looks nice and smooth:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

