Return-Path: <cgroups+bounces-6200-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7CA14099
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B70167807
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CF155C87;
	Thu, 16 Jan 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdH8k/iS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C88C1917F1;
	Thu, 16 Jan 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047954; cv=none; b=DCUEeAB9Iu6tLPyV+hTueB7lOey2FzOBjhwUb9x6K6sSqybzlAFYfJmcUg8nlgKBtZMpkI4aJ4GYlJ1Ysa3pvUEAwFXxFanaMtBRiK0qPy3WhZYmPWfbkt4uZZ1M7Di984dmuXXK3y0whdrFj5+Ofp+mkyD6wjQMBf7w6nioQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047954; c=relaxed/simple;
	bh=jGZuy2kbmivebjwJnFSPSo24/KdX3O1Dp9Y34gYRAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFavbbdPKDcl+Xx0B+ibbebINND/FbSURI2be6jRZ/im11JgjvU3cotea4M/K7jAO67vrYtop9hkUPE01Y+x/iq13IteqEcMqc+QE6weKCVmLCzWDW1YqHwbOctzHVrrJLMEneUP1qYk3vQ3GwJ/FxNa3Y36AFict5AhlFrizyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdH8k/iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5515C4CEE2;
	Thu, 16 Jan 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047953;
	bh=jGZuy2kbmivebjwJnFSPSo24/KdX3O1Dp9Y34gYRAok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdH8k/iSdBrBaTXYw6qCSFZ+ZU9Z5qJ2086VbubtG9GmokadQPUt3pEqqMGNZMoRm
	 kLPKAD/GJaBiQSfIj/HRI+BwnbkML2GCAkFDCW9ZDSYRpglpchqpKQWwbHfjDDyz2E
	 18ie5OBpAIPq+OkqPD2Hc+vr6cz08Ojhoat0RFs2OAxd8KNxsCIxaYZkFezuVF3T53
	 Pxs1mKNnpP+btrO3JdOSPjAEpbQKmjo1/m47h92XuIRoohcJWs6IrhT+RurMtEIznW
	 pR3e4oTgTZtVH0Gzb/6VXC9YqeaFaqzFvvMlGbsm82idcyF07kfz3pdef7GHVcXTcb
	 L3TErUB+71THQ==
Date: Thu, 16 Jan 2025 07:19:12 -1000
From: Tejun Heo <tj@kernel.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
Message-ID: <Z4k_kLW_a_D50v1I@slm.duckdns.org>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <20250113010530.432396-1-lizhijian@fujitsu.com>
 <871px6bo3v.fsf@trenco.lwn.net>
 <4e96a241-a996-4289-9ac5-dc1ff65cbff8@fujitsu.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e96a241-a996-4289-9ac5-dc1ff65cbff8@fujitsu.com>

Hello,

On Thu, Jan 16, 2025 at 05:50:54AM +0000, Zhijian Li (Fujitsu) wrote:
...
> Let me quote a piece of the numa.stat:
> 
> In pages:
> >          pgdemote_khugepaged                                                   
> >                Number of pages demoted by khugepaged.

If this is the only entry in pages, I'm not sure the proposed document
update is the best one. The above can have an easy alternative description
"the number of times khugepaged demoted a huge page" - ie. indicate that it
is an event counter instead, which is a plausible and likely more intuitive
definition anyway given that a "huge page" can plausibly be of different
sizes. With the key name and matching description, I'm not sure it's
violating the rule that all *sizes* are expressed in bytes.

Thanks.

-- 
tejun

