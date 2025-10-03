Return-Path: <cgroups+bounces-10532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058BBB732F
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 16:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7533C2EE1
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AD521ABB9;
	Fri,  3 Oct 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn8sDZE+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730C1E2834;
	Fri,  3 Oct 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502234; cv=none; b=RwHBSc9qeLzYkajaDmJmG9uoGEQ7TJ3C/PRK9K1VVcJxI7S2qkVZXcQnjz3a0vbXMmj6C25HaWebTc0QzwXPl+Bs5Gf6mOaVFwUn2cu86VZooslZ6+X0G4UWgcHoOS3Pzxw/zFBhgRHUljt53hQhCGPF/g6NqsaV0PUESo2lepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502234; c=relaxed/simple;
	bh=A8BE/uZ4bRaKp1mPV9yFBcD9cYck3xUZ4rs0/g7nu58=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qDjmq8bX+x/Dx2gha7mOP2Il1/n5S/noupShNPSDrbgcJIrMCptmojCYi2EXrQXO9rOzuFp/Q599mpnmf64nrw9JCFpyL9H3mXxB5v8Yz/RsMQzMIS56EuS2I2fXZ8Mb5eYGf4gPEpKmIryKHX7Z+9f5th9PQN2ZV5xXfc7W6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn8sDZE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B33C4CEF5;
	Fri,  3 Oct 2025 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759502232;
	bh=A8BE/uZ4bRaKp1mPV9yFBcD9cYck3xUZ4rs0/g7nu58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gn8sDZE+GryUQdOH+GQI41Fhen0WhGw/zKHf+BheQHh4CtLEb0rk5OrITqhxP3oxS
	 Xw7qZDz1O9OEkEC2SyfzpRgg5aYlCzopIiRukuBIJrIzcvtUZn6xqQ6XbByUrrP+M4
	 08aYbosghWe6EQKOjBV5HScCPues74BpqDTVCFtQnwJOM/GjfQD8PEDH2TsFt3tTiz
	 V2P7laVfO7RuLsP1nZiDas3CVa4bY56eXRCKVOckHVIAi6rPEGS7seG4CEbHsqlb5v
	 XWZDX5h8TdNeZ/ZO7Na6NV9ha75BrCs3BGKDyBrmsxsOjCCqP3YlKZDVQcyiC4c4HA
	 ERvB1D7opA+AA==
Date: Fri, 03 Oct 2025 04:37:11 -1000
Message-ID: <0cc44bb7e9ea51e6d031356218bd3c85@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.18-fixes.

Thanks.

--
tejun

