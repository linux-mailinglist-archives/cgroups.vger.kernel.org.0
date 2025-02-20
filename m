Return-Path: <cgroups+bounces-6630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B3A3E38B
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 19:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CC168B28
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BAF214212;
	Thu, 20 Feb 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI4Sz+74"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C621F892D
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075290; cv=none; b=KmHe2MeMiFIeN50JgEq15A0CYZmeVjWoUWfUa9R/RDZ7XJj3tQqSuDhUswy+9Ebzr2GbagIqcQzTU+4LzwmoLWY3j9pWvtU8Ok6cWIfPjsykW/t9A/DyW+XStWOov3QoEIQdXb8FtUPgh2IoJgRGwfH0+es6ZiJ3dbiFz8Gm7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075290; c=relaxed/simple;
	bh=sG3BP9aINN4HQE0oTDFqq0jzfj23HIGGirzRUZ7gwvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGuQtYub/cr7Lq8SqCpm7QK8HRWsbv5SYXABzhS3NuYPBEjLxf2b4hReAz9Zgpm8PTdZppGKQuruKuFJs67E0QJfpBK6ejlA/Tx1keahil1+mmX0ePpsc7PtdlzRgYewayszDR4ozieba0YnYswr15kaos5ua+GbADRlO4PwEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI4Sz+74; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c665ef4cso20849255ad.3
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 10:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740075288; x=1740680088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oObvhUMt4cjhg8s99kHncplBjGhp4cxwDQbmBZl3oBw=;
        b=LI4Sz+74FRRX1+SJGgLuOqT1TKi7HK84rRd+EsOUkP2NLZ87WBVeGNJnxdO5Wy4hEk
         C69sSiGBLD9sA6vzIAYM4wnXu2ZzHOCL4B/0iqxfOM5TmotxGsf42/mTO3GK9WKMsQZ9
         XzJQp5Zci6Mj6ecxRijkv//mb4cpGf2ErJvt8ZswsIzhXUUhXYo8gqRksOlRAWSs1Osw
         Z+pzyuX2GJBTxvFUCNAOGfOMuaKceITf1YSYmIUUBjDBV5jk3qHPK5y/43+IgVBU9VHx
         96SPsb9Fye4YeEQCzIALByMB6LWcNXDiEhOd5DSIpbbkz3qVEhWugSZxnkIOhIxEAdvJ
         o1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075288; x=1740680088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oObvhUMt4cjhg8s99kHncplBjGhp4cxwDQbmBZl3oBw=;
        b=P9ZcsUz09EOG5akQ2Da4z2Nl7bcd4uj3FTmEitXxHscgUTKsoBRYJDrxeEOBEHdITh
         A7Q749P4NAX7IeIo0qKcXF6Z+qkElNvZwYCcXz8GK+VLheWxltZVh5fuTboZOOd1EnP4
         t0x6Slt5ORg3XjHqJyKymtRx8FjZZhOVslqU5ZrC2g1gNYJJnFZdRJtTyzlE1DXKTV5s
         P+RaNrt0k/Of3X0XpW8T87Rf9ONd3ELWincY9Mu++WzmNzC6COF7ZYYQkt+iHQN3WyjE
         GRZ69irQHlhcDnozzlnbNTzsPGp4uJbBjnGp57u/Pbjuo06SdWK1auMuTGY+nLFQpIC1
         b7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVwG+C3gsi/A0Hxh/SCt/5JQq25Y3GAyP7yB6vBXmQlu0ieQSy40SJoUWUJPFwVkE7gpfJ2JUm@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZ2APjyAeO79bHbHe09747JLXgIxyzM8mvSpIOGNwll/TsulZ
	T7Z2mw5WbeVVIb7kYeZAxVZbLggkEcGK9X3XqJE+3ZwZNGr+7wEKnlJNKw==
X-Gm-Gg: ASbGncs/Z0WZGCFp6t2p3Na6BJ40eQ7KrAuA9oY6Guwrj2Spoi7KiPYqn2XhPczmT/y
	jkXrWEx2B3wBaGHC6Qu4PqcvuykRvbmFThrfWNtid2fcbTaeZLhV9MNAdcY2U7PAvDTd6Xep8u7
	L3B13ho/EVrK5s8PyPmR2Ge+qMmuALEnMQBvgXgPzTbdfWKG4CxuKjE67mqVGEMz+I4u1AUaa0o
	gTqppTUCAugnIjMrcaDV3guE89elNQdIR3MlRi6/Z90F+aam7q70QXPEEQpFP/dQHwYLIUm8TWA
	TiV1hbD8rbtYGgFyjgi1MVdY9pIZHUdcI8iNL2pJakcs2ISi
X-Google-Smtp-Source: AGHT+IFBSASVMdXYA+Pmss8qMHeZIJWACcBNMLBfrQ8MGynyGryeSXT+bNOgbCZ9MwyLBI8E67CvBg==
X-Received: by 2002:a17:902:e889:b0:221:7b4a:476c with SMTP id d9443c01a7336-2219ff9ee80mr1369405ad.18.1740075287787;
        Thu, 20 Feb 2025 10:14:47 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:23bb:b0c4:3d98:81d7? ([2620:10d:c090:500::4:3465])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536738csm124699655ad.68.2025.02.20.10.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:14:47 -0800 (PST)
Message-ID: <158ea157-3411-45e6-bca4-fb70d67fb1c5@gmail.com>
Date: Thu, 20 Feb 2025 10:14:45 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kernel-team@meta.com
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
 <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
 <Z7dtce-0RCfeTPtG@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z7dtce-0RCfeTPtG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 9:59 AM, Yosry Ahmed wrote:
> On Thu, Feb 20, 2025 at 09:53:33AM -0800, Shakeel Butt wrote:
>> On Thu, Feb 20, 2025 at 05:26:04PM +0000, Yosry Ahmed wrote:
>>>
>>> Another question is, does it make sense to keep BPF flushing in the
>>> "self" css with base stats flushing for now? IIUC BPF flushing is not
>>> very popular now anyway, and doing so will remove the need to support
>>> flushing and updating things that are not css's. Just food for thought.
>>>
>>
>> Oh if this simplifies the code, I would say go for it.
> 
> I think we wouldn't need cgroup_rstat_ops and some of the refactoring
> may not be needed. It will also reduce the memory overhead, and keep it
> constant regardless of using BPF which is nice.

Yes, this is true. cgroup_rstat_ops was only added to allow cgroup_bpf
to make use of rstat. If the bpf flushing remains tied to
cgroup_subsys_state::self, then the ops interface and supporting code
can be removed. Probably stating the obvious but the trade-off would be
that if bpf cgroups are in use, they would account for some extra
overhead while flushing the base stats. Is Google making use of bpf-
based cgroups?

