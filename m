Return-Path: <cgroups+bounces-8540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE7ADB7EC
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7BA3A981D
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCA288C36;
	Mon, 16 Jun 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgmHtgjO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79E286D49;
	Mon, 16 Jun 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095907; cv=none; b=lqjoYITvDX2f4GVvU0ATCb2a/W5+xe5OyjgB+EIymrPjl8JJgrDUCPiDBFUkmnh3gDNTCD2NsrCexUnDA5OmRJxLJHf1zJdVcyq8JjQ5Xx9UJbqpw5+cgGKfmfukURI1MSfg0TzXljExZ6PbJszvcnnR5fSAEum/rLDsx5uBCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095907; c=relaxed/simple;
	bh=8yClafGnbycHH04eqz+Hp3jWxoFYSNEUzIISxplzaVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liZQBG9Bz26ZJhswsowkbrTnrC5czt9jyxl9MAxoeBWAPdeLnCJaqbpx19DEnnZEU2al1+aySGjxY9iwnkQpyRxBcoJSEYKzmAUT1gssw6THmiEgXDXEWPFHn/dhRkr5Sqs7enNDwhWvfBSaALJgEUdWRRtLdnySm7H/bVc3hdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgmHtgjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36668C4CEEA;
	Mon, 16 Jun 2025 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750095906;
	bh=8yClafGnbycHH04eqz+Hp3jWxoFYSNEUzIISxplzaVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgmHtgjOXekHxtj2GxeCuh2FuJMn3wrAqLIWBpCYd44ttXuaTJNSXuc7uvn5EUyzx
	 blHmc6AdKrEMgG6eMbpd13r3osvytSVnz7eCoB66+tlwwlStWZE3t1tORCrezCtpbR
	 2zozLBfpjJWTwCuO9WqeLHPYa9dNtcONsJdxyD8nWEbmC+C7FuzCOef93/cuG5Enfa
	 WDTEeQ/+SVX9UfswJ6bdGsEuVLcNDZaqOcHNRllv+XLezx4thabiSV7RecbDKXr4hF
	 3H6HurjdjCGrgwMxwfDYpUz9yPgijsM4Vm69TbJeWBHYO99baO6Ao78yR5fFKfR6LE
	 5VIp7nf7tVwug==
Date: Mon, 16 Jun 2025 07:45:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, guro@fb.com,
	kernel-team@fb.com, surenb@google.com, peterz@infradead.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	andrew@lunn.ch
Subject: Re: [rds-devel] [PATCH RFC v1] Feature reporting of RDS driver.
Message-ID: <aFBYIdaq8NOk_v3U@slm.duckdns.org>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <aEiZ212HZo3-zpMc@char.us.oracle.com>
 <aEikeOlAjvbqm_7v@slm.duckdns.org>
 <aEi8k1yKBn0egAui@char.us.oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEi8k1yKBn0egAui@char.us.oracle.com>

Hello,

On Tue, Jun 10, 2025 at 07:15:31PM -0400, Konrad Rzeszutek Wilk wrote:
...
> > That said, the sysfs approach is pretty straightforward and has worked well
> > for us. One thing which we didn't do (yet) but maybe useful is defining some
> > conventions to tell whether a given feature or option should be enabled by
> > default so that most users don't have to know which features to use and
> > follow whatever the kernel release thinks is the best default combination.
> 
> I see. With that in mind, would it have helped if each feature had its
> own sysfs file with a tri-state or such?

I don't see why that wouldn't work but maybe a bit too elaborate?

> In regards to the existing 'feature' sysfs attribute:
> 
> How were you thinking to address API/ABI semantic breakage? Say older
> versions implemented a "foobar" feature but never kernels implement a
> much better way, but with a change the semantics (say require extra parameters,
> etc).  Would you expose both of them via the 'feature' sysfs attribute: "foobar\nfoobar_v2" ?
> 
> What would be then the path for removing the old one? Would you just
> drop "foobar" and only expose "foobar_v2" ?

I don't think there's one good answer but here's one:

- Each token in the files represents an optional feature.

- A feature preceded by + is expected to be enabled (or used) by default. A
  feature preced by - is expected to be not used.

- When introducing v2, make v2 +, the old one -.

- After users are reasoanbly migrated, start generating warning on v1 usages.

- Remove v1.

Thanks.

-- 
tejun

