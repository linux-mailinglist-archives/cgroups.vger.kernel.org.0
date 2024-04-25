Return-Path: <cgroups+bounces-2701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7918B1A08
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 06:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FC11F22E2B
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 04:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE4839AF0;
	Thu, 25 Apr 2024 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiaxAdkq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D718E02;
	Thu, 25 Apr 2024 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714020723; cv=none; b=Fm6jIMncQO86JNsr1IpJaGEauh3HGgtts5V3+hR3MJivkUqgZaIrdBll1S65dEDRYwfKrnqdxy0mOMdi+dqfR/IsFuCVbA8hz4n3PWZq5BXiOoyJ6idTl3tGkTvXpCWuSY0qUI9SN4rRfWrrhLyad6UxOfPedz9b5RiceDFHCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714020723; c=relaxed/simple;
	bh=p7hjWUgR2R06dl3ei0tERDhkngFe7TKEuv52mjeiL5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YPyInGZu3qzDUzSgbsuyKcKTd3WOmXlTCo0DHQ2TJoATXpwN0BgPQxQqclq+0knqqOsHSPY4nzqinuvrm3o6zIPRwHbJ56XxkIUqUADAVbqrcsq0QkjQPAaPekxS6D375iQaA0+Jbz/s4zE1RfQ51ZnzYHQQfU0xlVfciuQ7r3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiaxAdkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FEEC113CC;
	Thu, 25 Apr 2024 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714020722;
	bh=p7hjWUgR2R06dl3ei0tERDhkngFe7TKEuv52mjeiL5k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KiaxAdkqqt8DPt6Nx4tssIeQoaNyqm4bSg1T6g8X3IVz3zUBEtkmlWuLfozSxqh4I
	 F2ToYlUTcWMLnVGmHmqBFOxA+K+/9Bv+gzvLDRcAt9Jj6pABjdGp6AsLqpYZ3Hw3dc
	 t8VjDL6yYzo/6vmbZtbGx2HCxOHkYtwMxiMR7S07OIk0Z6/p/9vbLYq6ec+S4rA4Dc
	 vK8+PPe1Hv6CGTBAekkqBJH1kR2PonEWVoNwFdgHH+glGj9cn4xN7B/SL0TzrfflZF
	 s1w0WYN1lhEguuFjXWHSTFhOFl1KSgesFYSt0jAyE3UtZ9oGSrgVYYcqeLd8AdpbqX
	 PZW+8UIIOt+Wg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Apr 2024 07:51:56 +0300
Message-Id: <D0SXMUQP947S.3KBGA0PH06PDX@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org>
 <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
 <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
 <op.2mqzodbxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mqzodbxwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Wed Apr 24, 2024 at 10:42 PM EEST, Haitao Huang wrote:
> Hi Jarkko
> On Tue, 16 Apr 2024 11:08:11 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
> >> I did declare the configs in the config file but I missed it in my pat=
ch
> >> as stated earlier. IIUC, that would not cause this error though.
> >>
> >> Maybe I should exit with the skip code if no CGROUP_MISC (no more
> >> CGROUP_SGX_EPC) is configured?
> > OK, so I wanted to do a distro kernel test here, and used the default
> > OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.
>
> I couldn't figure out why this failure you have encountered. I think =20
> OpenSUSE kernel most likely config CGROUP_MISC.
>
> Also if CGROUP_MISC not set, then there should be error happen earlier on=
 =20
> echoing "+misc" to cgroup.subtree_control at line 20. But your log =20
> indicates only error on echoing "sgx_epc ..." to =20
> /sys/fs/cgroup/...//misc.max.
>
> I can only speculate that can could happen (if sgx epc cgroup was compile=
d =20
> in) when the cgroup-fs subdirectories in question already have populated =
=20
> config that is conflicting with the scripts.
>
> Could you double check or start from a clean environment?
> Thanks
> Haitao

I can re-check next week once I'm back from Estonia. I'm travelling now
to https://lu.ma/uncloud.

BR, Jarkko

