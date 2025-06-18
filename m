Return-Path: <cgroups+bounces-8594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF8ADF7A0
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 22:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1517A6C31
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C121C161;
	Wed, 18 Jun 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3W3lLuo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEC21C160;
	Wed, 18 Jun 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278202; cv=none; b=isYcaeeIv9jTETfjv8RJwm+93xEW7J2avr0PkiYmEEk4vqepWKlAwCcRQA2bNIyGyMzCIMx0aZlRVX1fFLRnjcL15DTY6cYhSJjnXU35b692+De9xdv0Ua7AEzeZMywFGKVesGe/1HOCUL9pebcD9O62izarEDudO3aKOwjh2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278202; c=relaxed/simple;
	bh=9LXHkad+LqC2nKuCTpHhFK6nxC1mXE8NaMhxd4t5IJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kmiN4uKawm/Sv5Pgy/TBxbUy0eVKlq1OId1U2jhdspeVsji1YKbmgorgYbZfZszLCWzwDImy1UBgigiBNr8lQXa5TkbL94q5MbzTtjX5XgREamJOTfm3av1BvAl+miS2iXKxaeUI/u+fdj4cO2eBmHYQJyE5hF7JhS8z3tMAvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3W3lLuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67485C4CEE7;
	Wed, 18 Jun 2025 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750278202;
	bh=9LXHkad+LqC2nKuCTpHhFK6nxC1mXE8NaMhxd4t5IJI=;
	h=Date:From:To:Cc:Subject:From;
	b=j3W3lLuow6phQ0EfBvdkcaUDbSzX+/HCcGUxxZmWJ8bMPFcqKVeV/ZgyAfdg4svkH
	 pw4w2lPyPditvbL1UUghZHdCjLAxKj+NAtvZzf3MciKqFAC6VgAHbBDQaHK2uAgfg4
	 pCMPz2q0PMQup1ft99HxwZgVIwg4SlSMrSW7EMZgIrkoN9A4dCIBu23FAguMZuqvv1
	 IEk73IKkbGGqT8ejp88Lg4igv17RIM6/Goe8DTnK/RmEBtCB9ZMCHhoMiEjddH1eFq
	 7N49WctBbarePhS9GTDoVr8uK7MVdvFP0+b+kYy3hk0CIo/+HgminEnakjWAifw0S8
	 svhqbV5rPV85A==
Date: Wed, 18 Jun 2025 10:23:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: A fix for v6.16-rc2
Message-ID: <aFMgOa1knyr5LM83@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c853d18706de8c9525126b362f747d2e480e93df:

  cgroup: adjust criteria for rstat subsystem cpu lock access (2025-05-30 14:36:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc2-fixes

for you to fetch changes up to 37fb58a7273726e59f9429c89ade5116083a213d:

  cgroup,freezer: fix incomplete freezing when attaching tasks (2025-06-18 09:43:30 -1000)

----------------------------------------------------------------
cgroup: A fix for v6.16-rc2

In cgroup1 freezer, a task migrating into a frozen cgroup might not get
frozen immediately due to the wrong operation order. Fix it.

----------------------------------------------------------------
Chen Ridong (1):
      cgroup,freezer: fix incomplete freezing when attaching tasks

 kernel/cgroup/legacy_freezer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--
tejun

