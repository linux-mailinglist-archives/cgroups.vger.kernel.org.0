Return-Path: <cgroups+bounces-8121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8859AB20C2
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 03:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E2E1C27F20
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE98263F5F;
	Sat, 10 May 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ErIWNpYq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88952E401;
	Sat, 10 May 2025 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746840394; cv=none; b=hG+uJarDEfwyiHOPlGJx4FuqwGk+o92rXGPi6bQ8QWMZJamgIGwctglx70MVaXn5oYvZdMOWdMJQxodd+D5O5OJYelTeZdWVruonPRKMoIbIF7c4aaLroFSSdNHfrlJ83bsTZ8HS6It7eOjKYgg7nW6G2+werqOyAv5/XG3xImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746840394; c=relaxed/simple;
	bh=G3646iFM/PSXY7R167/rsBSW0S3KtjrzdAQFJQP3ynA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bx+Ib3bkaB0mfxrhdVM6cV3es4kBQHfxugLFzrWIkVaVTJ4gcUnao7o0mlhC+C45lKZ1HYaIrQ/bjWkydlBqoTjlVmeG5vc6PgQ546xKmWAx5mU3+5evF3m9fiNUa4qv0mdyLGJS6AB1q5oXjRnpLqirwshrNXzHIXe3obcqG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ErIWNpYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94B0C4CEE4;
	Sat, 10 May 2025 01:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746840393;
	bh=G3646iFM/PSXY7R167/rsBSW0S3KtjrzdAQFJQP3ynA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ErIWNpYqkcqsxM+6XhEBHioSO4BSy2GdXycbHxGuYxRyI7TcDv8EWg5IQv8p19V3E
	 c1Kk2rSN8N1i/rpbwyR5GGWgU3uk+0XvBxzB6xijkNQbiHU1wYI9L7RcUU/8zVLAL3
	 BEw2KTmp6++ckQxBYqyL5BDwKh8P7/YhkNNz5m/Q=
Date: Fri, 9 May 2025 18:26:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, Alexei
 Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, bpf@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-Id: <20250509182632.8ab2ba932ca5e0f867d21fc2@linux-foundation.org>
In-Reply-To: <20250509232859.657525-1-shakeel.butt@linux.dev>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:28:55 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> BPF programs can trigger memcg charged kernel allocations in nmi
> context. However memcg charging infra for kernel memory is not equipped
> to handle nmi context. This series adds support for kernel memory
> charging for nmi context.

The patchset adds quite a bit of material to core MM on behalf of a
single caller.  So can we please take a close look at why BPF is doing
this?

What would be involved in changing BPF to avoid doing this, or of
changing BPF to handle things locally?  What would be the end-user
impact of such an alteration?  IOW, what is the value to our users of
the present BPF behavior?



