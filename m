Return-Path: <cgroups+bounces-13092-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F29D14BA2
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 293773016AEB
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320D37F8A0;
	Mon, 12 Jan 2026 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcXi7YaI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F123803ED
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242053; cv=none; b=rUjUMxV10D6zgJLITAjY90g+i7KxrkADMJCjUxey0LPpmsurGXbd3umPrTcFfkhVnJSBPiXD/GPwgwO3+/o0bikdmD8KaSse+g0c5pr2LMxL1FqQ524gEJdP8LjETWujqNPWbAGOQaDSxygNogkIuFTuUVZRZcJn5900i672gsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242053; c=relaxed/simple;
	bh=2kDMNGlutLZbBlBwbeCuPsKPzeKjPwdmAr2kRZI8ISk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+aQlDT9NNzBR7Cp8d0g8UT1/YIr2j//KmHqvgkvzvR20aiIihr2wD4MrsnXgXwgQQ8v5Yjg6+HVCIzP7cwRPzVGX/HQy9FG5y4zXI+mStKc95ZbeO5AtqH55vEFsQUiKsTbz/BoBW43sc6TmHCSidJgKqdGboJxzZQoi4ouT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcXi7YaI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b87003e998bso302610666b.1
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768242051; x=1768846851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XHGqVtaW8x0Sh1FjZrgxZJsIoNRNYfvhtGoAiQ9Qrc=;
        b=qcXi7YaI8TqqlD3628ylsT3CVvAt+SCOSI0MjNzZgDhM4FgG2c2V962xOgHX0nOYPG
         MAq45iYgE8EevBCBaA0uDHRnllUNcSooNFm8IJfp0TG84klkUR4hP034nxmQmgYXxf9R
         hcu6dkr5j15qfp/OCeOdKRJ2ATu6vG3QhveRkna5Lj2SHLvNVVKJ7l3xjD1znJE94Paf
         oZtOL4diWOJmN0dSHF/kclchYYjPfhs80Z181R9T+m5yKNqafS4raNv/RlDCKxoiNX4C
         PsQj1Ei/Uo3MDVUCjvjmIa23b2EbkWZbozT9Pp3t2oVYR8R4dtCQEYmVAavP/QhipYZ3
         vr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242051; x=1768846851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XHGqVtaW8x0Sh1FjZrgxZJsIoNRNYfvhtGoAiQ9Qrc=;
        b=PEmeLs3q5gBgbrq2uYJwlGu30Rgl3VyfMwxg4vSP6qiyIcid3z8ixMH/t5T/22NgNE
         AFWp2Ut6ma+a3XknNmjKI3rfAl1LZznRuOjfMfIyCGfeZMNhi35/0bwcQZ4dxajuk/6n
         wZQyvOQ2L1geVXgnHvKS+7A8NF/Ae5gXhbEQA/C16Z3uoskxEYuAAdAWK0bFlyce7dZW
         X0Qw47lCOAIwnwL6v59ifLuRpfxmBhmK2SV3KVN9AYaphg515fit/1Nr3f4Rxdc0FlCG
         M58CofIfcQFhNVivnUQjVz5YMVv+1GPh7C7Yj5vn2o9LTHyFZfh4rC9wZSBp0QoT0TvI
         UQCA==
X-Forwarded-Encrypted: i=1; AJvYcCVmzGqPcYCvyeZ8HclVKMOU86O6TZ11Ohn2DE4h2T5YjedHWSORW8wyOv9cQ1YpytiBoWtft0pV@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpZmtng8xKb20DrNgxN1jMqrCAoqWVudvjLYRGKzqLIjGSt3X
	CJVLFlx9vxzeAvhVuO4OR+hqtO8w0IdIpLIyiHmSM7FXBH7oGS8nVjsTbaAUp9RCGQ==
X-Gm-Gg: AY/fxX5rU30ZxVTRXblsVSvkSUpqMmGH+NVAqYXUY//RP+syFAOaXcKvZR39w9JLmrs
	ooNg1a7ki6SiF29gZzbx009rZi/eTecfwBCb5vTm4OABNQ67lw7RE0WY+rBOFtRH8GIgFLWvAST
	oh7t/ES9GblF5IGiNdf5pnf+11kVieok03LYcQK74ahfq8shKM0ZrmaOGANOgDR/hvO4hI+oGj8
	ibM1a6uc5G0rjD5u1Jd6YOfD9tfzz4N4aZQkoc9v5HHokVYLXsV8kwNKLyF18PoUwyV8+zrxIzk
	Whu0HdesPGyWRWTw8VoP9A1W1wN6A4AK7VLX3pTcqM313y0FgNrHxfI8swYBFJ8WMbJPBa7QjVH
	Kd8Ri1JHgBH1mGtzhBoxv0MQ0dxuJZff9J5SFMHQ6QJ8S57EII+oQpb7xMAw5WJXevTO5Bqv0JP
	NE4KZAC3PmTYK1swifeI5+8uveGsN+1nkqdxBwPuF/oNoAX4PIbe6OlX1pKSAYMSyw
X-Received: by 2002:a17:906:d553:b0:b87:29ae:2b96 with SMTP id a640c23a62f3a-b87357dbad6mr34509066b.12.1768242050430;
        Mon, 12 Jan 2026 10:20:50 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm752858966b.62.2026.01.12.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:20:50 -0800 (PST)
Date: Mon, 12 Jan 2026 18:20:46 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aWU7fnkQ5TLbAUmk@google.com>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aWULOvXrN0acG97Y@google.com>
 <87ecnusq7m.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecnusq7m.fsf@linux.dev>

On Mon, Jan 12, 2026 at 09:20:13AM -0800, Roman Gushchin wrote:
> Matt Bobrowski <mattbobrowski@google.com> writes:
> 
> > On Mon, Oct 27, 2025 at 04:17:09PM -0700, Roman Gushchin wrote:
> >> Introduce a bpf struct ops for implementing custom OOM handling
> >> policies.
> >>
> >> ...
> >>
> >> +#ifdef CONFIG_MEMCG
> >> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
> >> +	for (memcg = oc->memcg; memcg; memcg = parent_mem_cgroup(memcg)) {
> >> +		bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
> >> +		if (!bpf_oom_ops)
> >> +			continue;
> >> +
> >> +		/* Call BPF OOM handler */
> >> +		ret = bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> >> +		if (ret && oc->bpf_memory_freed)
> >> +			goto exit;
> >
> > I have a question about the semantics of oc->bpf_memory_freed.
> >
> > Currently, it seems this flag is used to indicate that a BPF OOM
> > program has made forward progress by freeing some memory (i.e.,
> > bpf_oom_kill_process()), but if it's not set, it falls back to the
> > default in-kernel OOM killer.
> >
> > However, what if forward progress in some contexts means not freeing
> > memory? For example, in some bespoke container environments, the
> > policy might be to catch the OOM event and handle it gracefully by
> > raising the memory.limit_in_bytes on the affected memcg. In this kind
> > of resizing scenario, no memory would be freed, but the OOM event
> > would effectively be resolved.
> 
> I'd say we need to introduce a special kfunc which increases the limit
> and sets bpf_memory_freed. I think it's important to maintain safety
> guarantee, so that a faulty bpf program is not leading to the system
> being deadlocked on memory.

Yeah, I was thinking something along the same lines. We can always add
this kind of new BPF kfunc in at a later point, so need to directly
address this use case right now.

