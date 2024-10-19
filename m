Return-Path: <cgroups+bounces-5167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEF9A4A64
	for <lists+cgroups@lfdr.de>; Sat, 19 Oct 2024 02:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E641F23E2F
	for <lists+cgroups@lfdr.de>; Sat, 19 Oct 2024 00:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5784863C;
	Sat, 19 Oct 2024 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7RTEpQV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEF36C;
	Sat, 19 Oct 2024 00:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729296474; cv=none; b=kJJRpVyk6rYfn2q8cIkNdqk1/R7eLG2kXeLdmUlXjs7yL8V1AtqIS+IhJjuayTlQSdsfqFHo0Mkj148hYIUO1w57/8t4167GrBjXHIfIJ5SuN77RzabDAiKYMZ1zhwTQvWY7/hKcsGuMwb22SZMOhzkD91b0ERLY88lESm4JXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729296474; c=relaxed/simple;
	bh=rxGO8n71gE4NXm8RNHonZK04dP5KDs9L8y93AC1yhGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMk7ZVZ0xXp2FTbAymXYmGna8hyZG3eTteqj87Maim5jO2gNho6k3HxGshPye6Lr9b6k7Ojrfk47c2+f2wLIf4Jjh/FfGdgiwYajjnput+LxzDbRTfuJ+yXngKkDaAJf0m/3HjrOpZnYZcqR+mMEl0z25ID0htBcsopnOrjhYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7RTEpQV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so2198367a91.0;
        Fri, 18 Oct 2024 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729296471; x=1729901271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOq9JGXcaDocJuZ1KtOthpD7efSsXOMiKeeRezgLqXg=;
        b=X7RTEpQVsSQHYYnD73H5rz9m90K8qvuek8jnY63hL1AakDJ3d+YkdpfchZWK4cV+Nf
         90Hj/U1Hwz/68ErooAUBz2wKpvUEy7gIjypzTKFgO5/BAU3QupJhOHYis4Kb2xMwn1Ao
         iz8akEI5SLKKHGRrlDxdVkiGE7WHvxwdjWPPBwm7la1IYd/HIRb2IPVPbSjqCn+CmL3X
         S76w7W6KQ5l+EJFKHUgxUGMqAZ6Q4AFE90iNJ8hkwYjLk0fIhpmfmuFp8+3RlJrsLpqc
         CMwlmeDO3Wc2pmyh6fqb2AHRmzU6SIkQULTefyonjPPQrFE/anM75LqRT9pM0jDp0C12
         bzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729296471; x=1729901271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOq9JGXcaDocJuZ1KtOthpD7efSsXOMiKeeRezgLqXg=;
        b=kxBgXuql7A+yz0uep4X9jXKHnuw/6eb9ucLTbjU7s1ttpdF1KacYwHnH4fxR26iUgX
         maZDeU1uH7DNX+CBqTRSwtZulzj+5k4wxb6Ud75rwGDwonL1O7pWvqDayRYqerxg9UNz
         lGcMgsq41WrqthSe6PfeKq7T7wNyVAPRK8Pkt4H3gVZjGlxuhLrdYgv+259emhXj2mQp
         fYGKskwJg0UP75BTvLbhiIS6/kuYszKyQBXJO2MV9YD07PdEZpydkEaCz4kjgk51n01i
         lli3DYfzCbeQ6zKXtKb/rlDPhRGHjUsgJWRSlqknGh5YxfsDcX5DIRYuN0cTDSfqCopf
         BCQA==
X-Forwarded-Encrypted: i=1; AJvYcCVWadel0rXr1dHGtCV+GY1eHMIQolOBYdix5IJ5Kl3e5mSYzG+CkZHMO8VtL3NCMMvXq7YT9CCUwNObIaWw@vger.kernel.org, AJvYcCXcY3OJu4EQ3P4cwlSoZy1FNyCB1BZ8d8oLrpFzMwmt4s7TyQihXcYjhobW4fE2FXAa3QQY1lzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxORcKMj4eNy6B72Jgoqds9GATeugPoMAQ6XXrxkW0FoQD5/lQo
	d1c1J/qyXZ+SapM4OogNZ/BBDRMqIT1oMrX6BkkG2zwuJRwgBlT1
