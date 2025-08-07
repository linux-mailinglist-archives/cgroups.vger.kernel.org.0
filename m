Return-Path: <cgroups+bounces-9022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD3B1D8D8
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF58E169C2B
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081C238C26;
	Thu,  7 Aug 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBE5mgoK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244134A0C
	for <cgroups@vger.kernel.org>; Thu,  7 Aug 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572820; cv=none; b=Rj8Mg524Z+mpPq2BBWFsJPJOrT/euWgTu36tDXFZaPaFQ4LORav7Q3wFFXtzAzK4HdzFhDckZlBqOTGsQ4DwdGErpKQPyTOJT1bsS0l068ccOok7bNTBpzsw6ukAxciBtOAJi5YlzavTc1SnsQiVzgF5dhCPmhylvKWE0u3RvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572820; c=relaxed/simple;
	bh=vkgsdxbnV+jO/2KYWJGzI77qW+k8hy9tEjiVY7fTWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6vCHHAil9vU2oVhFi5gwipsKBjzRwH6k45Mvg4D0rTO9P3Pm95zEiNqoI3PXGA3/lek4GEiIVucj6Ozof9aGPAr2maGADaMICGGxCA1pywnpeikKpJKX1qkCwOEcn+TdSKKhdwXNi1OVl4yLZFAFS+fgP43OcuVU27kWDZld8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBE5mgoK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754572817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsCl+fG5s7XEuq47rWMb299hn6Md+wm0F7CH1smdlp4=;
	b=VBE5mgoK1eNRp4IRLF9ZQyV5HmgaCzlmRt23NYjE89ZuC5s8xmF9W4vW2YqIyQnjy9vpRk
	U0MU7zuJr4Q4+0P/HWr2Uq27YGYd7Sm+yC7EPdMPp1DGKcMgQGdeHs58Ei8t7zJIMnmcGc
	8jsCfnLEVm+9LCJekIIMSA3OA3lB/VM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-FpNZ-2JHOY65OkZjAZKm6A-1; Thu, 07 Aug 2025 09:20:16 -0400
X-MC-Unique: FpNZ-2JHOY65OkZjAZKm6A-1
X-Mimecast-MFC-AGG-ID: FpNZ-2JHOY65OkZjAZKm6A_1754572815
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-af9423cfdb9so87309366b.1
        for <cgroups@vger.kernel.org>; Thu, 07 Aug 2025 06:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572815; x=1755177615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsCl+fG5s7XEuq47rWMb299hn6Md+wm0F7CH1smdlp4=;
        b=uNAl3UEukdkkmQHbTaBJWRY/OMQOObqG/yG9O/Sh33n1dzIGnCLY53xW+WVaGiTbmO
         oVelnjbOZzngH6xx2NH63mjIro1nE9+j+Zla44rQnYT6MtXfjawLhmQiueoIk/jR1uhr
         5bN80SC7aoexsFM+SsKmsMKI+Mh4Pzw+bcv+XvkSXPbVjkXAkvVWCTHtvK74CiCffn/p
         Vf5gfm8H0vmXD1S9pXfFUrIAZ7ObIxvVct2gPPcBQzehK3xkqrSkTr9BTi8Dtu1l0zFr
         ++sCKiABeYEOH8kCJQrKy1JVI3fHdZhAgoL5MhP2tusjjI2Tiv6xXPoR1z57cNNRuEsN
         sqPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzSfVLVoAVxYOJXpSwZOQmsZqGtD4Zgpc5/s1GuPPab6CxrJ3Rw/qv39gM6KdmKe+9kKWGNY1w@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVKorfQFRr8f+kWDWLzjzutd+UFxY3c/tXYQS4wphdzfGH/n5
	Hovi4HjYOfXYIRXomG2k2KCZJkVJXVoJ3R5J22AdUZ/WzAP5hW040usGpSCX0SRDDxfMp5F9dR1
	NruO1Yiice7U0V6HQhJtiJen1UG0LjflAjz9WvzZm/R4r8oSdz5/KfBRu8xU=
