Return-Path: <cgroups+bounces-6072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC5A06570
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2727A3B60
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803581F708D;
	Wed,  8 Jan 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsnvMvW1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375741AB525;
	Wed,  8 Jan 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364938; cv=none; b=N6oiNk/yECmUlGtiBQ7XBO7134FfkN5AWnKdp7sJDW+3581CozZTezRDGEnJ7VihA5PBs/nph7b1hp94lPZmFBN9QvpouuHhiuwt5ScLe+Ek6DhLxmFB9QcUs7WMEz8hPuFHwMo0wU99cGfUHfudT5prC08zLcuE8Y50f7F1nLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364938; c=relaxed/simple;
	bh=A08GXzWT/LVLntPzBeosMrT4rVcETKQ4Qpd1BAubH7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1/DbQg0m4CVP3v6VdrzQg0gGfVCVSNIGsraJE2VTejN0vd5G8f1bZb74IOPH3F1VuEkZMVu632Eb+d5RT95amTmvExCjM8GAXnXwjlpsVYXy6yvqqm/kkDPf+K6v65COeom4dp/iJYaswql/+VwCYnVlAJnFupVfueMKQ/OPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsnvMvW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7EDC4CEDF;
	Wed,  8 Jan 2025 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364937;
	bh=A08GXzWT/LVLntPzBeosMrT4rVcETKQ4Qpd1BAubH7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsnvMvW1P/GC4iW4532KwZVn+EZXL1zM++mEgzOIDJiqJbHTPBPDSUx4BYHKCTVVZ
	 LJVH+dw0ShPnrKMDLEGx9I/aqeCykTkaLYgPPTbM9ZcRnPusbpIO97mAB9LP6pOFRm
	 QeGexy1xKCPG1AMguCvZm42EP34AidW3xzqlC5yDLvaedlkhOeW/Ulw3GsJyReKLrS
	 1JXbYjdgm42pvjeE99jbXhgaRguCGrBPlaiMGqpvgRyCkH/jIhcsziINwBa857SFeM
	 tvofM2MB8nO9HQhCpmhgVVGXr3sEWrCHS0R8r0xx/q6jBFBxFceHYANog2hwNmImFR
	 EVUjSJy3efPJg==
Date: Wed, 8 Jan 2025 09:35:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
Message-ID: <Z37TiId4rFkwc0Mc@slm.duckdns.org>
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z36th2ni0q32gsUE@slm.duckdns.org>
 <c40d5b49-1955-42ee-b95c-37ed580e9933@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40d5b49-1955-42ee-b95c-37ed580e9933@redhat.com>

Hello,

On Wed, Jan 08, 2025 at 02:27:07PM -0500, Waiman Long wrote:
> On 1/8/25 11:53 AM, Tejun Heo wrote:
> This patch looks good me. However, this does raise a question that I
> overlook when I made hotplug operation synchronous while task transfer, if
> needed, remained asynchronous. There is a very slight chance where we keep
> removing tasks added after execution capability is restored. As cgroup v1 is
> in the process of being deprecated, do you think we still need to do
> something to address this issue?

I *think* that should be fine. In cgroup1, the kernel is making irreversible
system config changes when a cgroup loses all its CPUs. I have a hard time
imagining use cases that would depend on the the exact ordering of
operations at that point. The auto transfer-out was always the last ditch
measure to not leave the system in a broken state after all. If someone's
depending on the transfer out being strictly ordered w.r.t. the cgroup
losing all CPUs and then gaining some, let's hear why the hell that ordering
matters first.

Thanks.

-- 
tejun

