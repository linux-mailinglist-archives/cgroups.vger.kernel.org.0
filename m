Return-Path: <cgroups+bounces-12141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EBC760D2
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1CB16241FC
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257562EFD90;
	Thu, 20 Nov 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c6qGKiCC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75881F4CB3
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666423; cv=none; b=U5V4W4h9LQGBslLHS5x925NfDHkYZf1TRX+TrpqMtuKEF/cmVSBT/Sdrczy6gwZ6pbUj1euRmzy71c6BHoHWP96Z3JJthrKqu/jaRjXYS74M5a9/WkLdvZg/GvfHNLZ8109kCZxyc4E5x/l5KmHNkbfiv4Fws3qtep6vxzUMbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666423; c=relaxed/simple;
	bh=AaCcqFGlaMkBKinMgcJOTsQZe0To9vv4Dqsh7zVA0tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5bIz4uezp3w0PiGBZ99UakmD2SuC59juDKDnrYmZ39zntiUZMqQDvlSkhAWuGXWgETQhJ3F0QzxDRBQ/Pe4WWPrGd649YkZxssNtoKEdeYo4VA0/yR3/S3aMYw0gBjhwT+cwHSnClYh9QWs65irlHaD7mcKj9ScdFtn/hwz5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c6qGKiCC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so1118102f8f.2
        for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763666420; x=1764271220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1GdkfT+k3vOqAIJe3mmQZm2FSZ3v5dOxrZlq1SxHp5k=;
        b=c6qGKiCCqVGjbVCF3KPrM8v17KfcDRCjANlVnpv3vnsNhSl5fK8MLoVc+YvU9JLjyC
         aHEGZyboEx2KYcfxE/3eQ+82zxQC9pSxwwnIv/j2mITLr+VDioC0kNk92RRHFneto+AO
         KzJ04xEvX1xcsUiHBOZ80r8Cd0K+JwsaIn704XiLROJKjqvLwy/I41nIY6aKuhQeRTcr
         EoWeD8aPvIIpkJYwobikIjMoW/byJ4lPJAtROwlVmhsSoY2naJv4MCAZSLro02igbfbb
         rPPAjrHUpFAwuJhEFhkmC9TCo+7I8Mv4/vwcuyOZepdIVMa3eC0gpj5odgydgsgJB9OL
         pFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666420; x=1764271220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GdkfT+k3vOqAIJe3mmQZm2FSZ3v5dOxrZlq1SxHp5k=;
        b=f0IPmKHqhYvbLTXqySz6GXLneQ+P7TluFPtoP42L+Jp9VpU1dxj7ljnXoo4Y003dZz
         I73ZzfE+tLDYhlfhRscaRyUzk45DJ0cEjdLSkQA0QhPdUKP5XUyfe9kDmLe7KSB4i697
         fYMonNYTyZMrcxhpoJLDHNuY/eZuXbYTxgj1owLFksAxXsQtiihQxFh0ZTXLdllFzafr
         lvwVCB44z0sxkFRlFnrQCFAVCq9m5VlYHhnClz2H3A5U3MlhKw65AVnmd+pSfBUmm4mP
         bFLwkxAXNdWM0fbKUipEXwDrfyN2Zs289rt9EoZqXXcOaVg3y6yrjcw9Zwlme6Z8Rwta
         oZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7eardUHa+gU2a70C93A33aOpuBuu1hzufUqaAvJnvrKmjhohlk6kQNc+5T1sHehGh0zZh7iz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0ezJjkCZY26EPwv6+H4iJD6crfluvJYoCbUyGGoWB94tB3AN
	rTaXvJckf2E6Y1K5UIYxPCBIpirOweOPzLMsUjMr/DNHZqoY3XvvsbTbjtwPt/lFdg0=
