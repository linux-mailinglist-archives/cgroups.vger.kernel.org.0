Return-Path: <cgroups+bounces-3454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573891C489
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001A82813A1
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2FB1CB321;
	Fri, 28 Jun 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+D4lrrQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368632263A;
	Fri, 28 Jun 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594703; cv=none; b=P0ORdJFqWCcbEdO6CtPfxzmTP6RcwhJJXKjhlNZm0TWavVWIQd4QGmlX3M5CF0Jk8WVu+qFZ7jgldSIOmjTCAqvG0jqb73LGaHQwk4eRBuw+Yz9BneSgptUdaTBu/Zf9P3s34bXjsJn/7DyGDcM7OpACgvVxrvR0qeyJRg6q7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594703; c=relaxed/simple;
	bh=X85ngQ/EMGY54M7s9ym0z5iIYohmHn4ScybjJGQVeSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyXDIcbqxqfaWEVS64vAdwkEX3fbkRfWjbm/sUtCoFNBZu4ELHfqh4KAe63AnomPEFwRxUlS46wMr37Miz40v9v3QXVGPI4r3a0RmhKzn5ucY1cMiBRj9IO6NRvNDwfp9sG4/CE1j2z3WQhZ9t8ASIJFeyNcSTQEsJiQWBTmOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+D4lrrQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7066f68e22cso698319b3a.2;
        Fri, 28 Jun 2024 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719594701; x=1720199501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0SGdwC5uTjP4Trlz+k6ArDzPjnR77dSkAo7ukvOa7g=;
        b=a+D4lrrQucaHJyYJUKyp83qDQrqnz/vS6E4rNnYBHPrqox55QjiD8JRM8NgMtOl+7l
         3rzGlxOpqe6956Dy5kfmBLDIKG2ndUOD3WlQt/7fNUKjYnTg4S7cSy98f2g/6/WPgI++
         UwOH94UdM0aRhzvUoeV8Wq1LmpLr2toovgR8E+EgALJVUcOGDvqHk5tqxXbJE+UZAhiA
         vLyEHhRpVncZczbjIGsQ0FTaBKsw/SAEWJMhEGMJv8k5+wfDoFxCgxgeYOjdb/+MwIW1
         3S+suES933PFYfXhAitaIM9VdGcQ4vusPWUQMmhBrL1K17iEd/E+dlPF9wyTmrVJ7cnp
         0yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594701; x=1720199501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0SGdwC5uTjP4Trlz+k6ArDzPjnR77dSkAo7ukvOa7g=;
        b=QUeeMwv+5DuIppxF7Tw2Mye7JcPAwJID0MwnH+VoqwSOXOWTjAvlCQbw1Muutu9EB+
         KkTROo1wKCAHLbXiqLb6+uurATO+jm/SaZO2Kmy4FJ0ARmiyRvlwuk70S67ZGhTx8q/8
         /2pzy0BbaKyOMvSaJNSxsUtHWiQBe4T9SRPw4/FP7H9O3KSuyGtvr8v8dt6fPF7wbh9H
         72DiRy2Z+i0L4q6A3giGjfjGsA6IqEJIOafdF2d5WE3VAH0g2DcZZs74emwzcGXoRVOM
         QzfkyqhXueTs4JPfTfwgctNZRdB7alvawrKH/JNpddQewCCwCt1FGJn4HuwM/1d5K7WL
         MEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhDGgoRpslwwYJD/KAzEcRXHKVmsTGpmrtC1RDh+QdxrbaHbTZ4QAFc7bEog5BbpxS6A0/J1bvSsUHp4bLwyuwZDHxLTbTMGwrPumP+85vdsEHwGj1fD51vkGT/wDN87kVeNWnnQ==
X-Gm-Message-State: AOJu0YyOYJh+hwO8gTWEBCXwoOiqxj1dq6M7ApqnwAOPGhmwNiLds75L
	ewbYSwWX/2tBGcZCDtHjAKemAi0vArErwGJsuWRqjpmP9xKcSyXY
X-Google-Smtp-Source: AGHT+IEWpm9rgTkImFSBsnGAXI4ejIR/0vVaoeddZt77pmzn2665cZur4JmljG33KGrixzxkJvjwTw==
X-Received: by 2002:a05:6a20:b709:b0:1bd:fef5:ab0b with SMTP id adf61e73a8af0-1bdfef5ade4mr8505677637.8.1719594701296;
        Fri, 28 Jun 2024 10:11:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569f0bsm17702775ad.216.2024.06.28.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:11:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 07:11:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Message-ID: <Zn7uyzx-GdpUzaJ7@slm.duckdns.org>
References: <20240628013604.573498-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628013604.573498-1-chenridong@huawei.com>

Hello,

Replaced the v3 patch in cgroup/for-6.10-fixes with this version.

Thanks.

-- 
tejun

