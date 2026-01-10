Return-Path: <cgroups+bounces-13030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A44D0DF46
	for <lists+cgroups@lfdr.de>; Sun, 11 Jan 2026 00:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E8B3006441
	for <lists+cgroups@lfdr.de>; Sat, 10 Jan 2026 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105DC28C2DD;
	Sat, 10 Jan 2026 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H6KSlHuT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F025A659;
	Sat, 10 Jan 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088023; cv=none; b=H1d2OEXx3CRPTuyolpHIJVVFMFXhOl5Ltfx7ATYYhaJ1Xhi+zXc1Qdmgyd7u2fapl6WDafnRb4mFpWpX9kKuIGv0UUENNwA4MslUqnimBY6nYgaSh2fNqZ/lRqVxbU5zCsC+AhfmM7ttVaPhjc/VAWRsF1ZyKrweoWMj5XS2PIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088023; c=relaxed/simple;
	bh=e2sYFvxqf2oXVRxryUmtDGwxS+F7IW+fdW8ehSlHuC8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZES3SDE0Qj42jfWwWmXaKR6qEM0GqT5LvF2vCVxGUvuucZ+jqI/jhn2BfMythbwU3gE02qX7nyIu60scVfWBasiQwGMaGvrslFoacxypKiAsaICi6iHNkgAghlv+BJ1P1ysIlR6bf79TtYYh4aNieOddqMeN3UgF2Ipvdwd9kVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H6KSlHuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A32C4CEF1;
	Sat, 10 Jan 2026 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768088023;
	bh=e2sYFvxqf2oXVRxryUmtDGwxS+F7IW+fdW8ehSlHuC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H6KSlHuTQuj+XO6tT+K97n6UdIUpCQNL5xOzjBZtL/XVGYgcnn3SdwVNcMe3K39SB
	 zfzmPAHYElbee7Hjx5MuvVlhj3dQQhL4cH/DaohiwWVQSfonVbQ8mHmdS5ALMMRAht
	 +zPpclEJOZVKbM0sXj1MaKDj5sIYq4gUFYM/MwsQ=
Date: Sat, 10 Jan 2026 15:33:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: optimize stat output for 11% sys time reduce
Message-Id: <20260110153342.7e689e794ce43a0a39c699fc@linux-foundation.org>
In-Reply-To: <20260110042249.31960-1-jianyuew@nvidia.com>
References: <CAJxJ_jioPFeTL3og-5qO+Xu4UE7ohcGUSQuodNSfYuX32Xj=EQ@mail.gmail.com>
	<20260110042249.31960-1-jianyuew@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 12:22:49 +0800 Jianyue Wu <wujianyue000@gmail.com> wrote:

> Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
> printf parsing in memcg stats output.
> 
> Key changes:
> - Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
> - Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatting
> - Update __memory_events_show(), swap_events_show(),
>   memory_stat_format(), memory_numa_stat_show(), and related helpers
> - Introduce local variables to improve readability and reduce line length
> 
> Performance:
> - 1M reads of memory.stat+memory.numa_stat
> - Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
> - After:  real 0m9.051s, user 0m4.775s, sys 0m4.275s (~11.4% sys drop)
> 
> Tests:
> - Script:
>   for ((i=1; i<=1000000; i++)); do
>       : > /dev/null < /sys/fs/cgroup/memory.stat
>       : > /dev/null < /sys/fs/cgroup/memory.numa_stat
>   done

I don't understand - your previous email led me to believe that the new
BPF interface can be used to address this issue?