X-Google-Smtp-Source: AGHT+IHXfvtGsTkBVNqQTw8XkMljnZJrpvcCLyH8qh23i3WeZEMZa4iLgKYt+lnbk69r0Ki7267nrQ==
X-Received: by 2002:a17:90b:180a:b0:2e2:b204:90c8 with SMTP id 98e67ed59e1d1-2e561a11042mr4910116a91.34.1729296471335;
        Fri, 18 Oct 2024 17:07:51 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e561202a68sm2655529a91.31.2024.10.18.17.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 17:07:50 -0700 (PDT)
Date: Sat, 19 Oct 2024 08:07:45 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>, xavier_qy@163.com, longman@redhat.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Using union-find in BPF verifier (was: Enhance union-find with
 KUnit tests and optimization improvements)
Message-ID: <ZxL4UTGzV1yd07jd@visitorckw-System-Product-Name>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwQJ_hQENEE7uj0q@slm.duckdns.org>
 <aci6pn57bqjfcshbak7ekxb7zr5zz72u3rxyu4zbp5w3mvljx2@b4rn2e4rb4rl>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aci6pn57bqjfcshbak7ekxb7zr5zz72u3rxyu4zbp5w3mvljx2@b4rn2e4rb4rl>

On Thu, Oct 17, 2024 at 03:10:50PM +0800, Shung-Hsi Yu wrote:
> Michal mentioned lib/union_find.c during a discussion. I think we may
> have a use for in BPF verifier (kernel/bpf/verifier.c) that could
> further simplify the code. Eduard (who wrote the code shown below)
> probably would have a better idea.
> 
> On Mon, Oct 07, 2024 at 06:19:10AM GMT, Tejun Heo wrote:
> > On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > > This patch series adds KUnit tests for the union-find implementation
> > > and optimizes the path compression in the uf_find() function to achieve
> > > a lower tree height and improved efficiency. Additionally, it modifies
> > > uf_union() to return a boolean value indicating whether a merge
> > > occurred, enhancing the process of calculating the number of groups in
> > > the cgroup cpuset.
> > 
> > I'm not necessarily against the patchset but this probably is becoming too
> > much polishing for something which is only used by cpuset in a pretty cold
> > path. It probably would be a good idea to concentrate on finding more use
> > cases.
> 
> In BPF verifier we do the following to identify the outermost loop in a
> BPF program.
> 
> 	static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_state *st)
> 	{
> 		struct bpf_verifier_state *topmost = st->loop_entry, *old;
> 	
> 		while (topmost && topmost->loop_entry && topmost != topmost->loop_entry)
> 			topmost = topmost->loop_entry;
> 
> 		while (st && st->loop_entry != topmost) {
> 			old = st->loop_entry;
> 			st->loop_entry = topmost;
> 			st = old;
> 		}
> 		return topmost;
> 	}
> 	
> 	static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
> 	{
> 		struct bpf_verifier_state *cur1, *hdr1;
> 	
> 		cur1 = get_loop_entry(cur) ?: cur;
> 		hdr1 = get_loop_entry(hdr) ?: hdr;
> 
> 		if (hdr1->branches && hdr1->dfs_depth <= cur1->dfs_depth) {
> 			cur->loop_entry = hdr;
> 			hdr->used_as_loop_entry = true;
> 		}
> 	}
> 
> Squinting a bit get_loop_entry() looks quite like uf_find() and
> update_loop_entry() looks quite link uf_union(). So perhaps we could get
> a straight-forward conversion here.
>
From a quick glance, it seems that there are still some differences
between update_loop_entry() and uf_union(). If we want to use
lib/union_find.c, we would need a new union function to ensure the
merge order, i.e., ensuring that a.parent = b but not b.parent = a.

Additionally, used_as_loop_entry can be replaced with
uf_find(a) == a && a->rank != 1.

However, I'm not entirely sure if this would make the code easier to
understand compared to the current implementation.

Regards,
Kuan-Wei

