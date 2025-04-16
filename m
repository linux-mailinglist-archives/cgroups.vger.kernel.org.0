Return-Path: <cgroups+bounces-7601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4DEA90AF3
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9410E3ACDF7
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9ED1AF0BC;
	Wed, 16 Apr 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuuLXOFv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D74215F43
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827025; cv=none; b=HtOmSm3rHjruxXmWUxAuQj8ZI79rYhD/EFb/zBxsgM+kz88QlsFnkYme0Gt1f4mIw3YvivLfG7VR/y60HHC8omKFRGoBnmJTmzoiyzAj6LbF02ifwaEBlSybes+6gejBGi8L5HhaxlgiiUZZdPr88cpapcLvFTjwikrmhBAeD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827025; c=relaxed/simple;
	bh=JeJRNTfzTToZiceNjd0MXWLUgNr+JgzRDYz7BNOB5Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec343/LWSr7E4lQAuJDZOz/XjCnFiyxnRRHhqVnwi8i9vZJy/hPuyKtyF8Y+0wISAGTACTbeFaGT4moh0Pf84Vgc9pA/vKMQ9GA8FCzUvHHk0Ye3h2PgeFPwoOatEqcICn499RwHJDfz/ZusIraO+VmwA4CRE52u2o5OhajT558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuuLXOFv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477296dce8dso68553091cf.3
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744827023; x=1745431823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMwRbk6qG7I8wYVc0AiKcQhWswU6G4m4BqFeblLkQ78=;
        b=WuuLXOFvNFbQCsmM89kOJINcSUmOvkRx8C6Sq9AP/aOMN3qS6w1dXueuGfw5T++nkR
         NZHVc1BvyukXwktznw35IDpsf7qVb6agUSbShA6BwtxU/9cwXD/+q1S5VqtY+2BDyAT1
         2BDcbDmpOj8cNM47hvEo65KyfluFFfNg8p4WzIYCbTH0UzMLB263XWwKH0ZpWUJ359RJ
         K5xBFsfay/7id0GweGeaKpuBgZAxxiGt7FDAad0B6rEUiWzBPHQINrL5kIQllegj/taV
         H8YnCBKDN+X20q6hSZj7RT5yy711o8koRvlagvoxiLk3Fa37MLhLYu+EsgxQEAwsWdRa
         MqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744827023; x=1745431823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMwRbk6qG7I8wYVc0AiKcQhWswU6G4m4BqFeblLkQ78=;
        b=E3yDLUn5UaLspq6s3mAXRS7Ejl26YTpjPlEpk4oqdVUm9rfYSnuVsyRXKeibgvRSWU
         GKzElEBkPGD0ntJ3ZeLEzZkJuw4AySI8FKtC4pc4VJGFOTsVqbdcnq+NcYtvHCNoBXPc
         A+qlD9OzPXpR6ZcNVltIlqXrKHm2xo3EE35oGrNOUiXC/EV8QS8k6GUQiRURa6g4R8Un
         RK4DI2iEObIxKTj5KYuKNbTP2+zcTgccq2Zi+noSDDN1BezveANV2dternmoFWTd1Va/
         y1QeWJ1aZYXEqsddXyK2JK3ZdAqXc7Kb00Fd1BPPJO6+C+6cDeMzGjRcegxqv6DY6Rug
         Jbzg==
X-Forwarded-Encrypted: i=1; AJvYcCVzB5I0LDc5K1vTujiv5UfnIHZYBKILt9N96eh2eZiWz8NQtaNam+uFx8RIStAtLFyiuTvfenSm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpkmz1eJBAXfCMoYgdXTxGo2hb1+H8UyRZtB6Fk1MatCf6ETw4
	jCCdSFs7ei28j5Uhgiqr88dQwHVFGEUV3w28wrAHymwXupNzmiBma1Xmqw==
X-Gm-Gg: ASbGnctKYnoAN0zTQLJC4KOE07SRs276FzbLYjTH2uLfJJKE9xXTLNfEXXqAzVmPXrT
	GOuRFTAT1DDKEg9A3ijqUu4/f/2UCwuo5a3/m4Lp8HZ5raaqyhjnFnm+sV5WGDXt5FltoaEJNk3
	ufQRLA8a3JPkDKhq0GdFy+l/iOGjl+fl/gxY+nFp28C4P3gRdZiLlzwkvCPXRR0jJ+6r3yhv7pi
	o3ZPosam8+tn4J71ra2N/dWMShdpkgsTPyfplXkEqje4hSsRyOCcZluvFOtT6BPtP8Sc4GxlYLr
	Ed6zL1xw5jwdiiJjDYmO1JcaZGhqf5qLGqBkDaO1g4tkeoez45gOCH4G86dkN45JpP+jAtsk
X-Google-Smtp-Source: AGHT+IEfBviXkm5Cks9CvATvW/KbAuBVk4lIGGFXwJSQGOKXN90TyWTzppAWVlD5oMfgwxhn1r2zoQ==
X-Received: by 2002:a05:622a:15d6:b0:477:cb1:ab2a with SMTP id d75a77b69052e-47ad80be77bmr46408951cf.13.1744827022814;
        Wed, 16 Apr 2025 11:10:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:b31:ddc1:afa7:7c1e? ([2620:10d:c090:500::4:d585])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2bfa7sm114202281cf.42.2025.04.16.11.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:10:22 -0700 (PDT)
Message-ID: <6409c074-501f-4fe4-826d-5d5004735f00@gmail.com>
Date: Wed, 16 Apr 2025 11:10:20 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
 <Z_6z2-qqLI7dbl8h@slm.duckdns.org>
 <gmhy3l3dlywtytmnwl3yegwf46hshshavknurjtzyruvfysp5x@4y4axheathhx>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <gmhy3l3dlywtytmnwl3yegwf46hshshavknurjtzyruvfysp5x@4y4axheathhx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 2:50 AM, Michal Koutný wrote:
> On Tue, Apr 15, 2025 at 09:30:35AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> I don't know whether this is a controversial opinion but I personally would
>> prefer to not have __acquires/__releases() notations at all.
> 
> Thanks for pointing it out.
> 
>> They add unverifiable clutter
> 
> IIUC, `make C=1` should verify them but they're admittedly in more sorry
> state than selftests.
> 
>> and don't really add anything valuable on top of lockdep.
> 
> I also find lockdep macros better at documenting (cf `__releases(lock)
> __acquires(lock)` annotations) and more functional (part of running
> other tests with lockdep).
> 
> So I'd say cleanup with review of lockdep annotations is not a bad
> (separate) idea.

Maybe we can keep these intact for now while updating the text within
to something more specific like Michal is suggesting?

Tejun, let us know if you have a strong feeling on removing them at
this point.

> 
> Michal


