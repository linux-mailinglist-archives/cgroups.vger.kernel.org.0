Return-Path: <cgroups+bounces-3112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA48FDEA9
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 08:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A2A1F216C2
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 06:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F673444;
	Thu,  6 Jun 2024 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6a3uCBz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9417BD5;
	Thu,  6 Jun 2024 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655045; cv=none; b=eNoXex+ofo4giKjHAQzcg983iB8nhZIZ6GHn7Cw1HXuCfC0YiXwD8dCU/geO4TrzTlJBYuZdi2u0XXcj8DDp647idhl39RVsxgiRXpB5b9zr7rV9quXk0TS542jyKSDhLVnRJH/T48qz+hxXCU6njb/37jUWreAjwPgn87ZbQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655045; c=relaxed/simple;
	bh=Xmf+9W3CuWTJtgo6IQWETLoxYV8aWEsYyhvAl4to5BI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=MtDX6pIoFAJhT8ZcwVuL/+RlgFJJ1PxkGb1Bv+Xfdi7sScXIxqOOzp9OkWbqOSxl+atUI3PzEF/eOOSUpBUBAPBG/DoGxswhEzU0KHtN4g7UUxA51nkVNIfdNiIW9fjk4r3kJivqzpS2rRrnRD5GkhqrFb2T/9mCsx3FcmeJ10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6a3uCBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FB0C2BD10;
	Thu,  6 Jun 2024 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717655044;
	bh=Xmf+9W3CuWTJtgo6IQWETLoxYV8aWEsYyhvAl4to5BI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=V6a3uCBzKKrXFU0sf5Wio7VKNFk/R+sFFVccK40BceTOBRmpggbf/7GL5usUiHpVT
	 F7gHqNe/M8rpWA6oAIaJvtxatNMjowRWXNTAgji3i4ivJnpFRqxJ34nTgLHKAdCxu3
	 oXoqKyrYtbYjL6Mz5PgVF0d+GLfmYaAnTnYIo8YrFYgVgFDLanMbID3cJFdErVQuJg
	 PVZjN9x+qc0s0EC4LTOD7i4NuU0tLLbiy7ZRSSGrIqqIG2ahSOiusGWnXr1dUkv4Td
	 nowd9hYqGEMTNBddwSYaxqD8Diyp6Z94nRNJeScCS22oXvoVchPylY/4eGAh/Fk5bl
	 3uEpd+nCPa4QQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Jun 2024 09:23:58 +0300
Message-Id: <D1SPW7EF9CTN.1BY6S0JCPDPPY@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Huang, Kai"
 <kai.huang@intel.com>, "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7cbf3583-a23e-4437-afc2-1faeb4a1f436@intel.com>
 <D1SPTDBBDU6F.2WLRZKYZWWTRB@kernel.org>
In-Reply-To: <D1SPTDBBDU6F.2WLRZKYZWWTRB@kernel.org>

On Thu Jun 6, 2024 at 9:20 AM EEST, Jarkko Sakkinen wrote:
> > There are existing code where BUG_ON() is used during the kernel early=
=20
> > boot code when memory allocation fails (e.g., see cgroup_init_subsys())=
,=20
> > so it might be acceptable to use BUG_ON() here, but it's up to=20
> > maintainers to decide whether it is OK.
>
> When it is not possible continue to run the system at all, and only
> then.
>
> Here it is possible. Without SGX.

With this logic sgx_init() should call BUG() in the error paths.

BR, Jarkko

