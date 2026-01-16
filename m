Return-Path: <cgroups+bounces-13269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A854D2DABF
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2687130185E3
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EEB2DC359;
	Fri, 16 Jan 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MntOxpQo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973FB67E;
	Fri, 16 Jan 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550735; cv=none; b=Xn6iWr+02DEgSKQYItNlLdj2SVTebOUUJKUQPtpog8J2en/HLrHjAOF5Z5FCeePl8J47hcj366WmcDqDDIGBLnBfrq5pJE/rg/zz0epYSJ9cvYsTXBaU+0VXCQsot+9kBZ/uju4yLG3XV8aTkrK7EDj01G+6P3nXv+JW0Jxydy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550735; c=relaxed/simple;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ZWb4zuiet+w3rSay2FhOaBuwMOfBZwBcUw4y+NuH4IDCEhRKsSwNSF4NiFCiBJtVPM+yVDMX+ari/RZEbLetrQl6bnHCiMIGmreI5TdcahTquVAOYk4zjKPtxURu8wNAsrxK+pvKgdzmeeQBlSl+GSPA5XsG4b4TXudk5GFMufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MntOxpQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC30C116C6;
	Fri, 16 Jan 2026 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550734;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MntOxpQoAmCpvJHoSDPXvG3UwWG2vl2bLt50Xzjvyx0sGb/YLbeTW3XSh3MBt3tNu
	 TLTIXy4zz9hnWc2+Dh1VRX2c6+6MEqpIEdicXSsoiKG5all1rV198BJJgWdVxifPB9
	 gZDHBS91biAPsb+Klkm1h9XYa/uc88H+jo1OBJCVwC8k9L06PB3OMtC/A12UFkhytw
	 Tbjegf2REL9xmEAA3LJAleqoPbjMM9/ClosVtTCAW6OuEqew0Hsdw74/YZJh2NCSt+
	 +vJaE48EqGRZl60LUijSCcti5TLlhU5TDWzO6C43v3SP19kE0m4StDHxkC/zqBvc6p
	 hffgqnmf2dKEA==
Date: Thu, 15 Jan 2026 22:05:33 -1000
Message-ID: <a90b3a30d3a41c42c4553d21bb14f202@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tim Bird <tim.bird@sony.com>
Cc: menage@google.com,
 simon.derr@bull.net,
 pj@sgi.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 linux-spdx@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: cgroup: Add SPDX-License-Identifier lines
In-Reply-To: <20260114203027.584517-1-tim.bird@sony.com>
References: <20260114203027.584517-1-tim.bird@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19-fixes.

Thanks.

--
tejun

