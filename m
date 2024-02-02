Return-Path: <cgroups+bounces-1327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794C847D57
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 00:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D5D1F292D9
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F7912C81F;
	Fri,  2 Feb 2024 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoKzzng0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24712C809;
	Fri,  2 Feb 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917508; cv=none; b=UFWKh4y6Ho+w+ah6nDD5l8CifIZ+9HyXt2cKKMReaZc+T7uiMVcn6JU+qlC0RV+a9w0E6EgLbnUuNKZZF9mQftfcCJwe/hKnbT5Rhp0CYX+XLwNrGjPQI2pZ5Ly4WbDUntqyCDZ/Lj+9JbpvxzgqvX/m5Eo2lCp1s6XK5iQA/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917508; c=relaxed/simple;
	bh=u14JJUaOwUjTknw9OXMt8TK1fGhG5qE9VIX/LCcSv1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSCfDnMa1Cb4jvrUsUtH6+KAfWfm8jw4EEdAAzFXH4Hhsj/TqAvhJuuyneqXxhNo3590tfnqd0S1aXAzxprffdnLrc4JJRgZpl/p9l/g6cvhFZ5eUKg4q15M8wHmF7IoHZwCjHEDNpxeaJ8cTPHmlYzajh3Qr6lCVWF5Ba0P9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoKzzng0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706917507; x=1738453507;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=u14JJUaOwUjTknw9OXMt8TK1fGhG5qE9VIX/LCcSv1I=;
  b=hoKzzng0WtxrKW6Tm4tPaS/EZvwyJ1uVpk8XWwQ7hjrwZCpG8kR1Aa4q
   ECcCTehLssJ8RzpuNNyZfgslaCo6CDdYFNG3c4wzjAip0aQ0hJtNhqFva
   snzM8sDL52uOhhwDQokHHnL+8Zx1ZOsAfnAl67aveqwGmJKLN2uXxdKk5
   4urs01ECLVYfzgWEitR5b0wb79lxy32PRVQnWnCRUWeEtznOBhNAQ/d5Y
   Hf+MRKJP46MHBV7GFkbwAd4DD1EEGbMOwEIpPdVqfcnuMw0eTOw8kI/nB
   /Ul1IJiBPOT1iPS5V3YY/fc3DHWyDHZzBPJRnfn0vXowbtt+NgSvUeRHx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11629193"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11629193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 15:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4798202"
Received: from mkuchla-mobl1.amr.corp.intel.com (HELO [10.209.72.111]) ([10.209.72.111])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 15:45:06 -0800
Message-ID: <ca25d3462944dcea553665d7c85903cdd6a846bc.camel@linux.intel.com>
Subject: Re: [PATCH v7 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, jarkko@kernel.org, 
 dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com, 
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org, 
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de,  hpa@zytor.com, sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com, 
	zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com, 
	yangjie@microsoft.com
Date: Fri, 02 Feb 2024 15:45:05 -0800
In-Reply-To: <20240122172048.11953-10-haitao.huang@linux.intel.com>
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
	 <20240122172048.11953-10-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 09:20 -0800, Haitao Huang wrote:
>=20
> @@ -1047,29 +1037,38 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup=
(struct sgx_encl *encl)
>   * @encl:	an enclave pointer
>   * @page_index:	enclave page index
>   * @backing:	data for accessing backing storage for the page
> + * @indirect:	in ksgxd or EPC cgroup work queue context
> + *
> + * Create a backing page for loading data back into an EPC page with ELD=
U. This function takes
> + * a reference on a new backing page which must be dropped with a corres=
ponding call to
> + * sgx_encl_put_backing().
>   *
> - * When called from ksgxd, sets the active memcg from one of the
> - * mms in the enclave's mm_list prior to any backing page allocation,
> - * in order to ensure that shmem page allocations are charged to the
> - * enclave.  Create a backing page for loading data back into an EPC pag=
e with
> - * ELDU.  This function takes a reference on a new backing page which
> - * must be dropped with a corresponding call to sgx_encl_put_backing().
> + * When @indirect is true, sets the active memcg from one of the mms in =
the enclave's mm_list
> + * prior to any backing page allocation, in order to ensure that shmem p=
age allocations are
> + * charged to the enclave.
>   *
>   * Return:
>   *   0 on success,
>   *   -errno otherwise.
>   */
>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_ind=
ex,
> -			   struct sgx_backing *backing)
> +			   struct sgx_backing *backing, bool indirect)
>  {
> -	struct mem_cgroup *encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
> -	struct mem_cgroup *memcg =3D set_active_memcg(encl_memcg);
> +	struct mem_cgroup *encl_memcg;
> +	struct mem_cgroup *memcg;
>  	int ret;
> =20
> +	if (indirect) {
> +		encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
> +		memcg =3D set_active_memcg(encl_memcg);
> +	}
> +
>  	ret =3D __sgx_encl_get_backing(encl, page_index, backing);
> =20
> -	set_active_memcg(memcg);
> -	mem_cgroup_put(encl_memcg);
> +	if (indirect) {
> +		set_active_memcg(memcg);
> +		mem_cgroup_put(encl_memcg);
> +	}
> =20


You can reduce the number of if statements to make the logic
simpler.  Something like

	if (!indirect)
		return __sgx_encl_get_backing(encl, page_index, backing);

	encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
	memcg =3D set_active_memcg(encl_memcg);
	ret =3D __sgx_encl_get_backing(encl, page_index, backing);
	set_active_memcg(memcg);
	mem_cgroup_put(encl_memcg);

>  	return ret;

Tim



