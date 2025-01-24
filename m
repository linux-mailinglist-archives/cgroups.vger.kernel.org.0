Return-Path: <cgroups+bounces-6282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273AA1BDE9
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 22:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478D7188ECA9
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DF81DD520;
	Fri, 24 Jan 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L09HrAf6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9612EBDB;
	Fri, 24 Jan 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754389; cv=none; b=ETABav9NCpNKiySHHu+0yPakxwT8D/fP8RkWLDbWG1MWK7+BFn9djZxOfg6jgl6OU03ImBaXyckg5LsxjQlJTVYsfkQ/7zgcwVUD33LNaUwKpuFNMYrkTFGWt4E00qjoWtazHC4FuA4kYLbruXDKDL682CrB6nI5BgeMfDULzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754389; c=relaxed/simple;
	bh=qtxtVv/eUmvjo6zXjbbWpetjcbEvPkRFG9m/YzrMg9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kaWcYek7rhJ7q8Ga8xFYVj8/kuCJd0g5bI56YYpJqLSPwvV3+7UcJ9PsFyIsZD3kFs58cARdeBcNIRNx+mPS64bTOw9iDs82DjsjZVIOR3108peLUMUZtxPrWKMj0IZwDOVMlyRtBsarHXOoluEP72okvOQCiOlNQoXIEHk/OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L09HrAf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ECFC4CED2;
	Fri, 24 Jan 2025 21:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737754388;
	bh=qtxtVv/eUmvjo6zXjbbWpetjcbEvPkRFG9m/YzrMg9k=;
	h=Date:From:To:Cc:Subject:From;
	b=L09HrAf6F+LECxSNsZ0vryTm7KnCwTWDALASzjqhGXE486bToxFZYnMoBXTq9A8bs
	 vqV3kzE/4OnI7nFVl4uJiybvYvd7WTJyWwPJF5fr7CEGiR4/5+TDNbxXX7D4kP3E5w
	 KvxBQmOJla2Qbei5ay4j6p252gmXmMaHx+nqLiseYpZ+Rw6OnvOILoA8Pt6z9AOzzz
	 fWaTtG719CXsDZu+5V88/YatdDzfflLED3scXbXJ/lKd4bn6gHWehbFRYpSzlfedDM
	 MR3AgNb4OFZ4uEzCrWxHN2TI5HTpuxXfrfYVWKZpJIEev5Ye7TrnExLZDszVJccUaV
	 j9lPPwB5KLKdg==
Date: Fri, 24 Jan 2025 11:33:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Maybe a race window in cgroup.kill?
Message-ID: <Z5QHE2Qn-QZ6M-KW@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Christian.

I was looking at cgroup.kill implementation and wondering whether there
could be a race window. So, __cgroup_kill() does the following:

 k1. Set CGRP_KILL.
 k2. Iterate tasks and deliver SIGKILL.
 k3. Clear CGRP_KILL.

The copy_process() does the following:

 c1. Copy a bunch of stuff.
 c2. Grab siglock.
 c3. Check fatal_signal_pending().
 c4. Commit to forking.
 c5. Release siglock.
 c6. Call cgroup_post_fork() which puts the task on the css_set and tests
     CGRP_KILL.

The intention seems to be that either a forking task gets SIGKILL and
terminates on c3 or it sees CGRP_KILL on c6 and kills the child. However, I
don't see what guarantees that k3 can't happen before c6. ie. After a
forking task passes c5, k2 can take place and then before the forking task
reaches c6, k3 can happen. Then, nobody would send SIGKILL to the child.
What am I missing?

Thanks.

-- 
tejun

