Return-Path: <cgroups+bounces-4512-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54609961692
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 20:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875D71C22FBE
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0991D27B8;
	Tue, 27 Aug 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ0F7iOG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACE1D279D;
	Tue, 27 Aug 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782519; cv=none; b=I7phVyB8Docl2ze13j7PPPB9qRruTOPrKCx95HOeUi6KVJzYjV3PDdGkD2gGYt5S+hTTNdeOY8gy8LxMVcoZafwDNkX/vuGfBZmSN+5RMqIsvIpSnK2c+ZxE6VJ+VCOK0Ccr7xVmyNlR/p8w8c8STU+4qcgsBPUfd02oHBwCje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782519; c=relaxed/simple;
	bh=6wrO4imU4MwjakQht2O2MvehVpVYewcFDFcIkLEK+Uk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iuG0qZ+y4fpN0pcXpfFdDTAucp9PJEFEvsYe8YRFOXT/wKxDyyVSfAZL5fBawE8knhuOe1AU7q4vrPTyyCQEJ5YqW0kZo9wBsySM/UYqmWADfl02cUds5LOBL+63G5c8xvbDQev6bmLD+9OSk6XQIq5Jvjqm8thsr+M/6AhugUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ0F7iOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5F4C567C2;
	Tue, 27 Aug 2024 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782519;
	bh=6wrO4imU4MwjakQht2O2MvehVpVYewcFDFcIkLEK+Uk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aQ0F7iOGL9xReQnx9xoqcczVk92Y+EtBRqznvlwq8yteza29zi7rx4pLvtrIFROjU
	 DV+A3i6Y6/qWoy6km9q9X0fCUIaECGxSb1VVw5fUPwN8dKgGEkaXRh6djAudnM2ndK
	 5M53M/B9z2XlhUdc9XKHmZhwHWUn0TorFaiWnQV404TW/4bcHIl8DHURI0Z5AGJYtF
	 4IxvN4rCnp7SslSlJPZ7Owyzzb2sc80xFw7jo941IQHM1o+H4aHpVCEwQjyc1gcBex
	 dtU/NzBhhZ/GDTAFHulgWv70Piot3T30hz4qjtjbyDpoYOAuAtGKAL8NzgLDC9VRsI
	 eaos+4/4PRCNQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 21:15:15 +0300
Message-Id: <D3QWDGUOJ4NF.1I16RTUH9Z45U@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 08/16] x86/sgx: Encapsulate uses of the global LRU
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
 <20240821015404.6038-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-9-haitao.huang@linux.intel.com>

On Wed Aug 21, 2024 at 4:53 AM EEST, Haitao Huang wrote:
> To support the per-cgroup reclamation, each cgroup will have its own
> "per-cgroup LRU" and EPC pages will be in its owner cgroup's LRU instead
> of the global LRU. Abstract the code that is directly working with the
> global LRU into functions reusable with per-cgroup LRUs.
>
> Currently the basic reclamation procedure, sgx_reclaim_pages() directly
> reclaims pages from the global LRU. Change it to take in an LRU.
>
> Note the global EPC reclamation will still be needed when the total EPC
> usage reaches the system capacity while usages of some cgroups are below
> their respective limits. Create a separate wrapper for the global
> reclamation, sgx_reclaim_pages_global(), passing in the global LRU to
> the new sgx_reclaim_pages() now. Later it will be revised to reclaim
> from multiple LRUs from all EPC cgroups instead of a single global LRU.
>
> Wrap the existing emptiness check of the global LRU with a helper so
> that it can be changed later to work with multiple LRUs when per-cgroup
> LRU comes to play.
>
> Also the per-cgroup EPC reclaim and global EPC reclaim will have
> different check on whether they should be done.  Rename the existing
> sgx_should_reclaim() to sgx_should_reclaim_global() to separate the two
> cases.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

