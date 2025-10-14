Return-Path: <cgroups+bounces-10750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0220BDB546
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 710B04EABD2
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1D306B38;
	Tue, 14 Oct 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swyR28py"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B373074AF;
	Tue, 14 Oct 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475195; cv=none; b=CYo+PYno5QPB+tEBtRPMlA2M984Er5uIlrAjo8ChPrLXsXhTyqqd66hV/lmPXv8L6vcuXZ9qfO3PvLMzru35PYs0ViSSJ1wSJ9ezszTi1GnYwoxSi2Ca2nq7Jqc0R8Qd+grKu5w24F3I2o4ccnjVsq0NXHOCzfwjhcVdqSfIJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475195; c=relaxed/simple;
	bh=n/LR/VOVuEOFCI8XhFHTE8VhAsveYLysbT1xUiVBRoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mc75yd0ujlKgb/7QKM5kiZW43Gm9/6fNf3dNl8DMsxHxq2bKPlKtgWH8ud6ROrX1i18REc/rnAZFs0jPJcqiiju8EA6IiB0p7YlbZdiHUvYUpUAJWj+dzhrfcu4eFQUAGH+gXfhiLSvN8rt+iqmL7OwHX0SSpp+r14AOlGP0lPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyR28py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21D6C4CEF9;
	Tue, 14 Oct 2025 20:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475195;
	bh=n/LR/VOVuEOFCI8XhFHTE8VhAsveYLysbT1xUiVBRoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=swyR28pypyBnRwl4m3DigwMj3bUrxOd00mzjuGD5aTN0FjLn8NZloGgLtoSm4EWF6
	 U+OQrImhcyFW1VE+1XOf7gsl+Z6u33VL59B3ZFGSMdhSCKfE10SSPf7PmGdnejwJFG
	 4W7sgMSd47UsSs4bbQQC0m2b54v2j6riWSO3ueU6abtrZ6v3Z1APYa4Dz7eg+oMj1c
	 E6GAg/xVIOaSHdCbI1G5jNYk9cUVlMAQIS1+cIiZKnhohliyM8TIACP4GiEgzG7+ha
	 7oSYLyFf2hw0TAj9/uWSaVineqdRxAJldC0oB4sXW5a4J7HK8JAuGF/KcmG4Gk36Tb
	 fkRsty8PnFzAw==
Date: Tue, 14 Oct 2025 15:53:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
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
Message-ID: <20251014205313.GA906793@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013203146.10162-2-frederic@kernel.org>

On Mon, Oct 13, 2025 at 10:31:14PM +0200, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> therefore be made modifyable at runtime. Synchronize against the cpumask
> update using RCU.
> 
> The RCU locked section includes both the housekeeping CPU target
> election for the PCI probe work and the work enqueue.
> 
> This way the housekeeping update side will simply need to flush the
> pending related works after updating the housekeeping mask in order to
> make sure that no PCI work ever executes on an isolated CPU. This part
> will be handled in a subsequent patch.

s/modifyable/modifiable/ (also in several other commit logs)

