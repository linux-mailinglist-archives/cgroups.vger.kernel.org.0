Return-Path: <cgroups+bounces-12139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5AC75818
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 18:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 66A2C2BCA2
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802C1F8723;
	Thu, 20 Nov 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su+qSk7C"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025282E8B76;
	Thu, 20 Nov 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658009; cv=none; b=E0n8IXAOs8bzs/aqj3+fF8szCO2qVtTpBFCxRfVhUHpiZbaNEKB0TnLDOUBLyfKaDpVCwoWRHkPGsImGUCWU6s5rxEjschvj7Z6jHbWRXURsQOlf2yeHEXH/meyJ3yfNTydOfpaRCET+n4tQP3WFs2PbUmnauoAM4iLkqFO7S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658009; c=relaxed/simple;
	bh=p+dOT7FCzBfJ39x7dA4MT17Y0eUFgtm7HoNO/DdOV0c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Sl44FFor8sqgAcOAQ4KoiT7H01ZnI7OrXHmwxon+JEmlKz3nUE2PGPAQZlNdtub6YZkeEbziZZr7TAzwZ7/BKjNx8KqQNZIbBSDs+rau95L4yS2aw3UsDnGLZ/hhOAM9/7hRhhEoyaAg37r4C+R2vDsOamsm9sDT6Ge6TPZjMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su+qSk7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460ECC4CEF1;
	Thu, 20 Nov 2025 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658006;
	bh=p+dOT7FCzBfJ39x7dA4MT17Y0eUFgtm7HoNO/DdOV0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=su+qSk7CX6O1H1n3fvJuJ7T5QGxRXcbduh8mu3221Iv2oEJw6RmJKIp23IyaA4u2/
	 npZ4XEgT+bcxiK/iT8de3fgyRiBBJ6qE4TFLMmWPL35Tz5eQmoDj+apByksSo9vg+O
	 I6/62mdJdngbcFTpg3Eb5muXH99R9v1aOcm+u+gqkf72aJlqYxi/+rxMpIAzmYWX1k
	 qyy+t5ddqGk2n1QR9BgUk3D4KwxuMu4u5wT/QoKmV3Zsy1tJR6SZQfikAr8ClxfynN
	 GcQMlBWNhQMDwtAl0nNXgoqx/iPJC7gROeffqWOfWdeLNX1gr3MpWSXYoUInQB8gYB
	 v04D1vl1DUxhA==
Date: Thu, 20 Nov 2025 07:00:05 -1000
Message-ID: <92d3ce31b104cec08c6b9772320fc2b7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCHv7 0/2] sched/deadline: Walk up cpuset hierarchy to
 decide root domain when hot-unplug
In-Reply-To: <20251119095525.12019-1-piliu@redhat.com>
References: <20251119095525.12019-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

On Wed, Nov 19, 2025 at 05:55:23PM +0800, Pingfan Liu wrote:
> Pingfan Liu (2):
>   cgroup/cpuset: Introduce cpuset_cpus_allowed_locked()
>   sched/deadline: Walk up cpuset hierarchy to decide root domain when
>     hot-unplug

Applied 1-2 to cgroup/for-6.19.

Thanks.

--
tejun

