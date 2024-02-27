Return-Path: <cgroups+bounces-1886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30486A0F3
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 21:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3FE1F24FEE
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA748CFC;
	Tue, 27 Feb 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guZy/hT8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC8134B1;
	Tue, 27 Feb 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066481; cv=none; b=Pa2YbH/FqBsvFpykVvIdFqrn3PSKiwTqzaOWgRpDL8BthnN52Hl3UWsqaSwce1i4c1XyjZOclYlh4QhT5pi8/QPgdbsBaQ1E8onSIFJwlA8GIgKrKpWZQi7LFHbkWMntDWpgKi9rc66j2QeGhkqDDobaD7dOPempHi2Dj3I9HdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066481; c=relaxed/simple;
	bh=C3koc4BLUVBfCv4h3OTG4z56obl5Kil1OhlpatVuxVQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WJWs77tZfUCf5T0nuIV4FzRnTNBhab0mXtql1r86aJshGIO4TgcuGK5YVdAZ/qYAVWmFFvv5KeltH+ziKzM0mW3GVb1pPtbb0a4JhDJ/qHZBQBUJum3cl95al3wtpReMUlHDiN5zbCoxqQz8C10qGGxzjht+H/tIQPticMPHGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guZy/hT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B37C433F1;
	Tue, 27 Feb 2024 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709066481;
	bh=C3koc4BLUVBfCv4h3OTG4z56obl5Kil1OhlpatVuxVQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=guZy/hT88vtmqaJOKLgNAcTyuCLhnMzeuczn96zWG6ni0mK+00rJ5FGCHHba6RqJ6
	 EUQ8hd0rPuRyJ10yBvAQVDFMG7qS0jvLzF3eEwi+SpSw/zjVxjAjmV4sZHEHilV8/z
	 kGnbXcsb/uLZDhlM/zb+VjOMx9SrdgsaIaSvSQvGua4pTN1JgnBaTw4d+SFoft/h2a
	 iwnAsXaIfQK2J5Ey3QYFRathYuMTGBpdrdb8+5gKEYehV1Ry7OOlpagHp6dYKyzCji
	 2UcbLlU99UBKSPJ6W37HhQUwgSSoDHEPctMZ1xFZ/KheN4lUEhOZb0ED9dZXo4sZ6H
	 dPo8t615ACtBQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 22:41:14 +0200
Message-Id: <CZG5I3CPFINS.2ZV8CB5AXCCEX@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "bp@alien8.de" <bp@alien8.de>
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
 <d9b0df06-da68-4729-8aac-2a77e890e152@intel.com>
 <op.2jrquskiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3f4c6d12-7e0f-44ca-920e-ec219904e0aa@intel.com>
In-Reply-To: <3f4c6d12-7e0f-44ca-920e-ec219904e0aa@intel.com>

On Mon Feb 26, 2024 at 11:56 PM EET, Dave Hansen wrote:
> On 2/26/24 13:48, Haitao Huang wrote:
> > In case of overcomitting, i.e., sum of limits greater than the EPC
> > capacity, if one group has a fault, and its usage is not above its own
> > limit (try_charge() passes), yet total usage of the system has exceeded
> > the capacity, whether we do global reclaim or just reclaim pages in the
> > current faulting group.
>
> I don't see _any_ reason to limit reclaim to the current faulting cgroup.
>
> >> Last, what is the simplest (least amount of code) thing that the SGX
> >> cgroup controller could implement here?
> >=20
> > I still think the current approach of doing global reclaim is reasonabl=
e
> > and simple: try_charge() checks cgroup limit and reclaim within the
> > group if needed, then do EPC page allocation, reclaim globally if
> > allocation fails due to global usage reaches the capacity.
> >=20
> > I'm not sure how not doing global reclaiming in this case would bring
> > any benefit.
> I tend to agree.
>
> Kai, I think your examples sound a little bit contrived.  Have actual
> users expressed a strong intent for doing anything with this series
> other than limiting bad actors from eating all the EPC?

I'd consider this from the viewpoint is there anything in the user space
visible portion of the patch set that would limit tuning the performance
later on, if required let's say by a workload that acts sub-optimally.

If not, then most of performance related issues can be only identified
by actual use of the code.

BR, Jarkko

