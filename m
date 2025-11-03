Return-Path: <cgroups+bounces-11546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00772C2E358
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 23:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3743BCDF5
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC92BF3DB;
	Mon,  3 Nov 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMqyr6CK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090535979;
	Mon,  3 Nov 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207492; cv=none; b=NwmtWyIeExGmCHOxcJmC20JWD/qaFSO4+vafEijIiZPvXwDWnlvwFQhXhx4DzeuGlCW4TwrTTtcHlYa06X0KGo2dtAmRo/3cUulIGv5o0DSptSIUdtCDyePclh5d2G3brRzE2ua90uYQgCyS/YG2N95zbtQqX11GNsui1+PhJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207492; c=relaxed/simple;
	bh=q1KnAwOqhZ12LbhelGvpWpLtVrGFm8BctW+uZmoSZMw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rD6zp22/fbVwQA8ydan/AVZ7CGglhRO45eU0jw4vGOvm+x/58SeVESANtfMkIBLmKDcdMpSCAjPkLMg2HbZx7nOMsHm3Ti/p7nUwnCR7F+yabsi2ODdw1LhXYFTAIFx4u1yYhWFu6StCdC5q3SjSpXADY9CVDfykUm004y1kjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMqyr6CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B5C4CEE7;
	Mon,  3 Nov 2025 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207491;
	bh=q1KnAwOqhZ12LbhelGvpWpLtVrGFm8BctW+uZmoSZMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NMqyr6CKBc68xyKXaO3dz5y7pmejbIt7B0Ywu0OVyGnkTQBcwAkcSikgGfudh10WW
	 qiftr/JzXDHIZkRSUGPyk28xVXKKJFOUJ2LsgljActe+rFr+Glr73l56bn4rJ+AHkY
	 OAloBrZoFf0m12UoI+WhVxRJGsyMaeDAmNm6BhlUb43jvPLsj62D+Itxfab9lqU7V7
	 Yw+uLKxDgi+I1VB2r/APa6O3qFnneVkBRJeCtZckK+320eR7PjFUfUa/O4H6kqmJhQ
	 sTJMEqS+g7KRw7SZBxCr1iAQIAYhYnwUCiskVtjDF1vgUn6b6psvxEnFVn3a1Hlebf
	 Axnhd5mjyigSw==
Date: Mon, 03 Nov 2025 12:04:50 -1000
Message-ID: <be1d60422cf5b4a7d707e97c879cc533@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 0/4] cgroup: Fix task exit ordering
In-Reply-To: <20251029061918.4179554-1-tj@kernel.org>
References: <20251029061918.4179554-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

> Tejun Heo (4):
>   cgroup: Rename cgroup_{exit|release|free}() to cgroup_task_{exit|release|free}()
>   cgroup: Move dying_tasks cleanup from cgroup_task_release() to cgroup_task_free()
>   cgroup: Defer task unlinking from cgroup during exit to finish_task_switch()
>   sched_ext: Rename sched_ext_free() to sched_ext_dead() and move earlier in finish_task_switch()

Applied 1-3 to cgroup/for-6.19 and 4 to sched_ext/for-6.19.

Thanks.
--
tejun

