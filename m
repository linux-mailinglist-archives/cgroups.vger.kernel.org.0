Return-Path: <cgroups+bounces-11462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D2C25D7F
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEEF1A219CB
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D0271A94;
	Fri, 31 Oct 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc8FbJqr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE22D23B1;
	Fri, 31 Oct 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924607; cv=none; b=pDZ8T5q0G5SjgWSUZinuFrAM4dYxdy3m/dq8+9L7ikqPo3TNp+VQLhlFFvX3K9cFF60yQ/Qpe9VjIpwZ2E/hMiRgrkP5MWKBjPLYem7Yq4fvzGpulD/cHF6A1f3+UnURGuB9lE0jEK8aAbcoXckJWYkxUdbFpDh3qgL88SURWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924607; c=relaxed/simple;
	bh=YN9mFpyOirMJG3gxerIW77pECs9cukfzbQfkHOAQpHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS0qujMUWvoioKtTSzcBP1GNWdxUbHu0ZHiA1QJoT/1/Y7AKNmNsJqg1626KfzqCx+8LCT4Qe2wTnz6Vnupq8tBhQzIhX+Kjw3Tzbt2lScI99P03Q212lI5p5JrY9rHaSk5tpDqc85/4GZTjAArflud+xGayB+KTZibe6h7UnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc8FbJqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA2C4CEE7;
	Fri, 31 Oct 2025 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924606;
	bh=YN9mFpyOirMJG3gxerIW77pECs9cukfzbQfkHOAQpHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qc8FbJqrkdCIX64uhcGh/3sGHjyZ/kg6c299TYuVaR/EIJqJe7VvR4brCH0bIYjIm
	 ccsiXGVZz9k3yUOR3gfrmQ4kIjoms18UgykNgu+1CPsw1KuPLyFPYP/ri0CslMVeUb
	 vNzzDSei9y78K6SkntbzS3NuE/nOFh03zqzWcjMyZqDmbWPbmwfVj9iGHSmvPPXwPc
	 bLnL/UODhTrwTO/5oR0zP4Ffx/OwNa3rxctvcB2Auk1OYMjRRkNvJeY9CtHVN3Bugi
	 cKqrp5O5IQGjZsNXoECmy3q447y0cXLwfHpdovDId8J2RkKvC1IhxGiQRqQ+t06oEy
	 OmO8wkiAp0STQ==
Date: Fri, 31 Oct 2025 16:30:04 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aQTV_F-p4tGjdBEq@localhost.localdomain>
References: <20251013203146.10162-2-frederic@kernel.org>
 <20251014205313.GA906793@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014205313.GA906793@bhelgaas>

Le Tue, Oct 14, 2025 at 03:53:13PM -0500, Bjorn Helgaas a écrit :
> On Mon, Oct 13, 2025 at 10:31:14PM +0200, Frederic Weisbecker wrote:
> > HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> > therefore be made modifyable at runtime. Synchronize against the cpumask
> > update using RCU.
> > 
> > The RCU locked section includes both the housekeeping CPU target
> > election for the PCI probe work and the work enqueue.
> > 
> > This way the housekeeping update side will simply need to flush the
> > pending related works after updating the housekeeping mask in order to
> > make sure that no PCI work ever executes on an isolated CPU. This part
> > will be handled in a subsequent patch.
> 
> s/modifyable/modifiable/ (also in several other commit logs)

Languages are hard.

Fixing the set, thanks!

-- 
Frederic Weisbecker
SUSE Labs

