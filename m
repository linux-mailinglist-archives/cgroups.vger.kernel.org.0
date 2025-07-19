Return-Path: <cgroups+bounces-8784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6CB0B0E8
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B252B3B602D
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D412874ED;
	Sat, 19 Jul 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD4qVCij"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51A1F0995;
	Sat, 19 Jul 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752942449; cv=none; b=NT8c2pV5e2qHBKTVNkKtIrhP6sot/VxAfmB9DvBiyjHSw7QVSaQhjt3spcfW+3a3Jr5d1dhr7jBJA68jvnay/CfrAI5ddGGEUKvgIVl4H6P8kCBOw4H3VDfQoCTkrpWXhSW22/cOrqkBT3XJVRUugT3bO2pFkqqW+VciZphymiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752942449; c=relaxed/simple;
	bh=x59sCC/nT63ijVIF6qQAi5qHK7n8i7j+AwnQIsEn6l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip/ROa8A54W2A5s8OfyEECe2P4TS6nD/gPyxvD9P0dr78XD4kz6MdklkrA/MKHomN3boB9YRhtgXI08ZpZYfZ+4hzm757BvqWcaN+dfg4DzFL+zXsCwwqH/q6/L0KEBWKYabSDJs3h8hYASTRFg3rfmG30U09TsqUwdHk7mylvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD4qVCij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A486C4CEE3;
	Sat, 19 Jul 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752942448;
	bh=x59sCC/nT63ijVIF6qQAi5qHK7n8i7j+AwnQIsEn6l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PD4qVCij5GQf+kLinTcQTataL/IQ5nhr/iRTuNWWAfctQi54nLrwpPv0rpMDKhfOW
	 +W51TVEVpygulJ4H1b4q+rP8/JKK7XYzOPzlPzZPRQLMGGIw3o8aYdD4IUe1wAgxK0
	 jYI55yLZD3bhBwIQ4Ahy6+MeO6+Uu4O8k9U61aFq/PEKTCj6pNo/+b6nOuS1UstCK7
	 aUeNMXcRFlt2MWWJJ5snAw0QYAA22ZSrzsi19ScyEcBmkY6Mn0+vr3VYSbz7khUIMx
	 uffoiF8oUWuBlyY9QCMeAkxSCjLlKDkR+ld8zskqKeTbaAHrs0n++mDRToIP4uKcYc
	 Y51GtgnA0rbtQ==
Date: Sat, 19 Jul 2025 06:27:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
Message-ID: <aHvHb0i6c8A_aCIo@slm.duckdns.org>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>

On Sat, Jul 19, 2025 at 10:01:07AM +0800, Chen Ridong wrote:
...
> What I'm considering is moving the implementation of cpu.stat from cgroup_base_files to
> cpu_cgrp_subsys—without changing the user-facing interface (filenames and content remain the same).
> However, the interface would only appear if the CPU subsystem is enabled.
> 
> Currently, cpu.stat and cpu.stat.local are visible in every cgroup, even when the CPU subsystem is
> disabled. The only populated fields in such cases are:
> 
> - usage_usec
> - user_usec
> - system_usec
> - nice_usec
> 
> I’m unsure whether this change would be acceptable?

I don't think so and don't really see what benefits moving the stats would
bring. Why would we move these?

Thanks.

-- 
tejun