X-Gm-Gg: ASbGncuOpycamJF3j47+oKZ8KJEaSbbQKW+FEJvA1+DmuvCpZB0rZcLRo19bm1zOezq
	NAav8npkOGRK/X+aAK/9qEZo0/U7f6GupmT7NTv/T18peLr63TgPko8neurujR9Vi78C5HImaBo
	RKUFzSgwoswva/Wpa1vmVXxCxHBsHcNN9fJzwMoaQMZS5/ot5hSlvhGOuxEGP6Bc66tVXMXHuSi
	xMWJywCcgR/8TqXTggMlL5BVJttsNCD1rdG1rI4r87TCn7kOYkLowCuHdGaYix1SWHYcp+D3kQk
	GWWRRYKwcL4EMNZdHBuvM9ywoQ3/gcl19TVai9jKMS/W3pqdvxh4kK+TWGbZFO62CQRMUMR+qpo
	4eVUtMUMjHwEijbFmChN4R80=
X-Received: by 2002:a05:600c:35d4:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-459e7440902mr54692055e9.6.1754572508999;
        Thu, 07 Aug 2025 06:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES0zbDgiFtIMLurP4jaGdX+lg+7QeTWhWmoc1YE1i42QiR0yB42DLVlO7szOf+gfWylt/oDQ==
X-Received: by 2002:a05:600c:35d4:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-459e7440902mr54691615e9.6.1754572508454;
        Thu, 07 Aug 2025 06:15:08 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-151.as13285.net. [2.102.14.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de91ea4csm147149985e9.10.2025.08.07.06.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:15:07 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:15:06 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cgroup/cpuset: Use static_branch_enable_cpuslocked()
 on cpusets_insane_config_key
Message-ID: <aJSm2sG1G_mk_1P-@jlelli-thinkpadt14gen4.remote.csb>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806172430.1155133-2-longman@redhat.com>

Hi,

On 06/08/25 13:24, Waiman Long wrote:
> The following lockdep splat was observed.
> 
> [  812.359086] ============================================
> [  812.359089] WARNING: possible recursive locking detected
> [  812.359097] --------------------------------------------
> [  812.359100] runtest.sh/30042 is trying to acquire lock:
> [  812.359105] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xe/0x20
> [  812.359131]
> [  812.359131] but task is already holding lock:
> [  812.359134] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_write_resmask+0x98/0xa70
>      :
> [  812.359267] Call Trace:
> [  812.359272]  <TASK>
> [  812.359367]  cpus_read_lock+0x3c/0xe0
> [  812.359382]  static_key_enable+0xe/0x20
> [  812.359389]  check_insane_mems_config.part.0+0x11/0x30
> [  812.359398]  cpuset_write_resmask+0x9f2/0xa70
> [  812.359411]  cgroup_file_write+0x1c7/0x660
> [  812.359467]  kernfs_fop_write_iter+0x358/0x530
> [  812.359479]  vfs_write+0xabe/0x1250
> [  812.359529]  ksys_write+0xf9/0x1d0
> [  812.359558]  do_syscall_64+0x5f/0xe0
> 
> Since commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem
> and hotplug lock order"), the ordering of cpu hotplug lock
> and cpuset_mutex had been reversed. That patch correctly
> used the cpuslocked version of the static branch API to enable
> cpusets_pre_enable_key and cpusets_enabled_key, but it didn't do the
> same for cpusets_insane_config_key.
> 
> The cpusets_insane_config_key can be enabled in the
> check_insane_mems_config() which is called from update_nodemask()
> or cpuset_hotplug_update_tasks() with both cpu hotplug lock and
> cpuset_mutex held. Deadlock can happen with a pending hotplug event that
> tries to acquire the cpu hotplug write lock which will block further
> cpus_read_lock() attempt from check_insane_mems_config(). Fix that by
> switching to use static_branch_enable_cpuslocked().
> 
> Fixes: d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock order")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Looks good to me. Thanks for spotting and fixing this.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