X-Gm-Gg: ASbGncvrlKZUl5dSpjrJbsWj0cu/h4AYIozmhfB27wFwEa7f1Typ8W8lG/YlTGgk611
	0ASXTpx4W3aSRZvKuwM2gye5Jnmcja9goCblhmPmLxYqIGuGJuSySZXBol+OfEYRMmLzredY2kg
	DM61KqGua4USKJEumLAXg2BkbiQd3bquFm6ydaPBGkI5JG4hqWX7Z1mUylIzz2m2CZ2z4SPPXpe
	KfatD9fVl9JSUNpCBaAp8hZVkMClcFRhbHkV7yydPZCnezIRbZip1VdNvf3984qcIWEQbtz4x/C
	W+gwbSMdxW8BOsO04e4KcQLiHmynjuUJyuCbKk3fP0ZbnvF3v4dq2OqGk6OynzZtYNAIVezMotb
	8/wJ3tE+OQphgALdQ8EEMIigrcTL5DeNwqMKu1UxEInQAh2VRTUcvKQ3nS2XyFfgQ4ypfXJTwEN
	dQsCHphG5BOKbKQRRHyL+ACSPL
X-Google-Smtp-Source: AGHT+IGAoi9mcb2Ki+Vf2x8GF9MIVNCxw9/ODHm+fzM81xCrrAi2YNRfJaEumj8/F5Vldpj31JhIrw==
X-Received: by 2002:a5d:5f50:0:b0:42b:5628:f4a3 with SMTP id ffacd0b85a97d-42cb9a0d86bmr4652179f8f.1.1763666420131;
        Thu, 20 Nov 2025 11:20:20 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa41d2sm6785593f8f.22.2025.11.20.11.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:20:19 -0800 (PST)
Date: Thu, 20 Nov 2025 20:20:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: hui.zhu@linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
Message-ID: <aR9p8n3VzpNHdPFw@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>

On Thu 20-11-25 09:29:52, hui.zhu@linux.dev wrote:
[...]
> > I generally agree with an idea to use BPF for various memcg-related
> > policies, but I'm not sure how specific callbacks can be used in
> > practice.
> 
> Hi Roman,
> 
> Following are some ideas that can use ebpf memcg:
> 
> Priority‑Based Reclaim and Limits in Multi‑Tenant Environments:
> On a single machine with multiple tenants / namespaces / containers,
> under memory pressure it’s hard to decide “who should be squeezed first”
> with static policies baked into the kernel.
> Assign a BPF profile to each tenant’s memcg:
> Under high global pressure, BPF can decide:
> Which memcgs’ memory.high should be raised (delaying reclaim),
> Which memcgs should be scanned and reclaimed more aggressively.
> 
> Online Profiling / Diagnosing Memory Hotspots:
> A cgroup’s memory keeps growing, but without patching the kernel it’s
> difficult to obtain fine‑grained information.
> Attach BPF to the memcg charge/uncharge path:
> Record large allocations (greater than N KB) with call stacks and
> owning file/module, and send them to user space via a BPF ring buffer.
> Based on sampled data, generate:
> “Top N memory allocation stacks in this container over the last 10 minutes,”
> Reports of which objects / call paths are growing fastest.
> This makes it possible to pinpoint the root cause of host memory
> anomalies without changing application code, which is very useful
> in operations/ops scenarios.
> 
> SLO‑Driven Auto Throttling / Scale‑In/Out Signals:
> Use eBPF to observe memory usage slope, frequent reclaim,
> or near‑OOM behavior within a memcg.
> When it decides “OOM is imminent,” instead of just killing/raising
> limits, it can emit a signal to a control‑plane component.
> For example, send an event to a user‑space agent to trigger
> automatic scaling, QPS adjustment, or throttling.
> 
> Prevent a cgroup from launching a large‑scale fork+malloc attack:
> BPF checks per‑uid or per‑cgroup allocation behavior over the
> last few seconds during memcg charge.

AFAIU, these are just very high level ideas rather than anything you are
trying to target with this patch series, right?

All I can see is that you add a reclaim hook but it is not really clear
to me how feasible it is to actually implement a real memory reclaim
strategy this way.

In prinicipal I am not really opposed but the memory reclaim process is
rather involved process and I would really like to see there is
something real to be done without exporting all the MM code to BPF for
any practical use. Is there any POC out there?
-- 
Michal Hocko
SUSE Labs

