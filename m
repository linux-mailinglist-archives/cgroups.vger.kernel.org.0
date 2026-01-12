Return-Path: <cgroups+bounces-13109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4120D15D6A
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 00:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425DE301D5E2
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316472BE05F;
	Mon, 12 Jan 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pjMhlaYP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1D29D29D
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261259; cv=none; b=FZQoqcOHfxlaPTEqts16yyNPHCCJ1Z1ZSrDjyx+WpTQ/Osc5xFq6YSSJhtr8MWoRA7+uoYNk45b9OnUU3i8nAJZUot/HrKQ3IVbucMD4dVFHZHF9uy1fDTkELwhGUSTAsENHK3nAyy4Z27O5gLKZmrVYmzi74+y4a/UDuATu3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261259; c=relaxed/simple;
	bh=AUWLVB42LRP3Zrefwivb6vdVAhUxvr7KXl/fEwzONGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvwV5on7OLeVlD0JDMa6LjydA8QCSpNQoDilmH7/q3/fzFJVFKCTXSwos2cZpzZV7aRyIJZujNPL3dDUZRjd4Vt7afzZXVrdJiRdGPLgJEp4rylnbUqulq3FsbCfJ0D32sjFJvBtSUaSNsuNYSuwkXXWbIU1Hu4biqd6ilNBq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pjMhlaYP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8908f5ed4aeso55795316d6.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 15:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768261256; x=1768866056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMPIlr+0naNU5kMo2DwX+nChgxcRBVo8GV+FHyiHDrM=;
        b=pjMhlaYPyxVVaBwbmKoshuhidOVjixLdPdFvDYawO1J7Xs2m13FfOZ1I17yIuFhUJy
         WUT2j2HgcuQu0Oj7ylWEeDQ1lino9psab+M9wXypwGuesRYHHzFs0FtBYd88OgMwNVgS
         t5GeYt5lr3CiPDJLTt9219egn8uw1UmceGEQvJnehROkpt1zkMm1W09BdtKyU6pbyTKY
         iuLPomhI7uNwIAalTLEw4mqS7ViG7fimbNsP12w2DNXdziX6KrNagP7luJnubuhUM8Vh
         qRSo0n9CKY8PigVwWmMYOwY9VY/3Qygua1hb+/2OiTyxG1+kDDIHVLOJ5HN48drlEhRq
         jnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261256; x=1768866056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMPIlr+0naNU5kMo2DwX+nChgxcRBVo8GV+FHyiHDrM=;
        b=k2Vk/xaHAQgd5JKy7yAr1hUZTSnzy0aRNpMDqbYY3XdXl7Wv1vdX7RtBxUh1pvuMSb
         ntS/8CD3ofmWDLxoIOdMzolouqdhSqAHUgN7sgZweMXKsJYmVQsCvCl+BnGc4Zjjnd/l
         vZAFNkDqAWkjn4lKOVFAB8ZgIx7wgYURgojFASkPjUUFa+K4kKF3B2ajn7W2pugKHt4L
         Z6fF6p9Y4brbnE2wuOzptFTsXpE5oPfvw4tZ7emeIJW96wVIF8CSktGP7FIKSRRwZgCQ
         YAcGFsilCvHrt2PMPJWQSqikMhmOKfUhxQLMijCT0ua3jxOwiecVSm+C7yqdKlzzm78V
         C7+A==
X-Forwarded-Encrypted: i=1; AJvYcCXNuXR8hnvNLFsVh8VsUeh7MTST+65W5lEt3CcMn2KP88EFfW/a6SqUbNC56d0nX7B3YsZVSoX0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpk9+lvM0byx+mRa+2kadvSt30XbvqtfH1v2u4MQQlcoIAQqU3
	YFS4LZyLJW0jrO3OmODVJgW/M6z/mp357PVuGPOkeRajBlyWdw/m34Su5LAPvHshj44=
X-Gm-Gg: AY/fxX6Du20Fuz1BfSK8bxXlalyRJXpSY+iUGiPmiVNaVmw3o9VlTATDz+ELz3yFn7d
	dtcU+/bRUkMODsaIcJVnN/aCPA2OU2fILJ59tcmugj9Tg+SzHWJn6pHv8R7PvkNcFLjfPDHx3vU
	+W6Qdmm8SlXkcoK6PCqV/hnPeOeDRbUjA5JiUUNqyhhP/orCoMtD1WBu/oXXwfZWz1izPzn/o8u
	gESFkv06DSLj8U2itmCxiBKM4krI0/EP1jN8K6DOob4hfr3GEl5zkrOuzqPTQmAJ2AD7m2AYAlC
	G3oHXadou3Lu3iz8MewNaoXIaP3ZOzHYz94noN/yo+5MeQGlgf0rAdYMMHTXIbk/KQNTRSF4JOO
	4ciMwd23S0rzgV5kyxIG/+kxADvcTGmUfZdCIPyJ2MgLJwLa3cCOYqSsGBXQFMfXENmNRfU4LuX
	z/vNUT778nFLcd7D6HCH7BAtBUQqG2dwvsXdEUYrxk+cl+VloGbvZ7pjhqqn2amQnu08g9QQ==
X-Google-Smtp-Source: AGHT+IFzyx3JnI+bFcbUp+3l5iKXvAuxuT7zO7857F9qVshwDcYCVr5Df5mi4k65Skb1cKr5CB/URA==
X-Received: by 2002:a05:6214:5901:b0:880:4690:3bb8 with SMTP id 6a1803df08f44-8908420e7dcmr284078116d6.18.1768261256343;
        Mon, 12 Jan 2026 15:40:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e8cfasm146393266d6.21.2026.01.12.15.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:40:54 -0800 (PST)
Date: Mon, 12 Jan 2026 18:40:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: dan.j.williams@intel.com, Yury Norov <ynorov@nvidia.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Message-ID: <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
 <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>

On Tue, Jan 13, 2026 at 09:54:32AM +1100, Balbir Singh wrote:
> On 1/13/26 08:10, dan.j.williams@intel.com wrote:
> > Balbir Singh wrote:
> > [..]
> >>> I agree with Gregory the name does not matter as much as the
> >>> documentation explaining what the name means. I am ok if others do not
> >>> sign onto the rationale for why not include _MEMORY, but lets capture
> >>> something that tries to clarify that this is a unique node state that
> >>> can have "all of the above" memory types relative to the existing
> >>> _MEMORY states.
> >>>
> >>
> >> To me, N_ is a common prefix, we do have N_HIGH_MEMORY, N_NORMAL_MEMORY.
> >> N_PRIVATE does not tell me if it's CPU or memory related.
> > 
> > True that confusion about whether N_PRIVATE can apply to CPUs is there.
> > How about split the difference and call this:
> > 
> >     N_MEM_PRIVATE
> > 
> > To make it both distinct from _MEMORY and _HIGH_MEMORY which describe
> > ZONE limitations and distinct from N_CPU.
> 
> I'd be open to that name, how about N_MEMORY_PRIVATE? So then N_MEMORY
> becomes (N_MEMORY_PUBLIC by default)
>

N_MEMORY_PUBLIC is forcing everyone else to change for the sake a new
feature, better to keep it N_MEM[ORY]_PRIVATE if anything

~Gregory

