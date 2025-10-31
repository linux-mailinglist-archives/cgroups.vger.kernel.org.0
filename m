Return-Path: <cgroups+bounces-11455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C5C240A9
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25861583158
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3032ED26;
	Fri, 31 Oct 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qa0LOxbF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89032E6B9
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901563; cv=none; b=DtrctIScBgTS4AoEWW7xZu373CGjrHunTrLoc3bffyeiFZGx1sfKosNZoW+dlq5kxwLTB3wbDKoQDErgMjsKzuwfXwXvOdXz00V1qnf/R40dREhW2zgcPZ4uYfbNP84sJBNPQWydFjPeqpSGu2k8TnDuABgeTnzxgXuF1aFAUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901563; c=relaxed/simple;
	bh=ku+s48JLQC3eWSP8xQJFPNECjEvh3Mo/HcgF5mJuAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3VsvNUBlU4vX6MVN9E36W1mlapt3iNcI9bhGu7IU4nMNTc85+HsayOnbBcsrQhjDSRCcxphVCRJ/b8swUz4YA3+m3t6FVUTWJb5IVtJ7VDEfAe0rcowsl945+/8bc1KsN1yCKPhC9OMpKbctNjwoNn4B5UNIrK21LscPXu3GEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qa0LOxbF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471191ac79dso22151385e9.3
        for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761901560; x=1762506360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Je1BoSkiy3cQsPMrVyvcSTGyt460ikMCavqziE4oJW8=;
        b=Qa0LOxbFPBTIZ5cwkjkceemeoaDAvEF27VjguwYlURhZ2PL3DLN3BKqVlQepHUHutb
         cZ3jjSitHVmjW/ptrGxl0LMFy1BzL/MK1QV/GobRfyDX+rsx9g2vNyk7A6nIxtWK7DQM
         XI8U8HPDA/yw+bk86n4qo4IPX4RVPStvIT0L9aq9462QVqJAVLQYK1ek3/Vlue1pp7HG
         NrhsqA6uj+dLRbXdoAHFKyqL+yrK889PHMATq3eWmr/6eFRIJuv2njqQXiku02hVjy5Z
         6s8QFWQ+qAb91+kZsXHuY99XKNnDNoIL+yYIpRwKJzY035098x/kZVKCEQi7d2TSGlvd
         6Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901560; x=1762506360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je1BoSkiy3cQsPMrVyvcSTGyt460ikMCavqziE4oJW8=;
        b=p4XgV/hRNHcKugKkdMN+5DC+na22K0veu6VuKbi8SrIhSgzNo2ATScE8poVgXn1CYZ
         yuaZUAGQei1Zcr6A7erqoNENVwI81Xms71+i0Bafg6h9IJATD0fQQu8yIUzU3jNLqyc0
         H8+/l99GzHRQ2AsB45d225wdcNVTKbOuvycfVoHfLhd9POSSlyrz0PX8h7nBg2DaVGJ3
         l2RBv2Xu6VUXyVE4avaaZXgJmxKoZA8LgyxxUVOQKL2xVFVvR4Fs7mR4rb263kpJy8/u
         Kpt4khhoP+yLSq7Hdmnny5WWkylGT95dOINe6vIj+Q0FSskctKXJNvIWUieOcGPHCk1j
         07nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhwdUMmIMvr8iNz6OyvQnO3GQK7Nty4BDSOBLLhvJb+7fWoZ7iiz0NoA/FtLCW89SIE3y8sV9@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHQ05TGAT0w0DedsMv1cVXyxy1Fj2pHNlpce9O97bpjmjeWGJ
	wbzOtEFAc3bkCbBN5HBtQT4epAfBhFDSRKV6++MGOOCTE+YQPX6kN5jns2zWLNBfmBY=
X-Gm-Gg: ASbGncsDUUgOGf89+QTDN2CZdT00/hr/hhUyVjZcDO+ds6vdNIhCr7csHdGMnETB3Aq
	9Z2urcT7RLh2mXCN1u0lWBIc4xVKAl4Lyt5Hjr9SPK8HahyUEqmz9wdSntyG7SAjfd2QzE6v57/
	7hBH4uR2Nnakc4S9sHN4jFiIcdm7c9qlfScWFgdtnk1MMcc/YaXiAmPNtnnnt7TYEqCVLRZiCml
	utoqnj4Qspo/8snXP/FMvzXXfMfEgD/e1pGjyN6YiIbpmo3Rud2RrKe2+MJmCADv4c1BXLjAy8Q
	eQjrFc6v5YgX6mnYIKHx/RjITH64yAh2S0FGXmXvVpL151/7ZAanBbL7vs6/bJCaxWobfC46kvG
	i2ezhCGKYkbe47ZK03gKwoH2VafLC8bUkMVASVs+vHRPhJNyrkNA5vFyXM0Pd8vlh42rIVCD+z4
	zf/RslI/kX/geJ+fJR+x/xFdxQ
X-Google-Smtp-Source: AGHT+IFDhjw/NQy6gXd0KrwaHxidybeaclTmSKM+ZycX2IB9hql/be8JKkXi3tpvF4ocbMgb128LQQ==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-477308ce7b2mr26457735e9.31.1761901560280;
        Fri, 31 Oct 2025 02:06:00 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fe5719csm17619365e9.3.2025.10.31.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:05:59 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:05:58 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 07/23] mm: introduce bpf_oom_kill_process() bpf kfunc
Message-ID: <aQR79srdPzyUT9_I@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-8-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:10, Roman Gushchin wrote:
> Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
> to be used by BPF OOM programs. It allows to kill a process
> in exactly the same way the OOM killer does: using the OOM reaper,
> bumping corresponding memcg and global statistics, respecting
> memory.oom.group etc.
> 
> On success, it sets om_control's bpf_memory_freed field to true,
> enabling the bpf program to bypass the kernel OOM killer.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

LGTM
Just a minor question

> +	/* paired with put_task_struct() in oom_kill_process() */
> +	task = tryget_task_struct(task);

Any reason this is not a plain get_task_struct?
-- 
Michal Hocko
SUSE Labs

