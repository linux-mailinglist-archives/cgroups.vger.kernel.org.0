Return-Path: <cgroups+bounces-8315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB1AC148B
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 21:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E674F16F240
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34E29CB27;
	Thu, 22 May 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFlHGESg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC5288C1B;
	Thu, 22 May 2025 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940839; cv=none; b=umg0zi3ZZROcJItCJzWk3rGErT6ykeuNvW6ZqIL9++L6P3IL71f/JgQ+unLzzmub6A5BLvJFi32aokCtYf2p49evat+nLljR3bRMe6aDkwBETgLFvmxxRG7q7ysa4+gwULda5aacpfqYT+G2nvgNgWKCYp2n7jzF4cJ+aceBASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940839; c=relaxed/simple;
	bh=z93fW9aX4RSW6HmAdGJNE/kIRHN+vMqn5oOrqhHiTxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqXohvLsy7kbv3i1LCBFQ9QNtvsiJ81uCOiK7AE+qK6z/7JMSaR0KcrnEwHBqV+oswyHQp6FsgMAfbZTPymkc34z+3NM/sFJ/VeyhQEwg9z9cBpNQU6bR9ujj7wK6Hp3P5YSlOrgI8AQoSQxVs+h+RqyRJ4lEOq0pquY05jzH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFlHGESg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F006CC4CEE4;
	Thu, 22 May 2025 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747940838;
	bh=z93fW9aX4RSW6HmAdGJNE/kIRHN+vMqn5oOrqhHiTxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFlHGESg+0CfUVh/rMMW1dFrG57yuISW86zQM+GbLzzTQJLKi+mB3/RMIvb7lDtEF
	 tTIN2AT2eHl+GWN47LwiBlw/389Br9wnc33VdpbyOPwa/8Ab0wO6W2ZpDcxPC9ugeb
	 vSyKrOTxJvowlt1jZ3Q+5S9yKa3fd9ww1fzhle3JOkwinFq6MWTsk6JN8rwRkZKH/N
	 6yGdMOqy9lk7rkDaEl9y6JHj9JPyXJ6AZwZLtSYzmvzkB8Ps+teIheynZmA10LNYlt
	 s8a5JdZpYtY6IdGHJYQ7u2ywiW15W1Ce3jQjjYomshNAyD8yqG+uCLbH6fdmjCCe04
	 b4ot7Apa/kH5g==
Date: Thu, 22 May 2025 09:07:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v3 1/3] cgroup, docs: convert space indentation to tab
 indentation
Message-ID: <aC915Bge2uzZ8Q6A@slm.duckdns.org>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
 <20250522-rt-and-cpu-controller-doc-v3-1-483fc9cca591@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-1-483fc9cca591@sony.com>

On Thu, May 22, 2025 at 11:08:12AM +0900, Shashank Balaji wrote:
> The paragraphs on cpu.uclamp.{min,max} are space indented. Convert them to
> tab indentation to make them uniform with the other paragraphs.
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

