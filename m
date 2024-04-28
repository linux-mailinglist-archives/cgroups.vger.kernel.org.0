Return-Path: <cgroups+bounces-2713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF68B4E6F
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 00:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D50A1C206A6
	for <lists+cgroups@lfdr.de>; Sun, 28 Apr 2024 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF5BA2E;
	Sun, 28 Apr 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if2Ye99H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47382F44;
	Sun, 28 Apr 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341804; cv=none; b=mOgH11Hy98lYFCdd0H6JGYdaynn7ve67C+7oWqo4/pqxK8+oW43YD/k8uMkqq4Pgt7Pa5LSK2E0MOP2ks0gFQ1BzFvjs3K8EW2XWES+gyr3Kfpj8bxgs+zbqIy4QHY8YxqorVklWFtU2TNvc66A/TBMbspVxbBJ52Bq5SdNfzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341804; c=relaxed/simple;
	bh=ambIjCt0dHWovx83ZJuXThRMYcTMq0iDPC2InteFJrs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qR5gond3HlVzxst0bvvSI2y3TW2k83kRQmkC4wJx9Dd2aOXiM4bvk7ogH1DDYhSN/nuacEloABNyjpfZvlxo4HMrh3GV3AbtWGHFrXBuNiw6+i8AaCC/HwEd7qaO+Vxkhxc0XypfCZoXr+QmXFzTZbX2wqhfFLLhk+IuSaqWr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if2Ye99H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2774C113CC;
	Sun, 28 Apr 2024 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341804;
	bh=ambIjCt0dHWovx83ZJuXThRMYcTMq0iDPC2InteFJrs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=if2Ye99HCceTNazUjBYkPYPLG8oueQ3JmHMVnP9RVf1jT7RJD+P3g9P5KRuzPby33
	 VDs2OSeINZvSZhpxr+TjQAY6DgcHVG/gln1XRFYuxMR7V1OYR0rMkQt6Kh6AuHgsjk
	 UTPJGuAQHo1g2K/eS/Ifg4VHjeyNOfKRjVZGoTOv3NgkBuqPakQ81cBUomiwz/yMcX
	 zUkVI2CqO+N6bNAlO6HkpBGNX03sefg6gkpvVi+jZgogonvwaoXVO9RUsCw4p7RuTE
	 sB2tTw0p1oJavBslNCgT6W3i3UhDMogqwwq6iAocPNaqH2FQz9nwlQngoFxZm5YNxy
	 lU5zuk4XqVqnA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 01:03:17 +0300
Message-Id: <D0W3G5GVNMMW.3OCGUH8AYNORY@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
 <haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
 <D0LLZTSVG3BC.8WIRM39WC7UU@kernel.org>
 <f62c29ec-f893-4320-8097-f6b3a372267a@intel.com>
In-Reply-To: <f62c29ec-f893-4320-8097-f6b3a372267a@intel.com>

On Fri Apr 26, 2024 at 5:28 PM EEST, Dave Hansen wrote:
> On 4/16/24 07:15, Jarkko Sakkinen wrote:
> > On Tue Apr 16, 2024 at 8:42 AM EEST, Huang, Kai wrote:
> > Yes, exactly. I'd take one week break and cycle the kselftest part
> > internally a bit as I said my previous response. I'm sure that there
> > is experise inside Intel how to implement it properly. I.e. take some
> > time to find the right person, and wait as long as that person has a
> > bit of bandwidth to go through the test and suggest modifications.
>
> Folks, I worry that this series is getting bogged down in the selftests.
>  Yes, selftests are important.  But getting _some_ tests in the kernel
> is substantially more important than getting perfect tests.
>
> I don't think Haitao needs to "cycle" this back inside Intel.

The problem with the tests was that they are hard to run anything else
than Ubuntu (and perhaps Debian). It is hopefully now taken care of.
Selftests do not have to be perfect but at minimum they need to be
runnable.

I need ret-test the latest series because it is possible that I did not
have right flags (I was travelling few days thus have not done it yet).

BR, Jarkko

